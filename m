Return-Path: <linux-kernel+bounces-83139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC54868F5E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AC05B2547F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D5A13A24D;
	Tue, 27 Feb 2024 11:42:27 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB62B13958A;
	Tue, 27 Feb 2024 11:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709034147; cv=none; b=ijrPYLQRYg6ApthaiMkC1N7aJaeqS1ZrBNAQtaZWqZ1aA3ATPGWY7kqS8D2QtjKLzwgTcFVlfvgCm7LCHXZ90QnqhVP9mdYnDFVSW1opaWhZ0w2576g9BvbJCzzCwga7mu67Hj2Ntw2/yq3eIYSZ2gRFNBoTYeyMXKzFpSh0fs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709034147; c=relaxed/simple;
	bh=ycpsLMGqKQfrLYCH+x1HWi2wiMddtCqg7V3YbCTEAC4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=od+s689A1CrA/WaBI+7a02F4s8+fIs0CrhC8G4jhY1KN5AtxF4Pph6S+6IMVgQTlltwq8PlPs30Ijs+rZ1rFxXCYfv7EKMtCbFLfpgwS5SaK/r9U/J9A24MtkP8FOQkIrCE8rVUqV/XqXhNWH6SYLw/Qd6/xIGtwXB3FgPxABPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id E681EA0EEC;
	Tue, 27 Feb 2024 11:42:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id 4AD102002A;
	Tue, 27 Feb 2024 11:42:14 +0000 (UTC)
Message-ID: <b0a352781f58a829deadffbe2ef2085c97c6ab32.camel@perches.com>
Subject: Re: [PATCH] wifi: brcm80211: handle pmk_op allocation failure
From: Joe Perches <joe@perches.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, Duoming Zhou
	 <duoming@zju.edu.cn>, linux-kernel@vger.kernel.org
Cc: brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev, 
 linux-wireless@vger.kernel.org, justinstitt@google.com, john@keeping.me.uk,
  quic_alokad@quicinc.com, marcan@marcan.st, johannes.berg@intel.com, 
 linus.walleij@linaro.org, kvalo@kernel.org
Date: Tue, 27 Feb 2024 03:42:13 -0800
In-Reply-To: <87166784-79ab-4eb4-ad1e-af4bc31757b7@broadcom.com>
References: <20240227080613.34001-1-duoming@zju.edu.cn>
	 <87166784-79ab-4eb4-ad1e-af4bc31757b7@broadcom.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4AD102002A
X-Stat-Signature: edoqsgf7ic6us6cah63pub7niog877mg
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/WU0+q9CP9YB3iZf4lKGg5gQDCP5sOEeA=
X-HE-Tag: 1709034134-96182
X-HE-Meta: U2FsdGVkX19TCIOBunB/trdZTRgi6R4E3PcqVCwEybxKePZ9o1W7it2/qFbLqYIs53EHyYYfFl8x0B7R0mINy3zRdpVuP62lhcb9V7LUa22u8kjylexBvXmWH/ecs+KGvdffoGc3N21S68SK05i+3sCg4yJKblnZZTtR9y3ZFxqx/XrR2Fx8zpCVrwxACFBpbGXXmULsj5PWzCO+8qQ4Sf5JJkE5OuwhWad6Y21UZJOdYOUuHe1DnpGQYM0ZOzykoLlS5HlC4zSAApnXrYm04btVQnyvH/v0N3YQ+i4aW6ciBJ22DDCTQgzDCFICBj+o

On Tue, 2024-02-27 at 12:21 +0100, Arend van Spriel wrote:
> On 2/27/2024 9:06 AM, Duoming Zhou wrote:
> > The kzalloc() in brcmf_pmksa_v3_op() will return null if the
> > physical memory has run out. As a result, if we dereference
> > the null value, the null pointer dereference bug will happen.
> >=20
> > Return -ENOMEM from brcmf_pmksa_v3_op() if kzalloc() fails
> > for pmk_op.
>=20
> NAK (see below)
>=20
> Also this issue was reported earlier by Joe Perches. Not sure if he=20
> wants to be mentioned as such.

I think it's unimportant to be mentioned.

I think it's more important that the code be researched
that the simple return of -ENOMEM the appropriate fix
and is handled by all possible callers of the function.

>=20
> > Fixes: a96202acaea4 ("wifi: brcmfmac: cfg80211: Add support for PMKID_V=
3 operations")
> > Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> > ---
> >   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >=20
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.=
cq b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> > index 28d6a30cc01..3b420b33188 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> > @@ -4322,6 +4322,10 @@ brcmf_pmksa_v3_op(struct brcmf_if *ifp, struct c=
fg80211_pmksa *pmksa,
> >   	int ret;
> >  =20
> >   	pmk_op =3D kzalloc(sizeof(*pmk_op), GFP_KERNEL);
> > +	if (!pmk_op) {
> > +		ret =3D -ENOMEM;
> > +		goto out;
> > +	}
>=20
> There is really no need to introduce a new label for this. Although you=
=20
> can kfree() a NULL pointer there is no need to do so when you know=20
> already it is NULL. Just return -ENOMEM and be done with it.
>=20
> Regards,
> Arend
>=20
> >   	pmk_op->version =3D cpu_to_le16(BRCMF_PMKSA_VER_3);
> >  =20
> >   	if (!pmksa) {
> > @@ -4340,6 +4344,7 @@ brcmf_pmksa_v3_op(struct brcmf_if *ifp, struct cf=
g80211_pmksa *pmksa,
> >   	pmk_op->length =3D cpu_to_le16(length);
> >  =20
> >   	ret =3D brcmf_fil_iovar_data_set(ifp, "pmkid_info", pmk_op, sizeof(*=
pmk_op));
> > +out:
> >   	kfree(pmk_op);
> >   	return ret;
> >   }


