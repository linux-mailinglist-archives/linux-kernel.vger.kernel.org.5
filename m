Return-Path: <linux-kernel+bounces-130294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A9E89767E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F7371C298DE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68E9157E95;
	Wed,  3 Apr 2024 17:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/H4CKj9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017D1157E81;
	Wed,  3 Apr 2024 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164661; cv=none; b=PmPvPsi+RB5g3Z/OgcKP3Z6sxSOTc4yFsnlZ2ekGlcbEtnsOUZkB7edf3GsNtsooI0h2yoUKzb4eiV0zv51cV+nrWodvHPfZ6jJl4SiY8b9zU74PLEPRY1jVce56loaHgxWf+f1sSvlcKIZ4qHe39+pSrNhX4+ISKC3u8CU5dVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164661; c=relaxed/simple;
	bh=PqdQSkza1BV/j3939MC3d2UEy8GlaQK2W0y7hEo/laQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AELyHhQ3m33fLw6AS9iNkCQ8N5YovBbA3w9Nw3Jz35w0moqHQBqGS0O6Sq5X8itHUDlQoUYykXb2SUMOGgsIca9VskUYW/BNf5Z/IqGjU/qBhatxtyu7cK8uguEQgpIoVXQgoHA7zzCb/QLHNW32/HRgS+LNDfYpRYuM+JPe1Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/H4CKj9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A75C433F1;
	Wed,  3 Apr 2024 17:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164660;
	bh=PqdQSkza1BV/j3939MC3d2UEy8GlaQK2W0y7hEo/laQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i/H4CKj9Efz0SeZg+ddtY331DqOWjVnzfj7FKDUunuzYcxCpBJbc5GATcPnFNwl9N
	 x4HJCliANnnxhR1L1fIJAsZ2AeVwVdUunl46likA7ye3wSSZYvkYaGJWFA/KSKS6yR
	 iS6dHA06K+3iXb16GBg13lUXNJgnsQiAjvwPL4HCiVA0KNDJ4kJOz8ud53ycPjazbm
	 nrR2IFwoR6SnjbTpe4hbQ9h/NE8MUPPOXR8/cXpb7QVPfi6Gf3Gv2PzulDkqxWgkNH
	 6ghQKVHZ7rONcziZA9bvIT1h+8HRA9kT+O4nJbUqImnNSyB6eaOUVw78E//gPBIh5H
	 s398RlWAm536g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiawei Wang <me@jwang.link>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	Syed.SabaKareem@amd.com,
	Vijendar.Mukunda@amd.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 20/28] ASoC: amd: yc: Revert "add new YC platform variant (0x63) support"
Date: Wed,  3 Apr 2024 13:16:22 -0400
Message-ID: <20240403171656.335224-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171656.335224-1-sashal@kernel.org>
References: <20240403171656.335224-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.3
Content-Transfer-Encoding: 8bit

From: Jiawei Wang <me@jwang.link>

[ Upstream commit 37bee1855d0e3b6dbeb8de71895f6f68cad137be ]

This reverts commit 316a784839b21b122e1761cdca54677bb19a47fa,
that enabled Yellow Carp (YC) driver for PCI revision id 0x63.

Mukunda Vijendar [1] points out that revision 0x63 is Pink
Sardine platform, not Yellow Carp. The YC driver should not
be enabled for this platform. This patch prevents the YC
driver from being incorrectly enabled.

Link: https://lore.kernel.org/linux-sound/023092e1-689c-4b00-b93f-4092c3724fb6@amd.com/ [1]

Signed-off-by: Jiawei Wang <me@jwang.link>
Link: https://msgid.link/r/20240313015853.3573242-3-me@jwang.link
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/pci-acp6x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/amd/yc/pci-acp6x.c b/sound/soc/amd/yc/pci-acp6x.c
index 694b8e3139024..7af6a349b1d41 100644
--- a/sound/soc/amd/yc/pci-acp6x.c
+++ b/sound/soc/amd/yc/pci-acp6x.c
@@ -162,7 +162,6 @@ static int snd_acp6x_probe(struct pci_dev *pci,
 	/* Yellow Carp device check */
 	switch (pci->revision) {
 	case 0x60:
-	case 0x63:
 	case 0x6f:
 		break;
 	default:
-- 
2.43.0


