Return-Path: <linux-kernel+bounces-99086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D2D878347
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71722285240
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C216087B;
	Mon, 11 Mar 2024 15:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwZ39h9M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B3660868;
	Mon, 11 Mar 2024 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170019; cv=none; b=a1Wa+mJSq9+tn57E9SNRoy3a88jGlmGTtUZCAQ/WHdp4EqNL0juRYzvNUe8mwSVFy+6w/5F1uRDJIOvtrT1dOr88v3BwQiQMZ28iPrCERz+llZGF7GFHQkKyVsYFaLm6RWPssYHF4bu7DfN/AnEgubDNDeM8+G5b/3i3Vq3icJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170019; c=relaxed/simple;
	bh=MstotRqjwZf2eSpZRoKnjVnu8irMqzwmM1ka5cqE2XA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jBS9LDW9TgC5SASnEhrdoP6ib8GjcQlH8tE/Q7ggGo8yT9LEGgIaUwaF+2ZLzlfUFpAgLJy5drNQX3i9tTl9AG28T3CJ99Z5javXzu6BIKxO2AAhWXmWJH9R0ymYU0rOel5due424BKVcwuJKNfjQ1fgs74PbOjukQeec2rKJU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwZ39h9M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC70BC433F1;
	Mon, 11 Mar 2024 15:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710170019;
	bh=MstotRqjwZf2eSpZRoKnjVnu8irMqzwmM1ka5cqE2XA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PwZ39h9MMZZFi9BNuUvsHJKvrTxwYkZOYzWyOlafl+xiQYi8bG/LZBSa8Ry7kHvMn
	 lumQZxquxG3lMzgU4nIten527+ahfN3i42XriLjlsXSWU/SKhSd7iA7Rf7QJYYn1Yy
	 d1C/bLOGoxVHdOcIu+l56sLFRzh/WZMInVYgn+h4quAEFlhzzVrS3jO1rk6Us7X+9V
	 jwCoWMwtfeuxt4390Wr2aqAuiGS9tiBdOFJbb9sfncwWhnU2iOyWHvR1gPPxqs6WDn
	 NgPd6fBKsN/AbqLzC17xYtpfH+wyjwdyrmHawd5zX8cvz98o0zR9zhMf7CjCzd0/sx
	 l3Z2M9GJzpr2A==
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
Subject: [PATCH AUTOSEL 6.6 12/17] ASoC: amd: yc: add new YC platform variant (0x63) support
Date: Mon, 11 Mar 2024 11:13:03 -0400
Message-ID: <20240311151314.317776-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151314.317776-1-sashal@kernel.org>
References: <20240311151314.317776-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.21
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


