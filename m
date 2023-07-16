Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587E1755114
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 21:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjGPTi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 15:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGPTi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 15:38:28 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B557109
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 12:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1689536304;
        bh=DAxFcO4hd0RSUS5dQ25rynGRteiQTqrOT9urW59eNfU=;
        h=From:Date:Subject:To:Cc:From;
        b=DE+YmNXWuoSeK+lg0u4kzMsUehZHVy/MmP0pQ61jPcEirnuL1+Jya7GUQISxCQcV0
         Qiid4MiTIQExFQwOQTZD3SCIjhP/IokfkzVvdJ+O7IJEyJA5cY9DetdE4CGLs03tlD
         TEWY+yD713ujxeBBI6i4mIgqLdXIrDBZzln9btl4=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sun, 16 Jul 2023 21:38:19 +0200
Subject: [PATCH] pgpkeys: new keys need two signatures
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230716-fixes-v1-1-9802bf35ad6b@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIACpHtGQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDc0Mz3bTMitRi3SQjo0RjA9OUZMsUIyWg2oKiVLAEUGl0bG0tAM5iL9F
 XAAAA
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689536303; l=1071;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=DAxFcO4hd0RSUS5dQ25rynGRteiQTqrOT9urW59eNfU=;
 b=NlGlHE7fCorgolZJVkuo9IkcN42TeVbebx8ZjHwdHXzP7FZnVnxXFfOUByHaWuX1lHIzejqIO
 Jw1xdULvuRnCXGQeWoiAtdSd9vWLNNA9ELvpmSPonwmD6nlkuMJ3RQA
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent messages on the keys@linux.kernel.org list indicate that two
signatures are needed.
This also matches the wording from accounts.rst.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 source/pgpkeys.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/source/pgpkeys.rst b/source/pgpkeys.rst
index 78ba703ff42b..ee2a912612f8 100644
--- a/source/pgpkeys.rst
+++ b/source/pgpkeys.rst
@@ -3,7 +3,7 @@ Kernel developer PGP keyring
 
 If you regularly contribute code to the Linux kernel, you are encouraged
 to submit your key to be included in the PGP keyring repository. For us
-to be able to accept it, it must have at least one signature from
+to be able to accept it, it must have at least two signatures from
 someone whose key is already in that repository, so we can trace each
 key's trust lineage to the head maintainer (Linus Torvalds).
 

---
base-commit: 8196a3c298d9b1f11be305c87eb890f44f7c8cc5
change-id: 20230716-fixes-b22a305dc9d2

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

