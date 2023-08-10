Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E249777A97
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbjHJOYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbjHJOYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:24:35 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8214A26BA;
        Thu, 10 Aug 2023 07:24:35 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bda9207132so3417025ad.0;
        Thu, 10 Aug 2023 07:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691677475; x=1692282275;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=g7aVWMgiSCY8pbrReUeQfTDqSM2NOWq1Su86uIhB8xM=;
        b=ShmnbVqmdpWKk1Bgj5jhiPZZm9hzZaSTST7U59fSdo73Q6AsKb3l3uzMBfg1SHwa4H
         efQtrx3M6oCkAl1Kcbd2XhjWxPqDp1FmuDFthIlU6GL8OAVc+/W4a4l2RBtvEFL3XVlb
         xt/nYX4BredPMGzeqm97k1/GuPQ4EbiBqGVxf3rfIAxcc3ipaftpESMGbgFEhmvpcbpl
         Wp2/O00i11o+vWbxXlC+tkRo79lXtPzwwxXYhSWmQhQjzu6lPi155Iyzypzk4Qami/Y0
         FzSxDoqIE/j2eN0zG+aqovTnrOHGKS4QhXoXc2yOrPte0TD3vnYzdpTCqCR6DcwTx9nd
         JHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691677475; x=1692282275;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7aVWMgiSCY8pbrReUeQfTDqSM2NOWq1Su86uIhB8xM=;
        b=eqt0jtmSYbLZOXEm+QpCJPasTJQe0HHwiMtn7wQSbdcQo1v3hNzHNGAoUKNFbzVK7V
         I9ze4Vw9RpJQTrXgtasSSJY3PsP0cTpthnS8cQIyM2PnswqE/0pVbs4IZDKpk2ll41ls
         S2b/q1L3OW/Enlp0zGtGkaJUzSsMT2uLFDSCHhGkNetvCA/puOqlQ/Qd55Yv88xRYuKA
         7X35+KVC7p3cTXTMU9X27CHoeZFv4mY3RER/n8p8D5cfzfM8p2Mj51LGYYVCBjpH3Clk
         DGVcP793Te1Lczny1T/OlJLtrINaRB3AUQzXG6JC1e/+xieVhIAJoHufTQAxZf74Pb4e
         PHAA==
X-Gm-Message-State: AOJu0YwUXSwrfI6FA+G1rikXWBx/z2HrQzcPJlYRsM4AlTU0xyj/Nr9D
        bk9ix2TfEsgbVeWikTmUq8c=
X-Google-Smtp-Source: AGHT+IH3n1zkaG/y/IW0v36I+eu+pJIzWmUs6Wme5ATrsdqnMBHOIrtY+Pb3D3QfBp+9lBTHE8YmvQ==
X-Received: by 2002:a17:903:11c9:b0:1bc:48d7:f29b with SMTP id q9-20020a17090311c900b001bc48d7f29bmr3008767plh.27.1691677474846;
        Thu, 10 Aug 2023 07:24:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902e84300b001bc59cd718asm1819355plg.278.2023.08.10.07.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 07:24:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fff0f61e-4260-f91a-2254-65daaffae45d@roeck-us.net>
Date:   Thu, 10 Aug 2023 07:24:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4.19 000/323] 4.19.291-rc1 review
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230809103658.104386911@linuxfoundation.org>
 <252c7673-53ee-4c4b-e5ef-5bb2c0416154@roeck-us.net>
In-Reply-To: <252c7673-53ee-4c4b-e5ef-5bb2c0416154@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/23 06:55, Guenter Roeck wrote:
> On 8/9/23 03:37, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 4.19.291 release.
>> There are 323 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
>> Anything received after that time might be too late.
>>
> 
> Building sparc64:allnoconfig ... failed
> --------------
> Error log:
> <stdin>:1335:2: warning: #warning syscall rseq not implemented [-Wcpp]
> /opt/kernel/gcc-11.4.0-2.40-nolibc/sparc64-linux/bin/../lib/gcc/sparc64-linux/11.4.0/../../../../sparc64-linux/bin/ld: warning: arch/sparc/vdso/vdso-note.o: missing .note.GNU-stack section implies executable stack
> /opt/kernel/gcc-11.4.0-2.40-nolibc/sparc64-linux/bin/../lib/gcc/sparc64-linux/11.4.0/../../../../sparc64-linux/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
> /opt/kernel/gcc-11.4.0-2.40-nolibc/sparc64-linux/bin/../lib/gcc/sparc64-linux/11.4.0/../../../../sparc64-linux/bin/ld: warning: arch/sparc/vdso/vdso32/vdso-note.o: missing .note.GNU-stack section implies executable stack
> /opt/kernel/gcc-11.4.0-2.40-nolibc/sparc64-linux/bin/../lib/gcc/sparc64-linux/11.4.0/../../../../sparc64-linux/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
> sparc64-linux-ld: init/main.o: in function `start_kernel':
> main.c:(.init.text+0x77c): undefined reference to `arch_cpu_finalize_init'
> 
> Building sparc64:tinyconfig ... failed
> --------------
> Error log:
> <stdin>:1335:2: warning: #warning syscall rseq not implemented [-Wcpp]
> /opt/kernel/gcc-11.4.0-2.40-nolibc/sparc64-linux/bin/../lib/gcc/sparc64-linux/11.4.0/../../../../sparc64-linux/bin/ld: warning: arch/sparc/vdso/vdso-note.o: missing .note.GNU-stack section implies executable stack
> /opt/kernel/gcc-11.4.0-2.40-nolibc/sparc64-linux/bin/../lib/gcc/sparc64-linux/11.4.0/../../../../sparc64-linux/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
> /opt/kernel/gcc-11.4.0-2.40-nolibc/sparc64-linux/bin/../lib/gcc/sparc64-linux/11.4.0/../../../../sparc64-linux/bin/ld: warning: arch/sparc/vdso/vdso32/vdso-note.o: missing .note.GNU-stack section implies executable stack
> /opt/kernel/gcc-11.4.0-2.40-nolibc/sparc64-linux/bin/../lib/gcc/sparc64-linux/11.4.0/../../../../sparc64-linux/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
> sparc64-linux-ld: init/main.o: in function `start_kernel':
> main.c:(.init.text+0x764): undefined reference to `arch_cpu_finalize_init'

Introduced with v4.19.290.

