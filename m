Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A187BF56D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442660AbjJJIPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379425AbjJJIPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:15:09 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514A3DB
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:14:43 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-3515deaa7c1so22537185ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696925682; x=1697530482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/HoMaOoKR0pGoq+6UqdtbB9lre+T0vb4C/YvnZ/SdQ=;
        b=W9T95a3XtqEx0v4CH8mIMsJXVZ2IUKZG4AhiqXfew0F4/lFxYfoWZN5DnL/LsL5Er6
         KrNweJ+yhgdW6u4CSra47XvDQbyKmPrIoFo6azXuFcTk7iSEKQhqDcAhPC3nUkiNXQHC
         SKfgkFYxjgeRWlMiiu0dU9CAGV0XmyDg6Iye4Qly3CeQ7pM5KLZ9HpjJYUiwy5K1ncFQ
         4AYsx74z6howsHceOQt6AKNLZt4M5OaKdSuiOiwlsZCJwqnTC7gguY7uNK3UwR/X5Rqu
         dELkCWG7+xtYIqgY824Yb+vTaocLnkQUdiciYK9V563lUPOuwknN4u14796V4+LlVGEW
         Gk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696925682; x=1697530482;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b/HoMaOoKR0pGoq+6UqdtbB9lre+T0vb4C/YvnZ/SdQ=;
        b=WD55qPcT+jtnnBcMIam6us9za83017jaqYbaqSMTcEWAaJk/wsWsJjHLxfDUvN8yLM
         ZAR13p6KSOEkBBJTKCmisGDmeCva0lFGis/Qo3QXGAEv//9dCyUICMV9feSDhxndK0yh
         On96SYx4ZjcuCwSWFTvRY28pzErAw0QC3pgatbLLF4Ez/2jp282fZVsm/WuWSo65Ux9Y
         ct5Zs/yiJpS/ldGhGhHLOEqqEernEFJJD8vTdcVGQtAPo4cLkTAENmvTBeJiJzDR1F5z
         jmYKhamNPZMmb/Q+TSx3DxbJaSjatP9iEriUlUmytSKQKEMYuBk6kFW448X2BQtPjwts
         cb/A==
X-Gm-Message-State: AOJu0Yy2I5F6uWGcEE5cWNopDEGAxDL8ReEZ+UR3v1Dv5tWXQxnSsk3P
        0FhHYQfVKnyUNl3/vd5sAn1vcVxWbJcXzbNDhwc=
X-Google-Smtp-Source: AGHT+IGOkGKsxfcx84/hXVEjTu9O2t+8khMDt2f/9uKqJftbuY/vAUCFImLmVU2jPzwafwd0XEwYXw==
X-Received: by 2002:a92:cd82:0:b0:351:80c:bc29 with SMTP id r2-20020a92cd82000000b00351080cbc29mr22970088ilb.17.1696925682543;
        Tue, 10 Oct 2023 01:14:42 -0700 (PDT)
Received: from [10.254.8.137] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id z5-20020a633305000000b0057cb5a780ebsm9623492pgz.76.2023.10.10.01.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 01:14:42 -0700 (PDT)
Message-ID: <be35c8c6-16fb-4b9b-b406-7dd4c6f5811b@bytedance.com>
Date:   Tue, 10 Oct 2023 16:14:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 0/8] Add Open-coded task, css_task and css
 iters
To:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, martin.lau@kernel.org,
        tj@kernel.org, linux-kernel@vger.kernel.org
References: <20231007124522.34834-1-zhouchuyi@bytedance.com>
 <d25f9b70-e958-c229-c275-95ed664bf0ed@iogearbox.net>
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <d25f9b70-e958-c229-c275-95ed664bf0ed@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

在 2023/10/10 16:01, Daniel Borkmann 写道:
> On 10/7/23 2:45 PM, Chuyi Zhou wrote:
>> Hi,
>>
>> This is version 4 of task, css_task and css iters support.
>> Thanks for your review!
>>
>> --- Changelog ---
>>
>> v3 -> 
>> v4:https://lore.kernel.org/all/20230925105552.817513-1-zhouchuyi@bytedance.com/
>>
>> * Address all the comments from Andrii in patch-3 ~ patch-6
>> * Collect Tejun's ack
>> * Add a extra patch to rename bpf_iter_task.c to bpf_iter_tasks.c
>> * Seperate three BPF program files for selftests (iters_task.c 
>> iters_css_task.c iters_css.c)
> 
> This fails to build BPF selftests:
> 

Yes, thanks for the remind!

I didn't notice this error since it may only occurs when using llvm-16 
to compile the selftest, and when we using gcc, it works OK.
(https://github.com/kernel-patches/bpf/actions/runs/6462875618/job/17545170863)

I can reproduce this error in my environment. Before sending next 
version, I would use LLVM-16 to double check.

Thanks.


> [...]
>   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:166:6: error: variable 'skel' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>            if (!ASSERT_OK(err, "setup_cgroup_environment"))
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:190:26: 
> note: uninitialized use occurs here
>            iters_css_task__destroy(skel);
>                                    ^~~~
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:166:2: 
> note: remove the 'if' if its condition is always false
>            if (!ASSERT_OK(err, "setup_cgroup_environment"))
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:162:6: 
> error: variable 'skel' is used uninitialized whenever 'if' condition is 
> true [-Werror,-Wsometimes-uninitialized]
>            if (!ASSERT_GE(cg_fd, 0, "cg_create"))
>      TEST-OBJ [test_progs] xdp.test.o
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:190:26: 
> note: uninitialized use occurs here
>            iters_css_task__destroy(skel);
>                                    ^~~~
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:162:2: 
> note: remove the 'if' if its condition is always false
>            if (!ASSERT_GE(cg_fd, 0, "cg_create"))
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:159:6: 
> error: variable 'skel' is used uninitialized whenever 'if' condition is 
> true [-Werror,-Wsometimes-uninitialized]
>            if (!ASSERT_OK(err, "setup_cgroup_environment"))
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:190:26: 
> note: uninitialized use occurs here
>            iters_css_task__destroy(skel);
>                                    ^~~~
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:159:2: 
> note: remove the 'if' if its condition is always false
>            if (!ASSERT_OK(err, "setup_cgroup_environment"))
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:154:29: 
> note: initialize the variable 'skel' to silence this warning
>            struct iters_css_task *skel;
>                                       ^
>                                        = NULL
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:213:7: 
> error: variable 'skel' is used uninitialized whenever 'if' condition is 
> true [-Werror,-Wsometimes-uninitialized]
>                    if (!ASSERT_GE(cgs[i].fd, 0, "cg_create"))
>                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:244:21: 
> note: uninitialized use occurs here
>            iters_css__destroy(skel);
>                               ^~~~
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:213:3: 
> note: remove the 'if' if its condition is always false
>                    if (!ASSERT_GE(cgs[i].fd, 0, "cg_create"))
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:209:6: 
> error: variable 'skel' is used uninitialized whenever 'if' condition is 
> true [-Werror,-Wsometimes-uninitialized]
>            if (!ASSERT_OK(err, "setup_cgroup_environment"))
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:244:21: 
> note: uninitialized use occurs here
>            iters_css__destroy(skel);
>                               ^~~~
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:209:2: 
> note: remove the 'if' if its condition is always false
>            if (!ASSERT_OK(err, "setup_cgroup_environment"))
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:195:24: 
> note: initialize the variable 'skel' to silence this warning
>            struct iters_css *skel;
>                                  ^
>                                   = NULL
>    5 errors generated.
>    make: *** [Makefile:605: 
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/iters.test.o] Error 1
>    make: *** Waiting for unfinished jobs....
>    make: Leaving directory '/tmp/work/bpf/bpf/tools/testing/selftests/bpf'
>    Error: Process completed with exit code 2.
