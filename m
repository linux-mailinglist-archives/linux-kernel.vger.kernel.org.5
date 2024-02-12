Return-Path: <linux-kernel+bounces-61835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D061B85173A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CA74283466
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3556C3B781;
	Mon, 12 Feb 2024 14:44:43 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5997E28389;
	Mon, 12 Feb 2024 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707749082; cv=none; b=Uak7I5M2dpIzM14CYXLHJ3CzjeoNOnPM9Wkd3PTsXKooB9P8OP+z6yYNzFhotkboh7V4YZ1IRGvLOvHJRNw5rRAT0nnXislAkp3zSXqH1sHym1KGTPDKOMTdJuq3FPnBp8fjynI6Q6vtWV1/tpHWlP3ATTgtU3XiOT5ZYbIClsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707749082; c=relaxed/simple;
	bh=WaeIv7+ItDIkBtIePy0VDoxQcmIyIXt+XWTOFfl0jWw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tL1itjgRAvLBNmlAeunY3tBMqMOGEGPWuRBIUyfmxjWhSTDTyUsEyflTp+LkTuRae65R6nSvah9HSiP6thdVOMqUVFGDbg5Va5/vqqrweR1Gqt8sApzSCSA3T5g306MSJ+PYCc4A//0tmLrtBhho1tMqwkprHyHyyK/H07VHlLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail2.sysu.edu.cn; spf=pass smtp.mailfrom=mail2.sysu.edu.cn; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail2.sysu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail2.sysu.edu.cn
X-QQ-mid: bizesmtp75t1707748998tos1jfhl
X-QQ-Originating-IP: XCxMfl4zxjZgVvN+Wm6q5OKrDL4vr/ck+nFLjccppeQ=
Received: from VM-16-2-ubuntu.. ( [122.51.61.190])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 12 Feb 2024 22:43:16 +0800 (CST)
X-QQ-SSF: 01400000000000B0R000000A0000000
X-QQ-FEAT: +ynUkgUhZJlWkuX9oFjGafb11b8pHgwFDTjbDZpXFPQ0hz636G6iKTeRs6sWY
	We1Bue9Kefq8A23K+Iquc9xKYw0YWy66JmbAFeeArZc8obFs5RsvdEzHRcCWU6p2bseX3HJ
	eXynXHlbJ0gpPtXzBZA83/clTSRXhbTPC0rqbCxlEAHKmKEmm+BGKQ0VqVpwNrmx61+pAtn
	LQHCsuCa+r1u4S4RYM0hrqaI5aA21FEHUMnoRj/dnuwg/hW5mDbSjgybu9o8nql2jgH/6Lx
	8KO0k0nTu12Kmgo3wnVVM/t9Vx0hMUxCU0FrQ+rg5z9TD3JfqwHrMGK9ienYuvSuB6EX+18
	TkZRIXBXR/F0ps7hq0MRxCd6RGwrdTABXby4eKfKkvQCaXq99MY3ECep9dxKiCKZGgUtkex
	WSNVJkeBxeo=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 9194800066344149808
From: Yinchuan Guo <guoych37@mail2.sysu.edu.cn>
To: Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Yinchuan Guo <guoych37@mail2.sysu.edu.cn>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: codecs: fix TYPO 'reguest' to 'request' in error log
Date: Mon, 12 Feb 2024 22:42:45 +0800
Message-Id: <20240212144247.43744-1-guoych37@mail2.sysu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:mail2.sysu.edu.cn:qybglogicsvrsz:qybglogicsvrsz3a-1

This patch corrects a common misspelling of "request" as "reguest" found
in error log across multiple files within sound/soc/codecs.

Signed-off-by: Yinchuan Guo <guoych37@mail2.sysu.edu.cn>
---
 sound/soc/codecs/rt274.c      | 2 +-
 sound/soc/codecs/rt286.c      | 2 +-
 sound/soc/codecs/rt298.c      | 2 +-
 sound/soc/codecs/rt5514-spi.c | 2 +-
 sound/soc/codecs/rt5645.c     | 2 +-
 sound/soc/codecs/rt5651.c     | 2 +-
 sound/soc/codecs/rt5659.c     | 2 +-
 sound/soc/codecs/rt5663.c     | 2 +-
 sound/soc/codecs/rt5665.c     | 2 +-
 sound/soc/codecs/rt5668.c     | 2 +-
 sound/soc/codecs/rt5682-i2c.c | 2 +-
 sound/soc/codecs/rt5682s.c    | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/rt274.c b/sound/soc/codecs/rt274.c
index 9a33e3776b55..6e7843484250 100644
--- a/sound/soc/codecs/rt274.c
+++ b/sound/soc/codecs/rt274.c
@@ -1192,7 +1192,7 @@ static int rt274_i2c_probe(struct i2c_client *i2c)
 			IRQF_TRIGGER_HIGH | IRQF_ONESHOT, "rt274", rt274);
 		if (ret != 0) {
 			dev_err(&i2c->dev,
-				"Failed to reguest IRQ: %d\n", ret);
+				"Failed to request IRQ: %d\n", ret);
 			return ret;
 		}
 	}
diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 981155b046fd..f8994f4968c5 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -1237,7 +1237,7 @@ static int rt286_i2c_probe(struct i2c_client *i2c)
 			IRQF_TRIGGER_HIGH | IRQF_ONESHOT, "rt286", rt286);
 		if (ret != 0) {
 			dev_err(&i2c->dev,
-				"Failed to reguest IRQ: %d\n", ret);
+				"Failed to request IRQ: %d\n", ret);
 			return ret;
 		}
 	}
diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index ad3783ade1b5..03d9839a5de3 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -1284,7 +1284,7 @@ static int rt298_i2c_probe(struct i2c_client *i2c)
 			IRQF_TRIGGER_HIGH | IRQF_ONESHOT, "rt298", rt298);
 		if (ret != 0) {
 			dev_err(&i2c->dev,
-				"Failed to reguest IRQ: %d\n", ret);
+				"Failed to request IRQ: %d\n", ret);
 			return ret;
 		}
 	}
diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index 3ee6d85268ba..f475c8cfadae 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -279,7 +279,7 @@ static int rt5514_spi_pcm_probe(struct snd_soc_component *component)
 			rt5514_dsp);
 		if (ret)
 			dev_err(&rt5514_spi->dev,
-				"%s Failed to reguest IRQ: %d\n", __func__,
+				"%s Failed to request IRQ: %d\n", __func__,
 				ret);
 		else
 			device_init_wakeup(rt5514_dsp->dev, true);
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 5150d6ee3748..61624c502261 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -4197,7 +4197,7 @@ static int rt5645_i2c_probe(struct i2c_client *i2c)
 			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
 			| IRQF_ONESHOT, "rt5645", rt5645);
 		if (ret) {
-			dev_err(&i2c->dev, "Failed to reguest IRQ: %d\n", ret);
+			dev_err(&i2c->dev, "Failed to request IRQ: %d\n", ret);
 			goto err_enable;
 		}
 	}
diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 0cee4fd1c84b..33a34bd0b405 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -2261,7 +2261,7 @@ static int rt5651_i2c_probe(struct i2c_client *i2c)
 			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
 			       | IRQF_ONESHOT | IRQF_NO_AUTOEN, "rt5651", rt5651);
 	if (ret) {
-		dev_warn(&i2c->dev, "Failed to reguest IRQ %d: %d\n",
+		dev_warn(&i2c->dev, "Failed to request IRQ %d: %d\n",
 			 rt5651->irq, ret);
 		rt5651->irq = -ENXIO;
 	}
diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index a061028a16d8..fb094c0fe740 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -4292,7 +4292,7 @@ static int rt5659_i2c_probe(struct i2c_client *i2c)
 			rt5659_irq, IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
 			| IRQF_ONESHOT, "rt5659", rt5659);
 		if (ret)
-			dev_err(&i2c->dev, "Failed to reguest IRQ: %d\n", ret);
+			dev_err(&i2c->dev, "Failed to request IRQ: %d\n", ret);
 
 		/* Enable IRQ output for GPIO1 pin any way */
 		regmap_update_bits(rt5659->regmap, RT5659_GPIO_CTRL_1,
diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index 9550492605ac..161dcb3915f9 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -3692,7 +3692,7 @@ static int rt5663_i2c_probe(struct i2c_client *i2c)
 			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
 			| IRQF_ONESHOT, "rt5663", rt5663);
 		if (ret) {
-			dev_err(&i2c->dev, "%s Failed to reguest IRQ: %d\n",
+			dev_err(&i2c->dev, "%s Failed to request IRQ: %d\n",
 				__func__, ret);
 			goto err_enable;
 		}
diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index a39de4a7df00..6f778c8f0832 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4929,7 +4929,7 @@ static int rt5665_i2c_probe(struct i2c_client *i2c)
 			rt5665_irq, IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
 			| IRQF_ONESHOT, "rt5665", rt5665);
 		if (ret)
-			dev_err(&i2c->dev, "Failed to reguest IRQ: %d\n", ret);
+			dev_err(&i2c->dev, "Failed to request IRQ: %d\n", ret);
 
 	}
 
diff --git a/sound/soc/codecs/rt5668.c b/sound/soc/codecs/rt5668.c
index 4623b3e62487..6d8e228ccb57 100644
--- a/sound/soc/codecs/rt5668.c
+++ b/sound/soc/codecs/rt5668.c
@@ -2580,7 +2580,7 @@ static int rt5668_i2c_probe(struct i2c_client *i2c)
 			rt5668_irq, IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
 			| IRQF_ONESHOT, "rt5668", rt5668);
 		if (ret)
-			dev_err(&i2c->dev, "Failed to reguest IRQ: %d\n", ret);
+			dev_err(&i2c->dev, "Failed to request IRQ: %d\n", ret);
 
 	}
 
diff --git a/sound/soc/codecs/rt5682-i2c.c b/sound/soc/codecs/rt5682-i2c.c
index fbad1ed06626..62f26ce9d476 100644
--- a/sound/soc/codecs/rt5682-i2c.c
+++ b/sound/soc/codecs/rt5682-i2c.c
@@ -266,7 +266,7 @@ static int rt5682_i2c_probe(struct i2c_client *i2c)
 		if (!ret)
 			rt5682->irq = i2c->irq;
 		else
-			dev_err(&i2c->dev, "Failed to reguest IRQ: %d\n", ret);
+			dev_err(&i2c->dev, "Failed to request IRQ: %d\n", ret);
 	}
 
 #ifdef CONFIG_COMMON_CLK
diff --git a/sound/soc/codecs/rt5682s.c b/sound/soc/codecs/rt5682s.c
index 3322056bbb3b..12741668fdb3 100644
--- a/sound/soc/codecs/rt5682s.c
+++ b/sound/soc/codecs/rt5682s.c
@@ -3283,7 +3283,7 @@ static int rt5682s_i2c_probe(struct i2c_client *i2c)
 		if (!ret)
 			rt5682s->irq = i2c->irq;
 		else
-			dev_err(&i2c->dev, "Failed to reguest IRQ: %d\n", ret);
+			dev_err(&i2c->dev, "Failed to request IRQ: %d\n", ret);
 	}
 
 	return devm_snd_soc_register_component(&i2c->dev, &rt5682s_soc_component_dev,
-- 
2.34.1


