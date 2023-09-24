Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9213F7AC92B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjIXN1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjIXN1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:27:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2FB26B6;
        Sun, 24 Sep 2023 06:20:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E426C433AD;
        Sun, 24 Sep 2023 13:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561640;
        bh=0JBoW82sAVisLUsxaax3heE9JWG7x0RJLebL2mFRSlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H6IXMMHBTXjNrrciuIvYUBnzHgyIpM0Kk+LA5x9o/hR5olp8iCOPbEpytpTc8Sm4d
         GZj0bcyDutJue2uFYpDTF4doAA8bJYA1RWlUN+byAKm2Y322yGm8EGUvHlujSRScka
         WjHEN3WbGVN8r127FMs8w21b3EidDNr5AI+WpzZLRQi+BCgBXaAvx6gpOAPWqBtRLw
         w103lF4445obK5mAHcMldUzAWwnoGbEFzRStMOow7dvBG0zxX0T6drZ/2QSJnjh7ng
         bhx/7rNbO51b7cM+Tx3t/UOkyt6CkhoXEWeA5dO/B1tvOWGdWqu6/vgkEUwufzqtIT
         e7XiF9KqZyrlw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        James.Bottomley@HansenPartnership.com, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-parisc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 3/7] parisc: drivers: Fix sparse warning
Date:   Sun, 24 Sep 2023 09:20:27 -0400
Message-Id: <20230924132033.1276920-3-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924132033.1276920-1-sashal@kernel.org>
References: <20230924132033.1276920-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.295
Content-Transfer-Encoding: 8bit
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
index 01a2ed59d2f2a..94037c8512f78 100644
--- a/arch/parisc/kernel/drivers.c
+++ b/arch/parisc/kernel/drivers.c
@@ -903,9 +903,9 @@ static __init void qemu_header(void)
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

