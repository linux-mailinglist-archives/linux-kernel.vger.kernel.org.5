Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D75769A03
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbjGaOs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjGaOsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:48:23 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8A3E46;
        Mon, 31 Jul 2023 07:48:22 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bbc64f9a91so38719395ad.0;
        Mon, 31 Jul 2023 07:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690814902; x=1691419702;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ioQL3amGVFLHt+/XGqLPUSH2Ac7t4cUjcuuZe7CDhps=;
        b=QXOHxzzuyuUtqTlbPoNx72xTFBCt4zZ0MKzi6DYZWP4ezcq2zpqDOuQGvfzCa3rtlO
         csVPph93/gOpNYSkPl28LvYmLtnSgxoGFKtWBD/yljuXMYeK+4LG7f4bekGAPrmfgzZa
         J0ivuHNQ7XX/FhXjMZenLZLWq8sIxX2dRZEcDazdA3aXVUW3oSlxmnzWTc/15VedFvYm
         GaVre329hqL52cKtTlgBXrpeQ58JTMiPuC+WQO3MB3IE/TKYCU7gk4qkdpHpoCoHvVHJ
         hssp55EMDEcFtgjMuIMBMiJtHnKbqyFBOqsvIQy8LTJ54mt3anXO2doZQWkvAGR+KxeK
         y+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690814902; x=1691419702;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ioQL3amGVFLHt+/XGqLPUSH2Ac7t4cUjcuuZe7CDhps=;
        b=bDB66d/O4xTXpDMynvbeM/Z5RQPqYB0TReoPagxurGPp5qo1cu4cZwj04cgulCCrUK
         /pe8TSPEBNyS+ivTb0vZS/qO4V9nTeGD6nUIOFJQjPqpXApT1tkZljVdwAa6aPEmxWHq
         bODtrvDdLDPygVx1iNefMDNXB0iYLt/iNaGe18VOtxBZIyCHnaibtnII8WVvO6gAlnnn
         muGowu/EOVoNdtzj1ypEEn8vC7QaSYSx4ISQAYafMeJlSBEVXM0sRI8x0wgpkoTS59QN
         3FUNeT+LiTowCeEy9fkpZnclDfgdQDZNNWpMCXkyAQa+K+OWFv9yb+3vL21h5rqn7qfb
         dJLQ==
X-Gm-Message-State: ABy/qLbGF4uxPxVRUs16Xj94jDIX0pc+Nur56HB0Nl35SK7vCdWOd/ok
        9FZsmv2d20u5/SFJIl9BXIU=
X-Google-Smtp-Source: APBJJlFIMiYtJ40DXimsHlznA5C1s6kQTYjo1ggDLkpx7oEl19AIO/ozOOqVA8moiico0A3dpFbXrA==
X-Received: by 2002:a17:902:7486:b0:1b9:c205:a876 with SMTP id h6-20020a170902748600b001b9c205a876mr11031747pll.29.1690814901553;
        Mon, 31 Jul 2023 07:48:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e16-20020a17090301d000b001b8b2fb52d4sm8666302plh.203.2023.07.31.07.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 07:48:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f5a18aa3-9db7-6ad2-33d5-3335a18e4e2f@roeck-us.net>
Date:   Mon, 31 Jul 2023 07:48:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: scheduler problems in -next (was: Re: [PATCH 6.4 000/227]
 6.4.7-rc1 review)
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>, paulmck@kernel.org,
        Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        rcu@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
References: <2cfc68cc-3a2f-4350-a711-ef0c0d8385fd@paulmck-laptop>
 <D56D0318-A2EA-4448-8F4D-BE84706E26A5@joelfernandes.org>
 <3da81a5c-700b-8e21-1bde-27dd3a0b8945@roeck-us.net>
 <20230731141934.GK29590@hirez.programming.kicks-ass.net>
 <20230731143954.GB37820@hirez.programming.kicks-ass.net>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230731143954.GB37820@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/23 07:39, Peter Zijlstra wrote:
> On Mon, Jul 31, 2023 at 04:19:34PM +0200, Peter Zijlstra wrote:
>> On Sat, Jul 29, 2023 at 09:00:02PM -0700, Guenter Roeck wrote:
>>> On 7/27/23 16:18, Joel Fernandes wrote:
>>>
>>> [ ... ]
>>>
>>>>> I freely confess that I am having a hard time imagining what would
>>>>> be CPU dependent in that code.  Timing, maybe?  Whatever the reason,
>>>>> I am not seeing these failures in my testing.
>>>>>
>>>>> So which of the following Kconfig options is defined in your .config?
>>>>> CONFIG_TASKS_RCU, CONFIG_TASKS_RUDE_RCU, and CONFIG_TASKS_TRACE_RCU.
>>>>>
>>>>> If you have more than one of them, could you please apply this patch
>>>>> and show me the corresponding console output from the resulting hang?
>>>>
>>>> FWIW, I am not able to repro this issue either. If a .config can be shared of the problem system, I can try it out to see if it can be reproduced on my side.
>>>>
>>>
>>> I managed to bisect the problem. See bisect log below. Bisect repeated twice.
>>> so it should be reliable. I don't really understand it, but the following
>>> reverts fix the problem. This is on top of next-20230721 because next-20230728
>>> crashes immediately in my tests.
>>>
>>> 0caafe9b94ab (HEAD) Revert "sched/fair: Remove sched_feat(START_DEBIT)"
>>> 518bdbd39fdb Revert "sched/fair: Add lag based placement"
>>> a011162c3e32 Revert "sched/fair: Implement an EEVDF-like scheduling policy"
>>> df579720bf98 Revert "sched/fair: Commit to lag based placement"
>>> aac459a7e738 Revert "sched/smp: Use lag to simplify cross-runqueue placement"
>>> 8d686eb173e1 Revert "sched/fair: Commit to EEVDF"
>>> 486474c50f95 Revert "sched/debug: Rename sysctl_sched_min_granularity to sysctl_sched_base_slice"
>>> 79e94d67d08a Revert "sched/fair: Propagate enqueue flags into place_entity()"
>>> ae867bc97b71 (tag: next-20230721) Add linux-next specific files for 20230721
>>>
>>> For context: x86 images (32 and 64 bit) in -next tend to hang at
>>>
>>> [    2.309323] RCU Tasks: Setting shift to 0 and lim to 1 rcu_task_cb_adjust=1.
>>> [    2.311634] Running RCU-tasks wait API self tests
>>>
>>> The hang is not seen with every boot; it happens roughly about once every
>>> 10 boot attempts. It is not CPU dependent as I initially thought.
>>>
>>> Configuration file is at http://server.roeck-us.net/qemu/x86-next/config.
>>> Example qemu command line:
>>
>> Hurmph, let me see if I can reproduce on next-20230731 (not having the
>> older next thingies around).
> 
> I've taken your config above, and the rootfs.ext2 and run-sh from x86/.
> I've then modified run-sh to use:
> 
>    qemu-system-x86_64 -enable-kvm -cpu host
> 
> What I'm seeing is that some boots get stuck at:
> 
> [    0.608230] Running RCU-tasks wait API self tests
> 
> Is this the right 'problem' ?
> 


Yes, exactly.

Thanks,
Guenter

