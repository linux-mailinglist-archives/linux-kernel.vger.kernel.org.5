Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9617E6E1A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbjKIP5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjKIP5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:57:47 -0500
X-Greylist: delayed 382 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Nov 2023 07:57:44 PST
Received: from postout2.mail.lrz.de (postout2.mail.lrz.de [129.187.255.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035D02736
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 07:57:43 -0800 (PST)
Received: from lxmhs52.srv.lrz.de (localhost [127.0.0.1])
        by postout2.mail.lrz.de (Postfix) with ESMTP id 4SR5z762ZDzyXQ;
        Thu,  9 Nov 2023 16:51:15 +0100 (CET)
Authentication-Results: postout.lrz.de (amavisd-new); dkim=pass (2048-bit key)
        reason="pass (just generated, assumed good)" header.d=tum.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tum.de; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received; s=tu-postout21; t=1699545075; bh=FLhY3lTuUc3
        WtyOcLcUxakIx8PVClCaL3IV9f8Y5L90=; b=N/TXfWMy9zpCCJLzYvbIxaD0dUx
        WELXUYSKYFnM4U7W/wj7sCYI8VkdTVh2oU//d9j2jKQcrMYMlRyeaENeujdkxQyI
        77WlHKChdwbGgtuyusTPax/PEyn5SofxzwRiIwvPOFUJgaXwzmwGYsFboD5HbOxi
        YYIXff2pDJcunVzbDdRQS9a6Fl6ivPLkczplRnTJoj64uS8g3sT04BvbkaJzPPDM
        E5pvVfm7p29h0y0bf2r/JdEu9AHl5DoHP9nGbM+6Xrcz1AC6jMzKL6NSC0v4pl/P
        GMMu9mHNgfzZh4CT5OUM/pBrQVI7JyOkjoZ80MzOvWixtnFqRgC5EOzw6Yw==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs52.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -2.885
X-Spam-Level: 
X-Spam-Status: No, score=-2.885 tagged_above=-999 required=5
        tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, DMARC_ADKIM_RELAXED=0.001,
        DMARC_ASPF_RELAXED=0.001, DMARC_POLICY_NONE=0.001,
        LRZ_CT_PLAIN_UTF8=0.001, LRZ_DATE_TZ_0000=0.001, LRZ_DMARC_FAIL=0.001,
        LRZ_DMARC_FAIL_NONE=0.001, LRZ_DMARC_POLICY=0.001,
        LRZ_DMARC_TUM_FAIL=0.001, LRZ_DMARC_TUM_REJECT=3.5,
        LRZ_DMARC_TUM_REJECT_PO=-3.5, LRZ_ENVFROM_FROM_MATCH=0.001,
        LRZ_ENVFROM_TUM_S=0.001, LRZ_FROM_ENVFROM_ALIGNED_STRICT=0.001,
        LRZ_FROM_HAS_A=0.001, LRZ_FROM_HAS_AAAA=0.001,
        LRZ_FROM_HAS_MDOM=0.001, LRZ_FROM_HAS_MX=0.001,
        LRZ_FROM_HOSTED_DOMAIN=0.001, LRZ_FROM_NAME_IN_ADDR=0.001,
        LRZ_FROM_PHRASE=0.001, LRZ_FROM_TUM_S=0.001, LRZ_HAS_CT=0.001,
        LRZ_HAS_MIME_VERSION=0.001, LRZ_HAS_SPF=0.001,
        LRZ_URL_PLAIN_SINGLE=0.001, LRZ_URL_SINGLE_UTF8=0.001,
        T_SCC_BODY_TEXT_LINE=-0.01] autolearn=no autolearn_force=no
Received: from postout2.mail.lrz.de ([127.0.0.1])
        by lxmhs52.srv.lrz.de (lxmhs52.srv.lrz.de [127.0.0.1]) (amavisd-new, port 20024)
        with LMTP id JcuZfT6noPOB; Thu,  9 Nov 2023 16:51:15 +0100 (CET)
Received: from sienna.cit.tum.de (Monitor.dos.cit.tum.de [131.159.38.165])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by postout2.mail.lrz.de (Postfix) with ESMTPSA id 4SR5z66SBszySZ;
        Thu,  9 Nov 2023 16:51:14 +0100 (CET)
From:   =?UTF-8?q?Paul=20Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Paul=20Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>
Subject: [PATCH] kasan: default to inline instrumentation
Date:   Thu,  9 Nov 2023 15:51:00 +0000
Message-Id: <20231109155101.186028-1-paul.heidekrueger@tum.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASan inline instrumentation can yield up to a 2x performance gain at
the cost of a larger binary.

Make inline instrumentation the default, as suggested in the bug report
below.

When an architecture does not support inline instrumentation, it should
set ARCH_DISABLE_KASAN_INLINE, as done by PowerPC, for instance.

CC: Dmitry Vyukov <dvyukov@google.com>
Reported-by: Andrey Konovalov <andreyknvl@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=203495
Signed-off-by: Paul Heidekrüger <paul.heidekrueger@tum.de>
---
 lib/Kconfig.kasan | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index fdca89c05745..935eda08b1e1 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -134,7 +134,7 @@ endchoice
 choice
 	prompt "Instrumentation type"
 	depends on KASAN_GENERIC || KASAN_SW_TAGS
-	default KASAN_OUTLINE
+	default KASAN_INLINE if !ARCH_DISABLE_KASAN_INLINE
 
 config KASAN_OUTLINE
 	bool "Outline instrumentation"
-- 
2.40.1

