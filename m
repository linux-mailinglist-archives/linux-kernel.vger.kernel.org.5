Return-Path: <linux-kernel+bounces-165220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 586858B89B5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79D22B22046
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2786A5A4CD;
	Wed,  1 May 2024 12:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dQMgDEvd"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B84A85C66
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 12:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714565925; cv=none; b=ZZM9U0BCRaAaCeM5ajyxv2/15pmpxEUYuWUCpLQNZR/2fL8Qo8EjmqCn/j7PgcrYIq/Gw+hK7N4TxaQZ+Vnzxt3zBnKT377Odh5cVutH9ahbX3KiOo9AAmaF7o1DAqwS576lBFUgVUbvLhrBxqjxN3Gc0USwqlGcjNy4+EcoqqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714565925; c=relaxed/simple;
	bh=8Sfu8Z9vX1s+/fsrTVCUwOEPkW2bmWazbW7JyHI1Yzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G9f33VhVp9+kSB9Bo9clKir8b73lsqIykh9UEvu9A1jys14eP63lgW6phC2ogZaAzISolPX29tHqwtYISjbtk1gPqary71+/WnT9mnOTtB7oQbQQ0RrQ54Ndfzz2h7KzrHh58wGqW7mbnKO5eQxWweJJMbIiIn94QmQsgIeNWNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=dQMgDEvd; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ec41d82b8bso16634685ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 05:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714565923; x=1715170723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNK+H7F1X6JmEpHoq/SVvyVT2dyL9n7lyqIUUwemfkM=;
        b=dQMgDEvdGDpkqffEqE0YIpbluC9isPcjHb1zOy6hv2Np2N/8nAVqGcGJRlwqvpUDY8
         bnsB7zH723riXC83pII+dlLuSOPW1eOBGt++KkIbN5xvAmSq0UiDCO0zuz2vs4SKGWZy
         Tncrx+1FWLtyHRKzanmiqamw27DPSxEa84g15k0zJZDrK8muzvpaV+LfJ5bLoGJiSs/E
         ZGegZy9o7fQMonMn0YViScl3RPkZX1J5hry8+vrvxFb2zjqZWgbRjmY/jcv1yT4NslZg
         rtetA5YEBa6NGScgTCw+fArrKFiCSxWIxI11V5q8He7YHksYonh6/ciZed/jNjP4Nhmt
         CR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714565923; x=1715170723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNK+H7F1X6JmEpHoq/SVvyVT2dyL9n7lyqIUUwemfkM=;
        b=eWu3o1vZIapIsC2+ROatt4C1WT09F+uu4WQkQ05niEgcnsPZx4lUXA1d8y2ph6zIDB
         rCnwFJE2/ZiyQSGJdivtOImIqeCbhuVkx+vkqllN+oQa2EynXpEdEXU7wG9Qo5ytVEnU
         QNMmOjARhVDxU4yi9xV51o9r605mwyRnrenn8n3EhLh2uJY1AQx7WZZGb2s29kJeIRO4
         Pm8scrfxZYRLlUSkHO8BicukRVDA3mJmDbGxtXhVxa/zTBTBl98njC17jslg9Pp5RUEc
         MMO6y1gzJEbvOgHGUBlZLre8FT68WvTP520jth8yyBH9BkF4rMSUeHfPzg5B/bij3CSA
         GzMA==
X-Forwarded-Encrypted: i=1; AJvYcCVN5TB7h16213PY4FfwXiSJuEO9Sk5XSifAwHpRTT+jFTt5ol4ExewAXu64siGzofBWMM7EU8D0hjpt/vnpqx5OWAWBO04/qAKVDR7c
X-Gm-Message-State: AOJu0YwPs3EoWG8gFQw87XcgGuuQEcU1AsTTjP9R+Au3pyZrnpdtzcnG
	D/DRHICh3rQ6uub+5kzZS2RssWNBzzKy/8hxtAjAxlMjP/IPi56HhG9eaJe50AU=
X-Google-Smtp-Source: AGHT+IGI5pV9TYR10/cfbIQ9JMek+r7tBzzTGhtdRl1CfIULDyfaZRTCxXSzFPv/bTagC0SBwcv3pQ==
X-Received: by 2002:a17:902:db09:b0:1ea:cc:e123 with SMTP id m9-20020a170902db0900b001ea00cce123mr2687556plx.46.1714565922763;
        Wed, 01 May 2024 05:18:42 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.106])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001ec8888b22esm1336900plb.65.2024.05.01.05.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 05:18:42 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v5 05/17] ACPI: scan: Add RISC-V interrupt controllers to honor list
Date: Wed,  1 May 2024 17:47:30 +0530
Message-Id: <20240501121742.1215792-6-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V PLIC and APLIC will have dependency from devices using GSI. So, add
these devices to the honor list.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/scan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 3e3320ddb3da..beded069cb0a 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -832,6 +832,8 @@ static const char * const acpi_honor_dep_ids[] = {
 	"INTC1095", /* IVSC (ADL) driver must be loaded to allow i2c access to camera sensors */
 	"INTC100A", /* IVSC (RPL) driver must be loaded to allow i2c access to camera sensors */
 	"INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c access to camera sensors */
+	"RSCV0001", /* RISC-V PLIC */
+	"RSCV0002", /* RISC-V APLIC */
 	NULL
 };
 
-- 
2.40.1


