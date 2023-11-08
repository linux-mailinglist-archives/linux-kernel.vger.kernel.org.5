Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B777E607F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 23:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjKHWvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 17:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKHWva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 17:51:30 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C9C210A;
        Wed,  8 Nov 2023 14:51:28 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-daec4e4c5eeso267855276.1;
        Wed, 08 Nov 2023 14:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699483888; x=1700088688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzcCOTkzTMNtkGk4euDjQYgNxZ6bCe93/Di6zU8gTRc=;
        b=OYhT3dfiQ+8P75cwsUoERA1LvUy4+2q50BsYasVlKsFD90rebJmAgKBs50YgKbHNvJ
         Z3x9/56o4T+7I9TteFPJwpdpPDVMkWfs7vOznH7c9FMO1z9C9yKafHpI0ZSyT/L9ojyN
         shzd6d6ehINPh9Mko+c9q3XDrNy6Y0e/D7qimbPzmgwZPWrlLMBXW3eUpwBgGF6Uz1d3
         7NPpL5KVMRH4Y256CmdriyjKMsrExaNrqzsVN1VCrcqq/caWEYvoM43Pw6yGQ45pQMr3
         SLlBxZ6emXE9o7RGSKZ4tY0uRtYfHbTSQXe/vrd+3HtiSN7Mo3J4IgI3Rwc1lOTO5w2o
         C/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699483888; x=1700088688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BzcCOTkzTMNtkGk4euDjQYgNxZ6bCe93/Di6zU8gTRc=;
        b=uYNbQwKpv5jrFCaG9byPq3L78oNUBGL9nb3esSJq/l1eW1RwtHF5wM1u7JbFP9lbMS
         PEHBv01ouuZjaPFBz0IrMS2pOd3lD8WqUR3572orq6Iug4pmNLtNE87olwvFmPlQ4D2V
         zdVADutg5RKxjQIUffgwz87aBzt3COZSI71d2WQ7MgM2M5qiwpQBTUyXLpNVn2mE1skN
         SQG9RoJPvXt7sUFCoXEY2psX2aLVLENgJaxkVQK6lWPQ5cDrKb4ZOcAA2YdUgWVNGmDI
         YR+rqYK2BnmBOVGpOjiDqLFm2GH26Vl/GBsCLlxa/ckD2BIfCGAXDFdfEqg7vYAlRkOJ
         PvDA==
X-Gm-Message-State: AOJu0YyTNQWPa9RAHes/Hs+11oOU7Xv4G5UTU7lNrz1MCm/n1FPRGfZA
        9qF+RTbgq0TTqSjjM7YLfI3TmpHCBqVp+TcipdI=
X-Google-Smtp-Source: AGHT+IEaPPgupPflU8R86zuD+7wlQveR1k2/ggwNpSfSGhYs/wVLpwaJbU2+nlsyvvQuG0YuKPt60F6hliIU31rjKcI=
X-Received: by 2002:a25:b123:0:b0:da3:ab41:31f3 with SMTP id
 g35-20020a25b123000000b00da3ab4131f3mr3017189ybj.8.1699483887797; Wed, 08 Nov
 2023 14:51:27 -0800 (PST)
MIME-Version: 1.0
References: <20231102231130.13ca0513@pcn112> <CAOMZO5C8wq=72HUqSb9bdQK2ji2zcEKByByovnKzUt6A5H3K8Q@mail.gmail.com>
In-Reply-To: <CAOMZO5C8wq=72HUqSb9bdQK2ji2zcEKByByovnKzUt6A5H3K8Q@mail.gmail.com>
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
Date:   Wed, 8 Nov 2023 23:51:11 +0100
Message-ID: <CAH+2xPBdpYiNRzPP+0Diqrc+GfdJYbiTDheD6n2fb42w65LNFg@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: dts: imx: tqma7: add lm75a sensor (rev. 01xxx)
To:     Fabio Estevam <festevam@gmail.com>
Cc:     =?UTF-8?Q?Jo=C3=A3o_Rodrigues?= <jrodrigues@ubimet.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den fre. 3. nov. 2023 kl. 22.07 skrev Fabio Estevam <festevam@gmail.com>:
>
> [Adding Bruno and Alexander]
>
> On Thu, Nov 2, 2023 at 7:12=E2=80=AFPM Jo=C3=A3o Rodrigues <jrodrigues@ub=
imet.com> wrote:
> >
> > From: Jo=C3=A3o Rodrigues <jrodrigues@ubimet.com>
> >
> > TQMa7x (revision 01xxx) uses a LM75A temperature sensor.
> > The two sensors use different I2C addresses, so we can set both sensors
> > simultaneously.

Hi Jo=C3=A3o,

Looks correct to me and an elegant way of adding support for rev 01xx board=
s.

Reviewed-by: Bruno Thomsen <bruno.thomsen@gmail.com>

After this change the imx7d-flex-concentrator.dts needs to be updated
as it uses TQMa7d rev 02xx boards with something like this:

/* TQMa7d 02xx */
&se97b {
        status =3D "okay";
};

I can send a follow up patch when this change lands.

/Bruno

> >
> > Signed-off-by: Jo=C3=A3o Rodrigues <jrodrigues@ubimet.com>
> > ---
> >  arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi b/arch/arm/boot/=
dts/nxp/imx/imx7-tqma7.dtsi
> > index fe42b0a4683..3fc3130f9de 100644
> > --- a/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
> > +++ b/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
> > @@ -128,11 +128,16 @@ vgen6_reg: vldo4 {
> >                 };
> >         };
> >
> > -       /* NXP SE97BTP with temperature sensor + eeprom */
> > +       /* LM75A temperature sensor, TQMa7x 01xx */
> > +       lm75a: temperature-sensor@48 {
> > +               compatible =3D "national,lm75a";
> > +               reg =3D <0x48>;
> > +       };
> > +
> > +       /* NXP SE97BTP with temperature sensor + eeprom, TQMa7x 02xx */
> >         se97b: temperature-sensor-eeprom@1e {
> >                 compatible =3D "nxp,se97b", "jedec,jc-42.4-temp";
> >                 reg =3D <0x1e>;
> > -               status =3D "okay";
> >         };
> >
> >         /* ST M24C64 */
> > --
> > 2.25.1
> >
