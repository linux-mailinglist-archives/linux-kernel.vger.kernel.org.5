Return-Path: <linux-kernel+bounces-71643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 145AD85A843
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C004A283628
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C8E3C082;
	Mon, 19 Feb 2024 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4KOFC7P"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1222A3A1DE;
	Mon, 19 Feb 2024 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358994; cv=none; b=hEBI1sO6am3uw3/ernRzr+iIwY0Fgtm5tV1VSX/UQmPvhcSNATb+uJ8utmNNRh58m87R2ZqjXjEMuuhJuleItzqVasNu9DDD0yfoSdE0GCsP5xiKolHEYRQTNAJRBhy2c2UuAe0GN4GQOW8TUOkTUmZi2UX/6ALf7MYCYGSg9Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358994; c=relaxed/simple;
	bh=DQcC30B5Y3OhlxpA+cpMhtTaBr5bQ3T2ftyXDYOaL/o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=swchBt0JdelSr/eEY3qgCg6I9vFYq5cE4hmWRJbhOV+O6XMo6Yzt3X0BjpdKBiS/tR4rGm7y/Uw9dvEq1/A3DiZnvHzUO44nv1mhLhI7bb/Ix3uZtLtajaG4+WvlKtUOqDI1KAh+x7VdhXQt/L6eTB3zOVX3pRTfKvynx4OaB9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4KOFC7P; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4126104e28eso12473365e9.0;
        Mon, 19 Feb 2024 08:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708358991; x=1708963791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hgTcCazmfvPYcFZvlwd5OlJY+oP9ObwQ8H/LVKVTwIM=;
        b=E4KOFC7P7yD1RaL9XThpyFAQPQ8T1WGpHxUpLv56VRNcE4N5xrfAQg4A3S/Sn4tQhk
         YQZ5YgF7cF7h6KibYDpIn1HP7ljmsd22sK8KUV0Xtu/L6NujfsorBQtX/F2mBQNEsc81
         wuk75sHrtKB/HusYzUdMBLHfRFhgQRKAlguNYUYfI5w4pxB1utMeevELuZScwyxunXuh
         qvLcHYtvrVZOn1XhF7yebIA6a03iGEs4/mMDx6vhr6Y+2zLtH2ArisF0vYEX/brWMin4
         oA0aI9qPZK5521mEAD+D9EBsrw8uRNdDWXTauhifFWazDR6b3C0D+PWtnqUiBNj9tZJ8
         acDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708358991; x=1708963791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hgTcCazmfvPYcFZvlwd5OlJY+oP9ObwQ8H/LVKVTwIM=;
        b=q1AirK4cM+f/20k8DvPr4n3uaDEyQZPqnocXXDuU3fKOZRFa2OZbmVrkVsjEzSY/50
         LO4r+XqMn8OX7Z1swg1qSq21vZpx4Sueha8/BmOLjUOZxLpRYbVWnOt/+XG+/HQy4w+m
         3BuADu2N0iVApKSMqkW9IEJiZf1HRal04ObL4KyBDvFBIkqBDXLgBUd/pD0qNTmw0Gza
         TI9FtMApwkcZqmXQFAnldFzjc195mT9kAFtn6fONQK51B4SiFl5YxJd3xXg0F4Ly+m/m
         nXC0tvCduyken/2ZNulxmrC89yQN7jBB3jIJ7FJBJS7nk8nDLHDIXaEH5QxLzUUE3da2
         raeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdQqjmVGwEvy4SRs072tYJCuEIN8m7ck8e7aoNQSe69qY9x3ZlkjfP4QeflfSmfTb3qHjJRC14pn0M/5vXqtStO/cA0ldPtHnvhj9h2Ed5a//3YM2f0ou1ib5Yl62+2nNVM0Q/FtvXVSnVhM+otdftFJ3w96fU8gCWdeGVJlMraTt/V+JvQXuJEnOo
X-Gm-Message-State: AOJu0Yzaj16UNcqY4VaA1bAywhSZ4HUWMrJy3tMMWLgSmlwBl/I61y9s
	UzsyNIFVIAQP8VIczQ5ME2Bv3mH7TTbQK2DfCIeu5tE6IVh4PUAD
X-Google-Smtp-Source: AGHT+IFBDfEdMu8J9eQUOFwU4sdASLpvZHfk9n3GsvYGdIRpXTTHFZ2H2BbQENp4fR1rTrdP0scF6A==
X-Received: by 2002:a05:600c:19cd:b0:411:d273:90e2 with SMTP id u13-20020a05600c19cd00b00411d27390e2mr11271472wmq.3.1708358991112;
        Mon, 19 Feb 2024 08:09:51 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:3c2e:cd45:f50f:f083])
        by smtp.gmail.com with ESMTPSA id l14-20020a7bc44e000000b00411d1ce4f9dsm11592670wmi.34.2024.02.19.08.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 08:09:50 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/4] Add new Renesas RZ/V2H SoC
Date: Mon, 19 Feb 2024 16:09:08 +0000
Message-Id: <20240219160912.1206647-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi,

This patch series adds initial support for RZ/V2H{P} (R9A09G057) SoC
identification.

The RZ/V2H{P} SoC is equipped with a Quad 64-bit Arm Cortex-A55 core
(up to 1.8 GHz), dual 32-bit Arm Cortex R8 core (up to 800 MHz) and a
32-bit Arm Cortex M33 core (up to 200 MHz). It supports the below
IP blocks/Features:
- Boot
  * Selectable boot CPU from Cortex-M33 or Cortex-A55
- Accelerated engines
  * AI accelerator (dynamically reconfigurable processor for AI (DRP-AI))
  * Dynamic re-configurable processor (DRP)
  * 3D graphics engine (GE3D MALI-G31) (optional)
  * Image signal processing (ISP MALI-C55) (optional)
  * Image scaling unit (ISU)
  * Video codec unit (VCU)
- On-chip SRAM and external memory interfaces
  * On-chip share SRAM (6-Mbyte with ECC)
  * 2-channel memory controller for LPDDR4-3200 or LPDDR4X-3200 with a
    32-bit bus width
  * xSPI interface
  * SDHI (eMMC/SD - 3ch)
- Timers
  * 32-bit general purpose timers (16 ch)
  * 32-bit CMTW (8 ch)
  * 32-bit GTM (8 ch)
  * RTC
  * WDT (4 ch)
- Communication/storage /network interface
  * Ethernet (2 ch: 10/100/1000 BASE)
  * USB2.0 (1 ch: Host/Function, 1 ch: Host only)
  * USB3.2 Gen2 (2 ch: Host only)
  * PCIe Gen3 (1/2/4 lanes)
  * MIPI CSI2 (4 ch: 1/2/4 lanes)
  * MIPI DSI (1ch: 1/2/4 lanes)
  * CAN/CANFD (6 ch)
  * SCI (10 ch: UART/SPI/I2C)
  * SCIF (1 ch)
  * SPI (3 ch)
  * I2C (9 ch)
  * I3C (1 ch)
- Audio
  * Asynchronous sampling rate converter unit (SCU) (up to 192 kHz)
  * DMAC for Audio (ADMAC) is available to transfer audio formats
    of I2S with SCU.
  * Flexible audio clock generator (ADG) for audio functions.
  * I2S (TDM) input/output interfaces (half-duplex 10 ch.; full-duplex
    5 ch.)
  * SPDIF input/output interfaces (3 ch.)
  * Pulse density modulation (PDM) input interfaces (6 ch.)
- Analogue/Digital converter and sensors
  * 2.5 Msps 12-bit ADC (8 ch)
  * Internal temperature sensors (2 ch)
- Security 
  * Hardware cryptographic engine (optional)

Logs:

~ # uname -ra
Linux rz/v2h 6.8.0-rc5+ #167 SMP PREEMPT Mon Feb 19 10:42:01 GMT 2024 aarch64 GNU/Linux
~ #
~ # for i in machine family soc_id revision; do echo -n "$i: ";cat /sys/devices/
soc0/$i; done
machine: Renesas EVK based on r9a09g057h44
family: RZ/V2H
soc_id: r9a09g057
revision: 0
~ # cat /proc/cpuinfo
processor       : 0
BogoMIPS        : 48.00
Features        : fp asimd evtstrm crc32 atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x2
CPU part        : 0xd05
CPU revision    : 0

processor       : 1
BogoMIPS        : 48.00
Features        : fp asimd evtstrm crc32 atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x2
CPU part        : 0xd05
CPU revision    : 0

processor       : 2
BogoMIPS        : 48.00
Features        : fp asimd evtstrm crc32 atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x2
CPU part        : 0xd05
CPU revision    : 0

processor       : 3
BogoMIPS        : 48.00
Features        : fp asimd evtstrm crc32 atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x2
CPU part        : 0xd05
CPU revision    : 0

~ # cat /proc/meminfo
MemTotal:       16240544 kB
MemFree:        16201748 kB
MemAvailable:   16073696 kB
Buffers:               0 kB
Cached:             2040 kB
SwapCached:            0 kB
Active:                0 kB
Inactive:             68 kB
Active(anon):          0 kB
Inactive(anon):       68 kB
Active(file):          0 kB
Inactive(file):        0 kB
Unevictable:        2040 kB
Mlocked:               0 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:                 0 kB
Writeback:             0 kB
AnonPages:            84 kB
Mapped:             1456 kB
Shmem:                 0 kB
KReclaimable:       2924 kB
Slab:               8720 kB
SReclaimable:       2924 kB
SUnreclaim:         5796 kB
KernelStack:        1056 kB
PageTables:           40 kB
SecPageTables:         0 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:     8120272 kB
Committed_AS:        648 kB
VmallocTotal:   133141626880 kB
VmallocUsed:        1264 kB
VmallocChunk:          0 kB
Percpu:              352 kB
HardwareCorrupted:     0 kB
AnonHugePages:         0 kB
ShmemHugePages:        0 kB
ShmemPmdMapped:        0 kB
FileHugePages:         0 kB
FilePmdMapped:         0 kB
CmaTotal:          32768 kB
CmaFree:           26624 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
Hugetlb:               0 kB
~ # cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
 11:       3426         66        291        243     GICv3  27 Level     arch_timer
 13:          0          0          0          0     GICv3 561 Level     11c01400.serial:rx err
 14:         15          0          0          0     GICv3 564 Level     11c01400.serial:rx full
 15:       1259          0          0          0     GICv3 565 Level     11c01400.serial:tx empty
 16:          0          0          0          0     GICv3 562 Level     11c01400.serial:break
 17:         82          0          0          0     GICv3 566 Level     11c01400.serial:rx ready
 18:          0          0          0          0     GICv3 563 Level     11c01400.serial:tx end
IPI0:         5         20          8         23       Rescheduling interrupts
IPI1:       530        204         91        155       Function call interrupts
IPI2:         0          0          0          0       CPU stop interrupts
IPI3:         0          0          0          0       CPU stop (for crash dump) interrupts
IPI4:         0          0          0          0       Timer broadcast interrupts
IPI5:         0          0          0          0       IRQ work interrupts
Err:          0
~ #

Cheers,
Prabhakar

Lad Prabhakar (4):
  dt-bindings: soc: renesas: Document Renesas RZ/V2H{P} SoC variants
  dt-bindings: arm: renesas: Document Renesas RZ/V2H{P} System
    Controller
  soc: renesas: Add identification support for RZ/V2H SoC
  arm64: defconfig: Enable R9A09G057 SoC

 .../soc/renesas/renesas,r9a09g057-sys.yaml    | 59 +++++++++++++++++++
 .../bindings/soc/renesas/renesas.yaml         |  8 +++
 arch/arm64/configs/defconfig                  |  1 +
 drivers/soc/renesas/Kconfig                   |  5 ++
 drivers/soc/renesas/renesas-soc.c             | 20 ++++++-
 5 files changed, 92 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/renesas/renesas,r9a09g057-sys.yaml

-- 
2.34.1


