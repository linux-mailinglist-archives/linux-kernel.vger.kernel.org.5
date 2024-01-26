Return-Path: <linux-kernel+bounces-40830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E6483E6A9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DCD21F2863E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F8A6280C;
	Fri, 26 Jan 2024 23:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XJebHFNU"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1EF5EE67
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 23:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310982; cv=none; b=oBAKKwsfaYD9QaSeC4NbrM8sqKLPH08RGQxvUzPSJtSi1y3jOUYrJtzijtKRoj3e0GX+qgj9dEHGXu5G3HCgMAeepPkEktxYGyC3FPi9bJe+XYONcW5tZsS7LEhKGuQXrSbaSgyfnt8vCsB74T4pKRF7DcNDuflAEyOGmjAHZWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310982; c=relaxed/simple;
	bh=vK6wWsO5Przh/ojH3JfCu7YYSoz/Cg2xAeL1Dht8Uos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G+yLOvNOjKmp+B+vcQt81+hTabK19QQRkDCXgRyIauDe0xXJOdDMxsZPWavxkApaDP2VkXL3P37JFGV1Z0bEXfmwIUTkIo1xGuxq0Co5OnIHWPFrh4+a41I+q2rCDlyJlrHn6Xwj8t1SZf/S02FrD/gqTyxX68QzRbzgvzjyszA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XJebHFNU; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7833a51a1aaso98136685a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706310978; x=1706915778; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJoiaHjGhItBXZj/CWSZG5W6mZ9RrzIgj+3pNfG2j8c=;
        b=XJebHFNUD6Q+ly97IhQVbsNuMoonpzSq5XiY+U09EHvlIs8tp5ViQr0vAGXU+ZhU9I
         lD+SCYMoCPKLyrNj7WzpSm9T667KB5nEMgEwEcoFZV0YmvrMviHURPg8fNpPCBpPFvhP
         1LR+YPOKIsmncuOKtTzTePos+v6HhwtZm0gdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706310978; x=1706915778;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJoiaHjGhItBXZj/CWSZG5W6mZ9RrzIgj+3pNfG2j8c=;
        b=FVwY6KVEPM/vLfuvIJxEzzA4smIwMFjWim10YTl66EEb89uDQdY9U0LjfzsEV5OInC
         8dLPLGvC4asPiCtKmP+NQV3Fr64rL1reYrPWS49E/dmQW2vvb0nKP88lpjAOum9y0Nix
         lv6doteWPSAsPZalUhjg3+vMgPE7XwVsymc2ycYu5HbYIVOi6AuixmoeFZ+AT63zziLU
         eyXaFT4S8RA9fUBQui7ECKrVypDoNfLN+kXrIcmBprfvT99XI0dKkTxDGeTwNQaIKiuv
         rB1vHQNSrKGOdLP2KMH4ZusPYE0lttkBK54SnZRp3krYNh4oDJ4GeMMj/RclQJrRbgTR
         L5BA==
X-Gm-Message-State: AOJu0Yw/vBalhvBFv8kjaBE8OgIA5ppoy5gqweYyqYG8yu4LMWxaLj2W
	b3cJE+oNe1A8OpLIEiEOvbYu1r98QdxdOf65IKvc/ilQ47qKzyEWW7GivJIPWg==
X-Google-Smtp-Source: AGHT+IFhQN8B5FsPqeRzzxRDyy6PJ/YXcjzquYxGB3Ad9UBljkLUVzxY+WO/snoMGhjDTG+ZaJzFDw==
X-Received: by 2002:a05:620a:108f:b0:783:df3d:ae88 with SMTP id g15-20020a05620a108f00b00783df3dae88mr485948qkk.49.1706310978262;
        Fri, 26 Jan 2024 15:16:18 -0800 (PST)
Received: from denia.c.googlers.com (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id m4-20020a05620a290400b00783de3ddf5esm507358qkp.70.2024.01.26.15.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 15:16:17 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 26 Jan 2024 23:16:11 +0000
Subject: [PATCH 12/17] media: samsung: exynos4-is: Fix kerneldoc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-gix-mtk-warnings-v1-12-eed7865fce18@chromium.org>
References: <20240126-gix-mtk-warnings-v1-0-eed7865fce18@chromium.org>
In-Reply-To: <20240126-gix-mtk-warnings-v1-0-eed7865fce18@chromium.org>
To: Tiffany Lin <tiffany.lin@mediatek.com>, 
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
 Yunfei Dong <yunfei.dong@mediatek.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, Hans Verkuil <hverkuil@xs4all.nl>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Bin Liu <bin.liu@mediatek.com>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Bingbu Cao <bingbu.cao@intel.com>, 
 Tianshu Qiu <tian.shu.qiu@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-amlogic@lists.infradead.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.3

Remove doc from missing fields.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/samsung/exynos4-is/fimc-lite.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-lite.h b/drivers/media/platform/samsung/exynos4-is/fimc-lite.h
index ddf29e0b5b1c..2d96fb00a5c6 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-lite.h
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-lite.h
@@ -117,8 +117,6 @@ struct flite_buffer {
  * @ctrl_handler: v4l2 control handler
  * @test_pattern: test pattern controls
  * @index: FIMC-LITE platform device index
- * @pipeline: video capture pipeline data structure
- * @pipeline_ops: media pipeline ops for the video node driver
  * @slock: spinlock protecting this data structure and the hw registers
  * @lock: mutex serializing video device and the subdev operations
  * @clock: FIMC-LITE gate clock
@@ -134,7 +132,6 @@ struct flite_buffer {
  * @active_buf_q: the queue head of buffers scheduled in hardware
  * @vb_queue: vb2 buffers queue
  * @buf_index: helps to keep track of the DMA start address register index
- * @active_buf_count: number of video buffers scheduled in hardware
  * @frame_count: the captured frames counter
  * @reqbufs_count: the number of buffers requested with REQBUFS ioctl
  * @events: event info

-- 
2.43.0.429.g432eaa2c6b-goog


