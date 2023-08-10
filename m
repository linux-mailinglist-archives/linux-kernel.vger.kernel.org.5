Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C71C7779F0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 15:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbjHJNzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 09:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjHJNzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:55:11 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3D8212B;
        Thu, 10 Aug 2023 06:55:10 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-686bc261111so678400b3a.3;
        Thu, 10 Aug 2023 06:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691675710; x=1692280510;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0FFT4Yj3m1Fx8gSEUta6Yy87BbswMA7bP4LX2BOsNOo=;
        b=HTR4WuxCQgLw34Fu/f7F9IIN7w1GPtSh+s61h0N1iOhtaVSeRutK8QCMjdKTquHWLB
         CJxvv16tKKNOaEEZ4VKyW8hha/AzG6hzbpnM2bM/9sjmAvKGF9ztZtU3k6xqJ1Q/n2LP
         C+hEvjDQUHTu6EE8vjZQDWKOvHaM+qwn9Ouxr+zBejIn5FO4P0bbLv53ve5eKB8gmMRG
         Y4NamyPFTuMcSf4kt6ZRge2J4cxFVFBFM5GMqni75MW8FyeFBTNWdcfxyXaEBuIAYJOR
         kWPyeZWApPNNU8N07L63RSvqlevyw4Jp8Gpq2NN/eahycBhy4AVZOSho0ksAkwhSHyAJ
         NQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691675710; x=1692280510;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0FFT4Yj3m1Fx8gSEUta6Yy87BbswMA7bP4LX2BOsNOo=;
        b=XA6RAT5MOOsusUDGrsXV4N23dagG0hvR8J/dHG6/n/vMrFQwIwZVZGjS/mPsC1I/+g
         Xjfcts5f87OqcSuTaKWD5stMI759Lf7rpLrsUmtcIr8dM8O+4/Z3Dn7lx5y0Ix9Sh6BF
         iil5ZM65//moz40TwuX9y4Eunm6QGGhYRC8IE+/n/tVD/7nd9oX9kwBOnrs5XTNNFjnF
         Sp2kMJioDdDAW8jT/mmI6I/+14iX5wI7dCURUNxduI1s0Ob+N1n0m4l9Nki7oNQU9GS+
         FpbircAy57f3cz2BaEcbkww0kxMDDQD4ajfcLa5bHJbEShvnjZ4Q0qc7NRd7Sz2IjbL8
         TYlg==
X-Gm-Message-State: AOJu0Yyu4NV33F3YIYDZkK6pcfyxUas4r/NNBlmAW5Pe3f8iNUYl9UJk
        o6kJq7ZvwBTKGyjhCDTEPQQ=
X-Google-Smtp-Source: AGHT+IGHvjKMCqXkTKHNNLW0ZoM8HQZLa2wjK3Qu3aLpOGqLf8ZY3pHoB5TkPlNQOFbsCueBFpzjmQ==
X-Received: by 2002:a05:6a20:3d14:b0:140:fab7:4d14 with SMTP id y20-20020a056a203d1400b00140fab74d14mr2832645pzi.15.1691675709742;
        Thu, 10 Aug 2023 06:55:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h5-20020a62b405000000b00687494a59bfsm1537456pfn.61.2023.08.10.06.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 06:55:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <252c7673-53ee-4c4b-e5ef-5bb2c0416154@roeck-us.net>
Date:   Thu, 10 Aug 2023 06:55:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4.19 000/323] 4.19.291-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230809103658.104386911@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/9/23 03:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.291 release.
> There are 323 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> Anything received after that time might be too late.
> 

Building sparc64:allnoconfig ... failed
--------------
Error log:
<stdin>:1335:2: warning: #warning syscall rseq not implemented [-Wcpp]
/opt/kernel/gcc-11.4.0-2.40-nolibc/sparc64-linux/bin/../lib/gcc/sparc64-linux/11.4.0/../../../../sparc64-linux/bin/ld: warning: arch/sparc/vdso/vdso-note.o: missing .note.GNU-stack section implies executable stack
/opt/kernel/gcc-11.4.0-2.40-nolibc/sparc64-linux/bin/../lib/gcc/sparc64-linux/11.4.0/../../../../sparc64-linux/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
/opt/kernel/gcc-11.4.0-2.40-nolibc/sparc64-linux/bin/../lib/gcc/sparc64-linux/11.4.0/../../../../sparc64-linux/bin/ld: warning: arch/sparc/vdso/vdso32/vdso-note.o: missing .note.GNU-stack section implies executable stack
/opt/kernel/gcc-11.4.0-2.40-nolibc/sparc64-linux/bin/../lib/gcc/sparc64-linux/11.4.0/../../../../sparc64-linux/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
sparc64-linux-ld: init/main.o: in function `start_kernel':
main.c:(.init.text+0x77c): undefined reference to `arch_cpu_finalize_init'

Building sparc64:tinyconfig ... failed
--------------
Error log:
<stdin>:1335:2: warning: #warning syscall rseq not implemented [-Wcpp]
/opt/kernel/gcc-11.4.0-2.40-nolibc/sparc64-linux/bin/../lib/gcc/sparc64-linux/11.4.0/../../../../sparc64-linux/bin/ld: warning: arch/sparc/vdso/vdso-note.o: missing .note.GNU-stack section implies executable stack
/opt/kernel/gcc-11.4.0-2.40-nolibc/sparc64-linux/bin/../lib/gcc/sparc64-linux/11.4.0/../../../../sparc64-linux/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
/opt/kernel/gcc-11.4.0-2.40-nolibc/sparc64-linux/bin/../lib/gcc/sparc64-linux/11.4.0/../../../../sparc64-linux/bin/ld: warning: arch/sparc/vdso/vdso32/vdso-note.o: missing .note.GNU-stack section implies executable stack
/opt/kernel/gcc-11.4.0-2.40-nolibc/sparc64-linux/bin/../lib/gcc/sparc64-linux/11.4.0/../../../../sparc64-linux/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
sparc64-linux-ld: init/main.o: in function `start_kernel':
main.c:(.init.text+0x764): undefined reference to `arch_cpu_finalize_init'
