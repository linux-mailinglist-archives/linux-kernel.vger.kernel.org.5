Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF47786501
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 04:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239210AbjHXCAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 22:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239272AbjHXB74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 21:59:56 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id AA321E59
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 18:59:51 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 86CE260A9B5A7;
        Thu, 24 Aug 2023 09:59:36 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Li kunyu <kunyu@nfschina.com>
To:     dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        vishal.l.verma@intel.com, pasha.tatashin@soleen.com,
        dave.jiang@intel.com, ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] resource: Remove unnecessary initial values of variables
Date:   Sat, 26 Aug 2023 02:30:56 +0800
Message-Id: <20230825183056.6688-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_24_48,
        RCVD_IN_SBL_CSS,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These variables are first assigned values and do not need to be
initialized for assignment.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 kernel/resource.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index b1763b2fd7ef..bbd7c113307a 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -656,7 +656,7 @@ static int reallocate_resource(struct resource *root, struct resource *old,
 			       resource_size_t newsize,
 			       struct resource_constraint *constraint)
 {
-	int err=0;
+	int err;
 	struct resource new = *old;
 	struct resource *conflict;
 
@@ -1310,7 +1310,7 @@ EXPORT_SYMBOL(__release_region);
 void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
 {
 	struct resource *parent = &iomem_resource;
-	struct resource *new_res = NULL;
+	struct resource *new_res;
 	bool alloc_nofail = false;
 	struct resource **p;
 	struct resource *res;
@@ -1556,7 +1556,7 @@ struct resource *
 __devm_request_region(struct device *dev, struct resource *parent,
 		      resource_size_t start, resource_size_t n, const char *name)
 {
-	struct region_devres *dr = NULL;
+	struct region_devres *dr;
 	struct resource *res;
 
 	dr = devres_alloc(devm_region_release, sizeof(struct region_devres),
-- 
2.18.2

