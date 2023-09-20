Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AD57A8E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 23:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjITV2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 17:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjITV2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 17:28:54 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30639C9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 14:28:48 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-79f7d596279so4526439f.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 14:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695245327; x=1695850127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+2tU7WgIdeqMFoUWsvwgrS0UpcgpoQLXurBiEI1oqgk=;
        b=Xmf4MguvNnu35K32tGwUGwRIPTSQ/qYRqRumyyrgVFaW4WgWj6WMswGkdD12nv7VoH
         7/fKTtFP1MX5IiS7s4aoqBi2tEJyNtmN45oR8MfiD5HZrlZ0no9VytAtv4JmIHgJzCoY
         1miV2nhpypdSyeIysTklp5P3XBRGHo5HEjaU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695245327; x=1695850127;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+2tU7WgIdeqMFoUWsvwgrS0UpcgpoQLXurBiEI1oqgk=;
        b=kFJJQSmObmy261uk42LTVl/J8v0P6NR1xddyiIMd5STg/0EU5uHQrCcWf8cptir82R
         X+Xml/BAyIkXeTm09dPH3Cd1BvLlLDkykUfBn2Zgt1Akt2H0sNudZba2N3b9847AyXI5
         iRoKLnNm8pEOYzDMa7da2+bGH8PFk2Pz0mioDZrSwbCOkWxW8yURb7d/rvdlcWZUHdNa
         DuAGHkaSX+3J56Lvc9NNYto0iRc9F8D+lcYvpvS4CCWW9FJZrnhn/Ys9aUp6SIRP+vqe
         bkfM6Ob7mxPom/P5JFh/7IYJvskpVcicI6uunDzo4Cp9myBixwBzoD8ObDNij5FDP4qb
         WEqg==
X-Gm-Message-State: AOJu0YyBO0DggzR8sfRBpZLtHRFJ3N6dY+HWmWA85aqPv72piKf9KxTQ
        ZznG132A78UQfMrLKwy6yEY4AA==
X-Google-Smtp-Source: AGHT+IHmFil7972NKUJ3vWb9mLeobhcI3iGZsatlWHXlyJS/jrbNxe7e15O42qmMG1XTDBfTtahfSg==
X-Received: by 2002:a05:6602:13c2:b0:79d:1c65:9bde with SMTP id o2-20020a05660213c200b0079d1c659bdemr5568258iov.1.1695245327395;
        Wed, 20 Sep 2023 14:28:47 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id a31-20020a029422000000b00439d4db47b6sm2362220jai.39.2023.09.20.14.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 14:28:46 -0700 (PDT)
Message-ID: <1e76d4cb-aa5a-4e8e-7019-2095d97d3fb8@linuxfoundation.org>
Date:   Wed, 20 Sep 2023 15:28:46 -0600
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
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230920112835.549467415@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230920112835.549467415@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 05:28, Greg Kroah-Hartman wrote:
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
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
