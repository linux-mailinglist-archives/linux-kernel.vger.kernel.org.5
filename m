Return-Path: <linux-kernel+bounces-10745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D82B081DB32
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 16:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D8D1C213A9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 15:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3CF111AC;
	Sun, 24 Dec 2023 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CwhKnTQM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB08ADDC1
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a23566e91d5so379377366b.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 07:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703432676; x=1704037476; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r4Q2nADKSJJyFLuoBm9qbZWxhgG3+quvPMfEmFUIhGU=;
        b=CwhKnTQMIPKjADZsNIol9aidFK4VyMBkKQT9ldwhersPeiZrBV4N66hoBdLGhFA4u0
         eunlEtrxBx10aQYSRPEqjBIoa+FStpw0xsUPcYlTQf1ueVvYxvJSUtl6Dt2bDxcdPeoY
         2bOQ/w0tqIYp5alv3gleYnaxg6pGNavESjrDbKcpofYjIk/y+M7Flr5KPq6n/otbXWEl
         O886siu/iiqCWJJOXWsEHdw3UeQNOsj65tQ05aFkEiG+rnLr4bWpz98H5JDNwmMILZlt
         hjrU3CIWqI2Ue4wWJ4uqjzhLKnvaG0TQQLolqjEQahnh/tC1sVThpEQkm1RB2Ci0rPMR
         G/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703432676; x=1704037476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4Q2nADKSJJyFLuoBm9qbZWxhgG3+quvPMfEmFUIhGU=;
        b=HOVaspUglVwtseFDxZTY4axfOWgcRlPpSjGTgslc4KLlh74+7ifa801JbcztRTgGR6
         FuQt6RoRNcxU0WDQ/nAeVJvJpHhVHxAXO3By5dQ/VZrfjIyW2W+ZSI/uhWbhVMjnpQxD
         thrmUN7G5d/8m+6KXRmkRH+KpiykgQnDA0dkhK0oTB5e5o805nrtzuHybYsDAh253hE3
         hGBE7EwiwfuwbnGNPwbAeU3HSFcbmqFBEevfN+nTWdFEwQQEIM6gzEdE7kNnDQmnts22
         gIO9+9KeyTj4TE76j4kBSTc/0qbPqlonYIjABz3x2KslNmduwp8l2keE1kBbp2gZKZxD
         qUwQ==
X-Gm-Message-State: AOJu0Yy6Cbrjbwcm68vBoqgMwnoiU3ysLrbLOLzN7+skrDohP26MsCJN
	8sIcpdDHasp+1M5wMhNZNXr5iWNOOpxZvQ==
X-Google-Smtp-Source: AGHT+IHsiJFm89Z87CL2nktkKopTAQrSauGGlkZXKCgaTQNFWSFTCHq1yVM9nlZafsoU0sG4ZBOpvw==
X-Received: by 2002:a17:906:bc44:b0:a23:4e3a:4356 with SMTP id s4-20020a170906bc4400b00a234e3a4356mr1399437ejv.182.1703432676050;
        Sun, 24 Dec 2023 07:44:36 -0800 (PST)
Received: from [127.0.1.1] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id ge12-20020a170907908c00b00a26ac403032sm3325901ejb.65.2023.12.24.07.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 07:44:35 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 24 Dec 2023 16:44:04 +0100
Subject: [PATCH 05/15] media: s5p-mfc: constify s5p_mfc_buf_size structures
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231224-n-s5p-mfc-const-v1-5-a3b246470fe4@linaro.org>
References: <20231224-n-s5p-mfc-const-v1-0-a3b246470fe4@linaro.org>
In-Reply-To: <20231224-n-s5p-mfc-const-v1-0-a3b246470fe4@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Aakarsh Jain <aakarsh.jain@samsung.com>, linux-fsd@tesla.coma, 
 linux-samsung-soc@vger.kernel.org, 
 Smitha T Murthy <smithatmurthy@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=9432;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=N6YS/7mRLJwdEcbOlRqHEpaRJFaZ8M8KXMSmDWzRy2k=;
 b=owEBfgKB/ZANAwAKAcE3ZuaGi4PXAcsmYgBliFHSU2k4b4bucLF39Jb/ovQuLzzq+ll9IVFTm
 VelIugiQw2JAkQEAAEKAC4WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZYhR0hAca3J6a0BrZXJu
 ZWwub3JnAAoJEME3ZuaGi4PXhuoP/ibqJwx0ApEBEn5x2nzP4RF7lBVQU0L5gLI1WntrJuW0m9U
 ssehL7xsFOxBpb142d9Kacz9B2rKO+yamsVFkhnMsk9Rv56OlCU5ylNN82Y+eyT8mt8rrQVytD3
 OhxHn9xlBJZda5jmMZJADQCND7A+8utd7ifxv0rB1U1quXGnbdAYcDRwiVu66xztpp4Z5BOfToY
 omd9C3h7tQgS2R2nA3yQmi0ce1ykBRLRLDg8uOPUr2lPjIvxyPSaVF11seTeoOYFVIizTbd4QsO
 0l9TkgzRMszaDOJPM0qbeGs+owINNOg8BICoIOGJi33pph/Jk8dBVmhI9SpMDCIabg0RxwTsUDq
 t7DDaUEYlMZYlvxIzMPY3iJZohh8h29fIU12Ao3jzdgPNpfDZxVRFt9Qyhgw9OOQ/h3ZGmdnJNt
 MCHpEHPIGPTXmAycjtsqEyHO5RtVajQ9Tz3WFFyrUNaES8sQ59s6wHUU5zlhpWdxcPABeUw53Tv
 D2g7QWSXVNMqvOTGKSm3mtP5E5tbo0j8PlY23xhAQOd/upsLS/5AxD8OwltlvKSwua0MZi4YeiO
 jQXsZnCodpu+L2TaNfJX2OLUU6t6pxp7t1GLSX1xklvna+KJzO4dAdSqqzhdkAhgMLj+3VOIc6q
 u3sDfAj12q1NSBOxsnwj0S+pHwaOV7GEKzBzv
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Static "s5p_mfc_buf_size*" structures are not modified by the driver, so
they can be made const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c     | 20 ++++++++++----------
 .../media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c  |  2 +-
 .../media/platform/samsung/s5p-mfc/s5p_mfc_common.h  |  4 ++--
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c |  2 +-
 .../media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c  |  6 +++---
 .../media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c  |  6 +++---
 6 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
index e30e54935d79..6af7b812c5df 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
@@ -1516,14 +1516,14 @@ static const struct dev_pm_ops s5p_mfc_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(s5p_mfc_suspend, s5p_mfc_resume)
 };
 
-static struct s5p_mfc_buf_size_v5 mfc_buf_size_v5 = {
+static const struct s5p_mfc_buf_size_v5 mfc_buf_size_v5 = {
 	.h264_ctx	= MFC_H264_CTX_BUF_SIZE,
 	.non_h264_ctx	= MFC_CTX_BUF_SIZE,
 	.dsc		= DESC_BUF_SIZE,
 	.shm		= SHARED_BUF_SIZE,
 };
 
-static struct s5p_mfc_buf_size buf_size_v5 = {
+static const struct s5p_mfc_buf_size buf_size_v5 = {
 	.fw	= MAX_FW_SIZE,
 	.cpb	= MAX_CPB_SIZE,
 	.priv	= &mfc_buf_size_v5,
@@ -1540,7 +1540,7 @@ static struct s5p_mfc_variant mfc_drvdata_v5 = {
 	.use_clock_gating = true,
 };
 
-static struct s5p_mfc_buf_size_v6 mfc_buf_size_v6 = {
+static const struct s5p_mfc_buf_size_v6 mfc_buf_size_v6 = {
 	.dev_ctx	= MFC_CTX_BUF_SIZE_V6,
 	.h264_dec_ctx	= MFC_H264_DEC_CTX_BUF_SIZE_V6,
 	.other_dec_ctx	= MFC_OTHER_DEC_CTX_BUF_SIZE_V6,
@@ -1548,7 +1548,7 @@ static struct s5p_mfc_buf_size_v6 mfc_buf_size_v6 = {
 	.other_enc_ctx	= MFC_OTHER_ENC_CTX_BUF_SIZE_V6,
 };
 
-static struct s5p_mfc_buf_size buf_size_v6 = {
+static const struct s5p_mfc_buf_size buf_size_v6 = {
 	.fw	= MAX_FW_SIZE_V6,
 	.cpb	= MAX_CPB_SIZE_V6,
 	.priv	= &mfc_buf_size_v6,
@@ -1569,7 +1569,7 @@ static struct s5p_mfc_variant mfc_drvdata_v6 = {
 	.num_clocks	= 1,
 };
 
-static struct s5p_mfc_buf_size_v6 mfc_buf_size_v7 = {
+static const struct s5p_mfc_buf_size_v6 mfc_buf_size_v7 = {
 	.dev_ctx	= MFC_CTX_BUF_SIZE_V7,
 	.h264_dec_ctx	= MFC_H264_DEC_CTX_BUF_SIZE_V7,
 	.other_dec_ctx	= MFC_OTHER_DEC_CTX_BUF_SIZE_V7,
@@ -1577,7 +1577,7 @@ static struct s5p_mfc_buf_size_v6 mfc_buf_size_v7 = {
 	.other_enc_ctx	= MFC_OTHER_ENC_CTX_BUF_SIZE_V7,
 };
 
-static struct s5p_mfc_buf_size buf_size_v7 = {
+static const struct s5p_mfc_buf_size buf_size_v7 = {
 	.fw	= MAX_FW_SIZE_V7,
 	.cpb	= MAX_CPB_SIZE_V7,
 	.priv	= &mfc_buf_size_v7,
@@ -1603,7 +1603,7 @@ static struct s5p_mfc_variant mfc_drvdata_v7_3250 = {
 	.num_clocks     = 2,
 };
 
-static struct s5p_mfc_buf_size_v6 mfc_buf_size_v8 = {
+static const struct s5p_mfc_buf_size_v6 mfc_buf_size_v8 = {
 	.dev_ctx	= MFC_CTX_BUF_SIZE_V8,
 	.h264_dec_ctx	= MFC_H264_DEC_CTX_BUF_SIZE_V8,
 	.other_dec_ctx	= MFC_OTHER_DEC_CTX_BUF_SIZE_V8,
@@ -1611,7 +1611,7 @@ static struct s5p_mfc_buf_size_v6 mfc_buf_size_v8 = {
 	.other_enc_ctx	= MFC_OTHER_ENC_CTX_BUF_SIZE_V8,
 };
 
-static struct s5p_mfc_buf_size buf_size_v8 = {
+static const struct s5p_mfc_buf_size buf_size_v8 = {
 	.fw	= MAX_FW_SIZE_V8,
 	.cpb	= MAX_CPB_SIZE_V8,
 	.priv	= &mfc_buf_size_v8,
@@ -1637,7 +1637,7 @@ static struct s5p_mfc_variant mfc_drvdata_v8_5433 = {
 	.num_clocks	= 3,
 };
 
-static struct s5p_mfc_buf_size_v6 mfc_buf_size_v10 = {
+static const struct s5p_mfc_buf_size_v6 mfc_buf_size_v10 = {
 	.dev_ctx        = MFC_CTX_BUF_SIZE_V10,
 	.h264_dec_ctx   = MFC_H264_DEC_CTX_BUF_SIZE_V10,
 	.other_dec_ctx  = MFC_OTHER_DEC_CTX_BUF_SIZE_V10,
@@ -1646,7 +1646,7 @@ static struct s5p_mfc_buf_size_v6 mfc_buf_size_v10 = {
 	.other_enc_ctx  = MFC_OTHER_ENC_CTX_BUF_SIZE_V10,
 };
 
-static struct s5p_mfc_buf_size buf_size_v10 = {
+static const struct s5p_mfc_buf_size buf_size_v10 = {
 	.fw     = MAX_FW_SIZE_V10,
 	.cpb    = MAX_CPB_SIZE_V10,
 	.priv   = &mfc_buf_size_v10,
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
index f8588e52dfc8..25c4719a5dd0 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
@@ -32,7 +32,7 @@ static int s5p_mfc_cmd_host2risc_v6(struct s5p_mfc_dev *dev, int cmd,
 static int s5p_mfc_sys_init_cmd_v6(struct s5p_mfc_dev *dev)
 {
 	struct s5p_mfc_cmd_args h2r_args;
-	struct s5p_mfc_buf_size_v6 *buf_size = dev->variant->buf_size->priv;
+	const struct s5p_mfc_buf_size_v6 *buf_size = dev->variant->buf_size->priv;
 	int ret;
 
 	ret = s5p_mfc_hw_call(dev->mfc_ops, alloc_dev_context_buffer, dev);
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
index f33a755327ef..6a47f3434c60 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
@@ -219,14 +219,14 @@ struct s5p_mfc_buf_size_v6 {
 struct s5p_mfc_buf_size {
 	unsigned int fw;
 	unsigned int cpb;
-	void *priv;
+	const void *priv;
 };
 
 struct s5p_mfc_variant {
 	unsigned int version;
 	unsigned int port_num;
 	u32 version_bit;
-	struct s5p_mfc_buf_size *buf_size;
+	const struct s5p_mfc_buf_size *buf_size;
 	const char	*fw_name[MFC_FW_MAX_VERSIONS];
 	const char	*clk_names[MFC_MAX_CLOCKS];
 	int		num_clocks;
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
index 268ffe4da53c..4dbe8792ac3d 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
@@ -426,7 +426,7 @@ static int vidioc_s_fmt(struct file *file, void *priv, struct v4l2_format *f)
 	struct s5p_mfc_ctx *ctx = fh_to_ctx(priv);
 	int ret = 0;
 	struct v4l2_pix_format_mplane *pix_mp;
-	struct s5p_mfc_buf_size *buf_size = dev->variant->buf_size;
+	const struct s5p_mfc_buf_size *buf_size = dev->variant->buf_size;
 
 	mfc_debug_enter();
 	ret = vidioc_try_fmt(file, priv, f);
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c
index 28a06dc343fd..13a3ff55e547 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c
@@ -34,7 +34,7 @@
 static int s5p_mfc_alloc_dec_temp_buffers_v5(struct s5p_mfc_ctx *ctx)
 {
 	struct s5p_mfc_dev *dev = ctx->dev;
-	struct s5p_mfc_buf_size_v5 *buf_size = dev->variant->buf_size->priv;
+	const struct s5p_mfc_buf_size_v5 *buf_size = dev->variant->buf_size->priv;
 	int ret;
 
 	ctx->dsc.size = buf_size->dsc;
@@ -200,7 +200,7 @@ static void s5p_mfc_release_codec_buffers_v5(struct s5p_mfc_ctx *ctx)
 static int s5p_mfc_alloc_instance_buffer_v5(struct s5p_mfc_ctx *ctx)
 {
 	struct s5p_mfc_dev *dev = ctx->dev;
-	struct s5p_mfc_buf_size_v5 *buf_size = dev->variant->buf_size->priv;
+	const struct s5p_mfc_buf_size_v5 *buf_size = dev->variant->buf_size->priv;
 	int ret;
 
 	if (ctx->codec_mode == S5P_MFC_CODEC_H264_DEC ||
@@ -345,7 +345,7 @@ static void s5p_mfc_enc_calc_src_size_v5(struct s5p_mfc_ctx *ctx)
 static void s5p_mfc_set_dec_desc_buffer(struct s5p_mfc_ctx *ctx)
 {
 	struct s5p_mfc_dev *dev = ctx->dev;
-	struct s5p_mfc_buf_size_v5 *buf_size = dev->variant->buf_size->priv;
+	const struct s5p_mfc_buf_size_v5 *buf_size = dev->variant->buf_size->priv;
 
 	mfc_write(dev, OFFSETA(ctx->dsc.dma), S5P_FIMV_SI_CH0_DESC_ADR);
 	mfc_write(dev, buf_size->dsc, S5P_FIMV_SI_CH0_DESC_SIZE);
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
index c0df5ac9fcff..70a62400908e 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
@@ -333,7 +333,7 @@ static void s5p_mfc_release_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 static int s5p_mfc_alloc_instance_buffer_v6(struct s5p_mfc_ctx *ctx)
 {
 	struct s5p_mfc_dev *dev = ctx->dev;
-	struct s5p_mfc_buf_size_v6 *buf_size = dev->variant->buf_size->priv;
+	const struct s5p_mfc_buf_size_v6 *buf_size = dev->variant->buf_size->priv;
 	int ret;
 
 	mfc_debug_enter();
@@ -393,7 +393,7 @@ static void s5p_mfc_release_instance_buffer_v6(struct s5p_mfc_ctx *ctx)
 /* Allocate context buffers for SYS_INIT */
 static int s5p_mfc_alloc_dev_context_buffer_v6(struct s5p_mfc_dev *dev)
 {
-	struct s5p_mfc_buf_size_v6 *buf_size = dev->variant->buf_size->priv;
+	const struct s5p_mfc_buf_size_v6 *buf_size = dev->variant->buf_size->priv;
 	int ret;
 
 	mfc_debug_enter();
@@ -493,7 +493,7 @@ static int s5p_mfc_set_dec_stream_buffer_v6(struct s5p_mfc_ctx *ctx,
 {
 	struct s5p_mfc_dev *dev = ctx->dev;
 	const struct s5p_mfc_regs *mfc_regs = dev->mfc_regs;
-	struct s5p_mfc_buf_size *buf_size = dev->variant->buf_size;
+	const struct s5p_mfc_buf_size *buf_size = dev->variant->buf_size;
 
 	mfc_debug_enter();
 	mfc_debug(2, "inst_no: %d, buf_addr: 0x%08x,\n"

-- 
2.34.1


