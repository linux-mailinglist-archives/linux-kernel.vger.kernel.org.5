Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BED7E8BCB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 18:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjKKRA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 12:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKKRA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 12:00:57 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5762590
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 09:00:54 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so2394139a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 09:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699722054; x=1700326854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dStD5B042zhWz8uhcKU64rvWRJeW1rxwjoPyS6/Gb1o=;
        b=cKPGT47e480hCbFXYCRfewdSBKeRRmxn1NblNnZmAEHxmPbGNoI2BYNuSalL9t39L2
         oUWL6i1e/Tw5hK6PDqrI75z3t+yZ5wg2RfBNxZGhOCsdKkn2KliBOEZpN0uV6d8HljcA
         8mI4idIWsjlnF0t8AdUyhCT13huJq6nlbKYFmjIzLpJfUWY0zumPFj8IwE+bfM6Kb9Ik
         4KvdHr5gGuExjuP7H0rIlcqHp+1NPkf/1OkNc78fRnkfj+iIPrGeM+dgGtwddRymLCOv
         P2CxgSeQd1MPUCUglADwSUU86rGrvi4/xLcaQ/M31Z87YvkcT6LTOVAHCba5Ke5yjexu
         zv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699722054; x=1700326854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dStD5B042zhWz8uhcKU64rvWRJeW1rxwjoPyS6/Gb1o=;
        b=EBCCSKg2w1IIMSDOLp+fvLZcIME8NQwMk81qhj8XQ0aXoVEU8ljBuHSzMldmUZsrJU
         5irll3aosTpgZwqfIVsK1RdZdDq6JdJ75+aKWZV1CwKES9TWPOSyVK71q/U9qMiwMu9i
         JyRB/xmwEw3ic9oR9W5o/ghvi5Qlds1aOPl9C4i9+RzcLtyMfHGO01YB7O398U6noasC
         gRhV37m1UJkJ20K6VoJHMccCFD9ML+Bh+rfKjEOjRm5shNguVlGIGM253iWxGvRHb3PA
         B/Dxu5IRGF0djJUD9sSpzqsLIw7Ubaee6D4Xh89jShNGeAM1vhWnoqWazVxi/I2/ssYn
         Fivw==
X-Gm-Message-State: AOJu0YwYHJqocXlvPYdDp1iOPLGb+PWZ48dsA3r+7iu/TvVW+4jgLOM+
        ivhiHbEVbojZXq7i5a92+Vo=
X-Google-Smtp-Source: AGHT+IETvyU8xxf0o8frPbikwWERdkFX+/NrUhpoHblscQj7I5uNBf6G1J29av5y8tFJqvilFGvdgQ==
X-Received: by 2002:a05:6a21:3e02:b0:181:ad19:d0a1 with SMTP id bk2-20020a056a213e0200b00181ad19d0a1mr2980569pzc.18.1699722053678;
        Sat, 11 Nov 2023 09:00:53 -0800 (PST)
Received: from DESKTOP-NK4TH6S.localdomain ([220.72.86.232])
        by smtp.gmail.com with ESMTPSA id g24-20020a056a00079800b006b73af176c7sm1493226pfu.157.2023.11.11.09.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 09:00:49 -0800 (PST)
From:   Paran Lee <p4ranlee@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, shjy180909@gmail.com,
        austindh.kim@gmail.com, Paran Lee <p4ranlee@gmail.com>
Subject: [PATCH] irqdesc: Fail check on early_irq_init allocation.
Date:   Sun, 12 Nov 2023 02:00:36 +0900
Message-Id: <20231111170035.10386-1-p4ranlee@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing start_kernel(),
On early_irq_init(), alloc_desc() or alloc_percpu()
may be fails. So, Explicit fail check needed on dynamic allocation.

Signed-off-by: Paran Lee <p4ranlee@gmail.com>
---
 kernel/irq/irqdesc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 27ca1c866f29..bdc35823e4c4 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -565,6 +565,7 @@ int __init early_irq_init(void)
 
 	for (i = 0; i < initcnt; i++) {
 		desc = alloc_desc(i, node, 0, NULL, NULL);
+		BUG_ON(!desc);
 		irq_insert_desc(i, desc);
 	}
 	return arch_early_irq_init();
@@ -582,18 +583,16 @@ struct irq_desc irq_desc[NR_IRQS] __cacheline_aligned_in_smp = {
 
 int __init early_irq_init(void)
 {
-	int count, i, node = first_online_node;
-	struct irq_desc *desc;
+	int count = ARRAY_SIZE(irq_desc), i, node = first_online_node;
+	struct irq_desc *desc = irq_desc;
 
 	init_irq_default_affinity();
 
 	printk(KERN_INFO "NR_IRQS: %d\n", NR_IRQS);
 
-	desc = irq_desc;
-	count = ARRAY_SIZE(irq_desc);
-
 	for (i = 0; i < count; i++) {
 		desc[i].kstat_irqs = alloc_percpu(unsigned int);
+		BUG_ON(!desc[i].kstat_irqs);
 		alloc_masks(&desc[i], node);
 		raw_spin_lock_init(&desc[i].lock);
 		lockdep_set_class(&desc[i].lock, &irq_desc_lock_class);
-- 
2.25.1

