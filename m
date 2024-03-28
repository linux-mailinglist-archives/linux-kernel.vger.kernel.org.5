Return-Path: <linux-kernel+bounces-122701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5755488FBBA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E983E1F2581F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B367CF2B;
	Thu, 28 Mar 2024 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Pu6dubfd"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7005556B77;
	Thu, 28 Mar 2024 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711618490; cv=none; b=L+L1tsZV5hIiIouqdTztZuCXhU8nW1db/fBb36MzXE6L9Pafphv+fL94zIdUbHBwVhFLm2F8fZS8OgVYKD4BqVjSybZFJXlaJ/n1aEHrco/FViR+epaaTkhGQCeBgDPvAgxBrMU5xvjNRc2gicF7jR9rar8OnLxIvurbv0IcLwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711618490; c=relaxed/simple;
	bh=kLtyFp4xpElNNw1K4yeyOMlFT9DpiyV8sV6LRNkBK34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PjWGv+NHLYq4BmA8vfknxza4kfuDwUJgaW2JgTIxHs0JcuIrn9WqKZAPNNkzy7zBL+gEyYCilcDfel9pPtTyM/vLEw5kdqt3eiy9GVhesaCwzNVoYwV32iZi4clsuZIZu90ScGXIimDKP81iXKjBuaBhS4brkKozyXihkbIKdPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Pu6dubfd; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711618486;
	bh=kLtyFp4xpElNNw1K4yeyOMlFT9DpiyV8sV6LRNkBK34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pu6dubfdXWeWVQ9ggcqmSJU6ycEO3YZkVSCugE5GWeEIWJIntrNGSHc3gZL6nQYQZ
	 Cslw71C9bW7d3X8F1WkTVKDN4YQ+algt4Gaa9OGAMoR/6EgQcjUWI4mo1Ow5cd3o+3
	 LWLUxKc8Y8zGQbrKxryh/bqWXBvCdwo5MzAeAsxJOi8O/o/nxT6ZcOy59vVUvMMo8L
	 s+9Q7aljhatOWm83RO8Ht4/q7Q2bCxZCYV0sIrTVGHVmhHNAxtb8949qR8AAXeypgO
	 jZ8eKLc8D1LkBE8zGzqaQZwfAMyDV3/gGzncja7uKkEJ1J12fGk2PGBLqxTLx2/A7n
	 ezY6bAHGV5o1w==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 187A6378211A;
	Thu, 28 Mar 2024 09:34:46 +0000 (UTC)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: ezequiel@vanguardiasur.com.ar,
	p.zabel@pengutronix.de,
	mchehab@kernel.org,
	heiko@sntech.de
Cc: linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH] media: verisilicon: Fix auxiliary buffers allocation size
Date: Thu, 28 Mar 2024 10:34:39 +0100
Message-Id: <20240328093439.18712-2-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240328093439.18712-1-benjamin.gaignard@collabora.com>
References: <20240328093439.18712-1-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use v4l2_av1_tile_info->tile_cols to know the number of colons
in the frame. This made auxiliary buffers meory size computation
more accurate.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Fixes: 727a400686a2 ("media: verisilicon: Add Rockchip AV1 decoder")
---
 .../media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c    | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c b/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
index cc4483857489..65e8f2d07400 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
@@ -257,7 +257,8 @@ static int rockchip_vpu981_av1_dec_tiles_reallocate(struct hantro_ctx *ctx)
 	struct hantro_dev *vpu = ctx->dev;
 	struct hantro_av1_dec_hw_ctx *av1_dec = &ctx->av1_dec;
 	struct hantro_av1_dec_ctrls *ctrls = &av1_dec->ctrls;
-	unsigned int num_tile_cols = 1 << ctrls->tile_group_entry->tile_col;
+	const struct v4l2_av1_tile_info *tile_info = &ctrls->frame->tile_info;
+	unsigned int num_tile_cols = tile_info->tile_cols;
 	unsigned int height = ALIGN(ctrls->frame->frame_height_minus_1 + 1, 64);
 	unsigned int height_in_sb = height / 64;
 	unsigned int stripe_num = ((height + 8) + 63) / 64;
-- 
2.40.1


