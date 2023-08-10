Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D355A7775B7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbjHJKZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjHJKZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:25:35 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA42983;
        Thu, 10 Aug 2023 03:25:34 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bb84194bf3so5363555ad.3;
        Thu, 10 Aug 2023 03:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691663134; x=1692267934;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Spf52dVKy0lT8vvfU1TgufHFM9V4XApAOmPWeXdI0zY=;
        b=fFFB0rdFgZ39f2Zx0GXGpN+1NXfR/iHWpgEnbOTISkpkJFGoto8EQmkSqcyg9Klj22
         c3adwbWeS2WaGQY3nvhNEVlT1QFsP0R+xgfXgdGOSwHAMsCDsM59NMfSxL88luXZipGN
         AbcN01FxVSpTLNErg97zNxHSeT5IeJOFJZZjGbnUqoCozUNtwZfrowBAAOU/VRaY1qNp
         syyYaIWzdfdYtx8ogWgqOS6SuBEPHiCe4oSzYF4B5QUnNyvawbI1FaYBVN1EdNwPE3lG
         7/w6pWZpzAxc/I42ORbZLUSIsxdju2AEvMbbSpiqTcWnq/hxzVLVOavMRv8GHE4Gy7Hd
         a8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691663134; x=1692267934;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Spf52dVKy0lT8vvfU1TgufHFM9V4XApAOmPWeXdI0zY=;
        b=keu4/QE484ckhp5Jbfe0CzxpWxy8vBdToLGSX498XI2ELki4LBpVXcV8zxV3yuyw6g
         Hv3fLYerNoAxVW21fG8V4H5tG+RGEljTAWquF27PVE3ZVSPA4/4hK/CT6G+k64paiwdb
         uKXOSD3rLqQ8S6Or2QjasSkEkxrum/Whn7H4fqIrsQWjpFzuNP10nUvVos/+C4w7u0Nn
         m44pMqrji7fAHUCL3x352HZjUU2A4xEkaubCZqzMzZ8mQCkq39FZwFQFdIqC8MaHBvHm
         rpVu+OesZTArK6LimXKdN9zjDThQseIGMvzkWiMfQyoDPkg/AMUKlH3C3/CQ9Ngyvlge
         Glvg==
X-Gm-Message-State: AOJu0YzSbZaTIORewutFKnqUBv7Rjofa+NVpb6wo4bVcUX8L6vXS4MMB
        I92QHFfaH1ycyp4X5LKEFj0=
X-Google-Smtp-Source: AGHT+IFQIdLON0+nJgNacBCPfCvvVgaMkTLhUoah8NUjx9nn51eQA3rDYuy1W35F0i/Yh7k496Y7yQ==
X-Received: by 2002:a17:902:868e:b0:1bb:3a7:6af7 with SMTP id g14-20020a170902868e00b001bb03a76af7mr1648591plo.23.1691663134269;
        Thu, 10 Aug 2023 03:25:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902788900b001bc6536051bsm1336081pll.184.2023.08.10.03.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 03:25:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3773188c-cb57-6b8c-1c7f-ce3250e203d1@roeck-us.net>
Date:   Thu, 10 Aug 2023 03:25:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.15 00/92] 5.15.126-rc1 review
Content-Language: en-US
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20230809103633.485906560@linuxfoundation.org>
 <3474ec1e-eb15-b2a0-003c-327d6fd17708@oracle.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <3474ec1e-eb15-b2a0-003c-327d6fd17708@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/23 03:16, Harshit Mogalapalli wrote:
> Hi Greg,
> 
> On 09/08/23 4:10 pm, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 5.15.126 release.
>> There are 92 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
>> Anything received after that time might be too late.
>>
> No problems seen on x86_64 and aarch64.
> 

fwiw, aarch64:allmodconfig doesn't compile.

Guenter

> Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> 
> Thanks,
> Harshit
> 
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.126-rc1.gz
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
>>

