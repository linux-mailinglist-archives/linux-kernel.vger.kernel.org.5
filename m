Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332E67A8A75
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjITRV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjITRV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:21:27 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAB2A3;
        Wed, 20 Sep 2023 10:21:21 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68cbbff84f6so794820b3a.1;
        Wed, 20 Sep 2023 10:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695230481; x=1695835281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Bu8XpvjZ8gfoAYQP/ge6F6IM0gqUOA+cRgVZfRXgSY=;
        b=QRZcxU8SJSfhYtd79mLzY4yxT6dweHwCQeSzuFR91N4/HBANadoXmzIucwCGYkMOYN
         WhAOxXiwz+nx2gpjZmBA8Mjoo8AkrQA9Whqo05P57cP7kL69Tg6vN0GXcny4u5kmy51Z
         Ju17vTk3aw8c3uwv/kDSr+OnQrYAwBIumYvSnRm/VPjzQanS8wju7bL3c6eNIfluJuxr
         VEC03J51cJskLQDzZzRCWa3h7I9HH5nIjTiTKqZezHqKydaKrTBkYCQF0Z4f0PyBQ2dX
         1MpgnDRQOzQ2Yq3J2mvOTbIJxO9dy2oE1SXzC/jLGTF4NYZX08wOo6wVEpODGuNq/4xo
         NwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695230481; x=1695835281;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Bu8XpvjZ8gfoAYQP/ge6F6IM0gqUOA+cRgVZfRXgSY=;
        b=Z76HKJgR25IakCkX2S92bxR37kxgfEdzCaxBk+bvztOdLfzo3iIFdJJgRRcorwfZOz
         HY2Bex7YiEfNo8CP5Doq2NYQnW28Wh044baeaor3PAZJpwHFtS8vEt0yP7WeKbjhAjjM
         Uui657/TcnD0ZCozBM9fcC8sOVSQqx3YDcmls/GhpO3eQOM5a7Z9Lu++gPQEXQH6LiIR
         6OxoY7FKztLTv7i6rx5u3KcDHayi9VwiuDqGqbyUkeAuC5IGNSpr5WU2zsVEEIftIIgU
         aCtgMsbIKqWfygc39Z5G26fykxh4tWZn68aW5avy1h1SrFFw6143R1Do18v+is2fw1TF
         i47Q==
X-Gm-Message-State: AOJu0YyqTYVbXf08dJsYU5T67I7v77sJNxHAKE+I+5T1qUmrSqXdPizf
        eoRJ1589a0DvK5PUOE9khFc=
X-Google-Smtp-Source: AGHT+IEMY5ePH5jK9wyR98gxFyTuY52Atn0lCRfd+ThGE3tsETj0oFGpKKAAY4utQB0EgSyEqZdpcQ==
X-Received: by 2002:a05:6a21:999c:b0:155:1710:664a with SMTP id ve28-20020a056a21999c00b001551710664amr5102634pzb.18.1695230481142;
        Wed, 20 Sep 2023 10:21:21 -0700 (PDT)
Received: from [10.67.49.139] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id p9-20020a056a0026c900b00690c52267easm2954411pfw.40.2023.09.20.10.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 10:21:20 -0700 (PDT)
Message-ID: <166b5b43-adab-7d00-e3f6-c9a1dfd29f52@gmail.com>
Date:   Wed, 20 Sep 2023 10:21:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5.4 000/367] 5.4.257-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230920112858.471730572@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
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

On 9/20/23 04:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.257 release.
> There are 367 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.257-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

perf does not build with:

libbpf.c: In function 'bpf_object__close':
libbpf.c:4205:15: error: 'struct bpf_object' has no member named 
'btf_vmlinux'
   btf__free(obj->btf_vmlinux);
                ^~

due to 34d66b750e83d49c7d3d33d59e6a1b49e0d5db15 ("libbpf: Free 
btf_vmlinux when closing bpf_object")

the btf_vmlinux member was introduced with 
a6ed02cac690b635dbb938690e795812ce1e14ca ("libbpf: Load btf_vmlinux only 
once per object.") which is only in >= 5.6.

Suggset we drop that commit.
-- 
Florian

