Return-Path: <linux-kernel+bounces-115704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD53889724
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20B171F35115
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A5A210A5F;
	Mon, 25 Mar 2024 02:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jslfhdTy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDFD15380D;
	Sun, 24 Mar 2024 23:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321701; cv=none; b=IaLX6/fe4u4g6hl+HeQIS36f1ODjSFO9rD6/8HEdvCyFB9lDuolKJ7F6iDXqLSTujuybrABRwnc7lCkP2pi1bnfiXGYLmNTJ2yOvDCb21vLqvhMOYMLjPp+FDiNRqVwzIZe6Zrl9HZHzV6HvMO4ov37YRk3Qy5HUd/ynJ17Qo3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321701; c=relaxed/simple;
	bh=da0v28uYIBgfQoka5OnAj9jwTvwhT7/5iIL5RdHgY+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qwzsd4eB6tX8xRRvyfxT2PPc5rKJoyPkByiB2hYSjkZquwEg2R2TGXp5GqmFETCXIqBM98BoEUJU6bBmzrELeaB63P045UCwsR/d5raiaRGtiArA5wwPBSBLurbsh1AvNpyScYFQNgcqPsHvQS9m7jVgO8ZQLODlWKktbjhs/X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jslfhdTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD32C43399;
	Sun, 24 Mar 2024 23:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321700;
	bh=da0v28uYIBgfQoka5OnAj9jwTvwhT7/5iIL5RdHgY+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jslfhdTy5UghOruz09HuuTekAHTw3waSHU/rQaUeFxenoSGwxstZdOIcJDcyXmuB+
	 0F0faT2sEM2cjL2UtjaZXZjT9HUHkuVCw9VnwewZa3LbsSkpaUIbDyQF+aA1BLcqTL
	 FNAu/b8wrBjOwP/MT+tWa2cGtlnmvp6Tah7HJNfHn2Q6TCtIs9fWdcOO4+3CNuKuW+
	 3fl2iti6xP/ixlYLxA5WuL37jbwqjxvbRGADnGVtxHBcxSDfUdjylB0BYs5tA2q2WG
	 ROtdFUYq1A/jdbROSChhAOOr94zopDMY9f6Lr0qbdGgYZHp8qmdCGSc1Xjo2K5WgES
	 myfenCU/4QHWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?J=C3=B6rg=20Wedekind?= <joerg@wedekind.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 429/638] PCI: Mark 3ware-9650SE Root Port Extended Tags as broken
Date: Sun, 24 Mar 2024 18:57:46 -0400
Message-ID: <20240324230116.1348576-430-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jörg Wedekind <joerg@wedekind.de>

[ Upstream commit baf67aefbe7d7deafa59ca49612d163f8889934c ]

Per PCIe r6.1, sec 2.2.6.2 and 7.5.3.4, a Requester may not use 8-bit Tags
unless its Extended Tag Field Enable is set, but all Receivers/Completers
must handle 8-bit Tags correctly regardless of their Extended Tag Field
Enable.

Some devices do not handle 8-bit Tags as Completers, so add a quirk for
them.  If we find such a device, we disable Extended Tags for the entire
hierarchy to make peer-to-peer DMA possible.

The 3ware 9650SE seems to have issues with handling 8-bit tags. Mark it as
broken.

This fixes PCI Parity Errors like :

  3w-9xxx: scsi0: ERROR: (0x06:0x000C): PCI Parity Error: clearing.
  3w-9xxx: scsi0: ERROR: (0x06:0x000D): PCI Abort: clearing.
  3w-9xxx: scsi0: ERROR: (0x06:0x000E): Controller Queue Error: clearing.
  3w-9xxx: scsi0: ERROR: (0x06:0x0010): Microcontroller Error: clearing.

Link: https://lore.kernel.org/r/20240219132811.8351-1-joerg@wedekind.de
Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=202425
Signed-off-by: Jörg Wedekind <joerg@wedekind.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b5b96d2a9f4ba..1739fd54a3106 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5520,6 +5520,7 @@ static void quirk_no_ext_tags(struct pci_dev *pdev)
 
 	pci_walk_bus(bridge->bus, pci_configure_extended_tags, NULL);
 }
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_3WARE, 0x1004, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0132, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0140, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0141, quirk_no_ext_tags);
-- 
2.43.0


