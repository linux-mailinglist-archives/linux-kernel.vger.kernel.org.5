Return-Path: <linux-kernel+bounces-126097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AAE893221
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74D72282500
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 15:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9594145345;
	Sun, 31 Mar 2024 15:54:17 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CCF1E531;
	Sun, 31 Mar 2024 15:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711900457; cv=none; b=fKj0zSdq1Fj4YEXbFCrCjeTp5LMDZz0GCLaD34UC/bnb6txP1rwzO4BBsTv8KUsH4OR416adoEIH/Dtxlk9HjqU6qOxAAKi9mTU4vRBswzNDo/IRzg0dJwQemzkfk2DMha14HeCjow4NrDwpRtPh8hwQi0FbRj1iSg8abKaqFyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711900457; c=relaxed/simple;
	bh=Uc1KW8hGMIQWMXsj9q7n3Os7KrFYC2VKY3GqwMRyHGw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gcfYs3YO68pl6vLX4J28WJ6ZsevJDtuZBRlj7WtTyRLLBk7GIe8xlf6TEGzHY5+53k3lta0JCgFhaZAzBU+Vjj9jUfdDonQ7DuzaAeV8yTNDyIS+geLPLgALTl5ZPUI4qAJeu2rznCGjY45rVyoSwvcC+gntP3hDOn4I4Pm5P3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 7CA7A120179;
	Sun, 31 Mar 2024 15:54:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 500E818;
	Sun, 31 Mar 2024 15:54:01 +0000 (UTC)
Message-ID: <dbe8ea1a6a3b599a00eeb8ba0254fde785a500b9.camel@perches.com>
Subject: Re: [PATCH v4 2/2] scripts: checkpatch: check unused parameters for
 function-like macro
From: Joe Perches <joe@perches.com>
To: Mac Xu <mac.xxn@outlook.com>, Barry Song <21cnbao@gmail.com>, 
	"akpm@linux-foundation.org"
	 <akpm@linux-foundation.org>, "linux-doc@vger.kernel.org"
	 <linux-doc@vger.kernel.org>
Cc: "apw@canonical.com" <apw@canonical.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "chenhuacai@loongson.cn" <chenhuacai@loongson.cn>, 
 "chris@zankel.net" <chris@zankel.net>, "corbet@lwn.net" <corbet@lwn.net>, 
 "dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
 "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux@roeck-us.net" <linux@roeck-us.net>,  "lukas.bulwahn@gmail.com"
 <lukas.bulwahn@gmail.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, 
 "v-songbaohua@oppo.com" <v-songbaohua@oppo.com>,
 "workflows@vger.kernel.org" <workflows@vger.kernel.org>,  Max Filippov
 <jcmvbkbc@gmail.com>
Date: Sun, 31 Mar 2024 08:54:00 -0700
In-Reply-To: <MN0PR20MB4717810B82175CC594A9F285F3382@MN0PR20MB4717.namprd20.prod.outlook.com>
References: <20240328022136.5789-1-21cnbao@gmail.com>
	 <20240328022136.5789-3-21cnbao@gmail.com>
	 <ef2c96e40bcf777535c9ff2405e4dc5b3138b27e.camel@perches.com>
	 <MN0PR20MB4717810B82175CC594A9F285F3382@MN0PR20MB4717.namprd20.prod.outlook.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: uh6mfa15t5g7ucfaa49qh8ezswwjjfa6
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 500E818
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/5kpa60OO0mgDP7ujpRGtlQZspuLjxAzI=
X-HE-Tag: 1711900441-273597
X-HE-Meta: U2FsdGVkX1908fgJHnjrmlQdMn0+SlRyYy9HNNP+vxv3r8Dv6hY3i1jH2e/PW52vPDrGBkukRRP34YWAi41zHWzF2+JzgJwH+a5kY5/BTZCqJos60SwH3/8lneEFYkA3EYsSONF8Zx2ofUys7sq61qWoGu2oZ2eKumioqAz4U97aeIgt60V0cfoZWWoh2jZV41pbc6cWG4r6RnmQsE6ye440giOES4u0TaPzhiXX9Cg+lpIoAB2w142cfkPG3ZVRvESF98G7mWSmU0QgX2X5G8YmGuW2oILSgnxZA4+ud6j4We2iuxpeh76MBM83uHqCCFZzG8Y/nRZdE58QFAJibP3yRQ2NWtTm

On Sun, 2024-03-31 at 13:46 +0000, Mac Xu wrote:
> > On Thu, 2024-03-28 at 15:21 +1300, Barry Song wrote:
> > > From: Xining Xu <mac.xxn@outlook.com>
> > >=20
> > > If function-like macros do not utilize a parameter, it might result i=
n a
> > > build warning.  In our coding style guidelines, we advocate for utili=
zing
> > > static inline functions to replace such macros.  This patch verifies
> > > compliance with the new rule.
> > []
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>=20
[]
> > It seems this logic is a bit redundant to existing
> > code and might be better added in the block that starts
> >=20
> > (line 6026)
> > # check if any macro arguments are reused (ignore '...' and 'type')
> >=20
> > as that already does each param in a #define and
> > ignores ... and type
>=20
> Hi Joe,
>=20
> Thank you for your comments with insights, as you said, code block of lin=
e 6026 is a better place to=20
> place this new logic, as it already handles the logic I'd wanted like ext=
racting, splitting and trimming=20
> the arguments, excluding the trailing comments etc.
>=20
> By placing the logic in the new place, code duplicates are reduced.
>=20
> Here's my new code (inserted from line 6044):
> +# check if this is an unused argument
> +        if ($define_stmt !~ /\b$arg\b/) {
> +                WARN("UNUSED_ARG_IN_MACRO",

Perhaps
					WARN("MACRO_ARG_UNUSED",
			...

to better match the others above it in the block:

					CHK("MACRO_ARG_REUSE",
and
					CHK("MACRO_ARG_PRECEDENCE",

Other than that trivial bit, seems ok.


