Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A4A8068CB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbjLFHkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjLFHjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:39:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBEE1722
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:38:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAA1C433B8;
        Wed,  6 Dec 2023 07:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701848292;
        bh=GjPJ3PxqDVQljTDeHhn532jvz4GA2f5RSxQE7O7jAGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OyUKuf4M5QjBoDnrYySejo97ocozDjJbUBMa66sWppD1m2v6sYjDWRgA9GVs23dif
         dwzlWMRN2KkkyHKV/1jLB2oRs6ZPq7KOihYRzdD5oeQ/tQ5rwKId2/x8UBeiXwuTJC
         qcGnPN+HRoKvH7rOpCmBrUWeoigKcJMIaqQG+oYVyRP/0iZej5gm8dYCFs9TNG/aG5
         alDEXeQBBh08q/SkEa6rJBZPB2EV1eaq0lkP+XaQ+G2C7DIAQhbI7YbgnybQSqpqEY
         b7c1gTsssUH4rnqM8fTQuKx563tI/38/fL5Sdl+ZJDJWruEZ7bllPqeHZq6Ppc44QF
         8TmMFs4R8CH7g==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 27/27] tty: xtensa/iss: use u8
Date:   Wed,  6 Dec 2023 08:37:12 +0100
Message-ID: <20231206073712.17776-28-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206073712.17776-1-jirislaby@kernel.org>
References: <20231206073712.17776-1-jirislaby@kernel.org>
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

Switch character types to u8. To conform to characters in the rest of
the tty layer.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/platforms/iss/console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
index 7d1f8b398a46..8896e691c051 100644
--- a/arch/xtensa/platforms/iss/console.c
+++ b/arch/xtensa/platforms/iss/console.c
@@ -65,7 +65,7 @@ static void rs_poll(struct timer_list *unused)
 	struct tty_port *port = &serial_port;
 	int i = 0;
 	int rd = 1;
-	unsigned char c;
+	u8 c;
 
 	while (simc_poll(0)) {
 		rd = simc_read(0, &c, 1);
-- 
2.43.0

