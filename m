Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7153878E13C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240863AbjH3VMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240757AbjH3VME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:12:04 -0400
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25B95185
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:11:27 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id bRtwq9Cq9LJHlbRtxqZvkj; Wed, 30 Aug 2023 22:34:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693427699;
        bh=ukX6nIzTyaosUbrTkIXJsNBtFe8mTALHzfMVVvM42bc=;
        h=From:To:Cc:Subject:Date;
        b=tU2kvuBiW/eMCF/tn/6aangRq7DihAInl+uRWuVrVN6dJggGpARY3DvpgCM+yCtwC
         vba8qjDthJoeGKkNKxh2tlEhFKVIaUzW0irEWjA8IVUcbY7Ln89PQxzCpc/nfLmjBf
         uHcaOo78+807a8dM9rj7uHizW915ThG0BjY1bGnjpU4V6mOxJX514C92zu58N/tQY9
         EqXgPtDLws83Lku51aBt9/uwLU4/RSxBLH7E2YeSL1ZSbjQ6p+hCYPVEcqsX5XICmS
         5SPxqwmXJ0kKeMDrGHrYbBwlGWn428Ekau1G7pcupynJVG938rH9aweYLbIhmLfUP2
         eqH7LVw/cOn3g==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 30 Aug 2023 22:34:59 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        linux-media@vger.kernel.org
Subject: [PATCH v2] media: i2c: rdacm21: Remove an incorrect fwnode_handle_put() call
Date:   Wed, 30 Aug 2023 22:34:51 +0200
Message-Id: <d9230082a1f5b7bab6363c51408508ec5ab6acfc.1693037086.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit in Fixes has removed an fwnode_handle_put() call in the error
handling path of the probe.

Remove the same call from the remove function.

Fixes: 1029939b3782 ("media: v4l: async: Simplify async sub-device fwnode matching")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
v2: s/rdacm2/rdacm21/ in the subject    [Laurent Pinchart]
    Add R-b tags

v1:
   https://lore.kernel.org/all/d9230082aefcb7bab6363c51c08598eb5ab62cfc.1693037086.git.christophe.jaillet@wanadoo.fr/
---
 drivers/media/i2c/rdacm21.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/i2c/rdacm21.c b/drivers/media/i2c/rdacm21.c
index a36a709243fd..3e22df36354f 100644
--- a/drivers/media/i2c/rdacm21.c
+++ b/drivers/media/i2c/rdacm21.c
@@ -608,7 +608,6 @@ static void rdacm21_remove(struct i2c_client *client)
 	v4l2_async_unregister_subdev(&dev->sd);
 	v4l2_ctrl_handler_free(&dev->ctrls);
 	i2c_unregister_device(dev->isp);
-	fwnode_handle_put(dev->sd.fwnode);
 }
 
 static const struct of_device_id rdacm21_of_ids[] = {
-- 
2.34.1

