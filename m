Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FC379F94B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 06:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbjINEEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 00:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbjINEEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 00:04:41 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 6DF3CE4B;
        Wed, 13 Sep 2023 21:04:36 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 8D438606080EF;
        Thu, 14 Sep 2023 12:04:32 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Wu Yunchuan <yunchuan@nfschina.com>
To:     kvalo@kernel.org
Cc:     syoshida@redhat.com, alexander@wetzel-home.de,
        johannes.berg@intel.com, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wu Yunchuan <yunchuan@nfschina.com>
Subject: [PATCH wireless-next 1/9] wifi: ar5523: Remove unnecessary (void*) conversions
Date:   Thu, 14 Sep 2023 12:04:26 +0800
Message-Id: <20230914040425.1169493-1-yunchuan@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

