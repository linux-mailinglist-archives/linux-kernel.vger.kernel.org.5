Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2E67913B3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 10:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349741AbjIDInU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 04:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352598AbjIDIeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:34:07 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6FDCC4;
        Mon,  4 Sep 2023 01:34:03 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-5007616b756so1988064e87.3;
        Mon, 04 Sep 2023 01:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693816441; x=1694421241; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pHfPHsRS32lQzAyn/aCgRZs7D/3MVytHhFMqFPkbks=;
        b=mmamYPyYMDgasX3MXy3iJLQxIdDqTn5eEJBn23StPcyJgncCO/B3+7vAlJus1cZqFH
         1L0tUsVsqWrlH5TrMAS91EusMWWDMDleukNK9tXyKb599eBOQS46F0lccEelszd+bBQj
         sMN1x6Hyox4lUk0fBoZmwkUo5WdayJqZYXxdksIxuLYSYVgvynqB6QITv8Zk87SZz/lD
         Jwb3jBlYdmBxZTdUuZL0piIJAU09iGfYfVEoF5QfGR0J7A4IzhNWBtUjtxlqwdkW3b3s
         7stIR3u5mfIutoeK/R9/CTKG1Uw/wPqQMj2beyZfb7Jc5FhYmxEdqPUQkKBxXMNFYn4N
         Mbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693816441; x=1694421241;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0pHfPHsRS32lQzAyn/aCgRZs7D/3MVytHhFMqFPkbks=;
        b=OkfqlqznfXtkzN11qz5NprCeP4IXmmonDf5VT74rRHxvPj+QqChUf35wbbI/sjFdxh
         HVQ1rVI880z0RPmrPnuWsmuRnQ8DKUtAbMU81bk/CO9p/S6r7IY9ji/HK07+oj1W/tU2
         als/3BxtnlAdl6/pL+SWfeIVue3gEgshpoBCOQyCus57YYPul4mIo1hS/dm2HDYgOOoe
         0Y1PFHR0J+alUsrimlv476xDqHG7r8l4N25YncnYF/1WrXHscbGUgmv+g3v218gy1Hro
         /NHZxnMT41CMk1pmpFJONasWGg7ANoi0ODs19tJj9KuLjxz7cL5NrL8n3iFfG4eUHSv1
         WM5A==
X-Gm-Message-State: AOJu0Ywdj+i7TE1SiPcIdOgW3oekAH/K1cQKFDIAG5j35mGNMWNIOHKH
        XL8Qb2vh0/8k03hDDEJqa9Y=
X-Google-Smtp-Source: AGHT+IHtr6DV3rG/CtK+M6vhF1zbxFhnQjZ9kLSqp2je76cD/XZSMMFxTb4+Sq3uaqR44G5Jp5TLUg==
X-Received: by 2002:a05:6512:536:b0:500:a69a:1c4 with SMTP id o22-20020a056512053600b00500a69a01c4mr5910615lfc.58.1693816440971;
        Mon, 04 Sep 2023 01:34:00 -0700 (PDT)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id t11-20020a05640203cb00b0052a1d98618bsm5571217edw.54.2023.09.04.01.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 01:34:00 -0700 (PDT)
Message-ID: <a03a6e1d-e99c-40a3-bdac-0075b5339beb@gmail.com>
Date:   Mon, 4 Sep 2023 10:33:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     openwrt-devel@lists.openwrt.org,
        bcm-kernel-feedback-list@broadcom.com
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: ARM BCM53573 SoC hangs/lockups caused by locks/clock/random changes
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I made a second attempt on debugging some longstanding stability issues
affecting BCM53753 SoCs. Those are single CPU core ARM Cortex-A7 boards
with a pretty slow arch timer running at 36,8 kHz.

After 0 to 20 minutes of close to zero activity I experience hangs and I
need to wait a minute for watchdog to kick in and reboot device.

First debugging attempt:
https://lore.kernel.org/netdev/0f9d0cd6-d344-7915-7bc1-7a090b8305d2@gmail.com/T/ ("ARM board lockups/hangs triggered by locks and mutexes")

After a lot of bisecting, testing & hacking I believe there are 3 types
of kernel aspects that affect BCM53573 stability. I'd like to describe
them below to document my debugging work. I'm clueless at this point.
Maybe someone can come up with an idea of actual issue & ideally a
solution.

#####

1. Locking

During my first bisecting attempts I found multiple locking-related
commit that regressed stability.

Bisected commits:

131287ff833d ("once: add DO_ONCE_SLOW() for sleepable contexts").

and a following group:

d0d583484d2e ("locking/refcount: Consolidate implementations of refcount_t")
dab787c73f6e ("locking/refcount: Consolidate REFCOUNT_{MAX,SATURATED} definitions")
0d3182fbe689 ("locking/refcount: Move saturation warnings out of line")
809554147d60 ("locking/refcount: Improve performance of generic REFCOUNT_FULL code")
9c9269977f03 ("locking/refcount: Move the bulk of the REFCOUNT_FULL implementation into the <linux/refcount.h> header")
04bff7d7b808 ("locking/refcount: Remove unused refcount_*_checked() variants")
513b19a43bec ("locking/refcount: Ensure integer operands are treated as signed")
68b4ee68e8c8 ("locking/refcount: Define constants for saturation and max refcount values")

I don't believe there is actually anything wrong about above changes.
Maybe it's some tiny timing thing that my board just doesn't like?

#####

2. Clock (arm,armv7-timer)

While comparing main clock in Broadcom's SDK with upstream one I noticed
a tiny difference: mask value. I don't know it it makes any sense but
switching from CLOCKSOURCE_MASK(56) to CLOCKSOURCE_MASK(64) in
arm_arch_timer.c (to match SDK) increases average uptime (time before a
hang/lockup happens) from 4 minutes to 36 minutes.

#####

3. Random code changes

During my bisecting attempts I found one commit that regressed kernel
stability but actual changes were meaningless in context of locking. It
was commit ad9b10d1eaad ("mtd: core: introduce of support for dynamic
partitions"):
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ad9b10d1eaada169bd764abcab58f08538877e26

I thought that maybe it was all about making add_mtd_device() bigger and
changing addresses of a lot of symbols (looking at System.map). So I
reverted that mtd commit and developed a dummy change relocating as few
symbols (System.map) as possible while still breaking stability:

--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -94,6 +94,21 @@ void __cpuidle default_idle_call(void)
  		arch_cpu_idle();
  		start_critical_timings();
  	}
+
+	if (cpu_idle_force_poll == 1234)
+		arch_cpu_idle();
+	if (cpu_idle_force_poll == 5678)
+		arch_cpu_idle();
+	if (cpu_idle_force_poll == 1234)
+		arch_cpu_idle();
+	if (cpu_idle_force_poll == 5678)
+		arch_cpu_idle();
+	if (cpu_idle_force_poll == 1234)
+		arch_cpu_idle();
+	if (cpu_idle_force_poll == 5678)
+		arch_cpu_idle();
+	if (cpu_idle_force_poll == 1234)
+		arch_cpu_idle();
  }

  static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,

Above dummy change didn't relocate thousands of symbols but only about
20 of them. They happened to be lock symbols however. Does it make any
sense for above diff to regress kernel stability for me and cause
hangs/lockups?

--- System.map.good
+++ System.map.bad
@@ -22214,36 +22214,36 @@
  c062e7e0 T __cpuidle_text_start
  c062e7e0 t cpu_idle_poll
  c062e860 T default_idle_call
-c062e884 T __cpuidle_text_end
-c062e888 T __lock_text_start
-c062e8a0 T _raw_spin_unlock_irqrestore
-c062e8c0 T _raw_spin_trylock
-c062e900 T _raw_write_unlock_irqrestore
-c062e920 T _raw_read_trylock
-c062e960 T _raw_write_trylock
-c062e9a0 T _raw_spin_lock_bh
-c062ea00 T _raw_read_lock_bh
-c062ea40 T _raw_write_lock_bh
-c062ea80 T _raw_spin_trylock_bh
-c062eb00 T _raw_spin_unlock_bh
-c062eb40 T _raw_write_unlock_bh
-c062eb80 T _raw_read_unlock_bh
-c062ebc0 T _raw_read_unlock_irqrestore
-c062ec00 T _raw_write_lock
-c062ec40 T _raw_write_lock_irq
-c062ec80 T _raw_write_lock_irqsave
-c062ecc0 T _raw_read_lock
-c062ed00 T _raw_spin_lock
-c062ed40 T _raw_read_lock_irq
-c062ed80 T _raw_spin_lock_irq
-c062ede0 T _raw_spin_lock_irqsave
-c062ee40 T _raw_read_lock_irqsave
-c062ee70 T __hyp_text_end
-c062ee70 T __hyp_text_start
-c062ee70 T __kprobes_text_end
-c062ee70 T __kprobes_text_start
-c062ee70 T __lock_text_end
-c062ee70 T _etext
+c062e954 T __cpuidle_text_end
+c062e958 T __lock_text_start
+c062e960 T _raw_spin_unlock_irqrestore
+c062e980 T _raw_spin_trylock
+c062e9c0 T _raw_write_unlock_irqrestore
+c062e9e0 T _raw_read_trylock
+c062ea20 T _raw_write_trylock
+c062ea60 T _raw_spin_lock_bh
+c062eac0 T _raw_read_lock_bh
+c062eb00 T _raw_write_lock_bh
+c062eb40 T _raw_spin_trylock_bh
+c062ebc0 T _raw_spin_unlock_bh
+c062ec00 T _raw_write_unlock_bh
+c062ec40 T _raw_read_unlock_bh
+c062ec80 T _raw_read_unlock_irqrestore
+c062ecc0 T _raw_write_lock
+c062ed00 T _raw_write_lock_irq
+c062ed40 T _raw_write_lock_irqsave
+c062ed80 T _raw_read_lock
+c062edc0 T _raw_spin_lock
+c062ee00 T _raw_read_lock_irq
+c062ee40 T _raw_spin_lock_irq
+c062eea0 T _raw_spin_lock_irqsave
+c062ef00 T _raw_read_lock_irqsave
+c062ef30 T __hyp_text_end
+c062ef30 T __hyp_text_start
+c062ef30 T __kprobes_text_end
+c062ef30 T __kprobes_text_start
+c062ef30 T __lock_text_end
+c062ef30 T _etext
  c062f000 D __start_rodata
  c062f000 D sigreturn_codes
  c062f044 d cpu_arch_name

###

As those hangs/lockups are related to so many different changes it's
really hard to debug them.

This bug seems to be specific to the slow arch clock that affects
stability only when kernel locking code and symbols layout trigger some
very specific timing.

Enabling CONFIG_PROVE_LOCKING seems to make issue go away but it affects
so much code it's hard to tell why it actually matters.

Same for disabling CONFIG_SMP. I noticed Broadcom's SDK keeps it
disabled. I tried it and it improves stability (I had 3 devices with 6
days of uptime and counting) indeed. Again it affects a lot of kernel
parts so it's hard to tell why it helps.

Unless someone comes up with some magic solution I'll probably try
building BCM53573 images without CONFIG_SMP for my personal needs.
