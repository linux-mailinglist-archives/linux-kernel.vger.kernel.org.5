Return-Path: <linux-kernel+bounces-113339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C08B888388
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC191F21E56
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8D86D1BC;
	Sun, 24 Mar 2024 22:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlnzaLY9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF0E197CAB;
	Sun, 24 Mar 2024 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320140; cv=none; b=RbOpGVNw8ASGHhXnEhNzZNp19ffxbVbSL4jsfW+o6ke20Kbyubk5FTY2h7l8dsCdYAC1pj6ZklhQWpAhzTKV/8IpSaOdlgFGTX6VlFPi/H6FmH6hU+A6jsY5FD1IHsK/9jm4BcuAE+HSjB8pWoYJX1HNo31Bdbf/zKFENmZbBHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320140; c=relaxed/simple;
	bh=03PMzaGnZQiUzLPb/Zjij3vJldyv3GiCMg42UjCblhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nrsUq+BIaH4Hs2O2/sZj8azknKc6vhfd+3/s02YeAppX1dHfX2Mz6chEUypxDoLCP/i0HW3p3GnP+eNBb790WY/lJAGr1GZj+yb40FFAZiJFQR+N9vgzRiUmUTk8FNYzYd+9ssXjJTiDDoKJ7+r2jsUlfPopGDyWXvDoUBlEPzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlnzaLY9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D7EC433C7;
	Sun, 24 Mar 2024 22:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320140;
	bh=03PMzaGnZQiUzLPb/Zjij3vJldyv3GiCMg42UjCblhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WlnzaLY9Na3U0GI9qz9v4ECMmJwAhDapwH6XRuTeC7ULZuiQzL2UqijiYMvF67+Te
	 RKy4vUjg/4/DsssKd8Mqx/4uOKaXBFOkuCRyEhqzWGYUrUyVHFafr6bmmeXgZJ/H5A
	 KWdDA8I4pDReSc9Mk3SjPkOHHJVScVlIgfdIBj7Iy7mU9PG3z+nP+Vug9UZU9FigpQ
	 zTriORl2l5iGZmairhpWBPuVCnSqOlDB8AFMkib6z/F7HnxaQejucBnHV0u1i4BWzw
	 jZ23kUy2rvZPaFM03QpP2VHNZfJxesJanSMKfhS78ili81iDRpFugPC9x0tj6BDBuV
	 Wm/7Ijf7JYQXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?J=C3=B6rg=20Wedekind?= <joerg@wedekind.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 448/715] PCI: Mark 3ware-9650SE Root Port Extended Tags as broken
Date: Sun, 24 Mar 2024 18:30:27 -0400
Message-ID: <20240324223455.1342824-449-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index d797df6e5f3e9..2ebbe51a7efe0 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5527,6 +5527,7 @@ static void quirk_no_ext_tags(struct pci_dev *pdev)
 
 	pci_walk_bus(bridge->bus, pci_configure_extended_tags, NULL);
 }
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_3WARE, 0x1004, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0132, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0140, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0141, quirk_no_ext_tags);
-- 
2.43.0


