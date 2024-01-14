Return-Path: <linux-kernel+bounces-25548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1240982D232
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 23:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39CD0281463
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 22:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239A52C680;
	Sun, 14 Jan 2024 22:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZsXSJ60S"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEEC1F17B
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3376ead25e1so6240570f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 14:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705271824; x=1705876624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6s2rXWc/tMH4uago23e498UJr39tRJPeqGDGZSoMKEY=;
        b=ZsXSJ60ScqbTnUW7xSp7xhB+KU4YxDESsQ90vQNlOKNvuUy3BmymTqVnl/vJAibJII
         QmkKR/b53Fl+cYxwZpAsnPROqFUnw6KAKJR3bSKiIBX1k+JNyORRq2FqNe/9W8y1MX//
         wjc4sxn+HcMEiuApYx32TK0TlyD9NN+9cdiA1GnO3AL/iqY5e89wJno8o28CvEjElutJ
         qMPVGgpGjBXDLx85uDvZUpco1N0xqFAqyuikSZPFGMK1WkI3YhJyVm4nMor7JmEIkRAm
         xAZxC4yFtFsTJnEcTm6kSaUTD/7Nuwl+pEvUdadQxM5uh4MvoUMah/DP/LNAm+7vVxeR
         KQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705271824; x=1705876624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6s2rXWc/tMH4uago23e498UJr39tRJPeqGDGZSoMKEY=;
        b=xIzLDHC7cU+LuY4gKHBa5VHJKE9HzhhJmRjk3kuwblqd9I034vDRAEo1RX+Z9/i6GY
         bW3Q0KSOKOKDP7ABBM2o4/DJYDXfgqF58mPYIoxxSw1eMHMHUseYX/CG3G2NxKAwePwR
         oEipG4/QFQ/Qt8tzXYzhdCLbAA8QFdtQRUFjqDaf+vL3uKy9WqO/HzmuoTS8c5nVMdpV
         tWE8Xh/qXUVEX36aZnXcQ6SXxHEEzmF9kahf18Aajkg+V5fUIb9kKzVFzZQKNy+NYiqt
         nCE/exwXsA+NBuHeA9HUUHL7SGVOERKbsnUSoxZQDoDpvOjiLRQ18v9k7Aqrp07GWc9z
         TBKg==
X-Gm-Message-State: AOJu0Yze6Z2iKjBuVgKxSgGvGNraAiyrIlSdQGX6UPiokfstFknOQ9o+
	Op0PGxi72gT9BYdsR3LqaxRyhg0xDJf2yA==
X-Google-Smtp-Source: AGHT+IE/oNt1I05yQ0MgN0/ZAU8lJPlEIlxDBObZH0WRwddH9azig9/gV4iLyh69uziPn6VmpPiBOg==
X-Received: by 2002:a05:6000:11cc:b0:337:6e32:1812 with SMTP id i12-20020a05600011cc00b003376e321812mr2196492wrx.35.1705271824318;
        Sun, 14 Jan 2024 14:37:04 -0800 (PST)
Received: from vermeer.ba.rivosinc.com (lfbn-mon-1-1176-165.w90-113.abo.wanadoo.fr. [90.113.119.165])
        by smtp.gmail.com with ESMTPSA id v10-20020a5d610a000000b0033719111458sm10158693wrt.36.2024.01.14.14.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 14:37:03 -0800 (PST)
From: Samuel Ortiz <sameo@rivosinc.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 0/4] tsm: Runtime measurement registers ABI
Date: Sun, 14 Jan 2024 23:35:26 +0100
Message-ID: <20240114223532.290550-1-sameo@rivosinc.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some confidential computing architectures (Intel TDX, ARM CCA, RISC-V
CoVE) provide their guests with a set of measurements registers that can
be extended at runtime, i.e. after the initial, host-initiated
measurements of the TVM are finalized. Those runtime measurement
registers (RTMR) are isolated from the host accessible ones but TSMs
include them in their signed attestation reports.

All architectures supporting RTMRs expose a similar interface to their
TVMs: An extension command/call that takes a measurement value and an
RTMR index to extend it with, and a readback command for reading an RTMR
value back (taking an RTMR index as an argument as well). This patch series
builds an architecture agnostic, configfs-based ABI for userspace to extend
and read RTMR values back. It extends the current TSM ops structure and
each confidential computing architecture can implement this extension to
provide RTMR support.

---
Samuel Ortiz (4):
  tsm: Runtime measurement register support
  tsm: Add RTMRs to the configfs-tsm hierarchy
  tsm: Allow for mapping RTMRs to TCG TPM PCRs
  tsm: Allow for extending and reading configured RTMRs

 drivers/virt/coco/Kconfig |   1 +
 drivers/virt/coco/tsm.c   | 362 ++++++++++++++++++++++++++++++++++++++
 include/linux/tsm.h       |  28 ++-
 3 files changed, 390 insertions(+), 1 deletion(-)

-- 
2.42.0


