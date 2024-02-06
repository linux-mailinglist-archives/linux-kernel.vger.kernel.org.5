Return-Path: <linux-kernel+bounces-54204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6408F84AC2F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C80C7B235D7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD7556B89;
	Tue,  6 Feb 2024 02:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eulvNua2"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BDA56B65;
	Tue,  6 Feb 2024 02:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707186322; cv=none; b=NjpaSBlTyKZk3atKIISugFzYMooJdh4aWhiSIeaX2vbtDMISCyzb5cVrls/X1kjs1CCGU2NymfUEHUF5QICqqGXE4lYXV5YQoURnMyKsI/ambGkyIm5FhnfhFd9uHmiSDdbAgtVZ4fJk4DyIP+RLgJOeexR9UrBLfrlLVCgMB34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707186322; c=relaxed/simple;
	bh=2yKBIlxETrljLtG8bUmHtTTra33h6dhwXZ0T/s0QsmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcSjylwcr5BfDfxYu4NojkqZT26p3fI8Xgl29o39RQcCQouBdTHRdL4t8IM8S7bQo2AzoLc8qRTqppF54AeqLNj57f8Fybvn50H4b7V+b/7QDosSsnQTaozm8Huuizw5XI2cN/0OHJ5dnD2icez9ocSpX2jeN40xYTKW6L74jok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eulvNua2; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bfcbfbfd92so192855b6e.2;
        Mon, 05 Feb 2024 18:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707186319; x=1707791119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ri1YQ2hEkTssAKG3opIAud0Ytbj1JVk5Pa/2THbXMCI=;
        b=eulvNua2W/TazGjHfr5iCCkP5eMGc/mYdI/tLOM7LjOe0a8dcC4YzDfY790JjLuzjC
         8k8nF3oX9QkD3DBPTD+/xE/qXWKEQOJ65EliXMc/jwyDNZfWfFN+nXeyexw1w01kEnsA
         gYODTBo8JWVsG5wTQu0NDKbJ5yt8ZI2C6RaGWmqP3OEpElArm0uqmVmnm9kwZVj1hfqJ
         kAtfJy5D2XL5qGMMfLuaIflc212ZXGpLxfTT2aQ9u7U7sUFTQKWqPxnrLNFdu3EzbDMq
         yKy9UNQYhza+2APhIGAUE/eHe0rdyFH1VpQhP9CdzzAkJYYAigu4TbeqElsPlragXn4q
         IUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707186319; x=1707791119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ri1YQ2hEkTssAKG3opIAud0Ytbj1JVk5Pa/2THbXMCI=;
        b=cN/tW8BzNsyKVsMT1D8JKqyQyEqTNivJwKphlmhaEkUnf0uA2QeTRADmJdmYGh54Kx
         GeOoSAGb/txB3xSWGM+64EhsBxKcqUGDOBgot941GQVT9lsii+NWGZW6B/SFIs4qF/NP
         73UZZo8RqfEMYo6X4FkNnUAPKqn5LQLRAXqcDEGxTcdJ/+SjKTvLvBe+15UNDFGSrCEJ
         DO+Puq3H3ymXX9BYuQrHPVf2fBXCN3IJCnuJ5ZtnhPyqpXN7bjd+CheU5NSAlhB5guNJ
         qS9v2phhwFfp5crk2ZYeSxhy8n6U6EUwGP89LFtk4+XZzWR/L5RRhyUEENXUgkorvvXF
         4msg==
X-Gm-Message-State: AOJu0Yybciqbx9EmS8REkdZl5qDEI920uvtN4zJYta3lBANb+C1JNnvW
	L2bD1MCr8I1GL/3Yh6dxMcoC1Sr4YaiJxz5zIIRtBXgiebqb6rRKVu8Dva9eFoN+H40/HurnwrM
	XfbRBZ0ctQcg+PawgYWfEE6kuU+c=
X-Google-Smtp-Source: AGHT+IEVsuie2ylzQj0kySZ8nRKieVfkGo33FysFNzbB3nzkZJlRBk3LZIRL0PZ4oMIKZNDj5ZH6MnaaktdvbHDH3JA=
X-Received: by 2002:a05:6808:11c8:b0:3be:c4df:6ccf with SMTP id
 p8-20020a05680811c800b003bec4df6ccfmr1892265oiv.5.1707186319364; Mon, 05 Feb
 2024 18:25:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203165307.7806-1-aford173@gmail.com> <20240203165307.7806-6-aford173@gmail.com>
 <1880028.tdWV9SEqCh@steina-w>
In-Reply-To: <1880028.tdWV9SEqCh@steina-w>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 5 Feb 2024 20:25:08 -0600
Message-ID: <CAHCN7xJZ5m1kZwx_9whx7Bv3B4N8mhB1feZUO4PpcosBXe5R2g@mail.gmail.com>
Subject: Re: [PATCH V8 05/12] arm64: dts: imx8mp: add HDMI power-domains
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux-arm-kernel@lists.infradead.org, marex@denx.de, 
	frieder.schrempf@kontron.de, Lucas Stach <l.stach@pengutronix.de>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Liu Ying <victor.liu@nxp.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 1:26=E2=80=AFAM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hi Adam,
>
> thanks for working on this.
>
> Am Samstag, 3. Februar 2024, 17:52:45 CET schrieb Adam Ford:
> > From: Lucas Stach <l.stach@pengutronix.de>
> >
> > This adds the PGC and HDMI blk-ctrl nodes providing power control for
> > HDMI subsystem peripherals.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> > V2:  Add missing power-domains hdcp and hrv
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 38 +++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mp.dtsi index
> > 76c73daf546b..5c54073de615 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > @@ -836,6 +836,23 @@ pgc_mediamix: power-domain@10 {
> >                                                        <&clk
> IMX8MP_CLK_MEDIA_APB_ROOT>;
> >                                       };
> >
> > +                                     pgc_hdmimix: power-
> domains@14 {
>

Alexander,

Thanks for the feedback.

> As per Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml the nod=
e
> should be called power-domain@.
>
> > +                                             #power-domain-
> cells =3D <0>;
> > +                                             reg =3D
> <IMX8MP_POWER_DOMAIN_HDMIMIX>;
> > +                                             clocks =3D <&clk
> IMX8MP_CLK_HDMI_ROOT>,
> > +                                                      <&clk
> IMX8MP_CLK_HDMI_APB>;
> > +                                             assigned-clocks =3D
> <&clk IMX8MP_CLK_HDMI_AXI>,
> > +
>   <&clk IMX8MP_CLK_HDMI_APB>;
> > +                                             assigned-clock-
> parents =3D <&clk IMX8MP_SYS_PLL2_500M>,
> > +
>          <&clk IMX8MP_SYS_PLL1_133M>;
> > +                                             assigned-clock-
> rates =3D <500000000>, <133000000>;
> > +                                     };
> > +
> > +                                     pgc_hdmi_phy: power-
> domains@15 {
>
> As per Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml the nod=
e
> should be called power-domain@.

Whoops.  I totally missed these when I applied them.  I'll have them
fixed on the next spin.
>
> > +                                             #power-domain-
> cells =3D <0>;
> > +                                             reg =3D
> <IMX8MP_POWER_DOMAIN_HDMI_PHY>;
> > +                                     };
> > +
> >                                       pgc_mipi_phy2: power-
> domain@16 {
> >                                               #power-domain-
> cells =3D <0>;
> >                                               reg =3D
> <IMX8MP_POWER_DOMAIN_MIPI_PHY2>;
> > @@ -1361,6 +1378,27 @@ eqos: ethernet@30bf0000 {
> >                               intf_mode =3D <&gpr 0x4>;
> >                               status =3D "disabled";
> >                       };
> > +
> > +                     hdmi_blk_ctrl: blk-ctrl@32fc0000 {
> > +                             compatible =3D "fsl,imx8mp-hdmi-blk-
> ctrl", "syscon";
> > +                             reg =3D <0x32fc0000 0x23c>;
> > +                             clocks =3D <&clk IMX8MP_CLK_HDMI_APB>,
> > +                                      <&clk
> IMX8MP_CLK_HDMI_ROOT>,
> > +                                      <&clk
> IMX8MP_CLK_HDMI_REF_266M>,
> > +                                      <&clk IMX8MP_CLK_HDMI_24M>,
> > +                                      <&clk
> IMX8MP_CLK_HDMI_FDCC_TST>;
> > +                             clock-names =3D "apb", "axi",
> "ref_266m", "ref_24m", "fdcc";
> > +                             power-domains =3D <&pgc_hdmimix>,
> <&pgc_hdmimix>,
> > +                                             <&pgc_hdmimix>,
> <&pgc_hdmimix>,
> > +                                             <&pgc_hdmimix>,
> <&pgc_hdmimix>,
> > +                                             <&pgc_hdmimix>,
> <&pgc_hdmi_phy>,
> > +                                             <&pgc_hdmimix>,
> <&pgc_hdmimix>;
> > +                             power-domain-names =3D "bus",
> "irqsteer", "lcdif",
> > +                                                  "pai", "pvi",
> "trng",
> > +                                                  "hdmi-tx",
> "hdmi-tx-phy",
> > +                                                  "hdcp",
> "hrv";
> > +                             #power-domain-cells =3D <1>;
> > +                     };
> >               };
> >
>
> According to RM this block is part of AIPS4, so it should be below
> hsio_blk_ctrl.

This is how it was when I got it, but I should have caught it.  Thanks
for that.  It looks like the subsequent HDMI, IRQ_steerting, LCDIF and
PHY ones are also out of place.

adam
>
> Best regards,
> Alexander
>
> >               aips5: bus@30c00000 {
>
>
> --
> TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Ge=
rmany
> Amtsgericht M=C3=BCnchen, HRB 105018
> Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan S=
chneider
> http://www.tq-group.com/
>
>

