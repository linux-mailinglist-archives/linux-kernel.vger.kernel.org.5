Return-Path: <linux-kernel+bounces-144889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179858A4C33
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D22283501
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D1A535B3;
	Mon, 15 Apr 2024 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpDNCiQl"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772CA4AEFB;
	Mon, 15 Apr 2024 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713175669; cv=none; b=fm8KxJyEf85k+aoIbiL91WgckbtlNYrJ3ixRoUEHkbnR6Csnu2koT0ukxm4hiuQNZb+F3mG8r+AVGObdZVGarrPClmfSz60yR4hzeJJoHY6mWDDP+cCIEiYZ4QWPezesEjjjU1TzcZMmiOrdC0um0GEtphhUEzuTxs1IB6p00G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713175669; c=relaxed/simple;
	bh=NjS5ZKTgn0CAxa/+hsGK1uKv551ICluEg83npu2Cgrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cclwOQwT8x7qHMhhGKpjhU5Ag+Xh07U9q95tr96PtXR0I3CqPbE5d3RKwNpD6r3pbyTuUdT/WKnci0ViIWrvLPM98o736NPDGwS5OPY5QL0WBQrW9vL8Wc+cuOf1tjBzo+Yp2T/dI6r1DXPB3FvKYMNUSGQIcoYRbRMSUTg24Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpDNCiQl; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-518a56cdc03so1770563e87.1;
        Mon, 15 Apr 2024 03:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713175665; x=1713780465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exJSaM97w/rxhKlp66LNs0J5dWRazkq0g+KzDjBjBpo=;
        b=HpDNCiQlSmaWI8Mm+dqV4uHlV0hsbpfcN5EDh9RRvTNskMD0JpuWQl9zJy4Givmf6f
         63Zn6lB72nwUa5bJXUKu63BxOQgZwqczskGBB2djspVk1AsIbIlwr68JqcT4Ag+YsrlN
         VAtwE+y2R3wMAzHdX0Z4qSIa5600Xxjvsj9yoU0wRRD7ju4NSfv67HrS+GrEphOSFm1W
         8Rhk/WItaFtLxnsdKoIy5mwoxhTCkCtiNV31Tnd1Z5TjijUUNvqXSh+kBRrS5MEU8LNO
         R9iXfFCbZmeckuK2uqftgPvO07cQjPRNA7GSV+82Bm1UVSSVJzp+fOhPaUJSuMVNGNlm
         ZEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713175665; x=1713780465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exJSaM97w/rxhKlp66LNs0J5dWRazkq0g+KzDjBjBpo=;
        b=Vixp3XqzO5B6n6K2+zg/bR3QyXmI2RPLoVnmGZNxiWa2LYjnn8nkGF6RiGaKzwYNZr
         T/z//bzHMRcwx5JazIlQwo2izZ1skCiO0wOeleQ6ZbGyawNXdwNNKWmVrNWsTHAe4Mu6
         ix9lNO4nW4rWYInl03b3Mot/mE0hdsaJc0Ujjn4XMB0Y6RXhcnHfKECKnVpGEeY2+axI
         eSPuLDpkyzPAig+7I9ePKcHPqEpX7Ds9uqt1akHk5exAdYqkaXDBShINBnu8luqSQuy2
         kmmVA1PedL15eXyUkNp4E8JIE1dAq24jZ+1FgNmmEgbluUA7rvzHEryV6vjNRwbtLtF0
         thvw==
X-Forwarded-Encrypted: i=1; AJvYcCVa+hRwlKoCMum5uUVd9twFPB8vkSuH3nfII27AYPVjPw2GsuUCJN8hY8PXPc7BXyXxAvlvHFqpmxBYoewlN1U86e2NliUiHbKFSbWC/OdIrDfqktljVwOjPDWC3E7Obk38qnLRGgaIt5k=
X-Gm-Message-State: AOJu0Yx6Xt0haVSjgRlE3qe15IHOJRtJxLBrumIQuQp8JTSbd6jrphi1
	cNREtGOvgdofjDHQ7o+enGFCA8U0kKgWj1cid5tNmijjiHka50r1
X-Google-Smtp-Source: AGHT+IF6t4iPe01O5oU41v/zZw0I0Fo4FbBYvLdW8Vxq0NN7pHKCTAx/pMUocFwh7R0O8IkihxDAqg==
X-Received: by 2002:a19:2d5c:0:b0:516:d163:608e with SMTP id t28-20020a192d5c000000b00516d163608emr6073453lft.34.1713175665366;
        Mon, 15 Apr 2024 03:07:45 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id g11-20020a0565123b8b00b00518f53da2dfsm149571lfv.291.2024.04.15.03.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 03:07:45 -0700 (PDT)
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sebastian Fricke <sebastian.fricke@collabora.com>
Cc: Ivan Bornyakov <brnkv.i1@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] media: chips-media: wave5: support decoding HEVC Main10 profile
Date: Mon, 15 Apr 2024 13:07:19 +0300
Message-ID: <20240415100726.19911-2-brnkv.i1@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415100726.19911-1-brnkv.i1@gmail.com>
References: <20240415100726.19911-1-brnkv.i1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for decoding HEVC Main10 profile by scaling FBC buffer
stride and size by the factor of (bitdepth / 8).

Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
---
 .../chips-media/wave5/wave5-vpu-dec.c         | 30 +++++++++++--------
 .../platform/chips-media/wave5/wave5-vpuapi.h |  1 +
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index c8624c681fa6..8e1dab9434ca 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -1055,6 +1055,22 @@ static int wave5_prepare_fb(struct vpu_instance *inst)
 	int ret, i;
 	struct v4l2_m2m_buffer *buf, *n;
 	struct v4l2_m2m_ctx *m2m_ctx = inst->v4l2_fh.m2m_ctx;
+	u32 bitdepth = inst->codec_info->dec_info.initial_info.luma_bitdepth;
+
+	switch (bitdepth) {
+	case 8:
+		break;
+	case 10:
+		if (inst->std == W_HEVC_DEC &&
+		    inst->dev->attr.support_hevc10bit_dec)
+			break;
+
+		fallthrough;
+	default:
+		dev_err(inst->dev->dev, "no support for %d bit depth\n", bitdepth);
+
+		return -EINVAL;
+	}
 
 	linear_num = v4l2_m2m_num_dst_bufs_ready(m2m_ctx);
 	non_linear_num = inst->fbc_buf_count;
@@ -1063,7 +1079,7 @@ static int wave5_prepare_fb(struct vpu_instance *inst)
 		struct frame_buffer *frame = &inst->frame_buf[i];
 		struct vpu_buf *vframe = &inst->frame_vbuf[i];
 
-		fb_stride = inst->dst_fmt.width;
+		fb_stride = ALIGN(inst->dst_fmt.width * bitdepth / 8, 32);
 		fb_height = ALIGN(inst->dst_fmt.height, 32);
 		luma_size = fb_stride * fb_height;
 
@@ -1408,22 +1424,10 @@ static int wave5_vpu_dec_start_streaming(struct vb2_queue *q, unsigned int count
 		if (ret)
 			goto free_bitstream_vbuf;
 	} else if (q->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
-		struct dec_initial_info *initial_info =
-			&inst->codec_info->dec_info.initial_info;
-
 		if (inst->state == VPU_INST_STATE_STOP)
 			ret = switch_state(inst, VPU_INST_STATE_INIT_SEQ);
 		if (ret)
 			goto return_buffers;
-
-		if (inst->state == VPU_INST_STATE_INIT_SEQ) {
-			if (initial_info->luma_bitdepth != 8) {
-				dev_info(inst->dev->dev, "%s: no support for %d bit depth",
-					 __func__, initial_info->luma_bitdepth);
-				ret = -EINVAL;
-				goto return_buffers;
-			}
-		}
 	}
 
 	return ret;
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
index edc50450ddb8..fa4dc53949e6 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
@@ -327,6 +327,7 @@ struct vpu_attr {
 	u32 support_backbone: 1;
 	u32 support_avc10bit_enc: 1;
 	u32 support_hevc10bit_enc: 1;
+	u32 support_hevc10bit_dec: 1;
 	u32 support_vcore_backbone: 1;
 	u32 support_vcpu_backbone: 1;
 };
-- 
2.44.0


