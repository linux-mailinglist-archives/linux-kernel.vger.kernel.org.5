Return-Path: <linux-kernel+bounces-130551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E978D8979DA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A27B52839FC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72FC15624B;
	Wed,  3 Apr 2024 20:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ky6gCgaG"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBCE155A59;
	Wed,  3 Apr 2024 20:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176597; cv=none; b=nivbBkz1Ah6M/S4aFfMdf61J7WW82xCX+3OnT56gVP34d9KQ/Z4gnfuXUaQTHjwoj0CuNrTmaAroOM/z+cfEy7FkuJcMvXoMf9vKPC5rfdrRKw74MB7pJkXk6cd1QxG2ghVFUzyd3x/23uM6ER5haX+OGRL2MDv83cvoHL5fScM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176597; c=relaxed/simple;
	bh=XnZTwgLYOWz4MqCqFim9E7vD1JkNu9uS897oIjyxUHo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R+sQv8nSL9u451STTMc+A7ciRRkMpaIxs4RPB4smRJ+aPh6p+VJ6yg758CDew6VRhJjseAk6+6YDFmcSHlAdPwRUM79HUh+J3McMo+8Y6mttFVK6yKgSg0K9fcKfQ0zoPE3TINNaWfbD2ShMt5kBWSobANUK7LJKJNRmLc/xJeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ky6gCgaG; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3437efea11eso139276f8f.1;
        Wed, 03 Apr 2024 13:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712176593; x=1712781393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xLEjGKF78CUq2PdbZJuwrHAC1zTdpWI7ya8sqwxy9m8=;
        b=ky6gCgaG+46y1vNfY/ud+l7XK1OZ3nHK0eKlTgIcj4FP2pNeL+1k/C0t2iDRtVEAVU
         06T2vs9uMNEjZBtguliJA+lHLbqUKI43IvFi5saOa57Lx3EsaWh6oStmmAcqu3J2hULY
         W++3dnZqLnlO1W2RC/WAxdtzlNdQzhN2K/JFgrWGtQ5SxWFRUfz9kmlKHJs5f9eDVCVO
         vh3891wTKOoBSl/lGb8k4HjbJ9ISabMSxTa8BLVTXBlRBqcssHyneSiHuyVkfxWDMLGu
         aCqBu+vSb5jTSOiSsBPlcdSElOV20p46e7+CzziIzR00Vp2YD6138AKLMGJmxmPKR9Aw
         11cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712176593; x=1712781393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xLEjGKF78CUq2PdbZJuwrHAC1zTdpWI7ya8sqwxy9m8=;
        b=b3Kd90WMDNscO8vAbVN6LZJBWphR6TdpCqMGnXYykWW15a8H1Bl4pe3FfQX2aV3Rp0
         Fa6WEEQY59mf60+jtBVBoqHQnTTOfx9UoFWMT1W0vJm2t9dvH7v1zKh1PmbdNw6HN3cu
         DtSUmsDHvo9HfDCEuMp7dmRjEVWUEHBjvZ8UJYhQZDgOPrMPrqH1qQfrrOZraRoufvaE
         CWNA9ZePv/Qha4kRbum2fyYmZS1sTB1Sb/q4G1oIxdmMhe289jhaWQ0Ly1vZfysspYFK
         /lbzKVW6NI1U2VIcakYUG2deICog/NujIHjy6cwCenpEAw+b1z19qk4T06FSrqkS5lfs
         R1Ng==
X-Forwarded-Encrypted: i=1; AJvYcCX/tdz6iQzqgTl5ktsuXfq+A54/7ZIw/08PxKDoCF9t49Gcse1Hezp32VhI7PGdqrn13QxjiSQrKYk0tOwW/dkA5ayq16tKqmLOhrCA/w3ckl76VHRqODWc/nnS4U6EmflhA5Kn+/ydMr4HIZS6
X-Gm-Message-State: AOJu0Yyv3dAPqHVEtTAkqz2KkW4mE/zAetBBHMOeXB9LHZmGquhDdNaQ
	vOxHeEE5ohM8p+pmCzovgQiyipQ+jdmIXI4wqaRqz+cpMOd4LZhH
X-Google-Smtp-Source: AGHT+IGFrBKPW8fc9OizmttpoV1U88eOngqII6WaSNdlGNm5E5Z1fGV98RHkN3M5pqZK8yCujgoIsA==
X-Received: by 2002:adf:a1da:0:b0:343:9d3a:cc2e with SMTP id v26-20020adfa1da000000b003439d3acc2emr433983wrv.0.1712176593283;
        Wed, 03 Apr 2024 13:36:33 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:5eb:3d93:f2b6:25e8])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c468400b00415f496b9b7sm244910wmo.39.2024.04.03.13.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 13:36:32 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/5] Add IAX45 support for RZ/Five SoC
Date: Wed,  3 Apr 2024 21:34:58 +0100
Message-Id: <20240403203503.634465-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
- Indicate interrupt status. (NMI, IRQ, TINT, integrated bus error interrupt
  and integrated ECC error interrupt)
- Setting of interrupt detection method. (NMI, IRQ and TINT)
- All interrupts are masked by INTMASK.
- Mask function for NMI, IRQ and TINT

This patch series adds support for IAX45 in the IRQC driver and enables this
on RZ/Five SoC.

v1: https://patchwork.kernel.org/project/linux-renesas-soc/cover/20240129151618.90922-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (5):
  dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document
    RZ/Five SoC
  irqchip/renesas-rzg2l: Add support for RZ/Five SoC
  riscv: dts: renesas: r9a07g043f: Add IRQC node to RZ/Five SoC DTSI
  arm64: dts: renesas: r9a07g043: Move interrupt-parent property to
    common DTSI
  riscv: dts: renesas: rzfive-smarc-som: Drop deleting interrupt
    properties from ETH0/1 nodes

 .../renesas,rzg2l-irqc.yaml                   |  17 ++-
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi    |   1 +
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi   |   4 -
 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi   |  75 ++++++++++
 .../boot/dts/renesas/rzfive-smarc-som.dtsi    |  16 --
 drivers/irqchip/irq-renesas-rzg2l.c           | 137 +++++++++++++++++-
 6 files changed, 218 insertions(+), 32 deletions(-)

-- 
2.34.1


