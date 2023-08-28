Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E5578B972
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 22:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbjH1UQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 16:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbjH1UQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:16:23 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D4DCD6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 13:16:13 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RZMJW3cjyzB9;
        Mon, 28 Aug 2023 22:16:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1693253771; bh=mwOWvF12GF0G7BcNUGh8h35T4zy8C0iCrFwkHHYf1/c=;
        h=Date:Subject:From:To:Cc:From;
        b=iDXZ1NMKlsEjJZSlj2Tb0i7FbquWmLUN/W/l+TsUtSrirndWdJyq5yNoVg5GEMu6v
         GyAP/csl9RqgREgUf+rzXM3eWDXaHl/Irlg+M/YHP2vt3OWJ0gNzTJ6XVXXMIXn3nS
         YycxLkJM3Thzzlp7O5oaRMnvrNzfglpYLGAsrwYq1dCRj4SvHMUproVhMUj+/7cieU
         r9m+wkSQDs7oCiw48rBRu2kZNc6R2h1teuqgmoyILsWMnzOAKVWZf/LZJZS/aYP4qo
         h4gC5bniEuWAFrv64Vnkvfgw16YPtitBxJeSG2eYPkZNOxMEdiu510kbjYQoEjNDva
         HDmuWMIs6Yi8Q==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Mon, 28 Aug 2023 22:16:11 +0200
Message-Id: <b73fe4bc4bd6ba1af90940a640ed65fe254c0408.1693253717.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2] mfd: core: Un-constify mfd_cell.of_reg
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable dynamically filling in the whole mfd_cell structure. All other
fields already allow that.

Fixes: 466a62d7642f ("mfd: core: Make a best effort attempt to match devices with the correct of_nodes")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 include/linux/mfd/core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index 47e7a3a61ce6..e8bcad641d8c 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -92,7 +92,7 @@ struct mfd_cell {
 	 * (above) when matching OF nodes with devices that have identical
 	 * compatible strings
 	 */
-	const u64 of_reg;
+	u64 of_reg;
 
 	/* Set to 'true' to use 'of_reg' (above) - allows for of_reg=0 */
 	bool use_of_reg;
-- 
2.39.2

