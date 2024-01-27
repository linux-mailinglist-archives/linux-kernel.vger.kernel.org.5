Return-Path: <linux-kernel+bounces-41283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0523183EE65
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905641F21DDD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED92446DA;
	Sat, 27 Jan 2024 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="JRJeqNhY"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E57544C66
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706372351; cv=none; b=nf84Ugp81hbR36UV4KJvb9r063CkZsTM5AYZ87l71polkQvT+MxwDd5ofXUwVHIYuvFdb+3OrX6T/YFdZVRCz0lJtmCxkJiRQc/UT6XTfkLuOtelWd/u53jvPQAIl6i1g4IwXTd9m79y/oa31dWyNkl8xqhhfVvBxPPy5WImAlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706372351; c=relaxed/simple;
	bh=Q3rBGV+pgrEfKQs4sIgL09+u14n+Sa+WhQ7vAVT4hvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FMP7ztVaj44EFVhq37LtWpAW33izI6BdWYwCEw4I3PRq0XmZ13HTEenQfTuoQFeAW0rbxQIrUILyZ5f7POH0fSkWWn0KyDSOI7m+UMTnRObI/c21lWbo+t2ZZRciYfWO2LcKf8NwfzcQhEeQZjWC8+hVvTPhMK1kBpHHQCRbnIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=JRJeqNhY; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d8ca5692f2so315585ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 08:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1706372350; x=1706977150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aon1Rb6AZmHyR8DhDKG8+17ET4YMl25ggX5aln3DKEY=;
        b=JRJeqNhYqb6+THDOgWcIHJ8YSBdSx7WTaECMYTzXbH0GFkn5i6raVy9DLr+XDns1l4
         DZYLY5LmhId5kEJ7allY+HiyBmoz+2hJObnnniEJDfciO16ntGSSESAPj25UxHJJWzgi
         g8Cee+JS6Znu5iwo+tYOdRO45f2XAJE6gTgzOrH7FBSWPm1sXwDSNvSh1gcNiaJ8Y+TU
         oIPMG1uVFkk7eyOFy0Xh3pCbME4XF3RaxcwivHNlLVdmNBZBIruYhbMHddtzYD4IBRl7
         pEiuff3sKca515euYWqIVnRMoCJJ5dLBcgkpULxhiZdqwPnYoRD6gYKzHGyvGVZxH8t1
         bMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706372350; x=1706977150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aon1Rb6AZmHyR8DhDKG8+17ET4YMl25ggX5aln3DKEY=;
        b=ak8yuYEJHqPLHOZ/54CQyWUTewZGLAvFzRXG7zPd2p+7gEBwWXPozxT28GneDXulg6
         K57pWQtYataHsAEdl5OGSkPyNNKRcVNjvmHjJ8MDIuWbrxAG93HdBEzkm9KeTdn9HggM
         uNoNzWc2QMliROD6c+I0sUEIZOdKtp9a/VH3z30rtUo7cd6PuxBfE1WK1bYnWVzX41Eq
         TLiRTEjPkm/Mm70fSZ4PpQHOqux6GXgGf7Twf66/t4D0RF21jo2m10EG2mn2co0TIoCn
         zckIzCsLxmtdgYtjgny9JoBU3OL3G3KIh8uTHBtGuYhqJ4Ojt+Q/fKf8JRL8Rf+m0Aw3
         oXkw==
X-Gm-Message-State: AOJu0YybQjE5nUR0QA0EsvbmBUuc7j1O9tmMnPWACMXit+96bf8MKqhK
	5xOcPYyNHqSXJLdPPWy1rp1kGm8lN+yyJvLeMZVYyOmld+XevNtaJu+rjZPUQe0=
X-Google-Smtp-Source: AGHT+IESNQpMnkRheaXf4Iny97ASS+tysV2T2yQTW1r5Ok8Ym8c2y+pgCA3LcaRphHbCd/cF/syjDQ==
X-Received: by 2002:a17:902:ecc5:b0:1d6:f4d7:ed13 with SMTP id a5-20020a170902ecc500b001d6f4d7ed13mr1046044plh.83.1706372349939;
        Sat, 27 Jan 2024 08:19:09 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.86.17])
        by smtp.gmail.com with ESMTPSA id d11-20020a17090ac24b00b00290f8c708d0sm5091620pjx.57.2024.01.27.08.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 08:19:09 -0800 (PST)
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
Subject: [PATCH v12 09/25] genirq/msi: Provide DOMAIN_BUS_WIRED_TO_MSI
Date: Sat, 27 Jan 2024 21:47:37 +0530
Message-Id: <20240127161753.114685-10-apatel@ventanamicro.com>
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

Provide a domain bus token for the upcoming support for wire to MSI device
domains so the domain can be distinguished from regular device MSI domains.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 include/linux/irqdomain_defs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/irqdomain_defs.h b/include/linux/irqdomain_defs.h
index 4c69151cb9d2..f59d2e9941a2 100644
--- a/include/linux/irqdomain_defs.h
+++ b/include/linux/irqdomain_defs.h
@@ -27,6 +27,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_AMDVI,
 	DOMAIN_BUS_PCI_DEVICE_IMS,
 	DOMAIN_BUS_DEVICE_IMS,
+	DOMAIN_BUS_WIRED_TO_MSI,
 };
 
 #endif /* _LINUX_IRQDOMAIN_DEFS_H */
-- 
2.34.1


