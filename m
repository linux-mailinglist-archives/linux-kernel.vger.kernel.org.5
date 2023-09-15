Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DD67A25D8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 20:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbjIOSed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 14:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236554AbjIOSeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:34:12 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBA02710
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 11:34:05 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d8181087dc9so2264964276.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 11:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694802845; x=1695407645; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XAp4QGQYuiB0aBhykrwn9fuo1kSVZeoCYVkl9zEjWE8=;
        b=ZRn2r1NhTF7RYpU9wxUTTfDNoPsm2sCTFXU1/SwBNv25DiPf06YThxVCMV4zUBKCO3
         cRyQwzUXYv4n6sQXFoqqhqUpCcxXv8Nn7Uf9WvoZEiwCAAZ8FIUnap3XKbucbT57CAJF
         rIXOxDqv6tUYiUr4p8YFl5KjPOuZ/rkmVNpWnAlE0w2Eo8bmA345EyQuL9VLWpO1VMVT
         hXIBl0MdO6N1c144hAhtpiGJi5jXaaPE2g1MVc/DILwfFJLW+5h7tvFpOu9cLrpopNVd
         BeMBNPf/5h5KjAjAo4JSTKrLSLN/HazLaTHgY6jyEpjZa2V2wU18gx7tDmfMmZilxyqE
         ihbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694802845; x=1695407645;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XAp4QGQYuiB0aBhykrwn9fuo1kSVZeoCYVkl9zEjWE8=;
        b=CxCDp7fnHtPip/MAzi3A4tNsJbLvsjCe2Bc0i2UqimzuOnormqyCFqa5a64eE4XnM9
         4yMKe+5bhUSIpjo4ZLTMz1ppzKYnvIfK6Hp5l7ot472HVAG0r8DxspmpzOYp4pFDhnaG
         AZPVKUQuFIQZjgmEk2UuLPgYUdknzUa8z8WToNeqy773dS+2ZdPsQi9ZTXOnFThBVzVl
         rLTL9ihcs1kBJphjYPVhvCkO/8aa82EJPfrJ7g5X5jL/NK4BdEmNoeg5h6iAL1/tUIDQ
         iqaM4eZq6Z/ei4jLWjqcYRvWM1d+I1l5OXr3eF2wet2fnCiKYyAKIhKj99wcyUUcQzfW
         KTaw==
X-Gm-Message-State: AOJu0YyvdGaLYIxW5eNHd5B/pHL4mE6H4w4fVul6XTEpbRPSaMfbLcJB
        OAS2UdKMA0/ll+sCLyzmpbV3U9ru3V+yRBoaEOob5Q==
X-Google-Smtp-Source: AGHT+IGz/X+sLYorNmDn+iedwieWtRZ/y9HzEpRRT43OwE+qJPUPdVSjf4sOic9847CsYuYN7WCPMNDqcCWsxExcJ04=
X-Received: by 2002:a25:820e:0:b0:d7b:9a4b:5a72 with SMTP id
 q14-20020a25820e000000b00d7b9a4b5a72mr2312461ybk.31.1694802844944; Fri, 15
 Sep 2023 11:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230823091757.31311-1-quic_nitirawa@quicinc.com>
 <20230823091757.31311-3-quic_nitirawa@quicinc.com> <24cff590-c71f-4a30-9b80-fa9a0bd27957@linaro.org>
 <c9719d64-33c1-d13e-0ab6-289011282044@quicinc.com>
In-Reply-To: <c9719d64-33c1-d13e-0ab6-289011282044@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 15 Sep 2023 21:33:53 +0300
Message-ID: <CAA8EJppYD8Oq_fkOOKf8_x7RdbjBx7XzV_5y4sKE3ZDv_WV9_Q@mail.gmail.com>
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

On Fri, 15 Sept 2023 at 19:14, Nitin Rawat <quic_nitirawa@quicinc.com> wrote:
>
>
>
> On 9/6/2023 1:34 AM, Dmitry Baryshkov wrote:
> > On 23/08/2023 12:17, Nitin Rawat wrote:
> >> Add SC7280 specific register layout and table configs.
> >>
> >> Co-developed-by: Manish Pandey <quic_mapa@quicinc.com>
> >> Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
> >> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> >> ---
> >>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 142 ++++++++++++++++++++++++
> >>   1 file changed, 142 insertions(+)
> >>
> >> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> >> b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> >> index 3927eba8e468..514fa14df634 100644
> >> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> >> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> >
> > [skipped tables programming]
> >
> > 4),
> Sorry I quite didn't get this comment. what exactly is skipped ?Please
> can you help explain?

I skipped them, as I didn't have comments for them.

>
>
> >> @@ -888,6 +993,40 @@ static const struct qmp_phy_cfg
> >> sa8775p_ufsphy_cfg = {
> >>       .regs            = ufsphy_v5_regs_layout,
> >>   };
> >>
> >> +static const struct qmp_phy_cfg sc7280_ufsphy_cfg = {
> >> +    .lanes                  = 2,
> >> +
> >> +    .offsets                = &qmp_ufs_offsets,
> >> +
> >> +    .tbls = {
> >> +        .serdes         = sm8150_ufsphy_serdes,
> >> +        .serdes_num     = ARRAY_SIZE(sm8150_ufsphy_serdes),
> >> +        .tx             = sc7280_ufsphy_tx,
> >> +        .tx_num         = ARRAY_SIZE(sc7280_ufsphy_tx),
> >> +        .rx             = sc7280_ufsphy_rx,
> >> +        .rx_num         = ARRAY_SIZE(sc7280_ufsphy_rx),
> >> +        .pcs            = sc7280_ufsphy_pcs,
> >> +        .pcs_num        = ARRAY_SIZE(sc7280_ufsphy_pcs),
> >> +    },
> >> +    .tbls_hs_b = {
> >> +        .serdes         = sm8150_ufsphy_hs_b_serdes,
> >> +        .serdes_num     = ARRAY_SIZE(sm8150_ufsphy_hs_b_serdes),
> >> +    },
> >> +    .tbls_hs_g4 = {
> >> +        .tx             = sm8250_ufsphy_hs_g4_tx,
> >> +        .tx_num         = ARRAY_SIZE(sm8250_ufsphy_hs_g4_tx),
> >> +        .rx             = sc7280_ufsphy_hs_g4_rx,
> >> +        .rx_num         = ARRAY_SIZE(sc7280_ufsphy_hs_g4_rx),
> >> +        .pcs            = sm8150_ufsphy_hs_g4_pcs,
> >> +        .pcs_num        = ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
> >> +    },
> >> +    .clk_list               = sm8450_ufs_phy_clk_l,
> >> +    .num_clks               = ARRAY_SIZE(sm8450_ufs_phy_clk_l),
> >
> > This doesn't correspond to the bindings. This array has 3 enries, while
> > in the bindings you have opted for two clocks for this PHY.
> Sure. I'll update the bindings.

Are you sure about the third clock? Neither sm8150 nor sm8250 used the
qref clock. Or is that an omission on our side?

>
> >
> >> +    .vreg_list              = qmp_phy_vreg_l,
> >> +    .num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
> >> +    .regs                   = ufsphy_v4_regs_layout,
> >> +};
> >> +
> >>   static const struct qmp_phy_cfg sc8280xp_ufsphy_cfg = {
> >>       .lanes            = 2,
> >>
> >> @@ -1648,6 +1787,9 @@ static const struct of_device_id
> >> qmp_ufs_of_match_table[] = {
> >>       }, {
> >>           .compatible = "qcom,sa8775p-qmp-ufs-phy",
> >>           .data = &sa8775p_ufsphy_cfg,
> >> +    }, {
> >> +        .compatible = "qcom,sc7280-qmp-ufs-phy",
> >> +        .data = &sc7280_ufsphy_cfg,
> >>       }, {
> >>           .compatible = "qcom,sc8180x-qmp-ufs-phy",
> >>           .data = &sm8150_ufsphy_cfg,
> >> --
> >> 2.17.1
> >>
> >
> Thanks,
> Nitin



-- 
With best wishes
Dmitry
