Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38591789930
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 23:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjHZVH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 17:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjHZVHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 17:07:36 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E268FE54
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 14:07:33 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76e09202322so122128285a.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 14:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693084053; x=1693688853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9NqBpfNWuVfp+lqLBKycG9ymHculNF42B6ncYsp/94=;
        b=SxgmnLezK4gaSX8p3F4cOd4SCApJvv+hUWyZTZq4iHthw9/jgXpfyXz1e4w2gW88gz
         sX3hOZSs69/iJ8dncB93dbX9G6EthmjcwIAMlSaTbJO7uL4Rn4gQ/VUJpFqPu0+bICQ0
         8s6rGkDzxkoYm6AmY+PzdlJNWbV1sUpJac/anH6aKcICuI6ArZs+xMVw8NXowEhDYiaC
         a216LjaC3Fob8oc60zkN0HO0xjD5n6CjoutE0BvrGSsEzqOSjOlDczKQM250T3PKFzI8
         QR+nevAVVB2ENHia0ZZfwa+GxX/fBrW01feip0s/rDyPqzdMyt8nloVUYTOedru81AGd
         hztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693084053; x=1693688853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9NqBpfNWuVfp+lqLBKycG9ymHculNF42B6ncYsp/94=;
        b=LNRJGDEVqm0FYlamdjRmlUuBtf3xnbkgC7lYqScv632FhyomPzhrP1J1pWT04p36M7
         koaXcCuFbAZytW8N4ZsZih5fxJ+c0NLr3GhYPNWzqzrtPTlkU3jdJr9kQfIS2ghHLh/c
         PVl8XfmIv6V9SDPdxwkqupeggd09haN8MGIJLW6f/V6IfoVNVWLkCnd5WU6FlbmmgVF4
         i+7zgPnQbEIxXW2tmnhhNlgryMpkgxqPfGHhCmgPMiqnuGdT1vk4XEYHJf1yTtMS1Gos
         o1kyiFTlxLQcp6d2iAA2NLH6y4sO6mrFwYDxSUI/IEWdstZKsAzAJ15av8Ai0Cwn0PtB
         LoCg==
X-Gm-Message-State: AOJu0Yz9gD8XlVPJ65ZGP6xgX94NqpIBbK7Q2/ih8S//PNX3FLNL8MGb
        Tm2zw180BQ9Q7CdWp/eBSiY=
X-Google-Smtp-Source: AGHT+IHWEvLapkckEOmKW0AV9DzKV+uLzKt0JgheRQtzeM9+mavbPDoZLaJuJDzuR0QcSs/fVj2cjA==
X-Received: by 2002:a05:620a:2add:b0:76f:44c:5cd0 with SMTP id bn29-20020a05620a2add00b0076f044c5cd0mr2546920qkb.48.1693084052955;
        Sat, 26 Aug 2023 14:07:32 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:82ea:8c7c:b784:3f92:988a])
        by smtp.gmail.com with ESMTPSA id w3-20020a0c8e43000000b0064f50e2c551sm1488377qvb.1.2023.08.26.14.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 14:07:32 -0700 (PDT)
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Alexon Oliveira <alexondunkan@gmail.com>
Subject: [PATCH 1/4] staging: vme_user: fix check alignment of open parenthesis in vme_fake.c
Date:   Sat, 26 Aug 2023 18:05:15 -0300
Message-ID: <639fc19f5c5bce6557a813728b28c299c5134ecf.1693082101.git.alexondunkan@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693082101.git.alexondunkan@gmail.com>
References: <cover.1693082101.git.alexondunkan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed all CHECK: Alignment should match open parenthesis
as reported by checkpatch to adhere to the Linux kernel
coding-style guidelines.

Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
---
 drivers/staging/vme_user/vme_fake.c | 65 +++++++++++++++--------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index 7c53a8a7b79b..a88d2c8a785b 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -105,7 +105,7 @@ static void fake_VIRQ_tasklet(unsigned long data)
  * Configure VME interrupt
  */
 static void fake_irq_set(struct vme_bridge *fake_bridge, int level,
-		int state, int sync)
+			 int state, int sync)
 {
 	/* Nothing to do */
 }
@@ -125,7 +125,7 @@ static dma_addr_t fake_ptr_to_pci(void *addr)
  * interrupt to be acked.
  */
 static int fake_irq_generate(struct vme_bridge *fake_bridge, int level,
-		int statid)
+			     int statid)
 {
 	struct fake_driver *bridge;
 
@@ -152,8 +152,8 @@ static int fake_irq_generate(struct vme_bridge *fake_bridge, int level,
  * Initialize a slave window with the requested attributes.
  */
 static int fake_slave_set(struct vme_slave_resource *image, int enabled,
-		unsigned long long vme_base, unsigned long long size,
-		dma_addr_t buf_base, u32 aspace, u32 cycle)
+			  unsigned long long vme_base, unsigned long long size,
+			  dma_addr_t buf_base, u32 aspace, u32 cycle)
 {
 	unsigned int i, granularity = 0;
 	unsigned long long vme_bound;
@@ -221,8 +221,8 @@ static int fake_slave_set(struct vme_slave_resource *image, int enabled,
  * Get slave window configuration.
  */
 static int fake_slave_get(struct vme_slave_resource *image, int *enabled,
-		unsigned long long *vme_base, unsigned long long *size,
-		dma_addr_t *buf_base, u32 *aspace, u32 *cycle)
+			  unsigned long long *vme_base, unsigned long long *size,
+			  dma_addr_t *buf_base, u32 *aspace, u32 *cycle)
 {
 	unsigned int i;
 	struct fake_driver *bridge;
@@ -249,8 +249,8 @@ static int fake_slave_get(struct vme_slave_resource *image, int *enabled,
  * Set the attributes of an outbound window.
  */
 static int fake_master_set(struct vme_master_resource *image, int enabled,
-		unsigned long long vme_base, unsigned long long size,
-		u32 aspace, u32 cycle, u32 dwidth)
+			   unsigned long long vme_base, unsigned long long size,
+			   u32 aspace, u32 cycle, u32 dwidth)
 {
 	int retval = 0;
 	unsigned int i;
@@ -335,8 +335,8 @@ static int fake_master_set(struct vme_master_resource *image, int enabled,
  * Set the attributes of an outbound window.
  */
 static int __fake_master_get(struct vme_master_resource *image, int *enabled,
-		unsigned long long *vme_base, unsigned long long *size,
-		u32 *aspace, u32 *cycle, u32 *dwidth)
+			     unsigned long long *vme_base, unsigned long long *size,
+			     u32 *aspace, u32 *cycle, u32 *dwidth)
 {
 	unsigned int i;
 	struct fake_driver *bridge;
@@ -356,15 +356,15 @@ static int __fake_master_get(struct vme_master_resource *image, int *enabled,
 }
 
 static int fake_master_get(struct vme_master_resource *image, int *enabled,
-		unsigned long long *vme_base, unsigned long long *size,
-		u32 *aspace, u32 *cycle, u32 *dwidth)
+			   unsigned long long *vme_base, unsigned long long *size,
+			   u32 *aspace, u32 *cycle, u32 *dwidth)
 {
 	int retval;
 
 	spin_lock(&image->lock);
 
 	retval = __fake_master_get(image, enabled, vme_base, size, aspace,
-			cycle, dwidth);
+				   cycle, dwidth);
 
 	spin_unlock(&image->lock);
 
@@ -511,7 +511,7 @@ static noinline_for_stack u32 fake_vmeread32(struct fake_driver *bridge,
 }
 
 static ssize_t fake_master_read(struct vme_master_resource *image, void *buf,
-		size_t count, loff_t offset)
+				size_t count, loff_t offset)
 {
 	int retval;
 	u32 aspace, cycle, dwidth;
@@ -700,7 +700,7 @@ static noinline_for_stack void fake_vmewrite32(struct fake_driver *bridge,
 }
 
 static ssize_t fake_master_write(struct vme_master_resource *image, void *buf,
-		size_t count, loff_t offset)
+				 size_t count, loff_t offset)
 {
 	int retval = 0;
 	u32 aspace, cycle, dwidth;
@@ -739,7 +739,7 @@ static ssize_t fake_master_write(struct vme_master_resource *image, void *buf,
 		if ((addr + done) & 0x2) {
 			if ((count - done) < 2) {
 				fake_vmewrite8(bridge, (u8 *)(buf + done),
-						addr + done, aspace, cycle);
+					       addr + done, aspace, cycle);
 				done += 1;
 				goto out;
 			} else {
@@ -768,7 +768,7 @@ static ssize_t fake_master_write(struct vme_master_resource *image, void *buf,
 		count32 = (count - done);
 		while (done < count32) {
 			fake_vmewrite8(bridge, (u8 *)(buf + done), addr + done,
-					aspace, cycle);
+				       aspace, cycle);
 			done += 1;
 		}
 
@@ -784,7 +784,7 @@ static ssize_t fake_master_write(struct vme_master_resource *image, void *buf,
 
 	if ((count - done) & 0x1) {
 		fake_vmewrite8(bridge, (u8 *)(buf + done), addr + done, aspace,
-				cycle);
+			       cycle);
 		done += 1;
 	}
 
@@ -802,8 +802,8 @@ static ssize_t fake_master_write(struct vme_master_resource *image, void *buf,
  * Requires a previously configured master window, returns final value.
  */
 static unsigned int fake_master_rmw(struct vme_master_resource *image,
-		unsigned int mask, unsigned int compare, unsigned int swap,
-		loff_t offset)
+				    unsigned int mask, unsigned int compare,
+				    unsigned int swap, loff_t offset)
 {
 	u32 tmp, base;
 	u32 aspace, cycle;
@@ -848,7 +848,7 @@ static unsigned int fake_master_rmw(struct vme_master_resource *image,
  * callback is attached and disabled when the last callback is removed.
  */
 static int fake_lm_set(struct vme_lm_resource *lm, unsigned long long lm_base,
-		u32 aspace, u32 cycle)
+		       u32 aspace, u32 cycle)
 {
 	int i;
 	struct vme_bridge *fake_bridge;
@@ -894,7 +894,8 @@ static int fake_lm_set(struct vme_lm_resource *lm, unsigned long long lm_base,
  * or disabled.
  */
 static int fake_lm_get(struct vme_lm_resource *lm,
-		unsigned long long *lm_base, u32 *aspace, u32 *cycle)
+		       unsigned long long *lm_base,
+		       u32 *aspace, u32 *cycle)
 {
 	struct fake_driver *bridge;
 
@@ -917,7 +918,7 @@ static int fake_lm_get(struct vme_lm_resource *lm,
  * Callback will be passed the monitor triggered.
  */
 static int fake_lm_attach(struct vme_lm_resource *lm, int monitor,
-		void (*callback)(void *), void *data)
+			  void (*callback)(void *), void *data)
 {
 	struct vme_bridge *fake_bridge;
 	struct fake_driver *bridge;
@@ -995,7 +996,7 @@ static int fake_slot_get(struct vme_bridge *fake_bridge)
 }
 
 static void *fake_alloc_consistent(struct device *parent, size_t size,
-		dma_addr_t *dma)
+				   dma_addr_t *dma)
 {
 	void *alloc = kmalloc(size, GFP_KERNEL);
 
@@ -1006,7 +1007,7 @@ static void *fake_alloc_consistent(struct device *parent, size_t size,
 }
 
 static void fake_free_consistent(struct device *parent, size_t size,
-		void *vaddr, dma_addr_t dma)
+				 void *vaddr, dma_addr_t dma)
 {
 	kfree(vaddr);
 /*
@@ -1094,7 +1095,7 @@ static int __init fake_init(void)
 	mutex_init(&fake_device->vme_int);
 	mutex_init(&fake_bridge->irq_mtx);
 	tasklet_init(&fake_device->int_tasklet, fake_VIRQ_tasklet,
-			(unsigned long) fake_bridge);
+		     (unsigned long) fake_bridge);
 
 	strcpy(fake_bridge->name, driver_name);
 
@@ -1118,10 +1119,10 @@ static int __init fake_init(void)
 			VME_PROG | VME_DATA;
 		master_image->width_attr = VME_D16 | VME_D32;
 		memset(&master_image->bus_resource, 0,
-				sizeof(struct resource));
+		       sizeof(struct resource));
 		master_image->kern_base  = NULL;
 		list_add_tail(&master_image->list,
-				&fake_bridge->master_resources);
+			      &fake_bridge->master_resources);
 	}
 
 	/* Add slave windows to list */
@@ -1144,7 +1145,7 @@ static int __init fake_init(void)
 			VME_2eSST267 | VME_2eSST320 | VME_SUPER | VME_USER |
 			VME_PROG | VME_DATA;
 		list_add_tail(&slave_image->list,
-				&fake_bridge->slave_resources);
+			      &fake_bridge->slave_resources);
 	}
 
 	/* Add location monitor to list */
@@ -1179,7 +1180,7 @@ static int __init fake_init(void)
 	fake_bridge->free_consistent = fake_free_consistent;
 
 	pr_info("Board is%s the VME system controller\n",
-			(geoid == 1) ? "" : " not");
+		(geoid == 1) ? "" : " not");
 
 	pr_info("VME geographical address is set to %d\n", geoid);
 
@@ -1220,7 +1221,7 @@ static int __init fake_init(void)
 	/* resources are stored in link list */
 	list_for_each_safe(pos, n, &fake_bridge->master_resources) {
 		master_image = list_entry(pos, struct vme_master_resource,
-				list);
+					  list);
 		list_del(pos);
 		kfree(master_image);
 	}
@@ -1275,7 +1276,7 @@ static void __exit fake_exit(void)
 	/* resources are stored in link list */
 	list_for_each_safe(pos, tmplist, &fake_bridge->master_resources) {
 		master_image = list_entry(pos, struct vme_master_resource,
-				list);
+					  list);
 		list_del(pos);
 		kfree(master_image);
 	}
-- 
2.41.0

