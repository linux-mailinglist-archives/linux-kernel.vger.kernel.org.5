Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D2D763D1A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 19:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjGZRAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 13:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjGZRAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:00:32 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2DF13D;
        Wed, 26 Jul 2023 10:00:32 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-55b0e7efb1cso3647310a12.1;
        Wed, 26 Jul 2023 10:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690390831; x=1690995631;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GRXFgTXwEMCksEqkmAG7j7rHI7ptzJ+wrSewIU7zYRk=;
        b=hVlx7E50I8QXnsT9P97cs1HAMPqrmoO1gfTpfHiwzixeU95QEBPAQR9waHDHdb/JuP
         Js2fzSxRvnWHK40CsqGrB5PXJMB/3SyNlAz7Opetpus1Yb6C2TZCfy8uSjhZGjqj1TeB
         LiH7WQti+8nlCnXTZL6yNBuOG9M9fVUzgxAYA+tvjA8aKGb4RMcPC/EldhW+kTX8phtc
         0V3JhDsRuCYZEFtCqTLMn+boDze2tqxr//rcD76Efn70YbyVFjHoxQDLlnqm1vLz68ke
         C2iPktyGdQouYoUOE42JfHOHnfnF4egggOmydQ7arfGts+6W3ZOLcsbedqEm2uzHHYM3
         gvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690390831; x=1690995631;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GRXFgTXwEMCksEqkmAG7j7rHI7ptzJ+wrSewIU7zYRk=;
        b=AkfL/VK0j07mNJvRdlF4HPHN/Sw00iZu9R+8JuA8OfFmNxfLeb8l3pazZ5LKbzER9g
         DFGjD240mq+Ghoo2OJjr4uyd3pwwyuK5RFk318I3rq8Rsxl5BD8z0Cy6YXCSamw6v4+r
         qKiP4my3k3uyp+xyAfb2ceJcxLl/SGyCvasouTVBAnXLMZqDBbSJeCcBSN6x3wF89poV
         lWMR3x9265gI8fhmseCUDGmEBUPDanFzB7aHzd2nssQZQ2pyibddgxmcteHdkUPCFf7p
         jbFeOdE9Vlwm7e4dh8+5/ZY4EkCt+jhTOkuynjXa5PC6SieF95xkDUaVrXKTnzinRuwF
         IqZQ==
X-Gm-Message-State: ABy/qLaBLwDmB+KBBn6bwyrEX5ilN4EtjTGOWD46rgSOW3J/g5F7mnvM
        DZROAdZx9pOgDUcfxUWz5AA=
X-Google-Smtp-Source: APBJJlHlmQt5qUdMqMWWQeb/Dn/+EsZmfh/FeLlUckZByDjyiPEVj4bCMi6MqUU2oiFNaRjmA0UfHg==
X-Received: by 2002:a17:90a:74cd:b0:263:9e9b:5586 with SMTP id p13-20020a17090a74cd00b002639e9b5586mr2123026pjl.44.1690390831295;
        Wed, 26 Jul 2023 10:00:31 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id b20-20020a17090aa59400b00268160c6bb8sm1478834pjq.31.2023.07.26.10.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 10:00:30 -0700 (PDT)
Message-ID: <4b2bdca4-278e-c6b2-0cba-31b5baed472a@gmail.com>
Date:   Wed, 26 Jul 2023 10:00:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.4 000/310] 5.4.251-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230726045247.338066179@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230726045247.338066179@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/23 21:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.251 release.
> There are 310 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 28 Jul 2023 04:51:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.251-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

