Return-Path: <linux-kernel+bounces-130356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 441D1897719
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67711F2F990
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A897B16E864;
	Wed,  3 Apr 2024 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBcJ9jh9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF2F16DED1;
	Wed,  3 Apr 2024 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164818; cv=none; b=Vz9Vc1gJT/2Xg9oRvqqCK2liE8kukcR2Lf6MNK65NDbt+PHO5JFyj4wptEoz/LNPYZwK1t1R8JjMriXWPZ3MqxAnvtl3QdlHPv+7gIem6fKOteRhM9CCN2kqzxXnRT/TLnaHTOnzwg1sPuELTrL7lXldgGgVKBkZfOWGTGlfzc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164818; c=relaxed/simple;
	bh=Rrm8tWYaGkWcXihbvaPJj6PlMYoXcogn9JU65JdeccM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXR4CtBp4hFmysqf0eCMmNxGEMBxeVlVtjk9GfizP9uNelLINVNsrJlTTjqVv+jXyTydCNgjU/TlzLoLCh92V++qBT9vY0ftsAbeIXpTfP3JbYPkgi308TFXb98+wRGHteGRpYlcS9mwRfjRCLWGCQyioPFwoW/lKuGeH+QRhKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBcJ9jh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880FAC43390;
	Wed,  3 Apr 2024 17:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164817;
	bh=Rrm8tWYaGkWcXihbvaPJj6PlMYoXcogn9JU65JdeccM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aBcJ9jh9COQNHt1G06ZaNvxrhVHiP558x27q8Gpq1cQtVa/BSWnQJUrzP1wCEFtqF
	 hfr/iXeu/rdKHXUvF7p+dix/hKCNvTZLAGtdmAueqHFGqJoYdLYbhMVOcfqI9ioXEv
	 YU4LAwRzKm5hOGqRwfMxHt1FmMLcU3MGXFSlzc0FI+knpVaUwV3L6+1O8WvllvZhju
	 bdQehZ4U/KebvWqM/4IujR16IpYeb+y3jwpxIRU30V2lBsz+BhTTpVa7coK/uW9PvX
	 22fVtZaabkI9+/sBB2U6DsOzXBYOqoYrkq8Cg6nh2JwjCY/Gwnt+S1f/osRALh4nYY
	 55tV5a/divTRg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Jiawei Fu (iBug)" <i@ibugone.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 7/8] drivers/nvme: Add quirks for device 126f:2262
Date: Wed,  3 Apr 2024 13:20:01 -0400
Message-ID: <20240403172006.353022-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403172006.353022-1-sashal@kernel.org>
References: <20240403172006.353022-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
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
index 970a1b374a669..5242feda5471a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3199,6 +3199,9 @@ static const struct pci_device_id nvme_id_table[] = {
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


