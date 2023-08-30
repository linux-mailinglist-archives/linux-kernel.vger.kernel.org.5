Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD48278DF88
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240342AbjH3TbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244610AbjH3N2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:28:32 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4711B0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:28:29 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bceca8a41aso82368651fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693402107; x=1694006907; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEWMoFnUcnc1j3RYasTyLd2yi0P56Bg3IkoCVeqrlhY=;
        b=IjgGw3NUW5dKTmHFVv9SBbJmwOoYo/TfaPxLeJKjUmUEQPQY8qR6IYDJ0NKBGMDruG
         z8ooSR370K4ePpS6XdI74U7LVXe75oLUvZJ8JCRVQd/tzJuF0RT/0VVqLlvG4JCfTRP1
         qAAxIpZ8iuBh/R0SZ3RR9Hdnh3DGh3PsHCda3nHV0zgkCzIlzb1PoWdS0DCwt0itC3QL
         H3uMbKy+We7sP/20V7pDr2kSLrAEPC0KEfOcLfDmxKYPvZaB4CUsfb1R+0012T2ubskB
         22Xqss82vx6kBJgQfMm1ismtEOlv5M4xYXjWz4stHyJaLARXJS6c7uZSTOsNJGTWFUZu
         EnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693402107; x=1694006907;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iEWMoFnUcnc1j3RYasTyLd2yi0P56Bg3IkoCVeqrlhY=;
        b=IzAmNyUEy8JkQ48KZQ8FpMy9Buq/f248GUee5sP7q3LvxGNpxzjlDEQTje/40c+Tvq
         JZtNfuU8oZTcO213zcvu5wJrRfE0B2352CHpJMhOTvQ3etcHSItkinCUy9NfuLT8kXLX
         leRw9NhKHJoFWLBs4TtDJ5M/7a1XOPJvRIA7pL3AFFpQNOb4HGXLbq2QwhW6uH7tXScz
         kenm2DmlWeckWk8+qB9fdOIbtl4NqeWzeTRPKrXIlargbE/+xB4aGPXFqd2+8kZx/ycR
         KjJ44O1N7kDbvuy7yWdxU0AVe/EakRKUkk7jk6gYgq6uT8G4eTa5BicQ4QVpwOg+Ux3L
         /WxQ==
X-Gm-Message-State: AOJu0Yz43YwfQ9feO7i139iup3Gpim6xqfZ/qyd37NfZ4mxV2VbAXX7/
        gHx+70k/OQIBbXM+ZKLMQ7rz1lWd8RnC/LUmvmI=
X-Google-Smtp-Source: AGHT+IHkxGLc0bZ1dsKFs8FHmkJiu39FD2AjzklvCQwrq8B0DpWyOy7SEQMGgk/VR4LWDkrO1pJvCQ==
X-Received: by 2002:a2e:9dcb:0:b0:2bd:16e6:f07c with SMTP id x11-20020a2e9dcb000000b002bd16e6f07cmr1859462ljj.17.1693402107364;
        Wed, 30 Aug 2023 06:28:27 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id q13-20020a7bce8d000000b003fbc30825fbsm2338698wmj.39.2023.08.30.06.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 06:28:26 -0700 (PDT)
Message-ID: <feead2fd-8113-c270-a094-10de6570a2d2@linaro.org>
Date:   Wed, 30 Aug 2023 15:28:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Walter Chang <walter.chang@mediatek.com>,
        Tom Rix <trix@redhat.com>, Mans Rullgard <mans@mansr.com>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer drivers for v6.6-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

please consider the following changes for the timer drivers material. 
Sorry for the late PR.

Thanks

The following changes since commit 8b5bf64c89c7100c921bd807ba39b2eb003061ab:

   clocksource/drivers/cadence-ttc: Fix memory leak in ttc_timer_probe 
(2023-06-23 09:33:44 +0200)

are available in the Git repository at:

   https://git.linaro.org/people/daniel.lezcano/linux.git 
tags/timers-v6.6-rc1

for you to fetch changes up to 0a8b07c77ea09602a152d3604e599f95726306d0:

   clocksource: Explicitly include correct DT includes (2023-08-18 
12:16:01 +0200)

----------------------------------------------------------------
- Remove oxnas the 0x810 and the 0x820 timer drivers, the platform
   being no longer maintained and removed (Neil Armstrong)

- Disable the timer before programming the CVAL as there is no
   guarantee of atomicity on the ARM architected timer (Walter Chang)

- Set variable ls1x_timer_lock static on the Loongson1 (Tom Rix)

- Remove duplication of code and data by factoring out the structures
   into a single one and convert to the platform driver on the sun5i
   (Mans Rullgard)

- Explicitly include correct DT includes (Rob Herring)

----------------------------------------------------------------
Mans Rullgard (3):
       clocksource/drivers/sun5i: Remove duplication of code and data
       clocksource/drivers/sun5i: Remove pointless struct
       clocksource/drivers/sun5i: Convert to platform device driver

Neil Armstrong (2):
       clocksource/drivers/timer-oxnas-rps: Remove obsolete timer driver
       dt-bindings: timer: oxsemi,rps-timer: remove obsolete bindings

Rob Herring (1):
       clocksource: Explicitly include correct DT includes

Tom Rix (1):
       clocksource/drivers/loongson1: Set variable ls1x_timer_lock 
storage-class-specifier to static

Walter Chang (1):
       clocksource/drivers/arm_arch_timer: Disable timer before 
programming CVAL

  Documentation/devicetree/bindings/timer/oxsemi,rps-timer.txt |  17 
------------
  drivers/clocksource/Kconfig                                  |   7 -----
  drivers/clocksource/Makefile                                 |   1 -
  drivers/clocksource/arm_arch_timer.c                         |   7 +++++
  drivers/clocksource/bcm2835_timer.c                          |   2 +-
  drivers/clocksource/nomadik-mtu.c                            |   2 +-
  drivers/clocksource/sh_cmt.c                                 |   1 -
  drivers/clocksource/timer-cadence-ttc.c                      |   1 +
  drivers/clocksource/timer-gxp.c                              |   1 +
  drivers/clocksource/timer-integrator-ap.c                    |   2 +-
  drivers/clocksource/timer-loongson1-pwm.c                    |   2 +-
  drivers/clocksource/timer-oxnas-rps.c                        | 288 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  drivers/clocksource/timer-sun5i.c                            | 288 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------------------------------------------------------------------------
  drivers/clocksource/timer-tegra186.c                         |   1 -
  drivers/clocksource/timer-ti-dm.c                            |   1 -
  15 files changed, 136 insertions(+), 485 deletions(-)
  delete mode 100644 
Documentation/devicetree/bindings/timer/oxsemi,rps-timer.txt
  delete mode 100644 drivers/clocksource/timer-oxnas-rps.c

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
