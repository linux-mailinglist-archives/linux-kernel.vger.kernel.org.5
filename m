Return-Path: <linux-kernel+bounces-2195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AB2815931
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 14:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8531F23B6A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BB523761;
	Sat, 16 Dec 2023 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AH3Bwh9C"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B24219F7;
	Sat, 16 Dec 2023 13:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-54f4b31494fso2766134a12.1;
        Sat, 16 Dec 2023 05:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702732170; x=1703336970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n89IuR5gUSQ4BVQ0By1D6c8QjvjYZ+sxQ5eQOMT0DAg=;
        b=AH3Bwh9C4wt509hYoMqQPmYEjsg02xkQqNuCb5CG2jzWMK+qzWNehBQjgR5sNt29xn
         0WDPm32mhGQoMuxs0jHlOFrgA2qMfHga+GfGMrWz6FY/Lh0wmjEObtTPvB2L0PdAEznM
         dh9kcgbyd6rvg5631j8m9301eWxy5DgXg8T9aEVpsPvFpoaMSKvzrSxBXEyg8WK4pk/g
         rJBraFD50pmcRNVnZ+ZHAyTsxFOkd/Iyg78RY2+PHCUMXmIUspURnO/HbbyMI9y2g19O
         g49HVEtRaaMEj5mq6WksVLktrk+mvSl5IyUJPVBbbm6ro3vB0iHX8XGOcbAJskbAnLAC
         I1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702732170; x=1703336970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n89IuR5gUSQ4BVQ0By1D6c8QjvjYZ+sxQ5eQOMT0DAg=;
        b=hhx15APGUf56BMurKNo0n0C7uuB/RW35JPtXlMwJftmPwfIndeM0sexyq3whKCcYI2
         j0wZRZYZjxBFFWeoR/IlmBJXw35JHg2GvsOpnkcwSEUS1IdTsPN7zM+ZsI0rULfKXtge
         saezvScLfvpcs1Q9DpFNVokW7OaQF7rNANCZgQ4KGzovnQlABxn4bbGtmW++Io0Vqgw0
         IzpUgOPIgMw5mP/w6mNs6u1UREpEH+SUikaxdNsO9+ZMK8qlaPqLZuL9xcUOC3oDwBI1
         xwVdmTCLoxv/+KVw6z0rGX6iXRr4dX04TMBROtcLgjZEO6gKcxH0FhyXTvND6f4hGIqM
         ieNw==
X-Gm-Message-State: AOJu0YyGaujpGDEotrMdeT5UKFz/4ud6z10toJWtu6D9xiGY0N8Ilxuf
	DbG4uQIeF3Wsu3Gwu9pu93Q=
X-Google-Smtp-Source: AGHT+IHkWr7Mj3eKXJJud+PAc5UQeJZpEKzpZ43hzhunTp0Fynlbb806wfnWNJcKola3DEFkl9bo+g==
X-Received: by 2002:a50:baea:0:b0:54c:bb9c:4b88 with SMTP id x97-20020a50baea000000b0054cbb9c4b88mr13586805ede.5.1702732170257;
        Sat, 16 Dec 2023 05:09:30 -0800 (PST)
Received: from localhost.localdomain (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id ew12-20020a056402538c00b00552691fc7f9sm2628963edb.66.2023.12.16.05.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 05:09:29 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: mripard@kernel.org,
	paul.kocialkowski@bootlin.com
Cc: mchehab@kernel.org,
	gregkh@linuxfoundation.org,
	wens@csie.org,
	samuel@sholland.org,
	hverkuil-cisco@xs4all.nl,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] media: cedrus: h265: Fix configuring bitstream size
Date: Sat, 16 Dec 2023 14:09:25 +0100
Message-ID: <20231216130925.2533395-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bit_size field holds size of slice, not slice + header. Because of HW
quirks, driver can't program in just slice, but also preceding header.
But that means that currently used bit_size is wrong (too small).
Instead, just use size of whole buffer. There is no harm in doing this.

Fixes: 86caab29da78 ("media: cedrus: Add HEVC/H.265 decoding support")
Suggested-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus_h265.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
index fc9297232456..16c822637dc6 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
@@ -427,11 +427,11 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	unsigned int ctb_addr_x, ctb_addr_y;
 	struct cedrus_buffer *cedrus_buf;
 	dma_addr_t src_buf_addr;
-	dma_addr_t src_buf_end_addr;
 	u32 chroma_log2_weight_denom;
 	u32 num_entry_point_offsets;
 	u32 output_pic_list_index;
 	u32 pic_order_cnt[2];
+	size_t slice_bytes;
 	u8 padding;
 	int count;
 	u32 reg;
@@ -443,6 +443,7 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	pred_weight_table = &slice_params->pred_weight_table;
 	num_entry_point_offsets = slice_params->num_entry_point_offsets;
 	cedrus_buf = vb2_to_cedrus_buffer(&run->dst->vb2_buf);
+	slice_bytes = vb2_get_plane_payload(&run->src->vb2_buf, 0);
 
 	/*
 	 * If entry points offsets are present, we should get them
@@ -490,7 +491,7 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 
 	cedrus_write(dev, VE_DEC_H265_BITS_OFFSET, 0);
 
-	reg = slice_params->bit_size;
+	reg = slice_bytes * 8;
 	cedrus_write(dev, VE_DEC_H265_BITS_LEN, reg);
 
 	/* Source beginning and end addresses. */
@@ -504,10 +505,7 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 
 	cedrus_write(dev, VE_DEC_H265_BITS_ADDR, reg);
 
-	src_buf_end_addr = src_buf_addr +
-			   DIV_ROUND_UP(slice_params->bit_size, 8);
-
-	reg = VE_DEC_H265_BITS_END_ADDR_BASE(src_buf_end_addr);
+	reg = VE_DEC_H265_BITS_END_ADDR_BASE(src_buf_addr + slice_bytes);
 	cedrus_write(dev, VE_DEC_H265_BITS_END_ADDR, reg);
 
 	/* Coding tree block address */
-- 
2.43.0


