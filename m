Return-Path: <linux-kernel+bounces-162173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBD58B5714
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72A09287010
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0217B4DA05;
	Mon, 29 Apr 2024 11:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z3VpVOp/"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD87B4D583
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714391341; cv=none; b=J2Lk6g7Mp9XWpdVvruoWwbLCcCHSsUqipkSZghsGmqgVNwkQsoXZgfDUvsxDb1+iIfla598ZNKhGsBeXWg7Mu1SERDDA6K0JbXv0XZm9GOFsXtj6NVlyTQFYDkGAVvDsl655npsILbUpQB/yhg07EUhSYfR8FTJlVEhBvVJNPug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714391341; c=relaxed/simple;
	bh=8hlbxDVsli5Uho2Dc9zk1d5MLlzWuHE+5PgzBXH717k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QyLjnnG2/V2n89A4SOTjW0vu/zdKFiD/gaH0llegXBW84UfIqdfCKjyq3MO8PO3zo6GV3Cd/BepCYCzNnROxBm+8Gm52I8ckujt63Pk+2VyQA5llihFoGGOLK9WHxgHtnMgAIe8KoVYNw7rhNnB03RlZuCOLOWMpuqCw6XuRcis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z3VpVOp/; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a5894c1d954so61304966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 04:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714391337; x=1714996137; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zgF7uDK3ODdULvp2AprCnsXD0Ii385XkEkpICxLIUP8=;
        b=Z3VpVOp/fj9skUzNvQ2I4DpBywBiTsU2dpEHUtnsnHt0gxrb11EmBY8BXUzkzwGk+A
         Dh63MlkW5TzpYLqy8o+EO2dKXMh6Cal/C8F8sN8FpqvA3A0ty27v5cPmcrwr2vOg7IL8
         m1XsKekfTnCTXl9FMeJO9u5i1dZi3G6FLtfx2J4EBTi6Dve1ET4Gz7LPWmaTJ41DcWtF
         7y8vaxQPSghUs68i/PBet4TrpEM9D8B802vn99G28aZlIKCgDIL44SJ0B4yQ/mPl1xIu
         lOS0UWyMYXW7GrEzo5GUGjb664LMsghQdVKqqKBZ0Ys8e3rg0JJ1N2usE0e3YryvYx1x
         fGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714391337; x=1714996137;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zgF7uDK3ODdULvp2AprCnsXD0Ii385XkEkpICxLIUP8=;
        b=tybyX5GyIDL8GJP4K2Ea/8XpBWbMA1m360iSc1Lm+ZezocC9GR6TC9jYd93y+dr5rU
         A5QRXs3vdnpk2Ry9rlVUYHYfi+HNb951kaI3p0LHtf4QumJljSFKTSXvoQYbS1LFBwGq
         gK1rAiPe2zR9qB2afWgIaV06zO9QovQdbXClrW353vObgJy87TdnXc2LKAjvZQS7HarM
         CXu4QACGNDr5eloighzh0FlvfoAADRe7nS8ecXuUJcbi+qXnAsU6hn9tfeRdKQruIN8Z
         YJl7p/JbrffhA1WXXrjSmaxyqSlIQ3A44apHVfne8qEtUoEnDerGoJ6gKPGj/ok3IGY+
         cJ6A==
X-Forwarded-Encrypted: i=1; AJvYcCVszOCwttzFS5Fqi1pJ595WQpjc3N4tVfQ/h4T992tvpiLrOF5BLOu6b/UzyYk1IMIt8Yn+/yFjDYzn8kwfDqTplmAMvh/mN4SVmFRA
X-Gm-Message-State: AOJu0Yy15fVOoM+gCWkex8z94lf+/VJ9AV7ZgH7o0FcBXGrmGGEvb4Vl
	vawMWltVp6wmVlA6mPNsR41rVXYlKkIZC71Pl/apv/+Blccd0nRL6VnsJI9rG7c=
X-Google-Smtp-Source: AGHT+IFMulAQp2dFZ0Q7CZL4pR5DvDvO/9NEVxfbIybQWLY3FZZ5OUXvmdGImHkWL/GlP/fLlPTrQA==
X-Received: by 2002:a50:99c7:0:b0:572:3f41:25aa with SMTP id n7-20020a5099c7000000b005723f4125aamr8735212edb.11.1714391336676;
        Mon, 29 Apr 2024 04:48:56 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id y43-20020a50bb2e000000b0057000a2cb5bsm13549651ede.18.2024.04.29.04.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 04:48:56 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/4] ASoC: Constify static snd_pcm_hardware
Date: Mon, 29 Apr 2024 13:48:45 +0200
Message-Id: <20240429-n-asoc-const-snd-pcm-hardware-v1-0-c6ce60989834@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB2JL2YC/x3MQQqDQAwAwK9Izg1sFwXrV8RDyMaaQ7OSFFsQ/
 96lx7nMCSGuEjB1J7gcGlqt4X7rgDeyp6CWZsgp96nPDzSkqIxcLd4YVnDnF27k5UMuuCYaqMg
 4DkzQjt1l1e//n5fr+gFMAIkPbwAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1038;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=8hlbxDVsli5Uho2Dc9zk1d5MLlzWuHE+5PgzBXH717k=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmL4kgxXlqNnnMKJpg2EaIkw0QWwus3XmTLMuWB
 hWfdwwddXWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZi+JIAAKCRDBN2bmhouD
 14MsD/4wk/fFPGuo07Tc6t4ZBVVny/yf56kqMyV3UPs7GTN7fgENz4Vs5Gin8llVwv9nvvbIrfh
 cBrBJ53HMb7tMNtKDhoCjXLKV6y/XFF3OcjnUu8dFKF9+HWsntLk2pUa7XZf/m3xuCoFz+I2+2X
 FtEvt7tK7J1L1CbOP082IC4ZkhfTVvhN7VjqiC1AcntknqAwCKb5II6RAtl044X2cAgHBFXI7B1
 Qo/+a8PGKa0K0uBnIoHoNp75nHACjabA/jn601auP/o6zvNEBbjmG/1jviOgBIo6/+12fvjPqxx
 E9EcND0vFAI4b2W8IiR2Xg4uWuTtkzGOQ8gVmSQMUY/Xqhgulo8rrUYpnIV5JlSObZpNZstIdHZ
 3di//AnjPfGRIgVC0kO6jiOPGtCi/WnZe8zyg1tkArBgsmXLIXbuACRbR90yWnYeWGk0Ny8w76f
 T0pJ7kVVgxhVy84se9GzdxXC3V4bBs8KB0UmtCrmfQTKLG/ZcYUIptvLIejPfxSNAnOYcSN4XMu
 DF8BifoTInlQ+Xw9QYLBMmT5zOa2kXfIiS04T/C0Z55+ur3NPpX35/hwD93URXyFfrBLnClmjbo
 PHSEi6tWOFhgJAg8kZWEuqJOx4/8mOJxKL+LiIkCVek5bgHt7OxbuIiY10JdZB1Gy6BujtRGdnc
 RzHz8OsHOxt8zBQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

No dependencies.

Static 'struct snd_pcm_hardware' is not modified by few drivers and its
copy is passed to the core, so it can be made const for increased code
safety.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (4):
      ASoC: qcom: Constify static snd_pcm_hardware
      ASoC: fsl: Constify static snd_pcm_hardware
      ASoC: meson: Constify static snd_pcm_hardware
      ASoC: uniphier: Constify static snd_pcm_hardware

 sound/soc/fsl/imx-pcm-rpmsg.c    | 2 +-
 sound/soc/meson/aiu-fifo-i2s.c   | 2 +-
 sound/soc/meson/aiu-fifo-spdif.c | 2 +-
 sound/soc/meson/aiu-fifo.h       | 2 +-
 sound/soc/meson/axg-fifo.c       | 2 +-
 sound/soc/qcom/qdsp6/q6apm-dai.c | 4 ++--
 sound/soc/qcom/qdsp6/q6asm-dai.c | 2 +-
 sound/soc/uniphier/aio-dma.c     | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)
---
base-commit: ebbaba914053d8bcadd7d64eb8d2555299509a27
change-id: 20240429-n-asoc-const-snd-pcm-hardware-f0a5ade885ca

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


