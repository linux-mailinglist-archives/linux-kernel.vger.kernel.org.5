Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A03C7A0BA0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238882AbjINRZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjINRZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:25:08 -0400
Received: from kozue.soulik.info (kozue.soulik.info [IPv6:2001:19f0:7000:8404:5400:ff:fe00:d7d6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC754685;
        Thu, 14 Sep 2023 10:23:55 -0700 (PDT)
Received: from ritsuko.sh.sumomo.pri (unknown [10.0.12.132])
        by kozue.soulik.info (Postfix) with ESMTPSA id 79D153001F1;
        Fri, 15 Sep 2023 02:23:42 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 kozue.soulik.info 79D153001F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soulik.info; s=mail;
        t=1694712223; bh=91ZYByAiQ0k1Ldqa97fT7yCCM4KmbxhRMMYPhoLTlgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QaeQ31BUa3hgH9EqcJMVDjhMF1p7mUjW6+gnxALzHwkStegEc0enCTVwcrlINIrl7
         Nh0Eu0JvYi31Min0bJqQV6Crg0PsWN4bGY4FwaA7gOZpKpE93nVSH/mgjdFGhm6P32
         ftSEVc2kUbJCE9XBJghXLYtCiZ2PnmgxH7iMdAps=
From:   Randy Li <ayaka@soulik.info>
To:     linux-usb@vger.kernel.org
Cc:     Randy Li <ayaka@soulik.info>, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: [PATCH 1/2] USB: dma: remove unused function prototype
Date:   Fri, 15 Sep 2023 01:23:23 +0800
Message-ID: <20230914172336.18761-2-ayaka@soulik.info>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914172336.18761-1-ayaka@soulik.info>
References: <20230914172336.18761-1-ayaka@soulik.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb_buffer_map_sg() and usb_buffer_unmap_sg() have no definition
since the beginning of v5.4. The rest are gone from 2.6.12.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 include/linux/usb.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/include/linux/usb.h b/include/linux/usb.h
index a21074861f91..8c61643acd49 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1823,22 +1823,6 @@ void *usb_alloc_coherent(struct usb_device *dev, size_t size,
 void usb_free_coherent(struct usb_device *dev, size_t size,
 	void *addr, dma_addr_t dma);
 
-#if 0
-struct urb *usb_buffer_map(struct urb *urb);
-void usb_buffer_dmasync(struct urb *urb);
-void usb_buffer_unmap(struct urb *urb);
-#endif
-
-struct scatterlist;
-int usb_buffer_map_sg(const struct usb_device *dev, int is_in,
-		      struct scatterlist *sg, int nents);
-#if 0
-void usb_buffer_dmasync_sg(const struct usb_device *dev, int is_in,
-			   struct scatterlist *sg, int n_hw_ents);
-#endif
-void usb_buffer_unmap_sg(const struct usb_device *dev, int is_in,
-			 struct scatterlist *sg, int n_hw_ents);
-
 /*-------------------------------------------------------------------*
  *                         SYNCHRONOUS CALL SUPPORT                  *
  *-------------------------------------------------------------------*/
-- 
2.41.0

