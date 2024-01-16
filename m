Return-Path: <linux-kernel+bounces-27690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E89982F42A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29F21C23986
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEEC1CF82;
	Tue, 16 Jan 2024 18:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRiiHs2n"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB391CD2D;
	Tue, 16 Jan 2024 18:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429416; cv=none; b=qKfaY/kqnwPVu5kfgfkn0Ci5FKRvrggbic9rpPKoEGe/jV3tgQl0FIgSIO09929taNDN6ov7//b9Dkg5WH56q3mzbNpWYQmgwOq2wuJttdByk+qeo4HWO4kIfh5QUlE0JpoY2C9BifHPev9YEg4cJMMcKrA0VX8myGNS8tup/bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429416; c=relaxed/simple;
	bh=t6QZpw8tRWPxfxmxVzrShS7GSh7KnuODXeUv5G5MGUg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Sender:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRblRxPAoE5bU2j6MiDxi8sKFB/sVqLUwmTjnlVTzC4NjwhH2Au9Zg5quL4B4jt1stZMmOp+MJEi5Lmhp7BHaWQ0tBRfa7nGYUjIg7nRHZj9OaLNBz1w5ManLppbakNz01SxGjj0jlqWfLZ94qDoVlx1GMac+YKeD7VPpsNQJi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRiiHs2n; arc=none smtp.client-ip=209.85.215.177
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so3628777a12.0;
        Tue, 16 Jan 2024 10:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705429414; x=1706034214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MD3fKbxQQQgI0U3y5wKrOkObfHPHYecniiq4Rfz4jHE=;
        b=lRiiHs2nwWUodKra/HjfG0MdwcimjKksnl5gL2qC1eD9YRf+xcZ8C15NPdPHsbjkQT
         j25ADmdNjxtMT33zLPV8oqKeYHNzH22kt9EvkEgAPG0AvIc1RnIA7G1+RVBvXIoJImPL
         rX4R9CQ02gSSvvRZIFnhT/ScxVBz3HtBPzeRL36bUdnaKRlkjpoWIj+DzWJI/WdvVZTm
         JNQEFj9SC8kkdHJ802QA8uwqNHIcdLuG6GTuILKjYdkIzH7VNyCjfUQyrRLfx2JhoBBU
         nlVetcbVpkYcDvrF1tdzRMK4LewSnauAVyZ5ivn+i6H4hCd5Ath8ifktRmRIRWtxs8QA
         cXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705429414; x=1706034214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MD3fKbxQQQgI0U3y5wKrOkObfHPHYecniiq4Rfz4jHE=;
        b=AUdM5zrFhqzy9gS5+4lnwrJeKDRjpv7gDR4tWBUvARb0wn58wu56TXCQxwECytJri1
         yVuyTaxlJl1qQIBzmp7e0+HwYBW63iAJWXB5R5Je4gkrBWteTfZHfrJTzw2q7iciUb6L
         C4g48cnZxT1nS1EFr7+DgD02beUfVmK8Ob0dPAwGjWE+2WtgjRTY2aNmv32ZF4paJOdM
         fZaIUKRxyl+qcqv/igfRjzDLk9RRklv+Xa3312St6SsjHtAqhwcQSXhziSqiZN7OdlJp
         arFNzKb5hszoxz9RSm5DHrPVWskCDTvasvE2uDHss5wjVqRVV1oLp2GbYQcnQdvixb0n
         nFqA==
X-Gm-Message-State: AOJu0Yz9KCLrbIOOaiOstbzrOh0lv7XD0A/u8JPzGREX2WmdgAD9Ah1p
	o6XIo2NofGTp/Vh9K61FMEs=
X-Google-Smtp-Source: AGHT+IHvKGy5JSSRKLyL4xP93sojht9KV/bnqAX2PBFnMKralDeocAfXsvJYWTWi4P0g0wy+GikmEg==
X-Received: by 2002:a17:90a:3ccb:b0:28c:3507:a89e with SMTP id k11-20020a17090a3ccb00b0028c3507a89emr4052831pjd.21.1705429414004;
        Tue, 16 Jan 2024 10:23:34 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id pt6-20020a17090b3d0600b0028e60ceb419sm3646455pjb.1.2024.01.16.10.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 10:23:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 16 Jan 2024 10:23:31 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFC PATCH] gpiolib: remove extra_checks
Message-ID: <19dca2a9-36e1-4a6b-9b65-db4c0a163d56@roeck-us.net>
References: <20231219201102.41639-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219201102.41639-1-brgl@bgdev.pl>

Hi,

On Tue, Dec 19, 2023 at 09:11:02PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> extra_checks is only used in a few places. It also depends on
> a non-standard DEBUG define one needs to add to the source file. The
> overhead of removing it should be minimal (we already use pure
> might_sleep() in the code anyway) so drop it.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This patch triggers (exposes) the following backtrace.

BUG: sleeping function called from invalid context at drivers/gpio/gpiolib.c:3738
in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 7, name: kworker/0:0
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
3 locks held by kworker/0:0/7:
 #0: c181b3a4 ((wq_completion)events_freezable){+.+.}-{0:0}, at: process_scheduled_works+0x23c/0x644
 #1: c883df28 ((work_completion)(&(&host->detect)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x23c/0x644
 #2: c24e1720 (&host->lock){-...}-{2:2}, at: sdhci_check_ro+0x14/0xd4
irq event stamp: 2916
hardirqs last  enabled at (2915): [<c0b18838>] _raw_spin_unlock_irqrestore+0x70/0x84
hardirqs last disabled at (2916): [<c0b1853c>] _raw_spin_lock_irqsave+0x74/0x78
softirqs last  enabled at (2360): [<c00098a4>] __do_softirq+0x28c/0x4b0
softirqs last disabled at (2347): [<c0022774>] __irq_exit_rcu+0x15c/0x1a4
CPU: 0 PID: 7 Comm: kworker/0:0 Tainted: G                 N 6.7.0-09928-g052d534373b7 #1
Hardware name: Freescale i.MX25 (Device Tree Support)
Workqueue: events_freezable mmc_rescan
 unwind_backtrace from show_stack+0x10/0x18
 show_stack from dump_stack_lvl+0x34/0x54
 dump_stack_lvl from __might_resched+0x188/0x274
 __might_resched from gpiod_get_value_cansleep+0x14/0x60
 gpiod_get_value_cansleep from mmc_gpio_get_ro+0x20/0x30
 mmc_gpio_get_ro from esdhc_pltfm_get_ro+0x20/0x48
 esdhc_pltfm_get_ro from sdhci_check_ro+0x44/0xd4
 sdhci_check_ro from mmc_sd_setup_card+0x2a8/0x47c
 mmc_sd_setup_card from mmc_sd_init_card+0xfc/0x93c
 mmc_sd_init_card from mmc_attach_sd+0xd8/0x180
 mmc_attach_sd from mmc_rescan+0x2ac/0x30c
 mmc_rescan from process_scheduled_works+0x2e4/0x644
 process_scheduled_works from worker_thread+0x188/0x418
 worker_thread from kthread+0x11c/0x144
 kthread from ret_from_fork+0x14/0x38

This is with the imx25-pdk qemu emulation when booting from mmc/sd card.
It isn't really surprising since sdhci_check_ro() calls the gpio code under
spin_lock_irqsave(). No idea how to fix that, so I won't even try.

Bisect log attached for reference.

Guenter

---
# bad: [052d534373b7ed33712a63d5e17b2b6cdbce84fd] Merge tag 'exfat-for-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat
# good: [70d201a40823acba23899342d62bc2644051ad2e] Merge tag 'f2fs-for-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs
git bisect start 'HEAD' '70d201a40823'
# good: [b6e1b708176846248c87318786d22465ac96dd2c] drm/xe: Remove uninitialized variable from warning
git bisect good b6e1b708176846248c87318786d22465ac96dd2c
# good: [7912a6391f3ee7eb9f9a69227a209d502679bc0c] Merge tag 'sound-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect good 7912a6391f3ee7eb9f9a69227a209d502679bc0c
# bad: [a3cc31e75185f9b1ad8dc45eac77f8de788dc410] Merge tag 'libnvdimm-for-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
git bisect bad a3cc31e75185f9b1ad8dc45eac77f8de788dc410
# bad: [576db73424305036a6aa9e40daf7109742fbb1df] Merge tag 'gpio-updates-for-v6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux
git bisect bad 576db73424305036a6aa9e40daf7109742fbb1df
# good: [61f4c3e6711477b8a347ca5fe89e5e6613e0a147] Merge tag 'linux-watchdog-6.8-rc1' of git://www.linux-watchdog.org/linux-watchdog
git bisect good 61f4c3e6711477b8a347ca5fe89e5e6613e0a147
# good: [12b7f4ddfcb66dafed432cf4a987f5b40179c0f1] Merge tag 'device_is_big_endian-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core into gpio/for-next
git bisect good 12b7f4ddfcb66dafed432cf4a987f5b40179c0f1
# good: [ede7511e7c22c9542a699ddff9f32de74e0bb972] gpiolib: cdev: include overflow.h
git bisect good ede7511e7c22c9542a699ddff9f32de74e0bb972
# bad: [f34fd6ee1be84c6e64574e9eb58f89d32c7f98a4] gpio: dwapb: Use generic request, free and set_config
git bisect bad f34fd6ee1be84c6e64574e9eb58f89d32c7f98a4
# good: [7dd1871e5049bbd40ee78ac94b1678ba5caf2486] gpio: tps65219: don't use CONFIG_DEBUG_GPIO
git bisect good 7dd1871e5049bbd40ee78ac94b1678ba5caf2486
# bad: [0338f6a6fb659f083eca7dd5967bb668d14707f8] gpiolib: drop tabs from local variable declarations
git bisect bad 0338f6a6fb659f083eca7dd5967bb668d14707f8
# bad: [5d5dfc50e5689d5b09de4a323f84c28a6700d156] gpiolib: remove extra_checks
git bisect bad 5d5dfc50e5689d5b09de4a323f84c28a6700d156
# first bad commit: [5d5dfc50e5689d5b09de4a323f84c28a6700d156] gpiolib: remove extra_checks

