Return-Path: <linux-kernel+bounces-61293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 006A385108E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B6D3B20CF4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B261804A;
	Mon, 12 Feb 2024 10:19:49 +0000 (UTC)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153D85244
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733189; cv=none; b=KMbgfj588uoXKOoFiNfzGybJF2asppDP75hDcAv5oBdbozx0ZzxMlGkr+0wjFf00AnAoWekphWOoe2ZxqS+4GFoHJALJ15yatRaKQRTUqDHN56xD3ctG/nrBlZkU7SB3SPkXCju3WWhch+A+mj5sSjAR44J7w02rEBs4sUVrMMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733189; c=relaxed/simple;
	bh=SEcJ4zTcyCcF6woV9v43oZ2vKZFHbHbrPgvKRxKiCtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZKT1ec6qW1IYaSnRH/WyyRzBBFcUf5MzCG+Z/tkgP5CAkofuJQALTPdpToCsQlCVoSRrwb+TzX5zTAHjiBl4NGMmEPsK/Ntfj9JoXeAeBT9IedeiqQSW0ow6/0kzfOMMjxu2G8kdOFdAMZrep53gQZanMOZqHFymXGF9mVeUqZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail2.sysu.edu.cn; spf=pass smtp.mailfrom=mail2.sysu.edu.cn; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail2.sysu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail2.sysu.edu.cn
X-QQ-mid: bizesmtp68t1707733107tfv96pxg
X-QQ-Originating-IP: cpku7vEil/v+ZkoFq3hmnqaMeplPEm28H2nYMy/Xvfg=
Received: from VM-16-2-ubuntu.. ( [122.51.61.190])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 12 Feb 2024 18:18:25 +0800 (CST)
X-QQ-SSF: 01400000000000B0R000000A0000000
X-QQ-FEAT: 9YL+uTTQpf9mZ4m+Z1FW/tBxcHhqJzE6G/zvE1+onLhO1Z0c3vzfz+viAyeWa
	jrEBI1P71/fyihJyrouLAT0S/UemUpEqNM73mmLqP781Rv/UsJHGjgWbgBL3Meq373rK51T
	Ax1ZDTVAw+83V68UvU46AFMpTTKazSCFYApVGnAMdu8tMyDyGNjxVNp20QOVVT9OwdSBrMN
	zAJQkHZGBD+uM16+sVlTIGplOJFG8slXAGXwPji0dohJVLRiIylWxNB5dwCsK5cbGvv2Trg
	vWY5c8T7Ooa9GiRmsLDKJlX7fsP/y0MNaeViH0V0md6uX73mzcm0bOXzT159t84pvyIioi5
	nVDLCO9FrCvO2d3IvpW7T4IHzir07s9xuJYbKaM3Xi3bReDhOCcH9i+KLoCNnkDNv0OhhZu
	Ki08s1xhSWc=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 12912666476556176843
From: Yinchuan Guo <guoych37@mail2.sysu.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	Yinchuan Guo <guoych37@mail2.sysu.edu.cn>
Subject: [PATCH] sound: codecs: fix typo 'reguest' to 'request'
Date: Mon, 12 Feb 2024 18:18:20 +0800
Message-Id: <20240212101820.18437-1-guoych37@mail2.sysu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212065014.3696356-1-guoych37@mail2.sysu.edu.cn>
References: <20240212065014.3696356-1-guoych37@mail2.sysu.edu.cn>
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
in the log messages across various files within sound/soc/codecs.

Signed-off-by: Yinchuan Guo <guoych37@mail2.sysu.edu.cn>
---
Hi,

  I modified the incorrect subsystem identifier in the subject of my 
previous patch, and only submitted the fixes under the sound subsystem.

Thanks,
Yinchuan Guo
---
 sound/soc/codecs/rt274.c      | 2 +-
 sound/soc/codecs/rt286.c      | 2 +-
 sound/soc/codecs/rt298.c      | 2 +-
 sound/soc/codecs/rt5514-spi.c | 2 +-
 sound/soc/codecs/rt5640.c     | 2 +-
 sound/soc/codecs/rt5645.c     | 2 +-
 sound/soc/codecs/rt5651.c     | 2 +-
 sound/soc/codecs/rt5659.c     | 2 +-
 sound/soc/codecs/rt5663.c     | 2 +-
 sound/soc/codecs/rt5665.c     | 2 +-
 sound/soc/codecs/rt5668.c     | 2 +-
 sound/soc/codecs/rt5682-i2c.c | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/rt274.c b/sound/soc/codecs/rt274.c
index 0d3773c576f8..b385b859373b 100644
--- a/sound/soc/codecs/rt274.c
+++ b/sound/soc/codecs/rt274.c
@@ -1196,7 +1196,7 @@ static int rt274_i2c_probe(struct i2c_client *i2c,
 			IRQF_TRIGGER_HIGH | IRQF_ONESHOT, "rt274", rt274);
 		if (ret != 0) {
 			dev_err(&i2c->dev,
-				"Failed to reguest IRQ: %d\n", ret);
+				"Failed to request IRQ: %d\n", ret);
 			return ret;
 		}
 	}
diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 802f4851c3df..061211f0fd65 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -1244,7 +1244,7 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 			IRQF_TRIGGER_HIGH | IRQF_ONESHOT, "rt286", rt286);
 		if (ret != 0) {
 			dev_err(&i2c->dev,
-				"Failed to reguest IRQ: %d\n", ret);
+				"Failed to request IRQ: %d\n", ret);
 			return ret;
 		}
 	}
diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index c592c40a7ab3..ac81edfd2320 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -1286,7 +1286,7 @@ static int rt298_i2c_probe(struct i2c_client *i2c,
 			IRQF_TRIGGER_HIGH | IRQF_ONESHOT, "rt298", rt298);
 		if (ret != 0) {
 			dev_err(&i2c->dev,
-				"Failed to reguest IRQ: %d\n", ret);
+				"Failed to request IRQ: %d\n", ret);
 			return ret;
 		}
 	}
diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index 1a25a3787935..98e12f8113bc 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -280,7 +280,7 @@ static int rt5514_spi_pcm_probe(struct snd_soc_component *component)
 			rt5514_dsp);
 		if (ret)
 			dev_err(&rt5514_spi->dev,
-				"%s Failed to reguest IRQ: %d\n", __func__,
+				"%s Failed to request IRQ: %d\n", __func__,
 				ret);
 		else
 			device_init_wakeup(rt5514_dsp->dev, true);
diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 9523f4b5c800..5b7ae70be1be 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2843,7 +2843,7 @@ static int rt5640_i2c_probe(struct i2c_client *i2c,
 		/* Gets re-enabled by rt5640_set_jack() */
 		disable_irq(rt5640->irq);
 	} else {
-		dev_warn(&i2c->dev, "Failed to reguest IRQ %d: %d\n",
+		dev_warn(&i2c->dev, "Failed to request IRQ %d: %d\n",
 			 rt5640->irq, ret);
 		rt5640->irq = -ENXIO;
 	}
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 9408ee63cb26..cc868a9742bc 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -4127,7 +4127,7 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
 			| IRQF_ONESHOT, "rt5645", rt5645);
 		if (ret) {
-			dev_err(&i2c->dev, "Failed to reguest IRQ: %d\n", ret);
+			dev_err(&i2c->dev, "Failed to request IRQ: %d\n", ret);
 			goto err_enable;
 		}
 	}
diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index fc0c83b73f09..e603886627e4 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -2266,7 +2266,7 @@ static int rt5651_i2c_probe(struct i2c_client *i2c,
 		/* Gets re-enabled by rt5651_set_jack() */
 		disable_irq(rt5651->irq);
 	} else {
-		dev_warn(&i2c->dev, "Failed to reguest IRQ %d: %d\n",
+		dev_warn(&i2c->dev, "Failed to request IRQ %d: %d\n",
 			 rt5651->irq, ret);
 		rt5651->irq = -ENXIO;
 	}
diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index 4a50b169fe03..acfbdcf2fbd9 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -4299,7 +4299,7 @@ static int rt5659_i2c_probe(struct i2c_client *i2c,
 			rt5659_irq, IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
 			| IRQF_ONESHOT, "rt5659", rt5659);
 		if (ret)
-			dev_err(&i2c->dev, "Failed to reguest IRQ: %d\n", ret);
+			dev_err(&i2c->dev, "Failed to request IRQ: %d\n", ret);
 
 		/* Enable IRQ output for GPIO1 pin any way */
 		regmap_update_bits(rt5659->regmap, RT5659_GPIO_CTRL_1,
diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index be9fc58ff681..8f7db0703ea2 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -3676,7 +3676,7 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
 			| IRQF_ONESHOT, "rt5663", rt5663);
 		if (ret) {
-			dev_err(&i2c->dev, "%s Failed to reguest IRQ: %d\n",
+			dev_err(&i2c->dev, "%s Failed to request IRQ: %d\n",
 				__func__, ret);
 			goto err_enable;
 		}
diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index e59323fd5bf2..d82ead0e5caf 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4930,7 +4930,7 @@ static int rt5665_i2c_probe(struct i2c_client *i2c,
 			rt5665_irq, IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
 			| IRQF_ONESHOT, "rt5665", rt5665);
 		if (ret)
-			dev_err(&i2c->dev, "Failed to reguest IRQ: %d\n", ret);
+			dev_err(&i2c->dev, "Failed to request IRQ: %d\n", ret);
 
 	}
 
diff --git a/sound/soc/codecs/rt5668.c b/sound/soc/codecs/rt5668.c
index 6ab1a8bc3735..f1abfbc62a78 100644
--- a/sound/soc/codecs/rt5668.c
+++ b/sound/soc/codecs/rt5668.c
@@ -2581,7 +2581,7 @@ static int rt5668_i2c_probe(struct i2c_client *i2c,
 			rt5668_irq, IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
 			| IRQF_ONESHOT, "rt5668", rt5668);
 		if (ret)
-			dev_err(&i2c->dev, "Failed to reguest IRQ: %d\n", ret);
+			dev_err(&i2c->dev, "Failed to request IRQ: %d\n", ret);
 
 	}
 
diff --git a/sound/soc/codecs/rt5682-i2c.c b/sound/soc/codecs/rt5682-i2c.c
index 8ea9f1d9fec0..d03307585806 100644
--- a/sound/soc/codecs/rt5682-i2c.c
+++ b/sound/soc/codecs/rt5682-i2c.c
@@ -261,7 +261,7 @@ static int rt5682_i2c_probe(struct i2c_client *i2c,
 			rt5682_irq, IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
 			| IRQF_ONESHOT, "rt5682", rt5682);
 		if (ret)
-			dev_err(&i2c->dev, "Failed to reguest IRQ: %d\n", ret);
+			dev_err(&i2c->dev, "Failed to request IRQ: %d\n", ret);
 	}
 
 	return devm_snd_soc_register_component(&i2c->dev,
-- 
2.34.1


