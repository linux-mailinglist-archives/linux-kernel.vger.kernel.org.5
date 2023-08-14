Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5867277B7C5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjHNLtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHNLtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:49:19 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BADF1AA;
        Mon, 14 Aug 2023 04:49:18 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5657add1073so1714461a12.0;
        Mon, 14 Aug 2023 04:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692013758; x=1692618558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTPbXj2Uxmh/ZQx99D0srNo3oDkeQJHs+MeKAMMuYew=;
        b=XmULyqyZJX48s0XpgxEHZX32tPmDo+LICgRH7lBo7TOk/Zf6l7D0ldoeVwuTmmXKQ9
         oNGcRyJamj8OZ3b9pVV8mlAwpRQWIYKiKKGQLBRZP3BzMOps89lKN04WPcAcAGdRs6li
         1rWGw59je9t7H4jl/Exbwyvet5ESH0/RcYH0YJSJs1qK6k7XHitrCbq2TC/e8TMfBYVq
         je5Jiq8yUCFCaubVxgUyPxMQlxr15VmZHmUUOM3X1s+t2mv1RgmG8Ufmyi7KU7S1PGyC
         kGdzF4/MQsaakAJbei0Eqt9fZz+i4DuJoTSluZhKJxBmQDLLp5RWl3eQl62wa3VfpI4w
         pUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692013758; x=1692618558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTPbXj2Uxmh/ZQx99D0srNo3oDkeQJHs+MeKAMMuYew=;
        b=QI5uemoQj+KLh+CYFAbGxf2ELEwpuT48/LRxdUFozR+vlC2i+ndmhlMxQH7u8LNLcS
         EwzJKx04RE2b2gEFvHGYdu/KyF1lbDvjoFMOj/3iRDy0rE0Fy/JuyfrY9zqNxbxyY5F6
         f6PyJN0srkLxRr7X1leY5D8p2VJ7QAnmvqcaCHvO90vdhqCtTB2jYJ9peOrVjY0iUS/B
         hhpjmBK+yqwzBXGKHdmEe6UymWJdDCM+fwEvViURKlGE03pvIZUqyYqek1ShEMiEcGjo
         ub5Eh18Q9cYonCmvgtUWoyfyotarPuTKT+qNpXeFHoucJDNYw/4H7ZtULWOklH0SwnFg
         QmuA==
X-Gm-Message-State: AOJu0YzAq8O/L87kLkOu3J6HxQcOwjhZBcAD7YAz92ws0sEj7ELOoXXC
        v+igmcV+msN5Yqlnh3QfqnOtQFv9QF9hRTTcR4Q=
X-Google-Smtp-Source: AGHT+IGzs05rP2gaON/RJotGpSnz4dC5IpedGF2UWU9SvBHkLXR4J7HKk7ufGFIZ9/eJn9zDN0/0pgvThR7AKyygWOM=
X-Received: by 2002:a17:90a:a0f:b0:267:fe88:f2f3 with SMTP id
 o15-20020a17090a0a0f00b00267fe88f2f3mr16343354pjo.15.1692013757821; Mon, 14
 Aug 2023 04:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230813162906.22640-1-aford173@gmail.com> <c08784a0a1412d5843cf97b992efb17e1dc602b7.camel@pengutronix.de>
In-Reply-To: <c08784a0a1412d5843cf97b992efb17e1dc602b7.camel@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 14 Aug 2023 06:49:06 -0500
Message-ID: <CAHCN7xKysFVRq0gkp8+VG_NNs1cijacbeDs4D2JDcZ-RucGUBw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mp: Fix SDMA2/3 clocks
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 3:22=E2=80=AFAM Lucas Stach <l.stach@pengutronix.de=
> wrote:
>
> Am Sonntag, dem 13.08.2023 um 11:29 -0500 schrieb Adam Ford:
> > A previous patch to remove the Audio clocks from the main clock node
> > was intended to force people to setup the audio PLL clocks per board
> > instead of having a common set of rates since not all boards may use
> > the various audio PLL clocks for audio devices.
> >
> > Unfortunately, with this parenting removed, the SDMA2 and SDMA3
> > clocks were slowed to 24MHz because the SDMA2/3 clocks are controlled
> > via the audio_blk_ctrl which is clocked from IMX8MP_CLK_AUDIO_ROOT,
> > and that clock is enabled by pgc_audio.
> >
> > Per the TRM, "The SDMA2/3 target frequency is 400MHz IPG and 400MHz
> > AHB, always 1:1 mode, to make sure there is enough throughput for all
> > the audio use cases."
> >
> > Instead of cluttering the clock node, place the clock rate and parent
> > information into the pgc_audio node.
> >
> > With the parenting and clock rates restored for  IMX8MP_CLK_AUDIO_AHB,
> > and IMX8MP_CLK_AUDIO_AXI_SRC, it appears the SDMA2 and SDMA3 run at
> > 400MHz again.
> >
> Note that 800MHz for the AXI clock is overdrive mode for the chip. For
> other i.MX8M* chips we tried to have the nominal drive rates as
> assigned rates in DT. With the i.MX8MP it's currently a wild mix and
> most of the AXI clocks are set to OD rates, so I won't reject this
> patch based on this.
>
> Most boards run the DRAM at DDR4-4000, which already requires OD
> voltages, so there isn't much point in trying to stick to ND rates on
> those boards. We should probably do some consolidation here and come up
> with a proper policy for the i.MX8MP soon.

I didn't realize 800MHz was OD.  I just set it to the rate that it was
before the previous patch.  I think the defaults should be ND, and let
boards who need OD set them.  Unless someone objects, I'll submit a
V2.

adam
>
> > Fixes: 16c984524862 ("arm64: dts: imx8mp: don't initialize audio clocks=
 from CCM node")
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
>
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boo=
t/dts/freescale/imx8mp.dtsi
> > index 6f2f50e1639c..408b0c4ec4f8 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > @@ -790,6 +790,12 @@ pgc_audio: power-domain@5 {
> >                                               reg =3D <IMX8MP_POWER_DOM=
AIN_AUDIOMIX>;
> >                                               clocks =3D <&clk IMX8MP_C=
LK_AUDIO_ROOT>,
> >                                                        <&clk IMX8MP_CLK=
_AUDIO_AXI>;
> > +                                             assigned-clocks =3D <&clk=
 IMX8MP_CLK_AUDIO_AHB>,
> > +                                                               <&clk I=
MX8MP_CLK_AUDIO_AXI_SRC>;
> > +                                             assigned-clock-parents =
=3D  <&clk IMX8MP_SYS_PLL1_800M>,
> > +                                                                      =
 <&clk IMX8MP_SYS_PLL1_800M>;
> > +                                             assigned-clock-rates =3D =
<400000000>,
> > +                                                                    <8=
00000000>;
> >                                       };
> >
> >                                       pgc_gpu2d: power-domain@6 {
>
