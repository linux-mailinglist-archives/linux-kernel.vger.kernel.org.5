Return-Path: <linux-kernel+bounces-141599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E5F8A2086
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D686C1C21F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C942942A;
	Thu, 11 Apr 2024 20:56:41 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C892615E8C;
	Thu, 11 Apr 2024 20:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712869001; cv=none; b=fa75gW8ocPr0LVUJtfSO/JTB1mBsLECpCsmmxyeezErJN/6o9Mwg+Tb5D8aXaqes6QopQb6m2qIlMm448DPJeELw26rE6HYBflVLfm4+ogu9blimJ3Mnhg/nyM/+Lmxpijw2FjcNukNUjX7Zd6S0Vg5HgXXVtbmNf+Jd4ujH17o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712869001; c=relaxed/simple;
	bh=4BT8U1oZexspBctfz3dQlPM2UzZbOyaBzY8R86jX8Ks=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rUvFA/4NvAy/7dIrvUBK/2ut4f3QliS+rBkstfwaSksoIDcbEFxoj2kv2mgHcOHxt1mqOKkoujay78MJLvazUgXZ8xOs46Nni6TJFk5JdrzEro1YpoFN8U3jbeHHtDxBb+iyU7eZa09t86bUIxdc54c5Ri8i+DTvji0JgV1KMOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 28CEC40D0E;
	Thu, 11 Apr 2024 20:56:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id 21DE62002A;
	Thu, 11 Apr 2024 20:56:29 +0000 (UTC)
Message-ID: <1a4554d39229c790c98bebb213bc9f2423cd32de.camel@perches.com>
Subject: Re: [PATCH v4] checkpatch: add check for snprintf to scnprintf
From: Joe Perches <joe@perches.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Justin Stitt
 <justinstitt@google.com>, Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray
 <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>, 
 linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>, Finn
 Thain <fthain@linux-m68k.org>
Date: Thu, 11 Apr 2024 13:56:27 -0700
In-Reply-To: <48d593c1-c706-4af3-aacf-d1329a8b0d4b@wanadoo.fr>
References: <20240408-snprintf-checkpatch-v4-1-8697c96ac94b@google.com>
	 <48d593c1-c706-4af3-aacf-d1329a8b0d4b@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: rx4sspfkygb7qi1g3x6n1z1wisttt8zn
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 21DE62002A
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1825JZAII+H5iFHVvm8VKIoRHYFoNimUP4=
X-HE-Tag: 1712868989-801773
X-HE-Meta: U2FsdGVkX1+XfDs6nV8rYVUsyMz+i+9Jl3FVBcsNyS4KtY2HbKa3OthSlP71edsaGj2CZq31SHFGeLS7ywU8Yvs3Yh9DdpDzdieZdQA7OC8SRzPOtxQFkutAiSKM4tiCaGWkB6sWh2osxXPlG1gc7+crqf0bDhyus5rfZat9sW74LUXr+/5/4ucYushMHZe4auxv5SSSql+oFWSidxTn+Xe8HIaYFH1qQ4YSwUTzUrPrSYVzgCr69yd6MugPx/ING4HlbL8q+Nu30Uph61h0zqNu3bo3ikZi07UnCx2pHmXhsQg8obdSYkp0d51ou26028oeF8mVWzqlS8hSJqI6Lv+JeMUqf1/viIukVpMtxEHztZ/bUnhlz5NhLAzU9ss1LGAOw16rWpoHLKfzAnDnjg/eZrttrSjYWmArT+8tJMilbT2WJc4yI2eng4pfHa0krpE1TLKL/vADL1a3P0XLY4iWFUhtIW/nc+ar2sG+w5s=

On Thu, 2024-04-11 at 22:01 +0200, Christophe JAILLET wrote:
> Le 08/04/2024 =E0 22:53, Justin Stitt a =E9crit=A0:
> > I am going to quote Lee Jones who has been doing some snprintf ->
> > scnprintf refactorings:
> >=20
> > "There is a general misunderstanding amongst engineers that
> > {v}snprintf() returns the length of the data *actually* encoded into th=
e
> > destination array.  However, as per the C99 standard {v}snprintf()
> > really returns the length of the data that *would have been* written if
> > there were enough space for it.  This misunderstanding has led to
> > buffer-overruns in the past.  It's generally considered safer to use th=
e
> > {v}scnprintf() variants in their place (or even sprintf() in simple
> > cases).  So let's do that."
> >=20
> > To help prevent new instances of snprintf() from popping up, let's add =
a
> > check to checkpatch.pl.
> >=20
> > Suggested-by: Finn Thain <fthain@linux-m68k.org>
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Changes in v4:
> > - also check for vsnprintf variant (thanks Bill)
> > - Link to v3: https://lore.kernel.org/r/20240315-snprintf-checkpatch-v3=
-1-a451e7664306@google.com
> >=20
> > Changes in v3:
> > - fix indentation
> > - add reference link (https://github.com/KSPP/linux/issues/105) (thanks=
 Joe)
> > - Link to v2: https://lore.kernel.org/r/20240221-snprintf-checkpatch-v2=
-1-9baeb59dae30@google.com
> >=20
> > Changes in v2:
> > - Had a vim moment and deleted a character before sending the patch.
> > - Replaced the character :)
> > - Link to v1: https://lore.kernel.org/r/20240221-snprintf-checkpatch-v1=
-1-3ac5025b5961@google.com
> > ---
> >  From a discussion here [1].
> >=20
> > [1]: https://lore.kernel.org/all/0f9c95f9-2c14-eee6-7faf-635880edcea4@l=
inux-m68k.org/
> > ---
> >   scripts/checkpatch.pl | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >=20
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 9c4c4a61bc83..a0fd681ea837 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -7012,6 +7012,12 @@ sub process {
> >   			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - s=
ee: https://github.com/KSPP/linux/issues/90\n" . $herecurr);
> >   		}
> >  =20
> > +# {v}snprintf uses that should likely be {v}scnprintf
> > +		if ($line =3D~ /\b(v|)snprintf\s*\(\s*/) {
>=20
> Hi,
>=20
> for my understanding, what is the purpose of the 2nd "\s*"?
> IMHO, it could be just removed.

It could.

# {v}snprintf uses that should likely be {v}scnprintf
		if ($line =3D~ /\b((v?)snprintf)\s*\(/) {
			WARN("SNPRINTF",
			     "Prefer ${2}scnprintf over $1 - see: https://github.com/KSPP/linux/=
issues/105\n" . $herecurr);
		}



Though I also think it's better to use lore rather than github


