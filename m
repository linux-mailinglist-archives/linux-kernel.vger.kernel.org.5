Return-Path: <linux-kernel+bounces-10749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484FA81DB3F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 16:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F41AB282056
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 15:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084551805D;
	Sun, 24 Dec 2023 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ShzPTsie"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB37015AEF
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-554d06bfd83so300777a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 07:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703432682; x=1704037482; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uPtI8bSt3Ez5hLHZMbq8TpWSSmR71jwLZo0bXfxiX3Q=;
        b=ShzPTsieDIfeyjehymx8cx3VilB6a06PyoeSmPabwhmu41t/uAue+2rmNxQ+xmO5X3
         75j2gTtutMOvoh9zTl/lJOF0lxZ452+ypybcrZQXQLuZOeoOOLYJs+AxstCdw47kGjor
         UuEoY00tE0+H4+kFYNJ33223OY7+jtW6Pkp7Ddp5hjAqz9KRQcNCbEywUDQWNMDy/iPP
         wmaQzMc3GATmTRQEYYEB82K4Hk6PE4HYXbQspMK/n40JWqnvmcBN6e/h7x+sexWpiKAH
         Z/Gy5C9u1AtwxyCtrj3WmRuC6kWbGmOEjgjkomdmvTMQ8ESUiEa0B1bSCdlUfqX5QAug
         tGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703432682; x=1704037482;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPtI8bSt3Ez5hLHZMbq8TpWSSmR71jwLZo0bXfxiX3Q=;
        b=eweN0b1Mcn20ps2Rk7+4SynfrYLZPBNJ0HBITBZfVIWrCYZn1G6hEOh5+XrIEMEgTW
         075TOY1nsLQ9H8k0Sh0UrWiz5rkDKfh2z2163d7IQKATKLfKO6XG0H1pJzW3U64vj2h3
         wLcC1nxFDntsrKxhuBMK7him0Y+ExLWS/2L7TmtWWiMN+yUtpejFvw5eRNEo2ejgLqYD
         bczxkcq2XhslPgyK60duJSx28tZFMhZoxljSs28P2kkGkKyYdvv65UWkPtyXkyvyRtX9
         UfnVeky0ZAmJc0ppd5Sm41b7/w0/PJaNhOiU66QWRvXzoKATfV4MYenVu9i11y+zmfZJ
         MbKA==
X-Gm-Message-State: AOJu0Yyyh2OFmAD4WUHXtdJzEkMrP2p3f7LWMB3Ll2iQEsBNgBLlHzza
	ufn/1IFuxk8yOqL5T6NpY3qLZORrglF5NA==
X-Google-Smtp-Source: AGHT+IFQ+879cPB96mB+qRdtO8ch3WDmQE2+Mg1lSxV1xg5CK21rYIIEy3ZAMMkigKWapWPYLD8hwA==
X-Received: by 2002:a50:a40f:0:b0:553:ffea:d0a7 with SMTP id u15-20020a50a40f000000b00553ffead0a7mr2818729edb.32.1703432682196;
        Sun, 24 Dec 2023 07:44:42 -0800 (PST)
Received: from [127.0.1.1] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id ge12-20020a170907908c00b00a26ac403032sm3325901ejb.65.2023.12.24.07.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 07:44:41 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 24 Dec 2023 16:44:09 +0100
Subject: [PATCH 10/15] media: s5p-mfc: constify struct structures
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231224-n-s5p-mfc-const-v1-10-a3b246470fe4@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3562;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=7eLA73/Lxy5Yo9MdLmPuVAn1gTKGvPSmfN1gvCYYUnY=;
 b=owEBfgKB/ZANAwAKAcE3ZuaGi4PXAcsmYgBliFHW4EG4R+SMVxMqgocTB7ioHMGzVI6kRjC2A
 uLDE5DR6naJAkQEAAEKAC4WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZYhR1hAca3J6a0BrZXJu
 ZWwub3JnAAoJEME3ZuaGi4PXOlQP/jKjDthPJX0wo8OYeoBSWUosWomRncDBw+86aGCEFofZ1uv
 1o4QQyQxQDNhXp82RVFP+6Bebq92iZx1GWeBGrmSLM4j772K4qn68mcVUBDlO25PqggkuoH0Zem
 gLu6laqCpqTNqD66qzkwOEmk4MrnAwgD29uSun+qznKrLyijwBfTywZ7ikTqjkb0aIZ4KbbtgRL
 MiZgm7Vk1FqxutaINdUs/16wyHY+GaoXId0udkhxPioi/8rpoW8yvWdCS1klvubi+EXQQs0QfsF
 nnKKqfjotnW0bkHMHpocTpaYzPVEBYYP4LozUGW7xgxhbqHtCLlQf4T4z7E9X+qs+ePOy6UhScX
 /S6temNSp7roQXy2nfQKV4NLf3sWaJcA1NBIxvQdWDsD+GmCeLqTDFHRgsvxNKBfKeDVZaswMRZ
 +mj9Qr9vOf04wy01lhYzN8mKuo0fGRSiH5PEMcRHc1jRyKb8v78QgAiaOtSnA7KvYZbiE2VuzZh
 4tDVKkPugU8AHrsqRuTzANXgzq0PORzQQtVs3R3+r74xjPabAzC77RhEfJD+x2KAp+0vm3of4sS
 e4bZtLNe5HQYg6fKxoX1mFjk8kJTuzpWX+h3qHxyxJGK4a+LWcTPzM0j2t2BwXkrarjsnTXRoc9
 Yji5Ay6x7yReo2GZTm9ZQsiK0vc+1JdNTvq4m
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Static "struct" structures are not modified by the driver, so
they can be made const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c | 4 ++--
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.h | 2 +-
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c | 4 ++--
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.h | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
index 2f664c7e9e4c..eef26d4e02cf 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
@@ -1117,7 +1117,7 @@ static void s5p_mfc_buf_queue(struct vb2_buffer *vb)
 	s5p_mfc_hw_call(dev->mfc_ops, try_run, dev);
 }
 
-static struct vb2_ops s5p_mfc_dec_qops = {
+static const struct vb2_ops s5p_mfc_dec_qops = {
 	.queue_setup		= s5p_mfc_queue_setup,
 	.wait_prepare		= vb2_ops_wait_prepare,
 	.wait_finish		= vb2_ops_wait_finish,
@@ -1132,7 +1132,7 @@ const struct s5p_mfc_codec_ops *get_dec_codec_ops(void)
 	return &decoder_codec_ops;
 }
 
-struct vb2_ops *get_dec_queue_ops(void)
+const struct vb2_ops *get_dec_queue_ops(void)
 {
 	return &s5p_mfc_dec_qops;
 }
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.h
index d4310966a0c2..47a6eb9a8fc0 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.h
@@ -10,7 +10,7 @@
 #define S5P_MFC_DEC_H_
 
 const struct s5p_mfc_codec_ops *get_dec_codec_ops(void);
-struct vb2_ops *get_dec_queue_ops(void);
+const struct vb2_ops *get_dec_queue_ops(void);
 const struct v4l2_ioctl_ops *get_dec_v4l2_ioctl_ops(void);
 int s5p_mfc_dec_ctrls_setup(struct s5p_mfc_ctx *ctx);
 void s5p_mfc_dec_ctrls_delete(struct s5p_mfc_ctx *ctx);
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
index d6a4b9c701eb..537c6e603cd5 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
@@ -2594,7 +2594,7 @@ static void s5p_mfc_buf_queue(struct vb2_buffer *vb)
 	s5p_mfc_hw_call(dev->mfc_ops, try_run, dev);
 }
 
-static struct vb2_ops s5p_mfc_enc_qops = {
+static const struct vb2_ops s5p_mfc_enc_qops = {
 	.queue_setup		= s5p_mfc_queue_setup,
 	.wait_prepare		= vb2_ops_wait_prepare,
 	.wait_finish		= vb2_ops_wait_finish,
@@ -2610,7 +2610,7 @@ const struct s5p_mfc_codec_ops *get_enc_codec_ops(void)
 	return &encoder_codec_ops;
 }
 
-struct vb2_ops *get_enc_queue_ops(void)
+const struct vb2_ops *get_enc_queue_ops(void)
 {
 	return &s5p_mfc_enc_qops;
 }
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.h
index 0cf08b8d40ff..62d6db67fd91 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.h
@@ -10,7 +10,7 @@
 #define S5P_MFC_ENC_H_
 
 const struct s5p_mfc_codec_ops *get_enc_codec_ops(void);
-struct vb2_ops *get_enc_queue_ops(void);
+const struct vb2_ops *get_enc_queue_ops(void);
 const struct v4l2_ioctl_ops *get_enc_v4l2_ioctl_ops(void);
 int s5p_mfc_enc_ctrls_setup(struct s5p_mfc_ctx *ctx);
 void s5p_mfc_enc_ctrls_delete(struct s5p_mfc_ctx *ctx);

-- 
2.34.1


