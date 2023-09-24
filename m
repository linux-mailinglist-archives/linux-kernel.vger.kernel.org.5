Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37587AC938
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjIXN3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbjIXN25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:28:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4DD469D;
        Sun, 24 Sep 2023 06:19:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6196EC433CA;
        Sun, 24 Sep 2023 13:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561593;
        bh=f57BZg4nBOPcQcqood/bCUZRkQD4yiA7aPxXiO6WBk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ejxCF0KgpwJOhROh1+zws2XyByFt/TiGrUpPDUQQ1lZw5oevY5u9ZyIk3xUl4E7/A
         hI8dFsDyVfwhGlPbOG7i2SVlSO8dBRR618l0Q31FRwyYNgo8s/Yk2d8u3i6qGx+uQa
         TA+VkZzQ2b50/Q0L2LeqCzZb9Ehzj1OUpQ0dGY4Jdja1ncdTCnfg44Sn61PCEUf+cW
         3VWqpCWiN0kFS/moCAXbCZynZ7R+j6gjen9sENZ2ZIeqszc+jr7+tV3ASWtBQ6fHSm
         T4Gd4xroHNoHY7NYV2508gl4eGygjScAud1Gbu+f/L1PpMCSOygtt0n8f5hWrvh3iZ
         so0CDx05Q7wAg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        James.Bottomley@HansenPartnership.com, hdegoede@redhat.com,
        rafael@kernel.org, gregkh@linuxfoundation.org,
        linux-parisc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 03/13] parisc: drivers: Fix sparse warning
Date:   Sun, 24 Sep 2023 09:19:33 -0400
Message-Id: <20230924131945.1276562-3-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131945.1276562-1-sashal@kernel.org>
References: <20230924131945.1276562-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.197
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
index d95157488832a..d11a3123f3dc4 100644
--- a/arch/parisc/kernel/drivers.c
+++ b/arch/parisc/kernel/drivers.c
@@ -925,9 +925,9 @@ static __init void qemu_header(void)
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

