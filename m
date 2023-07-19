Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741D9759F47
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjGSUF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjGSUFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:05:19 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DEF213D;
        Wed, 19 Jul 2023 13:05:12 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1baf02c36e0so25975fac.2;
        Wed, 19 Jul 2023 13:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689797111; x=1692389111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzA46Lk2UXF11sprTNDhbjiZv+TKiXPilVyGd/tnrZs=;
        b=qo+h+TGhjzhpvyATm8i6Z9UqhupRzO1vwYEMVJGZ3+fWc+AvzxBwJ8Ayiv58L/wSWy
         H4lbuzsN6JTwUBlCjEz8lYcfOkraayGve9ULbNxwS46A7Cd7GtOJD4zxu6UDCAK4GbW7
         0tb7oWnlKZBuFtWj102mIroQ/oyIPlqyiSUvGweXt1A5mYSAxhwATnmDTktYNSfFMszw
         4bsQo2LtBzaIFQUmDkylP80wB0q4TmvBXxJgRseELbdn7V1WEL/cQZGzH3WyxchDhAG7
         GjxkskISt6wdp2tepe/SmtBDx6xxkDZosq8qyFTz0Ru2th1kIVNZ2sTgziodBLsscg+z
         LOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689797111; x=1692389111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzA46Lk2UXF11sprTNDhbjiZv+TKiXPilVyGd/tnrZs=;
        b=UKIkFMf9u4Zgdj7sMJlonpDZAOz1e0diRM2khwbzuSeam8Y3GPonf6SjJTtmud+3xQ
         9SDdONinW0rxj8B9Your8WnchlbDXVuqu72W68C29oxjcZHoDZRTfVxbNClcnugY1lXP
         4Bd90Fe9kXbfCMVqrOzYTyp3Lc6LdOFiVy4Nu6X88CtbO0Q/wKyadx8KW5NtLBDnDgc4
         aEpbUHEPyTMKsWfR4/lLBhhw8lTl7+zXbbhqoyYdNgEk/WztLRld3YcJFwHKPqghlerb
         pU0znNInW1lmx6LQsd2VdyqF88+A22gw0mSQqYkOLhYPS9BByMr7uk3OmXufuaYnheKa
         T8ag==
X-Gm-Message-State: ABy/qLZ3kZX0VqWSrREQUXglD4xbcSO6IObiMhWOToGHZE4iwGnp+RZt
        xmtpOcKjl8v9sgWmCSdZ3E4hoFaeoTmvOfU/3bM=
X-Google-Smtp-Source: APBJJlHAlTSJ110yNHkRqVUIwD0OPnA3aK9Ibuy17pZQK3cmfgDVCyDcL1GULmIlB2lGI2LeDhV5iPaInFr29yZEVJk=
X-Received: by 2002:a05:6870:5493:b0:1ba:6180:ff47 with SMTP id
 f19-20020a056870549300b001ba6180ff47mr3702650oan.21.1689797111224; Wed, 19
 Jul 2023 13:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230719160048.2737423-1-james.hilliard1@gmail.com>
 <20230719160048.2737423-2-james.hilliard1@gmail.com> <CAOMZO5C_BFm+P=9uizL0buSJ9a33PM6hNgG5OcZ3B4YxD=h_6w@mail.gmail.com>
In-Reply-To: <CAOMZO5C_BFm+P=9uizL0buSJ9a33PM6hNgG5OcZ3B4YxD=h_6w@mail.gmail.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Wed, 19 Jul 2023 14:04:58 -0600
Message-ID: <CADvTj4ptXGo8bcZ65hq-JzOpJdwsV1JwTO8c-=ziLtbeZD4A=Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx6q: Add Variscite MX6 Custom board support
To:     Fabio Estevam <festevam@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 1:32=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi James,
>
> On Wed, Jul 19, 2023 at 1:01=E2=80=AFPM James Hilliard
> <james.hilliard1@gmail.com> wrote:
> >
> > This patch adds support for the Variscite MX6 SoM Carrier Board.
> >
> > This Carrier-Board has the following :
> > - LVDS interface for the VLCD-CAP-GLD-LVDS 7" LCD 800 x 480 touch displ=
ay
> > - HDMI Connector
> > - USB Host + USB OTG Connector
> > - 10/100/1000 Mbps Ethernet
> > - miniPCI-Express slot
> > - SD Card connector
> > - Audio Headphone/Line In jack connectors
> > - S-ATA
> > - On-board DMIC
> > - RS485 Header
> > - CAN bus header
> > - SPI header
> > - Camera Interfaces header
> > - OnBoard RTC with Coin Backup battery socket
> > - RS232 Debug Header (IDC10)
> > - RS232 DTE
>
> Good, but what exactly has been tested?

Well so far the basics such as the screen/networking and such seem to work.

Tested with:
https://www.variscite.com/product/evaluation-kits/var-som-mx6-kits/
Part number VAR-DVK-MX6_V2-PRO

As well as another custom PCB with a very similar design using the SOM.

>
> > Product Page : https://www.variscite.com/product/single-board-computers=
/var-mx6customboard
> >
> > The dts file based on the ones provided by Variscite on their own
> > kernel, but adapted for mainline.
> >
> > Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> Is this patch from you or Gregory? If Gregory is the author, then his
> name should appear in the From: line.

It's from me, the original(seemingly abandoned) patch was from Gregory on t=
he
mailing list which I have been attempting to clean up.

>
> > +&iomuxc {
> > +       imx6qdl-var-som-mx6 {
>
> This ' imx6qdl-var-som-mx6' should be dropped.
>
> > +
> > +               pinctrl_ipu1: ipu1grp {
> > +                       fsl,pins =3D <
> > +                               MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_=
CLK      0x10
> > +                               MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15   =
         0x10
> > +                               MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02    =
         0x10
> > +                               MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03    =
         0x10
> > +                               MX6QDL_PAD_DI0_PIN4__IPU1_DI0_PIN04    =
         0x80000000
>
> No 0x80000000 please. Use the real pad ctl value instead.
> This applies globally.
>
> &mipi_csi {
> > +       status =3D "okay";
> > +       ipu_id =3D <0>;
> > +       csi_id =3D <1>;
> > +       v_channel =3D <0>;
> > +       lanes =3D <2>;
>
> These are all NXP vendor devicetree properties. They do not exist upstrea=
m.
>
> > +       lvds-channel@0 {
> > +               fsl,data-mapping =3D "spwg";
> > +               fsl,data-width =3D <24>;
> > +               status =3D "okay";
> > +               primary;
>
> This property does not exist upstream.
>
> > +       lvds-channel@1 {
> > +               fsl,data-mapping =3D "spwg";
> > +               fsl,data-width =3D <24>;
> > +               status =3D "okay";
> > +               primary;
>
> Ditto.
>
> > +&usbphy1 {
> > +       tx-d-cal =3D <0x5>;
>
> In upstream it is called fsl,tx-d-cal.
>
> > +};
> > +
> > +&usbphy2 {
> > +       tx-d-cal =3D <0x5>;
>
> Ditto.
