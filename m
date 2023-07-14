Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C966075359A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbjGNIvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbjGNIvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:51:00 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD85426AF
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:50:58 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2QDb42LSzBR9sj
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 16:50:55 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689324655; x=1691916656; bh=OE0KQdUdTOFnvUpaKsCK2w+k4oS
        NXvvG4m4MI6Kr+6Y=; b=NoTp3I8D/qQHqwYowoCmrYyzree13827DHVHHlaJ731
        5+trslYMKaWZbOG5U/Ur0JiuPFhexsHTxjhJCYD4kexHSe5yPCFQjWEjy6WEEz+R
        5Hu3oGopmJOvFiP0ubpCeEXcCfSW1Ng165SeM8pOOS/yquiZraZQ/04/eEdJZ5DA
        TGhev57lShWV0DdvZBWr8F9PjfXA30IwyO2dA1eE9X/jSErE9OJ0TwfeC4hqPc4+
        mDsKVD6d30re0Nd+NP4venizykseSNzdhuyKABWO2kEYXgG7wsl5AEnRQ1juQQYO
        l175z/6X7TdZ94oqmlaQFn+egb2SLoB5Hc4PHEYXjcA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VETfRJTkjWuv for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 16:50:55 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2QDb2RqPzBR9sf;
        Fri, 14 Jul 2023 16:50:55 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 16:50:55 +0800
From:   sunran001@208suo.com
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: add missing spaces before '*' and remove spaces after
 '*'
In-Reply-To: <20230714084941.14803-1-xujianghui@cdjrlc.com>
References: <20230714084941.14803-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <603b287b9f153389d8ccf87c21ae8a2d@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing spaces to clear checkpatch errors.

ERROR: "foo* bar" should be "foo *bar"
ERROR: else should follow close brace '}'

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/media/dvb-frontends/bsbe1.h | 36 ++++++++++++++---------------
  1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/media/dvb-frontends/bsbe1.h 
b/drivers/media/dvb-frontends/bsbe1.h
index 7ca1bdc08177..89ca9b14a740 100644
--- a/drivers/media/dvb-frontends/bsbe1.h
+++ b/drivers/media/dvb-frontends/bsbe1.h
@@ -36,24 +36,24 @@ static int alps_bsbe1_set_symbol_rate(struct 
dvb_frontend *fe, u32 srate, u32 ra
      u8 aclk = 0;
      u8 bclk = 0;

-    if (srate < 1500000) {
-        aclk = 0xb7;
-        bclk = 0x47;
-    } else if (srate < 3000000) {
-        aclk = 0xb7;
-        bclk = 0x4b;
-    } else if (srate < 7000000) {
-        aclk = 0xb7;
-        bclk = 0x4f;
-    } else if (srate < 14000000) {
-        aclk = 0xb7;
-        bclk = 0x53;
-    } else if (srate < 30000000) {
-        aclk = 0xb6;
-        bclk = 0x53;
-    } else if (srate < 45000000) {
-        aclk = 0xb4;
-        bclk = 0x51;
+    if (srate < 1500000) {
+        aclk = 0xb7;
+        bclk = 0x47;
+    } else if (srate < 3000000) {
+        aclk = 0xb7;
+        bclk = 0x4b;
+    } else if (srate < 7000000) {
+        aclk = 0xb7;
+        bclk = 0x4f;
+    } else if (srate < 14000000) {
+        aclk = 0xb7;
+        bclk = 0x53;
+    } else if (srate < 30000000) {
+        aclk = 0xb6;
+        bclk = 0x53;
+    } else if (srate < 45000000) {
+        aclk = 0xb4;
+        bclk = 0x51;
      }

      stv0299_writereg(fe, 0x13, aclk);
