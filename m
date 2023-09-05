Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9057A792F6F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242358AbjIEUEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235857AbjIEUEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:04:13 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707E2F9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 13:04:08 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52713d2c606so4134943a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 13:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693944247; x=1694549047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QBRdKdZ5WjyqUvk4N5iiue5qAMVDhesOYviouHViHm8=;
        b=TUHm+qjovsdPN2E3Adwo/yktErFumDH6P6f/f40ijMLcZXyfbEG/vyHHGTuW4/gDIs
         6K0uhfoeaj1BeWJDj8dtkrG4pzRBC5r5k/wVC43xTuSbvvdMqaxXuqHqCoKs7BQYjtqd
         1bhpvdFspGK74V5ObAdT3aYNZIVexZMfUJnzS+B2Ly84hIqmDM6o43N+RMdjsdES4JDA
         dp/P5McKZSLeidDMpmHWO80Ua6Ap5Wm2QfvsolUyFPIZxbFiFt0Nm7Ya/BImw3NAdK6y
         HI9G24UurrkgXIPBRCxvSbXuRatAd2kNTLMfqYc6xTcj66G5fI+wC8+vuTjkvEXFrAkM
         FJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693944247; x=1694549047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QBRdKdZ5WjyqUvk4N5iiue5qAMVDhesOYviouHViHm8=;
        b=iOqOEr4VIF91j5mzzR0ItUZCP/hwVjGtBtAsLcb0Cbp6oxk1YspVCdwjRBC1lLPdz8
         cNZAWHg6mlGn98mBSSmSKDapzDNbokXAZDb9zWPRCi0mTtyvLIQWMxtA4xx24uY42JYk
         JJ7z5AxGw3wPkcpwtwO8j4k5xYLYt7YoKA0jxBqC1airKVFV6UrrVq+y/6NN8zCoOkj9
         mThbpkNd1SZ26Ho7vvW1pPot3M76KBKjRyiPouumShnlHKoG47Qbs8RzB4y2XLbu4qFG
         V4ofQxDejD6fdVC7BFcG2fu3zxNrkl3uPy9uCTA+iD5Ze9IxQGLn1Y2mPDT/hSYwdeL8
         2Tdg==
X-Gm-Message-State: AOJu0YwYSjtqKa3ZSMcVPex14n9lrZdlkt+RbUB9BShQELS8qydb5Pxh
        wBtbWbrus/0gmFRKVTZR1E5hmQ==
X-Google-Smtp-Source: AGHT+IGhdAXPegcUWCc02b5OC+h0Y/iNRrXwmMGd44XlfKvdJU2O+zod90kkDBW2NHAgsqakJsk5ow==
X-Received: by 2002:aa7:dcd2:0:b0:52c:164:efe5 with SMTP id w18-20020aa7dcd2000000b0052c0164efe5mr566620edu.39.1693944246854;
        Tue, 05 Sep 2023 13:04:06 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id w26-20020a50fa9a000000b0052a401d8ef6sm7562829edr.71.2023.09.05.13.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 13:04:06 -0700 (PDT)
Message-ID: <24cff590-c71f-4a30-9b80-fa9a0bd27957@linaro.org>
Date:   Tue, 5 Sep 2023 23:04:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/2] phy: qcom-qmp-ufs: Add Phy Configuration support
 for SC7280
Content-Language: en-GB
To:     Nitin Rawat <quic_nitirawa@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Manish Pandey <quic_mapa@quicinc.com>
References: <20230823091757.31311-1-quic_nitirawa@quicinc.com>
 <20230823091757.31311-3-quic_nitirawa@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230823091757.31311-3-quic_nitirawa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2023 12:17, Nitin Rawat wrote:
> Add SC7280 specific register layout and table configs.
> 
> Co-developed-by: Manish Pandey <quic_mapa@quicinc.com>
> Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 142 ++++++++++++++++++++++++
>   1 file changed, 142 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> index 3927eba8e468..514fa14df634 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c

[skipped tables programming]

4),
> @@ -888,6 +993,40 @@ static const struct qmp_phy_cfg sa8775p_ufsphy_cfg = {
>   	.regs			= ufsphy_v5_regs_layout,
>   };
> 
> +static const struct qmp_phy_cfg sc7280_ufsphy_cfg = {
> +	.lanes                  = 2,
> +
> +	.offsets                = &qmp_ufs_offsets,
> +
> +	.tbls = {
> +		.serdes         = sm8150_ufsphy_serdes,
> +		.serdes_num     = ARRAY_SIZE(sm8150_ufsphy_serdes),
> +		.tx             = sc7280_ufsphy_tx,
> +		.tx_num         = ARRAY_SIZE(sc7280_ufsphy_tx),
> +		.rx             = sc7280_ufsphy_rx,
> +		.rx_num         = ARRAY_SIZE(sc7280_ufsphy_rx),
> +		.pcs            = sc7280_ufsphy_pcs,
> +		.pcs_num        = ARRAY_SIZE(sc7280_ufsphy_pcs),
> +	},
> +	.tbls_hs_b = {
> +		.serdes         = sm8150_ufsphy_hs_b_serdes,
> +		.serdes_num     = ARRAY_SIZE(sm8150_ufsphy_hs_b_serdes),
> +	},
> +	.tbls_hs_g4 = {
> +		.tx             = sm8250_ufsphy_hs_g4_tx,
> +		.tx_num         = ARRAY_SIZE(sm8250_ufsphy_hs_g4_tx),
> +		.rx             = sc7280_ufsphy_hs_g4_rx,
> +		.rx_num         = ARRAY_SIZE(sc7280_ufsphy_hs_g4_rx),
> +		.pcs            = sm8150_ufsphy_hs_g4_pcs,
> +		.pcs_num        = ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
> +	},
> +	.clk_list               = sm8450_ufs_phy_clk_l,
> +	.num_clks               = ARRAY_SIZE(sm8450_ufs_phy_clk_l),

This doesn't correspond to the bindings. This array has 3 enries, while 
in the bindings you have opted for two clocks for this PHY.

> +	.vreg_list              = qmp_phy_vreg_l,
> +	.num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
> +	.regs                   = ufsphy_v4_regs_layout,
> +};
> +
>   static const struct qmp_phy_cfg sc8280xp_ufsphy_cfg = {
>   	.lanes			= 2,
> 
> @@ -1648,6 +1787,9 @@ static const struct of_device_id qmp_ufs_of_match_table[] = {
>   	}, {
>   		.compatible = "qcom,sa8775p-qmp-ufs-phy",
>   		.data = &sa8775p_ufsphy_cfg,
> +	}, {
> +		.compatible = "qcom,sc7280-qmp-ufs-phy",
> +		.data = &sc7280_ufsphy_cfg,
>   	}, {
>   		.compatible = "qcom,sc8180x-qmp-ufs-phy",
>   		.data = &sm8150_ufsphy_cfg,
> --
> 2.17.1
> 

-- 
With best wishes
Dmitry

