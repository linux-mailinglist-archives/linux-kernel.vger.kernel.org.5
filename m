Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EE07BCF94
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 20:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344403AbjJHSdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 14:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjJHSdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 14:33:42 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F000B6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 11:33:19 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c88b46710bso17102705ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 11:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696789998; x=1697394798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:content-language
         :references:cc:to:from:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BwfVcBXul2YudjzP0K2Y5pnWckXRjo7iIFIQho4Pppw=;
        b=INgLxuZmHF74YP0JK5UdzA22YhMg7hO5nRXE8HcJR+ufogxgeCc5hC91dveiRy5CDZ
         Nn5oml5TBpSvB3O2cEV1RP3BcBrfOBgHTJkJSNevq62RIvhUA3q8fw14NYjnu8xh9oYl
         di6hh6fVmVkf09r5cwNK3YWFCjdjXTtJEzi9U2HawxUwCm9oHw0iuryc0ywSHKFSLofe
         nBuQ78BFaEOgnLmwdcnGRd8/ImcL6C1fzYTyNTp4HJQCcBhISiDPctYb4PunslNa6jFe
         De/kKYUXN5VKX7OYZPtJxCuPj7SY+ciO2Y1YdJBPfyrsj59kK4MeAMD6O9/Kid3NlxHj
         PIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696789998; x=1697394798;
        h=content-transfer-encoding:in-reply-to:subject:content-language
         :references:cc:to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BwfVcBXul2YudjzP0K2Y5pnWckXRjo7iIFIQho4Pppw=;
        b=ncujwPJJKCslybcmH9ms/qe3arq8R1xMT+nwAPwFA8C4Kv8r8GT2M5IQNAku1Bd4dd
         3sLR9AO+AFFxqKGz2labgPdKCO+Y7CTh3KUpvn5ubY7YqI/iAEKHtOZ7Od7sBTBDptqj
         3vO+TgKU2oyJ6GjnktY5mRtWYm+Wgrr1kbZO55MU9qSiuVzoPPgKqe54grseMf30soga
         kAnBZJ7PXhE0/9xsgGDWech5BomodVL0oMPU/Lrfp2jVSJm9lBzYW8Ly57AUNO3vVUzM
         SuDOzDR/2Czu8xailZ0D7DROGs9fLSNGB7b2ESfW+xTwWOUWdDnppI99zc7E4RnOh6RP
         vuag==
X-Gm-Message-State: AOJu0YwlvamG38VxdQfazp+GctFGT/ffjRELR52aCi34RNx3lW7VXUJ9
        zqG4+MyWHlXDLee0ygSB13Px75+YJY5zz2wK3apcsg==
X-Google-Smtp-Source: AGHT+IGeSLvChAelOdNg5xcvg7ht1Gd3ueSN63PCk+hxuH7YOdzzbb7bWQsXu/wovyzCoJlUMaemdA==
X-Received: by 2002:a17:902:d2c2:b0:1c7:3526:dfcd with SMTP id n2-20020a170902d2c200b001c73526dfcdmr13201955plc.52.1696789998517;
        Sun, 08 Oct 2023 11:33:18 -0700 (PDT)
Received: from [10.254.230.118] ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id y13-20020a170902ed4d00b001c898328289sm4092752plb.158.2023.10.08.11.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Oct 2023 11:33:18 -0700 (PDT)
Message-ID: <30892865-c92e-433e-2dba-ec6004c3d0e2@bytedance.com>
Date:   Mon, 9 Oct 2023 02:33:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
From:   wuqiang <wuqiang.matt@bytedance.com>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        rostedt@goodmis.org, peterz@infradead.org,
        akpm@linux-foundation.org, sander@svanheule.net,
        ebiggers@google.com, dan.j.williams@intel.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com
References: <20230905015255.81545-1-wuqiang.matt@bytedance.com>
 <20230923175746.da3ab516a5c17c5d1897d6d6@kernel.org>
Content-Language: en-US
Subject: Re: [PATCH v9 0/5] lib,kprobes: kretprobe scalability improvement
In-Reply-To: <20230923175746.da3ab516a5c17c5d1897d6d6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/23 16:57, Masami Hiramatsu (Google) wrote:
> Hi Wuqiang,
> 
> I dug my mail box and found this. Sorry for replying late.
> 
> On Tue,  5 Sep 2023 09:52:50 +0800
> "wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:
> 
>> This patch series introduces a scalable and lockless ring-array based
>> object pool and replaces the original freelist (a LIFO queue based on
>> singly linked list) to improve scalability of kretprobed routines.
>>
>> v9:
>>    1) objpool: raw_local_irq_save/restore added to prevent interruption
>>
>>       To avoid possible ABA issues, we must ensure objpool_try_add_slot
>>       and objpool_try_add_slot are uninterruptible. If these operations
>>       are blocked or interrupted in the middle, other cores could overrun
>>       the same slot's ages[] of uint32, then after resuming back, the
>>       interrupted pop() or push() could see same value of ages[], which
>>       is a typical ABA problem though the possibility is small.
>>
>>       The pair of pop()/push() costs about 8.53 cpu cycles, measured
>>       by IACA (Intel Architecture Code Analyzer). That is, on a 4Ghz
>>       core dedicated for pop() & push(), theoretically it would only
>>       need 8.53 seconds to overflow a 32bit value. Testings upon Intel
>>       i7-10700 (2.90GHz) cost 71.88 seconds to overrun a 32bit integer.
> 
> What does this mean? This sounds like "There is a timing issue if it's enough fast".

Yes, that's why local irq must be disabled. If push()/pop() is interrupted or 
preempted long enough (> 10 seconds for the extreme cases), other nodes could
overrun the same ages[] of 32-bit, then after resuming to execution the push()
or pop() would see the same value without notifying the overrun, which is a
typical ABA.

Changing ages[] to 64-bit could be a solution, but it's inappropriate for
32-bit OS and looks too heavy. With local irg disabled, push() or pop() is
uninterrupted，thus the ABA is avoided.

push() or pop() consumes only ~4 cycles to complete (most of the use cases), 
so raw_local_irq_save/restore are used instead of local_irq_save/restore to
minimize the overhead.

> Let me reivew the patch itself.
> 
> Thanks,
> 
>>
>>    2) codes improvements: thanks to Masami for the thorough inspection
>>
>> v8:
>>    1) objpool: refcount added for objpool lifecycle management
>>
>> wuqiang.matt (5):
>>    lib: objpool added: ring-array based lockless MPMC
>>    lib: objpool test module added
>>    kprobes: kretprobe scalability improvement with objpool
>>    kprobes: freelist.h removed
>>    MAINTAINERS: objpool added
>>
>>   MAINTAINERS              |   7 +
>>   include/linux/freelist.h | 129 --------
>>   include/linux/kprobes.h  |  11 +-
>>   include/linux/objpool.h  | 174 ++++++++++
>>   include/linux/rethook.h  |  16 +-
>>   kernel/kprobes.c         |  93 +++---
>>   kernel/trace/fprobe.c    |  32 +-
>>   kernel/trace/rethook.c   |  90 +++--
>>   lib/Kconfig.debug        |  11 +
>>   lib/Makefile             |   4 +-
>>   lib/objpool.c            | 338 +++++++++++++++++++
>>   lib/test_objpool.c       | 689 +++++++++++++++++++++++++++++++++++++++
>>   12 files changed, 1320 insertions(+), 274 deletions(-)
>>   delete mode 100644 include/linux/freelist.h
>>   create mode 100644 include/linux/objpool.h
>>   create mode 100644 lib/objpool.c
>>   create mode 100644 lib/test_objpool.c
>>
>> -- 
>> 2.40.1
>>
> 
> 


