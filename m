Return-Path: <linux-kernel+bounces-99100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C071487836F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4B0281A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6007A6351E;
	Mon, 11 Mar 2024 15:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rT7fVQDx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9EE63503;
	Mon, 11 Mar 2024 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170054; cv=none; b=p+ZrgXRlykBRRmxsbrvUERYcjn/Epmhn71q8LX2vUwMtvzAHgfHXZvwzjEyx8Vaty+gHBedm8cm83/Kl2Bw/4vsnKROfRO1Ii5k24dC1xcG7/Sx/0gAtC47KxZvNDE2/7VhSyxTeOYGqSjJjbMSnlCrTacHCbbtd1ROaqaW75fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170054; c=relaxed/simple;
	bh=AneSAr7fcn+l7mSuH9qEQW1aIS9Ep3TVbKk6AAQotGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gajJ/uvfbyXAnO4dAupNMIC/x1wFf4828Wtpgzyq/vsPO+JrNJuwinEXcY2OEWekjpXbrsBxLq0I6DwI6Pc6BLWieUdY8D+aCV4nnb/+5Fgz1SXMYH9narX3kVNzJzeEBmG+0R8w5hvuqtqkRXxhhwGEDDtvvzUfRmTaMhlpiys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rT7fVQDx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1C3C43390;
	Mon, 11 Mar 2024 15:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710170054;
	bh=AneSAr7fcn+l7mSuH9qEQW1aIS9Ep3TVbKk6AAQotGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rT7fVQDxm8sMz3aMWVxLa8t/OXeHDUgS+hew6lGlfjD9jgQ+bbeX4M3BtczAIsbnD
	 6Ppu5xpKP4K+Qss0P/zLviakIDcv+l6J5DjeUQgRXJ9dkzi6EIjh4YdbQdnoZn2GdJ
	 IW+tXMwKMcT8jQdnMH5/egCKYjF+MhwFvBPrPI7F3ly2Yo1143MKaVH1ZjggOURddj
	 0inIsmZXHMY0LHAFgjX3bSYFzektDH8u7rPnnyYb+3R+YNp8Mqjd3EhDfKC/NZKO5L
	 +w5hOllXJdk2gyvwCLumbcVRqUbEzPcbUIEPqQWosIdeCNcgrjBl/Llq0nqAquEMRJ
	 0tXLqiGI4zxHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiawei Wang <me@jwang.link>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	Vijendar.Mukunda@amd.com,
	Syed.SabaKareem@amd.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 09/13] ASoC: amd: yc: add new YC platform variant (0x63) support
Date: Mon, 11 Mar 2024 11:13:44 -0400
Message-ID: <20240311151354.318293-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151354.318293-1-sashal@kernel.org>
References: <20240311151354.318293-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.81
Content-Transfer-Encoding: 8bit

From: Jiawei Wang <me@jwang.link>

[ Upstream commit 316a784839b21b122e1761cdca54677bb19a47fa ]

The Lenovo 21J2 (ThinkBook 16 G5+ APO) has this new variant,
as detected with lspci:

64:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD]
        ACP/ACP3X/ACP6x Audio Coprocessor (rev 63)

Signed-off-by: Jiawei Wang <me@jwang.link>
Link: https://msgid.link/r/20240228073914.232204-1-me@jwang.link
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/pci-acp6x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/amd/yc/pci-acp6x.c b/sound/soc/amd/yc/pci-acp6x.c
index 77c5fa1f7af14..81dc32f70de21 100644
--- a/sound/soc/amd/yc/pci-acp6x.c
+++ b/sound/soc/amd/yc/pci-acp6x.c
@@ -156,6 +156,7 @@ static int snd_acp6x_probe(struct pci_dev *pci,
 	/* Yellow Carp device check */
 	switch (pci->revision) {
 	case 0x60:
+	case 0x63:
 	case 0x6f:
 		break;
 	default:
-- 
2.43.0


