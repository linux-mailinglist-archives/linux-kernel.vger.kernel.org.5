Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADEF7AC8D8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjIXNUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjIXNTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:19:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE41136;
        Sun, 24 Sep 2023 06:17:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF71C433C7;
        Sun, 24 Sep 2023 13:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561476;
        bh=NGS+/VCSQQPfJZf3Zd6iCTKHQBKn8OO27Irst0AL6TY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Md56otqoH2JxYyGg+lG5Vf415wpan+PbwbuNizKDxkjBzWDVSqRf/u5scy4j1zop6
         xcq2CYnFLgk3T7pPR6hnLGgpDtTJiDUE6zJVOLiVtAGX+WFwJN0S2pnXEqW0Ff6BBs
         5fnzkcgWAKoYfg/WdZG+mpPQ9D9Mi2M2fuymuAgDF37ABEaAlC8235m6WmjyFlRaAx
         FUMzlC1Gu4/9uJ0XZLNk/yOKr+aecrbB/mpxwMo/DYR8bpnTDLsODz/qkmYREZ+B2b
         yuTuBqQ31GpFLoSMiHkWzgrt4Hci9mwWxpXvzhG0u/lpL3h2sqkk7EVo3cbjUiURXg
         Pl9/AIJ+2p7Bg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        James.Bottomley@HansenPartnership.com, rafael@kernel.org,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        linux-parisc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 04/28] parisc: drivers: Fix sparse warning
Date:   Sun, 24 Sep 2023 09:17:21 -0400
Message-Id: <20230924131745.1275960-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131745.1275960-1-sashal@kernel.org>
References: <20230924131745.1275960-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.55
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

