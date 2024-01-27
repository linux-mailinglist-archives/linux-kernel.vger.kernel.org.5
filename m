Return-Path: <linux-kernel+bounces-41274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7591583EE52
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08C32B22A3B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B87A2C6BB;
	Sat, 27 Jan 2024 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="geP1o5ph"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCDA2C6B5
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706372305; cv=none; b=p4Bprt0errRT/E2fJneMc6WJSgt/ZKMsWsCQo6/EhmFQ/GpdI6xw0TZySCHM6SwkA6G9EdIsUMUYT0Rl2PjMBHQUeN54T39t4vo4vTjhoMHPPSLyU6zVDRtIqLdZ1B+GeYvGGKLdDzQmTxdhv+sOgzcjSVlswZ+36PthItqKskU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706372305; c=relaxed/simple;
	bh=EDsrArkwDhq7KC2LZOeZEyPp5+AA3ka6aMI74l1LCfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u9W/RDF/H/x1VZQqg7vn6L7cK3GPtBiGudEvFPexvAW53eQRxgWmrT3KXt0dfDAdONE5XuRu+cd0oUb1+TfIb8PJr8ihnfKBIWMJjVjUNVvFtvy5TgYCClS/L6mHYAGrrDODgZOlANtJRk8RlR16GtREqqaE/ow0hOauRZr7nhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=geP1o5ph; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6db0fdd2b8fso663361b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 08:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1706372303; x=1706977103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zu7qmaFKtSQTHBWmN1WZersC14c4aifFLlwgdgw14DA=;
        b=geP1o5ph7ZITJhi0zygGsGl5t+fa/vxYrUbPpJvAUjLkVsZA4C6cJbg1QDrbyMBQai
         afYuRzSWerQWn83RRriR1qUGp6ZsnCT9GROQk4G1XGUDZ4Yo01Rpq4N3TUS9VdFPAnJG
         B7O6dhugmZPQsk7dZPnQHx3uWdRUpq3/sBTkSEkoeMMXlegkfZmAEqudFDGDxJvt0iL6
         zA4Pi9aqC4t26Pvn7ZGzCj3AGqz67b/PLWPvb3tXszyk+D5Hplb9suwJtmE6Qd/zxOLo
         YRaFziypOLNcQQKnRQXfrwFtQkDPC9J9liow3vLoDjcVrNy4w5cJkL2LfwHCS10Kk2uE
         lQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706372303; x=1706977103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zu7qmaFKtSQTHBWmN1WZersC14c4aifFLlwgdgw14DA=;
        b=QZhR92+K8ln81pNW8yic0b2K5EaeZvV0zHI8tklwZawhJXyGeQnyaXf0pGYrzy2UJs
         f1moomXy+cWgl/2PGkq/dUzTpi/785C3ggWxJk1qCU1GsFJV92bAovZLQimxrrZdV4e+
         ypsTqDpZgBzIclAKDC509pUkkbw5Jy2utFWuhNZjqjo1HFGeT8dGa6lyUP25vHJ+vW3N
         ZBjLYHf2fX2JEyZavVYI4c2AqbNaqEeA77i17I+USDzCtzvd1kiqpNZeLlTxipXkER9R
         af+pId040nysq8l/cIwS9nFAbpRTeaIzxPukkLWqf27SyXvpx5pnAp7WUmk+2vpFuv8G
         HKMQ==
X-Gm-Message-State: AOJu0YyhP0cyUppxomodWAB8uP1grFhJ5bW8S7h/TkeukR9XTuNSPZEF
	DOpR8MNmyDKzM2Ad9th7jo8xS9ACaEO49NdEi57GwFAK1jKUSj+1gHutxkMZ7zY=
X-Google-Smtp-Source: AGHT+IGWNqCuHvim94RTzZCaCZxexRf+vALBBKbirBhqFCZBtNghT5AvXpTXfThJR+s7xqJCGSZFFw==
X-Received: by 2002:a17:902:bb85:b0:1d7:56c3:75f1 with SMTP id m5-20020a170902bb8500b001d756c375f1mr1352934pls.122.1706372303005;
        Sat, 27 Jan 2024 08:18:23 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.86.17])
        by smtp.gmail.com with ESMTPSA id d11-20020a17090ac24b00b00290f8c708d0sm5091620pjx.57.2024.01.27.08.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 08:18:22 -0800 (PST)
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
Subject: [PATCH v12 01/25] irqchip/gic-v3: Make gic_irq_domain_select() robust for zero parameter count
Date: Sat, 27 Jan 2024 21:47:29 +0530
Message-Id: <20240127161753.114685-2-apatel@ventanamicro.com>
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

Currently the irqdomain select callback is only invoked when the parameter
count of the fwspec arguments is not zero. That makes sense because then
the match is on the firmware node and eventually on the bus_token, which is
already handled in the core code.

The upcoming support for per device MSI domains requires to do real bus
token specific checks in the MSI parent domains with a zero parameter
count.

Make the gic-v3 select() callback handle that case.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 98b0329b7154..35b9362d178f 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1702,9 +1702,13 @@ static int gic_irq_domain_select(struct irq_domain *d,
 	irq_hw_number_t hwirq;
 
 	/* Not for us */
-        if (fwspec->fwnode != d->fwnode)
+	if (fwspec->fwnode != d->fwnode)
 		return 0;
 
+	/* Handle pure domain searches */
+	if (!fwspec->param_count)
+		return d->bus_token == bus_token;
+
 	/* If this is not DT, then we have a single domain */
 	if (!is_of_node(fwspec->fwnode))
 		return 1;
-- 
2.34.1


