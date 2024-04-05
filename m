Return-Path: <linux-kernel+bounces-133352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D06B289A2B6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 451861F2498A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3426E171677;
	Fri,  5 Apr 2024 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZKuNskC"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A282317164A;
	Fri,  5 Apr 2024 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335293; cv=none; b=SGRPyreOQIPllF44T5qCf6AVA3WuO3c74CYCkSLO6V+UEDqIwVmesUMJahU/rs+fQWHurTR3ozwib9Z61+vyiAYQP5VR/mzv0/JPyF8NPYYGPsx1EFOtsHyZYuf9WiMbv9ieeGHGfRUfqfZ+d8gp5ElXUqBHIPMLaxCDyDaXGuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335293; c=relaxed/simple;
	bh=qkH1n2ZJ4QVAdDXQQaJsqr3HhVev4kuqL3wJZVBjiJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMcQYG1puMJHfaeN31TTe5PoEEMfqZ3jm54b0e61ZRhobGc0Zz+42WXflFOkdEtD7CmjjR5IX7SpXheQckpFVOwhYmKa7jbrG9/QcWdGGhwRETtVI4ltEJ05cQaqjrW6vaFu8hWHKbTzGnMWq3gX++275wIX1giXFjxlDEZ4gsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZKuNskC; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d68651e253so28064781fa.0;
        Fri, 05 Apr 2024 09:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712335290; x=1712940090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6AIAxCJz2R5rlggcf2OWr2A/Jt7N68nXNuioW63cJo=;
        b=mZKuNskCabOm3Lpu+LHcn9JH+i9huakKae4vdZuA7GH3o8lqRcy7QvAeBtzbE7W43x
         gUUJLx0Gvvi7alAulflhEWU27hcHbbxQ1toGxMyDHESrJz6ZqMdsPzC2Fak6P64fkp2l
         7g1p9XHmlqkVDMqYrsoMCrUwcDiXq/RY8HjinaRCu+fa4W8rMw4zC2Vff63wSEWtWGuV
         vbDyj8LkFkMgBoelJhgMwO+YgAUzUgweYQWfg0i8FVwVN6qFspVRQpFg0HhcNTxB/sRi
         ivGNFD1gQi6hl8qlDaO9P3gvnvfLSuZ85U6fLpLds7ITlFmq9XqTsCScfRpKJmdCoGAR
         xYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712335290; x=1712940090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6AIAxCJz2R5rlggcf2OWr2A/Jt7N68nXNuioW63cJo=;
        b=oZBubHvh0CdmFusV3stodhflY6Nqf83msI5likSsEKZV4erQGha6WS3kETs2vlw9og
         026U+2pzZPiQ3m28K3PrL9rAkYMarfgov4/zru8JWrcFmYGJOA6YQRb7GtlX/Wth7ta4
         /t3ELhc10vicMEmqHP0G+UQE9tmwIPRLVNa2gpvQZZU5/vRO8IKhJvCf68BplkyiAdYR
         t4mnvvdM9VoNgyPDfP9YgpBxrq+JJ4lbdKF/ubyknXJld/a2/kU1lcvvrIfyO8g6MZka
         A/f/x3YVRTi6LGpgM3ZF3ghyqJcoHFPDsHx0wX24xK9TwEfaHMvUIe4+Rw2U37mMcjOz
         BJFg==
X-Forwarded-Encrypted: i=1; AJvYcCVwLWaUBGM/VBl03w5L8rfibHKcQtpP517XT/evpZXZeNcIo1ZLpELzoCETKML1d7I8SxS3Yn5k+epLDhDJxcIAIN6TjwGRtH9PaHVcX0vweTeUpc4YbWLn+r65uhaDkIE6fOA4++Py4Xs=
X-Gm-Message-State: AOJu0YzQP35Xl6PW7d9h/tOIK1YjKdjCbxWAlUMelSauA6Z+Vj+qEXvl
	SYXjbFzXPYY2tNTBqBoHOMNGBNulGiKImYOEUzCiEfBGir5zq+uQ
X-Google-Smtp-Source: AGHT+IFjtQuZOZW0BDVNPhYb7bUR3Fz2orD/fw5MqatcEC0Ei9BdI8MB0UTP85FED3le6XQfnvxdLw==
X-Received: by 2002:a2e:960a:0:b0:2d8:8b7:76e3 with SMTP id v10-20020a2e960a000000b002d808b776e3mr1565309ljh.11.1712335289629;
        Fri, 05 Apr 2024 09:41:29 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id h13-20020a05651c124d00b002d6c93793f1sm218372ljh.77.2024.04.05.09.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 09:41:29 -0700 (PDT)
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sebastian Fricke <sebastian.fricke@collabora.com>
Cc: Ivan Bornyakov <brnkv.i1@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] media: chips-media: wave5: support decoding HEVC Main10 profile
Date: Fri,  5 Apr 2024 19:41:05 +0300
Message-ID: <20240405164112.24571-2-brnkv.i1@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405164112.24571-1-brnkv.i1@gmail.com>
References: <20240405164112.24571-1-brnkv.i1@gmail.com>
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
index ef227af72348..5a71a711f2e8 100644
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
index 352f6e904e50..465ff9dfe8b1 100644
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


