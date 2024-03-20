Return-Path: <linux-kernel+bounces-109385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 850A4881868
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E50286525
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0247D8593B;
	Wed, 20 Mar 2024 20:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="OtHU3N1M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Csv2DKe+"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3873985929;
	Wed, 20 Mar 2024 20:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710965530; cv=none; b=hlHQS/EbYgQ9fNPiU0VxgqqHaG/lDSyiHthia0dY7y+axbO3moGD4VuGULhAf77xy3ihJnxqTauptsMwcfYDzEBhifFeKUEBFqbK5MVCG7f1vQ1qglrKId7V/2sJ3gibZ2RRH/mt1f141fWo10I5tO0s74tt5ixf96sZCqNeNi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710965530; c=relaxed/simple;
	bh=mWJ/bN8tdkOEkbEyPFYiVdM0z2OVeBG5BDHaJa0CtMU=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=uX77cDZ35pGqcYljPqqJ+B+CGi/CRT1OFkANT8D0CN/Af2YGGtIM9rw3n1+m9ETRJYBvxEGtGzjs0MejGIMhvq+S62rDqsbnflFaLmcPKdtjjyUsrQvPii9tUF4r8iwMgtBZbysmQW9auxC02EwAAMpnG5FW1sONn/xE/sr1Jic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=OtHU3N1M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Csv2DKe+; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3446F1380091;
	Wed, 20 Mar 2024 16:12:07 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Wed, 20 Mar 2024 16:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1710965527;
	 x=1711051927; bh=fFrDCHOnNJdytIVPZVMjE68HaUs0NU8NVLvkGUbap6c=; b=
	OtHU3N1MGTGOCjGAye/Vz7HyMs23GF+mG5bInbhhcE9zY+jFEiko4oSSg+jJ6tgf
	wX8vKgWU1JeX9jDp/GCwZ+HxoXWYvnd0VCZOxHdKV6DNXVNRRwhYESmiJsQs4pem
	IU3Zhy6LdlpMCrEbCyYPtQNUOUuVP9k1GYW+PuU2q22FuT8noGZJxF9ALhR72IdT
	2zsBwNVPolo/o61j55Y/dnUe+d1YE3tvweTvk2KQ+fCZqxp4WD5MKGoLuPOe5KIX
	sgCbwe1dU0wy/wGPDHe4+kINRC8f/jwa/Y+zxGo0E8QEloq/mVGBTUfQzVSpa5g5
	5I/NL0GqunAUB9DxbqRT2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1710965527; x=
	1711051927; bh=fFrDCHOnNJdytIVPZVMjE68HaUs0NU8NVLvkGUbap6c=; b=C
	sv2DKe+6SbbwiJVPR8whalDnFPWftujXRKxUXbpBkhuXteOYK9FhTGh6xlbrKT4k
	oqAOywdxU3AfuVkFFhc3akwD6YQ7vlVIegJ9scej4le9bk0WSyEaHsGAruyORTT3
	Bt1kIXBD4+Z7lBVM8QptKIxCVZ0/VelBdnUazMXBT4JjVlDbvShuRpqZIfF5vkfw
	aEKm3Ndt5UPJR58BAM5fCB9ExGFWqmFN5Vx2VRiTp0qYcM8t2xHaHca6o6pk+g84
	U+1+paKyp0Q50LzVkx1zAzn2Nyrzac9m0R++wfY1nie9CSEJ4zp3FLq35mg9KvY2
	t5h6skKPIFWDguQBZR2MA==
X-ME-Sender: <xms:F0P7ZSCOeokg7ZAP_AP_qfFCHUdR9K4uQqoyzJLr5VdFp_ayEU3E6w>
    <xme:F0P7ZSjj8kLWHfOZwd_cVo-DzipUGJehYJY6g8VYFrfjhixSnpLxYw7bskzMijawR
    0qG04q2DX3rsChQpfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeggddufeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfn
    uhhkvgculfhonhgvshdfuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrth
    htvghrnhepfeeugffhvdeufeehieelvdegfeffveegleehtddvheegkeetueegtdegueeh
    vdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplh
    hukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:F0P7ZTOeqQb-iKcfrwdB__p5ZotQchYO70fQqLpH6jfeYmD57f2qJQ>
    <xmx:F0P7Zb52OHOKkNBrxkB8iS7GEV45fyqnIriOQoqAPD4NMNBp9ndeww>
    <xmx:F0P7ZZ3Ap-5Ds8mvKMzq8jPK0QdDQn5nmy-wWNxArKHWUmT8Zlvefg>
    <xmx:F0P7ZUb8zag0_-h29Lhcs9_o4FbHzS6jDk2hEh9WiR4ZGYtTnHiJlw>
    <xmx:F0P7ZUVpAQSZU55EkPHd9So0QPS71sSmJT8VGz5ulbzp0dw_W4OFsg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1D9402340081; Wed, 20 Mar 2024 16:12:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1006a1d3-86f2-4770-9cf2-4f7e3e12a787@app.fastmail.com>
In-Reply-To: <ebe48668-dfca-775c-880e-dfa333b7e562@linux.intel.com>
References: <20240310233722.30884-1-luke@ljones.dev>
 <ebe48668-dfca-775c-880e-dfa333b7e562@linux.intel.com>
Date: Thu, 21 Mar 2024 09:11:43 +1300
From: "Luke Jones" <luke@ljones.dev>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
 "Hans de Goede" <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: asus-wmi: store a min default for ppt options
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Thu, 21 Mar 2024, at 2:13 AM, Ilpo J=C3=A4rvinen wrote:
> On Mon, 11 Mar 2024, Luke D. Jones wrote:
>=20
> > Laptops with any of the ppt or nv tunables default to the minimum se=
tting
> > on boot so we can safely assume a stored value is correct.
> >=20
> > This patch adds storing of those values in the local struct, and ena=
bles
> > reading of those values back.
> >=20
> > Secondary to the above it renames some internal variables to be more
> > consistent (which makes code grepping show all related parts)
> >=20
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > ---
> >  drivers/platform/x86/asus-wmi.c | 141 +++++++++++++++++++++++++----=
---
> >  1 file changed, 111 insertions(+), 30 deletions(-)
> >=20
> > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/=
asus-wmi.c
> > index e4341abb71e0..482e23b55e1e 100644
> > --- a/drivers/platform/x86/asus-wmi.c
> > +++ b/drivers/platform/x86/asus-wmi.c
> > @@ -272,12 +272,19 @@ struct asus_wmi {
> > =20
> >  /* Tunables provided by ASUS for gaming laptops */
> >  bool ppt_pl2_sppt_available;
> > + u32 ppt_pl2_sppt;
> >  bool ppt_pl1_spl_available;
> > + u32 ppt_pl1_spl;
> >  bool ppt_apu_sppt_available;
> > - bool ppt_plat_sppt_available;
> > + u32 ppt_apu_sppt;
> > + bool ppt_platform_sppt_available;
> > + u32 ppt_platform_sppt;
> >  bool ppt_fppt_available;
> > - bool nv_dyn_boost_available;
> > - bool nv_temp_tgt_available;
> > + u32 ppt_fppt;
> > + bool nv_dynamic_boost_available;
> > + u32 nv_dynamic_boost;
> > + bool nv_temp_target_available;
> > + u32 nv_temp_target;
> > =20
> >  bool kbd_rgb_mode_available;
> >  u32 kbd_rgb_dev;
>=20
> Can you check with pahole if this structure is now full of 31-bit hole=
s?
>=20
> The benefit of keeping bool & u32 doesn't seem that big to begin with=20
> (in visual sense because of the 1 char variation in column).

I don't really understand what you mean here. I do most of this stuff wh=
en I have time, so because my time is limited I usually don't have oppor=
tunity to learn much more than the minimum.

