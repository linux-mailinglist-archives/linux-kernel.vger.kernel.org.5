Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8255E773FA2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbjHHQug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbjHHQt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:49:27 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA544AABB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:57:29 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686f090310dso5784660b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691510214; x=1692115014;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sVJ0p0WaC8Bx3ZnF3RkzwD7YcCGFMibfiG+VoV03ROc=;
        b=Ij24N04tJQiR+F9CDlqTQWU4GvQtMXeGZKd3oHit3Re+tLP+WAkIInILesQJSjXgp3
         msWdYpzrYOoOXcqL+qBKEV47dtqwW3Z6IypFa+T7yqand4CD9xY2rTgRiFRHLH7ZKEMY
         0QCYQkeUXEW4LptffZAPoxfQ6rqUp3r1oqRBEkIuVuIVrX32tcU9QlVfG4bXArdrnls2
         YXfX0dr2QKdlVJAZmKBfIQ0h0Rzli6kdzzF4TF7Z4z8/STZvr7XEKijUgQEG+IQzbsBd
         M8JxfVSB6Ev/F9DP9fF4dBv94s6/oB1gD3RXb46P7zXcCpycWUlCF2/6J9/ra6lBkETe
         MEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510214; x=1692115014;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sVJ0p0WaC8Bx3ZnF3RkzwD7YcCGFMibfiG+VoV03ROc=;
        b=hjh1TXYYhH5xJj/GPEYYzVIi0AcZ4X/bINAWtdtmJ0RoXuG+lsmX4koBf17SA4AaIA
         nirPK4tHUgDXV3DfKMieX+y7KO8kbxLhkbUusj1SmXbXcQOdB0JPWYv448GWU++yUpSq
         xiIv03cwWOSY66cSV5Ty9Fp7U1AoGNIk0mxtj0k9GMtunZr/7BnMu9s+OEQinXbaQnOJ
         ONNpCuu4mKAEMiF7HuVxpLlLv8mS5CAQGEzFkUXxvJoF299rB84WnmwUyhYXeuC94p1i
         TuS1PWvRZGd0PdVsGLHlgfYnpsDi4AvDxsDscnsP9PCcU53Ed37+h9hxRMbgPCRbcYqh
         5fGA==
X-Gm-Message-State: AOJu0YwSYTEN6KQobpmy0U0pkN1C+GbJ2DZKXMevDhDDNZB6LKYQrWw8
        avBmoqzDPL3yxgRGoPJ8WqYEGaobWS0=
X-Google-Smtp-Source: AGHT+IFzjfgPVAMDP/IlnyhvMVGjufQyfLVhLezbz0C9N3wFwCNGl/Q+UyVhyvKUu5mXkp/cCiQSbQ==
X-Received: by 2002:a05:6870:3911:b0:1b0:3d61:553e with SMTP id b17-20020a056870391100b001b03d61553emr14068619oap.15.1691503185589;
        Tue, 08 Aug 2023 06:59:45 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:86d6:7871:f7e9:8a15:865a])
        by smtp.gmail.com with ESMTPSA id tp11-20020a0568718b8b00b001bec2a8f4e3sm6074614oab.14.2023.08.08.06.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 06:59:45 -0700 (PDT)
Date:   Tue, 8 Aug 2023 10:59:40 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v3] staging: vme_user: fix alignment of open parenthesis and
 deleted trailing spaces
Message-ID: <ZNJKTLZ62SZMM6D8@alolivei-thinkpadt480s.gru.csb>
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
and deleted the trailing whitespaces as reported by
checkpatch to adhere to the Linux kernel coding-style
guidelines.

Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
---

Changes in v3:
- Rebased against staging.git and staging-next branch, noted by Greg KH

Changes in v2:
- Fixed changelog, noted by Greg KH

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

