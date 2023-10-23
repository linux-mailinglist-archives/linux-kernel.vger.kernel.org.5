Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8111B7D3970
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbjJWOgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbjJWOgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:36:31 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48631A4;
        Mon, 23 Oct 2023 07:36:29 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a92782615dso19714507b3.2;
        Mon, 23 Oct 2023 07:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698071789; x=1698676589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CJ0t+v02CjwjkswDCmDeSY6rN5hL3pFQ5QlA90jP6kY=;
        b=ED0niK/RRbcDg/noEgLsCYcFd8yKPh6svYCOr3LUnOIg3X4v+BHWYrkvOkF9vv7x4W
         2becHHFHEOws9fRZcl4FntdVRdngxr83oLIy5dOHleFtKyo4F0NhXHltTGOrUNTEtodA
         MTA0XSQ6o4IvG0YJw1ahg6Fki+xISnk6mJw068Ob3eFB8USlNRxrUVufHzy404xbaFVo
         f6J1re8yibApmBl7PHkT3eBTDtbZP6d6p551OwTcNIKIT41YK/dcCIykqvHTjrB1LYt0
         vsuS+IYeel062V18x2qG/EH5CFe+3xfeMsMy+kfuZxzpL1J3P0bLhnTy1Y9B6ZJk27ci
         OAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698071789; x=1698676589;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJ0t+v02CjwjkswDCmDeSY6rN5hL3pFQ5QlA90jP6kY=;
        b=YfnAMem69fGyjx66y+4wRcr4Yxu8412FIJXcx0VgnNV7ITDHrOGRMe39jasxvyuIKc
         RuKSJRF23n1WuurNMBbSp42y8LriKOVh0W3cM148ensaz8+5cOr++gcLHzqP3xxY7bG0
         sMg3c33xEds3KuscklyYHEyhj43nbaJU7Yset+3xaslse7ZO4Dzb8+J//tzSDEgZNv60
         RtLDVpPEza4qiswer7bigaTtkkPmQ2/xUbqkXzuQPoQpuVVG98+LJd1A1x3hXU7Ub+Mk
         4bA1PuTx97wDui7uJCYUHmrk2F5KlhQbJWw+kVHdX9VOVKfqZsyyqWmBMhPH0O4h0ZJp
         IMWw==
X-Gm-Message-State: AOJu0YxmhJyuNgMdmq2bqaZ6UlDBGmt5gf0oigFt258IwYBkW8Nnxa6f
        Kxhgp4imTr3xfirHH4BVNItApzuiyhA=
X-Google-Smtp-Source: AGHT+IH9MpOOovN5WmRxQq7B0erFLUXyrlNO8AFUEAU0ZSw6It/yUdsSd6EwhA77lIBmadu98p3EgA==
X-Received: by 2002:a25:7756:0:b0:d9a:d894:7b51 with SMTP id s83-20020a257756000000b00d9ad8947b51mr10286089ybc.57.1698071788862;
        Mon, 23 Oct 2023 07:36:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u5-20020a250945000000b00d7465a90f0csm2722816ybm.22.2023.10.23.07.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 07:36:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5bd191c3-a58a-e6b4-12a6-64efb9b03f2e@roeck-us.net>
Date:   Mon, 23 Oct 2023 07:36:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20231023104817.691299567@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 5.4 000/123] 5.4.259-rc1 review
In-Reply-To: <20231023104817.691299567@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/23 03:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.259 release.
> There are 123 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.
> 

drivers/gpio/gpio-vf610.c:249:18: error: 'IRQCHIP_IMMUTABLE' undeclared here (not in a function); did you mean 'IS_IMMUTABLE'?
   249 |         .flags = IRQCHIP_IMMUTABLE | IRQCHIP_MASK_ON_SUSPEND
       |                  ^~~~~~~~~~~~~~~~~
       |                  IS_IMMUTABLE
drivers/gpio/gpio-vf610.c:250:27: error: 'IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND' undeclared here (not in a function); did you mean 'IRQCHIP_MASK_ON_SUSPEND'?
   250 |                         | IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND,
       |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       |                           IRQCHIP_MASK_ON_SUSPEND
drivers/gpio/gpio-vf610.c:251:9: error: 'GPIOCHIP_IRQ_RESOURCE_HELPERS' undeclared here (not in a function)
   251 |         GPIOCHIP_IRQ_RESOURCE_HELPERS,
       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpio/gpio-vf610.c:251:9: warning: excess elements in struct initializer
drivers/gpio/gpio-vf610.c:251:9: note: (near initialization for 'vf610_irqchip')
drivers/gpio/gpio-vf610.c: In function 'vf610_gpio_probe':
drivers/gpio/gpio-vf610.c:340:9: error: implicit declaration of function 'gpio_irq_chip_set_chip'

Also affects v5.10.y and v5.15.y.

Guenter

