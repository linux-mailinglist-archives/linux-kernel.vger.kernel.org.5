Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFEC7FE161
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjK2UyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjK2Ux6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:53:58 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D31D69
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:54:00 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40b4d9e81deso1731995e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20230601.gappssmtp.com; s=20230601; t=1701291239; x=1701896039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YKjbNQgXkGMeMvnSiazATvW5vc83bVG6h9HitL94um8=;
        b=kQpQoQWE3JvI6Sk1pwSmnEZjXE1b7nAjtCMMx0yuLuAL06QFPkhCoHrBGfj0cB69YL
         meYqE+W9sSmk79So2o4ueAM9W+h9hsbItFY4H3K0FmYbAehzaFqu8Nf3k5UCbuvukxZ7
         HL83XVh35lAlesmW93PkgcVUYIJqCfSUPgHyecXwzt41McLuB+uH5Pj8zCRJUXy/DqKl
         7Lyfmeqz9e8OencVfsU01vZFBg/k6RuYbyDtRbXYLic+hVupiisctJ/DpNFMexUvTW8R
         kttwpW4bKf0PrDv3/5d/+nAG6zKKgotHlgahLgWBxc64hZGoYB9x+mGtWl1eSzkw7hv3
         k5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701291239; x=1701896039;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YKjbNQgXkGMeMvnSiazATvW5vc83bVG6h9HitL94um8=;
        b=HwXbzvHOxhkdmSha75I5z6ysXfh/etwZwsjlJfBpfjwysyc8QiJfTLgTZdI/io8mkE
         rDopHYUuU7lyBypSq0oAJskpR0RmYqlngC/DEFXnQbi5T9yULB/iVllm1yV3B96CLFTJ
         pY4MPb54+hVnEp30Yn4pvKpz59+Cumb2pyg5ZCW6cyi3v4ZJxmfvWs4Y/z2jZRRZyEje
         NcXScP0S6M9z6hx7PxiBRO+zhO6FXeA6DWuG9lS4NBiGu9Yl5MYwq9t7AR/L4nWmALNz
         tJbAXlVfYKF3K5mhCkMXKGdfgIdidUXfo/gxs6RV681o9p+/nU8TzyEolHcvphXs/1EA
         ECPA==
X-Gm-Message-State: AOJu0YyBVvuYlXFWFU1evNrBNo1ZuCu3wLIn942bezI2NOuwFtGmcWnZ
        PmQoFfsLUIbUgbp30RkxFXWA4w==
X-Google-Smtp-Source: AGHT+IFJnxs03uHyKsQvS/eeVLg4bLJCJWU+N3Z26xmaV36HJAdD6+44jAtYpt4zRuMooN+P4N+XzA==
X-Received: by 2002:a05:600c:4ed3:b0:408:3c10:ad47 with SMTP id g19-20020a05600c4ed300b004083c10ad47mr12917112wmq.40.1701291238941;
        Wed, 29 Nov 2023 12:53:58 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id k18-20020a05600c1c9200b0040b2976eb02sm3351905wms.10.2023.11.29.12.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 12:53:58 -0800 (PST)
Message-ID: <cc8b9eea-ea4c-4943-a0f2-c2a791903440@nexus-software.ie>
Date:   Wed, 29 Nov 2023 20:53:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/15] clk: qcom: branch: Add a helper for setting the
 enable bit
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
References: <20230717-topic-branch_aon_cleanup-v2-0-2a583460ef26@linaro.org>
 <20230717-topic-branch_aon_cleanup-v2-1-2a583460ef26@linaro.org>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <20230717-topic-branch_aon_cleanup-v2-1-2a583460ef26@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2023 18:59, Konrad Dybcio wrote:
> We hardcode some clocks to be always-on, as they're essential to the
> functioning of the SoC / some peripherals. Add a helper to do so
> to make the writes less magic.
> 
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/clk/qcom/clk-branch.h | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
> index 0cf800b9d08d..155818cc8d49 100644
> --- a/drivers/clk/qcom/clk-branch.h
> +++ b/drivers/clk/qcom/clk-branch.h
> @@ -47,6 +47,7 @@ struct clk_branch {
>   #define CBCR_FORCE_MEM_PERIPH_OFF	BIT(12)
>   #define CBCR_WAKEUP			GENMASK(11, 8)
>   #define CBCR_SLEEP			GENMASK(7, 4)
> +#define CBCR_CLOCK_ENABLE		BIT(0)
>   
>   static inline void qcom_branch_set_force_mem_core(struct regmap *regmap,
>   						  struct clk_branch clk, bool on)
> @@ -81,6 +82,12 @@ static inline void qcom_branch_set_sleep(struct regmap *regmap, struct clk_branc
>   			   FIELD_PREP(CBCR_SLEEP, val));
>   }
>   
> +static inline void qcom_branch_set_clk_en(struct regmap *regmap, u32 cbcr)
> +{
> +	regmap_update_bits(regmap, cbcr, CBCR_CLOCK_ENABLE,
> +			   CBCR_CLOCK_ENABLE);
> +}
> +
>   extern const struct clk_ops clk_branch_ops;
>   extern const struct clk_ops clk_branch2_ops;
>   extern const struct clk_ops clk_branch_simple_ops;
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
