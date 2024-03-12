Return-Path: <linux-kernel+bounces-100074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BC187916D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878BB1F21873
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6927A142;
	Tue, 12 Mar 2024 09:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="zvQsu+fI"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD55D79B73;
	Tue, 12 Mar 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710237031; cv=none; b=VhL7+mhWp8mdDtvGvW2HbPHBcfxc7AcH2VHy2mBspcphiQekSV5CPnoCHyWqKIE5rlM7CyvvrSMKTfiGR7wNkouMO6Os12zYsksuQMQK0CFLTRIwdEgSoz1aR7il5Hv1T1Hom/sWXFdMUFkgg8axhFgjeMBfeBYAFDlxXtoMBak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710237031; c=relaxed/simple;
	bh=CZUwmtrMAbhgiKTCOMdUvfJTKdr28NZ87Os6j2jRv5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kgsqqPwTwXwDV8NuVG0wxycP/2jRqgC9S+tF0fs3RtOtvQPBAqIcVgdhKXqoXq1AQHLehII5X6QJ0DCsVYNK4kn9dVxCZab//hdUtIZJTxcKhfwzhLO2mpOctI2PugSfguNoRZRGsgE7hn4n7Jr68nDD49gzFnGTK4D4o+OetKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=zvQsu+fI; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710237028;
	bh=CZUwmtrMAbhgiKTCOMdUvfJTKdr28NZ87Os6j2jRv5E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=zvQsu+fIJYiHjQXafQqCVTx0aNz958hGNoFh5q/c5TdKFmkiM4KwqU+wNo3kk97oB
	 JQlTiCf9OU1yK6qe3wUe9byjeZPrqLKGXhvJd5agIeXXOCv678DHXNh9kyK6IZ1LNq
	 aMu4rNLzQby8all1/Ew+F/YjlWUWRa3g6U9hPIhxaDvsCGUZ1s71I7bsVwcmLBi6mW
	 C0b2NLx9NK/DMpdBu06+I5U1wl3ERuiR7Qqx6HmAwynKssS7WFOTWmBonZP/363C7G
	 m9f/vVQD3Bl0TvmIa+Qn6KetEVpHJROSFcRCjTHS/p8wfOFlfWXg7NeiPPbMh90cZp
	 063GMukXAr4pQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 012E2378209A;
	Tue, 12 Mar 2024 09:50:27 +0000 (UTC)
From: Sebastian Fricke <sebastian.fricke@collabora.com>
Date: Tue, 12 Mar 2024 10:50:21 +0100
Subject:
 [PATCH v2 3/3] media: mediatek: vcodec: Replace false function description
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240309-mediatek-typos-v2-3-7eaacd8e5401@collabora.com>
References: <20240309-mediatek-typos-v2-0-7eaacd8e5401@collabora.com>
In-Reply-To: <20240309-mediatek-typos-v2-0-7eaacd8e5401@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710237023; l=2009;
 i=sebastian.fricke@collabora.com; s=linux-media; h=from:subject:message-id;
 bh=CZUwmtrMAbhgiKTCOMdUvfJTKdr28NZ87Os6j2jRv5E=;
 b=/1DOX8jA9henQNBIlm5fmKQ5f1n7Wz7Ojvk6tGNsdZb7AUz03Yaw2uu0jaCV9j3wqyjltyMiS3QP
 m5KjxAc5CkvRZaMoTnV6Y7950Idp4ZeGp0otkcYp/B1glgScjKZZ
X-Developer-Key: i=sebastian.fricke@collabora.com; a=ed25519;
 pk=pYXedPwrTtErcj7ERYeo/IpTrpe4QbJuEzSB52fslBg=

The function descriptions where falsely copy pasted from another entry,
write more fitting descriptions for the functions.

Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../mediatek/vcodec/decoder/vdec/vdec_h264_req_common.h       | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_common.h b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_common.h
index 6f624c266246..31ffa13160a3 100644
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
@@ -225,10 +225,13 @@ void mtk_vdec_h264_copy_slice_hd_params(struct mtk_h264_slice_hd_param *dst_para
 					const struct v4l2_ctrl_h264_decode_params *dec_param);
 
 /**
- * mtk_vdec_h264_copy_scaling_matrix - get each CID contrl address.
+ * mtk_vdec_h264_copy_scaling_matrix - Copy scaling matrix from a control to the driver
  *
- * @dst_matrix:	scaling list params for hw decoder
- * @src_matrix:	scaling list params from user driver
+ * @dst_matrix:	scaling list params for the HW decoder
+ * @src_matrix:	scaling list params from a V4L2 control
+ *
+ * This function is used to copy the scaling matrix from a
+ * v4l2 control into the slice parameters for a decode.
  */
 void mtk_vdec_h264_copy_scaling_matrix(struct slice_api_h264_scaling_matrix *dst_matrix,
 				       const struct v4l2_ctrl_h264_scaling_matrix *src_matrix);

-- 
2.25.1

