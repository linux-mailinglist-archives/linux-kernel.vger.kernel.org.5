Return-Path: <linux-kernel+bounces-71053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C241A85A00D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DD3D28132E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0BF28DA0;
	Mon, 19 Feb 2024 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vEVuFgrs"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE4C288AE
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 09:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708335779; cv=none; b=hV4BfmcLgKbKS5pmZwakgIallz52JfAKJ9iSPg4FCESCadoLjMO+Gpyde2dhrb9XrWmFnJl38Q4T+Kedm2TPfAvh3YuHiwZ3xJbS+iaWjRk5pS9q0lzv+STcSoMc/NGlz34BIjq0rWtjthkJOo4ZsvIKkYBBiqkaRfAi/HepIwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708335779; c=relaxed/simple;
	bh=GslTOtA5roMk3ttBbdEIL3hQsmMPYBh8/SEYK4yqAeo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BCZKepr3bvOP8OgaPqiDTHPidXPpUxlxMcXGk/7EOvxmCzUVCOmQ7HKq3VIPKteSnvGmEGNBHFFGelOocrJyWJjHsiYjorpmGVhiOCTSeEW2848+G/BWMm0pFM83vsHnKzsiVaMhPWC5LXydT+0bLwd6Ug5CIylPuKcVsIRGZKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vEVuFgrs; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4b978e5e240so1256843e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 01:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708335777; x=1708940577; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HhJNzLN6fXYVLA2iLFB/FZAXUja7DMTX8Jx1BhdjDUc=;
        b=vEVuFgrssR0iZZEWkd3z6XneKNyQyNe+KXU1gKLkIQ9PCkpL31K6AMVls8R6dxzI+u
         sWXtyF8k/Jb/IiPeNnusStkF/8EQmsIlXrAd9K2KfYVqXH5uTVOyK4ZRdoG2nOhnja0q
         APKvoGxpUTt61ptfvhsb7H6RYrqlPEVKtCjVfWz+aNKxfGmwCXCkAssfMfzOrvcxyVOO
         CVtvxA1mfA5HMAvZIj2uq2V9WsqHUqddPDEybcpccOIYSetdSyBIte2TnFEuyCNvjUv3
         Udzqz2He301xK0VB9W2KE5iz3zSozH+nZe1e7n08pzsWWkKAKcCBgUX2/QlTAxWxQfbK
         +6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708335777; x=1708940577;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HhJNzLN6fXYVLA2iLFB/FZAXUja7DMTX8Jx1BhdjDUc=;
        b=rT819hZiok807+9dq5Jm4KtHh88olqiX+tFtQWeurk48UkkbRkMe3CRnHocQTjEFpa
         NtFvMZbv/tMFwfX961OzxtUO2Z9k1b85r7rrmVB+SBTfkU4beZMeKWpeZ4cicdsBr5pb
         uAHp0PLZetdEOxrsorxJQ3lSMcbgbaJiVOzka2RKyG7x3p1cr0qzPndX01bvzn1qavlh
         Fm1g3brrXanCVWu05QQvHOh2OW8U6FXO3FQQSCG9FsInpwvB263DTzHDhAFWClmQ5H0r
         Z0g15O7TadENI28vt1qha7nBT9PSM9xjXyivr3i4/dR84ZA6UxuuLkRy/DXxRtbfqycS
         SNJg==
X-Gm-Message-State: AOJu0YyAy7vQaTFpbkgd4eN9JOydAjOvUmUCyAt8M2lalgjU9e+pK8I3
	a17HY1BTFZPZGWeeTtIuf9UgboiICq3GLgw7+/JNfVAu+0DRg/+0dsYWkTz2arhKkRhTRlMr3yd
	jk+RCahQouT2ljf4xFkvi/c/+5rvN3ciaSgGq2RKfYFQTfqHf
X-Google-Smtp-Source: AGHT+IGWjBozLtCufhEPX2o1mkEOi3JHUxj+S8hpsBLDpuaqRR0hPDEjPlbwIyMmjBof2P9vQDoMgaxnXvwrUjWN0yo=
X-Received: by 2002:a1f:4ac2:0:b0:4c0:2ada:2f19 with SMTP id
 x185-20020a1f4ac2000000b004c02ada2f19mr7163642vka.15.1708335776824; Mon, 19
 Feb 2024 01:42:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 19 Feb 2024 15:12:45 +0530
Message-ID: <CA+G9fYugYiLd7MDn3wCxK+x5Td9WO-VUX2OvOtTN7D1d4GHCfg@mail.gmail.com>
Subject: next-20240219: arm64: boot failed - gic_of_init
To: open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The qemu-arm64 boot failed with linux next-20240219 tag kernel.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Boot log:
---------
<6>[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
<1>[    0.000000] Unable to handle kernel paging request at virtual
address ffff80008001ffe8
<1>[    0.000000] Mem abort info:
<1>[    0.000000]   ESR = 0x0000000096000004
<1>[    0.000000]   EC = 0x25: DABT (current EL), IL = 32 bits
<1>[    0.000000]   SET = 0, FnV = 0
<1>[    0.000000]   EA = 0, S1PTW = 0
<1>[    0.000000]   FSC = 0x04: level 0 translation fault
<1>[    0.000000] Data abort info:
<1>[    0.000000]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
<1>[    0.000000]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
<1>[    0.000000]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
<1>[    0.000000] swapper pgtable: 4k pages, 52-bit VAs, pgdp=0000000042497000
<1>[    0.000000] [ffff80008001ffe8] pgd=10000000439a5003,
p4d=10000001000e3003, pud=10000001000e4003, pmd=10000001000e5003,
pte=006800000800f413
<0>[    0.000000] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
<4>[    0.000000] Modules linked in:
<4>[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
6.8.0-rc5-next-20240219 #1
<4>[    0.000000] Hardware name: linux,dummy-virt (DT)
<4>[    0.000000] pstate: 804000c9 (Nzcv daIF +PAN -UAO -TCO -DIT
-SSBS BTYPE=--)
<4>[    0.000000] pc : gic_of_init+0x84/0x3a8
<4>[    0.000000] lr : gic_of_init+0x290/0x3a8
..
<4>[    0.000000] Call trace:
<4>[    0.000000]  gic_of_init+0x84/0x3a8
<4>[    0.000000]  of_irq_init+0x1d4/0x3d0
<4>[    0.000000]  irqchip_init+0x20/0x50
<4>[    0.000000]  init_IRQ+0xa8/0xc8
<4>[    0.000000]  start_kernel+0x270/0x690
<4>[    0.000000]  __primary_switched+0x80/0x90
<0>[    0.000000] Code: f94017e0 f90007e0 d29ffd00 8b0002c0 (b9400000)
<4>[    0.000000] ---[ end trace 0000000000000000 ]---
<0>[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
<0>[    0.000000] ---[ end Kernel panic - not syncing: Attempted to
kill the idle task! ]---

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240219/testrun/22730192/suite/boot/test/gcc-13-lkftconfig-armv8_features/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240219/testrun/22730192/suite/boot/tests/

--
Linaro LKFT
https://lkft.linaro.org

