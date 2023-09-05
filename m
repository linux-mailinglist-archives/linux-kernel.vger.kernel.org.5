Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1434C793094
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbjIEVBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjIEVBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:01:18 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4520BAC;
        Tue,  5 Sep 2023 14:01:15 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-76da22c090dso176640685a.2;
        Tue, 05 Sep 2023 14:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693947674; x=1694552474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UkbcyPlypG/y4wAG7EhwouSp+fvI1ifnR0lvfN/ArfY=;
        b=nOosD+QmuyDrpm3Gtb9IpBArU/OTaF3aYot6TX4s7iohpxENJLWIyAtmeF1WjsF58H
         lMmiQaXEFyF1BoTMoK3jhjp+oR91tcn8YRAz+GWiExUgA2jY1VNixK3O17Md9Ce+OR3A
         k2dAwbGTJ7UVsU4nzxnAToyG30nGKVrcMb32J1MsQFz1I39DQXK35uqRY5RWuO0/fFK6
         +wYVBs9mNPrmYEGsaZ0R6OY0/THcy2CyRsfzGUvZP7XkC3X3da35tK2SkH+vViCt40fu
         nYHlEL1ZPczUVbfH8COzFRllKtCwdut7GBxMWzuGMdFJVgWPj9VoHgJIRJihqvYoizmF
         QiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693947674; x=1694552474;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UkbcyPlypG/y4wAG7EhwouSp+fvI1ifnR0lvfN/ArfY=;
        b=aOFo/OfrYZzDxK8imQYcm/b3dlyCjjXxfu02fR3sscIqNC6mblEV3IyViZltyeZnzS
         62p7QkM2nbcCPKwurhqV9dhhn87P12gR6kaKbsW2gQanXYzv1RmRSrnIPUiacq80IFen
         STuIKsNQSaqg/Pl9aIlc45WB5vZxLQNxc3CLdGZTCnGLbAVaSHNEENdg4eLBg+cVX/l4
         FPzAVY+SYbFb2VfEZ6kDtkKcxrNfogRonGetaqvbVWX4ykiyi2YjWNxiNdSMNIUGilfV
         Je/4WjqsN4OwhYCU7r6Ip7Q1ouFTxJjSGLWdu1oCVElkSXJxYgh7PK3wKJ1ZCvbkEpTV
         +X7g==
X-Gm-Message-State: AOJu0YynMKZ0rzKc+irtYcW4US8ilU+fnKvDHM9V6FHWKBQ+bWUYxfZ/
        EBGJToHUHEvZs5GRRLi0R8c=
X-Google-Smtp-Source: AGHT+IFtGzKMy07ySd6obZfnUISJPd/4918qznY9cK5aT+WdE/lcKDBRZ8lo5G8awRYIr+ztYcb4Gg==
X-Received: by 2002:a05:620a:4004:b0:76f:3e5:8b59 with SMTP id h4-20020a05620a400400b0076f03e58b59mr17268977qko.15.1693947674318;
        Tue, 05 Sep 2023 14:01:14 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id i2-20020a05620a074200b007676f3859fasm4390702qki.30.2023.09.05.14.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 14:01:13 -0700 (PDT)
Message-ID: <f32910b1-ac50-d387-81c3-9e1142eb63c1@gmail.com>
Date:   Tue, 5 Sep 2023 14:01:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.4 00/32] 6.4.15-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230904182947.899158313@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20230904182947.899158313@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/2023 11:29 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.15 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Sep 2023 18:29:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.15-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

