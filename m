Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5617EE835
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 21:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjKPURf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 15:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKPURd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 15:17:33 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF00131;
        Thu, 16 Nov 2023 12:17:30 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-66d24ccc6f2so21332466d6.0;
        Thu, 16 Nov 2023 12:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700165849; x=1700770649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jA8Kf2xvnSFH4T2vRR6MMovJYoXzknMX/4kPrbr3RB4=;
        b=RejgJtWM4Cc2EE3InVWa35rFL51Ljlq0zU4pb/mWxtnY0FIOj1vzI4TWSPfj9qAOW+
         pkEa8zfK1YI4knwVuLxfVnBOVK1RBoMqgbsPH9cCFjbHK5HriQSuD8Bqporjo1zbaUjb
         p/D/DM8vP171mIFgearOsAE/yQIsDzZR8OpMDRjNlX9ahSPKz4IFZP2UwZE1oaWwoEsy
         lFaObI5g5oVpk/pmTsblYW2v5NcTu8vSMjK6rupe6ym6bdDyYMVDTAVi40N+OhhsJWV9
         2zRKV/Jm6n+VxQWUokVO/7Qu6HUUxRhkqp2S5u2MQJLnIfiY+5ke05A1ThTz06RQqceK
         lgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700165849; x=1700770649;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jA8Kf2xvnSFH4T2vRR6MMovJYoXzknMX/4kPrbr3RB4=;
        b=XN2owaH1eoauwkR2VVPjokkkRI+PrcEZpo+TUrTeEYL2RC7ztD3MJKuJiDF83Lf5ak
         w3YlA9MGTn7kaB6IbFWhIs0HvL+cctfrY/YCUMkgmJoLVOMo97e4zNDSSZ3FLLjeBUr5
         M3d3svrwezXdt8r7ce836VBulyh6lY5ZWQP/woGp9/pr5Y/oCesajP2+RIgF/0z+Y1oO
         lalfNWhwyn3WugO0mXXfWm3oSR8W1zx7M07KKyz1vq+fGuWKjs2jIkhkMqkyHEhF9brb
         aFm8h9e+AtI0XgaDLAAMFUqZzxnCfoo0huJSzNqj3aOE0J9UMfVlVzy+b3PDXnijaH1U
         DXsQ==
X-Gm-Message-State: AOJu0Yyv3v53IXjiRYtjU0UXPOCLlOx24wPVzqSPMXVUrc6tgONN9y4r
        HILvqNjru/UJy6pUXlFU3dU=
X-Google-Smtp-Source: AGHT+IEBR5eQSqIyrMm+k6Ud8Nw4s21ElqriwLQkbTlLqTJCI8hd1WMpEWFgPawnRXbHpEEbWmQ82g==
X-Received: by 2002:a05:6214:161:b0:66d:2ec5:c1b9 with SMTP id y1-20020a056214016100b0066d2ec5c1b9mr3827300qvs.11.1700165849521;
        Thu, 16 Nov 2023 12:17:29 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id c10-20020a056214070a00b0065d1380dd17sm45796qvz.61.2023.11.16.12.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 12:17:28 -0800 (PST)
Message-ID: <9e94d5ad-d682-4193-b965-edea91a9fbb4@gmail.com>
Date:   Thu, 16 Nov 2023 12:17:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/603] 6.6.2-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231115191613.097702445@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/23 11:09, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.2 release.
> There are 603 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 Nov 2023 19:14:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

