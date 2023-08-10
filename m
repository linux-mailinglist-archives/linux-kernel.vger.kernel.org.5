Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF72777E2D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbjHJQ0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbjHJQ0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:26:03 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6581E103;
        Thu, 10 Aug 2023 09:26:03 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68706d67ed9so817256b3a.2;
        Thu, 10 Aug 2023 09:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691684763; x=1692289563;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eukdoe2Tc680LE21wkxfZgZeWn3/Mo2/aaZLQF0/Kcc=;
        b=CdxbMIkjrD9v3xssSjgTGp7lTOklgfs5MwmzPqo18t7IM0bfF6dUK1IWVHlI+oGfq9
         /o8uT9NV0V6+d3gXoisVuowCscXms3f5x/KOl+4NFjTI+RfnzKTIvxaqs+XoqDFrD0QT
         sO3uoI8er6w2I/9mtgCwUtGq1KSnuYDHvxlTTmvzwzCP8+Aa/ipRvYt36taRDn7yX29y
         rADZvriSRlD+6+sS5qdsnxryhvY+G9PRqdvZELKZCUFAzytmcj/ihXLXsAEoM286V8HN
         xWyVaH8T2jNYSPDITNrnOu6JWJSNjfkbLBkxY3OI1lPypJRinu7hjfD9Pm0GAtYJ76AL
         LOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691684763; x=1692289563;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eukdoe2Tc680LE21wkxfZgZeWn3/Mo2/aaZLQF0/Kcc=;
        b=ZdMJk1obuVnBr/u9rg+1sPDFcdXSLPUGxQsr+jI9tQkWk8RfbfC2r//r2AFqo9ejOP
         VYJCr2TKmtrTNZTg0awMMuwkdYIic+Xb0oLTSL3MlqHmYOoGZXfBFEthtD8ByXLvdu1a
         VwDNQcVH/F1wdtOsYkLFqSecsV6fxtDci4/zNDbaRGYcFcfCYPxk9xvr8PWHAn8mmt8T
         eONqZzowuPGqK5MgHl1hAnYbL61oFQRI4i17BUkNYEphGejPVmm+KTe2fN+kAXlKSJ7L
         3ye1XUuhvkDZs88Rt1R6/vPwLIELYLYZCAH0aW2VUdvOF1WFoeoKHp8wmmpljREmwn3T
         GWew==
X-Gm-Message-State: AOJu0YwsdgDSsefBZ1k1aB5iErLleEZeQsPv6hj+W5a7ih3iuy0lUHG8
        DskkRxZ724jPY821SKk5n+s=
X-Google-Smtp-Source: AGHT+IGVENtRj0Uqvr0eDdi5LcYQATl9QX2SejWqIUO+p4XIqUH4j8jdbtzVjZHFiJ7kbdFl2n0T/w==
X-Received: by 2002:a05:6a21:1f1c:b0:140:694:cd99 with SMTP id ry28-20020a056a211f1c00b001400694cd99mr2631970pzb.44.1691684762721;
        Thu, 10 Aug 2023 09:26:02 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id j17-20020a62b611000000b00687f845f41fsm1710112pff.119.2023.08.10.09.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 09:26:01 -0700 (PDT)
Message-ID: <3815ef44-4edd-8d53-14e3-043b26d025f4@gmail.com>
Date:   Thu, 10 Aug 2023 09:25:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.15 00/92] 5.15.126-rc1 review
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230809103633.485906560@linuxfoundation.org>
 <9a3b1ff6-d702-6b67-9d9b-5eb1f90b4e50@roeck-us.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <9a3b1ff6-d702-6b67-9d9b-5eb1f90b4e50@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/23 03:24, Guenter Roeck wrote:
> On 8/9/23 03:40, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 5.15.126 release.
>> There are 92 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
>> Anything received after that time might be too late.
>>
> Building arm:allmodconfig ... failed
> --------------
> Error log:
> drivers/firmware/arm_scmi/smc.c:39:13: error: duplicate member 'irq'
> 
> drivers/firmware/arm_scmi/smc.c: In function 'smc_chan_setup':
> drivers/firmware/arm_scmi/smc.c:118:34: error: 'irq' undeclared
> 
> Building arm64:defconfig ... failed
> --------------
> Error log:
> 
> drivers/firmware/arm_scmi/smc.c:39:13: error: duplicate member 'irq'
> 
> drivers/firmware/arm_scmi/smc.c: In function 'smc_chan_setup':
> drivers/firmware/arm_scmi/smc.c:118:34: error: 'irq' undeclared
> 
> That is because commit d80e159dbdbb ("firmware: arm_scmi: Fix chan
> free cleanup on SMC") is applied without its dependent commit(s).

Indeed, we discussed this here: 
https://lore.kernel.org/all/20230810084529.53thk6dmlejbma3t@bogus/
-- 
Florian

