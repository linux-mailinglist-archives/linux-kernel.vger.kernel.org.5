Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABAD7BA6DE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjJEQnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbjJEQkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:40:45 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7611BF2;
        Thu,  5 Oct 2023 09:28:59 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3ae5ce4a4ceso791427b6e.1;
        Thu, 05 Oct 2023 09:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696523320; x=1697128120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LCjL1Nhcx+ZRfFxrSaIUnghupuRDrTl5Dh+1IzKptGc=;
        b=fP86GS/ZzkkWYAA1mFO2QBbW9be18fs/GwTT4cMWiJLOCIV0XDa92fASSpalFl8/md
         py+58XbKGNNpRNMOcVmc3hSZ8+trTWaAdb8pgLqxQPsYhof3ZmfdphLBp+oOyDIpv/81
         URfM6KGgqCeWwo2s94rRfJOlV9qBI7uD2O0k2M3Msfc1TXJoCeFfzUHvCeZWZjC9hEvS
         l34QzM8EuI4PQ9dwb1X6JLnBWn+upFjenjWSLdDdFEsDo46SRxWFNthYjdpXI1luXQ8k
         EOfdgyEFNZeXZW4ctG4yMGfg0rRK/mFszNP3HB4adQ5lSIPF9ERLjTwaBpdQbOaqdsvg
         5kTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696523320; x=1697128120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LCjL1Nhcx+ZRfFxrSaIUnghupuRDrTl5Dh+1IzKptGc=;
        b=YluYg2sHk16WNy68UietFxRB2GIbVht+stbffRqbpnmST63MrKVnt1cb6VxKcXYRVJ
         b/UMQm/2pefFhTGvOiiM6srWLswDqoHHkgIiusUGh4X4oLYEqxCgXX0CtUZds3vP3lvP
         z/IQkELSk1LnZxFfBBe+OuWnSdEv3GVvm/ZnrubtY34FzLZwF6yNBLnUXwGXwPQtwE/g
         lP+OMhEH8iZEpVi04M7wYBHcKIE6AwVvmVnXvwBHPw09000fg83ri+NjEAxsqg7P99XE
         SlwGYbT/9YgS8DHvxq/3h1vpN9DB9EOiprpJvzpOs+CM6hHIiam2Qp6sCCVRapmKiDze
         rQZQ==
X-Gm-Message-State: AOJu0YwDe0maUfVLTwf6bVcSeY1M3FMJgMRsQwJ/tJcB47RtR4UsBeG9
        PAEa1VE+lNN2XEWPs+98XkA=
X-Google-Smtp-Source: AGHT+IGxlPwo0Y0oep9fIBEaUahI/dpFBN6J/y7Ev9r8LwvBmovuSH0MCYGFHfryby1oHxSSBQbKZQ==
X-Received: by 2002:a05:6808:1306:b0:3ae:1e08:4209 with SMTP id y6-20020a056808130600b003ae1e084209mr7930890oiv.39.1696523319965;
        Thu, 05 Oct 2023 09:28:39 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d26-20020a63991a000000b0057a868900a9sm1598513pge.67.2023.10.05.09.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 09:28:39 -0700 (PDT)
Message-ID: <4628ee76-0bbe-48f4-80e0-a6d4a4dc6811@gmail.com>
Date:   Thu, 5 Oct 2023 09:28:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.5 000/321] 6.5.6-rc1 review
Content-Language: en-US
To:     Ron Economos <re@w6rz.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231004175229.211487444@linuxfoundation.org>
 <be48ca60-57dd-9bbb-d695-0d9d39e98dae@w6rz.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <be48ca60-57dd-9bbb-d695-0d9d39e98dae@w6rz.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/23 00:24, Ron Economos wrote:
> On 10/4/23 10:52 AM, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 6.5.6 release.
>> There are 321 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.6-rc1.gz
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
>>
> On RISC-V RV64. Bisecting now.

Naresh already reported that they have tracked down missing commits, see:

https://lore.kernel.org/r/CA+G9fYvHPnba-0=uGS70EjcPgHht13j3s-_fmd2=srL0xyPjNg@mail.gmail.com
-- 
Florian

