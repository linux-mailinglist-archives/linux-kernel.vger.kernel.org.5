Return-Path: <linux-kernel+bounces-148464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 279548A82ED
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE1782835B8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4316913D286;
	Wed, 17 Apr 2024 12:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfjzBj7u"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC6913D245;
	Wed, 17 Apr 2024 12:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713355975; cv=none; b=BwNeFHrklVdgN3mdXp/m0hSuNevjjpGSP6X2tOsr+9T4/MR3GI5TS48itL22iwWELBr5t2WbuNKVOcOfaFu7qTSrfzQUs6LledjCks1JjbZQNsRxbTVvrSrVBNK8QYhhVJrRkFoXBN7XlFRf01hH1BTLSmy0iQOpNyFArCbUf4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713355975; c=relaxed/simple;
	bh=HrZpYSTsoC4ix4EpnTAb47aPRg1jX1QDOboBvCgUWeI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CHCVs916ik0d8H0o8HigQACi/9Lh6exx2rFZ49SClbd/W1mM19QLBQ8SUlh37XEHa+tQnguMhqBZh39XaPn8c/RSGez26ZIgBQghJDD5VudDob4mlWTeZwFyeka34RC1pxS5+BpIcllgzkaolQovZ7GYJ5Rde8gipX5rotJYADI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfjzBj7u; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-416a8ec0239so4689365e9.0;
        Wed, 17 Apr 2024 05:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713355971; x=1713960771; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HrZpYSTsoC4ix4EpnTAb47aPRg1jX1QDOboBvCgUWeI=;
        b=HfjzBj7uYh4jhpTEEk6ge3FeynYUzCIlfo+ERSwghI0QYNfnWe+DhwdBnFkK5OmaQS
         xY8A9zwj39s1h1IS50H5XzOzc7KharXnD4AZUAe9X5jp7V0fdhqxQYBRapotaNjrqNBT
         UgXMwjdMn0E/3jsnquW5egd5x7P4kvZ7mBYfAzTG1wBxE6tpG9lVuUqJQQOJfg9JT5bL
         xEApHYX9rLnaPQnIOtww/yqk/f3PrFcO7iTlvH39ELXTUjOgkJKHjpHNKDet0JbD2OKQ
         bj4u29L0XquwRxwiVbr0am1JRVoaOWTdrWnvYEaRjAoZYi201XokvlGySsJMtwo2chte
         uJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713355971; x=1713960771;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HrZpYSTsoC4ix4EpnTAb47aPRg1jX1QDOboBvCgUWeI=;
        b=k4Fb+NhfRgedjt1ZDBODlsdpJO3i79EEywCpEBovqazSM5MsEb/1jrHaA2TFzInCJE
         IqC9+s0CoTUq5r46h8AC9rav++thHaTnx8vtPkujjSUI0/9fpHmbUtVITdpkLFb5F96e
         tlTsdieL4eZCR4cQt58b5SZNVY7aPx45akY606CAhZqcTZMUZ+FbRAlhb0+ytwcbW0gF
         MKUK7m2e+HjxF8p37fOFG1BgN4lhcBR0WLazUHMPzNMo/1/Np8H6IihK30KSy8CFoPTF
         9dFKOnhPBjJBzrzbggdgv8o2rvP8xvPhDpmD6sxDTaiTyuN2kF82DEuiDy1aOa7+N6/O
         6k5g==
X-Forwarded-Encrypted: i=1; AJvYcCVe/ocGO2wA145KGQvxT30tOUL255TLYwp1SOdSvTZ7hjxGcDVecvFTJlVhtFrSccR/ZQn5AZ/eAwyz2ZgnER2ZU4KHEvdeJ3WcZ+ocrG3Hv5DpzDGyHxjH5keuffbIlJK46ZfzuNvTWrBbom2w3/bGS2etNU1nApBxuvSv52vNGg==
X-Gm-Message-State: AOJu0YwKNlfsbKcr4vvxfXAzQxgIXH7194GFhKmMBik+94u8qLoYdyWS
	8xmTVbwGE3VwVvLjKgnuBo7WFJBzyaMG5o3njt0dVYx3ubLpniFO
X-Google-Smtp-Source: AGHT+IHSLygSTkmUK8kxFK7/Y0W8n7WxJu8sNlhyt+B+fUCRZxXO7GbTQJ3brmq96IFuBDfw86LBsw==
X-Received: by 2002:a05:600c:1d09:b0:417:d347:ac68 with SMTP id l9-20020a05600c1d0900b00417d347ac68mr4178655wms.17.1713355971267;
        Wed, 17 Apr 2024 05:12:51 -0700 (PDT)
Received: from ?IPv6:2001:8a0:e622:f700:abb8:8caf:bab6:45a3? ([2001:8a0:e622:f700:abb8:8caf:bab6:45a3])
        by smtp.gmail.com with ESMTPSA id n26-20020a05600c3b9a00b00418a2ce884bsm2632187wms.32.2024.04.17.05.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 05:12:50 -0700 (PDT)
Message-ID: <ae7a78f5e3258e5e1e0cd1515a50c2c9c0ce1edf.camel@gmail.com>
Subject: Re: [PATCH v1] arm64: dts: imx8mm: fix missing pgc_vpu_* power
 domain parent
From: Vitor Soares <ivitro@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,  Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 17 Apr 2024 13:12:44 +0100
In-Reply-To: <47cd522d09fbfb4cce7d1d82e6657b6b21fa04d7.camel@pengutronix.de>
References: <20240409085802.290439-1-ivitro@gmail.com>
	 <9ce35b9bb5a15891f6bd01bd54b7dc84b3ba4021.camel@pengutronix.de>
	 <e1552a3008a30ef7ed9097b4b80cda23ccb9e840.camel@gmail.com>
	 <fcd6acc268b8642371cf289149b2b1c3e90c7f45.camel@pengutronix.de>
	 <bd4d7198e58bd89b46a4c721546f6975b287a5fc.camel@gmail.com>
	 <c76d98a300a9d65d236d334da62916a7d658ef27.camel@gmail.com>
	 <564fa534b32f4a6e96da6752f531fc7447ec633d.camel@gmail.com>
	 <c064940ba46449b540a3cba14ebab96d31ba19de.camel@gmail.com>
	 <47cd522d09fbfb4cce7d1d82e6657b6b21fa04d7.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Lucas,

On Wed, 2024-04-17 at 10:00 +0200, Lucas Stach wrote:
> Hi Vitor,
>=20
> Am Dienstag, dem 16.04.2024 um 17:08 +0100 schrieb Vitor Soares:
> > On Tue, 2024-04-16 at 11:53 +0100, Vitor Soares wrote:
> > > ++ Peng Fan <peng.fan@nxp.com>
> > >=20
> > > Greetings,
> > >=20
> > >=20
> > > On Wed, 2024-04-10 at 12:01 +0100, Vitor Soares wrote:
> > > > Hi Lucas,
> > > >=20
> > > > On Tue, 2024-04-09 at 17:44 +0100, Vitor Soares wrote:
> > > > > On Tue, 2024-04-09 at 16:36 +0200, Lucas Stach wrote:
> > > > > > Am Dienstag, dem 09.04.2024 um 14:22 +0100 schrieb Vitor Soares=
:
> > > > > > > Hi Lucas,
> > > > > > >=20
> > > > > > > Thanks for your feedback.
> > > > > > >=20
> > > > > > > On Tue, 2024-04-09 at 11:13 +0200, Lucas Stach wrote:
> > > > > > > > Hi Vitor,
> > > > > > > >=20
> > > > > > > > Am Dienstag, dem 09.04.2024 um 09:58 +0100 schrieb Vitor
> > > > > > > > Soares:
> > > > > > > > > From: Vitor Soares <vitor.soares@toradex.com>
> > > > > > > > >=20
> > > > > > > > > The pgc_vpu_* nodes miss the reference to the power domai=
n
> > > > > > > > > parent,
> > > > > > > > > leading the system to hang during the resume.
> > > > > > > > >=20
> > > > > > > > This change is not correct. The vpumix domain is controlled
> > > > > > > > through
> > > > > > > > the
> > > > > > > > imx8mm-vpu-blk-ctrl and must not be directly triggered by t=
he
> > > > > > > > child
> > > > > > > > domains in order to guarantee proper power sequencing.
> > > > > > > >=20
> > > > > > > > If the sequencing is incorrect for resume, it needs to be
> > > > > > > > fixed
> > > > > > > > in
> > > > > > > > the
> > > > > > > > blk-ctrl driver. I'll happily assist if you have any
> > > > > > > > questions
> > > > > > > > about
> > > > > > > > this intricate mix between GPC and blk-ctrl hardware/driver=
s.
> > > > > > > =C2=A0
> > > > > > > I'm new into the topic, so I tried to follow same approach as
> > > > > > > in
> > > > > > > imx8mp
> > > > > > > DT.
> > > > > > >=20
> > > > > > That's a good hint, the 8MP VPU GPC node additions missed my
> > > > > > radar.
> > > > > > The
> > > > > > direct dependency there between the GPC domains is equally wron=
g.
> > > > > >=20
> > > > > > > I also checked the imx8mq DT and it only have one domain for
> > > > > > > the
> > > > > > > VPU in the GPC. It seem blk-ctrl also dependes on pgc_vpu_* t=
o
> > > > > > > work
> > > > > > > properly.
> > > > > > >=20
> > > > > > > The blk-ctrl driver hangs on imx8m_blk_ctrl_power_on() when
> > > > > > > access
> > > > > > > the
> > > > > > > ip registers for the soft reset. I tried to power-up the befo=
re
> > > > > > > the
> > > > > > > soft reset, but it didn't work.
> > > > > > >=20
> > > > > > The runtime_pm_get_sync() at the start of that function should
> > > > > > ensure
> > > > > > that bus GPC domain aka vpumix is powered up. Can you check if
> > > > > > that
> > > > > > is
> > > > > > happening?
> > > > >=20
> > > > > I checked bc->bus_power_dev->power.runtime_status and it is
> > > > > RPM_ACTIVE.
> > > > >=20
> > > > > Am I looking to on the right thing? It is RPM_ACTIVE event before
> > > > > runtime_pm_get_sync().
> > > >=20
> > > > During the probe I can see that
> > > > bus_power_dev->power.runtime_status =3D RPM_SUSPENDED and then vpum=
ix
> > > > is
> > > > powered up on GPC driver.
> > > >=20
> > > > On resume routine I can't see this flow. bus_power_dev-
> > > > > power.runtime_status =3D RPM_ACTIVE and vpumix end up not being
> > > > > powered-
> > > > up.
> > > >=20
> > > > I checked the suspend flow and the GPC tries to poweroff vpumix.
> > > >=20
> > > >=20
> > >=20
> > > My understanding is that when resuming the 38310000.video-codec, the
> > > vpumix isn't powered up. It happens because runtime_status and
> > > runtime_last_status =3D RPM_ACTIVE.=20
> > >=20
> > > I tried to change blk-ctrl suspend routine to force the runtime_statu=
s
> > > =3D RPM_SUSPENDED, but the system ended up hanging on another device.
> > >=20
> > > From the comment in blk-ctrl suspend, we rely on PM_SLEEP code that
> > > iterates over dpm_list for suspend/resume.
> > > I did look at the dpm_list, and it changes the order on every boot.=
=20
> > >=20
> > > With all the tests, I also found that the system randomly hangs on
> > > dispblk-lcdif suspend. I have confirmed this device is in a different
> > > place in the dpm_list (not sure if it is the root cause).=20
> > > I haven't understood how blk-ctrl ensures the correct order there yet=
=20
> > >=20
> Random order of the DPM list seems like a good find to investigate
> further.
>=20
> > > Taking the following dpm_list excerpt:
> > > idx - device
> > > ------------------------------
> > > ...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > 191 - imx-pgc-domain.7=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
> > > 192 - imx-pgc-domain.8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
> > > 193 - imx-pgc-domain.9=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
> > > 194 - 38330000.blk-ctrl=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0
> > > 195 - 38310000.video-codec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > 196 - 38300000.video-codec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > ...
> > > 205 - genpd:0:38330000.blk-ctrl
> > > 206 - genpd:1:38330000.blk-ctrl
> > > 207 - genpd:2:38330000.blk-ctrl
> > > 208 - genpd:3:38330000.blk-ctrl
> > > ------------------------------
> > >=20
> > > Shouldn't genpd devices be before 38330000.blk-ctrl?
> > > As their power domain is GPC and the blk-ctrl power domain is genpd.
> > >=20
> >=20
> > I did the following change to have genpd device before 38330000.blk-ctr=
l
> > on dpm_list and it did work.
> >=20
> > diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/i=
mx/imx8m-blk-ctrl.c
> > index ca942d7929c2..0f1471dcd4e8 100644
> > --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> > +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> > @@ -220,6 +220,7 @@ static int imx8m_blk_ctrl_probe(struct platform_dev=
ice *pdev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n dev_err_probe(dev, PTR_ERR(bc->bus_power_dev),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "failed to attach power domai=
n \"bus\"\n");
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device_move(dev, bc->bus_power_de=
v, DPM_ORDER_PARENT_BEFORE_DEV);
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < bc_data->n=
um_domains; i++) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 const struct imx8m_blk_ctrl_domain_data *data =3D &bc=
_data->domains[i];
> > @@ -268,6 +269,7 @@ static int imx8m_blk_ctrl_probe(struct platform_dev=
ice *pdev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 data->gpc_name);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto =
cleanup_pds;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 device_move(dev, domain->power_dev, DPM_ORDER_PARENT_BEFORE=
_DEV);
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 domain->genpd.name =3D data->name;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 domain->genpd.power_on =3D imx8m_blk_ctrl_power_on;
> >=20
> > any concern about this approach?
> >=20
> I'm a bit uncomfortable with calling such a low-level function from
> this driver. Also we don't really want to move the device to a new
> parent, but just want to ensure proper order on the dpm list. Adding a
> device_link between the devices seems like the better way to do so.

Thanks for your feedback.

I have tested with device_link_add() and it is working. I will prepare a ne=
w patch with this change.

Best regards,
Vitor Soares
>=20
> Regards,
> Lucas
>=20
> > Best regards,
> > Vitor Soares
> > >=20
> > > >=20
> > > > >=20
> > > > >=20
> > > > > >=20
> > > > > > Regards,
> > > > > > Lucas
> > > > > >=20
> > > > > > > Do you have an idea how we can address this within blk-ctrl?
> > > > > > >=20
> > > > > > > Best regards,
> > > > > > > Vitor
> > > > >=20
> > > >=20
> > >=20
> >=20
>=20


