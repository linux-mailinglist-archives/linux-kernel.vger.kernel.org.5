Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACA87F1DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 21:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjKTUEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 15:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbjKTT44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 14:56:56 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4140792;
        Mon, 20 Nov 2023 11:56:51 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40839807e82so13551195e9.0;
        Mon, 20 Nov 2023 11:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700510209; x=1701115009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IupAvwev6oBUFLNeQ7ZfeBu1thzkNwuSAYfTF2EO4Nw=;
        b=GZRx1lOSbGvSqRmbW7Iq5To21mrEjm9qusrt/o+GLA2CpmBQNI3m0zjbBmkfnrcWVR
         /9m/3jp+fq/p6x4t03lZvcMpBAfDFYZVZr5hVKA32JZV8neUxg5G6ONBjwDNQznv8ioN
         MDiotjXGNOiozPsZWfP4CsAwrdEZcyyf7WnVAtuDFiDf3qpxGtqvCVwx2bjpI7njDBUm
         bl/Z2hknzFpG6iPGpY1qrzv1NgUDMPJ1BCzk/9xaNR+w9NW3z4YdT7602f1MIghNHhjX
         3hTXaJjWqy9h9DCcWHHQeJT/NBPGNm4/eAOL6Z0HTlZ8z/p8mmc2eY/yiYPFmdqtNYa2
         TR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700510209; x=1701115009;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IupAvwev6oBUFLNeQ7ZfeBu1thzkNwuSAYfTF2EO4Nw=;
        b=grZ0JRKNJ7UYH0QbjsgpuAPd22kOB0QTzo40vZbT6qg1B3nRnz+IQadyxenkidzDRG
         7c9xb/BeBGy0vbu0bXZDtR3JOB2G8xQ9FcbsMKEhB6AYVj/o+tCa5QLXZr9aWjxCIRTX
         nWFCD7B7tAxH9WuTt+g2mtqHICQC937P3I4vpBeR96TZowKfZZuctcICd5aqe9XdkKLF
         MZmTQfUiQRnF5O+3rJhsP+Zn1mM+Fb3rxD/RgCLnZKvrFQK9klByV2tSNFe9puNl8LVk
         5xeErsVn0lWxM6tPYsQKgV9Ki8k49kaD3CrQwu54/uoMVDTQQivAwzKRUP43zSRG/ywZ
         622A==
X-Gm-Message-State: AOJu0YwvPzeaghlTLPCtuqab9QdKT0GY3IJUyrvS5ky7/xc9yGhAhGL6
        XGPXNOLoCbAGWJXmOrH+2wk=
X-Google-Smtp-Source: AGHT+IFOVyt+UsiUMNW3SwODANiNa7qL47ApDq5sA6MJK5eGLMX2ULynzicCEynEb0wPsT7uCBwD/Q==
X-Received: by 2002:a1c:7902:0:b0:405:3ab3:e640 with SMTP id l2-20020a1c7902000000b004053ab3e640mr393238wme.20.1700510209312;
        Mon, 20 Nov 2023 11:56:49 -0800 (PST)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id x16-20020a05600c21d000b004063cd8105csm18443804wmj.22.2023.11.20.11.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 11:56:48 -0800 (PST)
Message-ID: <2f14aab8-a5bb-4af4-9475-afe6b678a7fd@gmail.com>
Date:   Mon, 20 Nov 2023 20:56:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: qcom: qcm: fix unused
 qcom_scm_qseecom_allowlist
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
References: <20231120185623.338608-1-krzysztof.kozlowski@linaro.org>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20231120185623.338608-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/23 19:56, Krzysztof Kozlowski wrote:
> For !OF builds, the qcom_scm_qseecom_allowlist is unused:
> 
>    drivers/firmware/qcom/qcom_scm.c:1652:34: error: ‘qcom_scm_qseecom_allowlist’ defined but not used [-Werror=unused-const-variable=]
> 
> Fixes: 00b1248606ba ("firmware: qcom_scm: Add support for Qualcomm Secure Execution Environment SCM interface")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311191654.S4wlVUrz-lkp@intel.com/
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   drivers/firmware/qcom/qcom_scm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 520de9b5633a..ecdb367dc9b8 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -1649,7 +1649,7 @@ EXPORT_SYMBOL_GPL(qcom_scm_qseecom_app_send);
>    * We do not yet support re-entrant calls via the qseecom interface. To prevent
>    + any potential issues with this, only allow validated machines for now.
>    */
> -static const struct of_device_id qcom_scm_qseecom_allowlist[] = {
> +static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
>   	{ .compatible = "lenovo,thinkpad-x13s", },
>   	{ }
>   };

Thanks! Given that we're right now only allowing qseecom clients to load
on devices within that list, maybe it would be cleaner to make
QCOM_QSEECOM depend on OF explicitly instead?

Anyway, I'm also fine with this solution.

Acked-by: Maximilian Luz <luzmaximilian@gmail.com>

