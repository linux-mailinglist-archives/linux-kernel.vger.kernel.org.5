Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D907AC84A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjIXNP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjIXNPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:15:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22BC10E;
        Sun, 24 Sep 2023 06:15:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A984C433C7;
        Sun, 24 Sep 2023 13:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561344;
        bh=ABZ1A2v0BMnJqes0vFnyRuQHSp0LsdJD9Dff/RCUQgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CJksJmhiM6x/w9QUxKXQ92UPaJe8t6INsY/7aFuAC3+fkZth1Zmzrq5ddMb6dwH31
         AO/Ye9y5tTDZLECbrzkkYbvSdFBsiiZh6clluI52xMyionqQ4MzmEXTvnsT8rezTLS
         2kePSFFiuC0IksqKo72Kd+IwGKoPLY8uPEtkKQGUEPgWXCMqvnZ3pMLYPo/adGrcHu
         FCeQADW9CdDcCPAmiWw6IKDLT1o7SkimXgy6ELMQ39YhyiXSXOyn4HvjgCe18HR3HZ
         LGo+CWHBXjhERP1AQUhVso5HxR85qRzre1fa4lPS3juXHvzOVhQ9xwFSaRQmwVs3Sa
         J/A8OdDPgqDcw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        James.Bottomley@HansenPartnership.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, hdegoede@redhat.com,
        linux-parisc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 06/41] parisc: drivers: Fix sparse warning
Date:   Sun, 24 Sep 2023 09:14:54 -0400
Message-Id: <20230924131529.1275335-6-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131529.1275335-1-sashal@kernel.org>
References: <20230924131529.1275335-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.5
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
index 8f4b77648491a..ed8b759480614 100644
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

