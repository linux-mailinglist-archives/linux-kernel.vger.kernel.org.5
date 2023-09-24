Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303FA7AC7F7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 14:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjIXMWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 08:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIXMWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 08:22:48 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A97106;
        Sun, 24 Sep 2023 05:22:40 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-692d2e8c003so661527b3a.1;
        Sun, 24 Sep 2023 05:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695558159; x=1696162959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a2vcY7tF/zX/vLERKQFBiyXpiUq72NnOnw1gtUdIzwY=;
        b=iEcqv9qcBKpLHRf2axvMDSvTBRE/J2vZ7r+zEw0DvR1dUObJsIhpoEtOjHHiLxOlGB
         EWb11wtulXsQDXiyaJJyyO7dh1H+yirpRbXBUI/JvrWIMCDWVXofxPgb8iu5WzttHLqB
         G2uHv3eD9wnbRzY/BoD/EAWY40E1rUcxn8bL4vHNI1jbgKvQPybx5lpEB7A2LIZdyKCe
         +8CWL5AvJBLYCpZ8BNMNfXNmrCpN4mkRiqAWcUgd+EuYtTQRdOt72FBDwvMWWqUOkPBd
         r6pBoDxR0CdGDPfMFkiMDn/Y+YJSMacSItgO3E7WrkTt1oXjmSOsCD0YKPhTvb9IxvYU
         f8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695558159; x=1696162959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a2vcY7tF/zX/vLERKQFBiyXpiUq72NnOnw1gtUdIzwY=;
        b=nLgtKyxJcO9BqbY7nocNH+YgNioWYjCK+WmLwOoEaBns5bVmopkzJ/AtqeYO2fgcx4
         TMffzc6jC3lK4WbQaCiy5eP15EYKYEGzZJ3AaJMff+nKtMLrEPnLtGn9GYODMrY5xpyU
         LkDXA+ncV9Hoes6hDLPRUg7uln2M9h1huubWYv0NFiiU0s/DELL6Mc7dtvabfo24M47Y
         tMeeFFxi5QwPI6RhwBsd1rNu/OlJHw+cD/xwWCG5pb4Xj3JaYHHkPNYKJCaKusa0fGtb
         8aseansz6ntHVIq5zqRpxZQF06uvoUUrTWNaQB6QsQGJp/M4ySC5pShGsnDCs1f6cCsU
         PvdA==
X-Gm-Message-State: AOJu0Yyj+RvoMeDsipYkrjCnkKeb3Lf678qWaYqPsXaHkxYahYndmI2o
        c5U7QgX9OTsui+3PsKBDRP4=
X-Google-Smtp-Source: AGHT+IFzH0CilMUpxjK7Ai5MGsLE7MUvQd6UclHut0zH0m8PXgN/bwJ7pFeIcalNBKxMiMJwX7I/gg==
X-Received: by 2002:a17:90b:4ace:b0:274:98aa:72d8 with SMTP id mh14-20020a17090b4ace00b0027498aa72d8mr6467128pjb.3.1695558159500;
        Sun, 24 Sep 2023 05:22:39 -0700 (PDT)
Received: from [172.16.116.58] ([103.15.228.93])
        by smtp.gmail.com with ESMTPSA id y3-20020a170902864300b001b0358848b0sm6741970plt.161.2023.09.24.05.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Sep 2023 05:22:39 -0700 (PDT)
Message-ID: <69f8f5aa-075c-0dc1-7a5f-bd6978c71f53@gmail.com>
Date:   Sun, 24 Sep 2023 17:52:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 1/3] dt-bindings: Add beagleplaycc1352
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        greybus-dev@lists.linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, vaishnav@beagleboard.org,
        jkridner@beagleboard.org, nm@ti.com,
        krzysztof.kozlowski+dt@linaro.org, vigneshr@ti.com,
        kristo@kernel.org, robh+dt@kernel.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230924113725.164948-1-ayushdevel1325@gmail.com>
 <20230924113725.164948-2-ayushdevel1325@gmail.com>
 <0fd912a9-4aaa-d4bd-4ceb-7319d9f46db8@linaro.org>
Content-Language: en-US
From:   Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <0fd912a9-4aaa-d4bd-4ceb-7319d9f46db8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So this is "Texas Instruments Simplelink CC1352P7 wireless MCU"? Since
> you do not have any fixed feature and run general-purpose OS, then this
> should be rather compatible matching actual hardware (so ti,cc1352p7).
Yes, it is "Texas Instruments Simplelink CC1352P7 wireless MCU". Since 
the docs suggest that all functionality of the device should be 
mentioned in the bindings rather than just what is being used, I suppose 
all the other properties can be defined as optional? The bindings for 
this device do exist in Zephyr, so I guess that can be re-purposed for 
Linux kernel. However, I think in that case it should be moved into 
`soc` instead of `net`?
>
>> +
>> +maintainers:
>> +  - Ayush Singh <ayushdevel1325@gmail.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: beagle,play-cc1352
>> +
>> +required:
>> +  - compatible
> Still no resources? I asked about it last time and you did not answer
> anything.
Sorry, I missed that. By resources, I think you mean pins, peripherals, 
etc right?


Ayush Singh

