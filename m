Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF527EE814
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 21:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345529AbjKPUFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 15:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345528AbjKPUFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 15:05:42 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A362196;
        Thu, 16 Nov 2023 12:05:39 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-778711ee748so73066585a.2;
        Thu, 16 Nov 2023 12:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700165138; x=1700769938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XP8UF2SywWm6uvEiv3yQBU5bbISulYs0tmRsi39B+rQ=;
        b=Oe460IPl3b9E7M8VT8XzIZoz5G2Su/VIb/LQZiwCwfh64E3qjiMRGft/+lZnB63d7y
         XvF2y+aVzE7BKfmm09kFWaQ67c4fbx4K+vwysFkSovLNKjxspZt/QMgll4GoLpm4MWx6
         vUluf4IcuLgiBLiaLA2VHBfUiemGzh0IJ40trcws3R4/c+KAIx9F299NEfor+VVtOLoJ
         jIe9cqtVovxIjjJgScVo1bA15nKByz3lfz7aoMmBjk/ltEiB1Q0UVXxpqeOhMOJ9IQGx
         TixTFWsPiZKjJBy/2uQP30QzgN6HrAwWlm1gJih6+sICgszazt+eZnETotrG8FQkvml0
         Onxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700165138; x=1700769938;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XP8UF2SywWm6uvEiv3yQBU5bbISulYs0tmRsi39B+rQ=;
        b=F8Ofeib3dpPhIgB4sV1Iuin930rxCfUmvU3RBDI2eW/5qPDzMwi27n8D85xICp6fxt
         8h6ClJ43JHuX079ZAnnUrmQJyWNpT5Z1lGpYP/rAC3FU4xxwUj5bytaHtfFyXAQkyWtX
         xKTfBXqwv9PAheVwH78oCmkA1+3QkJRhoBmeY+mIclcrXt8KbgLhFtWo+M8YkOuwlwGj
         4dHd8NSBgLlz/YzVKYn6dzxiVLkFQCY38mza8Ec/oUcYcJORy3P+E0jqlNgD2p3hejzB
         HFM+Hb3z2/ZQG8PjaUlp3xe0hQfjImpV9WljRxosTr2zogDQaIUdZnrO8mGVrQa+tOqQ
         q3Dw==
X-Gm-Message-State: AOJu0YxjG33VsEPOXJ2TUDyh5G2MkLgSu4BmBFz2m+Q1BM6bkXveoDFX
        xMK+vEh0xml3EDT/PwMS3WE=
X-Google-Smtp-Source: AGHT+IE0rXw4mwZQi9/52TosY+1L9ojppFoOTRaT6/GO5DyaXFESEwXgi5vZk4i3eF/DKYcdk5ambA==
X-Received: by 2002:a05:620a:bca:b0:76d:2725:f36f with SMTP id s10-20020a05620a0bca00b0076d2725f36fmr12213399qki.71.1700165138249;
        Thu, 16 Nov 2023 12:05:38 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id tp9-20020a05620a3c8900b00775afce4235sm49161qkn.131.2023.11.16.12.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 12:05:37 -0800 (PST)
Message-ID: <7d953999-5303-4fb9-9a2f-66c31a54bffb@gmail.com>
Date:   Thu, 16 Nov 2023 12:05:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.5 000/550] 6.5.12-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231115191600.708733204@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
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
> This is the start of the stable review cycle for the 6.5.12 release.
> There are 550 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 Nov 2023 19:14:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
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

