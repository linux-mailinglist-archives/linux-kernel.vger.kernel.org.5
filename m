Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC52B791230
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352446AbjIDHaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352455AbjIDHaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:30:18 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0261E44
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:29:55 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so4188082a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 00:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693812594; x=1694417394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MQYtxZ4YMVufLg8cTj7D18vm0cjxwRPxw1iteFSZqzE=;
        b=YZZXcsM7aYr+jfDdgJqYkPzji1XASJrzHAuT+QUoivE0O7xpSJk8YoVEudRnO5+8C1
         VQ20ToMo8CqqO+G06H59MiVsoGdUMZgWGMBvwi08kJpGxe9YDxdHweJNuvy5dBaFHvfi
         N1VMttOlD1eaCoWbPoz/kS4ZRWNEyDQmaqBVSWIPVOMtiAPctFygNBsXIiaIesxD3pgq
         dGkiYjDP6OlaJ3AxM9elX14kF5zdttsQGG5RxtE3+AIWmjTtErTs5CpFme3nvzT1s+mP
         LlnduJYruPOXbg8Y9WKvRVPJ+LKQmgZk1HWLTdoV/4Irr5wkNxrifmbVpIIF2/RymPxZ
         LQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693812594; x=1694417394;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MQYtxZ4YMVufLg8cTj7D18vm0cjxwRPxw1iteFSZqzE=;
        b=NA/Jf8of6GXDYUXjdQiJVKbFWaCS4ZtNSRg5lcbjT3IudOecpA99uqx/mG3UyVcvQn
         P8btlx5640GyLyIFVclh++uRGLGgIGv/sFi4AoUvyr7nz95D9jlGvEM6eM011pjcQ98f
         lFwBbrpHnSdBYa9zkhd+ORZP3QejfjzN7pQFEss80PIOhcx+UdT5MI7kTVtEIRcL+uoZ
         c/02dE5R3ineG+QrYEFXxGgWgXvCIBkLl4CTM4ABKHysoAUrptjQaBPW8W+lTxRSw9Ow
         6i7F1BvwaBy8m7NFrkjEZCO511u+iZonrhrilTC4RHW6Odtz7pRPgNzbL2gbm5YX6VRR
         Ir4Q==
X-Gm-Message-State: AOJu0Yyk7aPhutpT/1ZXpmWjCPkWNB2AmuDXfg8NpODJXIy5I5YA4qL+
        k8IfeehUuQkffYySg92uM8V4pg==
X-Google-Smtp-Source: AGHT+IFjTFQlvYaNRPC1WlRV6FzXxov+PWopPfMBZJArbcX2WyN8R1jmD7YdwV4eNao3JwXbLyZ7GQ==
X-Received: by 2002:a17:906:51c5:b0:99c:5056:4e31 with SMTP id v5-20020a17090651c500b0099c50564e31mr9989300ejk.15.1693812593690;
        Mon, 04 Sep 2023 00:29:53 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id v7-20020a1709063bc700b0099bc80d5575sm5670697ejf.200.2023.09.04.00.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 00:29:53 -0700 (PDT)
Message-ID: <7329b120-2c8a-8382-3171-d6a9426182e3@linaro.org>
Date:   Mon, 4 Sep 2023 09:29:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 3/3] riscv: dts: Add th1520 reset device tree
Content-Language: en-US
To:     Kwanghoon Son <k.son@samsung.com>, p.zabel@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jszhang@kernel.org, guoren@kernel.org,
        wefu@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, inki.dae@samsung.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20230904042559.2322997-1-k.son@samsung.com>
 <CGME20230904042603epcas1p47c4e858d65f2618d747bdc214d350cf7@epcas1p4.samsung.com>
 <20230904042559.2322997-4-k.son@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230904042559.2322997-4-k.son@samsung.com>
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

On 04/09/2023 06:25, Kwanghoon Son wrote:
> Add reset device tree for th1520 SoC
> 
> Signed-off-by: Kwanghoon Son <k.son@samsung.com>
> ---

...

>  / {
>  	compatible = "thead,th1520";
> @@ -418,5 +419,12 @@ portf: gpio-controller@0 {
>  				interrupts = <55 IRQ_TYPE_LEVEL_HIGH>;
>  			};
>  		};
> +
> +		rst: reset-controller@ffef014000 {
> +			compatible = "thead,th1520-reset", "syscon";
> +			reg = <0xff 0xef014000 0x0 0x1000>;
> +			#reset-cells = <1>;
> +			status = "disabled";

Why do you disable it? There are no missing resources.

Best regards,
Krzysztof

