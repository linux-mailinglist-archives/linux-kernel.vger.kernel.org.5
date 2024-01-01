Return-Path: <linux-kernel+bounces-13929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DF28214F9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 19:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC3D281D3C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 18:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1926D529;
	Mon,  1 Jan 2024 18:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cHZFz6PZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463FFD51A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 18:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40b5155e154so117012435e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 10:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704133314; x=1704738114; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHr2f6HbVNJ8d+xjZu25lB3ItQC/vgDvUnApjWPeMfk=;
        b=cHZFz6PZhdEvK9nMZM8+OdDqslqRGxZx1WB/kW8mhQgpzsGs5oDtq0j0jUobXrrR84
         cEs3TfV8KwtCxR9kRKhFQrTm8UuoyzYGK4jEiwSlnGPWKldy/7tdfjvXX/vTyJuEs3Y8
         rAJFdKVeE3FTbiUIc4Umq/aFafuR45sZ/dfJo3KHD3mDitSTvUf8b2WN8cgnMxlhclt3
         rzIWJF7U5ALI6NtOfmuaYBB/38gQJoWiPUOvyw5lfOUPSa6VDGtqbLRoRCIj4e9YkVmp
         Xql5uqaxQRiht+kMrEKEd3/BfsIvIJ/3we/e8pCNZY43e91Q+EvDaSjCGrY/aNZ07Z3g
         tGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704133314; x=1704738114;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CHr2f6HbVNJ8d+xjZu25lB3ItQC/vgDvUnApjWPeMfk=;
        b=AHVM9kP0qS1rBzkGPhTLxKhB6UhRZJR36IMC9sLwHoh/jdpnhjNHHvV/Q5TOB07fPK
         lpifYs9pqe3XLLtwBQNSkCK9MdRpObWQ8ToYrUA7TD4rKlc6MW68RWn9KZ1Hl0f0estO
         E2k69VOPwFQeBHhsB6Mniwuhch6b85qjXdtWEndCEQFKkBA7woznG04oxkKQ4EhI4p8P
         WgdgKgRD8GEpMWpw28f3LrfK9uplueNZE+Tv/cP47pPMHJCHToCpPoLRZPd37+iUIzZl
         IinGMm0hhTvTDEZw0c/Plb3EqIKc9hRewjlRTCl1rzWu352Bv0fWx7XV7+uUAor9nL/F
         UwxA==
X-Gm-Message-State: AOJu0Yx1e7ysVUddrCbO1hrXzryb73lJHQOI9EMxNGOANRdCmbeXnpeC
	BnFAGgvDGTLrCgIQMqpPR56zFO66lT9SYg==
X-Google-Smtp-Source: AGHT+IH22c5W8UULbmDzJJXuxDGbhg8TPnkmV6gOdx3DBmHzYyu3thU+44CCb99NmoZVgNR+/fLCrw==
X-Received: by 2002:a05:600c:34cd:b0:40d:8369:3c19 with SMTP id d13-20020a05600c34cd00b0040d83693c19mr2081387wmq.248.1704133314406;
        Mon, 01 Jan 2024 10:21:54 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id y10-20020a1c4b0a000000b0040d877a5e61sm2815971wma.0.2024.01.01.10.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 10:21:53 -0800 (PST)
Message-ID: <0f07af92-e4b2-48de-88a6-dd9aa9e49743@linaro.org>
Date: Mon, 1 Jan 2024 19:21:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd.bergmann@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, Tony Lindgren <tony@atomide.com>,
 Joshua Yeong <joshua.yeong@starfivetech.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Inochi Amaoto <inochiama@outlook.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer drivers for v6.8-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Thomas,

happy new year 2024!

Please consider pulling these changes.

AFAICT, we had a few submissions recently with a finalized consensus, so 
this is a small set of changes, most of them being fixes.

   -- Daniel

The following changes since commit da65f29dada7f7cbbf0d6375b88a0316f5f7d6f5:

   timers: Fix nextevt calculation when no timers are pending 
(2023-12-20 16:49:39 +0100)

are available in the Git repository at:

   http://git.linaro.org/people/daniel.lezcano/linux.git 
tags/timers-v6.8-rc1

for you to fetch changes up to c0c4579d79d0df841e825c68df450909a0032faf:

   clocksource/drivers/ep93xx: Fix error handling during probe 
(2023-12-27 15:37:11 +0100)

----------------------------------------------------------------
- Fixed error handling at probe time and uninitialized return code on
   ep93xx (Arnd Bergman)

- Fixed some kerneldoc warning on Cadence TTC (Randy Dunlap)

- Fixed kerneldoc warning on Timer TI DM (Tony Lindgren)

- Handle interrupt disabling when shutting down the timer on RISC-V
   timer (Joshua Yeong)

- Add compatible string for the StarFive JH8100 clint (Sia Jee Heng)

- Separate mtime and mtimecmp registers in DT bindings (Inochi Amaoto)

----------------------------------------------------------------
Arnd Bergmann (1):
       clocksource/drivers/ep93xx: Fix error handling during probe

Inochi Amaoto (1):
       dt-bindings: timer: thead,c900-aclint-mtimer: separate mtime and 
mtimecmp regs

Joshua Yeong (1):
       clocksource/timer-riscv: Add riscv_clock_shutdown callback

Randy Dunlap (1):
       clocksource/drivers/cadence-ttc: Fix some kernel-doc warnings

Sia Jee Heng (1):
       dt-bindings: timer: Add StarFive JH8100 clint

Tony Lindgren (1):
       clocksource/drivers/timer-ti-dm: Fix make W=n kerneldoc warnings

  .../devicetree/bindings/timer/sifive,clint.yaml    |  1 +
  .../bindings/timer/thead,c900-aclint-mtimer.yaml   |  9 ++++++++-
  drivers/clocksource/timer-cadence-ttc.c            | 22 
++++++++++++++++------
  drivers/clocksource/timer-ep93xx.c                 |  5 ++---
  drivers/clocksource/timer-riscv.c                  |  7 +++++++
  drivers/clocksource/timer-ti-dm.c                  |  4 ++--
  6 files changed, 36 insertions(+), 12 deletions(-)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

