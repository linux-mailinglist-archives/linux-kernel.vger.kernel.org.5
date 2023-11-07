Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9052E7E440E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344395AbjKGPtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344360AbjKGPs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:48:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3822699;
        Tue,  7 Nov 2023 07:48:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533BBC433CA;
        Tue,  7 Nov 2023 15:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372092;
        bh=DO4fpqc4U5U4PKy2Hakqr/6aYN5jt0n5NWZpwDLc8GU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t8svN/OmOKhjTj0oilagKitRB3k3ICs3g7VY5YqJWy9dWUFlAsGiIg8UKWFwXK7Ar
         YTahIWcSa/30r4/s2aE91SJT4397600aZpYpcE6RzTTlxRc0WkTOp1gKViW0OR9uDO
         4RdyBT7vBW2srtPnpQc2ZnL4QbRhkO0p0ak8tl1uvzvqcKLQDmYV1cou7HoWVJLP39
         Q2UoX934b+a3Uhwkt0T7upEfph9nA/TTtmY8VeFeRj/Urp8+rCiBtA+Puf7hC/QK2w
         D9i3UYAS9Sb1t7+4KM9cv7Vng6HBY0IF+pMVe/ZY6nFtmRzGIuopbpZbLZV7qp4+Na
         WkLaCGF1YeNmw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 36/36] mfd: intel-lpss: Add Intel Lunar Lake-M PCI IDs
Date:   Tue,  7 Nov 2023 10:46:18 -0500
Message-ID: <20231107154654.3765336-36-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107154654.3765336-1-sashal@kernel.org>
References: <20231107154654.3765336-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
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

