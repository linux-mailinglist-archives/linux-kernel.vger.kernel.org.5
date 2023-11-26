Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1117F7F9349
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 16:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjKZPKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 10:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjKZPKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 10:10:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B63EA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 07:10:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85594C433C8;
        Sun, 26 Nov 2023 15:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701011451;
        bh=zFafLRdl6qo7jyo7XWh2Lf4k9/OTBqXF1Ey4sdDtHdQ=;
        h=From:To:Cc:Subject:Date:From;
        b=KElSrhwJ0cF1uR1kj8k0FIt+P2aZkiJy/2xMDJYn7f8OLp8LimYv4lWDkPQpSun5y
         EnHLCI8D1XjKFHUbm9l4O58qhVhSKYvW6OhZNUBQeBxrr6XMgn2RLY3A69Z3R0Tsob
         PiXxwfl6DJ2p1uNILDuAyiTV9ClqbQW3iQvMlde5nVVfTvduoWe6P4DrCQNSmJPg8w
         UNDfZm9mJj53TiHcVCbmAXEnpCMpOZKeQCM1YDoKBRJpO6iUqgubj+41OYRkPeSRKH
         N2BloO6f64b1chGKeT7/hZDhpnkBL6NYH22O05EeIYzxQCEa+MEYcVMQW1b9UCQPgr
         WxGryhXctiAdA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: replace <asm-generic/export.h> with <linux/export.h>
Date:   Mon, 27 Nov 2023 00:10:45 +0900
Message-Id: <20231126151045.1556686-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost")
deprecated <asm-generic/export.h>, which is now a wrapper of
<linux/export.h>.

Replace #include <asm-generic/export.h> with #include <linux/export.h>.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arm64/include/asm/assembler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 376a980f2bad..7b1975bf4b90 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -12,7 +12,7 @@
 #ifndef __ASM_ASSEMBLER_H
 #define __ASM_ASSEMBLER_H
 
-#include <asm-generic/export.h>
+#include <linux/export.h>
 
 #include <asm/alternative.h>
 #include <asm/asm-bug.h>
-- 
2.40.1

