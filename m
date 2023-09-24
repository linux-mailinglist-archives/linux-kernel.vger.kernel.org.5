Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D199E7AC999
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjIXNdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjIXNcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:32:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29644ECF;
        Sun, 24 Sep 2023 06:20:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C8FC43391;
        Sun, 24 Sep 2023 13:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561622;
        bh=PeYbhpmy2ZTD3bFuKNsu5o7zTw0fpjP5sWEMn3PieyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fQT9CmkiPRmigOpzLcCYXIUzaLEYk8tSna02LITFW+e2uI+H6Nm4TViIIf/Nu4EyZ
         K//3qh2UruTFazLoGsbUqoUcwn8WBAQ+MlzCLuQznRuimxLDYhVgB8PeQk1wTNqpu4
         H7WktSf2CU/91KmMGB/y9cXJ2PSDqcenBuyo7qadapgWt/3GFBQHXPSx7TBGWkUJVj
         5MFtomqW9L8x2VBmkhmEUiLq4prFkt2iddvQQ3/1NavZTEM0D4wKJDn1PWx/PXk0Hy
         NKzmK93p0Ue4zIPEaFG0gfChJcOJuANoKpaAfNGcZq3D+We3DQop7woG0cQQJEew+D
         cbSaX7VAAGSNA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        James.Bottomley@HansenPartnership.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, hdegoede@redhat.com,
        linux-parisc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 3/7] parisc: drivers: Fix sparse warning
Date:   Sun, 24 Sep 2023 09:20:10 -0400
Message-Id: <20230924132015.1276811-3-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924132015.1276811-1-sashal@kernel.org>
References: <20230924132015.1276811-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.257
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
index a1476673062e6..f1d4949313286 100644
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

