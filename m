Return-Path: <linux-kernel+bounces-41277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C97F983EE59
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A8D1C220C4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5642C19D;
	Sat, 27 Jan 2024 16:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ToMaSUKt"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DADE2D052
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706372316; cv=none; b=UYRc/EV1arUpJpgwXjsfbGwTczWCeeT9WPWOl095dfzzdstb22p1YinkAzyvFgTTVFYwbgXd2qwGwA+WuX4bgB8bNdk5Yq0g2HETgMThJW4FQc2gJMF/JXsIT70rwrO+FCWmlao0A+UuRIs7EaSzzl2TZOEHJOrMT7YjHDY+LE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706372316; c=relaxed/simple;
	bh=lErh7pLIs8JPN6EgGGGGO8yVQ1jQjwDvsxftt0cROB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mOWVY2dxXmEnNQYWXfs3qe+pAy+a3bg4Uc1jNPGm/gcH2KZaOlsIqNd/avCYAt/o/Zx2AMEO4XVUnKb6GuJJDJrbnVEtNM7a+Jt25Afy0iZTPaJBVdvqSVOpsI4+mNoVqkFyczGd4S1xwy6rPW/MlTHP028bx4Gt6AzpuJALYOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ToMaSUKt; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d75ea3a9b6so12716715ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 08:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1706372314; x=1706977114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhYUMfVc19qKu3HnThUsAONLPR7ur4VXlw7AfNK85R4=;
        b=ToMaSUKtLffxBTZort5crYfZxbT4CKkzIOLzJO+yZ34eVGxUaZpm2o9TuYOks8K2HN
         fVVEoH8oX6dhumhpSR2tmcKzgAficmfkoGxsr+u6Pk4a4CHlPBEjun+d7Q8FMDuZAeg0
         /VbHWDOiGWtCWQbJASq4RNL8fI2DfGBHt7MEU3kEEM0+dUWSwfzFQ46tkCuMzaWpQl1H
         H/dEWxZuieuTmLyLJXv4Wc3nKGcJTjP7ROIovPaBb2ArQln/suE1GyvAd4efxVC5yYuT
         p+1eTflAIVTqhRYwbzjFWnfsapiQ7cgXvPkG/AX9MM2kizY5AX7eeIW7rQYzQSP4HDeF
         7/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706372314; x=1706977114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhYUMfVc19qKu3HnThUsAONLPR7ur4VXlw7AfNK85R4=;
        b=wk2yY7cJDRa9dBz7pjsjHZC1H3vnzzDezNbXcTUpRzmcBEEdreoDgT7AkA5WJOFY9M
         dz1CR7ygBt2fjNZA+PltwQjxCZ6MeDyYuiscSxzsDh7kUMaIcS02yyZtgoyywiy0g3Ox
         5p6akEQrFZ0NJisbSb8tW/s+6KsBs0RMCqM/SgVXRcEEWOcfJuxokO99PKKlR+f1b7e8
         cz0UZpNhSuiMlFOzDvOMKbNoDVD8iX8qAlnmidblJ8LQwWsQ1dUKsNFfEf3N+BVfAYrd
         04FL14wGn3xvsL5lZ+cr8m3fsFwxv71oQGddtFA2ZKU4Zhd/BD9HgYB4uZa3EoHDmDNW
         qW2Q==
X-Gm-Message-State: AOJu0YxwGEBGEvBpqPt0n8MLkU70UZyB2IUxe2kk8O498+hL2TI/vZv8
	PN5850RUgNA7+AoHby33BaZay6+Z3kk1RAGyb28+Z3fGFs9tUs4IRshT6ie1v3k=
X-Google-Smtp-Source: AGHT+IHtY0P//woqQufFCQxfwqYt9nRAYpMpLB6XG5TxI8TAX8TT9FgCwM/axEzX7TjcSLauiPb5WA==
X-Received: by 2002:a17:902:d4cf:b0:1d7:8237:f770 with SMTP id o15-20020a170902d4cf00b001d78237f770mr2153923plg.17.1706372314502;
        Sat, 27 Jan 2024 08:18:34 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.86.17])
        by smtp.gmail.com with ESMTPSA id d11-20020a17090ac24b00b00290f8c708d0sm5091620pjx.57.2024.01.27.08.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 08:18:34 -0800 (PST)
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
Subject: [PATCH v12 03/25] genirq/msi: Extend msi_parent_ops
Date: Sat, 27 Jan 2024 21:47:31 +0530
Message-Id: <20240127161753.114685-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240127161753.114685-1-apatel@ventanamicro.com>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

Supporting per device MSI domains on ARM64, RISC-V and the zoo of
interrupt mechanisms needs a bit more information than what the
initial x86 implementation provides.

Add the following fields:

  - required_flags: 	The flags which a parent domain requires to be set
  - bus_select_token:	The bus token of the parent domain for select()
  - bus_select_mask:	A bitmask of supported child domain bus types

This allows to provide library functions which can be shared between
various interrupt chip implementations and avoids replicating mostly
similar code all over the place.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 include/linux/msi.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index ddace8c34dcf..d5d1513ef4d6 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -572,6 +572,11 @@ enum {
  * struct msi_parent_ops - MSI parent domain callbacks and configuration info
  *
  * @supported_flags:	Required: The supported MSI flags of the parent domain
+ * @required_flags:	Optional: The required MSI flags of the parent MSI domain
+ * @bus_select_token:	Optional: The bus token of the real parent domain for
+ *			irq_domain::select()
+ * @bus_select_mask:	Optional: A mask of supported BUS_DOMAINs for
+ *			irq_domain::select()
  * @prefix:		Optional: Prefix for the domain and chip name
  * @init_dev_msi_info:	Required: Callback for MSI parent domains to setup parent
  *			domain specific domain flags, domain ops and interrupt chip
@@ -579,6 +584,9 @@ enum {
  */
 struct msi_parent_ops {
 	u32		supported_flags;
+	u32		required_flags;
+	u32		bus_select_token;
+	u32		bus_select_mask;
 	const char	*prefix;
 	bool		(*init_dev_msi_info)(struct device *dev, struct irq_domain *domain,
 					     struct irq_domain *msi_parent_domain,
-- 
2.34.1


