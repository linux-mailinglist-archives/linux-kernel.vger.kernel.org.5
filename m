Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D927E456A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344045AbjKGQAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344052AbjKGP61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:58:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3566A65;
        Tue,  7 Nov 2023 07:51:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82586C433C8;
        Tue,  7 Nov 2023 15:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372290;
        bh=DO4fpqc4U5U4PKy2Hakqr/6aYN5jt0n5NWZpwDLc8GU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nok9b4sTRP1/La1ZvPqShAARq+zsIUP/odeUHQUKdmjth2o7vTKtTLnTjLysSv2WT
         1MwrCRYrMUxYg5VTlN/ojoZxVG3z7kHrHiWsSF0VpKSSSJm1B3oJ8BE3owHaQyc5fm
         oZOHfFYnn+M6r31GberOee5wUvppk2UN46LSDBV4Xrx6JOfhJOnNJJmAtrV0d3tYUk
         aCVxFMVXMNv5N2kGFg4mJb2T/5upwNC0VW54PT2ig/MWlonYK5xeIoL1lnnsr1GxEw
         0xKcvMaRv1/X6YXtitifkiKkNo5GqzFM8pwe61f/J9ENij5jV5/X6BmADA2jjR2NDk
         sizlyValGtcuw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 30/30] mfd: intel-lpss: Add Intel Lunar Lake-M PCI IDs
Date:   Tue,  7 Nov 2023 10:50:04 -0500
Message-ID: <20231107155024.3766950-30-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155024.3766950-1-sashal@kernel.org>
References: <20231107155024.3766950-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.61
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarkko Nikula <jarkko.nikula@linux.intel.com>

[ Upstream commit e53b22b10c6e0de0cf2a03a92b18fdad70f266c7 ]

Add Intel Lunar Lake-M SoC PCI IDs.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Link: https://lore.kernel.org/r/20231002083344.75611-1-jarkko.nikula@linux.intel.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/intel-lpss-pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 699f44ffff0e4..ae5759200622c 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -561,6 +561,19 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0xa3e2), (kernel_ulong_t)&spt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0xa3e3), (kernel_ulong_t)&spt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0xa3e6), (kernel_ulong_t)&spt_uart_info },
+	/* LNL-M */
+	{ PCI_VDEVICE(INTEL, 0xa825), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0xa826), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0xa827), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0xa830), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0xa846), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0xa850), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa851), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa852), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0xa878), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa879), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa87a), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa87b), (kernel_ulong_t)&ehl_i2c_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, intel_lpss_pci_ids);
-- 
2.42.0

