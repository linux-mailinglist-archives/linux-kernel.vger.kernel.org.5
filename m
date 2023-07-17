Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6820B7559B1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 04:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjGQCjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 22:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGQCjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 22:39:47 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D01AB
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 19:39:45 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R45rs6BXzzBHXlG
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 10:39:41 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689561581; x=1692153582; bh=B0VqIS048qQAyTRQkZRTwbl3bHl
        PopVf+hDtypP8Soc=; b=N7h3fmo3D668/G6npJR1vxoBW3v857PYtmW0XL/OCBk
        cGxBGdfj036QIEKr54i7P3lfN3huVKfdPaDp6xGd3ciqsM5QBOij8klGKRSH8m7h
        hVEIqbI7q/apJb90gDMTwCoh9+HzzNxTlbRH/xcxWdBxIteKqFGVQeevGt+bL158
        wkKJbId1FDtlSqgAafMCCQaMn7hHK3WpO5mZJPIPLeF7phyS0KFF41b3cbiZY7Wo
        t4kjANsi57odHTO1UWFGPfeY0Qrz1rZw+GlWJzO/Y3BTjyFGdQtpEJW7DhLSF+UI
        rMop6CR/NQJ/twkxgmKykGD6oyOQ31BQ6QMrZESpAmA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sgGtifjilfi9 for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 10:39:41 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R45rs3Q51zBHXR9;
        Mon, 17 Jul 2023 10:39:41 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 10:39:41 +0800
From:   hanyu001@208suo.com
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] myri10ge: Prefer unsigned int to bare use of unsigned
In-Reply-To: <tencent_3CB61C1D0FF3B148608B138A6CA1C3414B08@qq.com>
References: <tencent_3CB61C1D0FF3B148608B138A6CA1C3414B08@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <3854a4d7352831a6ae3732c0ef356f99@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning:

./drivers/net/ethernet/myricom/myri10ge/myri10ge.c:629: WARNING: Prefer 
'unsigned int' to bare use of 'unsigned'

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/net/ethernet/myricom/myri10ge/myri10ge.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c 
b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
index 8de2e5e..71b5f4c 100644
--- a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
+++ b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
@@ -626,7 +626,7 @@ static int myri10ge_load_hotplug_firmware(struct 
myri10ge_priv *mgp, u32 * size)
      vfree(fw_readback);
      if (crc != reread_crc) {
          dev_err(dev, "CRC failed(fw-len=%u), got 0x%x (expect 0x%x)\n",
-            (unsigned)fw->size, reread_crc, crc);
+            (unsigned int)fw->size, reread_crc, crc);
          status = -EIO;
          goto abort_with_fw;
      }
