Return-Path: <linux-kernel+bounces-97930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B488771D2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 16:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71811F21619
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 15:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2AD44C9C;
	Sat,  9 Mar 2024 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BKnHD/+i"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D4A44391;
	Sat,  9 Mar 2024 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709996933; cv=none; b=Qsvsc8QUvln9r6d657cj/EnJkpCfMzDLjxFoaimzFgy2N4THxfpHyIfdUX1fKwjeAnooyj4C05qZdb6xXyI91ZgEpgkd7P+g7T93If5Dj6CMai+cslDUnUW6p7VGKgfr1kZoS9kCYGFY1HSBE59EuxTsDLhpDnDGBac32iaxus0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709996933; c=relaxed/simple;
	bh=Isf3PRZPpGIZHZAJaAtHVL0lcRPUzgj1NgJcb5eXOmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tunqEwLUhRvGYrwe0B8CFOA4rEt+Lu55iLUZPuERVmUjDjJkdr1wK8FIkH3yuOuM1jBbW7PvZ931YcCLqQAEEraSPIqLvc45vrDcHNf7tccZZMv7yKleTR8joOxFFwFkiL7npPJOvNxsAuX8UkF3ZNgexceYhfOrLmcNQtfT/EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BKnHD/+i; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709996924;
	bh=Isf3PRZPpGIZHZAJaAtHVL0lcRPUzgj1NgJcb5eXOmA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BKnHD/+iCjaEdvc2nN3CdUutgbNrwmzgCzP5a4OHFbVTMZrskcy3FE2Upi15zP56Z
	 358R56ieY0rj9Xu45xdiV7Rd/r0+dNQ1xkrROC8wh2uMPUb+Caq5UoCcoiMsrgjxje
	 jmLRFEkW3cZePxx7ynpCQ+7T0SOdDyjmHeXekgg6gv27zPEPBkdd71lPN/hvmjWAeE
	 AItOP7Fp9Fu7IZhRQraX7CFQR18xGjqmlEGllqcKZfJwNiI+kdWEnQLBmJXftKBmvS
	 XrWdobj5IgWhnCHzTbebjblf923B0MACd5jMgJuCPp+sjaZMGw/HTfxImjbwRGQFIl
	 Gth7EMaASAF2g==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2A06D3782091;
	Sat,  9 Mar 2024 15:08:44 +0000 (UTC)
From: Sebastian Fricke <sebastian.fricke@collabora.com>
Date: Sat, 09 Mar 2024 16:08:39 +0100
Subject:
 [PATCH 3/3] media: mediatek: vcodec: Replace false function description
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240309-mediatek-typos-v1-3-fa4aeb59306c@collabora.com>
References: <20240309-mediatek-typos-v1-0-fa4aeb59306c@collabora.com>
In-Reply-To: <20240309-mediatek-typos-v1-0-fa4aeb59306c@collabora.com>
To: Tiffany Lin <tiffany.lin@mediatek.com>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com, Sebastian Fricke <sebastian.fricke@collabora.com>
X-Mailer: b4 0.11.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709996919; l=1595;
 i=sebastian.fricke@collabora.com; s=linux-media; h=from:subject:message-id;
 bh=Isf3PRZPpGIZHZAJaAtHVL0lcRPUzgj1NgJcb5eXOmA=;
 b=lkmmxOwN00OH6jVL0bqNRINEQIJHhjC8/OPRFiEsYHdLMCD0/aWE8EuuabCPin/HyTpYlyLWrzZE
 W7YYhQd2DwBn7wC5nZplrybyc3E11suxQq3F/LIfsrZz56MxlP7R
X-Developer-Key: i=sebastian.fricke@collabora.com; a=ed25519;
 pk=pYXedPwrTtErcj7ERYeo/IpTrpe4QbJuEzSB52fslBg=

The function descriptions where falsely copy pasted from another entry,
write more fitting descriptions for the functions.

Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 .../platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_common.h    | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_common.h b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_common.h
index 6f624c266246..2d845b1307b6 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_common.h
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_common.h
@@ -185,7 +185,7 @@ void mtk_vdec_h264_get_ref_list(u8 *ref_list,
 void *mtk_vdec_h264_get_ctrl_ptr(struct mtk_vcodec_dec_ctx *ctx, int id);
 
 /**
- * mtk_vdec_h264_fill_dpb_info - get each CID contrl address.
+ * mtk_vdec_h264_fill_dpb_info - Fill the decoded picture buffer info
  *
  * @ctx:		v4l2 ctx
  * @decode_params:	slice decode params
@@ -225,7 +225,9 @@ void mtk_vdec_h264_copy_slice_hd_params(struct mtk_h264_slice_hd_param *dst_para
 					const struct v4l2_ctrl_h264_decode_params *dec_param);
 
 /**
- * mtk_vdec_h264_copy_scaling_matrix - get each CID contrl address.
+ * mtk_vdec_h264_copy_scaling_matrix - Copy the scaling matrix from a source to
+ *				       a destination.
+ *				       (for example into the slice parameters)
  *
  * @dst_matrix:	scaling list params for hw decoder
  * @src_matrix:	scaling list params from user driver

-- 
2.25.1

