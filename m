Return-Path: <linux-kernel+bounces-97931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A698771D5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 16:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFBF9B21211
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 15:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDE745940;
	Sat,  9 Mar 2024 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LC9Yl0AS"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A9C40879;
	Sat,  9 Mar 2024 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709996933; cv=none; b=QB54d6lduU22WAYRtLbJ5NXjKnXCrSknIibNGvxz1l/x23ZyvCBp97ZHzLdoy8zJwSc2wDXAgvp7/tSb3xp524M6efh/Dkl8k6X0u12Gz8yqPT84VUYEDlIDRYbBJi1WPTQa1PsSlpYpJaxPC5wjHAqcWXbk8hfAI4SRlsU94Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709996933; c=relaxed/simple;
	bh=qTEqGKNFjaYsuV/phc8ORQVbsab7C8DxOC4Q/kxtGZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o4HYr8cNCtaKQRjR+ZFyQLnC+xfq11yoKm9UA8JNNUzOembNZ9/bysGI649+faECdsMmQZ+JmzIBOq3kgW6+j9N5mvglVxo48zpkH0718Ue6W/Y7NqG4+a7oF8aSKcCSn8IHpPy9FS5kFKaL7qMsV492MZgi+/epR/lB1NvLHBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LC9Yl0AS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709996923;
	bh=qTEqGKNFjaYsuV/phc8ORQVbsab7C8DxOC4Q/kxtGZo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LC9Yl0ASKsa/CrK1czdWcr/62wJZA8AxMjkFJKCzFtsdBXqD/HHpjZuQ9dVxpwAKR
	 2PIBATnledzYqRbGG7SWlmzYrO8cv9ZtKvi/qzcUGAbfLIJtnuy0l3epdARjqpd2Mf
	 tOnIfF2nCCH0LxWU302IE9Me1He2Izi8jmevYZ4HTQbFmUVQN1LBCdxR9ikfEsS5DA
	 oUFxOF38J/dKX/zjxHdccFt7nXLOgpckZbd3a8MUeadTTlnMDDRkD+5eIVOKDW/z5g
	 vU7EQRsDOUPNVhnJOmiE0Xw8PYf7XDoS950qSY4byKGxT6ullTrVkMHCHsCg1HHa8Q
	 /uo5XZO6oHWoQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E33443782043;
	Sat,  9 Mar 2024 15:08:42 +0000 (UTC)
From: Sebastian Fricke <sebastian.fricke@collabora.com>
Date: Sat, 09 Mar 2024 16:08:38 +0100
Subject:
 [PATCH 2/3] media: mediatek: vcodec: Improve wording & fix grammatic issues
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240309-mediatek-typos-v1-2-fa4aeb59306c@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709996919; l=5849;
 i=sebastian.fricke@collabora.com; s=linux-media; h=from:subject:message-id;
 bh=qTEqGKNFjaYsuV/phc8ORQVbsab7C8DxOC4Q/kxtGZo=;
 b=rKIInxf1pNxiLqElpsLEecHpA9fojcvJ0hoVMqp5YWocqN/Ve0kgtFxy+Smr1ZCN6obDvVV9IZdK
 K8fYAIdoD0L+bPnjpAMFIsMWjnqNc/Qoxiku51mQKswcIA8Blq63
X-Developer-Key: i=sebastian.fricke@collabora.com; a=ed25519;
 pk=pYXedPwrTtErcj7ERYeo/IpTrpe4QbJuEzSB52fslBg=

Multiple issues detected while scanning the code by far not a complete
list of required changes but some small improvements.

Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h   | 2 +-
 .../media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c    | 2 +-
 .../platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c    | 2 +-
 .../platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c    | 2 +-
 drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c     | 4 ++--
 drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
index a0451116f2e4..f975db4293da 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
@@ -71,7 +71,7 @@ enum mtk_vdec_hw_arch {
  * @fb_sz: bitstream size of each plane
  * E.g. suppose picture size is 176x144,
  *      buffer size will be aligned to 176x160.
- * @cap_fourcc: fourcc number(may changed when resolution change)
+ * @cap_fourcc: fourcc number(may change on a resolution change)
  * @reserved: align struct to 64-bit in order to adjust 32-bit and 64-bit os.
  */
 struct vdec_pic_info {
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c
index 37c41b673876..668e87bf30e8 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c
@@ -27,7 +27,7 @@ struct mtk_h264_dec_slice_param {
 /**
  * struct vdec_h264_dec_info - decode information
  * @dpb_sz		: decoding picture buffer size
- * @resolution_changed  : resolution change happend
+ * @resolution_changed  : flag to notify that a resolution change happend
  * @realloc_mv_buf	: flag to notify driver to re-allocate mv buffer
  * @cap_num_planes	: number planes of capture buffer
  * @bs_dma		: Input bit-stream buffer dma address
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c
index d5224c9584b6..c4ac6b6f7acf 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c
@@ -131,7 +131,7 @@ struct vdec_h264_slice_share_info {
 /**
  * struct vdec_h264_slice_inst - h264 decoder instance
  *
- * @slice_dec_num:	how many picture be decoded
+ * @slice_dec_num:	how many pictures to be decoded
  * @ctx:		point to mtk_vcodec_dec_ctx
  * @pred_buf:		HW working prediction buffer
  * @mv_buf:		HW working motion vector buffer
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c
index a44db6139ff2..349b510d355a 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c
@@ -342,7 +342,7 @@ struct vdec_hevc_slice_share_info {
 /**
  * struct vdec_hevc_slice_inst - hevc decoder instance
  *
- * @slice_dec_num:      how many picture be decoded
+ * @slice_dec_num:      how many pictures to be decoded
  * @ctx:                point to mtk_vcodec_dec_ctx
  * @mv_buf:             HW working motion vector buffer
  * @vpu:                VPU instance
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c
index 19407f9bc773..9649f4ec1f2a 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c
@@ -56,7 +56,7 @@
  * @cur_c_fb_dma      : current plane C frame buffer dma address
  * @bs_dma	      : bitstream dma address
  * @bs_sz	      : bitstream size
- * @resolution_changed: resolution change flag 1 - changed,  0 - not change
+ * @resolution_changed: resolution change flag 1 - changed,  0 - not changed
  * @show_frame	      : display this frame or not
  * @wait_key_frame    : wait key frame coming
  */
@@ -109,7 +109,7 @@ struct vdec_vp8_hw_reg_base {
 /**
  * struct vdec_vp8_vpu_inst - VPU instance for VP8 decode
  * @wq_hd	: Wait queue to wait VPU message ack
- * @signaled	: 1 - Host has received ack message from VPU, 0 - not receive
+ * @signaled	: 1 - Host has received ack message from VPU, 0 - not received
  * @failure	: VPU execution result status 0 - success, others - fail
  * @inst_addr	: VPU decoder instance address
  */
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c
index f677e499fefa..e27e728f392e 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c
@@ -35,7 +35,7 @@
  * @cur_c_fb_dma:	current plane C frame buffer dma address
  * @bs_dma:		bitstream dma address
  * @bs_sz:		bitstream size
- * @resolution_changed:resolution change flag 1 - changed,  0 - not change
+ * @resolution_changed:resolution change flag 1 - changed,  0 - not changed
  * @frame_header_type:	current frame header type
  * @crc:		used to check whether hardware's status is right
  * @reserved:		reserved, currently unused

-- 
2.25.1

