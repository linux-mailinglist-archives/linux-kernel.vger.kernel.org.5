Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BF57D7060
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344062AbjJYPHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbjJYPHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:07:19 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544DC128
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 08:07:17 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4083f61322fso45789255e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 08:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698246436; x=1698851236; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GH62mty2bCjs5fIxQas1NwVzKXHDhJFo6kS8/tesvyU=;
        b=G/jmtxjS4II1uR2mxanbVpRkBSPdHvFpLymJLb1aDv1dLF5982FmX2IYyQFGjxCeGM
         X3kZPiz2mXMflY5e4l2Ay5FiTqYS4w4UB1ugKO48k2hsQ8xjp1MpGTRuzft9SJ2GoRsi
         E9XrBcTZpGSWuRRJgRz87WJmBi1TDOxmyaxO91QJg1JyDmXl6oIFpl2GIKPrXCr2Tk8z
         VlrynS7QqME+0cGCPWYeBOZJ2yD5AfUbiI2/x7qrTW7DXW8bJTub/fFvbacatVb1iKkH
         TsLKDj1zC7fO9nMeNvQvRCJKos7PIDmzkp821Vq40lxuAbLej4XFr+Pgi5MbQe2RTnWS
         jW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698246436; x=1698851236;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GH62mty2bCjs5fIxQas1NwVzKXHDhJFo6kS8/tesvyU=;
        b=k4/LjVd0S4ZeGvAuzQX5Fl9XjWiRppRIBPJ3TawcgiKC2WUKhe52Gt0kUhzvZ8dSUk
         jNawRndGOBinw8kPs2h0oegykdTVP0ISu6eQ7G1eKQUE8iozKBuDAFkAYYvEigX8OPQ9
         OabfBIwptQXfcH5Z3o2CvsZT+apjd5pb4hU5o/oYUf5qVfwkr7TaIp3SHDhc1JcxkaOY
         bbjzy2YkBlbXyJSp66NIDWFEbhXWZyHaW2Kk9qTqb9Q//Lv4KT/jXDMPI0sEMpPlITYU
         t6yaTQHprx+DGk+fXl25/UQ4Pv8klFFGKEURbDTnznyMdt65VG4Pbu5YXE7dgzCvfaOH
         4W/A==
X-Gm-Message-State: AOJu0Yy6kbGHxD8Qw3a3w+a6/N4/EoQrubDHUQWp5L9YQSpwEJ5b5fOf
        6zlrwc/GbH4i/NtixWN5mA5hEg==
X-Google-Smtp-Source: AGHT+IFrCtzp6x89GEkaUWdp384yStWA955jZ7nt7fXUSOZ5ZzavfOXv6bkULUDOn9If9Waz/0EXtA==
X-Received: by 2002:a05:600c:a47:b0:408:39d3:a26b with SMTP id c7-20020a05600c0a4700b0040839d3a26bmr11492671wmq.40.1698246435582;
        Wed, 25 Oct 2023 08:07:15 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id t8-20020a05600c198800b004064cd71aa8sm9324wmq.34.2023.10.25.08.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 08:07:15 -0700 (PDT)
Message-ID: <0b238075-6f4c-91b5-2491-50a714d024f4@linaro.org>
Date:   Wed, 25 Oct 2023 17:07:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, Bai Ping <ping.bai@nxp.com>,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Ronald Wahl <ronald.wahl@raritan.com>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer drivers for v6.7-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

The following changes since commit 8ceea12d183cf29f28072dede218a04eda2a789c:

   alarmtimer: Use maximum alarm time for suspend (2023-10-09 15:03:28 
+0200)

are available in the Git repository at:

   https://git.linaro.org/people/daniel.lezcano/linux.git 
tags/timers-v6.7-rc1

for you to fetch changes up to c28ca80ba3b531a79402d61046aef83272f86b08:

   clocksource: ep93xx: Add driver for Cirrus Logic EP93xx (2023-10-15 
23:36:36 +0200)

----------------------------------------------------------------
- Fix DT bindings typos, readability and wrong information about
   underflow and overflow interrupts for the RZ/G2L MTU3a driver (Biju
     Das)

- Fix a memory leak in the error path when probing the i.MX GPT timer
   (Jacky Bai)

- Don't use clk_get_rate() in atomic context as the function might
   sleep. Store the clock and use notifiers to receive a clocke rate
     change notification (Ivaylo Dimitrov)

- Remove superfluous error message when platform_get_irq() fails
   because the underlying function already prints one (Yang Li)

- Add wakeup capability flag for the risc-V ACPI timer (Sunil V L)

- Fix initialization of the TCB timers which are in cascade as the
   second timer is reset after the first wraps up leading to
     inconsistent scheduler behavior (Ronald Wahl)

- Add DT bindings and driver for Cirrus Logic EP93xx (Nikita Shubin)

----------------------------------------------------------------
Biju Das (3):
       dt-bindings: timer: renesas,rz-mtu3: Fix overflow/underflow 
interrupt names
       dt-bindings: timer: renesas,rz-mtu3: Improve documentation
       dt-bindings: timer: renesas,rz-mtu3: Document RZ/{G2UL,Five} SoCs

Ivaylo Dimitrov (1):
       drivers/clocksource/timer-ti-dm: Don't call clk_get_rate() in 
stop function

Jacky Bai (1):
       clocksource/drivers/timer-imx-gpt: Fix potential memory leak

Nikita Shubin (2):
       dt-bindings: timers: Add Cirrus EP93xx
       clocksource: ep93xx: Add driver for Cirrus Logic EP93xx

Ronald Wahl (1):
       clocksource/drivers/timer-atmel-tcb: Fix initialization on SAM9 
hardware

Sunil V L (1):
       clocksource/timer-riscv: ACPI: Add timer_cannot_wakeup_cpu

Yang Li (1):
       clocksource/drivers/sun5i: Remove surplus dev_err() when using 
platform_get_irq()

  .../bindings/timer/cirrus,ep9301-timer.yaml        |  49 ++++++
  .../devicetree/bindings/timer/renesas,rz-mtu3.yaml |  67 ++++----
  drivers/clocksource/Kconfig                        |  11 ++
  drivers/clocksource/Makefile                       |   1 +
  drivers/clocksource/timer-atmel-tcb.c              |   1 +
  drivers/clocksource/timer-ep93xx.c                 | 190 
+++++++++++++++++++++
  drivers/clocksource/timer-imx-gpt.c                |  18 +-
  drivers/clocksource/timer-riscv.c                  |   4 +
  drivers/clocksource/timer-sun5i.c                  |   4 +-
  drivers/clocksource/timer-ti-dm.c                  |  36 +++-
  10 files changed, 332 insertions(+), 49 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/timer/cirrus,ep9301-timer.yaml
  create mode 100644 drivers/clocksource/timer-ep93xx.c



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
