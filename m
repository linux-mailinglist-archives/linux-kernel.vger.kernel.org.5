Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF64F802289
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 11:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbjLCKZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 05:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbjLCKZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 05:25:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1B5FD
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 02:25:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37B6C433C9;
        Sun,  3 Dec 2023 10:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701599137;
        bh=LEoTggARida+p4FLdOShzFKl4z7iyh9a/kviqyZ5sDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vj+fwQJayDbwrfs2+Hs+St+PCRLNFFY8IDpG2/4YAkzdbMeKDiNE472eFVcZw9Ezc
         8dFreVRKLo4w6cAS8YUWeD8Q92tyUA7fF+4vmeD+tp9Pzd/2JYLtyAcWG4Vi7dd7q5
         Qw2tFWn2qqxLJB010d/eYVy7dmWHsiiDWPVo/wVZkEXeCrao3W+CWHYlvy+KP4uYBo
         rBmOYjV9W3U81PjmHHKkfWalzGcrmgKwg+163ciOjhohFHK2CKezf6disP4A5fO0Zr
         Dcvuxr5j0gFQrcaoH/RrWS+V+5IgjaI5RFJCcZ0pXh7a0UTdqBjaZZZEKW+ERKZcjp
         1dW9m6ivPmmPw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] kconfig: add include guard to lkc_proto.h
Date:   Sun,  3 Dec 2023 19:25:26 +0900
Message-Id: <20231203102528.1913822-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203102528.1913822-1-masahiroy@kernel.org>
References: <20231203102528.1913822-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/lkc_proto.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/kconfig/lkc_proto.h b/scripts/kconfig/lkc_proto.h
index edd1e617b25c..687d8698d801 100644
--- a/scripts/kconfig/lkc_proto.h
+++ b/scripts/kconfig/lkc_proto.h
@@ -1,4 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef LKC_PROTO_H
+#define LKC_PROTO_H
+
 #include <stdarg.h>
 
 /* confdata.c */
@@ -50,3 +53,5 @@ char *expand_one_token(const char **str);
 
 /* expr.c */
 void expr_print(struct expr *e, void (*fn)(void *, struct symbol *, const char *), void *data, int prevtoken);
+
+#endif /* LKC_PROTO_H */
-- 
2.40.1

