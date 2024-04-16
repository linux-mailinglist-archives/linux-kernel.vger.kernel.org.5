Return-Path: <linux-kernel+bounces-147199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 329148A70E5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B066D1F23318
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A3D13175F;
	Tue, 16 Apr 2024 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0gRY89j"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65A2131726;
	Tue, 16 Apr 2024 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713283695; cv=none; b=Id2qWzi1H+PmtVOFE9o/cd7dNwYGoMeQfK607vOGhj0G0l8yp+7UUjm9Nz4R/pAXlohSSuW4jUQlUTy/bq2KdFSURp4E4jnXja8xDVu+ETeQuRBeHJe5JhhS+pCebbr8QDkvDrCGXebBc1PSzOSfj7WggCAMmuh0WCQs+Nl89Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713283695; c=relaxed/simple;
	bh=QV71qq9odi8AHKM63Tno0XX3cSK/Xlz9aafkhj8FPUw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=URXuyyyQaKNVVRSd9n0dsEEpog9xi20mWI+Si35xEdUV82d+Whbcdgn0PIzIoC6mRUcxeTfHlIKkMJjBex5xtWUfvv4vOGhEpFsn9d+WCQytcGiXejgbPeHUeeg5YNw9NFfA7XyJEp75bGtf3Cpl8L92+GCwlja8u64ds76mGZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0gRY89j; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4187731a6e1so12199135e9.2;
        Tue, 16 Apr 2024 09:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713283691; x=1713888491; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZIdA1Sj+M3uL+IMIYi64iHj/gQH9BBQNdMeTTfi5MAk=;
        b=V0gRY89jYvybpfTOtqLjrIb4AxdWlTZ42D+97vBdCUAR+mdLqo8rttNEaCi8wEclIB
         vLUVyYLiQ8t7e26GLpJDAz502bsQw0EIblozzHcLaTq06bIvAga5KjAWa7z6NBI7xj2p
         iuAfNyZm4+dDzfJUn9Qi5vYC+WuXVy1Di+0rAEFFSbllD1tO6aue+n3sE61jZ7ZzcWEn
         O9R1TZj+EUu2dibbReRc+NONqUnywUy1EuTHikJcc4I/dYD7pxT3CDfmBTwp0FGY2dPg
         ItM6WzenuGOmJ07s3/fed30rok/ulVyob6f8oj6ydIehbTRnjsHdHXXRpUuZo/N5fT9X
         weLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713283691; x=1713888491;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZIdA1Sj+M3uL+IMIYi64iHj/gQH9BBQNdMeTTfi5MAk=;
        b=uNIJzPr4EYZskGsJzW8971FaftjPrWdMWhJZ2B3mA5tYUe3IF7gS8JiaswCwU8RpXl
         m4Jijc/cWO0XIhwrGOBpDyxPBSpvcFSrR2yT1mnKoX8AO2v8UhvBWqIq9O5xTwXN+hs9
         W1T87VxD8xJr6i2ZTDdZsriqAMKBzeM8W9Vk/58OF49NAY4cWFH+E8CKSLCzPsZaxqoy
         MPAOk8CTXXiwhlrLpZlt+5Py0+mGcFDMbShkJGu/Ued6u+I+SfD1s1QGFvCMmy00JgXx
         SRfsq4uVcnA+1DgKrQgySqMfNm4gLsaT3ma202BVAE9M1Pu/0l3OCQphIDwA11B3czO1
         41BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC87sEUb6elqGDl7JKCGsqDacmqQcITXRgydms6lStbCgZbmr0QFkMgN51YEwvrCZOe9CCGeOgaloICbeVk5xv8wcrWHTUz9ff3WVf0Fibot2HqQ/qtETDE3vSwfTKABbcjAXsuohzKHWO+8YaYMrC7NrNmrs+iB6Q0RfC1RQTyA==
X-Gm-Message-State: AOJu0YwsplvoJKK0MjDyvzPgtRGyOI7HAhjYveKPo2CeGjIRoaG5JVle
	uTtAAHzOgjQrKWM2fN1c3LdaildF6yNXZrmqbGYyi3HEPQKeI8uI
X-Google-Smtp-Source: AGHT+IHyFWGmvJYOfR2xREiYISWtTfew1Vay0BFApoqN0ItFTTRH32ygEA6x9s/dWYJk19A15KUMfg==
X-Received: by 2002:a05:600c:3549:b0:418:23d7:816f with SMTP id i9-20020a05600c354900b0041823d7816fmr5977429wmq.17.1713283690835;
        Tue, 16 Apr 2024 09:08:10 -0700 (PDT)
Received: from ?IPv6:2001:8a0:e622:f700:648e:56c:90e2:9fe8? ([2001:8a0:e622:f700:648e:56c:90e2:9fe8])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c1c0700b004187d900766sm5347326wms.43.2024.04.16.09.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 09:08:10 -0700 (PDT)
Message-ID: <c064940ba46449b540a3cba14ebab96d31ba19de.camel@gmail.com>
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
Date: Tue, 16 Apr 2024 17:08:08 +0100
In-Reply-To: <564fa534b32f4a6e96da6752f531fc7447ec633d.camel@gmail.com>
References: <20240409085802.290439-1-ivitro@gmail.com>
	 <9ce35b9bb5a15891f6bd01bd54b7dc84b3ba4021.camel@pengutronix.de>
	 <e1552a3008a30ef7ed9097b4b80cda23ccb9e840.camel@gmail.com>
	 <fcd6acc268b8642371cf289149b2b1c3e90c7f45.camel@pengutronix.de>
	 <bd4d7198e58bd89b46a4c721546f6975b287a5fc.camel@gmail.com>
	 <c76d98a300a9d65d236d334da62916a7d658ef27.camel@gmail.com>
	 <564fa534b32f4a6e96da6752f531fc7447ec633d.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-16 at 11:53 +0100, Vitor Soares wrote:
> ++ Peng Fan <peng.fan@nxp.com>
>=20
> Greetings,
>=20
>=20
> On Wed, 2024-04-10 at 12:01 +0100, Vitor Soares wrote:
> > Hi Lucas,
> >=20
> > On Tue, 2024-04-09 at 17:44 +0100, Vitor Soares wrote:
> > > On Tue, 2024-04-09 at 16:36 +0200, Lucas Stach wrote:
> > > > Am Dienstag, dem 09.04.2024 um 14:22 +0100 schrieb Vitor Soares:
> > > > > Hi Lucas,
> > > > >=20
> > > > > Thanks for your feedback.
> > > > >=20
> > > > > On Tue, 2024-04-09 at 11:13 +0200, Lucas Stach wrote:
> > > > > > Hi Vitor,
> > > > > >=20
> > > > > > Am Dienstag, dem 09.04.2024 um 09:58 +0100 schrieb Vitor
> > > > > > Soares:
> > > > > > > From: Vitor Soares <vitor.soares@toradex.com>
> > > > > > >=20
> > > > > > > The pgc_vpu_* nodes miss the reference to the power domain
> > > > > > > parent,
> > > > > > > leading the system to hang during the resume.
> > > > > > >=20
> > > > > > This change is not correct. The vpumix domain is controlled
> > > > > > through
> > > > > > the
> > > > > > imx8mm-vpu-blk-ctrl and must not be directly triggered by the
> > > > > > child
> > > > > > domains in order to guarantee proper power sequencing.
> > > > > >=20
> > > > > > If the sequencing is incorrect for resume, it needs to be
> > > > > > fixed
> > > > > > in
> > > > > > the
> > > > > > blk-ctrl driver. I'll happily assist if you have any
> > > > > > questions
> > > > > > about
> > > > > > this intricate mix between GPC and blk-ctrl hardware/drivers.
> > > > > =C2=A0
> > > > > I'm new into the topic, so I tried to follow same approach as
> > > > > in
> > > > > imx8mp
> > > > > DT.
> > > > >=20
> > > > That's a good hint, the 8MP VPU GPC node additions missed my
> > > > radar.
> > > > The
> > > > direct dependency there between the GPC domains is equally wrong.
> > > >=20
> > > > > I also checked the imx8mq DT and it only have one domain for
> > > > > the
> > > > > VPU in the GPC. It seem blk-ctrl also dependes on pgc_vpu_* to
> > > > > work
> > > > > properly.
> > > > >=20
> > > > > The blk-ctrl driver hangs on imx8m_blk_ctrl_power_on() when
> > > > > access
> > > > > the
> > > > > ip registers for the soft reset. I tried to power-up the before
> > > > > the
> > > > > soft reset, but it didn't work.
> > > > >=20
> > > > The runtime_pm_get_sync() at the start of that function should
> > > > ensure
> > > > that bus GPC domain aka vpumix is powered up. Can you check if
> > > > that
> > > > is
> > > > happening?
> > >=20
> > > I checked bc->bus_power_dev->power.runtime_status and it is
> > > RPM_ACTIVE.
> > >=20
> > > Am I looking to on the right thing? It is RPM_ACTIVE event before
> > > runtime_pm_get_sync().
> >=20
> > During the probe I can see that
> > bus_power_dev->power.runtime_status =3D RPM_SUSPENDED and then vpumix
> > is
> > powered up on GPC driver.
> >=20
> > On resume routine I can't see this flow. bus_power_dev-
> > > power.runtime_status =3D RPM_ACTIVE and vpumix end up not being
> > > powered-
> > up.
> >=20
> > I checked the suspend flow and the GPC tries to poweroff vpumix.
> >=20
> >=20
>=20
> My understanding is that when resuming the 38310000.video-codec, the
> vpumix isn't powered up. It happens because runtime_status and
> runtime_last_status =3D RPM_ACTIVE.=20
>=20
> I tried to change blk-ctrl suspend routine to force the runtime_status
> =3D RPM_SUSPENDED, but the system ended up hanging on another device.
>=20
> From the comment in blk-ctrl suspend, we rely on PM_SLEEP code that
> iterates over dpm_list for suspend/resume.
> I did look at the dpm_list, and it changes the order on every boot.=20
>=20
> With all the tests, I also found that the system randomly hangs on
> dispblk-lcdif suspend. I have confirmed this device is in a different
> place in the dpm_list (not sure if it is the root cause).=20
> I haven't understood how blk-ctrl ensures the correct order there yet.=
=20
>=20
> Taking the following dpm_list excerpt:
> idx - device
> ------------------------------
> ...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0
> 191 - imx-pgc-domain.7=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0
> 192 - imx-pgc-domain.8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0
> 193 - imx-pgc-domain.9=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0
> 194 - 38330000.blk-ctrl=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0
> 195 - 38310000.video-codec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> 196 - 38300000.video-codec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> ...
> 205 - genpd:0:38330000.blk-ctrl
> 206 - genpd:1:38330000.blk-ctrl
> 207 - genpd:2:38330000.blk-ctrl
> 208 - genpd:3:38330000.blk-ctrl
> ------------------------------
>=20
> Shouldn't genpd devices be before 38330000.blk-ctrl?
> As their power domain is GPC and the blk-ctrl power domain is genpd.
>=20

I did the following change to have genpd device before 38330000.blk-ctrl
on dpm_list and it did work.

diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/i=
mx8m-blk-ctrl.c
index ca942d7929c2..0f1471dcd4e8 100644
--- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
@@ -220,6 +220,7 @@ static int imx8m_blk_ctrl_probe(struct platform_device =
*pdev)
                        return dev_err_probe(dev, PTR_ERR(bc->bus_power_dev=
),
                                             "failed to attach power domain=
 \"bus\"\n");
        }
+       device_move(dev, bc->bus_power_dev, DPM_ORDER_PARENT_BEFORE_DEV);
=20
        for (i =3D 0; i < bc_data->num_domains; i++) {
                const struct imx8m_blk_ctrl_domain_data *data =3D &bc_data-=
>domains[i];
@@ -268,6 +269,7 @@ static int imx8m_blk_ctrl_probe(struct platform_device =
*pdev)
                                      data->gpc_name);
                        goto cleanup_pds;
                }
+               device_move(dev, domain->power_dev, DPM_ORDER_PARENT_BEFORE=
_DEV);
=20
                domain->genpd.name =3D data->name;
                domain->genpd.power_on =3D imx8m_blk_ctrl_power_on;

any concern about this approach?

Best regards,
Vitor Soares
>=20
> >=20
> > >=20
> > >=20
> > > >=20
> > > > Regards,
> > > > Lucas
> > > >=20
> > > > > Do you have an idea how we can address this within blk-ctrl?
> > > > >=20
> > > > > Best regards,
> > > > > Vitor
> > >=20
> >=20
>=20


