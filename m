Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF48E777A77
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbjHJOWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbjHJOV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:21:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A9A26A9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 07:21:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56C4365D8A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD33C433C7;
        Thu, 10 Aug 2023 14:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691677315;
        bh=NTZhJvX8Fa33MdPPJUJFrTri4+p2YZpKQVbTmgUMKFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cqgKhGl2DoUwkrH27k0CfFHk4cjsMWCn+krIYRRadLbq/26dDO7M63XU2OA6RddWv
         dgIEDaGkr6CDt72ElTPqXoJmXpAzgguxwGmQcd5u+eXPiPrL0cRnTikIRskZp2XvBc
         qTC7ATNWHQdPUOVM8mxtsTB9A0G5Fan2dsnq1Ka109cwdlI1qNdKtZupKFKxnIX2Jb
         /ig+h6oo/9A1LKlxYouXUcTmsuAYmoLl/W1cxZBwBiWDSBWEqEYazRTK3Pp+zOHoi+
         UPC4NKD8NVlpxXQu/Ksklwbi1HCt/mESFyGS970fgg4jU7F3MYgbxidp3qiaT43kji
         WgekgZXFjYdeA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 06/17] macintosh/ams: mark ams_init() static
Date:   Thu, 10 Aug 2023 16:19:24 +0200
Message-Id: <20230810141947.1236730-7-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810141947.1236730-1-arnd@kernel.org>
References: <20230810141947.1236730-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This is the module init function, which by definition is used only
locally, so mark it static to avoid a warning:

drivers/macintosh/ams/ams-core.c:179:12: error: no previous prototype for 'ams_init' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/macintosh/ams/ams-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/ams/ams-core.c b/drivers/macintosh/ams/ams-core.c
index 877e8cb231283..c978b4272daa5 100644
--- a/drivers/macintosh/ams/ams-core.c
+++ b/drivers/macintosh/ams/ams-core.c
@@ -176,7 +176,7 @@ int ams_sensor_attach(void)
 	return result;
 }
 
-int __init ams_init(void)
+static int __init ams_init(void)
 {
 	struct device_node *np;
 
-- 
2.39.2

