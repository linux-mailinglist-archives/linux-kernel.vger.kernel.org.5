Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B09755F66
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjGQJfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjGQJek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:34:40 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1DF1BF9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:34:12 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4H353ZKqzBR5l8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 17:34:09 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689586449; x=1692178450; bh=vj4//deCA33OOlFe8LFxHO33dYk
        UaS71mYSQYbPAi+o=; b=jXI/ytPYUb1e4QfuOGnAhPf6HAHmQvgkSUDsRc0zGJs
        WP7dRbRp3pUsGUdRWUlhVkPPrtTBt44L8mLkMqU1NwZaDPflTPSxa7GpEYxOyMTM
        jWHIfeyx2vXaZrnOZBlmrZ9/2gK1rYPkp+Is6ZX4fxJSLXAYvuNpAkepc2/YGNYb
        iStjyMbkF6Q77J6mctaM8qdPgL35ZADvVBpdJGPjM1ULs42uKjvnzRlUvrpMEvGE
        Xup8hIjI+Yljt+FjSlldN0JSo0q0bF3y8WKBF2g3COpAtSQV+0duqXBfjVH34fCE
        rQk/3DziM2ewBdNZjzrmPw7sR+7CYre6k1N+XEkXCag==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id k7NMZSpb4qlX for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 17:34:09 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4H350HmPzBJ96K;
        Mon, 17 Jul 2023 17:34:08 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 17:34:08 +0800
From:   hanyu001@208suo.com
To:     benh@kernel.crashing.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Fwd: [PATCH] drivers: macintosh: space required after that ','
In-Reply-To: <tencent_C3903C16C7148542F183E66C393B6AE71109@qq.com>
References: <tencent_C3903C16C7148542F183E66C393B6AE71109@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <180c4f063ceee2b5b433de4e849cea29@208suo.com>
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

This patch fixes the checkpatch.pl error:

./drivers/macintosh/adbhid.c:1091: ERROR: space required after that ',' 
(ctx:VxV)

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/macintosh/adbhid.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/adbhid.c b/drivers/macintosh/adbhid.c
index b2fe7a3..293e72a 100644
--- a/drivers/macintosh/adbhid.c
+++ b/drivers/macintosh/adbhid.c
@@ -1088,7 +1088,7 @@ static void adbhid_input_unregister(int id)
      unsigned char r1_buffer[8];

      adb_request(&req, NULL, ADBREQ_SYNC | ADBREQ_REPLY, 1,
-            ADB_READREG(id,1));
+            ADB_READREG(id, 1));
      if (req.reply_len < 8)
          pr_err("%s: bad length for reg. 1\n", __func__);
      else
