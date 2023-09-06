Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7B97934F7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 07:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240449AbjIFFln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 01:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234458AbjIFFlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 01:41:42 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A78012A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 22:41:38 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-58caaedb20bso33565577b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 22:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693978897; x=1694583697; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=848Yrlbrn3zuIhwn1wjj9hZ6f3Wq+iwxUd4Va25dFlA=;
        b=GmNSjs3iai+9toV9KtWFj+P3o8VYppW2tyIEviK3zvJjaW9upmL8iOut+FYn8ZCgz1
         w57kzoz4uKCxolJ8zofHQedyHAvN98bDxnCdc1aYZQv7BMkMyoP2aUBqi/bw/J6e7DF2
         oda1eK9tc8/2/J1iiJp+7SNPrwJxemoB+/UMg5lBJPcbLUr0o2jnpMkM1vlY1ACk14eD
         bnrJQBMn8NLeygJe71BgK+3Vb3xjmrZdG7ldQ5t8p+9FM1dxvoe8XII4GV0EOLkqkAOt
         sL4kWWmzzOuTsadJy1jbT16y5E+54b0OHckGYVPykL1gk4wbOuX/mtM0bF2FMhIYAxGl
         EtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693978897; x=1694583697;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=848Yrlbrn3zuIhwn1wjj9hZ6f3Wq+iwxUd4Va25dFlA=;
        b=hj5jdV6ukxxH8ZqCAF5S5Pagyhv3HZz3H6mG8/CnDKEPx0l3zHFUBuE30EgRCiaLhQ
         93yb12Mm0N0qewPnMu9yDyXM2jXT4bJs4d7uQJowKnWO/9a7PC199H+Lsf/+wwNie9d/
         3/ewaFBF02/dFYNv7DqjVE+gFey/8aqt3ayHhBOdnxAZYN+dgOZScn5SHuuSBhKxYiwx
         zBRieCf11w4+pcURci3hyywIRK8RaBzHZZqjGfQFbj2bSzaFj1YvYclGBcZlaqVAlDpn
         LzolvnOCelgZs+cNDO0w06GAnQWZEtRkf/aX0pOyqOVRGjeUaal9hVrvlcanJYXClUQL
         cXiw==
X-Gm-Message-State: AOJu0YwnzxgIq4y6a0iwjd3lPLxVTv2fT6qd/AHCiOpZiIH4C7GYmAmv
        MitCo9Oxs+6hzmiH1quma2D6inIhqrJe4PVUt1cn0w==
X-Google-Smtp-Source: AGHT+IEp7u7PxVnFYoBuUpVIZhrA9XdvWG3pmhHSaNZy5pGYSfonmCi7U45WvDqyuJfiK9WMmFqrkn927tIhzrbY9zw=
X-Received: by 2002:a05:6902:120e:b0:d74:66aa:a277 with SMTP id
 s14-20020a056902120e00b00d7466aaa277mr17965799ybu.65.1693978897644; Tue, 05
 Sep 2023 22:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <1693909838-6682-1-git-send-email-quic_rohiagar@quicinc.com>
 <1693909838-6682-6-git-send-email-quic_rohiagar@quicinc.com>
 <8aefd8f9-cfe9-4011-a24b-ebb13d28faa0@linaro.org> <0d76f851-ef7a-2d09-a344-9ec31ba581a5@quicinc.com>
In-Reply-To: <0d76f851-ef7a-2d09-a344-9ec31ba581a5@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 6 Sep 2023 08:41:26 +0300
Message-ID: <CAA8EJprS3vxQbOGZnsipRGi4MiyZj3X5HpMan3Q6Z732aWfJ_g@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] phy: qcom-qmp-usb: Add Qualcomm SDX75 USB3 PHY support
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, abel.vesa@linaro.org,
        quic_wcheng@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Sept 2023 at 08:35, Rohit Agarwal <quic_rohiagar@quicinc.com> wrote:
>
>
> On 9/6/2023 2:08 AM, Dmitry Baryshkov wrote:
> > On 05/09/2023 13:30, Rohit Agarwal wrote:
> >> Add support for USB3 QMP PHY found in SDX75 platform.
> >>
> >> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> >> ---
> >>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 158
> >> ++++++++++++++++++++++++++++++++
> >>   1 file changed, 158 insertions(+)
> >>
> >> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> >> b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> >> index 0130bb8..57b8b5b 100644
> >> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> >> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> >> @@ -23,6 +23,7 @@
> >>   #include "phy-qcom-qmp-pcs-misc-v3.h"
> >>   #include "phy-qcom-qmp-pcs-usb-v4.h"
> >>   #include "phy-qcom-qmp-pcs-usb-v5.h"
> >> +#include "phy-qcom-qmp-pcs-usb-v6.h"
> >>     /* QPHY_SW_RESET bit */
> >>   #define SW_RESET                BIT(0)
> >> @@ -858,6 +859,134 @@ static const struct qmp_phy_init_tbl
> >> sdx65_usb3_uniphy_rx_tbl[] = {
> >
> > [skipped the tables]
> >
> >> @@ -1556,6 +1685,32 @@ static const struct qmp_phy_cfg
> >> sdx65_usb3_uniphy_cfg = {
> >>       .has_pwrdn_delay    = true,
> >>   };
> >>   +static const struct qmp_phy_cfg sdx75_usb3_uniphy_cfg = {
> >> +    .lanes            = 1,
> >> +    .offsets        = &qmp_usb_offsets_v5,
> >
> > v6?
> Since the offsets for v5 and v6 are same, I did not introduce a new
> struct with the same values.
> Please correct me if I have to introduce v6 offsets.

If the offsets are the same, it's fine to leave at v5.

> >
> >> +
> >> +    .serdes_tbl        = sdx75_usb3_uniphy_serdes_tbl,
> >> +    .serdes_tbl_num        = ARRAY_SIZE(sdx75_usb3_uniphy_serdes_tbl),
> >> +    .tx_tbl            = sdx75_usb3_uniphy_tx_tbl,
> >> +    .tx_tbl_num        = ARRAY_SIZE(sdx75_usb3_uniphy_tx_tbl),
> >> +    .rx_tbl            = sdx75_usb3_uniphy_rx_tbl,
> >> +    .rx_tbl_num        = ARRAY_SIZE(sdx75_usb3_uniphy_rx_tbl),
> >> +    .pcs_tbl        = sdx75_usb3_uniphy_pcs_tbl,
> >> +    .pcs_tbl_num        = ARRAY_SIZE(sdx75_usb3_uniphy_pcs_tbl),
> >> +    .pcs_usb_tbl        = sdx75_usb3_uniphy_pcs_usb_tbl,
> >> +    .pcs_usb_tbl_num    = ARRAY_SIZE(sdx75_usb3_uniphy_pcs_usb_tbl),
> >> +    .clk_list        = qmp_v4_sdx55_usbphy_clk_l,
> >> +    .num_clks        = ARRAY_SIZE(qmp_v4_sdx55_usbphy_clk_l),
> >> +    .reset_list        = msm8996_usb3phy_reset_l,
> >> +    .num_resets        = ARRAY_SIZE(msm8996_usb3phy_reset_l),
> >
> > Clocks and resets are gone in
> > https://lore.kernel.org/linux-phy/20230824211952.1397699-1-dmitry.baryshkov@linaro.org/
> >
> Sure.
> >> +    .vreg_list        = qmp_phy_vreg_l,
> >> +    .num_vregs        = ARRAY_SIZE(qmp_phy_vreg_l),
> >> +    .regs            = qmp_v5_usb3phy_regs_layout,
> >
> > This must be v6, if the rest of the PHY is using v6 register names.
> Same, Shall I introduce v6 struct?

Yes. Otherwise it becomes hard to add offsets for different versions.
Generic rule: the name of the struct should match the Vn found in the
register names inside.

>
> Thanks,
> Rohit.
> >
> >> +    .pcs_usb_offset        = 0x1000,
> >> +
> >> +    .has_pwrdn_delay    = true,
> >> +};
> >> +
> >>   static const struct qmp_phy_cfg sm8350_usb3_uniphy_cfg = {
> >>       .lanes            = 1,
> >>   @@ -2256,6 +2411,9 @@ static const struct of_device_id
> >> qmp_usb_of_match_table[] = {
> >>           .compatible = "qcom,sdx65-qmp-usb3-uni-phy",
> >>           .data = &sdx65_usb3_uniphy_cfg,
> >>       }, {
> >> +        .compatible = "qcom,sdx75-qmp-usb3-uni-phy",
> >> +        .data = &sdx75_usb3_uniphy_cfg,
> >> +    }, {
> >>           .compatible = "qcom,sm6115-qmp-usb3-phy",
> >>           .data = &qcm2290_usb3phy_cfg,
> >>       }, {
> >



-- 
With best wishes
Dmitry
