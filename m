Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96370808610
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378937AbjLGJX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbjLGJXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:23:25 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB0210C9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 01:23:23 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-334b1751182so58905f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 01:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701941002; x=1702545802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l5FBiJ45iDeUXfgQxMa3i0Od/x/7WPqbPJGDEHdM0F0=;
        b=WIHuVE+LrOEiN5WU9ZrQ+hLrJc3WZ9WQDXmVFItNNF4vBAbq0eBE9XEt3T3yFTe/E8
         edaSOGcUFiRtODYGMoMBz9tRs3gFDRcrUuBQ++iK18CcR2cZ4c7awj9p2DLoy+LkKmR9
         I75qpPs9jUOIZlHcOnIUKg6QcrcROhomqa5IadkGlC+RZPDzAGnHItOi2D5Usr2ST6fs
         OFvCwKJh11mE32ZCETibCy7E8+izUhUAstBrLcePj4/cz2v544wUheBkIJuI6l5TtF0g
         CPzNQ7nDER/o8ELocSgYCALjKRfF2Wrglo3GaEnMhSqMNPKIxjaga4O1OMVD7Zu8naFQ
         50Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701941002; x=1702545802;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l5FBiJ45iDeUXfgQxMa3i0Od/x/7WPqbPJGDEHdM0F0=;
        b=QyIoJIga+eOpzKl/9wqVoLbrBJ9PJV2lze3UEmCmGVTiA+Lp4gaUHbP557NHPkEgNG
         9B7VMuUbk89E7caXlKPgd+LxrSJHOFjmbRBteCvIQg6NwITZbPLH1zHu3LB82ppeexFr
         dIhB4sGpT+9ULwJg1v/YxiCOhUZt5RQChQCSondjrlJSZ/71mdG83/yL0015wAMsPHFb
         AS/sw8lFwyUPbcGCk+yhhQXakOyFMidB4z5sLdLyeg9ev3a/q0Vv9SoQSRkV3IlWboR3
         4M90C7YEtZ9nLr+LuHnCdcWhOEehOhefUtPp00QcOADAplNEBu8biUNKW9fwaFU/MZO6
         VP1w==
X-Gm-Message-State: AOJu0Yxs0UoOPg9JwutN51F8yRU3HHC6Hfbge9ygCoQ9jDmwSURolUCv
        B6hqqEXHevpO1DhBREePGkdZhw==
X-Google-Smtp-Source: AGHT+IHiSl8NR8L1J4o7p9pO4hO7ZjB/jzT8jO2oUpGxKH1pv3D7QS7UJOcLUaw5et+Kc0foXQo7Hg==
X-Received: by 2002:a05:6000:184b:b0:333:463a:b66e with SMTP id c11-20020a056000184b00b00333463ab66emr2922749wri.0.1701941001855;
        Thu, 07 Dec 2023 01:23:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:999:a3a0:7592:dcea:a631:2772? ([2a01:e0a:999:a3a0:7592:dcea:a631:2772])
        by smtp.gmail.com with ESMTPSA id e22-20020a5d5956000000b0033334625bdbsm529774wri.13.2023.12.07.01.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 01:23:21 -0800 (PST)
Message-ID: <8a9952bf-67ff-4ab0-9e44-e2c2f2a68076@rivosinc.com>
Date:   Thu, 7 Dec 2023 10:23:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] [RFC PATCH 0/3] riscv: add support for SBI Supervisor
 Software Events
To:     Xu Lu <luxu.kernel@bytedance.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Himanshu Chauhan <hchauhan@ventanamicro.com>
References: <20231026143122.279437-1-cleger@rivosinc.com>
 <CAPYmKFsFLQnhXRPXpcoNfO-kEyjYLXD2Hm-F-O=Yxe1WJoSL9w@mail.gmail.com>
Content-Language: en-US
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CAPYmKFsFLQnhXRPXpcoNfO-kEyjYLXD2Hm-F-O=Yxe1WJoSL9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/12/2023 10:09, Xu Lu wrote:
> Pardon. It seems that the code in opensbi[1] is not complete for PMU NMI now.
> For example, the pmu ovf irq is still delegated to supervisor mode and
> thus can not really play a role as NMI. And neither the kernel nor
> opensbi will inject a pmu event.
> 
> To complete the work, we think maybe 'enable_cb' and 'disable_cb'
> functions can be supplied for sbi_sse_cb_ops.
> When sbi_sse_enable is called to enable pmu event, the enable_cb will
> be called to revoke the delegation of pmu ovf irq and enable this irq
> in CSR_MIE.

Hi Xu,

Indeed, this part has been developed but was left out for the RFC. But
your understanding is correct.

> When pmu ovf irq occurs, kernel traps into opensbi and opensbi injects
> the event via sbi_sse_inject_event and eret back to kernel.
> 
> Please point it out if we have any misunderstanding.
> 
> By the way, how is SSE going now? We will appreciate it very much if
> we can participate in some development work in kernel or opensbi and
> be of any help.

The development is almost complete, Anup/Himanchu will send a new
revision of the spec addressing various comments and I'll resend the RFC
following that spec update.

Regards,

Clément

> 
> Regards!
> 
> Link: https://github.com/rivosinc/opensbi/tree/dev/cleger/sse [1]
> 
> On Thu, Oct 26, 2023 at 10:31 PM Clément Léger <cleger@rivosinc.com> wrote:
>>
>> The SBI Supervisor Software Events (SSE) extensions provides a mechanism
>> to inject software events from an SBI implementation to supervisor
>> software such that it preempts all other supervisor level traps and
>> interrupts [1].
>>
>> Various events are defined and can be send asynchronously to supervisor
>> software (RAS, PMU, DEBUG, Asynchronous page fault) from SBI as well
>> as platform specific events. Events can be either local (per-hart) or
>> global. Events can be nested on top of each other based on priority and
>> can interrupt the kernel at any time.
>>
>> First patch adds the SSE definitions. Second one adds support for SSE
>> itself. Implementation is split between arch specific code and generic
>> part (similarly to what is done for ARM SDEI). Finally, the last patch
>> add support fro SSE event in the SBI PMU driver. If the SSE event is
>> available from the SBI then, it will be used instead of the normal
>> interrupt.
>>
>> Amongst the specific points that needs to be handle is the interruption
>> at any point of the kernel execution and more specifically during
>> exception handling. Due to the fact that the exception entry
>> implementation uses the SCRATCH CSR as both the current task struct and
>> as the temporary register to switch the stack and save register, it is
>> difficult to reliably get the current task struct if we get interrupted
>> at this specific moment. A fixup-like mechanism allows to mark the
>> location of the current task struct depending on the entry level
>> (user/kernel) and the location. This is then used in the SSE assembly to
>> determine where is located the current task_struct.
>>
>> Contrary to pseudo NMI [2], SSE does not modifies the way interrupts are
>> handled and does not adds any overhead to existing code. Moreover, it
>> provides "true" NMI-like interrupts which can interrupt the kernel at
>> any time (even in exception handling). This is particularly crucial for
>> RAS errors which needs to be handled as fast as possible to avoid any
>> fault propagation. Additionally, SSE event handling is faster that the
>> standard IRQ handling path with almost half executed instruction (700 vs
>> 1590). Some complementary tests/perf measurements will be done.
>>
>> For testing purpose, one can use the provided SBI implementation at [3].
>> This series also needs patch [4] to fix a bug in the PMU driver.
>>
>> Link: https://lists.riscv.org/g/tech-prs/message/515 [1]
>> Link: https://lore.kernel.org/lkml/20231023082911.23242-10-luxu.kernel@bytedance.com/T/ [2]
>> Link: https://github.com/rivosinc/opensbi/tree/dev/cleger/sse [3]
>> Link: https://lore.kernel.org/linux-arm-kernel/20231026084010.11888-1-alexghiti@rivosinc.com/ [4]
>>
>> ---
>>
>> Clément Léger (3):
>>   riscv: add SBI SSE extension definitions
>>   riscv: add support for SBI Supervisor Software Events extension
>>   perf: RISC-V: add support for SSE event
>>
>>  arch/riscv/include/asm/asm-prototypes.h |   5 +
>>  arch/riscv/include/asm/sbi.h            |  40 ++
>>  arch/riscv/include/asm/sse.h            |  94 +++++
>>  arch/riscv/kernel/Makefile              |   1 +
>>  arch/riscv/kernel/asm-offsets.c         |  17 +
>>  arch/riscv/kernel/entry.S               | 156 ++++++++
>>  arch/riscv/kernel/sbi.c                 |   4 +
>>  arch/riscv/kernel/sse.c                 |  97 +++++
>>  arch/riscv/kernel/stacktrace.c          |  13 +
>>  arch/riscv/kernel/vmlinux.lds.S         |   6 +
>>  drivers/firmware/Kconfig                |  10 +
>>  drivers/firmware/Makefile               |   1 +
>>  drivers/firmware/riscv_sse.c            | 496 ++++++++++++++++++++++++
>>  drivers/perf/riscv_pmu_sbi.c            |  51 ++-
>>  include/linux/riscv_sse.h               |  56 +++
>>  15 files changed, 1038 insertions(+), 9 deletions(-)
>>  create mode 100644 arch/riscv/include/asm/sse.h
>>  create mode 100644 arch/riscv/kernel/sse.c
>>  create mode 100644 drivers/firmware/riscv_sse.c
>>  create mode 100644 include/linux/riscv_sse.h
>>
>> --
>> 2.42.0
>>
