Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692C1757004
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 00:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjGQWu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 18:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjGQWuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 18:50:10 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88858115;
        Mon, 17 Jul 2023 15:50:09 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-26309247002so2973625a91.0;
        Mon, 17 Jul 2023 15:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689634209; x=1692226209;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=R16wYXJMzLsEsj3FtQgk/CvxzmydOiyAt9JWzQt8uoI=;
        b=BiRNYGFnwAYfIznKKt9FOgRGm5RuU/GMsOekFTRwD5/ies/HlrT1t6cqP6E6zr0+qI
         i6WJvatIh0quRDU3EUiLVxMVqYpJq7WiW64j35gqQ5kHaCMwTBzolkY5amKFFf6lQoZt
         hR6AKx/KyEah19OAxfqtT1SILtRugoDkDSxRYNvkI6TyrElqjbL9Fbrc+F8JFC3+nG/0
         TWLnWdg5x5969gkruFmZywVN8SciJB7HTMPlOCA0szFhGFAY9LOgx9srpCj7HZZALOiO
         SEX+yGro0YOHWYbUb9e5UAhfSJaGwgkWFjqgGTI67k//nD2IX2kbU78qtOYQcj9mIenY
         XmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689634209; x=1692226209;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R16wYXJMzLsEsj3FtQgk/CvxzmydOiyAt9JWzQt8uoI=;
        b=MAOyMSbiSEKSXwGlyyTxRI19XcCc0E3OT5mNubKMyccC2disj5k1kj/JYN2r6Wckk1
         w5BE1McLIKrslfJtM3YpQ7lg98phjXwoorliwPhEFfj/la1nKy//+tQYTS1rR3ckGk4c
         5nihG7orru0Kb1ymhe0tpd0GuIivmuCpcMq2SFKmdR744prJzciBuyXLwMcChri8t+nH
         WDtLP9tyeboICy4stG+B4II+1uqUBy0Lhgx9MdJD6bY3MTQcC5eAgthURVNIq4d/yZZL
         RbUzzSouzbR9WAKgx28wA0uDvAw4XpqDIp8iHgcrGPHmrgHyzQP87+xMK6wAwSZgR6J5
         Z+gg==
X-Gm-Message-State: ABy/qLagC4+/qq9OhR5fj8i6Bfy5iezdUhDZc1d5Z0jnbgULw6bKExO0
        cLc0JsYgHcJdpFvXJ+NF1u8=
X-Google-Smtp-Source: APBJJlEXGgThbxa04zY5Ja8vhwJhXfm/sbZHKWKosW+tHnHT8l0v/jmiwi9K0QzqLXj9Frb/0e/6KA==
X-Received: by 2002:a17:90a:f189:b0:262:ff1c:bc33 with SMTP id bv9-20020a17090af18900b00262ff1cbc33mr387194pjb.13.1689634208919;
        Mon, 17 Jul 2023 15:50:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id me13-20020a17090b17cd00b00263dccf96a3sm261125pjb.54.2023.07.17.15.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 15:50:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9705c130-997d-6356-18bc-ee5ce5d8b325@roeck-us.net>
Date:   Mon, 17 Jul 2023 15:50:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.1 000/589] 6.1.39-rc3 review
Content-Language: en-US
To:     Paul Barker <paul.barker.ct@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230717201547.359923764@linuxfoundation.org>
 <9da5f8cb-5ed0-1854-0a0a-252794e01ce3@bp.renesas.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <9da5f8cb-5ed0-1854-0a0a-252794e01ce3@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/23 15:39, Paul Barker wrote:
> Hi Greg,
> 
> On 17/07/2023 21:34, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 6.1.39 release.
>> There are 589 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Wed, 19 Jul 2023 20:14:46 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.39-rc3.gz
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
>>
> 
> Building i386_defconfig in my Yocto Project environment (with gcc 13) fails:
> 
> | /.../kernel/workqueue.c: In function 'get_work_pwq':
> | /.../kernel/workqueue.c:706:24: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
> |   706 |                 return (void *)(data & WORK_STRUCT_WQ_DATA_MASK);
> |       |                        ^
> | /.../kernel/workqueue.c: In function 'get_work_pool':
> | /.../kernel/workqueue.c:734:25: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
> |   734 |                 return ((struct pool_workqueue *)
> |       |                         ^
> | /.../kernel/workqueue.c: In function 'get_work_pool_id':
> | /.../kernel/workqueue.c:756:25: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
> |   756 |                 return ((struct pool_workqueue *)
> |       |                         ^
> 
> Cherry-picking afa4bb778e48d79e4a642ed41e3b4e0de7489a6c from mainline fixes the build for me.
> 

That is not a new problem, though. I see the same problem with v6.1.38
and with v6.1 if I try to build with gcc 13.1.

Guenter

