Return-Path: <linux-kernel+bounces-156870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C518B097E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2C10B26271
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BF015B115;
	Wed, 24 Apr 2024 12:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="kjCKQRgS"
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB24815AD9D;
	Wed, 24 Apr 2024 12:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961727; cv=none; b=PvdNWgbQGZeo9lxjgAxR93GFENO21+pIdxKLU5YT6UlkOqfKxCN/uJl1bi9pwyYSfxI287gzYLEHozHaBnogzapoagHXX5pKvEWgTfQKEFhj1meK2+l4vEBESPT4eftDPTwLy6sPo3fgtDXZzH5xIp1i59rUldPvWdSF8GCJst0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961727; c=relaxed/simple;
	bh=BE7LvHhy1jcP9dVf2+G9dk0Puo2poqCn/ow8d+Ul8Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i2QiUpvxK/hGRc+r4SAOqAf+ZYSwAZKTkwACRl09ml4xtQ1oAzq8R8JQj7xqBdCcjLbZrq5RgKWFHdBYkvMZz9oUNeinaRVFXpEz66gcn/hzJoUvyHv6nQKC15FSpyGiKUme5TAXYiCY/7BWWJPEDuiYKceWHVQroEN+NGU1n+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=kjCKQRgS; arc=none smtp.client-ip=80.12.242.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id zbijrKEx3tES9zbijrejgW; Wed, 24 Apr 2024 14:27:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713961652;
	bh=0euCcEnVXaCbghlJdcYSkVKJP6L0D104GpN/D1rVMRM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=kjCKQRgS5F+ta/B+KkLL4Abevv9pFTJrXd1PrbjwS9rhV7Eura+IHlVS+CjZ2U0ru
	 b3QTqFYgY8EHvdzXrgKHx6LwR1h9OLKklY4cdbRZ8ZISpgk7iA2w8TTZtB0dd+0eaz
	 SWzOVpPkuiUNvOePgKOGo4o3bWsBT3B6Quccjg9WjJf9T7fu7EpgGSnaKpfYT7gUz/
	 Ws296KA4IigfMYQVrKGjGye3BQbP4SIrij3dLoDn2toV4VVbC69E9fx9hnjDAloULi
	 rblZ7RUqyJWpg5eZlskUP+BhybPXkJ/ukSb7k2A8cwigtRpv63MZqTIedkjpzvtupr
	 ctOtp4GVEOXtw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 24 Apr 2024 14:27:32 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jorgen Hansen <jhansen@vmware.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] VMCI: Fix an error handling path in vmci_guest_probe_device()
Date: Wed, 24 Apr 2024 14:27:23 +0200
Message-ID: <a35bbc3876ae1da70e49dafde4435750e1477be3.1713961553.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After a successful pci_iomap_range() call, pci_iounmap() should be called
in the error handling path, as already done in the remove function.

Add the missing call.

The corresponding call was added in the remove function in commit
5ee109828e73 ("VMCI: dma dg: allocate send and receive buffers for DMA
datagrams")

Fixes: e283a0e8b7ea ("VMCI: dma dg: add MMIO access to registers")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/misc/vmw_vmci/vmci_guest.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index c61e8953511d..476af89e751b 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -625,7 +625,8 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	if (!vmci_dev) {
 		dev_err(&pdev->dev,
 			"Can't allocate memory for VMCI device\n");
-		return -ENOMEM;
+		error = -ENOMEM;
+		goto err_unmap_mmio_base;
 	}
 
 	vmci_dev->dev = &pdev->dev;
@@ -642,7 +643,8 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 		if (!vmci_dev->tx_buffer) {
 			dev_err(&pdev->dev,
 				"Can't allocate memory for datagram tx buffer\n");
-			return -ENOMEM;
+			error = -ENOMEM;
+			goto err_unmap_mmio_base;
 		}
 
 		vmci_dev->data_buffer = dma_alloc_coherent(&pdev->dev, VMCI_DMA_DG_BUFFER_SIZE,
@@ -892,6 +894,10 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 err_free_data_buffers:
 	vmci_free_dg_buffers(vmci_dev);
 
+err_unmap_mmio_base:
+	if (mmio_base != NULL)
+		pci_iounmap(pdev, mmio_base);
+
 	/* The rest are managed resources and will be freed by PCI core */
 	return error;
 }
-- 
2.44.0


