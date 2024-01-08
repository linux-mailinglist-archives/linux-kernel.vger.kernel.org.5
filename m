Return-Path: <linux-kernel+bounces-19323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D071A826B68
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3451F22388
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D690134A9;
	Mon,  8 Jan 2024 10:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2sMkJDM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B560314009
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d8e7a50c1so21622235e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 02:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704708877; x=1705313677; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=uJ++RTumRAxAYHai2oKWZ4SCrhH22n+gB2PrOjmAI3g=;
        b=Z2sMkJDMtOvE1iHU8Qqg6mrTDM8U2/9cdSiELYhS75DlRl2CUo/tOiN5ZxUsLpg7m2
         WvX3KVkgUvcNGUgZvR7gv2qx5ERY/jBv9U2bge0nIpfACZSHSGAllhYE7ZoTD/2XtHs/
         Mj6v6eraVaYyHzMzvd1hKTexqP/QYKTwrQJFY+XFusoTDxs2e3MA+nWTnfYMK1rwBPnz
         u4TYOvFUklQOMMn197jNupgeFWS6XmetX2DqNNdJvvPXBRdgm1bFgSMQSJNt5KI1eWLo
         6mbmTOrRpM9Y1liBTCC1gHNWZRy2RRcsgB+s8cZ9O7D4BbnS+xRaPZo8MdtAed/kcqAo
         4fuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704708877; x=1705313677;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJ++RTumRAxAYHai2oKWZ4SCrhH22n+gB2PrOjmAI3g=;
        b=k8wdwBf8OXjnTvPZgONYhv7GBL3cGneEbF6B2F2A6oAjvxk+7OgVcbwggPKixRIenr
         6XDLrfNazeqWNH2ujNaT6xoCrxHZDV73IZZ1wsJ+v4Ul5Y9ySc+DrAgU3TkJ1dhjrQRW
         nyQI2LCOdoMWobef1MNeAulS0N0u8N+z+wOUWvD5pRGH/tRai0aMePrKrqgqerxa2Osp
         aGJRn/yv7+bxHXV0c3362aQYVojjuKCskUzAENMKGnfx0S7SMejHG8TVYQZd1Uqeu9R4
         SfLXE4YJ5Viz4HwxFWzGeRnFIRNbRe6s/yvYfq7iVylPoEmrUm9by2LbYz4fwCQqzKhn
         vMvQ==
X-Gm-Message-State: AOJu0Yy/MiPCMmmPNo2LxNXjTG/J/pacM/YxTF0/4XBQkPM2fumusBU+
	MWMS5BvIrZbTwJjUWo+Nyw4=
X-Google-Smtp-Source: AGHT+IGwA9H1/pRTCWN4NNK1iyd5MjMs6Z6rhngpgMsJa4fDpfov/uwdyPlUf+sA8ao64NCElNq6aQ==
X-Received: by 2002:a7b:cb93:0:b0:40e:3a1f:8b39 with SMTP id m19-20020a7bcb93000000b0040e3a1f8b39mr1534650wmi.200.1704708876700;
        Mon, 08 Jan 2024 02:14:36 -0800 (PST)
Received: from gmail.com (1F2EF3FE.nat.pool.telekom.hu. [31.46.243.254])
        by smtp.gmail.com with ESMTPSA id j10-20020a05600c190a00b0040d8eca092esm10450497wmq.47.2024.01.08.02.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 02:14:36 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 8 Jan 2024 11:14:34 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [GIT PULL] IRQ subsystem changes for v6.8
Message-ID: <ZZvLCmUqAriMV/Va@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest irq/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2024-01-08

   # HEAD: 69ffab9b9e698248cbb4042e47f82afb00dc1bb4 irqchip/irq-xtensa-pic: Clean up

IRQ subsystem changes for v6.8:

  Drivers:

   - Add support for the IA55 interrupt controller on RZ/G3S SoC's

   - Update/fix the Qualcom MPM Interrupt Controller driver's
     register enumeration within the somewhat exotic "RPM Message RAM"
     MMIO-mapped shared memory region that is used for other purposes
     as well.

   - Clean up the Xtensa built-in Programmable Interrupt Controller
     driver (xtensa-pic) a bit.

 Thanks,

	Ingo

------------------>
Claudiu Beznea (7):
      irqchip/renesas-rzg2l: Use tabs instead of spaces
      irqchip/renesas-rzg2l: Align struct member names to tabs
      irqchip/renesas-rzg2l: Document structure members
      irqchip/renesas-rzg2l: Implement restriction when writing ISCR register
      irqchip/renesas-rzg2l: Add macro to retrieve TITSR register offset based on register's index
      irqchip/renesas-rzg2l: Add support for suspend to RAM
      dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/G3S

Konrad Dybcio (2):
      dt-bindings: interrupt-controller: mpm: Pass MSG RAM slice through phandle
      irqchip/qcom-mpm: Support passing a slice of SRAM as reg space

Max Filippov (1):
      irqchip/irq-xtensa-pic: Clean up


 .../bindings/interrupt-controller/qcom,mpm.yaml    |  52 ++++++----
 .../interrupt-controller/renesas,rzg2l-irqc.yaml   |   5 +-
 drivers/irqchip/irq-qcom-mpm.c                     |  26 ++++-
 drivers/irqchip/irq-renesas-rzg2l.c                | 110 ++++++++++++++++-----
 drivers/irqchip/irq-xtensa-pic.c                   |  31 +++---
 5 files changed, 157 insertions(+), 67 deletions(-)


