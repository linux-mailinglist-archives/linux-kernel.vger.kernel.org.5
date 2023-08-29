Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA0E78CD87
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 22:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238697AbjH2UXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240525AbjH2UX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:23:26 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA851BB;
        Tue, 29 Aug 2023 13:23:24 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bf5c314a57so29920415ad.1;
        Tue, 29 Aug 2023 13:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693340603; x=1693945403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9JouhxBa4CgjE8m+MiUTn5+R6KTenHsJATYLj7J/g98=;
        b=p7cqeDeEpXJzKclLZTUBGvcvILKHLgD3bnXHNPYnUgRXiIuvrHA4sAgz657108upRM
         onZC4F84ndotxqIhR5m+V3hda49wJXxlbrizMt/LJn5j1vMqyB14MG1sz23KArxolU/j
         2MzJmXBC8iKMfrymzZjT/vkQ2iURuRIBpDk1C6xL27MLynv2M5yNO6LgpVoCUzdw8oEe
         VH6XvmqNWgCqWPCjmyAV2GfNHS9bfTeG8iz5VaXnb4/vk+pduxn0Ns/t0z0mgmmsmdGu
         uh18PizVAclnS176HzqJsKfPTGi/tPiNY6Y69EHuiF7edwyEKO9NVSFomyE+lA2b43vB
         CSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693340603; x=1693945403;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9JouhxBa4CgjE8m+MiUTn5+R6KTenHsJATYLj7J/g98=;
        b=cmU8hWMlDp394IYUBbTkXkdOxgSEV95ZYKE7FWFbUsrr7l3cximtNSF2DORE5XMPuj
         RIWR1auQ6H1lzhMAczwxLxiaD8A70zxY9OTfKxjmXWdUVkJrpEo86er9phachPVoAKA6
         GGqJvqkfwS0Ve39+azPq+ttWOhu0DjytaKQyGI1hprPlcAhzW8jGq6rJY4tcTZucVBBa
         ZCzuCHbm6WDWKuDr3uF3OrQtfrZhhBcw9zN1lZRvEoXA46WWJnGaDtQcBwpzF0l0sJoR
         wmatelaQRxOek+HLgJuPRlPhWTNsbivFXUmjhTEHv3ISkuieJONlCVj3cWJlQe1xJaHv
         p7Wg==
X-Gm-Message-State: AOJu0Yyt3rkY9rd5X885Au5cWxYYhywabrCqHIn4eaL74LYH3CRdNugb
        /1XDjTD9EsfS9WE903n3rOA=
X-Google-Smtp-Source: AGHT+IH/ZV7YXX4NiEwT0xnxwNSN6YFUbRam+I4C1qDFpuGDwrSQrE7rRyGcyXBU50rSToFzJRlY8Q==
X-Received: by 2002:a17:902:6507:b0:1b8:c1f:fd2c with SMTP id b7-20020a170902650700b001b80c1ffd2cmr195154plk.33.1693340603373;
        Tue, 29 Aug 2023 13:23:23 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id v11-20020a170902d68b00b001bdc2d10753sm9707929ply.215.2023.08.29.13.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 13:23:22 -0700 (PDT)
Message-ID: <3d3f693c-c6b2-9bfe-6293-2ef623d7e7dd@gmail.com>
Date:   Tue, 29 Aug 2023 13:23:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.4 000/129] 6.4.13-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230828101157.383363777@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/23 03:11, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.13 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

