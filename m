Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD2C7F22A0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 01:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjKUA4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 19:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjKUA4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 19:56:05 -0500
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03C6C1;
        Mon, 20 Nov 2023 16:56:01 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VwqOChu_1700528158;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VwqOChu_1700528158)
          by smtp.aliyun-inc.com;
          Tue, 21 Nov 2023 08:55:59 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
        markgross@kernel.org, vadimp@nvidia.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] platform/mellanox: Simplify bool conversion
Date:   Tue, 21 Nov 2023 08:55:57 +0800
Message-Id: <20231121005557.69324-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./drivers/platform/mellanox/mlxbf-tmfifo.c:94:41-46: WARNING: conversion to bool not needed here

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7584
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/platform/mellanox/mlxbf-tmfifo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index 5c683b4eaf10..8ba23eb5be0b 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -91,7 +91,7 @@ struct mlxbf_tmfifo_vring {
 /* Check whether vring is in drop mode. */
 #define IS_VRING_DROP(_r) ({ \
 	typeof(_r) (r) = (_r); \
-	(r->desc_head == &r->drop_desc ? true : false); })
+	(r->desc_head == &r->drop_desc); })
 
 /* A stub length to drop maximum length packet. */
 #define VRING_DROP_DESC_MAX_LEN		GENMASK(15, 0)
-- 
2.20.1.7.g153144c

