Return-Path: <linux-kernel+bounces-41276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F55E83EE56
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 897C21F231A8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742FD2D611;
	Sat, 27 Jan 2024 16:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OLFUkwd5"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DBD2D052
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 16:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706372310; cv=none; b=eRQKsDywwhHzTxE4F/mtGZ/YcjoRNvjT6xRM1sx/7kvSRyGhmGapYfx2uzG7zvwt1QV4uqw6donVIxnUiQod4efObhQ2vZPvYRx+T0jOsFHfNlmQCtvZm/FuuDvLHgE3LQlT5Uf9Y4gkRugT+AQjv1zgujGzFE17NLF+pkAUPlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706372310; c=relaxed/simple;
	bh=eJFuo3cIfXEq1mEON0RCgiaWMZ23JLuACI8xiBlZ4CY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SA69LUEkeQJtBCp4F+k+SiWt7J+nOEREmkLKO3cPaoPn8pfjfmSgRTtF94jXKHyb6pwAUFyGKrPBydyG98Wji8t9+6OYpYY4nTNzz4ZBawBSrDu1QTI/GYcO94hIQRmYT1s/Ie43gU32aHcwOT3bmXEmVq0qqTw0Ngmz1L6SMSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=OLFUkwd5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d730b6943bso7060275ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 08:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1706372309; x=1706977109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gio4VcisYA6evHi9fLFTB/NsIADoYywgfT0MwGlZzIc=;
        b=OLFUkwd5v6tkfaultzA8WwqEMA3GwD6QeZUFT8YUzgO1ZY7XS34jIRPfoDVfXTNek/
         tAbd/n4kTnjhZWXHVw7nAwPgyIogameaQYLn3NbPO9QglqvkTMKlYbYppRXu6rD0CHKr
         XnDiIsa8jfQShhMkcweTg4NpTuN2l8Okz+urrnttE2ec3AlUwgckyCAUE/f83DvOvHCO
         tQhqBepp4RRU+BNHmWoUuI9/4xahnS7CE9qScsmtg94DSWXSXLWdSFMPiTJV7tPgJDPL
         ymE1PTE/g7q6SAgeMXLCUsyWje4GgZXKNYG47nq4N0z6SdbvCD0WLK/uacCnRMMK5x0B
         FdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706372309; x=1706977109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gio4VcisYA6evHi9fLFTB/NsIADoYywgfT0MwGlZzIc=;
        b=p2JrS1iX7NyRXxzoLW71210fyeg3ZjpTgniRnMcp1N1AUd/f2xEA16hlvdh88/1tAR
         qOw1jV5UpqoYzD2aH8E9UvDl62HDB8vRjif/YXQcLU4MQzzM1lIK8vwsBlCGP+oufO/Q
         7ao2bJEntD2rAyyUbvjesSDuHPLMHne1JDfhkD57C84vjgwxe3+9GYZHdkL8d4XfKCLg
         wexEuqSYcFYdF+0fobRW6WrWlYB3XGjG81O9eoEn4epa8jy15cAVCeEwshpsoESWKIbH
         LKL3AI7McATWoaau6quKeVewc4CP6Kez7TKQExP4gHLECU5B+amj/W1DNjDVnffxJrdh
         2wCQ==
X-Gm-Message-State: AOJu0Yy+8QEcmRHwhsjolh3XzaTklTwi0PDqzEDeh78ADkaEX/Qvlr5v
	abNU86QzO1gdUAubQvfg02k3Do4WYvkWKiu/xYHAL/QHIdCsvm7RyHK0NExX4hU=
X-Google-Smtp-Source: AGHT+IED/6ZIyLe42SYcWyw5qvmxNb89PVkJ7Cc0/TjAs0f65nBH0WO/WCelT/RErST/4ZIoCKlTJA==
X-Received: by 2002:a17:903:1c3:b0:1d4:326c:1c89 with SMTP id e3-20020a17090301c300b001d4326c1c89mr1195988plh.10.1706372308671;
        Sat, 27 Jan 2024 08:18:28 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.86.17])
        by smtp.gmail.com with ESMTPSA id d11-20020a17090ac24b00b00290f8c708d0sm5091620pjx.57.2024.01.27.08.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 08:18:28 -0800 (PST)
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
Subject: [PATCH v12 02/25] genirq/irqdomain: Remove the param count restriction from select()
Date: Sat, 27 Jan 2024 21:47:30 +0530
Message-Id: <20240127161753.114685-3-apatel@ventanamicro.com>
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

Now that the GIC-v3 callback can handle invocation with a fwspec parameter
count of 0 lift the restriction in the core code and invoke select()
unconditionally when the domain provides it.

Preparatory change for per device MSI domains.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 kernel/irq/irqdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 0bdef4fe925b..8fee37918195 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -448,7 +448,7 @@ struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
 	 */
 	mutex_lock(&irq_domain_mutex);
 	list_for_each_entry(h, &irq_domain_list, link) {
-		if (h->ops->select && fwspec->param_count)
+		if (h->ops->select)
 			rc = h->ops->select(h, fwspec, bus_token);
 		else if (h->ops->match)
 			rc = h->ops->match(h, to_of_node(fwnode), bus_token);
-- 
2.34.1


