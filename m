Return-Path: <linux-kernel+bounces-164123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3828B794F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77461F21D38
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860E01C660D;
	Tue, 30 Apr 2024 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItfwH0JN"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7713C1C6611;
	Tue, 30 Apr 2024 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714486506; cv=none; b=gZF90W9AgrsuA3ov/k8MPSwdKOqkuFWiCkYdGsxZDaKePm5BTsphUUgWuLPVRo/goGsKq9ChPjSXorsUYktZFGGMbSEqr3QLIrieN5pY77ZzFJYHpYUI5M/xQO0hjNeQ+OfAye8gXE3r08nkv/2vxmvU1gxBB2GYK9kuquE+5b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714486506; c=relaxed/simple;
	bh=Sg6ud7KiGS1Cp5pElVI9VFlSWWalF/rJ+U9DkbHk3yk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VenE8ZyvJqMEC0+xtIAn5vg5OAOfoBojRUwgMkBcv/ZOjcmP+WV54fxrDV+OZRhEys8pB/7vWoxt7vIsUri3wTvH6zGxJBMD5ZUxCrPOLAXrmGGwgLb7UV5EhPA1xklxPTh8qpDuODwzFwH0YHBr56aw8EkzoNesefVo05IWrVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItfwH0JN; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2b1b1a38f54so1806764a91.1;
        Tue, 30 Apr 2024 07:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714486505; x=1715091305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jt+Wgc/0cpY0Hhbq8ZGUv5ZmpO1a7WlBPnK8BTyEmKY=;
        b=ItfwH0JNKUibwbMgBr04LPYDElehY0sjNhDPdRtpWORm5aRIcbWwC1U8SGPVNSIWbW
         Id1Q4Jo8biGFvn6ExmXcOCKm36q4fp8EvdOxWYWtXDgcw98K/fdgsFVXmLCwG52cdsOu
         ROMAA7lTalw0ilAEwvqpF42A+OD2Yul7Iz8V02pU5mOBeatnGjlk/p8LhVElTL1BWtk7
         VRRb4GU5kgmiA7DPxSPO+JBY1vEPdrwwKCjtMCdjoMCPfakzTNiMkwv0d4ibl32CShhu
         ghjQhfW29eJwq3lrhnRSrHn0iFkOMZeeB+f0JuOg345PxknJyOelEFBOX3jEO12tZwmp
         TWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714486505; x=1715091305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jt+Wgc/0cpY0Hhbq8ZGUv5ZmpO1a7WlBPnK8BTyEmKY=;
        b=OOXkIWsUFqDgm7/SF7T5/nsPIv4+u3Qq2asfZ7Kmvhjg4o1awzsvGulRbBh1vTiDTV
         FFaFgvchJX5D3KCZzgbg3oPfXLPIRlkqp+6eftRC6feUGHS1QMb9bFVOuOvaIsYohnXl
         jPbeETuWm1TEzylkghbp2wUlyJQegBc4VdCSgxAGQJVK8ETYAuQFHlIA/CR7iyAcWDpi
         buzmDZIiqVy5xjmkV9gA85mbEdJJpEcGL5bQ5H4U8EmM6Q1HdZN3Z4cHRYGpPbgQ+CTX
         7EQJHe26Q/0HpclRI5ZbTb7OdjqK+gkCeYsq8Wbm/0krHPu40DLY02oe3g8xO97HtYyy
         S+Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVELQGTOH2brh4nDx+UQrsU7XvEC5z5A7x8bTQ5pxWfMLRYxRcJyDZLH4AZ78QE+MmgTPnrRtBUu1fUPrTlHc9FQpZmK91Jm0KmcFHb9UC4++riEQnqF4J6z6L1p0wmBwaSR8a3S7lILtDNR5iR
X-Gm-Message-State: AOJu0YyYSY9La1JGAr5jM/zWttEKZdozExh8s3HgWjS0wcInIdOc5TKn
	0MmqKVxRImhdDsSxCtSMQPQpGoNXFxBx3ooxsB0NAprmcIQ78yGg
X-Google-Smtp-Source: AGHT+IGXNwe0ifTdrMrDTPt8hFE4IiyaFYwYtJAYXveAhwUnXl/cH700jJrLQOdOWJ8qhtHPia5u7g==
X-Received: by 2002:a17:90a:9317:b0:2b2:a6e9:400c with SMTP id p23-20020a17090a931700b002b2a6e9400cmr1164428pjo.12.1714486504606;
        Tue, 30 Apr 2024 07:15:04 -0700 (PDT)
Received: from prasmi.domain.name ([103.219.60.80])
        by smtp.gmail.com with ESMTPSA id az24-20020a17090b029800b0029bacd0f271sm22883227pjb.31.2024.04.30.07.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 07:15:03 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 0/2] Add IAX45 support for RZ/Five SoC
Date: Tue, 30 Apr 2024 15:14:36 +0100
Message-Id: <20240430141438.132838-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

The IAX45 block on RZ/Five SoC is almost identical to the IRQC bock found
on the RZ/G2L family of SoCs.

IAX45 performs various interrupt controls including synchronization for the
external interrupts of NMI, IRQ, and GPIOINT and the interrupts of the
built-in peripheral interrupts output by each module. And it notifies the
interrupt to the PLIC.
- Select 32 TINT from 82 GPIOINT.
- Integration of bus error interrupts from system bus.
- Integration of ECC error interrupts from On-chip RAM.
- Indicate interrupt status. (NMI, IRQ, TINT, integrated bus error
  interrupt and integrated ECC error interrupt)
- Setting of interrupt detection method. (NMI, IRQ and TINT)
- All interrupts are masked by INTMASK.
- Mask function for NMI, IRQ and TINT

This patch series adds support for IAX45 in the IRQC driver and enables
this on RZ/Five SoC.

v3->v4
- Renamed rzg2l_irqc_init_helper -> rzg2l_irqc_common_init
- Moved the locks into callers for (un)mask and (en/dis)able functions
- Collected RB tag from Geert for patch#2

v2->v3
- DTS/I patches dropped from the series as they have been merged into
  renesas-soc tree
- Just using a const from compat string instead of having it in a items
- Added RZ/Five specific irqchip

v2: https://patchwork.kernel.org/project/linux-renesas-soc/cover/20240403203503.634465-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
v1: https://patchwork.kernel.org/project/linux-renesas-soc/cover/20240129151618.90922-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (2):
  dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document
    RZ/Five SoC
  irqchip/renesas-rzg2l: Add support for RZ/Five SoC

 .../renesas,rzg2l-irqc.yaml                   |  17 +-
 drivers/irqchip/irq-renesas-rzg2l.c           | 148 +++++++++++++++++-
 2 files changed, 155 insertions(+), 10 deletions(-)

-- 
2.34.1


