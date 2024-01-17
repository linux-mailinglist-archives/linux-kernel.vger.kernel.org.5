Return-Path: <linux-kernel+bounces-29134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD0D830953
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12901C21B27
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8564D225AE;
	Wed, 17 Jan 2024 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WueU6Fx7"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A95224C6;
	Wed, 17 Jan 2024 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705504338; cv=none; b=PD9WRQrIomyz847HRPzrfMrf55XHFYBD7F9kKECAJw3b9xvy4KzvyuxB9aArN6A7Tol0CiaQlkUYB2nymnYvyZ4Vbx43VAj59B+bZwRasUMy5n0v1qIl4Uv8wdcmZR46MpnoHKMmvbvGAtTG+KjVYtnPWq80nTqpYlxtqsSyK1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705504338; c=relaxed/simple;
	bh=YvV1/JkCbzQT0j8DI4iZqxHvsPZ+nnCbsag0eB+AyhY=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=izHjRkFT5d/wbxpor8uiNo1cVi/AcnhEqYpfeKS1rvY3eyGmE+wbR8g1NuSdfAPTF33VDmt1eugSoXbHQJBe8pwvdW2D82mb0nFoi5hwZ2LRRlqTlyY96cPsLfRivXG+5Mm+dcEf8Dy3XuKMqpUOvnqE/KWqlQAPvb11/byb2RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WueU6Fx7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705504335;
	bh=YvV1/JkCbzQT0j8DI4iZqxHvsPZ+nnCbsag0eB+AyhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WueU6Fx7NT8BEXRelCzVECi8C0NRwNZSidN4uV2UCe8WF4Uw+KgJFVI2jY7iFuWB6
	 LjDOVQA6aFqNZxddyniFF3i140Zm+c0EottykV2XrqECvq+c363ayDa8pXojiqKdsN
	 3aME0ak3066SPQvhkUPk3N01TxVACOfL0VSQt+I4BAT3qaHravqNb2eb6DjFe/ntFj
	 dlTTfYfyJfrthgaiyQTR2aT6lqynr2lGyahZPCQScxMnc9YO3xk5sHz5ThcEh1Tr6l
	 gyPdKfvfBEreZzVxW2mkSYs7bCuWoOZbJe2Tu6tKL34UAsKlKMSKofkWEuHIimO6cN
	 JjG5I+Y8sCOqw==
Received: from arisu.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 809B63782070;
	Wed, 17 Jan 2024 15:12:14 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: linux-media@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v5 4/4] visl: Add codec specific variability on output frames
Date: Wed, 17 Jan 2024 10:10:18 -0500
Message-ID: <20240117151202.405426-5-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117151202.405426-1-detlev.casanova@collabora.com>
References: <20240117151202.405426-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running tests with different input data, the stable output frames
could be too similar and hide possible issues.

This commit adds variation by using some codec specific parameters.

Only HEVC and H.264 support this.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/media/test-drivers/visl/visl-dec.c | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/media/test-drivers/visl/visl-dec.c b/drivers/media/test-drivers/visl/visl-dec.c
index 4933caa4f2a6..1540948119ca 100644
--- a/drivers/media/test-drivers/visl/visl-dec.c
+++ b/drivers/media/test-drivers/visl/visl-dec.c
@@ -295,6 +295,35 @@ static void visl_tpg_fill_sequence(struct visl_ctx *ctx,
 		  " top" : " bottom") : "none");
 }
 
+static bool visl_tpg_fill_codec_specific(struct visl_ctx *ctx,
+					 struct visl_run *run,
+					 char buf[], size_t bufsz)
+{
+	/*
+	 * To add variability, we need a value that is stable for a given
+	 * input but is different than already shown fields.
+	 * The pic order count value defines the display order of the frames
+	 * (which can be different than the decoding order that is shown with
+	 * the sequence number).
+	 * Therefore it is stable for a given input and will add a different
+	 * value that is more specific to the way the input is encoded.
+	 */
+	switch (ctx->current_codec) {
+	case VISL_CODEC_H264:
+		scnprintf(buf, bufsz,
+			  "H264: %u", run->h264.dpram->pic_order_cnt_lsb);
+		break;
+	case VISL_CODEC_HEVC:
+		scnprintf(buf, bufsz,
+			  "HEVC: %d", run->hevc.dpram->pic_order_cnt_val);
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
 static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
 {
 	u8 *basep[TPG_MAX_PLANES][2];
@@ -327,6 +356,13 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
 	frame_dprintk(ctx->dev, run->dst->sequence, "");
 	line++;
 
+	if (visl_tpg_fill_codec_specific(ctx, run, buf, TPG_STR_BUF_SZ)) {
+		tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, buf);
+		frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
+		frame_dprintk(ctx->dev, run->dst->sequence, "");
+		line++;
+	}
+
 	visl_get_ref_frames(ctx, buf, TPG_STR_BUF_SZ, run);
 
 	while ((line_str = strsep(&tmp, "\n")) && strlen(line_str)) {
-- 
2.43.0


