Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BD977A817
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjHMPyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjHMPxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:53:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F747172E;
        Sun, 13 Aug 2023 08:52:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AEF4632B5;
        Sun, 13 Aug 2023 15:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E37C433C8;
        Sun, 13 Aug 2023 15:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691941904;
        bh=7aGq13H8vkd5h5pvyfTB2rxIn/wgA+LwyikdI52dkbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c4FFWgR3WO8pPPkv1ExgTB7XJneNuywSkC32BFGbsS39F65IpscaaF+8WXUjVoPLG
         n0TFDdxCY83ybaEtv4532DSe7ZxHUmNEo3FijYTbBJmTnoYFemS/XvZWLQi6vVZgzC
         YuzYuiAxjyGhBR3VHCNJBQ0MW11ffHMY3OARaOL9A1dJpBT6PW4FOj1StuDdgrXxmq
         8TI58jfmXF1IPjWu/zhJwYV0zCoyDCqb6z1XQDrvd9mgUP/KZAaBjTjVrhIC0fnJ80
         Q7yVyhCEEizP3t6P6HD9ajCGZZGZIuXbCFTu8dI3tJdnf00MOn04fN/ip9xwZtxtG8
         8lE/yOXtNOmIQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 35/54] platform/x86/amd/pmf: reduce verbosity of apmf_get_system_params
Date:   Sun, 13 Aug 2023 11:49:14 -0400
Message-Id: <20230813154934.1067569-35-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813154934.1067569-1-sashal@kernel.org>
References: <20230813154934.1067569-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.10
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

[ Upstream commit 839e90e75e695b3d9ee17f5a2811e7ee5aea8d4a ]

apmf_get_system_params() failure is not a critical event, reduce its
verbosity from dev_err to dev_dbg.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Link: https://lore.kernel.org/r/20230714144435.1239776-1-Shyam-sundar.S-k@amd.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmf/acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/pmf/acpi.c b/drivers/platform/x86/amd/pmf/acpi.c
index 081e84e116e79..732b15b392ab9 100644
--- a/drivers/platform/x86/amd/pmf/acpi.c
+++ b/drivers/platform/x86/amd/pmf/acpi.c
@@ -289,7 +289,7 @@ int apmf_acpi_init(struct amd_pmf_dev *pmf_dev)
 
 	ret = apmf_get_system_params(pmf_dev);
 	if (ret) {
-		dev_err(pmf_dev->dev, "APMF apmf_get_system_params failed :%d\n", ret);
+		dev_dbg(pmf_dev->dev, "APMF apmf_get_system_params failed :%d\n", ret);
 		goto out;
 	}
 
-- 
2.40.1

