Return-Path: <linux-kernel+bounces-67629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A66856E30
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92A71F23176
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835BC145B31;
	Thu, 15 Feb 2024 19:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TlMMBwtU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jFUrozY1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8E213F015;
	Thu, 15 Feb 2024 19:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708027027; cv=none; b=VzMYy2ovy8VoqDvtN3Tkg3kyiPNHf4IAg054uGHbqsS30TGSysk4Rb66t9OPI5jnfrgaRzeFqDzQqqbew3mVcx9saoz/Bf9zdf8nUHP1nXF7OxgJjr9++qDlzTMmSDbv5n5rRKAXxUYZ6YUL9ilbyGlaWo/Px62RKwlXjAnIHy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708027027; c=relaxed/simple;
	bh=7YDd2B5SqV45ikmfreJ59bgynvqQkVkZ6xwqZ7/2FPc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qZvWpOcyxrjIsnkJz4cFVIKBmu9raMrObZco4yfFIH5pmbMD4uzl5BsOk7wDC0c0Gtr2klMVXtwRdCnXvzUoMEULS3KpHFU95niEV/bR9EX+t5/zqj7tT8E+3SVp1iQf5/E9zF7gYmACFd4d3uJmRnS/c4PjHTvAiMztBYW1HHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TlMMBwtU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jFUrozY1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Feb 2024 19:57:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708027024;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yTh6mUHjjdibo0tfpOHe8ZBuIoCX8qjC5zycQtTdvSg=;
	b=TlMMBwtUbXfEgJYWSD7MAwWp27AfJ5VGkVYYcntZjNHo7pdWV8tD+Q9KhQ94FQocob8hT/
	lWKFuQmPXVKg+0bdKw1Q4yt2SGpU/clhcN0+qJIe4rXvJ7E8jYNu7BvU6w8pvW61zk/3Z5
	W+3yGlBJSb1ZwGE96udE0M5uQvUUBDtVw+VZUKK90GwdMsyaUpIAgIRYb4V+paQ8/5SBaG
	2s5FbMipUA9JqbxdNKIV6xZJ1thPsAiQjZ4USd8pX7p7d3xGyOjVaunLkIH0E9fCAp6i3w
	ioXmHjj0+11wO7NB+wFJ+kp6iNUIvLe7C0yrcY5VAIVMWKWj3kClDp1cubrJ0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708027024;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yTh6mUHjjdibo0tfpOHe8ZBuIoCX8qjC5zycQtTdvSg=;
	b=jFUrozY1XO+L7id3sNLL6MW4VukfCRDoWLJgf6XTZlyywCbMoalma+Pn1bSwu3PCCedbxo
	NnFMz1lAAOSt6bDQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Extend msi_parent_ops
Cc: Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240127161753.114685-4-apatel@ventanamicro.com>
References: <20240127161753.114685-4-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170802702353.398.15470035846322348407.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     ac81e94ab001c2882e89c9b61417caea64b800df
Gitweb:        https://git.kernel.org/tip/ac81e94ab001c2882e89c9b61417caea64b800df
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 27 Jan 2024 21:47:31 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 17:55:40 +01:00

genirq/msi: Extend msi_parent_ops

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
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240127161753.114685-4-apatel@ventanamicro.com

---
 include/linux/msi.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index ddace8c..d5d1513 100644
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

