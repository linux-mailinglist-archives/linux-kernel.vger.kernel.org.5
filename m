Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7A67BCAAA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 02:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344222AbjJHAs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 20:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjJHAs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 20:48:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B329BB6;
        Sat,  7 Oct 2023 17:48:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5AAC433C8;
        Sun,  8 Oct 2023 00:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696726136;
        bh=FDVlWtfIoWp9upUBEcknCTBG/yt397trn7QtEc86PJo=;
        h=From:To:Cc:Subject:Date:From;
        b=TcQosX1rH2KyvO4mm0XKjJMc/1ip0rrOgpC+v6gBhSfSTU2LVA3sMY+tzHGbrHFci
         lnBgABLJ+M5mIuJf9GIKh27EK/LDg1cNQjDRqE4aQNRS2hJ7d1Tp0aWbK+4edpMuvc
         J0BQuBICo5SYd7DYsCFl95ySP4ty7V6zMWZcS/ZwDO4ERgHcA9EWKmZpVthl1d7emL
         C8V2/dvYbjokwYAy595bCGCgQB2n26G/6YSKivdIyHSkDyx+TTpcTVeVWapqxiwSo3
         n11zCUHT8Z88grqRGdOf1VFzgDEfcWcWBGeZ/7WWjDR9gN2FkGAC6g8cH62kpZYLOn
         9+lmZaOUcED+w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Thompson <davthompson@nvidia.com>,
        Asmaa Mnebhi <asmaa@nvidia.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, sre@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 01/18] pwr-mlxbf: extend Kconfig to include gpio-mlxbf3 dependency
Date:   Sat,  7 Oct 2023 20:48:35 -0400
Message-Id: <20231008004853.3767621-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.6
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

From: David Thompson <davthompson@nvidia.com>

[ Upstream commit 82f07f1acf417b81e793145c167dd5e156024de4 ]

The BlueField power handling driver (pwr-mlxbf.c) provides
functionality for both BlueField-2 and BlueField-3 based
platforms.  This driver also depends on the SoC-specific
BlueField GPIO driver, whether gpio-mlxbf2 or gpio-mlxbf3.
This patch extends the Kconfig definition to include the
dependency on the gpio-mlxbf3 driver, if applicable.

Signed-off-by: David Thompson <davthompson@nvidia.com>
Reviewed-by: Asmaa Mnebhi <asmaa@nvidia.com>
Link: https://lore.kernel.org/r/20230823133743.31275-1-davthompson@nvidia.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index fff07b2bd77b9..62f592e617339 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -307,7 +307,7 @@ config NVMEM_REBOOT_MODE
 
 config POWER_MLXBF
 	tristate "Mellanox BlueField power handling driver"
-	depends on (GPIO_MLXBF2 && ACPI)
+	depends on (GPIO_MLXBF2 || GPIO_MLXBF3) && ACPI
 	help
 	  This driver supports reset or low power mode handling for Mellanox BlueField.
 
-- 
2.40.1

