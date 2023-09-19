Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057377A5887
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 06:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjISEtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 00:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjISEtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 00:49:18 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 2EE14FD;
        Mon, 18 Sep 2023 21:49:11 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 3597D602F96E2;
        Tue, 19 Sep 2023 12:49:09 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Wu Yunchuan <yunchuan@nfschina.com>
To:     kvalo@kernel.org
Cc:     syoshida@redhat.com, johannes.berg@intel.com,
        alexander@wetzel-home.de, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wu Yunchuan <yunchuan@nfschina.com>
Subject: [PATCH v2 wireless-next 1/9] wifi: ar5523: Remove unnecessary (void*) conversions
Date:   Tue, 19 Sep 2023 12:49:06 +0800
Message-Id: <20230919044906.523189-1-yunchuan@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need cast (void*) to (struct ar5523_cmd_hdr *).

Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
---
 drivers/net/wireless/ath/ar5523/ar5523.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ar5523/ar5523.c b/drivers/net/wireless/ath/ar5523/ar5523.c
index 19f61225a708..43e0db78d42b 100644
--- a/drivers/net/wireless/ath/ar5523/ar5523.c
+++ b/drivers/net/wireless/ath/ar5523/ar5523.c
@@ -256,7 +256,7 @@ static int ar5523_cmd(struct ar5523 *ar, u32 code, const void *idata,
 	/* always bulk-out a multiple of 4 bytes */
 	xferlen = (sizeof(struct ar5523_cmd_hdr) + ilen + 3) & ~3;
 
-	hdr = (struct ar5523_cmd_hdr *)cmd->buf_tx;
+	hdr = cmd->buf_tx;
 	memset(hdr, 0, sizeof(struct ar5523_cmd_hdr));
 	hdr->len  = cpu_to_be32(xferlen);
 	hdr->code = cpu_to_be32(code);
-- 
2.30.2

