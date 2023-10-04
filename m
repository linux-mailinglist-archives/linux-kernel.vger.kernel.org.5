Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608017B7ED9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242311AbjJDMPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbjJDMPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:15:46 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062E0A1;
        Wed,  4 Oct 2023 05:15:43 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5859b06509cso1404264a12.2;
        Wed, 04 Oct 2023 05:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696421742; x=1697026542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4giBNd39dk0FzKD/nLSuY8CIxKBu7ZMBGsAWAOjFNuQ=;
        b=j86Zff6+FW5jSkvVhYzXSomqSIzqANHU5ShrQecPnXwiLaJOREx/RtLggwWw9knQ3u
         OcIaiU9Nl84bDjB/Z3LQ6+vVusTJbtc1Cvv8GR2iqEZa8Nci+BqHRbLSG6W9EwMF588I
         gd+24Q8Xdwm4MnnMCs6bfy2jy+hkv9+s1kioStKYM0vSHAK1rNF89+UEoIPLxovc83Iu
         hMorQ9iCxasvfshSTD90ApkgyBeB9wqjryTAq/m0WId9avWumVdmESJFv3NYK7cw0y3d
         mL4C2MvqjaifDRZo4GKfC3PRDFyrfQnIZ4bNT8TAXEdtLzsDtjSaayRRDFrk4EydXVal
         YDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696421742; x=1697026542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4giBNd39dk0FzKD/nLSuY8CIxKBu7ZMBGsAWAOjFNuQ=;
        b=J+zkHmvO0Hxpb1TO2Blazb8Qh2V7MM88WB1oBCWbaujedIr56mqWWBOW0xMzDn6aY9
         DcvG5aZkxEnEpIKYWyS6eslfPk3CclE/YGcWj0k2IDR6CKYqPCBc411nt2pedz3WhUnA
         DmD8HdMI/FTuqA9juxt8rBzo3IR2nKGlONCKJ1riSyq8WAM+2p2ahvXgXrb4S8ZV26ax
         kN3N0UgSIhRDGcFYvaKZYznuprtASiDY+1Wdy53ApJG6cylkf+cWtznjjxRGnOlZ3G2A
         QI43FbV2POVfzVUBKnSZKBi4Ss81Faq+Auy/y6OBqdhKh3N6vOVO7XwYrGOT0TMMk/ZQ
         i6uA==
X-Gm-Message-State: AOJu0YxMstJWRcgfTPnwUJ6nqCiwLgUky6Fa0uwlepQ5GqpG0q/30AST
        i5TJYE0pF8a3qHN3DPZ9L2HVop6T/2ds+fYBvjaYhg3k
X-Google-Smtp-Source: AGHT+IHpGLrw+FW27qMuwyN096JOkfzCeLmiQELADbhINgTOrUv+G+Slf5JmJK26zur239okf9jmcxlor49kJxvS8co=
X-Received: by 2002:a17:90b:1bc7:b0:26d:4ab3:fe11 with SMTP id
 oa7-20020a17090b1bc700b0026d4ab3fe11mr1774905pjb.24.1696421742135; Wed, 04
 Oct 2023 05:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230831044431.250338-1-aford173@gmail.com> <20230831044431.250338-2-aford173@gmail.com>
 <CAOMZO5DyZJuqYswLYhf1f3zP7Rc1ZhnPfq26dpyU2m5mhvRtVw@mail.gmail.com>
In-Reply-To: <CAOMZO5DyZJuqYswLYhf1f3zP7Rc1ZhnPfq26dpyU2m5mhvRtVw@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 4 Oct 2023 07:15:30 -0500
Message-ID: <CAHCN7xLxsKPp2LpeDXg8_63W17Qn28i2y72GfhScSFOLG7Re_A@mail.gmail.com>
Subject: Re: [PATCH V3 2/3] arm64: dts: imx8mp: Add micfil node
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, marex@denx.de,
        aford@beaconembedded.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 8:12=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> Hi Adam and devicetree folks,
>
> On Thu, Aug 31, 2023 at 1:44=E2=80=AFAM Adam Ford <aford173@gmail.com> wr=
ote:
> >
> > The i.MX8MP has a micfil controller which is used for interfacing
> > with a pulse density microphone. Add the node and mark it as
> > disabled by default.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> > V3:  The AUDIOMIX_PDM_ROOT doesn't exist and the real clock is
> >      called IMX8MP_CLK_AUDIOMIX_PDM_SEL, so swap it out.
> >
> > V2:  No change
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boo=
t/dts/freescale/imx8mp.dtsi
> > index 3167706d81e1..341fd0369ce9 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > @@ -1479,6 +1479,27 @@ easrc: easrc@30c90000 {
> >                                         fsl,asrc-format =3D <2>;
> >                                         status =3D "disabled";
> >                                 };
> > +
> > +                               micfil: audio-controller@30ca0000 {
> > +                                       compatible =3D "fsl,imx8mp-micf=
il";
> > +                                       reg =3D <0x30ca0000 0x10000>;
> > +                                       #sound-dai-cells =3D <0>;
>
> After this patch, the following schema warning is seen:
>
> imx8mp-beacon-kit.dtb: audio-controller@30ca0000: '#sound-dai-cells'
> does not match any of the regexes: 'pinctrl-[0-9]+'
> from schema $id: http://devicetree.org/schemas/sound/fsl,micfil.yaml#
>
> What is the correct way to solve this?
>
> - Document #sound-dai-cells in fsl,micfil.yaml as an optional property
> - Remove #sound-dai-cells from imx8mp.dtsi
> - Document #sound-dai-cells in fsl,micfil.yaml as a required property
> and pass #sound-dai-cells to imx8mm/imx8mn/imx83.dtsi?

I am not an expert on yaml, in fact they quite confuse me, but I
believe the proper solution is likely to document them in the yaml.
When I built the device tree without the sound-dai-cells, it threw a
message indicating that it needed to be there when it is configured to
operate.  I didn't see the schema warning that you noted, but my
schema could have been out of date.  Looking at the sai nodes and the
yaml file, it appears that the sound-dai-cells is listed in the yaml.

adam
