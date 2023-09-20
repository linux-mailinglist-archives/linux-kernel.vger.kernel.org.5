Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8EA7A8CEE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjITTar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjITTai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:30:38 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09F4CE8;
        Wed, 20 Sep 2023 12:30:00 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c59c40b840so1189565ad.3;
        Wed, 20 Sep 2023 12:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695238195; x=1695842995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sUlxpDvphMvioljxEZkNm9H9LA+4RY/SFbC6XXedRTw=;
        b=ASD+BNWovAiBra66V2QKTPel/fYx4WENK7t9hrVQr5jTojdgj7oISZGSJTiwhSZT9V
         IFFJ/OVEGFjvyEecRszc2VybpqYm6c4hkoz63Kvq0PRbsanv8qjILSJ+AfzJTLHttxZp
         zEqGM/MQBF6r/QLOw8bPYXm5EjgeBzkjmcxpxKnR71FFsE/g0JjVVTV8xSzDVAXD2650
         yuHQkakVp/ibI4wkDEAGh3g7EaMzGKv1IRD8paDkBw8ITZscwXGTphrtdqdUOLSNuzoH
         +PJwGZs1BcurvahS9b7BvA007UXAR1psPvpBiUEr5qHjgZDRJTRTH3kiIsB/8vDW9/8r
         5gZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695238195; x=1695842995;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sUlxpDvphMvioljxEZkNm9H9LA+4RY/SFbC6XXedRTw=;
        b=f2Mja0IvkOJCCAXBY/Otg0nOGR+rbmlqk4DbaOHZ0tAxgU0n/4C56l5VQaQzdAUksd
         x2OR1ak76LYM9PNYeD/pJsKy5vdi9pHQ+rzRf4sYLJ1+FOMndGJNuejFLkdleedH2URx
         q1hiTtiUFq2/INLAn1fMfzQJDkX8sdfXyyH3ZUCl8TAZ6j75uhdXoptP9/IBLMHlTU2H
         tQ9oGgNj1gIPUoBN3pFPi3ItMBIOWzGaHE3EGgUY4OIKdm52egKIEFoKOEzvwEv0dYEd
         AJnbQlcWufnTvZfcd4RmmMxpXDiCu803+X43tCDwcSnAeKIUQx7cNonF5+HaMdi0XQWH
         bHdg==
X-Gm-Message-State: AOJu0YziPSsVCflhV/+3aLDV+nr7oNvwndkki+KPz4vID+xTw49QVM18
        GWEaGbiU+KDLQCz2z8JrM6I=
X-Google-Smtp-Source: AGHT+IFzCe9v4enWMqD8aJlN8WVdwg5w2F6MgrYVy9VIPVO0fjAfqUhk7kgjFnoWDx4oCn1gTQTlmA==
X-Received: by 2002:a17:903:120b:b0:1c3:1167:26e4 with SMTP id l11-20020a170903120b00b001c3116726e4mr3725633plh.60.1695238194996;
        Wed, 20 Sep 2023 12:29:54 -0700 (PDT)
Received: from [10.67.49.139] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id iw13-20020a170903044d00b001c582de968dsm4964589plb.72.2023.09.20.12.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 12:29:54 -0700 (PDT)
Message-ID: <d48fb8da-c170-0c79-9ffe-152bc07ce819@gmail.com>
Date:   Wed, 20 Sep 2023 12:29:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6.1 000/139] 6.1.55-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230920112835.549467415@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230920112835.549467415@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 04:28, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.55 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.55-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

