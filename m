Return-Path: <linux-kernel+bounces-76261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F6385F4DA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2771D1C227F1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A961E3F9EB;
	Thu, 22 Feb 2024 09:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="WMYYCpwN"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE37A383AE
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708594962; cv=none; b=UoPSS9L6pd1mTLqJwIy17pfYnYkbyMpRm8L5IxmeZLow821nRTr894i3YwGyOwy282tD5quBsDJYbUrP6lwoHOCBQyKEeFy3/JNHGVKkdf8zsP1WmsUrZ6G6//hi9wsdpOEpJzYyhzxx+d+wheihK6HqY8IFtrkFwqO4yGp/ljI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708594962; c=relaxed/simple;
	bh=cHX9yVZX2U/M0SSdzvjQb4m+7zWASmD9kQu3egh0Rao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aa9oHKLIvmbWZF0QoYSryw0zDZM60nobaYL9Jxi3lLpNfBGPoRh2P1xCDBj8cfbdlhKd89m30KmMph9U5WmGH4l0UqJzy87ShHLPTnC9AK6wjZXCVWxgJWwkxyofnr+OwaBA7aCLgyGZFgnMV3zmOHsOo724HAKsQrQSOZm7Nzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=WMYYCpwN; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bb9d54575cso1037626b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708594959; x=1709199759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTFsbe7fY6CIFM3QbszGAvcCN7xF4yBveTkrIBLrPJ8=;
        b=WMYYCpwNly5llL5XOBn7u5lDVmZOsu8VECa/gjqZk05eu24FnMXkdGMEh/QJ+pZykf
         KGW9LF9c2UFoXCkqlEgA+AgFUpioPvW7NEa6MbLdWc4ujZNOcL091G2BeI2lba9Js0S4
         EY8dowwHyuijTnMGwIkc6LPHzAYoO4QRzZarUS4HHQ3BHv/d6vLw/RWy7jOLj+Q6jmG6
         nfjFqhW2JU+Vi61yjJzgirjkg4Hld8VIyiHrir0C8/ufUwOj8YomJzyaJauRzYdbULvr
         dG8fh/U3tQ3gP1QhVxCALQZmvOA2OcQRtSj/owWieZn4mt+Q6n7aRbd9ECjCPbgDhZtI
         mbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708594959; x=1709199759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTFsbe7fY6CIFM3QbszGAvcCN7xF4yBveTkrIBLrPJ8=;
        b=HFRMxgeb6EXGFiUsrRg7froFGAiHvzdY3wn/rE4c/FE/rvnz2JeODqMoZnrnJ1PNqY
         jFVQg360+5tUcxJrqnHr91VAucEV1lXHOwHTizjjDdNx8AEOBEAotB0TczSuZaUx4ffr
         nwnrgX3q2VdLdu4iyeO/dMphuKcCFvk5HqLFEju2zUXjUwSVm5kkNuymze9G/4vBTDs9
         pYvrdKCD63uK8evCvU0s8dFyZ77Flvao6kvWEGtnrqRAz87ySETg34HyvkS9cZ7HF6ej
         LkG4rxtK3TuG+0fL0X0606MBXaNId2sxzBxz14Wm4cXVVpjEftFoed93g+RnPzV15HlF
         eYOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuxRzMsokNx4K+AWmq3NoQeQ+ZZwMu1OD3cOJHP98MxTjmEYRzQ71+1fRcgi9QCWfWU3vx5GvUT6fKBy3Y1g6M2oO9QD7hQMUFG7ov
X-Gm-Message-State: AOJu0Yxb+/cBeq3EjVG8bypgCCqsnovJu5eVYfh95AvAydgbt8uyivqZ
	tcE0FF2CalWAXaAK5g8qKGyYJmNqzfCaFBEKXUUkXzr+TH2I8GqV7a+yuqquYaw=
X-Google-Smtp-Source: AGHT+IEdqW6jE4esiWm0SS85wFJdMrJDV0i9YNpT80P998X6W/nqUz42BQhn8vd3gyZ2d9UdV+lvyQ==
X-Received: by 2002:a05:6808:4496:b0:3c1:52b0:2ec3 with SMTP id eq22-20020a056808449600b003c152b02ec3mr22434124oib.53.1708594959018;
        Thu, 22 Feb 2024 01:42:39 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id n15-20020a05680803af00b003c17c2b8d09sm130699oie.31.2024.02.22.01.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 01:42:38 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Saravana Kannan <saravanak@google.com>,
	Anup Patel <anup@brainfault.org>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v14 18/18] MAINTAINERS: Add entry for RISC-V AIA drivers
Date: Thu, 22 Feb 2024 15:10:06 +0530
Message-Id: <20240222094006.1030709-19-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222094006.1030709-1-apatel@ventanamicro.com>
References: <20240222094006.1030709-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as maintainer for RISC-V AIA drivers including the
RISC-V INTC driver which supports both AIA and non-AIA platforms.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ed4d3868539..d948f9210f1b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18801,6 +18801,20 @@ S:	Maintained
 F:	drivers/mtd/nand/raw/r852.c
 F:	drivers/mtd/nand/raw/r852.h
 
+RISC-V AIA DRIVERS
+M:	Anup Patel <anup@brainfault.org>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
+F:	Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
+F:	drivers/irqchip/irq-riscv-aplic-*.c
+F:	drivers/irqchip/irq-riscv-aplic-*.h
+F:	drivers/irqchip/irq-riscv-imsic-*.c
+F:	drivers/irqchip/irq-riscv-imsic-*.h
+F:	drivers/irqchip/irq-riscv-intc.c
+F:	include/linux/irqchip/riscv-aplic.h
+F:	include/linux/irqchip/riscv-imsic.h
+
 RISC-V ARCHITECTURE
 M:	Paul Walmsley <paul.walmsley@sifive.com>
 M:	Palmer Dabbelt <palmer@dabbelt.com>
-- 
2.34.1


