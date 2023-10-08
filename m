Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A567BCAE6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 02:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbjJHAuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 20:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbjJHAtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 20:49:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5905D61;
        Sat,  7 Oct 2023 17:49:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5CBC433D9;
        Sun,  8 Oct 2023 00:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696726172;
        bh=CvsbMA6o1hf6s0sGhwFv37Z+xi+UkOfltBQ25XUEmjo=;
        h=From:To:Cc:Subject:Date:From;
        b=GM6RDysZPJqlY8ctoXLBeVN7dRb7iFpTgL10KA0xqAJpFWGnyE1W3j0pM5tTILYpd
         xDyYOyYKrd5IFRDqS0ClxWfGZIWkEqpZZJaub1OtlronAuJcfsOx6fozxG/k3zjcZ5
         2YtXv+J+wvqlbVhMEUgWcoHL7CjPcQ2x4g5PDJfBjdfUJVvwZ7uXXQ+cmrfKob7nQo
         o8yMmgPEtm7zfEjeDOT7t+bGZ2ZjIBT4HxcllcceyghIMOvDGwU7WlYLC9Yv2QGeva
         CLutJkqyWD2orKszU394V8lT9h9dEQl10OL4opXwNn3R1vHVluZnbJTw9jp+8675Si
         k4T0jZQHFYOTA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Thompson <davthompson@nvidia.com>,
        Asmaa Mnebhi <asmaa@nvidia.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, sre@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 01/12] pwr-mlxbf: extend Kconfig to include gpio-mlxbf3 dependency
Date:   Sat,  7 Oct 2023 20:49:18 -0400
Message-Id: <20231008004929.3767992-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.56
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
index a8c46ba5878fe..54201f0374104 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -299,7 +299,7 @@ config NVMEM_REBOOT_MODE
 
 config POWER_MLXBF
 	tristate "Mellanox BlueField power handling driver"
-	depends on (GPIO_MLXBF2 && ACPI)
+	depends on (GPIO_MLXBF2 || GPIO_MLXBF3) && ACPI
 	help
 	  This driver supports reset or low power mode handling for Mellanox BlueField.
 
-- 
2.40.1

