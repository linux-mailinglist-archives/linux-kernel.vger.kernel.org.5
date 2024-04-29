Return-Path: <linux-kernel+bounces-162176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8010A8B5718
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBDF81F20F88
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415AC535A4;
	Mon, 29 Apr 2024 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C04ANXxe"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54DB4CE19
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714391351; cv=none; b=S+wPlMyrMpJZq1V2z8cOKRO2cpY6npIsIWICJEdYlCHrG95Tn1USXxMIURULS+dPz8cunWm6VgsfRC+z5ZfnfazlwWWsmI5jrkqFaxKPXaiHU0vG59odjjzUCuy0D8XhdCm7jW4h7JmOHygTchWiswuDmX6aqWnTmIaFC9MaNCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714391351; c=relaxed/simple;
	bh=siprCfRQtWpQCCCk/EgBvG4/nMgpZ/i2CNSROadlb+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mkPoxQli/0DFwJCybNW2y/Ur4C50mmKI8sxNCuieHpstAhCv0N/14QsmgV0RXtH0HtGTfqkpqm7usLy7OxG1opFeppQZVVckjnW4HTfMV+SUKDKnjRFq+mcDdi2aiOVdkT498X7EH5sjGGbuMM2oRro5/k3oz/QEFLoj3etM944=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C04ANXxe; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e6a1edecfso6525835a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 04:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714391348; x=1714996148; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TFY2BJrqfoEw33ApHVjLKezetKZA4dvDEs7pqAJegiw=;
        b=C04ANXxeGavlyzytgZU6hN3Ho/+pfusQLoQ0UHVeRcX9l3XKtE2PWY/ZiwTqkTdkOF
         xR1SnjL3RukxAVwbSI8UJjICEFrKhx8dqHbpd+WSdOIV5ckqQDD5kPNve4R60yJe8a7f
         ifFQAfqYqb8P0RvSWpZjrrFb4dtLq2XTPwGnpEjQlnskieUl8L68IbwDRqAnHDCV6aJZ
         nBuItiLyeBHyH5XKYiogUb0OTsbekeBdXdyGC06w673cQTCtdNnjpVBDzNNkZLlOOZXI
         wS9JxSPLjae8eH4jhmG2Xy7QTGCZBWW+5+ECEyEsMp1Om/I4GQYzT9GgPUhSWPT0DK0y
         zM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714391348; x=1714996148;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TFY2BJrqfoEw33ApHVjLKezetKZA4dvDEs7pqAJegiw=;
        b=F4MugvquYbgmHzKNcbhHvp6iAsEs4+9vf11ZLX+ou9dVyAVlOovCz/hmar67Pb+JUf
         Vjf+OIc+mIjHnChmuakzvzLrnslgf16FyuRamoHffaUadPpOahQ27JQFwlnzC9SH9Co0
         EP8DvwsGNLPah0Yz2mNDIZajCDqOygM4W91ZMOKXIvSJM4cArI1GEx7UkWj2kEjPkIJQ
         tDFNx4D7Cy4x5grXwVEK8r3Y/9ThlBxyWmga1Ne4qRlEo3USJIgqWYh5qyY/H38lrhDY
         xC5DlKcqxFGK6wV7pSJmUkYVf3VnamTDpReBANVSwHEpCwfjoLVoyhGgkKS30dfycO1i
         xUDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0z2drvb1WomJpDaKNvk02FmWCdPWUup1o30gP9ajTZVeoCZTA0SoQIpwlUcxFX1caOU3b1bjK8G00X5cOD7vuJdAqFUeUJYs0V2s7
X-Gm-Message-State: AOJu0Yzwc3YSV1NTSnZtd9rPQD5dYANAjieJJ9BQ41bUeMDdm2M8vdrM
	nYV1tBUV422tHC5sOB6+2Daei61sYi8igD7fWDB3SsAReFh8ZMO6Si85IeHlk6k=
X-Google-Smtp-Source: AGHT+IHr1i+P/yQq8bNC4hXAKz0hI9Zk8EupFlwsHF2uyxSdfVH1X92jPdRxN/6FjGHLuxgVDiSE9g==
X-Received: by 2002:a05:6402:1a4d:b0:572:8aab:4420 with SMTP id bf13-20020a0564021a4d00b005728aab4420mr504841edb.39.1714391348231;
        Mon, 29 Apr 2024 04:49:08 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id y43-20020a50bb2e000000b0057000a2cb5bsm13549651ede.18.2024.04.29.04.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 04:49:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 29 Apr 2024 13:48:48 +0200
Subject: [PATCH 3/4] ASoC: meson: Constify static snd_pcm_hardware
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240429-n-asoc-const-snd-pcm-hardware-v1-3-c6ce60989834@linaro.org>
References: <20240429-n-asoc-const-snd-pcm-hardware-v1-0-c6ce60989834@linaro.org>
In-Reply-To: <20240429-n-asoc-const-snd-pcm-hardware-v1-0-c6ce60989834@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Shengjiu Wang <shengjiu.wang@gmail.com>, 
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
 Nicolin Chen <nicoleotsuka@gmail.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2299;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=siprCfRQtWpQCCCk/EgBvG4/nMgpZ/i2CNSROadlb+k=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmL4klip7kMQMnb9G4Un51jC6C4Sy6sBF7+x0fz
 ZtOzlrSQNqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZi+JJQAKCRDBN2bmhouD
 1zwfD/oCx8UsThy03fZQjvfzPPcHgd0sRjY0kzWjofPTFWoZrVbUl44+srODgATNkHSmXju076H
 /8V0+7FBomIBsrL/34jm+W7Ws2vae7j5TdY5WuquXO2P6hR5pry/+g8stMlQ0a09eWKWwOTUvuP
 09V4EzktH6rje90J1+lyxp9U0H0ROUA7LVYvj/uipaB/xhKtMk8CIuMIhpmkwPBBLfK11iXpjLk
 E2RvbOBGvGQd81MNYefDVd9DRbqfqcuLEmqjm/9yx7fLKq/A0AmAYbBQr66grnffuPOmoQD0Brz
 448EDhEzJcawBxb1rCp46MqUN8IYEMZMLsXXCkcpJIdJzUYeQunzaZp0Neu+haV/pZc02pOr3qN
 uEzMnAOOP0ZVoPyPOvWaJ19G/tlxIvOmLxPuG9WktTK3F5n5Kn0GaxpWvLth5zXWj+OITLwkfZo
 Ki3HsUbdVtdhPM3Vx4gW6BHI5l3UzxqQK3slZQnatydFdONKuXuKKIa0uNvspzVB+Jes2wZoKE8
 Bg05N8617xn/CcWWHYg/Rheq+bxja9iY5ZXhfmpUAQLsyebOXkfmxY8DB891GxnCFDOuuUtipbA
 xZDgKdZ6MAMWj2eZYZCzPwcML4hWxnH6sG4b8Ep0QD2u46DE4BM/yuRcaanbojeZz3UktdT8/ou
 SUnWJYvw0bJJVAw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Static 'struct snd_pcm_hardware' is not modified by the driver and its
copy is passed to the core, so it can be made const for increased code
safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/meson/aiu-fifo-i2s.c   | 2 +-
 sound/soc/meson/aiu-fifo-spdif.c | 2 +-
 sound/soc/meson/aiu-fifo.h       | 2 +-
 sound/soc/meson/axg-fifo.c       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/meson/aiu-fifo-i2s.c b/sound/soc/meson/aiu-fifo-i2s.c
index 7d833500c799..eccbc16b293a 100644
--- a/sound/soc/meson/aiu-fifo-i2s.c
+++ b/sound/soc/meson/aiu-fifo-i2s.c
@@ -25,7 +25,7 @@
 
 #define AIU_FIFO_I2S_BLOCK		256
 
-static struct snd_pcm_hardware fifo_i2s_pcm = {
+static const struct snd_pcm_hardware fifo_i2s_pcm = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED |
 		 SNDRV_PCM_INFO_MMAP |
 		 SNDRV_PCM_INFO_MMAP_VALID |
diff --git a/sound/soc/meson/aiu-fifo-spdif.c b/sound/soc/meson/aiu-fifo-spdif.c
index fa91f3c53fa4..e0e00ec026dc 100644
--- a/sound/soc/meson/aiu-fifo-spdif.c
+++ b/sound/soc/meson/aiu-fifo-spdif.c
@@ -27,7 +27,7 @@
 
 #define AIU_FIFO_SPDIF_BLOCK			8
 
-static struct snd_pcm_hardware fifo_spdif_pcm = {
+static const struct snd_pcm_hardware fifo_spdif_pcm = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED |
 		 SNDRV_PCM_INFO_MMAP |
 		 SNDRV_PCM_INFO_MMAP_VALID |
diff --git a/sound/soc/meson/aiu-fifo.h b/sound/soc/meson/aiu-fifo.h
index 42ce266677cc..84ab4577815a 100644
--- a/sound/soc/meson/aiu-fifo.h
+++ b/sound/soc/meson/aiu-fifo.h
@@ -18,7 +18,7 @@ struct snd_pcm_hw_params;
 struct platform_device;
 
 struct aiu_fifo {
-	struct snd_pcm_hardware *pcm;
+	const struct snd_pcm_hardware *pcm;
 	unsigned int mem_offset;
 	unsigned int fifo_block;
 	struct clk *pclk;
diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index bebee0ca8e38..633fd971b444 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -23,7 +23,7 @@
  * These differences are handled in the respective DAI drivers
  */
 
-static struct snd_pcm_hardware axg_fifo_hw = {
+static const struct snd_pcm_hardware axg_fifo_hw = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED |
 		 SNDRV_PCM_INFO_MMAP |
 		 SNDRV_PCM_INFO_MMAP_VALID |

-- 
2.43.0


