Return-Path: <linux-kernel+bounces-164069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5DA8B786B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7363F1C227DC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A0C178CD6;
	Tue, 30 Apr 2024 14:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FV0KeHFA"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BD5176FC0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485763; cv=none; b=OI6lsJLTDUA+FauOTcdzXAZbrQPVl5XsHaT6Lc1SyhmW+R8zt6E8GecD7lGbIk8+yyA0n1+DJbOLXqx0ycs+2UBXvCZBuLKHVyptD8N6vsidKnKzfPpeFmivWimNger5kjV7+80eSF6Q4r49x4JPgu19cSyK8paijWRQbk1KqCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485763; c=relaxed/simple;
	bh=EYOXzIuCEupt1Jy5CsKHEjSmv9410RCbwX9prH3L2HA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=akaUiqosaslaJbtgnxsJ7fICK31wmdlk090Ltoc8y+hz1nvPLEoTrXc215rkHvXp3ehuJ02CMR2apXmCqdPN40sz0s+ocn8+Kvx+WQYM+NL8eviApetcBghke89haXntRPvBJ+VcXNsEpHzMLoB+bqjLCd8V3q7hBIH5VkxaMmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FV0KeHFA; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so6037450a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714485759; x=1715090559; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sbe9yQYz/BTDyMh+ij8kmCNBJHEOOFsTDuijF7mUMdo=;
        b=FV0KeHFAOojFBLFgcvxg79kxqHlEg4+mhd43zc86eIjHzitFHmh7fYy/Ji23MLpAKW
         QMS7ejQKzb0w3IPXuVqtx0xBlt81BDya+iWcbQ0R/uF5EV3bLUqw5t8yhfL/c3ebl/Kq
         HT9pQUd7mmNbMz4ZAYmB9GBX8nxoNrDW20w/tXIoglw83DfYGsxCUQAx+aL6bkLqxr9z
         TKvGDOO2agCf7j4BfcGYs0Ln0tpWzkM3AKF0N8A255Cfmeali7S3oRkM/HSd/joIKWXH
         kOkM1DAHbLEJ221N5tabU/0c8y4c2fduh2JdBJLt+4xlSRksxVxkywZ/AYMDpw9GTVgK
         kECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714485759; x=1715090559;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sbe9yQYz/BTDyMh+ij8kmCNBJHEOOFsTDuijF7mUMdo=;
        b=ZRnmsMqwR7ElxGJg3cL1ezqSspoM0G+abscV1oqXTExvTw0yut3EVm8GATHEyrLpB2
         YOAAxVuoZ541mGT4kd0rzeu8D75niVEuuJ/tlTSscHIurfob+KCEfQmeXKJ3WDCjh9dH
         I8oH30Bs+CjMIVy2lePNld2QUw2dxQ9vcBBAJTS8R0r68Rjkgw9NmxXLGgXaOd+0SV1k
         QQquaVl6oiHKD6BfmQuxRBX+YaokQpyHMKtWqErdPczOWChZgFbfSXAlCD4jOOahXh5a
         1+XKPHpMp4nX1sLhXVvzWje5KmJL27DOJbCisZdRjlB1MoY/NPmc/+zkNPMnFJUo1o2C
         HU0w==
X-Forwarded-Encrypted: i=1; AJvYcCXf/k/dVA5tr/9V+1JH/Ykkl3dAATSZ+V4BIGNIyOLMclP9sWFbiALEcAmisbPXJIcwfphemq0KAQBhyHTxyXx2k34e6lmE7j7Myyj4
X-Gm-Message-State: AOJu0YxJqpiMzvNBJZUFxH2+5NZc8+G9cdJZYs39Y4w9NspxL5ZJCJhg
	Tn2N4Vfo55ZuI0JdqdQdUSA17h+82xxNiWikzJbtIXt5AePsmkR6d3kmMJP4Niw=
X-Google-Smtp-Source: AGHT+IHdsI/DUhcbw7hzBVg3qBc+0V12TRFrR9cHpVMwu16bSy1BMgvI9FUIj8Pm8ojhCeGhB8Fiiw==
X-Received: by 2002:a17:907:318a:b0:a58:c6b2:7885 with SMTP id xe10-20020a170907318a00b00a58c6b27885mr9202903ejb.5.1714485758809;
        Tue, 30 Apr 2024 07:02:38 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id pv27-20020a170907209b00b00a5940af3f67sm31434ejb.16.2024.04.30.07.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 07:02:38 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 30 Apr 2024 16:02:10 +0200
Subject: [PATCH 01/13] ASoC: qcom: Use snd_soc_substream_to_rtd() for
 accessing private_data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-asoc-snd-substream-clean-v1-1-6f8a8902b479@linaro.org>
References: <20240430-asoc-snd-substream-clean-v1-0-6f8a8902b479@linaro.org>
In-Reply-To: <20240430-asoc-snd-substream-clean-v1-0-6f8a8902b479@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Jarkko Nikula <jarkko.nikula@bitmer.com>, Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, 
 Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Ban Tao <fengzheng923@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev, 
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16677;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=EYOXzIuCEupt1Jy5CsKHEjSmv9410RCbwX9prH3L2HA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmMPntVJM7CBtiQZFjdHajiCBztuYxeWNOxPU37
 X+UX9z90+WJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZjD57QAKCRDBN2bmhouD
 13TmD/4qXIFaAFDXeCnNH0oAhrw32XJLa2r3bqvZKguGT0+ATfy44c3d51Qq7HrO6cDzUxb5jc2
 z2B6V8dKyW4x0faVkGAgaBZLre/d1WUEqqBzctl7BwEZk23qmkKT03pbNXUwmlHeH7YPx+i9sXL
 0plZxZ3GX571+WtXFP3jm4GpC9y74ofLinuLh6dt0pozVAyZw2/Z8k/SbHHbQscrUaIoxviLt6y
 0dEgjah8Te5XYkztgH6jAqHiIvnT7Lgxt8f2cW6YwfamB4QBXRCM+AAbi1MWSVeVzAEzq9jNpE5
 XQEDgjqzWFHzCh7tKy1rIhkLD103PzDQErh7U8a9S54rbhBp9xJehRvwRLLL0IPdXC3LEZKIN/J
 AjZti7/kUkKyMqV704d95S51YRPIzcuoxttt7UZtJqRLz/uDO2zMh5sK62hnnlIvv/WnJjwgH3K
 bPgiTNn4xEpBoExU9BHkIHW2INjXwvdV9KKS/+nwijUZ9N2r0EBFvxkIejt/k1f4wDF8zTLehIS
 Y/2dD7l8r9Npn4xP+5JlitTv3jz00tQkKvBzlwLDYM7f7dG5cvKuUiVmeeYOq4Wn0Ayl0gR/kkj
 yg0bb+7TOKaiD88drOq1soPfu7t+2MSBBfqOTZeX0H5WzYZ5CfUFXb+VNXvdxjeHMFWiIze3alk
 lEtGF3oLa91efbA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Do not open-code snd_soc_substream_to_rtd().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/qcom/apq8016_sbc.c     |  4 ++--
 sound/soc/qcom/qdsp6/q6apm-dai.c |  2 +-
 sound/soc/qcom/sc7180.c          | 10 +++++-----
 sound/soc/qcom/sc7280.c          | 12 ++++++------
 sound/soc/qcom/sc8280xp.c        |  8 ++++----
 sound/soc/qcom/sdw.c             |  8 ++++----
 sound/soc/qcom/sm8250.c          | 10 +++++-----
 sound/soc/qcom/x1e80100.c        |  8 ++++----
 8 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
index 4834a56eaa88..3023cf180a75 100644
--- a/sound/soc/qcom/apq8016_sbc.c
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -192,7 +192,7 @@ static int msm8916_qdsp6_dai_init(struct snd_soc_pcm_runtime *rtd)
 
 static int msm8916_qdsp6_startup(struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_card *card = rtd->card;
 	struct apq8016_sbc_data *data = snd_soc_card_get_drvdata(card);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
@@ -213,7 +213,7 @@ static int msm8916_qdsp6_startup(struct snd_pcm_substream *substream)
 
 static void msm8916_qdsp6_shutdown(struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_card *card = rtd->card;
 	struct apq8016_sbc_data *data = snd_soc_card_get_drvdata(card);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index df19fc3376b7..db2f82e00a49 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -329,7 +329,7 @@ static int q6apm_dai_open(struct snd_soc_component *component,
 			  struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_soc_pcm_runtime *soc_prtd = substream->private_data;
+	struct snd_soc_pcm_runtime *soc_prtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(soc_prtd, 0);
 	struct device *dev = component->dev;
 	struct q6apm_dai_data *pdata;
diff --git a/sound/soc/qcom/sc7180.c b/sound/soc/qcom/sc7180.c
index 029780d6fe6d..bc030ce29680 100644
--- a/sound/soc/qcom/sc7180.c
+++ b/sound/soc/qcom/sc7180.c
@@ -200,7 +200,7 @@ static int sc7180_startup_realtek_codec(struct snd_soc_pcm_runtime *rtd)
 
 static int sc7180_snd_startup(struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_card *card = rtd->card;
 	struct sc7180_snd_data *data = snd_soc_card_get_drvdata(card);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
@@ -234,7 +234,7 @@ static int sc7180_snd_startup(struct snd_pcm_substream *substream)
 
 static int sc7180_qdsp_snd_startup(struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_card *card = rtd->card;
 	struct sc7180_snd_data *data = snd_soc_card_get_drvdata(card);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
@@ -307,7 +307,7 @@ static int dmic_set(struct snd_kcontrol *kcontrol,
 
 static void sc7180_snd_shutdown(struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_card *card = rtd->card;
 	struct sc7180_snd_data *data = snd_soc_card_get_drvdata(card);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
@@ -334,7 +334,7 @@ static void sc7180_snd_shutdown(struct snd_pcm_substream *substream)
 
 static void sc7180_qdsp_snd_shutdown(struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_card *card = rtd->card;
 	struct sc7180_snd_data *data = snd_soc_card_get_drvdata(card);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
@@ -389,7 +389,7 @@ static int sc7180_adau7002_init(struct snd_soc_pcm_runtime *rtd)
 
 static int sc7180_adau7002_snd_startup(struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
 	struct snd_pcm_runtime *runtime = substream->runtime;
diff --git a/sound/soc/qcom/sc7280.c b/sound/soc/qcom/sc7280.c
index d36f029b7888..207ac5da4dd4 100644
--- a/sound/soc/qcom/sc7280.c
+++ b/sound/soc/qcom/sc7280.c
@@ -205,7 +205,7 @@ static int sc7280_snd_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *codec_dai;
 	const struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct sc7280_snd_data *pdata = snd_soc_card_get_drvdata(rtd->card);
@@ -237,7 +237,7 @@ static int sc7280_snd_hw_params(struct snd_pcm_substream *substream,
 
 static int sc7280_snd_swr_prepare(struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	const struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct sc7280_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
 	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
@@ -268,7 +268,7 @@ static int sc7280_snd_swr_prepare(struct snd_pcm_substream *substream)
 
 static int sc7280_snd_prepare(struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	const struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 
 	switch (cpu_dai->id) {
@@ -287,7 +287,7 @@ static int sc7280_snd_prepare(struct snd_pcm_substream *substream)
 
 static int sc7280_snd_hw_free(struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct sc7280_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
 	const struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
@@ -312,7 +312,7 @@ static int sc7280_snd_hw_free(struct snd_pcm_substream *substream)
 
 static void sc7280_snd_shutdown(struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_card *card = rtd->card;
 	struct sc7280_snd_data *data = snd_soc_card_get_drvdata(card);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
@@ -339,7 +339,7 @@ static int sc7280_snd_startup(struct snd_pcm_substream *substream)
 {
 	unsigned int fmt = SND_SOC_DAIFMT_CBS_CFS;
 	unsigned int codec_dai_fmt = SND_SOC_DAIFMT_CBS_CFS;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
 	int ret = 0;
diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
index 878bd50ad4a7..06fd47c4178f 100644
--- a/sound/soc/qcom/sc8280xp.c
+++ b/sound/soc/qcom/sc8280xp.c
@@ -50,7 +50,7 @@ static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
 
 static void sc8280xp_snd_shutdown(struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct sc8280xp_snd_data *pdata = snd_soc_card_get_drvdata(rtd->card);
 	struct sdw_stream_runtime *sruntime = pdata->sruntime[cpu_dai->id];
@@ -89,7 +89,7 @@ static int sc8280xp_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 static int sc8280xp_snd_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct sc8280xp_snd_data *pdata = snd_soc_card_get_drvdata(rtd->card);
 
@@ -98,7 +98,7 @@ static int sc8280xp_snd_hw_params(struct snd_pcm_substream *substream,
 
 static int sc8280xp_snd_prepare(struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct sc8280xp_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
 	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
@@ -109,7 +109,7 @@ static int sc8280xp_snd_prepare(struct snd_pcm_substream *substream)
 
 static int sc8280xp_snd_hw_free(struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct sc8280xp_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
diff --git a/sound/soc/qcom/sdw.c b/sound/soc/qcom/sdw.c
index 7f5089bbe022..eaa8bb016e50 100644
--- a/sound/soc/qcom/sdw.c
+++ b/sound/soc/qcom/sdw.c
@@ -21,7 +21,7 @@
  */
 int qcom_snd_sdw_startup(struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct sdw_stream_runtime *sruntime;
 	struct snd_soc_dai *codec_dai;
@@ -54,7 +54,7 @@ int qcom_snd_sdw_prepare(struct snd_pcm_substream *substream,
 			 struct sdw_stream_runtime *sruntime,
 			 bool *stream_prepared)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	int ret;
 
@@ -105,7 +105,7 @@ int qcom_snd_sdw_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *params,
 			   struct sdw_stream_runtime **psruntime)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *codec_dai;
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct sdw_stream_runtime *sruntime;
@@ -135,7 +135,7 @@ EXPORT_SYMBOL_GPL(qcom_snd_sdw_hw_params);
 int qcom_snd_sdw_hw_free(struct snd_pcm_substream *substream,
 			 struct sdw_stream_runtime *sruntime, bool *stream_prepared)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 
 	switch (cpu_dai->id) {
diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
index d70df72c0160..a15dafb99b33 100644
--- a/sound/soc/qcom/sm8250.c
+++ b/sound/soc/qcom/sm8250.c
@@ -50,7 +50,7 @@ static int sm8250_snd_startup(struct snd_pcm_substream *substream)
 {
 	unsigned int fmt = SND_SOC_DAIFMT_BP_FP;
 	unsigned int codec_dai_fmt = SND_SOC_DAIFMT_BC_FC;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
 
@@ -72,7 +72,7 @@ static int sm8250_snd_startup(struct snd_pcm_substream *substream)
 
 static void sm2450_snd_shutdown(struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct sm8250_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
 	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
@@ -84,7 +84,7 @@ static void sm2450_snd_shutdown(struct snd_pcm_substream *substream)
 static int sm8250_snd_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct sm8250_snd_data *pdata = snd_soc_card_get_drvdata(rtd->card);
 
@@ -93,7 +93,7 @@ static int sm8250_snd_hw_params(struct snd_pcm_substream *substream,
 
 static int sm8250_snd_prepare(struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct sm8250_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
 	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
@@ -104,7 +104,7 @@ static int sm8250_snd_prepare(struct snd_pcm_substream *substream)
 
 static int sm8250_snd_hw_free(struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct sm8250_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
diff --git a/sound/soc/qcom/x1e80100.c b/sound/soc/qcom/x1e80100.c
index c3c8bf7ffb5b..0e0773a85809 100644
--- a/sound/soc/qcom/x1e80100.c
+++ b/sound/soc/qcom/x1e80100.c
@@ -31,7 +31,7 @@ static int x1e80100_snd_init(struct snd_soc_pcm_runtime *rtd)
 
 static void x1e80100_snd_shutdown(struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct x1e80100_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
 	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
@@ -67,7 +67,7 @@ static int x1e80100_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 static int x1e80100_snd_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct x1e80100_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
 
@@ -76,7 +76,7 @@ static int x1e80100_snd_hw_params(struct snd_pcm_substream *substream,
 
 static int x1e80100_snd_prepare(struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct x1e80100_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
 	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
@@ -87,7 +87,7 @@ static int x1e80100_snd_prepare(struct snd_pcm_substream *substream)
 
 static int x1e80100_snd_hw_free(struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct x1e80100_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];

-- 
2.43.0


