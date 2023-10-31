Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192C07DC81D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 09:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbjJaIYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 04:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjJaIX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 04:23:59 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD65EA6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 01:23:56 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc5fa0e4d5so10278095ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 01:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698740636; x=1699345436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XFdmiuguOFuW7b2WHLC4CrgK3Kr864AN6V1+a582UpU=;
        b=QbBUFKFZgfPqNMuWDTHHUv4g8QhoSmuD1DQxZ8jmDXusVsAZQ4+35xvlfNI6FdWjEG
         FDreC95RkSdlrCQIU7JSNTFP+1pKmjRrvXVC7/qFuMOjpcN9pv7OPQI0OpDmIQ3aO0e7
         SwvkguPVmKbBoe59fi6btzlOQI6ZIU+ZferUceqcuZo96gQVzcbWyas5c0miT9dOWdpn
         rYdC4pD6X0iCPSej5LtWmwrzwNfoEBlJQOHmrRVJ3lhoxdnzPH3lfzEIj4M4j4J09qZI
         PXIVIoop56pgDFKUXJYEWUJHt4SzQwpPF5WmpuBRr+cBm7Zci54jbIMuYfERvtWtqgrG
         d5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698740636; x=1699345436;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XFdmiuguOFuW7b2WHLC4CrgK3Kr864AN6V1+a582UpU=;
        b=F8nkobQ3BZEl+1xBFW0pGAftcScLsuXwRqCaeBrQLJije8DX/bJZwyrQoO/kYwEBR0
         U0941d5vW1a6xUaBh9gxs4MABPdFjzxkymujxxXZCAgAexRJdkJv04TlbJLVdDbO1ImX
         LnhIUYQuXpaGQ1FVhHOEt4bOugpxmY0evYi/QRN8mnVSL5yff+IEz9y3tNqFKXAE7V0L
         Tk0waZW7rlmaDtEpPNNjSi9XncnhYUDKhs4J7AweXRR4gtRSJEX3Z2WeLxTg8mQFsB0h
         U9ffFfJ8kbtcSZAdcjPSHG0PWq98KgoSwnX/9J3/RoLOWc/PTWhfYP9pOYt9JKC8f4KX
         j+kw==
X-Gm-Message-State: AOJu0YypEy26UNEDTtOot/WL1/vWoshj0sQyEu5HIdFWoLOxC+EVoR86
        pEANOwHJ1r3PI0SCzexJY5bLJKw4uYRnqQ==
X-Google-Smtp-Source: AGHT+IGZpnvmPDF5Hs4i5OKn8AMfCof9m/YQ8+OUaD64gx5XxvD0q7KWfd2/jrJ+wtDtDQFc5qM/8w==
X-Received: by 2002:a17:903:246:b0:1ca:2743:bf79 with SMTP id j6-20020a170903024600b001ca2743bf79mr15651988plh.39.1698740636350;
        Tue, 31 Oct 2023 01:23:56 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b001ca4ad86357sm763825plf.227.2023.10.31.01.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 01:23:56 -0700 (PDT)
Message-ID: <11941121-205b-44fd-86ee-1b86a52a3211@gmail.com>
Date:   Tue, 31 Oct 2023 17:23:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v5 6/7] r8169: Coalesce mac ocp write and modify for 8125
 and 8125B start to reduce spinlocks
To:     mirsad.todorovac@alu.unizg.hr
Cc:     hkallweit1@gmail.com, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <e9cb3842-3492-4b85-b7ad-77605a5836c3@alu.unizg.hr>
Content-Language: en-US
In-Reply-To: <e9cb3842-3492-4b85-b7ad-77605a5836c3@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mirsad,

[most CCs dropped]

I'm responding to your comment quoted below.  It caught eyes of me
who happens to be a reviewer of LKMM and a LaTeX advisor to perfbook.

On Mon, 30 Oct 2023 16:02:28 +0100, Mirsad Todorovac wrote:
> On 10/30/23 15:02, Heiner Kallweit wrote:
[...]
>> 
>> All this manual locking and unlocking makes the code harder
>> to read and more error-prone. Maybe, as a rule of thumb:
>> If you can replace a block with more than 10 mac ocp ops,
>> then fine with me
> As I worked with another German developer, Mr. Frank Heckenbach from the GNU Pascal project,
> I know that Germans are pedantic and reliable :-)
> 
> If this rtl_hw_start_8125_common() is called only once, then maybe every memory bus cycle
> isn't worth saving, and then maybe the additional complexity isn't worth adding (but it
> was fun doing, and it works with my NIC).
> 
> AFAIK, a spin_lock_irqsave()/spin_unlock_irqrestore() isn't a free lunch as you know, and I read
> from the manuals that on modern CPUs a locked ADD $0, -128(%esp) or something takes about 50
> clock cycles, in which all cores have to wait.

Do you mean, while one of x86 CPUs is executing "lock; addl $0, -4(%esp)"
aka smp_mb(), bus locking prevents all the other CPUs in the system
connected to the bus from doing any memory accesses ???

If it is the case, I believe you are missing the state of the art
optimization of x86 memory system architecture, where most of atomic
operations are done using cache locking.  Bus locking is used only
when it is unavoidable.

Hint: A short introduction can be found at stackoverflow.com [1].
Quote of (then) section 7.1.4 from Intel's SDM vol 3A in the answer
should suffice.

[1]: https://stackoverflow.com/questions/3339141/x86-lock-question-on-multi-core-cpus

A reachable link to Intel SDM should be somewhere in perfbook's bibliography.
The relevant section in Vol 3A is now "2.8.5 Controlling the Processor".

Hope this helps,
Akira

> 
> Doing that in storm of 10 lock/unlock pairs amounts to 500 cycles or 125 ns in the best case
> on a 4 GHz CPU.
> 
> But I trust that you as the maintainer have the big picture and greater insight in the actual hw.


