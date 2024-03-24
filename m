Return-Path: <linux-kernel+bounces-115495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2458E889F14
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23D41B47B4D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864742317F0;
	Mon, 25 Mar 2024 02:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lI7v5zl/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4031EAD2D;
	Sun, 24 Mar 2024 22:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320917; cv=none; b=iDh6e0X5ZjInUovZVjLzZ+xjy/NMaVpmEohjXxPhoHX3OWQMqyMnsu8O3VzeyfPOfAscSlqGrLF9djt5MbZDT7K+6wNzaXJoXgtrrbQrJVAFGH8wX7lzZ2GFkM304wA9YDjC827NOI98DmedOhHvtGKmCuR6fdqZPD+Rt0Qrits=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320917; c=relaxed/simple;
	bh=981DKCF6SxXTVV/XrFilV6gtQBHTCQLEtUX3SzrY2Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J+hpCliQ6yWiEic7lWJXxvZtKlZF3LRQOxTlEsCdTdytcmKPtrPq/ztvYTBNI8wFhGICxshcirk4BArHl3xLMNTTOC4nZKr/aormkGk8J7XHlHvzIx/iiiccn6jXviwOZKmZMlL4zDBlR+WHg7x7CrmnMO0cLQuBnAStgHhfU4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lI7v5zl/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1446BC433A6;
	Sun, 24 Mar 2024 22:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320916;
	bh=981DKCF6SxXTVV/XrFilV6gtQBHTCQLEtUX3SzrY2Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lI7v5zl/8Y+tVtPu7FkkQynEMg3/29xvdz+D0GZFEbYofWk3orjxMeR5CRchk6zuN
	 lq1YEkoBdUeaGoqE7ScKEvd+TdPJWQk/WgPRppLsgTy2wyh4wESLPZwZ65GUGJYR0R
	 94KsDis0yPwn2Mswms6ZpmSqW9BxY5tN7xqvVl+YBjf3nUbdBosd03UvKUrJkHuyum
	 X4BYXSNXWW0og5vQo2uFs6bBFNb/GwLc9NqkzC4n+Oqv+b85bzKKAQKvP1inmfBVHT
	 rRAXVsTDF0KY9SgbjtL7Lkt1/WeN3/YRv9ftq+9O1qZXNEhDqfoG1oQT2ok8pY7b1y
	 6U5Ka6VUM3hIg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?J=C3=B6rg=20Wedekind?= <joerg@wedekind.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 480/713] PCI: Mark 3ware-9650SE Root Port Extended Tags as broken
Date: Sun, 24 Mar 2024 18:43:26 -0400
Message-ID: <20240324224720.1345309-481-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index a2bf6de11462f..528044237bf9f 100644
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


