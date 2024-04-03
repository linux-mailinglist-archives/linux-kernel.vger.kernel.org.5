Return-Path: <linux-kernel+bounces-130321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A468976BE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 285841F2F034
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0193B15572A;
	Wed,  3 Apr 2024 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8Tbkdf5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FFE15ECC9;
	Wed,  3 Apr 2024 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164727; cv=none; b=m+5J+jwfjzIeGcsBYq1z3ACg4GBcsoK46fmnEgLZZRfTSxqxtWrE/qJq/tnCwbjC4j2th7SacQDecLbfP6k/sVT8Ggu6Qpgk2ed2sa9d2Mu0ftLx64UWhCQh9O0ZW+MCznK7LRKWajPFAjF7ygAbhRy/FGdYfmyYoLM47AMQgqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164727; c=relaxed/simple;
	bh=1/r2T1+lH3xh1cw8Hf+XNHbZmRnlMRWWJGmhtTvCMNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrHDtnQv/Q5oLQKm7gOI2JqVbVgGH/WFUu1+Co327udOAPS8DjYoc7TUMSstAQ02/ef197KuIMtlWJsxT1NKSAFlgeFEdDVVWhfu6kr+i+psO+AcX26okrsOkTGli8UA8X1tpMOY3PIx5IzI+JTfDNK3R6ak1O40e4gIzyoXAHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8Tbkdf5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022A2C43143;
	Wed,  3 Apr 2024 17:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164726;
	bh=1/r2T1+lH3xh1cw8Hf+XNHbZmRnlMRWWJGmhtTvCMNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t8Tbkdf5GIfbY7PIKFZFKMMgGTQrHC5Kx4IDb54gfUvpi88YqmmtZ5Pz38Rm6CbxS
	 PfgFNUpKDu/Yi+sus6zYf8nBOUiNgxZZDlpLEzbtHjNHV2US/BoHrPaVPxoOLF6hK4
	 dx3nSN8DtlS5lgYzczjxvLgFiANmzihAH02HE5kUCjOX3iOqckVnTef57HimY8AjS7
	 4X/MWuWQUFN9sCyO/7w4+sAvUXi5ENvudbe2RIMhmS1DEgs6tSRs4wp5Pq8LS1WlVA
	 k+VdlAE5VLr+fiM7zquY/GhZ30vCfasBNbXycKaQOCQgKweVwgr3jkWn6LbTmeJ996
	 Qqc4zdKcOxKXw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Jiawei Fu (iBug)" <i@ibugone.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 17/20] drivers/nvme: Add quirks for device 126f:2262
Date: Wed,  3 Apr 2024 13:17:58 -0400
Message-ID: <20240403171815.342668-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171815.342668-1-sashal@kernel.org>
References: <20240403171815.342668-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.24
Content-Transfer-Encoding: 8bit

From: "Jiawei Fu (iBug)" <i@ibugone.com>

[ Upstream commit e89086c43f0500bc7c4ce225495b73b8ce234c1f ]

This commit adds NVME_QUIRK_NO_DEEPEST_PS and NVME_QUIRK_BOGUS_NID for
device [126f:2262], which appears to be a generic VID:PID pair used for
many SSDs based on the Silicon Motion SM2262/SM2262EN controller.

Two of my SSDs with this VID:PID pair exhibit the same behavior:

  * They frequently have trouble exiting the deepest power state (5),
    resulting in the entire disk unresponsive.
    Verified by setting nvme_core.default_ps_max_latency_us=10000 and
    observing them behaving normally.
  * They produce all-zero nguid and eui64 with `nvme id-ns` command.

The offending products are:

  * HP SSD EX950 1TB
  * HIKVISION C2000Pro 2TB

Signed-off-by: Jiawei Fu <i@ibugone.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f8e92404a6591..b985142fb84b9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3361,6 +3361,9 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_VDEVICE(REDHAT, 0x0010),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x126f, 0x2262),	/* Silicon Motion generic */
+		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
+				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x126f, 0x2263),	/* Silicon Motion unidentified */
 		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST |
 				NVME_QUIRK_BOGUS_NID, },
-- 
2.43.0


