Return-Path: <linux-kernel+bounces-7394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 345E581A74D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 20:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8E0288559
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 19:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663A848792;
	Wed, 20 Dec 2023 19:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QN94mJiX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2E6482F6;
	Wed, 20 Dec 2023 19:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d3e2972f65so333635ad.3;
        Wed, 20 Dec 2023 11:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703100763; x=1703705563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KgECJk4lhBej3qZS9B7ni4XfhAqSDLyonY4YHrV/xFg=;
        b=QN94mJiXnU9oZ6MutgyQAjAmXidZF9qZrAbQKItStM/k3AUuA2MT+mXUO8qoEQRd+D
         Qsu9QuGRnnjqNq8jc7TqAWowE47mLe0XNFq28xqazHA49Giq70vIy25AkuM/Btvo2Cn1
         +WDyZOuO142zDoKj/s17tR62h46KfTKtsRoGWUNKNexSWw3LUS4K37kqCBwufgBylsYD
         leULrahys5PXsclLFMmcKzsJptRiDIq7RT6LfdMdTMq0qDveFXBVvg9mApMNoFHjwy1c
         59E4/9HQk4FHNmpxW52+ALzCH/lthTSL3Jy4mnP+k84fmOWowIF/UcGKx7POYr/Abmsp
         /2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703100763; x=1703705563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KgECJk4lhBej3qZS9B7ni4XfhAqSDLyonY4YHrV/xFg=;
        b=Ge1a+mVfcYP0WEFOsi5/yW/IzY+DGyMmSIXDsyaMCPYoCpuVXlnf7ppisBkw4IHWeh
         1nkefkvjouMI4Z5l0GuvuWhtT5EYpJiRsgNWbX+9rIeAUbt1+mfPnx9U3Tk9zJup/7AW
         7HMlnKxT2zSPGUHxo2z/239wlXBSQD72T6XBsQOtddoPZE2X8/qpZQh5zCQhmIgxSIlG
         +zhi5LBfQUZg1eCCCW1K2ZFumHSA5Wl+fH+FBhWmypb6LcjLr9oYHxvt9JHm9K+2f1ki
         NQipfZeCWtjOkpR7z1l4pFlfhPpLap1C3khC7n2PCj96snrohUHVtmy9i5ieDFrlu8dZ
         GXpw==
X-Gm-Message-State: AOJu0Yxm6iK1M2YCCzF6T9Rh6KK+WegZWlaE12Z24UDa5FU9dNd8DWuy
	Z7uYcXqBZXhL7R4+zwNmgEQ=
X-Google-Smtp-Source: AGHT+IHofIfWTJH3TIUobS3OxNvKFHYyhLLuQsRumkDQZd6+UBZp48HA7hMkCItu50SBR2LTbgmftA==
X-Received: by 2002:a17:903:298d:b0:1d3:a29e:cd6f with SMTP id lm13-20020a170903298d00b001d3a29ecd6fmr5672999plb.34.1703100762777;
        Wed, 20 Dec 2023 11:32:42 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c6-20020a170903234600b001d3d9be4d5bsm92280plh.88.2023.12.20.11.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 11:32:42 -0800 (PST)
From: Doug Berger <opendmb@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Doug Berger <opendmb@gmail.com>
Subject: [PATCH] irqchip/irq-brcmstb-l2: add write memory barrier before exit
Date: Wed, 20 Dec 2023 11:32:07 -0800
Message-Id: <20231220193207.1089469-1-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was observed on Broadcom devices that use GIC v3 architecture
L1 interrupt controllers as the parent of brcmstb-l2 interrupt
controllers that the deactivation of the parent irq could happen
before the brcmstb-l2 deasserted its output. This would lead the
GIC to reactivate the irq only to find that no L2 interrupt was
pending. The result was a spurious interrupt invoking the
handle_bad_irq() with its associated messaging. While this did
not create a functional problem it is a waste of cycles.

The hazard exists because the memory mapped bus writes to the
brcmstb-l2 registers are buffered and the GIC v3 architecture
uses a very efficient system register write to deactivate the
interrupt. This commit adds a write memory barrier prior to
invoking chained_irq_exit() to introduce a dsb(st) on those
systems to ensure the system register write cannot be executed
until the memory mapped writes are visible to the system.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/irqchip/irq-brcmstb-l2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index 5559c943f03f..63aed60dd3f1 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -2,7 +2,7 @@
 /*
  * Generic Broadcom Set Top Box Level 2 Interrupt controller driver
  *
- * Copyright (C) 2014-2017 Broadcom
+ * Copyright (C) 2014-2023 Broadcom
  */
 
 #define pr_fmt(fmt)	KBUILD_MODNAME	": " fmt
@@ -112,6 +112,9 @@ static void brcmstb_l2_intc_irq_handle(struct irq_desc *desc)
 		generic_handle_domain_irq(b->domain, irq);
 	} while (status);
 out:
+	/* Don't ack parent before all device writes are done */
+	wmb();
+
 	chained_irq_exit(chip, desc);
 }
 
-- 
2.34.1


