Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1905276C606
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjHBHCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjHBHCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:02:20 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27146FB;
        Wed,  2 Aug 2023 00:02:15 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe1489ced6so10645836e87.0;
        Wed, 02 Aug 2023 00:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690959733; x=1691564533;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dnJv7C1DOaAYlfgmnyE0gMNp1U/eFvuj/D4+Lrp8gKs=;
        b=fFW/wNhhzB9pZFHKWc9GOFwpjCvl2AMN1Zal7cWLl90tPS4Esx9upYwliJm/+vpkbc
         At1jdiIqp8Sr6/oHUd/RA28xhnNLw61hjAkY62fy+a0LmP2U8KgXellpQH2Mq0XXx15e
         C5YAKH+S1ZAPjL+BxWhFeo7h2M5TG+2dho7L4v/8UOJMTLIJUl+qG/AXr09EHOcsdCJ+
         AZ7C9+hAPPpyt4YCqxFgj7NTZ3A6LYwhoZ9J1qy1pWjCRqDgjRIR8RHhO2h8p6QZRoJB
         +n+vFHofAx7dJq5f9nsuIfafcWwCYHKx+kxaLH8ay5HW1nL/CJzmVkiRE9cRe3h201jL
         8/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690959733; x=1691564533;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dnJv7C1DOaAYlfgmnyE0gMNp1U/eFvuj/D4+Lrp8gKs=;
        b=RfuMyT0gvY3Wa1ohKRikv8GMltEQyCJPz4t6S33D4u4DRwLSQOtXTi82w99wSypuLv
         K3Q9C4GirO0p4R36ZTMYS6qiMzHGOKDi4UsVeMpUfU6pHYW0kk7Ejw2vkfegxoxhQlVe
         d4qieuKGoA+8cwPVL1J0g6trbnx0jcimHlvfivrRDxh5cvcxwNJZTQPW/Ro8SBiMRnxk
         KUfLpM+cNmb4tOJDabf+jfXPff49CVELRsMtcYTxEVJlxab+vk3bm9bQQB9XSplCGh7t
         71NkLFLM20tjCz6E8L+3/zijpaXn5YkzecQjJoVqm4SJL90TLpNX7uTysLNJx2w+Rzmp
         0IDg==
X-Gm-Message-State: ABy/qLblix3qBKyIqwDcAqjAaxPw7EDDlrtwIRMZJF3B1ceTqYOoV6Qj
        jgzvAw3I5nTRV94ECn747Po=
X-Google-Smtp-Source: APBJJlGQxoBqEV97PYoKx4G/JmsPwrcwrmX3UZ4J7xl2hHfaTGyuk5cc4Lyq+h3C37o3iJ3NFgL3lg==
X-Received: by 2002:a2e:9591:0:b0:2b6:fe3c:c3af with SMTP id w17-20020a2e9591000000b002b6fe3cc3afmr4172617ljh.27.1690959733056;
        Wed, 02 Aug 2023 00:02:13 -0700 (PDT)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id f22-20020a2e9516000000b002b6ec6cb24bsm3422470ljh.57.2023.08.02.00.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 00:02:12 -0700 (PDT)
Message-ID: <ded9eba2-3a50-0d75-f8be-80feac788d24@gmail.com>
Date:   Wed, 2 Aug 2023 09:02:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ARM board lockups/hangs triggered by locks and mutexes
Content-Language: en-US
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-clk@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     OpenWrt Development List <openwrt-devel@lists.openwrt.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
References: <CACna6rxpzDWE5-gnmpgMgfzPmmHvEGTZk4GJvJ8jLSMazh2bVA@mail.gmail.com>
 <8fcbe485-ce6b-c500-56da-77cae0c872ff@broadcom.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <8fcbe485-ce6b-c500-56da-77cae0c872ff@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.08.2023 00:25, Florian Fainelli wrote:
> Hi Rafal,
> 
> On 8/1/23 15:10, Rafał Miłecki wrote:
>> Hi,
>>
>> Years ago I added support for Broadcom's BCM53573 SoCs. We released
>> firmwares based on Linux 4.4 (and later on 4.14) that worked almost
>> fine. There was one little issue we couldn't debug or fix: random hangs
>> and reboots. They were too rare to deal with (most devices worked fine
>> for weeks or months).
>>
>> Recently I updated my stable kernel 5.4 and I started experiencing
>> stability issues on my own! After some uptime (usually from 0 to 20
>> minutes of close to zero activity) serial console hangs. I can't type
>> anything and I stop getting any messages. I've to wait about a minute
>> for watchdog to kick in and reboot device.
>>
>> #####
>>
>> I took that great chance and decided to track the regression.
>>
>> Linux 5.4 stable branch worked stable up to the release v5.4.197.
>> Starting with v5.4.198 I started experiencing those stability issues. I
>> bisected it down to the commit 4460066eb248 ("ipv6: fix locking issues
>> with loops over idev->addr_list"):
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=4460066eb2480b9e203c73755e12e2efc820a27e
>>
>> With above commit reverted I was able to use stable 5.4 branch up to the
>> release v5.4.207. Starting with v5.4.208 it got unstable again. I
>> bisected it down to:
>> commit d0d583484d2e ("locking/refcount: Consolidate implementations of
>> refcount_t")
>> commit dab787c73f6e ("locking/refcount: Consolidate
>> REFCOUNT_{MAX,SATURATED} definitions")
>> commit 0d3182fbe689 ("locking/refcount: Move saturation warnings out of line")
>> commit 809554147d60 ("locking/refcount: Improve performance of generic
>> REFCOUNT_FULL code")
>> commit 9c9269977f03 ("locking/refcount: Move the bulk of the
>> REFCOUNT_FULL implementation into the <linux/refcount.h> header")
>> commit 04bff7d7b808 ("locking/refcount: Remove unused
>> refcount_*_checked() variants")
>> commit 513b19a43bec ("locking/refcount: Ensure integer operands are
>> treated as signed")
>> commit 68b4ee68e8c8 ("locking/refcount: Define constants for
>> saturation and max refcount values")
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=d0d583484d2ed9f5903edbbfa7e2a68f78b950b0
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=dab787c73f6e38d8e7ed3c1e683385e8f0fe28a2
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=0d3182fbe689e3808c03b6cde6be98237f9e0a4a
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=809554147d609163cfbaf815c443c575b538a7ef
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=9c9269977f03ab9c448c8b71581a951e0eb4fb7b
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=04bff7d7b8081c4bb2e8171be31d33df297eee5b
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=513b19a43becee5f7af6d283bb9d3d241a8a21a8
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=68b4ee68e8c8800cf8d6b61cc74b4031a0742a4c
>> (I didn't actually check above commits individually).
>>
>> Reverting above locking/refcount commits worked fine for few releases:
>> up to the v5.4.219. Starting with v5.4.220 I got hangs again. I bisected
>> that down to the commit 131287ff833d ("once: add DO_ONCE_SLOW() for
>> sleepable contexts").
>>
>> Reverting that extra commit from v5.4.238 allows me to run Linux for
>> hours again (currently 3 devices x 6 hours and counting). So I need in
>> total 10+1 reverts from 5.4 branch to get a stable kernel.
>>
>> #####
>>
>> I'm clueless at this point. Is that possible kernel has some locking bug
>> I can hit only using this specific SoC? BCM53573s have a single ARM
>> Cortex-A7 CPU running at 900 MHz. The only unusual thing about this hw I
>> can think of is a slow arch timer running at 36,8 kHz.
> 
>  From the look of it, it seems like the CPU might have bugs with atomics?
> 
> Your log indicates that your Cortex-A7 is r0p5 which is described to be susceptible to ARM_ERRATA_814220, do you have it enabled by any chance, if not, can you enable it and see if makes any difference?

I had it disabled. Unfortunately CONFIG_ARM_ERRATA_814220=y doesn't help.
