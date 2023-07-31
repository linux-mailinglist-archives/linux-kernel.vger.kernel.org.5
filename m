Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51982769380
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjGaKuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjGaKtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:49:45 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C207F1FCD;
        Mon, 31 Jul 2023 03:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1690800559; bh=3+BgMlB03WtnMLfki2nDy1etZeSatZZUYt6mWNVYlCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gC+VPfdJR+ufKkXjg9/PMhOWEvELvTAgt7t8g+A2vsAdWeWVzlSsKnhgWay+6qmEi
         On6Drif3RAfaTYZ26j7Fjux4zbratEliiPJXbMIeM+Vw0+2qtKLXuCMvVUU71I4pjl
         853sXnp44KPFEPg2myqZTIsAxYScwsOk1KJgLLA8=
Received: from ld50.lan (unknown [101.88.28.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 72DBF6017D;
        Mon, 31 Jul 2023 18:49:19 +0800 (CST)
From:   WANG Xuerui <kernel@xen0n.name>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Subject: [PATCH 1/5] raid6: remove the <linux/export.h> include from recov.c
Date:   Mon, 31 Jul 2023 18:49:07 +0800
Message-Id: <20230731104911.411964-2-kernel@xen0n.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230731104911.411964-1-kernel@xen0n.name>
References: <20230731104911.411964-1-kernel@xen0n.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WANG Xuerui <git@xen0n.name>

There is no exported symbol left in recov.c, so the include is now
unnecessary, and breaks the raid6test build. Remove it.

Signed-off-by: WANG Xuerui <git@xen0n.name>
---
 lib/raid6/recov.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/raid6/recov.c b/lib/raid6/recov.c
index e49d519de6cbe..a7c1b2bbe40d8 100644
--- a/lib/raid6/recov.c
+++ b/lib/raid6/recov.c
@@ -13,7 +13,6 @@
  * the syndrome.)
  */
 
-#include <linux/export.h>
 #include <linux/raid/pq.h>
 
 /* Recover two failed data blocks. */
-- 
2.40.0

