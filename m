Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157D17F5E6C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345175AbjKWLzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345166AbjKWLzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:55:37 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F041199
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:55:43 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5079f3f3d7aso1078112e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700740541; x=1701345341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rEhXyXecSsXMQIg/YxUPDQVBwLqafKsHNHP/Yqj+n9A=;
        b=VTEy762owftzuyIGOvZXtYoFv1DEzFUGmSh1NycxhyQftzetC8RjjIsinMGLEVvpAF
         X2Zo9xZvFJAfL+AziMU8UT04owj6tF0Q/5cp3Oo+X6S+agRlclo8SDrsEbEunaK90aKF
         khbUOdh77V+YfcDIyaHHjcWwrXJZ3yeHIyFe6W6wOMuOoKVXdzB8QG1BYRiB6wqykdls
         e4s9s8JwfJ+aBUkcV4CeRZfcuAYSFnYPZgUURJVWfGAd51oORLFHVFiY6EyjIlFoXxp9
         Jtr54zcWjWGUl8EBYxsIMS9xJOQnboNJgO25WJ1NCHmnvCix+62rva+yZHuzArIvkRAZ
         n+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700740541; x=1701345341;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rEhXyXecSsXMQIg/YxUPDQVBwLqafKsHNHP/Yqj+n9A=;
        b=IjVyoNHkBsSqdHz2bTQS1JEPZ0GSUost6K+LiBq/QptJD27fLFYq4OalAOMKsRJhhk
         cu2Onq/DyGk024nMK7mcJzF7iwHZ1o4Pj0FGcmg/S0BomXsI4YL7OxKzDlKcx+S+AY9e
         imEpEIAOoPZJbf3NZAv61A6xT9DToHzmwniAq62f4EmyIZu6DL/CUEh6LmrFj7ScFYfz
         C/QuBhimll3k/09M0+NtoflG78lnvcYIfzWF2TOiJMx90hgyFC8iWDysJgqBtvJ0wEZu
         c7x3+4KUkX85vrVQxZW+CS9XsCmXfth4hNntp/57hBexw5SlDIyMZ6Yyw+9X4fYQiU10
         q5+w==
X-Gm-Message-State: AOJu0Yynm9XFWqbeDSkmoV3vU6O0qD8qY2QZ1hLCHHjkUvNpLkTMsCCW
        nRVYWDkAFBThwRk0Gf/URBqWKg==
X-Google-Smtp-Source: AGHT+IEQmg9QqvwxWaq3S4vi5vqQ2B4nJxRaKyvDHdI7fGHr0Y0QeQwLVtigFPh+zv9FMG5fnt/9Fw==
X-Received: by 2002:a19:740f:0:b0:500:9f7b:e6a4 with SMTP id v15-20020a19740f000000b005009f7be6a4mr3036004lfe.32.1700740541278;
        Thu, 23 Nov 2023 03:55:41 -0800 (PST)
Received: from [172.30.204.221] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id k41-20020a0565123da900b0050aaa64ed60sm170104lfv.54.2023.11.23.03.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 03:55:40 -0800 (PST)
Message-ID: <1e02f4f8-ebd3-4f57-98a9-48d7e08c0ad4@linaro.org>
Date:   Thu, 23 Nov 2023 12:55:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] net: stmmac: Add driver support for
 DWMAC5 fault IRQ Support
Content-Language: en-US
To:     Suraj Jaiswal <quic_jsuraj@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>
Cc:     kernel@quicinc.com
References: <cover.1700737841.git.quic_jsuraj@quicinc.com>
 <62eaaace3713751cb1ecac3163e857737107ca0e.1700737841.git.quic_jsuraj@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <62eaaace3713751cb1ecac3163e857737107ca0e.1700737841.git.quic_jsuraj@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/23 12:38, Suraj Jaiswal wrote:
> Add IRQ support to listen HW fault like ECC,DPP,FSM
> fault and print the fault information in the kernel
> log.
> 
> Signed-off-by: Suraj Jaiswal <quic_jsuraj@quicinc.com>
> ---
>   drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
>   drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 ++
>   .../net/ethernet/stmicro/stmmac/stmmac_main.c | 18 +++++++++++++++++
>   .../ethernet/stmicro/stmmac/stmmac_platform.c | 20 +++++++++++++++++++
>   4 files changed, 41 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
> index 6b935922054d..c4821c7ab674 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/common.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
> @@ -347,6 +347,7 @@ enum request_irq_err {
>   	REQ_IRQ_ERR_SFTY_UE,
>   	REQ_IRQ_ERR_SFTY_CE,
>   	REQ_IRQ_ERR_LPI,
> +	REQ_IRQ_ERR_SAFETY,
>   	REQ_IRQ_ERR_WOL,
>   	REQ_IRQ_ERR_MAC,
>   	REQ_IRQ_ERR_NO,
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index cd7a9768de5f..8893d4b7fa38 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -33,6 +33,7 @@ struct stmmac_resources {
>   	int irq;
>   	int sfty_ce_irq;
>   	int sfty_ue_irq;
> +	int safety_common_intr;
>   	int rx_irq[MTL_MAX_RX_QUEUES];
>   	int tx_irq[MTL_MAX_TX_QUEUES];
>   };
> @@ -331,6 +332,7 @@ struct stmmac_priv {
>   	/* XDP BPF Program */
>   	unsigned long *af_xdp_zc_qps;
>   	struct bpf_prog *xdp_prog;
> +	int safety_common_intr;
other interrupts use _irq yet you seem to use _intr, plus the
aforementioned "safety" vs "fault" naming

[...]

>   
> +int stmmac_get_fault_intr_config(struct platform_device *pdev, struct stmmac_resources *res)
> +{
> +	int ret = 0;
get rid of ret and return directly

> +
> +	res->safety_common_intr = platform_get_irq_byname(pdev, "safety");
> +
stray newline?

> +	if (res->safety_common_intr < 0) {
> +		if (res->safety_common_intr != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "safety IRQ configuration information not found\n");
> +		ret = 1;
> +	}
> +
> +	return ret;
> +}
> +
>   int stmmac_get_platform_resources(struct platform_device *pdev,
>   				  struct stmmac_resources *stmmac_res)
>   {
> +	int ret = 0;
Missing newline between declarations and code
Unnecessary initialization

>   	memset(stmmac_res, 0, sizeof(*stmmac_res));
>   
>   	/* Get IRQ information early to have an ability to ask for deferred
> @@ -702,6 +718,10 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
>   	if (stmmac_res->irq < 0)
>   		return stmmac_res->irq;
>   
> +	ret = stmmac_get_fault_intr_config(pdev, stmmac_res);
> +	if (ret)
> +		dev_err(&pdev->dev, "Fault interrupt not present\n");
Since you're getting the return value, perhaps the errno should
be propagated

Konrad
