Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445657AC988
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjIXNc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjIXNbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:31:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D514A1BCB;
        Sun, 24 Sep 2023 06:18:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F337CC43397;
        Sun, 24 Sep 2023 13:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561505;
        bh=OfNP2Az0qX+Oly80ZesppAT1QNyvdyQFnyCBfhrL83M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nndyLwbKRkWEW9CsBCYLc+kf0QHBAe/r/pGTFQ5sXF8dMGuPZyN5h41UHfmP5z6TY
         cS4BOkXTFRyYXQTet/iu3wMVy6H+oBs6BTVwyXuJ8+f13IpF1emTDQCse81eYvxkyI
         R+gVWnvlkZ463/tpyAROpg2UKs8mKsxGJszcCNBdFRIeEU1pR0r77N51RG+GlPU2wq
         1U+4dqo5O6obbq/7Pxyjk9CRHbsZYW+u6qtrPTw8OrltkKLKsFZPm/1BUhCX6HuRzN
         yiWSRJVCxnvYlj+hhu0PRixsqOiWXVBIUwtRzwQBORsFp724tC68zd69s7TTYjrG1u
         9UK53Q6wP959g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Thompson <davthompson@nvidia.com>,
        kernel test robot <lkp@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>, ilpo.jarvinen@linux.intel.com,
        markgross@kernel.org, vadimp@nvidia.com,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 17/28] platform/mellanox: mlxbf-bootctl: add NET dependency into Kconfig
Date:   Sun, 24 Sep 2023 09:17:34 -0400
Message-Id: <20230924131745.1275960-17-sashal@kernel.org>
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

From: David Thompson <davthompson@nvidia.com>

[ Upstream commit c2dffda1d8f7511505bbbf16ba282f2079b30089 ]

The latest version of the mlxbf_bootctl driver utilizes
"sysfs_format_mac", and this API is only available if
NET is defined in the kernel configuration. This patch
changes the mlxbf_bootctl Kconfig to depend on NET.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309031058.JvwNDBKt-lkp@intel.com/
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: David Thompson <davthompson@nvidia.com>
Link: https://lore.kernel.org/r/20230905133243.31550-1-davthompson@nvidia.com
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/mellanox/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/mellanox/Kconfig b/drivers/platform/mellanox/Kconfig
index 30b50920b278c..f7dfa0e785fd6 100644
--- a/drivers/platform/mellanox/Kconfig
+++ b/drivers/platform/mellanox/Kconfig
@@ -60,6 +60,7 @@ config MLXBF_BOOTCTL
 	tristate "Mellanox BlueField Firmware Boot Control driver"
 	depends on ARM64
 	depends on ACPI
+	depends on NET
 	help
 	  The Mellanox BlueField firmware implements functionality to
 	  request swapping the primary and alternate eMMC boot partition,
-- 
2.40.1

