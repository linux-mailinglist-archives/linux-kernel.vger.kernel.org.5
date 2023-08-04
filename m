Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E760F770AB9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjHDVVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHDVU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:20:59 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13835B1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 14:20:56 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-76ad8892d49so210203185a.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 14:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691184055; x=1691788855;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R+n0XwgRUCBYf2v/4RICLfZrVX06sOWFrOWSc1o23EY=;
        b=LMuRxuzPH6t80/VZd9NGC4a+uw8L0mEuI1TdIF8O6lJgpM01c9O8WtXCsxclOw3795
         w8Dc2yworB6vfvSqAva+kWk8zgQ+Dmflk6SbZZRAW8QfBW91THGXvpEcHuVGOy53qIvs
         BSAWCY1EySMrAg8jbdtP6JhYudlh+NHqE6vQtaCf49jPv2/eTQltk8jHKBuc3QqAtLQU
         Sj6mA1jDOog3TWR28TPcEOP1gsj9lMOitNNTW+8zAsZm3a4Y+xOJ2nvQ5vsOk2WWceIk
         IBFNV6G0g97drLGBtyiQZ/clCs0/XU/8MVifGGKoyQHuSP+RDMLKfeY7C6aQ5l+bYg6n
         AVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691184055; x=1691788855;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+n0XwgRUCBYf2v/4RICLfZrVX06sOWFrOWSc1o23EY=;
        b=MrwK/BARcKkPdQ9kG27SX5JQG95MH7VHQ7zFkOOHKkYWRrYmp7KykxO9EE0Ck3B2f5
         /kaVZ13JV1sF240PwR0M8AIc/VPs6srfX7g9VLj/HsZIFuDjwLGQGJv5XPPPvuF0zDlu
         V9CAWx+ZQ9GzWG//gwi8k4LNF3EEVcgorGi4H6gk/TBmjB2kACb/1s736ECh6zSJ0NFz
         rq6wX+7RTEavGPIvLPzhCDMDK3xWBTnsg3Dux1eo6Y0+5yrhtrnpILsaLrUTBe8eeFS4
         SwPIVmVp0tJA9SoGcblBSQh+LvLI9MtyeXiPs07Zdgf8Xpl1KdbcguHs9rxTDZx9qXrW
         OPJA==
X-Gm-Message-State: AOJu0YyAn1roeP8pHzD5ygffJJSLKziLtAYAK81bHyN3YQI6JxLWBgN1
        6s373FuBRkRO1LwswBm5bPoE3uOcM+Q=
X-Google-Smtp-Source: AGHT+IFzdt4urw+AVt2ALCVaR7x99vA6RibBcMvQ1ydqWcFDBWwXKKz1rpuqpW0MQNQysN9TLB+f1g==
X-Received: by 2002:a05:620a:2807:b0:767:6fd:4c1 with SMTP id f7-20020a05620a280700b0076706fd04c1mr3442749qkp.77.1691184054885;
        Fri, 04 Aug 2023 14:20:54 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:86d6:7871:f7e9:8a15:865a])
        by smtp.gmail.com with ESMTPSA id l8-20020a37f508000000b00767cf270628sm905884qkk.131.2023.08.04.14.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 14:20:54 -0700 (PDT)
Date:   Fri, 4 Aug 2023 18:20:50 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH] staging: vme_user: fix check alignment should match open
 parenthesis
Message-ID: <ZM1rsu0M22HHtjfl@alolivei-thinkpadt480s.gru.csb>
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

Fixed all CHECK: Alignment should match open parenthesis
as reported by checkpatch to adhere to the Linux kernel
coding-style guidelines.

Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
---
 drivers/staging/vme_user/vme.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index 977c81e2f3c7..741593d75a63 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -563,7 +563,7 @@ EXPORT_SYMBOL(vme_master_request);
  *         returned.
  */
 int vme_master_set(struct vme_resource *resource, int enabled,
-		   unsigned long long vme_base, unsigned long long size, 
+		   unsigned long long vme_base, unsigned long long size,
 		   u32 aspace, u32 cycle, u32 dwidth)
 {
 	struct vme_bridge *bridge = find_bridge(resource);
@@ -614,7 +614,7 @@ EXPORT_SYMBOL(vme_master_set);
  *         device or if an invalid resource has been provided.
  */
 int vme_master_get(struct vme_resource *resource, int *enabled,
-		   unsigned long long *vme_base, unsigned long long *size, 
+		   unsigned long long *vme_base, unsigned long long *size,
 		   u32 *aspace, u32 *cycle, u32 *dwidth)
 {
 	struct vme_bridge *bridge = find_bridge(resource);
@@ -1045,7 +1045,7 @@ EXPORT_SYMBOL(vme_dma_pci_attribute);
  * Return: Pointer to VME DMA attribute, NULL on failure.
  */
 struct vme_dma_attr *vme_dma_vme_attribute(unsigned long long address,
-					   u32 aspace, u32 cycle, 
+					   u32 aspace, u32 cycle,
 					   u32 dwidth)
 {
 	struct vme_dma_attr *attributes;
@@ -1841,7 +1841,7 @@ EXPORT_SYMBOL(vme_unregister_bridge);
 /* - Driver Registration --------------------------------------------------- */
 
 static int __vme_register_driver_bus(struct vme_driver *drv,
-				     struct vme_bridge *bridge, 
+				     struct vme_bridge *bridge,
 				     unsigned int ndevs)
 {
 	int err;
-- 
2.41.0

