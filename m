Return-Path: <linux-kernel+bounces-118423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A08588BA92
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9F042C522C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF38127B68;
	Tue, 26 Mar 2024 06:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iE2bSrRG"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C91984D12
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 06:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711435178; cv=none; b=i5OlttbgMx8O05j5j8Vd/WGDlgaqzLdtKPdxkJD51tNc0lN0V/RRpHUlBp7nR/BLGgcW3Sxq0I87GjybjI6wNYJnDuRl/tJ/P3Aon3XCrnXEvdyDfegcrMu6lt2vzyerl3abeu1Tx6SskC6RCvqPWQStrRagN3o+mFdWWFQPEbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711435178; c=relaxed/simple;
	bh=8hkG47Q40QgzkBdUkNgiugWCufZOCQ5wxIkjT5JKDc0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=YoD5jUWIHuLqxeUCf0cIgNigdARaZN9XP+twMThTDueAlJkYJAwyM44E60hfOiX5b9Yha6RmHm3y2g+K8YBfyM5lA0zBf9FYdYHCseAvmw+i5LOqbEswFKd4pkYSTgt4fyoI2HWYCo6o6VJ9LQrNtg+k2cn2qUvDEvyG0WrKokI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iE2bSrRG; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4d870fb9f5cso1489730e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 23:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711435175; x=1712039975; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=drVZ42Pjz6m24bstfIZiE8BogPtQcG+Q1nzebdlWw4A=;
        b=iE2bSrRGf4Fb9eiT2kybpflVK3sJrxBTN28BM6OfevZwFsVEz68PfEJrpDNsVuUVlE
         yEE2Ofaw8Df31qzCJ1WjDr1TrI3jhZ2Ye8pjDorbBYd5yXZZeQe2UZNPGLKeMp1V43CW
         EshtemO/XSF1ooVAeNh2p/+MiMDcQLv//b03c4ib2Al1FeNrxZ/w2/+TSOwjJqWQX7Xc
         zDct7xY8FSDVUSkeVCxIbDonZQfNgeSleMhVH6BLQZr2+D4EBbZmD8xzKtKQv52Ww35N
         j6felmEyDa9rL1YcTkOTH0Ri3jfKXpFLSVpg2P9Axjm0YqGaU8T0z5Gje+WyBqbZ/N6N
         fs3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711435175; x=1712039975;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=drVZ42Pjz6m24bstfIZiE8BogPtQcG+Q1nzebdlWw4A=;
        b=vLFkP2xOxGJFDBqf0Hk7dFISgPX9fkRi084on/dAaOzY5n9/tjxuxeEwS0emcIZVOU
         NkB6uIm9bGL1pHo8dpGXPPd5/v8LHMCZ5J8etl26TZu9fwaV8qooYWFq3C64gjifyOEW
         n1VUztiDWNLk7t78O/QC57FxbUPWSf/IWkJdRqcr4ef2CqGEHV/rSMQSqfzOBGn6kyxW
         ZsjegvPgO9EBw3+67MJyd0pI8KHGilsmZYyCOm0b2ou5NUffBL7u6WTaX3d8F092FWx9
         Gv3QRXVV2mD3ELpXsa2Lck+/oyVm1x4V1eG691dSwrr51YVhLHKgZJZGC9USzsJU+tOE
         FS4g==
X-Gm-Message-State: AOJu0Yx/Z313NlV6cRyC8KO918+mh4q3TrDJ6f4H+MCLf/mfCOz3r3iY
	5TIpK7KeDbqnAcBKVSNrGglqwu2sU5z9F1UVR4zNaNNEkvhcvLGWvodpFM3FLXU6dkZKECDRven
	YNR/i/HFsEdv5FtXDfVhDH26rEQMYvCrm7zGc8HANi6ATcwgCaYc=
X-Google-Smtp-Source: AGHT+IHEXqKXr2zeKfb/dcXtTpJUneKb2/8gxWMltBIlJ3SC8orv+0q/CSPQOhwnG8MsvVlHWmkE85wSNg0nDxpryiY=
X-Received: by 2002:a1f:f843:0:b0:4d8:7a5e:392f with SMTP id
 w64-20020a1ff843000000b004d87a5e392fmr6046584vkh.12.1711435174828; Mon, 25
 Mar 2024 23:39:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 26 Mar 2024 12:09:23 +0530
Message-ID: <CA+G9fYu49=6_L6r8hdagZHUSGk+JfjioFaqh+kRaxhce84Q5Kw@mail.gmail.com>
Subject: next: arc: defconfig - gcc-9 - mmu-arcv2.h:82:2: error: implicit
 declaration of function 'write_aux_reg' [-Werror=implicit-function-declaration]
To: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, linux-mm <linux-mm@kvack.org>, 
	linux-snps-arc@lists.infradead.org
Cc: Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, vgupta@kernel.org
Content-Type: text/plain; charset="UTF-8"

The following arc defconfig build warnings / errors noticed on today's
Linux next-20240326 tag.

Regressions:
    * arc - defconfig - gcc-9 build failed.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
---------
arch/arc/kernel/ptrace.c:342:16: warning: no previous prototype for
'syscall_trace_enter' [-Wmissing-prototypes]
  342 | asmlinkage int syscall_trace_enter(struct pt_regs *regs)
      |                ^~~~~~~~~~~~~~~~~~~
arch/arc/kernel/kprobes.c:193:15: warning: no previous prototype for
'arc_kprobe_handler' [-Wmissing-prototypes]
  193 | int __kprobes arc_kprobe_handler(unsigned long addr, struct
pt_regs *regs)
      |               ^~~~~~~~~~~~~~~~~~
In file included from arch/arc/include/asm/mmu.h:21,
                 from arch/arc/include/asm/pgtable.h:14,
                 from include/linux/pgtable.h:6,
                 from include/asm-generic/io.h:1047,
                 from arch/arc/include/asm/io.h:232,
                 from include/linux/io.h:13,
                 from kernel/dma/coherent.c:6:
arch/arc/include/asm/mmu-arcv2.h: In function 'mmu_setup_asid':
arch/arc/include/asm/mmu-arcv2.h:82:2: error: implicit declaration of
function 'write_aux_reg' [-Werror=implicit-function-declaration]
   82 |  write_aux_reg(ARC_REG_PID, asid | MMU_ENABLE);
      |  ^~~~~~~~~~~~~
cc1: some warnings being treated as errors

Steps to reproduce:
-------
# tuxmake --runtime podman --target-arch arc --toolchain gcc-9
--kconfig defconfig


Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240325/testrun/23149630/suite/build/test/gcc-9-defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240325/testrun/23149630/suite/build/test/gcc-9-defconfig/history/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2eA2VSZdDsL0DMBBhjoauN9IVoK/

--
Linaro LKFT
https://lkft.linaro.org

