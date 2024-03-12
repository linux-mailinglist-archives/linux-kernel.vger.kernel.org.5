Return-Path: <linux-kernel+bounces-100073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD7F87916A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 043B41F231BF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121A17A126;
	Tue, 12 Mar 2024 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dU0hPYq/"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A255079B60;
	Tue, 12 Mar 2024 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710237030; cv=none; b=qmR8CbvO4zF7JGCoLjFiCNdfmEYnbwxDWjLUIMUHnQYoccUuxKvEjkVGdy8j0p7gNhnCJfFXdk/4lKJsa+OzLanvKO1OKJ6jXWxK6LFhii5UC9hlJqxy20FQg7Gk/PZDfODs7KZAAspQM/oj4uoQOu0aJ+r3Lgv5FFA6ezyHEe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710237030; c=relaxed/simple;
	bh=wx5Od8e0msgGi1gWmjh7X4CMlWtUwg0DpHfFHz+2/cM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XRqhwoG8F76UOfqFvRlK2QPtRl/LmSMxUPjSknlu9HJA23xEyMU09MrIo/mGiCqARAf7bwshssZsbnajNY2IefWZJmkrMLwNouki173osZED2BrddciGCBzqH25LAzuzB+sjdwdHHHQND3Kc83BqNJOc5fiukhtU34WO+IKUQNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dU0hPYq/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710237027;
	bh=wx5Od8e0msgGi1gWmjh7X4CMlWtUwg0DpHfFHz+2/cM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dU0hPYq/vzHUOLU+RRnHBQwXFLMIg7g4HZaC7UVgWtpAwBPSngwwT3fTfKywh7VCN
	 CSDMMBz56Au3GcpNKvPx8zc3YOMf4DQSxyeZf7tMRFyhKGWrAqeS7hB/sIEyEcukg+
	 8uiMHpowNjJUi/JzouzS5n5Meu5PnA816vwA0QnCoF4yUtJAegXcPATO48+prPUlEG
	 UHvuIAqgBZlWJYEaXRw7U5kfTwUDOLhnDBX66FggOQXd5JOLZFz3EXJkA2VEAx64m1
	 aT5IBNxdoV8hYYsFNgKM029M+hcEnSY1EbOHOlUoqrSl08AiW16iWwPQ72UHiTcfMZ
	 HyMkueFiVd2NA==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B63D13782082;
	Tue, 12 Mar 2024 09:50:26 +0000 (UTC)
From: Sebastian Fricke <sebastian.fricke@collabora.com>
Date: Tue, 12 Mar 2024 10:50:20 +0100
Subject: [PATCH v2 2/3] media: mediatek: vcodec: Improve wording & fix
 grammatic issues
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240309-mediatek-typos-v2-2-7eaacd8e5401@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710237023; l=2834;
 i=sebastian.fricke@collabora.com; s=linux-media; h=from:subject:message-id;
 bh=wx5Od8e0msgGi1gWmjh7X4CMlWtUwg0DpHfFHz+2/cM=;
 b=4TRPb9ey+FZFBS7b7sJJt7mXLU+HL5QHI2VaENisPMR47hWK5CjdJJT2JQJbROrKV8u6Rp6PwfjH
 XMYLq/vjAi/IMidrky7RWkRKFt3WrYz7JdQsxY31CpJHf7WkLQOx
X-Developer-Key: i=sebastian.fricke@collabora.com; a=ed25519;
 pk=pYXedPwrTtErcj7ERYeo/IpTrpe4QbJuEzSB52fslBg=

Multiple issues detected while scanning the code by far not a complete
list of required changes but some small improvements.

Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c  | 2 +-
 .../platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c      | 2 +-
 .../platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c
index 37c41b673876..73d5cef33b2a 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c
@@ -27,7 +27,7 @@ struct mtk_h264_dec_slice_param {
 /**
  * struct vdec_h264_dec_info - decode information
  * @dpb_sz		: decoding picture buffer size
- * @resolution_changed  : resolution change happend
+ * @resolution_changed  : flag to notify that a resolution change happened
  * @realloc_mv_buf	: flag to notify driver to re-allocate mv buffer
  * @cap_num_planes	: number planes of capture buffer
  * @bs_dma		: Input bit-stream buffer dma address
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c
index d5224c9584b6..2d4611e7fa0b 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c
@@ -131,7 +131,7 @@ struct vdec_h264_slice_share_info {
 /**
  * struct vdec_h264_slice_inst - h264 decoder instance
  *
- * @slice_dec_num:	how many picture be decoded
+ * @slice_dec_num:	Number of frames to be decoded
  * @ctx:		point to mtk_vcodec_dec_ctx
  * @pred_buf:		HW working prediction buffer
  * @mv_buf:		HW working motion vector buffer
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c
index a44db6139ff2..fe0a8508d632 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c
@@ -342,7 +342,7 @@ struct vdec_hevc_slice_share_info {
 /**
  * struct vdec_hevc_slice_inst - hevc decoder instance
  *
- * @slice_dec_num:      how many picture be decoded
+ * @slice_dec_num:      Number of frames to be decoded
  * @ctx:                point to mtk_vcodec_dec_ctx
  * @mv_buf:             HW working motion vector buffer
  * @vpu:                VPU instance

-- 
2.25.1

