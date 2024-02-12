Return-Path: <linux-kernel+bounces-61121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC93F850DB0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 07:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AF03B21042
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 06:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7951B6FBF;
	Mon, 12 Feb 2024 06:49:41 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578BD3C15
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 06:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.67.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707720580; cv=none; b=C8URbEM8dBeP8WDIi3oyoeXqQAy1GTCdPACN2RwQmPFmkDWbmnvpwsogeJNLo0B3ot/jcxtbemDsIBFQIAJ7Wsq271r3I9Vqv2k2PivYhqovlBCUfWNRxZ/4U7hylQoK2bIS8RRzo3pi8bJT0bSC1fF0yluL0LseNIfo9289wyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707720580; c=relaxed/simple;
	bh=SiwFCaJfWhNdlNdl6SEg46+n+EXfIid+Cwwyq9BVmUM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Adly4n5uRh8xFAewAWPXh7ZMD6wwexd8IO+ygbcLCimKjfn1AH+F/M9s5MfXatDV81J9oTtqQeS2IFlhUwSj9+Hj8wAE4PzoB3OBWmmsikf3692sHMM/6l+Q+TZMRBfLVDodh22JQWjsnnxQ4Zbyvu0EzbA6t4mCw0e9LGdCi4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail2.sysu.edu.cn; spf=pass smtp.mailfrom=mail2.sysu.edu.cn; arc=none smtp.client-ip=114.132.67.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail2.sysu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail2.sysu.edu.cn
X-QQ-mid: bizesmtp75t1707720455thg5m4al
X-QQ-Originating-IP: ID6Imi9Kyd5PCnxx1+iu0ZJr5MlnhBlWt1ZoJOUa8eY=
Received: from VM-16-2-ubuntu.. ( [122.51.61.190])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 12 Feb 2024 14:47:33 +0800 (CST)
X-QQ-SSF: 01400000000000B0R000000A0000000
X-QQ-FEAT: Up0ovoMzSFkK7IzFoC1J+qJL9JWzU7s6ntc5l+eKHZUMQfByL+xcr+gQOjsFd
	46EtvsaDIouVHEC+QRdRQER4Ir4DXWKB1k2uanbdBxsXfJRriwX/IXj6CNwLavOku4BM4f+
	8zvc5YHI4L/9uAAija7zqflaFHRXcVDwUFg5CWeFpz7gkIuPXwhxdMsNUMiN+aBFhNNoHWi
	lg/1IEvFQxCn/ctZU5o0fQhf7qySEedleTLLitCZ3kewHb3amp3gKUKgPG2mR6sBvgvMGn2
	A39mkzQ04Arz+T1NIgI2nUztb+aG+axWC1iOFObEMqvy3RtFtqYgizEp3atNJv2TfxxhNk9
	ai/AwhP5fOsD0scO2g3nyBjViilzt4xVnHS95QcGajyF5ItyGf9GEFs2rOyPakpP8kfey4D
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 5966347724627092285
From: Yinchuan Guo <guoych37@mail2.sysu.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org,
	james.smart@broadcom.com,
	dick.kennedy@broadcom.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	Yinchuan Guo <guoych37@mail2.sysu.edu.cn>
Subject: [PATCH] sound: drivers: fix typo 'reguest' to 'request'
Date: Mon, 12 Feb 2024 14:50:14 +0800
Message-Id: <20240212065014.3696356-1-guoych37@mail2.sysu.edu.cn>
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

This patch fixes a widespread spelling mistake of the word "request"
(incorrectly spelled as "reguest") across multiple files.

Signed-off-by: Yinchuan Guo <guoych37@mail2.sysu.edu.cn>
---
 drivers/mfd/da9063-irq.c      | 2 +-
 drivers/scsi/lpfc/lpfc_sli.c  | 2 +-
 drivers/tty/serial/max310x.c  | 2 +-
 drivers/tty/serial/sccnxp.c   | 2 +-
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
 16 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/mfd/da9063-irq.c b/drivers/mfd/da9063-irq.c
index e2bbedf58e68..698d8ea50f32 100644
--- a/drivers/mfd/da9063-irq.c
+++ b/drivers/mfd/da9063-irq.c
@@ -188,7 +188,7 @@ int da9063_irq_init(struct da9063 *da9063)
 			IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
 			da9063->irq_base, irq_chip, &da9063->regmap_irq);
 	if (ret) {
-		dev_err(da9063->dev, "Failed to reguest IRQ %d: %d\n",
+		dev_err(da9063->dev, "Failed to request IRQ %d: %d\n",
 				da9063->chip_irq, ret);
 		return ret;
 	}
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index fc3682f15f50..a4fd45bb4ea5 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -9724,7 +9724,7 @@ lpfc_sli4_iocb2wqe(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq,
 		}
 
 		wqe->els_req.payload_len = xmit_len;
-		/* Els_reguest64 has a TMO */
+		/* Els_request64 has a TMO */
 		bf_set(wqe_tmo, &wqe->els_req.wqe_com,
 			iocbq->iocb.ulpTimeout);
 		/* Need a VF for word 4 set the vf bit*/
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 3cbc757d7be7..6e259b292c41 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1402,7 +1402,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 	if (!ret)
 		return 0;
 
-	dev_err(dev, "Unable to reguest IRQ %i\n", irq);
+	dev_err(dev, "Unable to request IRQ %i\n", irq);
 
 out_uart:
 	for (i = 0; i < devtype->nr; i++) {
diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index 10cc16a71f26..8968d214da2f 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -1016,7 +1016,7 @@ static int sccnxp_probe(struct platform_device *pdev)
 		if (!ret)
 			return 0;
 
-		dev_err(&pdev->dev, "Unable to reguest IRQ %i\n", s->irq);
+		dev_err(&pdev->dev, "Unable to request IRQ %i\n", s->irq);
 	} else {
 		timer_setup(&s->timer, sccnxp_timer, 0);
 		mod_timer(&s->timer, jiffies +
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


