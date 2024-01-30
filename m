Return-Path: <linux-kernel+bounces-44133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE52841DBB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28021C27ED2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125F558239;
	Tue, 30 Jan 2024 08:27:31 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3A557866;
	Tue, 30 Jan 2024 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706603250; cv=none; b=gDAKxIGz4/uqmZJB9crJPlr81VCzdauw4eq9079B4+FCz7kO+Z/y+o7aU1Bzp+3G3cCtezaddDMYPl4vKdHU+Mx2nWeQBPjxjawIuUx0vPQ2zbRUGjZmlfK9/WTI8mG2N90nlYDoRHAh9UFY3z/IA/9hVY97pmQY6C7s2ra9qm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706603250; c=relaxed/simple;
	bh=j98IsQ8A2Z7MQ4f9OXygCnkweqIQTfvcNd9hW2MDvYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kyP1pPKg9Vz6QOF6+7xagF+/+swKhe3Ux7c+BsZ1nj2QY1kUIrYuEEv8DZU1bh0tWFXDHwZVoIWYBOy8KwRYiB+F8QNmp+HdQMDwwjG10qjyZrvVNKHVZtzwijNF80ghnMA7Z/CnoHCHm+ytQbJ4syofAxVMdlqwElTxiJnLyqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxbOnusrhlZ0EIAA--.15199S3;
	Tue, 30 Jan 2024 16:27:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxHs_qsrhl4KcnAA--.23872S3;
	Tue, 30 Jan 2024 16:27:25 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	lvjianmin@loongson.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH v5 1/3] irqchip/loongson-eiointc: Typo fix in function eiointc_domain_alloc
Date: Tue, 30 Jan 2024 16:27:20 +0800
Message-Id: <20240130082722.2912576-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240130082722.2912576-1-maobibo@loongson.cn>
References: <20240130082722.2912576-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxHs_qsrhl4KcnAA--.23872S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKF47tr4UArWDZw1xCryxCrX_yoWDtFc_uF
	12ywnrGryaqr12q3Z7Wr1aqF9Fg3s8WFnY93Wq9F9xC34Utw18CrWaywnrJan7Kr4rAFn3
	CrZ8JryfAryIyosvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb3AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxU4AhLUUUUU

There is small typo in function eiointc_domain_alloc(), and there is no
definition about eiointc struct, instead its name should be eiointc_priv
struct. It is strange that there is no warning with gcc compiler. This
patch fixes the small typo issue.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/irq-loongson-eiointc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index 1623cd779175..b3736bdd4b9f 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -241,7 +241,7 @@ static int eiointc_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	int ret;
 	unsigned int i, type;
 	unsigned long hwirq = 0;
-	struct eiointc *priv = domain->host_data;
+	struct eiointc_priv *priv = domain->host_data;
 
 	ret = irq_domain_translate_onecell(domain, arg, &hwirq, &type);
 	if (ret)
-- 
2.39.3


