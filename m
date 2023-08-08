Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49567741FA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjHHRbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjHHRas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:30:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AC18DCD2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:13:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1E307224A1;
        Tue,  8 Aug 2023 12:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691497908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=I/vShr3Jq3F1ZVbL6tVyG7gjnkjA0quafGn5/I4986U=;
        b=hot0vPnZtRdGfJU1K4zNqT7Ki28xMEJ9RI008EqbVHVPUXk+lt1wu2rMssrMS4ijIn5Seg
        i55mASyZLxUKMnkGLECSCM9V3tmkrJ/QaDwhe94oawTVbtKk+BARaRhMbIAilXYCXKKe8T
        aSDB7bM9Jyt/AtTafoUM8up/wL4ZcMk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC0F3139D1;
        Tue,  8 Aug 2023 12:31:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KCRTKrM10mQTegAAMHmgww
        (envelope-from <antonio.feijoo@suse.com>); Tue, 08 Aug 2023 12:31:47 +0000
From:   Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
Subject: [RESEND PATCH] gen_initramfs.sh: replace spaces with tab
Date:   Tue,  8 Aug 2023 14:28:48 +0200
Message-Id: <20230808122848.23142-1-antonio.feijoo@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up indentation, replace spaces with tab.

Signed-off-by: Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
---
 usr/gen_initramfs.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/usr/gen_initramfs.sh b/usr/gen_initramfs.sh
index 14b5782f961a..753b7ac28053 100755
--- a/usr/gen_initramfs.sh
+++ b/usr/gen_initramfs.sh
@@ -171,7 +171,7 @@ input_file() {
 		print_mtime "$1" >> $cpio_list
 		cat "$1"         >> $cpio_list
 		if [ -n "$dep_list" ]; then
-		        echo "$1 \\"  >> $dep_list
+			echo "$1 \\"  >> $dep_list
 			cat "$1" | while read type dir file perm ; do
 				if [ "$type" = "file" ]; then
 					echo "$file \\" >> $dep_list
-- 
2.35.3

