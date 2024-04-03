Return-Path: <linux-kernel+bounces-130347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0667B897706
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC4A1C26B78
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DF216C863;
	Wed,  3 Apr 2024 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DghzODV1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57BC16C84B;
	Wed,  3 Apr 2024 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164797; cv=none; b=pKKvt/A30GF4qjKnevH7wbylPNuZL0r0qG/toIJUfd3Dftq6iqVWicgq5f+J5LPSxJS6ThqB4k1vQVQGHaE6jbv7Qw2br3pKJh7F5i4buvvUuOKEDm33C2WXUYLsjjN1YphrAS+erSfnaT9+hxotXLvwQxCOFsP3hCM61/NuKd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164797; c=relaxed/simple;
	bh=/wfGaD/enDrG7OtvffoRm8GavZjdjChuPzsdUzKMwTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oc4xEsg2RGBvw9dw8UJ4k1rDRVrxvSfK9+EjJ1oEd5+WetQWW68jlbpHHZN3HjZDCZ8h5cztuFWJRbX4BMiN1jKvpwafydzegOYeMxrUfcA+V0aZ5pFZ9sNpSWn9YB7n9uaD/cDffoMKE660T2xHatylNRR4OZ4WwYstjdQOBSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DghzODV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E781C433F1;
	Wed,  3 Apr 2024 17:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164797;
	bh=/wfGaD/enDrG7OtvffoRm8GavZjdjChuPzsdUzKMwTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DghzODV1In2aJUUjn/bQQwWuiQBit7dSVXebg6AJL2L4zlngiBCkOrrGokfIm21f0
	 ozGxSrutWcc2G+tVEYsgj4oTJVl90OKpXbWBRF86Rop+LsHEI2OxuNBr+ia79OGKly
	 QKFnv5sI7k/N77v4reu6D0NF2KwllEZOCbaQXHb6IgK4M1YUUgagyOHrgWS4NeY4tB
	 AdSPsWz/t8TMDRSDlQxKgVmlssuJ2rK4T42cVAkEuZozLic/7WK7MVnkpOlJFBngnR
	 jyTfXH1qDE9GEdus4q23F6W4l7yOq17pKduGt9iqE0RWLJC5DRc1B1/PoOYlcRdqKS
	 CHX1Vi1gwliJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Jiawei Fu (iBug)" <i@ibugone.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 7/8] drivers/nvme: Add quirks for device 126f:2262
Date: Wed,  3 Apr 2024 13:19:40 -0400
Message-ID: <20240403171945.350716-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171945.350716-1-sashal@kernel.org>
References: <20240403171945.350716-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
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
index fd20f3fdb1592..7bb74112fef37 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3339,6 +3339,9 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_VDEVICE(REDHAT, 0x0010),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x126f, 0x2262),	/* Silicon Motion generic */
+		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
+				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x126f, 0x2263),	/* Silicon Motion unidentified */
 		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST, },
 	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
-- 
2.43.0


