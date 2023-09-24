Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FF87AC935
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjIXN3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjIXN24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:28:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2264E1729;
        Sun, 24 Sep 2023 06:19:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958D5C433CA;
        Sun, 24 Sep 2023 13:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561544;
        bh=NGS+/VCSQQPfJZf3Zd6iCTKHQBKn8OO27Irst0AL6TY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GEDLtekyjpZZE1fjn6wJJMgrYPS91EDI0npCC5FVVFse1QjGHLtQfICtmHpCpastK
         e4AC1V7gLwTR1obxXWWNGeQktuUzCRAGefTtxzPWplJOCMevgp6SGFDwI3weV8luBY
         EQWDfoFQJEwme8ellPnoOMZIMs4XT9wfEwAgv7NebTUnn4ZHsCrtHO8C6XMLuTHHgr
         pyD6Dj3zMAg5FmcwRs+AueaSBBw+r/egg5Fu3Ji7S0oY4LyQMuv/smK4XVlSgFH1C1
         8Y84gRatJ0roLV8mqXMNTITqKCTeLbNjIwUr2uoDjy3Iry61rm4puUblTBvr7DjKne
         olcA/Qo3iQtJg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        James.Bottomley@HansenPartnership.com, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-parisc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 03/18] parisc: drivers: Fix sparse warning
Date:   Sun, 24 Sep 2023 09:18:40 -0400
Message-Id: <20230924131857.1276330-3-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131857.1276330-1-sashal@kernel.org>
References: <20230924131857.1276330-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.133
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helge Deller <deller@gmx.de>

[ Upstream commit b137b9d60b8add5620a06c687a71ce18776730b0 ]

Fix "warning: directive in macro's argument list" warning.

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/parisc/kernel/drivers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/drivers.c b/arch/parisc/kernel/drivers.c
index e7ee0c0c91d35..8f12b9f318ae6 100644
--- a/arch/parisc/kernel/drivers.c
+++ b/arch/parisc/kernel/drivers.c
@@ -924,9 +924,9 @@ static __init void qemu_header(void)
 	pr_info("#define PARISC_MODEL \"%s\"\n\n",
 			boot_cpu_data.pdc.sys_model_name);
 
+	#define p ((unsigned long *)&boot_cpu_data.pdc.model)
 	pr_info("#define PARISC_PDC_MODEL 0x%lx, 0x%lx, 0x%lx, "
 		"0x%lx, 0x%lx, 0x%lx, 0x%lx, 0x%lx, 0x%lx\n\n",
-	#define p ((unsigned long *)&boot_cpu_data.pdc.model)
 		p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8]);
 	#undef p
 
-- 
2.40.1

