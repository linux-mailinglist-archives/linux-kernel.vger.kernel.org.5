Return-Path: <linux-kernel+bounces-42973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC59584097D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E388B24AC8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D351153519;
	Mon, 29 Jan 2024 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpKeq+3H"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D9913DBA1;
	Mon, 29 Jan 2024 15:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706541390; cv=none; b=HrB8DWgWYejiPySsznOcivuGCEQfyoEOWzphzCwaeLqE6+WMkhGxVuiYncJk8YTOXOh/yIPM/Oo+KF5b/gbnjKRr3bAwoQjeip70vulalxbwOh8sEHDVU6IewpQ76ICpA6IChAY4aEj/xPSfffjgyEIkdvZz6PBaXLzzwgAbH2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706541390; c=relaxed/simple;
	bh=QlmHlZ4AiJnJUf+ZeL9SC9/lDIP5J9YhN6/lp2GI2r0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S8GTUBm5T8Yn3N6bEngtz5HS/Bmf8op50sIGk2sAV39AIv+CBOHniRKDPMffSZ0BYP96LfpjM9mUiuWb8IlVg1wVxmNyGLR6bDpXjNnB1YbHoozldz0fxeD1RZuvdjs58kVqGKzRqFni1OrVAjTmlxxg6ayhEAGh/dapk90IPiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpKeq+3H; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40ed356a6ecso25318915e9.2;
        Mon, 29 Jan 2024 07:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706541387; x=1707146187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BlMepFvcNokAhr6dcB9591xxdL8lwl4Op8N8VH8FV0Y=;
        b=lpKeq+3H9hQGW0DSFN2oVSVnK23RhiKCTttJsrqL0rhQNj+R33QMYiGDSDDeNvzPUR
         6GCY+RHZoSRjmAqgi0Yuefjqr4v0cAjxgiouC1RvQwyZX0NJxzsbMR9yxnEXx4WDpuZK
         yrG/m8I90OEOHdQPbNrVEioa81vCc8Joxbt2ttlIziqEFOgU/gyxHGq7P6lFWjO8cqvB
         uSfuHR1WgLW5PAZ66NwZDvRCwb7jHwrOJ44Nc6leksDj+W9B/H/isuvtbzQWkPZ+T3Cu
         ybMDhjMeRxPuPgIpmXfVTJcVi4i0M7DM6BQ6uxXeF59HPBNC6usWOC1HcGSZb2/02mNx
         ziOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706541387; x=1707146187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BlMepFvcNokAhr6dcB9591xxdL8lwl4Op8N8VH8FV0Y=;
        b=eOGaUd5j944BqyKDpD+W+bfQStNtgoSGxEBUi1DK8afCFXvBIxYdmUZa/4/ECXYwUG
         UNDN4SAvYU5eek5BsCnDMbAPPHHmcdPnPRCesaBejMlSPjXNDPpxRY2WGQUZCfk+cTes
         AdVnZ/BuxvyWaEdmHYkFVfs+Rp4SqFlvEVi5jVB0eRFIRHiRJsV1sjxguDGdpfqovzyC
         7mJxwRttD6k9mySBQekubjbVqDtkIAaFdpytWao0oDIpx/MtpxL6ayDz/85Y7fbIgnl5
         BOtTA+bguKNTM4uae/Mj1s/apqloyi9Fnn0hqNhHtTk3tQNg7iEZxwPayabCw0Eh0Mta
         vQwQ==
X-Gm-Message-State: AOJu0YzWQPj+jxGXLF2sqzYep453tCVB3ZAyjd4afX98XBLn5zvNgjkv
	nxDp9QnHfcvoAcJOIUcEAFeXaP441PUd136RMVL0gWj971lNYLSZ
X-Google-Smtp-Source: AGHT+IG8u6AlgJhTdcVceOQs8uggWZYdkfIwd2mlmvgTfSMVf0Gxx8DqXCyGTBKtRenyr+Cw+lv1hQ==
X-Received: by 2002:a05:600c:4507:b0:40e:f632:723d with SMTP id t7-20020a05600c450700b0040ef632723dmr3177999wmo.16.1706541386860;
        Mon, 29 Jan 2024 07:16:26 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:5616:a18c:ea50:2995])
        by smtp.gmail.com with ESMTPSA id h4-20020adfa4c4000000b00337d4eed87asm8397774wrb.115.2024.01.29.07.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 07:16:26 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/5] Add IAX45 support for RZ/Five SoC
Date: Mon, 29 Jan 2024 15:16:13 +0000
Message-Id: <20240129151618.90922-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

 .../renesas,rzg2l-irqc.yaml                   |  27 ++++
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi    |   1 +
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi   |   4 -
 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi   |  76 ++++++++++
 .../boot/dts/renesas/rzfive-smarc-som.dtsi    |  16 ---
 drivers/irqchip/irq-renesas-rzg2l.c           | 132 +++++++++++++++++-
 6 files changed, 232 insertions(+), 24 deletions(-)

-- 
2.34.1


