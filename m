Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DA275496D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 16:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjGOOo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 10:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjGOOoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 10:44:25 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686912707
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 07:44:22 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4faaaa476a9so4876822e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 07:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689432260; x=1692024260;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vSTbiGWl/f9LXjwAM0s7iS/UViUSFOcV217Gp5upeiY=;
        b=zFSwrDrcPxFVoikze9dhOfct50farucjZ3BE3PVnzCsLIc0BwyAHzjPxe6hC0jFTt8
         3dh1ZhW7NsqoFGtfkXGkbRi8SJczQlsoyZ28BUDx2JpId7Yd561/2YuqEpQw4GLoMpjo
         XcpMn1nn5YE4o1w8jibv2U74oI8ZkkAkWzbFoHGZUBWlWuXeH8f4de8nHlV1p5wJaaLb
         9Tq2nlWO9iCGPtbMZv880rGfnbbEFIMTHKL9+Jk68cTRKX0wu3a92lzXitbvT2fqrSag
         UmFuMceTXAdEFbOIGTx7iuWaktSXJorgyF29NyWwD2JT+B61S0fCT9Bp6ONqc1r9dLCp
         iV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689432261; x=1692024261;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vSTbiGWl/f9LXjwAM0s7iS/UViUSFOcV217Gp5upeiY=;
        b=ZrcQN10jUGtAc5K7AyjvBm3bzNT8RXU02MUOBkoEk3viWb4mUwx3jLMSWQ8SZI2gWM
         Kh0ssfcyiDU57tZO4CG1PDtnWrUhpJhFh84cnK8uwUhpXoRNnN47OjxuQsxWNVGVC9i7
         hf8w+4mv0zXavI0flU0eYpNk9d2yEjcqcvhbw6mhgCJDVKLcAAooRlpLPYVrP/Yxw3YZ
         ot/zOj13NbGK+ZRRYilCb7y0ikGjATq0MRK0bMDSV6RYx48Da5o0Cngf+EjhsrjOq7Of
         ge8xfzA13p+1nKFgIRzghmtJS+MTFDMEHG90x1UpAYWMMEBq/JQG5fNKU6PsNSto4JGa
         X5fw==
X-Gm-Message-State: ABy/qLZB4GEnMh93dEuEi6UqCXv5kHN4ADM4qearytMk0oGCKcj1TjQj
        q2MA65sHSEy7LqcUd13nY8kG2Q==
X-Google-Smtp-Source: APBJJlGKypXRCCU2rBpdohwglN/0iKXifubS2+iEPFSgy4Ue4OkkYElHGzUjauhRcw4vD0hXKb3L9w==
X-Received: by 2002:a05:6512:3c96:b0:4fa:f79f:85a with SMTP id h22-20020a0565123c9600b004faf79f085amr6711334lfv.69.1689432260696;
        Sat, 15 Jul 2023 07:44:20 -0700 (PDT)
Received: from [192.168.1.101] (abxi167.neoplus.adsl.tpnet.pl. [83.9.2.167])
        by smtp.gmail.com with ESMTPSA id q20-20020ac24a74000000b004fb9d7b9915sm1911777lfp.37.2023.07.15.07.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 07:44:20 -0700 (PDT)
Message-ID: <9799a98a-7e41-3b23-f883-bc790e2bba60@linaro.org>
Date:   Sat, 15 Jul 2023 16:44:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/7] clk: qcom: gcc-sc7180: Fix up
 gcc_sdcc2_apps_clk_src
Content-Language: en-US
To:     David Wronek <davidwronek@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org
References: <20230715091932.161507-1-davidwronek@gmail.com>
 <20230715091932.161507-2-davidwronek@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230715091932.161507-2-davidwronek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.07.2023 11:16, David Wronek wrote:
> Set .flags = CLK_OPS_PARENT_ENABLE to fix "gcc_sdcc2_apps_clk_src: rcg
> didn't update its configuration" error.
> 
> Fixes: 17269568f726 ("clk: qcom: Add Global Clock controller (GCC) driver for SC7180")
> Signed-off-by: David Wronek <davidwronek@gmail.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/clk/qcom/gcc-sc7180.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/qcom/gcc-sc7180.c b/drivers/clk/qcom/gcc-sc7180.c
> index cef3c77564cf..49f36e1df4fa 100644
> --- a/drivers/clk/qcom/gcc-sc7180.c
> +++ b/drivers/clk/qcom/gcc-sc7180.c
> @@ -651,6 +651,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
>  		.name = "gcc_sdcc2_apps_clk_src",
>  		.parent_data = gcc_parent_data_5,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_5),
> +		.flags = CLK_OPS_PARENT_ENABLE,
>  		.ops = &clk_rcg2_floor_ops,
>  	},
>  };
