Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB74276B983
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 18:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjHAQRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 12:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjHAQRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:17:16 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF801AA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 09:17:14 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6bcb15aa074so589557a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 09:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690906634; x=1691511434;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IluS0dN33fbcySvCi1VkJafmlujO6rxWmw3dx0Lv8F0=;
        b=V0CKP1Jdw5SNvLd4IvWun4OMWggcyahW6Fy0lLkk6sGSij/cuH2cleoG/+wZtjykJm
         Yv1HpcFskBeNvlhCzWMn86CZQtITl2igcjZGY35ryAMRDKsrMqeSlbAedIAmKhF7r1+B
         k3pAmwAh2opaRbOA/qqLkULkeZq12ISQq4Ia9Xi52KhYg8Rt8bv8+URoLQV96B1gyXbh
         6upqMGhBqBenB2YmwbATlnGxhmT/M3y60iSAD58HdTtzXmVo/hVIo0/n2Xidov6riQvo
         5D9+v/yh6ObEgGrYhjMVTS+E+iiXP8HIBMaXaR8YGKPg7pM5lRdME6pHLLRTobymaa9m
         4l7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690906634; x=1691511434;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IluS0dN33fbcySvCi1VkJafmlujO6rxWmw3dx0Lv8F0=;
        b=ha3cVp4tI//jh9w1zA21DkvBO4pHWN9ayVoci6SM3MF9aV0wi2twui8Aj7dij5kwgV
         UENT32XUpXYfmwVxE8Dm1BHXMM9srF4wD8Yvln1BqPAGxb5rAk2xvh/ojz0Ch3xisF0X
         6/K0HnvrTkXZY2H3BFRqRiPQwDX/YUZCT5XleUkhqELf3Kpooabybs9zfvqe2gX5hC9y
         Pwb/7OPnc/6Q7Js/BYbamfYNxmK2SLqxFRkWbTpmesmA4/ktqq7sXrIrK//xd7Ni3YRC
         Tx1qISHtYocAke3uK1NcpVpz2VS5k9v+IdNc+4sKTsbqIubVGjUd/H2QMcGnjpo2Xtuh
         ixRw==
X-Gm-Message-State: ABy/qLb7KkOtSZFY5CWGUqCGX8ZQtWU+dwSbNTK9ImCZ8BJCC6x6T8H5
        M+o6G+TCguG4bKVjDR1u2Zk=
X-Google-Smtp-Source: APBJJlHi0OSFDBu0zCNP4lp/yVzVtEou4lj1Rv1dDNKXV63YvhPn4yKUNI91+1p1QPMjRCZXzKDiUA==
X-Received: by 2002:a9d:664e:0:b0:6b7:564d:f368 with SMTP id q14-20020a9d664e000000b006b7564df368mr10498970otm.5.1690906633599;
        Tue, 01 Aug 2023 09:17:13 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:86d6:7871:f7e9:8a15:865a])
        by smtp.gmail.com with ESMTPSA id v15-20020a9d69cf000000b006b753685cc5sm5145636oto.79.2023.08.01.09.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 09:17:12 -0700 (PDT)
Date:   Tue, 1 Aug 2023 13:17:07 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        dan.carpenter@linaro.org
Subject: [PATCH v2] staging: vme_user: fix check alignment should match open
 parenthesis
Message-ID: <ZMkwA8TnMBAgPRgR@alolivei-thinkpadt480s.gru.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First patch was intended to fix all "CHECK: Alignment should match open parenthesis",
but added new warnings in the process. This patch is intended to fixed them all,
on lines 133, 142, 144, 145 and 173.

Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>

---

Changes in v2:
- Fixed 3 different line lengths exceeding 100 columns, noted by Greg KH and Dan Carpenter
- Fixed 1 line with alignment matching open parenthesis
- Fixed 1 line to not end with a '('

Changes in v1:
- Fixed 11 different lines with alignment matching open parenthesis

 drivers/staging/vme_user/vme_bridge.h | 46 +++++++++++----------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/vme_user/vme_bridge.h b/drivers/staging/vme_user/vme_bridge.h
index 11df0a5e7f7b..9bdc41bb6602 100644
--- a/drivers/staging/vme_user/vme_bridge.h
+++ b/drivers/staging/vme_user/vme_bridge.h
@@ -128,28 +128,24 @@ struct vme_bridge {
 	struct mutex irq_mtx;
 
 	/* Slave Functions */
-	int (*slave_get)(struct vme_slave_resource *, int *,
-		unsigned long long *, unsigned long long *, dma_addr_t *,
-		u32 *, u32 *);
+	int (*slave_get)(struct vme_slave_resource *, int *, unsigned long long *,
+			 unsigned long long *, dma_addr_t *, u32 *, u32 *);
 	int (*slave_set)(struct vme_slave_resource *, int, unsigned long long,
-		unsigned long long, dma_addr_t, u32, u32);
+			 unsigned long long, dma_addr_t, u32, u32);
 
 	/* Master Functions */
-	int (*master_get)(struct vme_master_resource *, int *,
-		unsigned long long *, unsigned long long *, u32 *, u32 *,
-		u32 *);
-	int (*master_set)(struct vme_master_resource *, int,
-		unsigned long long, unsigned long long,  u32, u32, u32);
-	ssize_t (*master_read)(struct vme_master_resource *, void *, size_t,
-		loff_t);
-	ssize_t (*master_write)(struct vme_master_resource *, void *, size_t,
-		loff_t);
+	int (*master_get)(struct vme_master_resource *, int *, unsigned long long *,
+			  unsigned long long *, u32 *, u32 *, u32 *);
+	int (*master_set)(struct vme_master_resource *, int, unsigned long long,
+			  unsigned long long,  u32, u32, u32);
+	ssize_t (*master_read)(struct vme_master_resource *, void *, size_t, loff_t);
+	ssize_t (*master_write)(struct vme_master_resource *, void *, size_t, loff_t);
 	unsigned int (*master_rmw)(struct vme_master_resource *, unsigned int,
-		unsigned int, unsigned int, loff_t);
+				   unsigned int, unsigned int, loff_t);
 
 	/* DMA Functions */
 	int (*dma_list_add)(struct vme_dma_list *, struct vme_dma_attr *,
-		struct vme_dma_attr *, size_t);
+			    struct vme_dma_attr *, size_t);
 	int (*dma_list_exec)(struct vme_dma_list *);
 	int (*dma_list_empty)(struct vme_dma_list *);
 
@@ -159,32 +155,26 @@ struct vme_bridge {
 
 	/* Location monitor functions */
 	int (*lm_set)(struct vme_lm_resource *, unsigned long long, u32, u32);
-	int (*lm_get)(struct vme_lm_resource *, unsigned long long *, u32 *,
-		u32 *);
-	int (*lm_attach)(struct vme_lm_resource *, int,
-			 void (*callback)(void *), void *);
+	int (*lm_get)(struct vme_lm_resource *, unsigned long long *, u32 *, u32 *);
+	int (*lm_attach)(struct vme_lm_resource *, int, void (*callback)(void *), void *);
 	int (*lm_detach)(struct vme_lm_resource *, int);
 
 	/* CR/CSR space functions */
 	int (*slot_get)(struct vme_bridge *);
 
 	/* Bridge parent interface */
-	void *(*alloc_consistent)(struct device *dev, size_t size,
-		dma_addr_t *dma);
-	void (*free_consistent)(struct device *dev, size_t size,
-		void *vaddr, dma_addr_t dma);
+	void *(*alloc_consistent)(struct device *dev, size_t size, dma_addr_t *dma);
+	void (*free_consistent)(struct device *dev, size_t size, void *vaddr, dma_addr_t dma);
 };
 
-void vme_bus_error_handler(struct vme_bridge *bridge,
-			   unsigned long long address, int am);
+void vme_bus_error_handler(struct vme_bridge *bridge, unsigned long long address, int am);
 void vme_irq_handler(struct vme_bridge *, int, int);
 
 struct vme_bridge *vme_init_bridge(struct vme_bridge *);
 int vme_register_bridge(struct vme_bridge *);
 void vme_unregister_bridge(struct vme_bridge *);
-struct vme_error_handler *vme_register_error_handler(
-	struct vme_bridge *bridge, u32 aspace,
-	unsigned long long address, size_t len);
+struct vme_error_handler *vme_register_error_handler(struct vme_bridge *bridge, u32 aspace,
+						     unsigned long long address, size_t len);
 void vme_unregister_error_handler(struct vme_error_handler *handler);
 
 #endif /* _VME_BRIDGE_H_ */
-- 
2.41.0
