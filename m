Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01E4755F00
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjGQJMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGQJL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:11:58 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4889D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:11:55 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4GYP0xhSzBR9sV
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 17:11:53 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689585113; x=1692177114; bh=vj4//deCA33OOlFe8LFxHO33dYk
        UaS71mYSQYbPAi+o=; b=uGz2viwAd5vEYbFkyY7V3UTVFRT9HvHBSK5LtrpgFli
        nI332PdqAZ9KRIXj6Bliz35X+wUNYTAmGHarDfR2ASPH/O8moUDTpEq555bTP7PT
        4DMTOWT6qMJMQwhBK7XgO2YdOWyPltVEiCR0g1m4CgHutjJbQRmdKZ/XYbzDMCrT
        2QzU+F8dpkZs6j7SwoM6p78nE5/bTDAEUvQWLl0IlimMsXKRwJdcu5fkCwsRdvey
        sVSCXVycNmnDT5zRbYwgfkHFith65ETu9kYkQeeXo5sYszESXzWUmTDlWly/kG8M
        GI7ZGq2Jrv37YDiVNgjavYULSUQsdayvyJuGQJ+atTA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hgK8zJ_VR-yn for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 17:11:53 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4GYN6L4yzBHXhJ;
        Mon, 17 Jul 2023 17:11:52 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 17:11:52 +0800
From:   hanyu001@208suo.com
To:     benh@kernel.crashing.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: macintosh: space required after that ','
In-Reply-To: <tencent_ADDBAE8EF1F902A4A64541C5ABD08C207D07@qq.com>
References: <tencent_ADDBAE8EF1F902A4A64541C5ABD08C207D07@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <7eb1fdadf332dccdb74bf4721b7772de@208suo.com>
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
