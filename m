Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06517A1787
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjIOHcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbjIOHcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:32:20 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF9B1BC9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:32:12 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-404573e6c8fso16418065e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694763131; x=1695367931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1pFfXlJOJvNpdcADR+2RDuK6BOaq4eRQB5oTZpxIz5k=;
        b=nW8tylY/AmJICbuH7LNcjfM1P2U/o79LYCVn1j8tD6McQUuWDJa92FJdZd/oWsCQTW
         4DnqCM41XxvllI13hWRfTMCjmfmqxRSTVEy7mEaIZ5XkN7NFrniC8aZD16B6509LZaDK
         W80jeDtpX87vMBYKijGF/p4/zCANmV9eMQT6KDeqZqBxEKSz/TLFY8daWYDQZZ7iYS/+
         xL+6JrHBO4jYs77NUXp/SjblUSfEmJdYTuD4XgYyAxMcnvxSzIUFwCpvws4IxRhq1M/6
         xk4m0ZTBEmwtaTKAgv5cWgO/rmUuE5af2cxDtYY8/xA6dA9oA141lVfSHFHACvkVGkwD
         iuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694763131; x=1695367931;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1pFfXlJOJvNpdcADR+2RDuK6BOaq4eRQB5oTZpxIz5k=;
        b=fmoRKe9HPZJrulhOguPeMzLWgCtMgiEs14A3P33WrfVIjpcn88xJcxjaVzXfpYCOs6
         v8KXlgd+MA/cItOfeBJDQAua85ynE/W3PinX5b0sBusakXPrPhDx5AJwAwW/5rL2Gm9N
         Awx5WigCB3rNEmHMRQaEauYkqq50hxta/DftUz63NfoCKF8LfHwffoTlLnDsGY2+dgsZ
         cv3SIUHQzZD1GhYLyZnXuDuJFnZmlbNbpOYenUso26Fc4MmpF0EKCKP4OZ1Vy23xKnE2
         XBkT2HE8NPtjrFtuBWjVJPL8WgMFew21HEkpudjqUSwh+/2HNKzn2dgSMMNrpOTTJ4tv
         uaOw==
X-Gm-Message-State: AOJu0YwKIP0u9TQI0bwC7ZpRRRUfLk09SE9jDr6vL/IYIFCfxwZGzpzE
        Mqc2VcdYFX1EsmQn7PIngu/OVQ==
X-Google-Smtp-Source: AGHT+IEk8DMEDkEsYiFq89U3dw2MEH+q7FpthgjHUbEXaIRWLW2niQ9IP4LJHDt5iGn63/nNROlsew==
X-Received: by 2002:adf:f310:0:b0:317:e04c:6791 with SMTP id i16-20020adff310000000b00317e04c6791mr739845wro.62.1694763131275;
        Fri, 15 Sep 2023 00:32:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id j6-20020adfff86000000b0031c56218984sm3628569wrr.104.2023.09.15.00.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 00:32:10 -0700 (PDT)
Message-ID: <acd83ee9-951d-928c-eb9f-e3295ae7ad55@linaro.org>
Date:   Fri, 15 Sep 2023 09:32:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 11/12] riscv: dts: sophgo: Add sophgo,sg2024-uart
 compatibles
Content-Language: en-US
To:     Wang Chen <unicornxw@gmail.com>, linux-riscv@lists.infradead.org,
        conor@kernel.org, aou@eecs.berkeley.edu,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jszhang@kernel.org, guoren@kernel.org, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com, Wang Chen <wangchen20@iscas.ac.cn>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
References: <20230915072624.118388-1-wangchen20@iscas.ac.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915072624.118388-1-wangchen20@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 09:26, Wang Chen wrote:
> Add compatible for uart.
> 
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Wang Chen <wangchen20@iscas.ac.cn>
> ---
>  arch/riscv/boot/dts/sophgo/sg2042.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> index 5c4b82f13207..87f7667bbe63 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> @@ -492,7 +492,7 @@ &cpu63_intc  0xffffffff &cpu63_intc  9
>  		};
>  
>  		uart0: serial@7040000000 {
> -			compatible = "snps,dw-apb-uart";
> +			compatible = "sophgo,sg2042-uart", "snps,dw-apb-uart";

No, you just added this file. Do not add buggy code which is fixed in
next patch.

Best regards,
Krzysztof

