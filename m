Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBE47BCDFB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 13:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344673AbjJHLKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 07:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjJHLKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 07:10:07 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72ACAC
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 04:10:06 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6c644a1845cso2474860a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 04:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696763406; x=1697368206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8ktmwwLv+LDOgbjf3ixbqpkxtDCfxzhl8ckG93FgT8=;
        b=KfnubNV7ZNLEOFXQjQmaMyPUbU76InBnS6EJ7VJe+GftBTfgEPpfiFUiK2vGPsn1OB
         Z+04POPSXVUYVKc5HdFNQV3fBDFspojB8CN1tLAqpWqhFXLcLEL+jQlm/lZiECsdEj7R
         aX5893wvYpEWHqL0Dm3iggk+euqoHSFErxhjBgmxMx16P8i4BeY9alRUyoS2qUs5tcwj
         MQfOxfdhWqh+jDux974L2J/pQJGkFm5HLiMZMBO4b1SHASs9DKf6cvzfWj7aFzHaA8E/
         vEwCx8cS/+oAYdtedHGTiPXhCmNMFPH+Ui69Q+mPWcfWG1kFDFtby2S5FyyQEV128chB
         bNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696763406; x=1697368206;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q8ktmwwLv+LDOgbjf3ixbqpkxtDCfxzhl8ckG93FgT8=;
        b=V46yNKEcCMfD/MnvjOiXS2pGDZoIBw8PrtGkMaxUOXycJSxddft2c2n9u+F7zsYwN3
         WLMMLZHfkxIHT08osEAoCnkcZgmpxgoeA2iPTidFR17nmZ9hNkV9WxchsqT+8gq8/boC
         vI5HO6fnh9Kr6UgWKJb9OFcUR110SH28XTY5Ar+oJ6nLHIViHKipt73CX/iAgXPJo0rp
         uKporGmGHZJljMO5S9PcbL4PoZF8NCoXcrHfFCswk5vXzQEebx+zyUBjz8HeWWPAm56y
         KVeXdDaAzVeeBhiXUB4ZOHUfb63dtIx8ut49fHNg90E0dJuvOeSSOg2MSOu06rWH6ic9
         B0tw==
X-Gm-Message-State: AOJu0YwlVp3UOWi+xw3Wr6SUb1owjPTnnnjTTddiARkrdVi/DwMXEHaw
        nGtjIrHKZkcxwdi2Epk9pDjDiVOEPWvMQ4F3
X-Google-Smtp-Source: AGHT+IEMKfeuwRPXqjMF1Fl7m25vPcCv5vQkL0D9td2/m/h/cVfUPOnPi1Va6i54s7D8D6tahDLPTw==
X-Received: by 2002:a05:6358:91c:b0:134:c8cb:6a00 with SMTP id r28-20020a056358091c00b00134c8cb6a00mr14026767rwi.12.1696763406114;
        Sun, 08 Oct 2023 04:10:06 -0700 (PDT)
Received: from [10.53.28.113] ([143.92.118.24])
        by smtp.gmail.com with ESMTPSA id z8-20020a17090a014800b00262eb0d141esm6937105pje.28.2023.10.08.04.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Oct 2023 04:10:05 -0700 (PDT)
Message-ID: <5dba07eb-88f0-bf84-494e-b979f32ad44d@gmail.com>
Date:   Sun, 8 Oct 2023 19:10:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 2/3] delayacct: convert task->delays to a object
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     bsingharora@gmail.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
References: <cover.1696761522.git.chunguang.xu@shopee.com>
 <531ddc82793a39f4c09316d701a4b1170bcad4ab.1696761522.git.chunguang.xu@shopee.com>
 <20231008105801.GC6320@noisy.programming.kicks-ass.net>
From:   brookxu <brookxu.cn@gmail.com>
In-Reply-To: <20231008105801.GC6320@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/10/8 18:58, Peter Zijlstra 写道:
> On Sun, Oct 08, 2023 at 06:49:37PM +0800, brookxu.cn wrote:
>> From: Chunguang Xu <chunguang.xu@shopee.com>
>>
>> Since in some scenarios we still want to get the task delayacct
>> through taskstats, so commit <0cd7c741f01de> introduces a sysctl to
> This is not the canonical way to reference a commit.
>
>> enable it dynamically. However, since task->delays is allocated
>> during fork(), task->delays will not be reallocated when delayacct
>> is enabled later. This will make we cannot get the delayacct of old
>> tasks, but the new tasks cans. This can easily lead to confusion.
>> Therefore, try to workaround this issue by convert task->delays to
>> an object.
> And grow task_struct for no reason? I think not.
>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 77f01ac385f7..5cc78184a31f 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -37,6 +37,7 @@
>>   #include <linux/kcsan.h>
>>   #include <linux/rv.h>
>>   #include <linux/livepatch_sched.h>
>> +#include <linux/delayacct.h>
>>   #include <asm/kmap_size.h>
>>   
>>   /* task_struct member predeclarations (sorted alphabetically): */
>> @@ -1331,7 +1332,7 @@ struct task_struct {
>>   	struct page_frag		task_frag;
>>   
>>   #ifdef CONFIG_TASK_DELAY_ACCT
>> -	struct task_delay_info		*delays;
>> +	struct task_delay_info		delays;
>>   #endif
> Yeah, no.
Yes, this way will increase about 80 bytes for task_struct, about 0.85% 
of size of task_struct, I think this just like sched_statistics, so that 
can better support dynamically enable through sysctl.
