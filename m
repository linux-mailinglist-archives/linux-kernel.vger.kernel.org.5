Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C487CDEC5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbjJRONw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbjJROM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:12:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24250D6A;
        Wed, 18 Oct 2023 07:12:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C43C433CA;
        Wed, 18 Oct 2023 14:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638369;
        bh=/o4D3CiiQwVmur8A7n+OX+pFGE+/0DOKTX2KzUcz84Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AM/euJk+T9jEZ5s9n5fee9bsYIIyu70p+ydQVu9lUQ3C7v4x+143g+IdB6/RnkKyF
         8DGWw25UnQPJQ7HT2Vs5hwSZH76DRsRRVpQbztFcGCoyKcYpDwepMW7aHm4w7QjPU/
         iO6w3YI+Z8ZgubnLllCAMz9SLDtC3bTNU7llJSC/1AQ5NsC4RWQJ9uN5cYWMAywDZw
         ThbGUUpr8+La3IXJ9zvPyaLZDgkoPoTTdiOKkOVuA+QYJhg2829b36vQTOG1JBGHr8
         wV01X9FAdYrmwvo19xpRxekMLMf3AQgxHhM859qq5NQMshnqhE1ETYD0/+q+qn4wIi
         O21lm/I0i8GCA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        August Wikerfors <git@augustwikerfors.se>,
        Francesco <f.littarru@outlook.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 23/31] ACPI: resource: Add TongFang GM6BGEQ, GM6BG5Q and GM6BG0Q to irq1_edge_low_force_override[]
Date:   Wed, 18 Oct 2023 10:11:40 -0400
Message-Id: <20231018141151.1334501-23-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141151.1334501-1-sashal@kernel.org>
References: <20231018141151.1334501-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.7
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit f9b3ea02555e67e2e7bf95219953b88d122bd275 ]

The TongFang GM6BGEQ, GM6BG5Q and GM6BG0Q are 3 GPU variants of a TongFang
barebone design which is sold under various brand names.

The ACPI IRQ override for the keyboard IRQ must be used on these AMD Zen
laptops in order for the IRQ to work.

Adjust the pcspecialist_laptop[] DMI match table for this:

1. Drop the sys-vendor match from the existing PCSpecialist Elimina Pro 16
   entry for the GM6BGEQ (RTX3050 GPU) model so that it will also match
   the laptop when sold by other vendors such as hyperbook.pl.

2. Add board-name matches for the GM6BG5Q (RTX4050) and GM6B0Q (RTX4060)
   models.

Note the .ident values of the dmi_system_id structs are left unset
since these are not used.

Suggested-by: August Wikerfors <git@augustwikerfors.se>
Reported-by: Francesco <f.littarru@outlook.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217394
Link: https://laptopparts4less.frl/index.php?route=product/search&filter_name=GM6BG
Link: https://hyperbook.pl/en/content/14-hyperbook-drivers
Link: https://linux-hardware.org/?probe=bfa70344e3
Link: https://bbs.archlinuxcn.org/viewtopic.php?id=13313
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/resource.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 32cfa3f4efd3d..f5ed33873dfde 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -500,16 +500,23 @@ static const struct dmi_system_id maingear_laptop[] = {
 
 static const struct dmi_system_id pcspecialist_laptop[] = {
 	{
-		.ident = "PCSpecialist Elimina Pro 16 M",
-		/*
-		 * Some models have product-name "Elimina Pro 16 M",
-		 * others "GM6BGEQ". Match on board-name to match both.
-		 */
+		/* TongFang GM6BGEQ / PCSpecialist Elimina Pro 16 M, RTX 3050 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "PCSpecialist"),
 			DMI_MATCH(DMI_BOARD_NAME, "GM6BGEQ"),
 		},
 	},
+	{
+		/* TongFang GM6BG5Q, RTX 4050 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM6BG5Q"),
+		},
+	},
+	{
+		/* TongFang GM6BG0Q / PCSpecialist Elimina Pro 16 M, RTX 4060 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM6BG0Q"),
+		},
+	},
 	{ }
 };
 
-- 
2.40.1

