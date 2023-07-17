Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36E1755E8A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjGQIdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 04:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGQIds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:33:48 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311C3AB
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:33:46 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4FjJ4pbhzBR7Zv
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:33:40 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689582820; x=1692174821; bh=qDEzJDHeLkl5fOCGw+7n0TBDlqx
        xR3XxrG/mc9PY8lI=; b=gypN3lrlaHSNA4wCXFaOQVAYpDtGRX4q90wB9KeZsR0
        0f3dDdO/tnDjUa/XQfMMmRwwZka2g1F5l+G0rQVP8BP6qIHsWOaR6masT/WflIcq
        O4u4q67/dI2+SNxGnnpt0+zcDV9Wi0bSE7Gc0nva171EEut3j1lqBh58g3rA/XXf
        HTd8jcu4TCq1cZafG8PqsHaUFDYScNsB8f9yzWy+iYAPJGRQZV2cg9wuMeDjDoX8
        NVuLdtqyKyphv9PzImIOjEX6AQEndS00+EYE5EVo8FRjBcunkkj3HcfHYziToUtR
        cPeJTqjktOlFxC67Ejsxwt9TjAuG5JpvOFsDZuqQLRw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yYf6feZ64gAY for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 16:33:40 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4FjJ2JpCzBR5lS;
        Mon, 17 Jul 2023 16:33:40 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 16:33:40 +0800
From:   hanyu001@208suo.com
To:     benh@kernel.crashing.org, mpe@ellerman.id.au, baihaowen@meizu.com,
        studentxswpy@163.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: macintosh: add spaces required around that ':' and
 '?'
In-Reply-To: <tencent_A7289285160569DAEE7418CF0B205D2C520A@qq.com>
References: <tencent_A7289285160569DAEE7418CF0B205D2C520A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <1deebcc233b93769ff1c85c74a432199@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds spaces required around that ':' and '?'.

./drivers/macintosh/macio-adb.c:143: ERROR: spaces required around that 
'?' (ctx:VxW)
./drivers/macintosh/macio-adb.c:143: ERROR: spaces required around that 
':' (ctx:VxW)

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/macintosh/macio-adb.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/macio-adb.c 
b/drivers/macintosh/macio-adb.c
index 55a9f8c..4de4883 100644
--- a/drivers/macintosh/macio-adb.c
+++ b/drivers/macintosh/macio-adb.c
@@ -140,7 +140,7 @@ static int macio_adb_autopoll(int devs)
      spin_lock_irqsave(&macio_lock, flags);
      out_8(&adb->active_hi.r, devs >> 8);
      out_8(&adb->active_lo.r, devs);
-    out_8(&adb->autopoll.r, devs? APE: 0);
+    out_8(&adb->autopoll.r, devs ? APE : 0);
      spin_unlock_irqrestore(&macio_lock, flags);
      return 0;
  }
