Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9E6770320
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjHDObA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjHDOa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:30:58 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B63849C3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 07:30:57 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6bca66e6c44so1860519a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 07:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691159456; x=1691764256;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tMe8d3F6FgsgCf4Bb6DRaJcRuzNRE/O7YwXPUR0KzAo=;
        b=YDNcv3+yaBOYkfxaSRUnLkv3S+RgbJiU33nJ+hBhv5C/ZE0T2XR/bhMF5SCLyZqz0r
         I2dyCDekJzl+ySjqgBF8167X1bEm5OgYyGaOt96XWqQlHvs4MUBYZ6UUlTaX3v/HcfZC
         xAxAd46ZV/PFcYjChf/euh0kV4xCrccHrhkTs5pmh+lP8kd7ST5+HV7gSIcO7n5kdcOk
         kuGPR5KPm+sFUj+RZgR1zmvPujglTwy1OQvagxEQwcqXT5+jBYrR6TskcEFmVCxDC+V0
         I/KWeqCTbdxOM7MT0X3zNywOxY794t0kVTskXz9XC/hwIw94pF8RoCm3ylqyKlqnMAgX
         dIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691159456; x=1691764256;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tMe8d3F6FgsgCf4Bb6DRaJcRuzNRE/O7YwXPUR0KzAo=;
        b=Z4TrzCttnCI6H/xQirklVHgA0Q7IH3dmPkfxFGEHPBbxWsFFS6AbavbRxGzH6OIrEM
         jfqz2I4VTsKFSvjxOQn3NFmdOztKOiaRi2h3Pw3Q5FyjAgFCl07Ue5YmO36cTXQRe2NM
         nPDBVIpqZU0VLIPuhPXNy1iIQZ8JUna5zVSAgv+ymzTE4B3VG/ZaYDHsYx1AaP5RS7cJ
         zRSfHLa2KCLFXOc7BnMBqTjBIex67suWes43Ru63591ElmQYOK1dToQper2BLRJsjNoX
         IWbXhWsbSKmn4gPjuyneJuEkT5I5Ya89ICfS47D78bGeaiSl5Do+TsXP80Y06E71i+5D
         qE0A==
X-Gm-Message-State: AOJu0YxiexevjOvs484KI8BcqzXsD0XrNNdwQOu6chT9CsK9mZEkwCxk
        1hzOMquY+BID3MrgHbgQSAY=
X-Google-Smtp-Source: AGHT+IFaAxfUYqGVXNTTOdNKZFSQzxTLwfpy41cblopH5umQrQmVXSyb0AVbu5XdQQLGZ3EOyfWX8g==
X-Received: by 2002:a05:6830:154:b0:6b8:7e53:e7c3 with SMTP id j20-20020a056830015400b006b87e53e7c3mr1799177otp.31.1691159456070;
        Fri, 04 Aug 2023 07:30:56 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:86d6:7871:f7e9:8a15:865a])
        by smtp.gmail.com with ESMTPSA id c18-20020a9d6852000000b006b8a2cd44adsm1146015oto.72.2023.08.04.07.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 07:30:55 -0700 (PDT)
Date:   Fri, 4 Aug 2023 11:30:50 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        dan.carpenter@linaro.org
Subject: [PATCH v3] staging: vme_user: fix check alignment should match open
 parenthesis
Message-ID: <ZM0Lmt5Dp/k6iO21@alolivei-thinkpadt480s.gru.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed the following as reported by checkpatch to adhere to the
Linux kernel coding-style guidelines.

Changes in v3:
- Fixed changelog

Changes in v2:
- Fixed CHECK: line length exceeds 100 columns, noted by Greg KH and Dan Carpenter
- Fixed CHECK: Alignment should match open parenthesis
- Fixed CHECK: Lines should not end with a '('

Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
---
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

