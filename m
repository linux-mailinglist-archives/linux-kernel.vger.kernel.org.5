Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715867A3F4A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 03:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbjIRBqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 21:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236526AbjIRBqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 21:46:40 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FBC128
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 18:46:32 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-59c2ca01f27so16527047b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 18:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695001592; x=1695606392; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GN+ZP7HO00noajf9njN6jgdBrsju6UYYDWypBjncENU=;
        b=yUJSEtlukS4Fxmd6o4eG1oM8+TdJwX6dHWcaqZaJW7R8nybnrrBCVgu3+3+MjToLno
         xHpTAti73edNw1W01OATkWCyspBMGOSGcWHkD8HA53lrSdhw9ihgE9H1b1t6/eeD6WHB
         W8kXD/j8PT1a2nsykKLo6FJrSBownXLfGs78VHitLu3IZhmpHLCjHCx55X1u4QJW8vIk
         StQPntPO2iTnyzyCHLAg8pLgbb7R3ycj4GompH849L0GB5/Nk7hoHyq41shVr98WqsVq
         8nyv4L5YC/eW9JkWjTWqMh+ovKtGRgJgjkegM0opxMN/ph/LE6xxY5NkFHu0F+rNwfd1
         64pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695001592; x=1695606392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GN+ZP7HO00noajf9njN6jgdBrsju6UYYDWypBjncENU=;
        b=fTDSCmuGyklNwsjzv+ojRh8MFfp/XyuJpddBEeKxivAbvPrsB+X2dwkysfscFLKtYE
         WOCUIzG+Bidea0UdK26TGkvToVu0OJKsCd6mQJVXdVpoMQhBUateW2/1vYHCQVT4Ni0s
         o7pM5WPPSd95FyOrGXohuZscZS44OyFyk7RiSXz34ftA0mcrFsfJE9KZMBYWdJIuqtCf
         fWpssScq++PfIFhSLCEn8rIgAkjSrdPAJEoQYCgDO676pqQLI35wppsY8KgSwdOrm53x
         YumS+OEmP3Zg03ruZQNAAJ9WGZCt0qvnI8nZ8NlgivlME8vlZdDPPg0Oem/VABz89JJM
         yC4A==
X-Gm-Message-State: AOJu0YzzqML5UPxAwesLhq5+wN0bKtRzV7NZUkV7ff4J1L9Rzfz1L+A5
        iR02pP6q0o4LbcI1/1KndlIARArddShBJ8CRsXYfug==
X-Google-Smtp-Source: AGHT+IFyyon2ii0QkHQJw/3KC5VRE/P0uqsTDjykAK8zhw2UPsZAy0HTamPa4+DC6onQOC4lZV/moBMVBprp9PLEc4M=
X-Received: by 2002:a81:524e:0:b0:59b:fe73:dec1 with SMTP id
 g75-20020a81524e000000b0059bfe73dec1mr7886346ywb.7.1695001591904; Sun, 17 Sep
 2023 18:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230823091757.31311-1-quic_nitirawa@quicinc.com>
 <20230823091757.31311-3-quic_nitirawa@quicinc.com> <24cff590-c71f-4a30-9b80-fa9a0bd27957@linaro.org>
 <c9719d64-33c1-d13e-0ab6-289011282044@quicinc.com> <CAA8EJppYD8Oq_fkOOKf8_x7RdbjBx7XzV_5y4sKE3ZDv_WV9_Q@mail.gmail.com>
 <68e111ba-9a7b-511a-5765-24b491ad201b@quicinc.com>
In-Reply-To: <68e111ba-9a7b-511a-5765-24b491ad201b@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 18 Sep 2023 04:46:20 +0300
Message-ID: <CAA8EJpr-E=wASYXnsviLTwYEvkzOCDi-m5Nu8v-yV5=xKP5yEg@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] phy: qcom-qmp-ufs: Add Phy Configuration support
 for SC7280
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Manish Pandey <quic_mapa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Sept 2023 at 17:23, Nitin Rawat <quic_nitirawa@quicinc.com> wrote:
>
>
>
> On 9/16/2023 12:03 AM, Dmitry Baryshkov wrote:
> > On Fri, 15 Sept 2023 at 19:14, Nitin Rawat <quic_nitirawa@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 9/6/2023 1:34 AM, Dmitry Baryshkov wrote:
> >>> On 23/08/2023 12:17, Nitin Rawat wrote:
> >>>> Add SC7280 specific register layout and table configs.
> >>>>
> >>>> Co-developed-by: Manish Pandey <quic_mapa@quicinc.com>
> >>>> Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
> >>>> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> >>>> ---
> >>>>    drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 142 ++++++++++++++++++++++++
> >>>>    1 file changed, 142 insertions(+)
> >>>>
> >>>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> >>>> b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> >>>> index 3927eba8e468..514fa14df634 100644
> >>>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> >>>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> >>>
> >>> [skipped tables programming]
> >>>
> >>> 4),
> >> Sorry I quite didn't get this comment. what exactly is skipped ?Please
> >> can you help explain?
> >
> > I skipped them, as I didn't have comments for them.
> >
> >>
> >>
> >>>> @@ -888,6 +993,40 @@ static const struct qmp_phy_cfg
> >>>> sa8775p_ufsphy_cfg = {
> >>>>        .regs            = ufsphy_v5_regs_layout,
> >>>>    };
> >>>>
> >>>> +static const struct qmp_phy_cfg sc7280_ufsphy_cfg = {
> >>>> +    .lanes                  = 2,
> >>>> +
> >>>> +    .offsets                = &qmp_ufs_offsets,
> >>>> +
> >>>> +    .tbls = {
> >>>> +        .serdes         = sm8150_ufsphy_serdes,
> >>>> +        .serdes_num     = ARRAY_SIZE(sm8150_ufsphy_serdes),
> >>>> +        .tx             = sc7280_ufsphy_tx,
> >>>> +        .tx_num         = ARRAY_SIZE(sc7280_ufsphy_tx),
> >>>> +        .rx             = sc7280_ufsphy_rx,
> >>>> +        .rx_num         = ARRAY_SIZE(sc7280_ufsphy_rx),
> >>>> +        .pcs            = sc7280_ufsphy_pcs,
> >>>> +        .pcs_num        = ARRAY_SIZE(sc7280_ufsphy_pcs),
> >>>> +    },
> >>>> +    .tbls_hs_b = {
> >>>> +        .serdes         = sm8150_ufsphy_hs_b_serdes,
> >>>> +        .serdes_num     = ARRAY_SIZE(sm8150_ufsphy_hs_b_serdes),
> >>>> +    },
> >>>> +    .tbls_hs_g4 = {
> >>>> +        .tx             = sm8250_ufsphy_hs_g4_tx,
> >>>> +        .tx_num         = ARRAY_SIZE(sm8250_ufsphy_hs_g4_tx),
> >>>> +        .rx             = sc7280_ufsphy_hs_g4_rx,
> >>>> +        .rx_num         = ARRAY_SIZE(sc7280_ufsphy_hs_g4_rx),
> >>>> +        .pcs            = sm8150_ufsphy_hs_g4_pcs,
> >>>> +        .pcs_num        = ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
> >>>> +    },
> >>>> +    .clk_list               = sm8450_ufs_phy_clk_l,
> >>>> +    .num_clks               = ARRAY_SIZE(sm8450_ufs_phy_clk_l),
> >>>
> >>> This doesn't correspond to the bindings. This array has 3 enries, while
> >>> in the bindings you have opted for two clocks for this PHY.
> >> Sure. I'll update the bindings.
> >
> > Are you sure about the third clock? Neither sm8150 nor sm8250 used the
> > qref clock. Or is that an omission on our side?
> >
>
> Hi Dmitry,
>
> For SC7280 we need all the three clocks for this target. Same is being
> used in downstream code as well. Hence I would need to update the
> binding as well.

Ack, thanks for the confirmation.

>
> Thanks,
> Nitin
>
>
> >>
> >>>
> >>>> +    .vreg_list              = qmp_phy_vreg_l,
> >>>> +    .num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
> >>>> +    .regs                   = ufsphy_v4_regs_layout,
> >>>> +};
> >>>> +
> >>>>    static const struct qmp_phy_cfg sc8280xp_ufsphy_cfg = {
> >>>>        .lanes            = 2,
> >>>>
> >>>> @@ -1648,6 +1787,9 @@ static const struct of_device_id
> >>>> qmp_ufs_of_match_table[] = {
> >>>>        }, {
> >>>>            .compatible = "qcom,sa8775p-qmp-ufs-phy",
> >>>>            .data = &sa8775p_ufsphy_cfg,
> >>>> +    }, {
> >>>> +        .compatible = "qcom,sc7280-qmp-ufs-phy",
> >>>> +        .data = &sc7280_ufsphy_cfg,
> >>>>        }, {
> >>>>            .compatible = "qcom,sc8180x-qmp-ufs-phy",
> >>>>            .data = &sm8150_ufsphy_cfg,
> >>>> --
> >>>> 2.17.1
> >>>>
> >>>
> >> Thanks,
> >> Nitin
> >
> >
> >
--
With best wishes
Dmitry
