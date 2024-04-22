Return-Path: <linux-kernel+bounces-154014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E61DB8AD61F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7555AB2121D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556011BDDC;
	Mon, 22 Apr 2024 20:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2Ltw14P"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B6E1BC2F;
	Mon, 22 Apr 2024 20:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713819074; cv=none; b=YI5qkxW9JuSlW1UktE7uDnO2RH7mnEeBeNlhm8kWJsxqaR4uaE/rZYVm8uv5xDGOlOVPx2Oa9d2n+AXrm5/4K+tOl8IgJVrzqSrlVwTsBtHlosEWo+8tIINYt6CueiqhgCO7aM6k+sAI9CTCjQ7KeyLDLXoiCAthM9wmjDQS2ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713819074; c=relaxed/simple;
	bh=oHqU6FsT+OcEGFJpCBQeLNq+s3Q6ZTeD9mj3g6Al0Tk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FaVkt0cUU+3ifOwWRlvkmhWf6oenrc3qindNsE6tz6wfie/blIsVgj0Zw56eV4gt6ha7Xw45oYxnlc9Fyh3dXtcTOXwj+jlbuWenAXBWBfeKe2jcjJ7XJMzjU77+7lpizvakTI6YOFVcueyXq1L+ihVHWn35job6ZQsdunx0PL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2Ltw14P; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-349545c3eb8so3604382f8f.2;
        Mon, 22 Apr 2024 13:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713819071; x=1714423871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3zu/hKewDxFZUd7julkmO/mSVLYzINum0GUwCUV8BmA=;
        b=B2Ltw14P34aQ1LqoDhSPf5FRZWJaIT3iPLKm+KMith1HerXla/PCuSfeAIGQkS+zM5
         UJ0KJNLdfARU7hbwgN5XVZikp0HTPVK2jFyZC2RVMtzlHm+aHPXBlNvKGvPYTRM6wAQu
         h8Ist97TtBMQcJN/+/82GCNuTlZgC6EAOvFG+7Tt/Rd7LBsDpwwnzBIqgfXbHGle8eVF
         gMjQ5xxWGtYliHorjLZvQQQZtyw+hSPi2LwMaJL6WQZ1yyZth/qh074skNvPFFyrZonL
         vaPpKYempeNDeu+1DX1yz8H0tARJKQtPmhufaDKkPs6czaA/kjucPXtOHvdDalHFkAi3
         llQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713819071; x=1714423871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3zu/hKewDxFZUd7julkmO/mSVLYzINum0GUwCUV8BmA=;
        b=ICSb9WRME1Ejuvzzs3gtlRZB5VWmfY8Tf10Vjz6YQvXk9ZkQI6XFEdEEL1jdJF/3mQ
         C9pIn6TUofBmHAyB/suMZ5rn5Og1oMj/aE7UiVX2AsOjq6gjY9ZOJFd3p3XLFP3X6DZE
         6PpcVMNPj/4l/vpyrzqWnoX4H4GD94pP9g2FRdH1HM3MvoKGEeZ4B9HKZB2d9xrIrCGu
         bT04SHMwGQuulqxmyYlgfKZeWFEp7FzKp5oDG6+of0StDmCJjOoxYIN4mD/qRhgvMI9J
         2AmiZfNayR4zN202N2o5pFG//9D8CicWHGZd1LDi4uRuNYezavn3CU9R1ObBWiydtRSN
         kARg==
X-Forwarded-Encrypted: i=1; AJvYcCVHUWF6QJwcV6AJJwBjfWK49V3hCUmZlT64z0yiCvjYbESWKz9twsRs83ntuRc5qkX4LCig59a2SVojB//IMfIs6iQo6HjbRMyF05dWtKfS2c49fpSbhQaSKZ/kkeoZ+5iVVOFAi2jUS/dT9ndY
X-Gm-Message-State: AOJu0Yz09zrDdBo4dJil39fXZgO9bQUXZmoNF26mmclZAwUsdmh/uqaY
	8Al7e5aHfW5dMN4zWd/FPdSG72qu6Ia4qj+brKg8i6iRp2BNmdNk
X-Google-Smtp-Source: AGHT+IHf9umZ5lbNZtP5yOgE2BHbesHxaX5NHSR2BitCLKgSeCTurwhmeUltxAQeOVniozw1S4i7Hg==
X-Received: by 2002:adf:e58d:0:b0:346:251a:396d with SMTP id l13-20020adfe58d000000b00346251a396dmr6516246wrm.51.1713819071183;
        Mon, 22 Apr 2024 13:51:11 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:ab0d:124:447c:bf37])
        by smtp.gmail.com with ESMTPSA id w15-20020a5d544f000000b00349c63eb484sm12861576wrv.23.2024.04.22.13.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 13:51:10 -0700 (PDT)
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
Subject: [PATCH v3 0/2] Add IAX45 support for RZ/Five SoC
Date: Mon, 22 Apr 2024 21:50:51 +0100
Message-Id: <20240422205053.496095-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

v2->v3
* DTS/I patches dropped from the series as they have been merged into
  renesas-soc tree
* Just using a const from compat string instead of having it in a items
* Added RZ/Five specific irqchip

v2: https://patchwork.kernel.org/project/linux-renesas-soc/cover/20240403203503.634465-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
v1: https://patchwork.kernel.org/project/linux-renesas-soc/cover/20240129151618.90922-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (2):
  dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document
    RZ/Five SoC
  irqchip/renesas-rzg2l: Add support for RZ/Five SoC

 .../renesas,rzg2l-irqc.yaml                   |  17 +-
 drivers/irqchip/irq-renesas-rzg2l.c           | 150 +++++++++++++++++-
 2 files changed, 157 insertions(+), 10 deletions(-)

-- 
2.34.1


