Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC5F7E3D62
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbjKGM2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbjKGM1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:27:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E511BD5;
        Tue,  7 Nov 2023 04:12:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E426C433CC;
        Tue,  7 Nov 2023 12:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359171;
        bh=G1LZmW0uj2wl31zbRTfBEtzBFB1PwJzMm9gk0a9oPXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U4BIOuVi+yLap5lcEcbQUBxO+hEGPe7D87+csNmdDe1KDIJu75zZJrii4O6u30MOX
         z//VyTSJ/xj35NdT5xGJkJkKqzj/VYXy9aaRccp1XSTsMiELK5mJ0g8cLAr5/eNwPm
         7IxqmrZs7HyqgTSbfw34HDA8V/yNktBE97KsX89R+KRhsSANoJDW8kDbscG9NUgBOa
         yr2V3oIDoOWdtr+9Yk0jfQVS/0EOQ4NFDdfh4VUx2wt2weVtd2TX3MpE+Ug07WW6eX
         h10NYUVXurY3L7JaR9RL7XpfdMxzheAGCM+NiaoE+MUP0ltz+hG6D0hNlYtZcJCWds
         tf5+4gh1ctGoQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Olli Asikainen <olli.asikainen@gmail.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, hmh@hmh.eng.br,
        hdegoede@redhat.com, markgross@kernel.org,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 11/11] platform/x86: thinkpad_acpi: Add battery quirk for Thinkpad X120e
Date:   Tue,  7 Nov 2023 07:12:26 -0500
Message-ID: <20231107121230.3758617-11-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121230.3758617-1-sashal@kernel.org>
References: <20231107121230.3758617-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.199
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olli Asikainen <olli.asikainen@gmail.com>

[ Upstream commit 916646758aea81a143ce89103910f715ed923346 ]

Thinkpad X120e also needs this battery quirk.

Signed-off-by: Olli Asikainen <olli.asikainen@gmail.com>
Link: https://lore.kernel.org/r/20231024190922.2742-1-olli.asikainen@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/thinkpad_acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index d8d241344d22d..00ca996b4d4b9 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -9718,6 +9718,7 @@ static const struct tpacpi_quirk battery_quirk_table[] __initconst = {
 	 * Individual addressing is broken on models that expose the
 	 * primary battery as BAT1.
 	 */
+	TPACPI_Q_LNV('8', 'F', true),       /* Thinkpad X120e */
 	TPACPI_Q_LNV('J', '7', true),       /* B5400 */
 	TPACPI_Q_LNV('J', 'I', true),       /* Thinkpad 11e */
 	TPACPI_Q_LNV3('R', '0', 'B', true), /* Thinkpad 11e gen 3 */
-- 
2.42.0

