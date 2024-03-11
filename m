Return-Path: <linux-kernel+bounces-99067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DF6878313
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA331C2129F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97AE41E22;
	Mon, 11 Mar 2024 15:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1rKxklK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1571756B71;
	Mon, 11 Mar 2024 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169979; cv=none; b=uqK9n7tXHtaddfsVauYcFEv1RqK3WRbwtgAXvhsg3Txn9ZZgGq29b030/x8SFQjrbooWYKU42hJmP+KLA1G/bbj/15K+69iZan8Cs0/PMFCqSooH9hTkvlO5insQMWcuwaLdIY9LLYWDob+vdWlTUFu/33UloT4jW+hL7MCqCNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169979; c=relaxed/simple;
	bh=MstotRqjwZf2eSpZRoKnjVnu8irMqzwmM1ka5cqE2XA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vc+3l5Jm42WJaU7fsdtE2/I+eBa/la2CD3HOFFKSDgrMOtqTbKIeJBNISmjuQf3zMd8iM3GvzfxqqsZfg+fnI8EiyrifB+zwU0ymK1ZttPOuVdTU21XrU6JB5uxJIexfdUmKEVcnkxLrPVF44uEi6CE+kLiWQVBeziscJnYYNns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1rKxklK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD38C433F1;
	Mon, 11 Mar 2024 15:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710169978;
	bh=MstotRqjwZf2eSpZRoKnjVnu8irMqzwmM1ka5cqE2XA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j1rKxklKRtkuhsbPP4Yc085ay3ZvqdV7XP3OogCqQG9mEDmu6C6DBbslVVozdlHkN
	 SJQ6frRutvUGVBnDK59i0PsBoPcYBS6S3baQjQBHa0Sa0VwSXvhBxTsGGN++U4vDX3
	 ja1nI3OInIjifcW+YCKaN3mdDd2k/Pu+GL7YCc4mc/qAidsETTA1s+5piw9UvUY4PY
	 /1j2ovntlrQ67dZ+kuR/RkiaeI8fsZrd7yrFjZqrDQm6mds8IE+ijDBVUB7yg8KGD0
	 tgnBsl6blEWPN9FqQ4UulNwgL2BAHXwYD4eRS9aMFcO5D3v0vCCGQ2mB/ONRjMir/4
	 h1IZ8Yydr8ZNg==
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
Subject: [PATCH AUTOSEL 6.7 18/23] ASoC: amd: yc: add new YC platform variant (0x63) support
Date: Mon, 11 Mar 2024 11:11:58 -0400
Message-ID: <20240311151217.317068-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151217.317068-1-sashal@kernel.org>
References: <20240311151217.317068-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.9
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
index 7af6a349b1d41..694b8e3139024 100644
--- a/sound/soc/amd/yc/pci-acp6x.c
+++ b/sound/soc/amd/yc/pci-acp6x.c
@@ -162,6 +162,7 @@ static int snd_acp6x_probe(struct pci_dev *pci,
 	/* Yellow Carp device check */
 	switch (pci->revision) {
 	case 0x60:
+	case 0x63:
 	case 0x6f:
 		break;
 	default:
-- 
2.43.0


