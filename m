Return-Path: <linux-kernel+bounces-86809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF11186CB1D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709491F24FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCE1133426;
	Thu, 29 Feb 2024 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DW3ov5vR"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A797F12A177
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216055; cv=none; b=crIeC4Nh2uuaHC6fk3OFz7B6U1OD/37cy5VADL/PkmJO+vFd91DYpiJswmUmuxo6y/Yh18N+JsgU9769eWI4plhOycCx2ETMdk6IO+lHUfsZYWkj/N7U974fskLrKdzBCuJF6CEoKYmFWBJG8UN3CkmbHh4HRv9gDXTD5I26NMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216055; c=relaxed/simple;
	bh=CXfstH9rFiGs2KZVe+LvNMjRuL5Ovq0heX79evtjmX0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MDdQmNQJWkaOBlONXSxxP4Bue9Tc5eHrNjzijRp3VNkNoPaIpEpl4Jof8m19tPO4ixrcBcfumw22799SzldH1dkAF+je/drwhALvm5Tp4JsGe7AADv3O235PVdO6nspc4w65n0xLevzjKlmur13Ea8Zudp/HXZ2zya8D669DWIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DW3ov5vR; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-21f0c82e97fso509040fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 06:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709216052; x=1709820852; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hu7zbppsAXpR1Zx1mO+XV9YvHFR78uicpnC5PSntEno=;
        b=DW3ov5vR3RH/oS30BFTLpLWuKxeu/vUxSq1aoOzpAhgzD3ed3WoiZbfAYtHDB3Zudg
         UK4xKleN6ChzepojjvVgF60OmFr4x9QZwyER3wzeKYN9KptVMJ5fGFU3xwPN+legL8cC
         qofBiuUUMx3U53vjWovjloSgRpnl8yxs4ewgAuR4iScygIdT70BIMGCKPMIz9WwCrewB
         5xQKyGvpg0CrM3VjnlnHZak6tEY01oNh3ASKuaqwKZ1CXipeLvZo8xfVlxwjcik3FVSz
         kLmK4Guq+fv1pQykFgW08Z0eAhHa6DtWeYg6HP+C6STwWRyo9/6YoRpjn9wxfUbMzYd6
         cd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709216052; x=1709820852;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hu7zbppsAXpR1Zx1mO+XV9YvHFR78uicpnC5PSntEno=;
        b=k0ZuxVFSDrv8on/RKa0RPHzKIogW9iUrGHNAQTDYQ6JgQB9ipTnbFvayZWTqP9yOjC
         Bdgk4PZcTH8GxOGOR/sdwaLedmycUDZhM5AadTVGkLXs2RvKSpwhhBnCHX+6PK5qKnbJ
         lfDd9OEfT51uHaIHf1XM2mV7CcK+CVUqDD7/y+c9RrETylbl4x0pdlFAyJAl9VwayM5c
         NI2oqP26pJAeIjIVXJAwZxnXgKqfdhZmRhxP5i/Prawc7ZjrvyyJtDYIhK6mwMdMmEqn
         4WkXzI+GPqc40N6Vmn2T5C4ky5yQCgFqe1d95k5dfEk9kg0JUIWHv9xkwvB1B5QTQORz
         91XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdM8NszA8T5b3u12+z7rX7I2h4I5uVo/GGAAX4rsFaf9oqHDrwEhQjPZX35khuk4VyODEJlqzxz6odegw2VivztmvHTwQ1lY7eaSEo
X-Gm-Message-State: AOJu0Yzyi5vY8whUSW7v9lnndAnfXR6Y+BP/s5WFS11F4/4PHgtxsy6j
	5yg7CbGyyFt2loIdwMXpK0+HOXMv5Y6smhbY6GjwjM34+mn52MiLzS3dUCqUKf6jdQjhFEXDpoA
	gMVhi0NcF5jrvicOMUPkLehKXG7RBPbxZY9t8QQ==
X-Google-Smtp-Source: AGHT+IEtW12XpM1vh8XjxJ3TdO+yTWr7kPmfzf56pz6jnq72H6ah3lzxvb0L63OZguJjgTL/FqFEiSKM4sf2Y9qPaec=
X-Received: by 2002:a05:6870:9d10:b0:220:8989:2ab9 with SMTP id
 pp16-20020a0568709d1000b0022089892ab9mr2430522oab.13.1709216052606; Thu, 29
 Feb 2024 06:14:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 29 Feb 2024 19:44:01 +0530
Message-ID: <CA+G9fYtddf2Fd3be+YShHP6CmSDNcn0ptW8qg+stUKW+Cn0rjQ@mail.gmail.com>
Subject: WinLink E850-96: WARNING: at block/blk-settings.c:204 blk_validate_limits
To: linux-block <linux-block@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	open list <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The arm64 WinLink E850-96 Board boot failed with 16K and 64K page size builds
Please find the below warning log on Linux next-20240229.
First noticed on the next-20240220 tag.

This issue arises only when one of these Kconfig options is enabled.
  CONFIG_ARM64_16K_PAGES=y
  CONFIG_ARM64_64K_PAGES=y

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Warning log:
-------
[    2.231008] mmc_host mmc0: Bus speed (slot 0) = 49968750Hz (slot
req 52000000Hz, actual 49968750HZ div = 0)
[    2.231714] mmc_host mmc0: Bus speed (slot 0) = 399750000Hz (slot
req 200000000Hz, actual 199875000HZ div = 1)
[    2.241961] mmc0: new HS400 Enhanced strobe MMC card at address 0001
[    2.249182] ------------[ cut here ]------------
[    2.252371] WARNING: CPU: 3 PID: 90 at block/blk-settings.c:204
blk_validate_limits (block/blk-settings.c:204 (discriminator 1))
[    2.261056] Modules linked in:
[    2.264082] CPU: 3 PID: 90 Comm: kworker/3:1 Not tainted
6.8.0-rc6-next-20240229 #1
[    2.271724] Hardware name: WinLink E850-96 board (DT)
[    2.276756] Workqueue: events_freezable mmc_rescan
[    2.281534] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    2.288479] pc : blk_validate_limits (block/blk-settings.c:204
(discriminator 1))
[    2.293076] lr : blk_set_default_limits (block/blk-settings.c:241)
<trim>
[    2.337595] PM: genpd: Disabling unused power domains
[    2.338361] xhci-hcd xhci-hcd.0.auto: remove, state 84
[    2.338391] usb usb1: USB disconnect, device number 1
[    2.343322]  x1 : 0000000000001000 x0 : ffff8000a504f888
[    2.343335] Call trace:
[    2.343339] blk_validate_limits (block/blk-settings.c:204 (discriminator 1))
[    2.343350] blk_alloc_queue (block/blk-core.c:421)
[    2.343362] blk_mq_alloc_queue (block/blk-mq.c:4083 (discriminator 4))
[    2.350571] ALSA device list:
[    2.352700] xhci-hcd xhci-hcd.0.auto: USB bus 1 deregistered
[    2.355651] __blk_mq_alloc_disk (block/blk-mq.c:4130)
[    2.355664] mmc_alloc_disk (drivers/mmc/core/queue.c:379)
[    2.355678] mmc_init_queue (drivers/mmc/core/queue.c:463)
[    2.359577]   No soundcards found.
[    2.362942] mmc_blk_alloc_req (drivers/mmc/core/block.c:2500
(discriminator 1))
[    2.362951] mmc_blk_probe (drivers/mmc/core/block.c:2603
drivers/mmc/core/block.c:3025)
[    2.446877] mmc_bus_probe (drivers/mmc/core/bus.c:132)
[    2.446892] really_probe (drivers/base/dd.c:579 drivers/base/dd.c:658)
[    2.454016] __driver_probe_device (drivers/base/dd.c:800)
[    2.458346] driver_probe_device (drivers/base/dd.c:830)
[    2.462513] __device_attach_driver (drivers/base/dd.c:959)
[    2.466939] bus_for_each_drv (drivers/base/bus.c:457)
[    2.470761] __device_attach (drivers/base/dd.c:1032)
[    2.474579] device_initial_probe (drivers/base/dd.c:1080)
[    2.478746] bus_probe_device (drivers/base/bus.c:532)
[    2.482563] device_add (drivers/base/core.c:3646)
[    2.486037] mmc_add_card (drivers/mmc/core/bus.c:371)
[    2.489683] mmc_attach_mmc (drivers/mmc/core/mmc.c:2353)
[    2.493500] mmc_rescan (drivers/mmc/core/core.c:2097 (discriminator
1) drivers/mmc/core/core.c:2259 (discriminator 1))
[    2.496974] process_one_work (kernel/workqueue.c:3253)
[    2.500966] worker_thread (kernel/workqueue.c:3322 (discriminator
2) kernel/workqueue.c:3409 (discriminator 2))
[    2.504700] kthread (kernel/kthread.c:388)
[    2.507914] ret_from_fork (arch/arm64/kernel/entry.S:861)
[    2.511473] ---[ end trace 0000000000000000 ]---
[    2.516435] mmcblk: probe of mmc0:0001 failed with error -22
[    2.522114] Waiting for root device /dev/mmcblk0p12...

Kconfig:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2ccVUNsQjaWBcREYI0wFRjzG3oa/config

Steps to reproduce:
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2ccVWjLtBJ3IuDSKLkyaFholQ67/reproducer

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240229/testrun/22884460/suite/boot/test/gcc-13-lkftconfig-16k_page_size/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240229/testrun/22884435/suite/boot/test/gcc-13-lkftconfig-64k_page_size/details/
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2d2JxLaSCZ6cTNGMeKdCbAjk9Sh
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2d2JuyeiEHCtWGJYV80n1tF77lh/


--
Linaro LKFT
https://lkft.linaro.org

