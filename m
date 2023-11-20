Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956A97F1A1A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjKTRdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjKTRdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:33:40 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63433BA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:33:35 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5484ef5e3d2so4496717a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700501614; x=1701106414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XpcT3rTKnIdGUAR9IGdwX67v7CmPFqW3w0pJLRLO2ls=;
        b=J4Y3GyCbkckoSeaOT4EdN+n81TBYIAJdmHJF2cdT50TkM3VZ1HqhiihXvvkakyJMj1
         is+7LbK7yL1jqF9hU5FLK7tk+LIKbGZcGLju8awuo20cKMsrdJZzcUp8/cekTqInnvzO
         P9eBv/ZdFtFaWhdCS9WxEMyPqZ9HT+RsFYyoOhEMmB2YF9PR/XjTPIkv7j1w3Mmu3zLG
         EGt++0f9mwWnyEf8CcLOdvzMQ7IUtQ+edtFN7vzFSJO7YkU3OUFy7+f5MDv8blnzih6L
         xIbeXajZxz21kEQVGYJiZGtYIWZnXz9B+kQnYiVd6WT+QFs+HYUjXiB+aoxMEUn7Q2ds
         dT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700501614; x=1701106414;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XpcT3rTKnIdGUAR9IGdwX67v7CmPFqW3w0pJLRLO2ls=;
        b=J90sCTvnpCZIe5Mub/sXWu2JNg4//L8Q59gh+z6RO7NVe+eGvjapNxVAZScX7Mn+ue
         Jh3I3OYNZ4Gkqux3a7pthT35DglevcwHCdz2vl+pwmU78zI+rkLLwX3R5My1WcuPs6rR
         seRdvPQex5xCggo94EFzT7mD2cLZSxPwkU9tWw/VeF7SC8Tg71vH0x+2ZxVkSRwDAi5C
         pcQZ1G7hl6nd+wQ64IHPJkTcrHEtZrYjTJc7nSh3tnrXqivMsyBWX+7Nc0IvrfPr2OpQ
         tvc3j0JCQxumb2L0XVw/tpFlQoYlm4fnUzQ1jRB1oC3Ec8x0cjDiLAJeZLybC7HRQ9Bi
         i4Dw==
X-Gm-Message-State: AOJu0YzIOzBNplDR1o1D8Tbnf2VFtwGmRMyQlUrw+9FLED/L6FIDbudt
        roG6p7qcukgQwYR0bPe7REE30g==
X-Google-Smtp-Source: AGHT+IFWdqimD/A6KMEHbSpDkd0skBa431YLo19fqJYYl6I2tPmV4rxCw4bblhc9h6dwAKJn0La2UA==
X-Received: by 2002:a17:906:208f:b0:9be:ab38:a361 with SMTP id 15-20020a170906208f00b009beab38a361mr5837654ejq.8.1700501613761;
        Mon, 20 Nov 2023 09:33:33 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id lz13-20020a170906fb0d00b009fcbb9162e9sm1965740ejb.174.2023.11.20.09.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 09:33:33 -0800 (PST)
Message-ID: <ee832442-064e-4f58-a963-5c008f6da455@linaro.org>
Date:   Mon, 20 Nov 2023 18:33:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] usb: cdns: fix suspend on J7200 by assuming
 reset-on-resume
Content-Language: en-US
To:     =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        Conor Dooley <conor.dooley@microchip.com>
References: <20231120-j7200-usb-suspend-v2-0-038c7e4a3df4@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231120-j7200-usb-suspend-v2-0-038c7e4a3df4@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2023 18:06, Théo Lebrun wrote:
> Hi,
> 
> Suspend on the TI J7200 platform is broken currently. There are two
> components that need to be patched so that they assume reset on
> resume: (1) the TI wrapper cdns3-ti & (2) the HOST role of the
> controller.
> 
> About (1): the TI wrapper only did its hardware configuration at probe
> time. Update so that it is done at resume on J7200 SoC.
> 
> About (2): signal from cdns3-ti to cdns3 host to xHCI that the
> controller resets on resume. This way we avoid the following warning:
> 
>    xhci-hcd xhci-hcd.1.auto: xHC error in resume, USBSTS 0x401, Reinit
> 
> Strictly speaking (2) is not required to have working suspend on J7200;
> its only goal is to silence this warning.
> 
> Those patches have been tested on the TI J7200 EVM GP. No need to

Yeah, but you forgot about dtbs_check testing. It's a step before
testing on the device. It does not make sense to test a code if it
causes build-time warnings.

Best regards,
Krzysztof

