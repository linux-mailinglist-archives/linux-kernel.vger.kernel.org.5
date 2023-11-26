Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134A97F934A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 16:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjKZPMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 10:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjKZPMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 10:12:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FBDEA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 07:12:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC3BC433C7;
        Sun, 26 Nov 2023 15:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701011550;
        bh=/kFpAA4DUTJCxXMcp6g5f0QDobgBKxMX1n83qyntQm0=;
        h=From:To:Cc:Subject:Date:From;
        b=aMiPZx2aFPvR9GMRXMo4guJnEJys6Thmjt/rCfhgCQGRSkGWzYrjzaXMqA5+/vaaF
         tJz34r9Z3e3+BRB1V0MyeHEtFd2eLhgO5HNAr7BXYHbclnDNJT5Ew6hzPeP0O/WqmP
         2nOt7FzLoxUAkHmAMMYWD6qganLAQvWY+dKA+t1x/xk6B4UoaeoHtR4FoaYOwfdkU6
         jmjue/ozhWylaA0pTpX0GdAy12/7FQBQVyAhMJkLMbu3daExwfLazLt188fEo+LHvE
         nq+uPPgoHN1og8pmnSyYsMP5Iln/gZacAbnIk9JHwlZ+hqAU49Pn2ruglUYDvIY/q3
         bjxiYM9htqFgw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] xtensa: replace <asm-generic/export.h> with <linux/export.h>
Date:   Mon, 27 Nov 2023 00:12:22 +0900
Message-Id: <20231126151222.1556761-1-masahiroy@kernel.org>
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

 arch/xtensa/include/asm/asmmacro.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/include/asm/asmmacro.h b/arch/xtensa/include/asm/asmmacro.h
index 01bf7d9dbb19..a52d49a16ce7 100644
--- a/arch/xtensa/include/asm/asmmacro.h
+++ b/arch/xtensa/include/asm/asmmacro.h
@@ -11,7 +11,7 @@
 #ifndef _XTENSA_ASMMACRO_H
 #define _XTENSA_ASMMACRO_H
 
-#include <asm-generic/export.h>
+#include <linux/export.h>
 #include <asm/core.h>
 
 /*
-- 
2.40.1

