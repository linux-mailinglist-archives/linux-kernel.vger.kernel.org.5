Return-Path: <linux-kernel+bounces-72388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E68B585B2B6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 720781F2231B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487125B209;
	Tue, 20 Feb 2024 06:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="BFcegst6"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253BA5917C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708409344; cv=none; b=bUco6iLzdimGGFGpOoHURa2yVR/DJfyHIdkTj1rXfrWOutKtM+SSWO1Pp79tNWYop/E5DiuZFcpyGyJ88qJj+18lDOrQTgRm9YD9pYsaWdXAfZ9Uuo+afyeHu/AiTdpQL8CBlP5+Wj/kcRM1PxYiwTLIhMkgvZDTNWa0z1JWNk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708409344; c=relaxed/simple;
	bh=cHX9yVZX2U/M0SSdzvjQb4m+7zWASmD9kQu3egh0Rao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SNKpZj6oZF2P1aS2eFTkOvwtKuRP559kPOBcjVJDb63/jEYXECPgLtsBLJcPMF5UlmxXGXC6ga+1iEAl6Y3292UbfEcR/5TaE/4d31PbbJmOWiA1sMm4K+UmYU/fulUf3tXAK+oKaPYTFTKS6SA/pyvXC+wjE5WYGZyfZulb104=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=BFcegst6; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso2647587a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 22:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708409342; x=1709014142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTFsbe7fY6CIFM3QbszGAvcCN7xF4yBveTkrIBLrPJ8=;
        b=BFcegst6a8/p/P+PUITfAlq8/+c+zurC5hvygCIaw5nb96Jr2K3GYTR4jgmrNikbm/
         hQ8CKcJ8i9wQcIsVaDzEDBuVTzDxLb3cZ+ZAcvU0Y4o647EVilMLwzNTpRDoFcSblDQ8
         +DRQgXJKCu38jAu9iQtmtHqc9yZEOSfY2jzWHXgsmJ4AWVt7HLqrhZYfzuK2G5gNACi8
         6ktgTI5N2Fb8KekP/baFsGfusMrjuIHTvLUMJgqtIxoVGnHfe0mUwb3sOn5FBStGrBKN
         J9RZBjRWJOI1oPrwCILdjo8JnlzzndHzHnOSjWPQqzK0TwKePiFr6kc15T+YPYjfRAKK
         AShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708409342; x=1709014142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTFsbe7fY6CIFM3QbszGAvcCN7xF4yBveTkrIBLrPJ8=;
        b=vnl2pB9Xj8A/fZsNKk0olgjYmEx8GlIOIyMSMp4co5kKLlcmM0Yz00j1Fh5y5Yy1gz
         O1tUKzljue5e8mqI5k4WUI9LOigkLXe67sNs/m3duZsf5H1J5TMbn5vhI1TeWB5JRtfI
         POrGLPqPuDOIGexXeJdjSOIq0buW0ASO+Wnp+snHtvHt8UZnNEtRnDWKGzfqEUxyNK1G
         YeyV8ODHaEphxpUKPyseskg2n2xNRX9J3Wh5svdrrQNkx2qVqO8lNwqZTcVQs+id5yAr
         z9qaRp2fFCo63gIfILwuDRRE07XQAuePyCcB3WFbWLFEM8ftC7Ab7QoTlHhpwSSrlqCB
         3OSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf7Gl24zvZD5fYJ9oOq3P0SKmoD5Q/NvPP7H/kKNlopU35VytNW943TR6t20fhfK0yc9DcFrM8CIBthQEolSkOirfkNoCItqqU6MfR
X-Gm-Message-State: AOJu0Yw7GL+E8KvBIOZARXSjvRKOSSdDhqXgneL1lCzfbGhoGHppj+DZ
	BoPkSqSqhy0nYfTI1/Z+t/F3op+b0e+gVltrZAu4hv27OrenJgjY5wtRkHYgP6s=
X-Google-Smtp-Source: AGHT+IEBBH3jBOTouE3fPQJ+zX117KApfGEgQ3veE5qYZqE2RMAHzwyj/h4hK1b0zjfKKWY60Y75oQ==
X-Received: by 2002:a05:6a20:93aa:b0:1a0:7fa2:305 with SMTP id x42-20020a056a2093aa00b001a07fa20305mr14510461pzh.47.1708409342479;
        Mon, 19 Feb 2024 22:09:02 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.80.86])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090276c600b001db4c89aea5sm5368114plt.158.2024.02.19.22.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 22:09:02 -0800 (PST)
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
Subject: [PATCH v13 13/13] MAINTAINERS: Add entry for RISC-V AIA drivers
Date: Tue, 20 Feb 2024 11:37:18 +0530
Message-Id: <20240220060718.823229-14-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220060718.823229-1-apatel@ventanamicro.com>
References: <20240220060718.823229-1-apatel@ventanamicro.com>
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


