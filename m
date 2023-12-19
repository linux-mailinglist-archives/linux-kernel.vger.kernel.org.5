Return-Path: <linux-kernel+bounces-5193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C334F8187CB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D0221F21DFA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3213E19BC0;
	Tue, 19 Dec 2023 12:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LbxcaLp/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6599C18059
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33621d443a7so4626285f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702989942; x=1703594742; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRVBeXF+QSqrae9EL7nBYIMaZo7QiMUVKXfXpluBSag=;
        b=LbxcaLp/lcl3Pe6vGYwFwfrva2JX5tSrfp3MTJCSXmb5vR5/6+P3NL0wkgCvgHbZin
         bjsc+s1CtDtzblISS2p9szvWEYy1Jv3OFFoHLzXzI5RmVJqy3wcP9BKsAFw0lqv1D3Eg
         I3V+OuhJ+FR0kqlUrVhq7pCHn25qD4CJ5hulUxhqECnO5PA7H3ObdlDqzGl0vye74cbU
         wl8IVpQMAPyl45LUpAEkU18MpeCZd+ls9XTDJPJwb7ASR6YHvSdSvTV80IjhTW7pyixA
         JeIFF9oCOKg/2RKTx/uG67v76O+yAkIqAT0cRKW5XXNxbADixl4RrUcXR2tqJOGjIuoN
         FDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702989942; x=1703594742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRVBeXF+QSqrae9EL7nBYIMaZo7QiMUVKXfXpluBSag=;
        b=Vh0pKgzst/YRQX/di+gMANQeNRZdP4Mnfo6h03KqJS8Ec8MvxIDJ9IF9WRbqQb0hkf
         1vrI2e0oFMn1OsIksggExAF+P40jbgK0Bj7vxw5B9qpt2PWrBKRnAU5N0oqXoYYp/QmO
         hhVCZ8c2Kf5QxXgn76vKZLqgdYLBT1i2hyPTurO7XBl83/fumeBezU45Aei2jBN6xU5X
         iBSIhDrkgmXmkR6G4MryXPlnS/V6mg68ve3lut9aubYDSAJ7jssHwpgWmlaclHOIgZsF
         XhK3Mb6jFvHkNH9znKyjrNETbPoP07lhbrOPBjPkwmG14QoytU0rwTVtz+oZ318XMtgF
         wtZg==
X-Gm-Message-State: AOJu0YxKy9j5WKqQpemYRCnpYklQ6+EMUe019046p7TKhmRn7Nl9tNn7
	Qy1ZpT+3sgGhB3X1ujH/fmKdIg==
X-Google-Smtp-Source: AGHT+IHcjAN/1c2pjkznYXtnyWaf03lih7LsZcw5E0PUDxSpjUevTyOZalq2g4dGkS2jtfMz7njxEQ==
X-Received: by 2002:a05:6000:1201:b0:336:4edb:9f9a with SMTP id e1-20020a056000120100b003364edb9f9amr3832084wrx.20.1702989942440;
        Tue, 19 Dec 2023 04:45:42 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id c3-20020adffb43000000b00336673a4153sm5975782wrs.80.2023.12.19.04.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 04:45:42 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 19 Dec 2023 13:45:36 +0100
Subject: [PATCH v4 3/5] ASoC: codec: wcd-mbhc-v2: add support when
 connected behind an USB-C audio mux
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-topic-sm8650-upstream-wcd939x-codec-v4-3-1c3bbff2d7ab@linaro.org>
References: <20231219-topic-sm8650-upstream-wcd939x-codec-v4-0-1c3bbff2d7ab@linaro.org>
In-Reply-To: <20231219-topic-sm8650-upstream-wcd939x-codec-v4-0-1c3bbff2d7ab@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Andy Gross <agross@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=8596;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=6/YR1yQHLHY5ZVJGZrtvXeeiCTAJu1S+VdYzYnIkom0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlgZBwtZ+fVXgIY1XnBadCo1YzWm2rJBHvAIPrnDKt
 K64JFeyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZYGQcAAKCRB33NvayMhJ0UlmEA
 CfSyuC/BCXLmzVHmawKSsEZ424u/6EHWKSs+1JRpJVXs4SCgTbYEJFl6DuQiAElyFZT+hgHsTjyzCw
 9IDbSAgkDaoP1CjHX+B+Ywf6Ugyh3uGv1RM5aQMBFc5rivtIyV9FofITzvXJTREjdH+YP4NPLdcupY
 Rxic/7CXYZ35clWvM+6zE7L2tOrqb3WfM9e+VrvnTwaxx4QKpqBqW1WvwLitox2QMjWNZJWamSXp7X
 t7eIAtP8tw+MJXo/NM5jK9+GPpIJqN/NZzYxzG0KfsvmNCC5N0WXW/Ylwcx4osuOiJl5FQ7awB+YHV
 1kb2cIn+BpONc0olYGqKMWYC/HAKlzv26MTzH+SNjAXCMNDQakje8z5vkZGZCUlhBuLJnp9wKmP9Xf
 EiRc7pt+IOvuFMDBm6q1UIswvScB9p/XtM9orR/IZqvc9jqEW6Su3E0TVOj2O+cPE1ZkPcZawcz61v
 PkTJQPCTqxpIKQp+OcHwUYIYt4FlrRbVd+YaeVXs+CT4r7Mptf2ZepWxMSwKhkCIl+ppSyTVtGe5bO
 ESTWBCciOSXMGHw6ZcK8tbmMNkO7awuJO+09jyXZhEHwR4skhX8Yri+HBhmOzbyL8L1jIqmcEU2XUb
 sDP5OYGlv6uY1bNEd39c1LEHNFoA4huN/FZ/XagI0bMDd6mNT7zZiV/dnH4A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

When the WCD codec is connected behind an USB-C audio mux,
plug/unplug events, clock control, pull-up and threshold are
different.
Add a typec_analog_mux config enabling those changes and add
two callbacks to trigger plug/unplug events from USB-C events.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 sound/soc/codecs/wcd-mbhc-v2.c | 95 +++++++++++++++++++++++++++++++++++-------
 sound/soc/codecs/wcd-mbhc-v2.h |  3 ++
 2 files changed, 83 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/wcd-mbhc-v2.c b/sound/soc/codecs/wcd-mbhc-v2.c
index 5da1934527f3..0e6218ed0e5e 100644
--- a/sound/soc/codecs/wcd-mbhc-v2.c
+++ b/sound/soc/codecs/wcd-mbhc-v2.c
@@ -16,6 +16,7 @@
 #define HS_DETECT_PLUG_TIME_MS		(3 * 1000)
 #define MBHC_BUTTON_PRESS_THRESHOLD_MIN	250
 #define GND_MIC_SWAP_THRESHOLD		4
+#define GND_MIC_USBC_SWAP_THRESHOLD	2
 #define WCD_FAKE_REMOVAL_MIN_PERIOD_MS	100
 #define HPHL_CROSS_CONN_THRESHOLD	100
 #define HS_VREF_MIN_VAL			1400
@@ -52,12 +53,15 @@ struct wcd_mbhc {
 	struct wcd_mbhc_field *fields;
 	/* Delayed work to report long button press */
 	struct delayed_work mbhc_btn_dwork;
+	/* Work to handle plug report */
+	struct work_struct mbhc_plug_detect_work;
 	/* Work to correct accessory type */
 	struct work_struct correct_plug_swch;
 	struct mutex lock;
 	int buttons_pressed;
 	u32 hph_status; /* track headhpone status */
 	u8 current_plug;
+	unsigned int swap_thr;
 	bool is_btn_press;
 	bool in_swch_irq_handler;
 	bool hs_detect_work_stop;
@@ -506,14 +510,13 @@ static void wcd_mbhc_adc_detect_plug_type(struct wcd_mbhc *mbhc)
 	}
 }
 
-static irqreturn_t wcd_mbhc_mech_plug_detect_irq(int irq, void *data)
+static void mbhc_plug_detect_fn(struct work_struct *work)
 {
-	struct snd_soc_component *component;
+	struct wcd_mbhc *mbhc = container_of(work, struct wcd_mbhc, mbhc_plug_detect_work);
+	struct snd_soc_component *component = mbhc->component;
 	enum snd_jack_types jack_type;
-	struct wcd_mbhc *mbhc = data;
 	bool detection_type;
 
-	component = mbhc->component;
 	mutex_lock(&mbhc->lock);
 
 	mbhc->in_swch_irq_handler = true;
@@ -576,9 +579,51 @@ static irqreturn_t wcd_mbhc_mech_plug_detect_irq(int irq, void *data)
 exit:
 	mbhc->in_swch_irq_handler = false;
 	mutex_unlock(&mbhc->lock);
+}
+
+static irqreturn_t wcd_mbhc_mech_plug_detect_irq(int irq, void *data)
+{
+	struct wcd_mbhc *mbhc = data;
+
+	if (!mbhc->cfg->typec_analog_mux)
+		schedule_work(&mbhc->mbhc_plug_detect_work);
+
 	return IRQ_HANDLED;
 }
 
+int wcd_mbhc_typec_report_unplug(struct wcd_mbhc *mbhc)
+{
+
+	if (!mbhc || !mbhc->cfg->typec_analog_mux)
+		return -EINVAL;
+
+	if (mbhc->mbhc_cb->clk_setup)
+		mbhc->mbhc_cb->clk_setup(mbhc->component, false);
+
+	wcd_mbhc_write_field(mbhc, WCD_MBHC_L_DET_EN, 0);
+	wcd_mbhc_write_field(mbhc, WCD_MBHC_MECH_DETECTION_TYPE, 0);
+
+	schedule_work(&mbhc->mbhc_plug_detect_work);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wcd_mbhc_typec_report_unplug);
+
+int wcd_mbhc_typec_report_plug(struct wcd_mbhc *mbhc)
+{
+	if (!mbhc || !mbhc->cfg->typec_analog_mux)
+		return -EINVAL;
+
+	if (mbhc->mbhc_cb->clk_setup)
+		mbhc->mbhc_cb->clk_setup(mbhc->component, true);
+	wcd_mbhc_write_field(mbhc, WCD_MBHC_L_DET_EN, 1);
+
+	schedule_work(&mbhc->mbhc_plug_detect_work);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wcd_mbhc_typec_report_plug);
+
 static int wcd_mbhc_get_button_mask(struct wcd_mbhc *mbhc)
 {
 	int mask = 0;
@@ -725,14 +770,23 @@ static int wcd_mbhc_initialise(struct wcd_mbhc *mbhc)
 
 	mutex_lock(&mbhc->lock);
 
-	/* enable HS detection */
+	if (mbhc->cfg->typec_analog_mux)
+		mbhc->swap_thr = GND_MIC_USBC_SWAP_THRESHOLD;
+	else
+		mbhc->swap_thr = GND_MIC_SWAP_THRESHOLD;
+
+	/* setup HS detection */
 	if (mbhc->mbhc_cb->hph_pull_up_control_v2)
 		mbhc->mbhc_cb->hph_pull_up_control_v2(component,
-						      HS_PULLUP_I_DEFAULT);
+				mbhc->cfg->typec_analog_mux ?
+					HS_PULLUP_I_OFF : HS_PULLUP_I_DEFAULT);
 	else if (mbhc->mbhc_cb->hph_pull_up_control)
-		mbhc->mbhc_cb->hph_pull_up_control(component, I_DEFAULT);
+		mbhc->mbhc_cb->hph_pull_up_control(component,
+				mbhc->cfg->typec_analog_mux ?
+					I_OFF : I_DEFAULT);
 	else
-		wcd_mbhc_write_field(mbhc, WCD_MBHC_HS_L_DET_PULL_UP_CTRL, 3);
+		wcd_mbhc_write_field(mbhc, WCD_MBHC_HS_L_DET_PULL_UP_CTRL,
+				mbhc->cfg->typec_analog_mux ? 0 : 3);
 
 	wcd_mbhc_write_field(mbhc, WCD_MBHC_HPHL_PLUG_TYPE, mbhc->cfg->hphl_swh);
 	wcd_mbhc_write_field(mbhc, WCD_MBHC_GND_PLUG_TYPE, mbhc->cfg->gnd_swh);
@@ -741,10 +795,18 @@ static int wcd_mbhc_initialise(struct wcd_mbhc *mbhc)
 		mbhc->mbhc_cb->mbhc_gnd_det_ctrl(component, true);
 	wcd_mbhc_write_field(mbhc, WCD_MBHC_HS_L_DET_PULL_UP_COMP_CTRL, 1);
 
-	wcd_mbhc_write_field(mbhc, WCD_MBHC_L_DET_EN, 1);
+	/* Plug detect is triggered manually if analog goes through USBCC */
+	if (mbhc->cfg->typec_analog_mux)
+		wcd_mbhc_write_field(mbhc, WCD_MBHC_L_DET_EN, 0);
+	else
+		wcd_mbhc_write_field(mbhc, WCD_MBHC_L_DET_EN, 1);
 
-	/* Insertion debounce set to 96ms */
-	wcd_mbhc_write_field(mbhc, WCD_MBHC_INSREM_DBNC, 6);
+	if (mbhc->cfg->typec_analog_mux)
+		/* Insertion debounce set to 48ms */
+		wcd_mbhc_write_field(mbhc, WCD_MBHC_INSREM_DBNC, 4);
+	else
+		/* Insertion debounce set to 96ms */
+		wcd_mbhc_write_field(mbhc, WCD_MBHC_INSREM_DBNC, 6);
 
 	/* Button Debounce set to 16ms */
 	wcd_mbhc_write_field(mbhc, WCD_MBHC_BTN_DBNC, 2);
@@ -753,7 +815,8 @@ static int wcd_mbhc_initialise(struct wcd_mbhc *mbhc)
 	mbhc->mbhc_cb->mbhc_bias(component, true);
 	/* enable MBHC clock */
 	if (mbhc->mbhc_cb->clk_setup)
-		mbhc->mbhc_cb->clk_setup(component, true);
+		mbhc->mbhc_cb->clk_setup(component,
+				mbhc->cfg->typec_analog_mux ? false : true);
 
 	/* program HS_VREF value */
 	wcd_program_hs_vref(mbhc);
@@ -1115,7 +1178,7 @@ static void wcd_correct_swch_plug(struct work_struct *work)
 	do {
 		cross_conn = wcd_check_cross_conn(mbhc);
 		try++;
-	} while (try < GND_MIC_SWAP_THRESHOLD);
+	} while (try < mbhc->swap_thr);
 
 	if (cross_conn > 0) {
 		plug_type = MBHC_PLUG_TYPE_GND_MIC_SWAP;
@@ -1183,7 +1246,7 @@ static void wcd_correct_swch_plug(struct work_struct *work)
 			cross_conn = wcd_check_cross_conn(mbhc);
 			if (cross_conn > 0) { /* cross-connection */
 				pt_gnd_mic_swap_cnt++;
-				if (pt_gnd_mic_swap_cnt < GND_MIC_SWAP_THRESHOLD)
+				if (pt_gnd_mic_swap_cnt < mbhc->swap_thr)
 					continue;
 				else
 					plug_type = MBHC_PLUG_TYPE_GND_MIC_SWAP;
@@ -1194,7 +1257,7 @@ static void wcd_correct_swch_plug(struct work_struct *work)
 			} else /* Error if (cross_conn < 0) */
 				continue;
 
-			if (pt_gnd_mic_swap_cnt == GND_MIC_SWAP_THRESHOLD) {
+			if (pt_gnd_mic_swap_cnt == mbhc->swap_thr) {
 				/* US_EU gpio present, flip switch */
 				if (mbhc->cfg->swap_gnd_mic) {
 					if (mbhc->cfg->swap_gnd_mic(component, true))
@@ -1473,6 +1536,7 @@ struct wcd_mbhc *wcd_mbhc_init(struct snd_soc_component *component,
 	mutex_init(&mbhc->lock);
 
 	INIT_WORK(&mbhc->correct_plug_swch, wcd_correct_swch_plug);
+	INIT_WORK(&mbhc->mbhc_plug_detect_work, mbhc_plug_detect_fn);
 
 	ret = request_threaded_irq(mbhc->intr_ids->mbhc_sw_intr, NULL,
 					wcd_mbhc_mech_plug_detect_irq,
@@ -1562,6 +1626,7 @@ void wcd_mbhc_deinit(struct wcd_mbhc *mbhc)
 
 	mutex_lock(&mbhc->lock);
 	wcd_cancel_hs_detect_plug(mbhc,	&mbhc->correct_plug_swch);
+	cancel_work_sync(&mbhc->mbhc_plug_detect_work);
 	mutex_unlock(&mbhc->lock);
 
 	kfree(mbhc);
diff --git a/sound/soc/codecs/wcd-mbhc-v2.h b/sound/soc/codecs/wcd-mbhc-v2.h
index 006118f3e81f..df68e99c81a3 100644
--- a/sound/soc/codecs/wcd-mbhc-v2.h
+++ b/sound/soc/codecs/wcd-mbhc-v2.h
@@ -193,6 +193,7 @@ struct wcd_mbhc_config {
 	int v_hs_max;
 	int num_btn;
 	bool mono_stero_detection;
+	bool typec_analog_mux;
 	bool (*swap_gnd_mic)(struct snd_soc_component *component, bool active);
 	bool hs_ext_micbias;
 	bool gnd_det_en;
@@ -273,6 +274,8 @@ int wcd_mbhc_start(struct wcd_mbhc *mbhc, struct wcd_mbhc_config *mbhc_cfg,
 void wcd_mbhc_stop(struct wcd_mbhc *mbhc);
 void wcd_mbhc_set_hph_type(struct wcd_mbhc *mbhc, int hph_type);
 int wcd_mbhc_get_hph_type(struct wcd_mbhc *mbhc);
+int wcd_mbhc_typec_report_plug(struct wcd_mbhc *mbhc);
+int wcd_mbhc_typec_report_unplug(struct wcd_mbhc *mbhc);
 struct wcd_mbhc *wcd_mbhc_init(struct snd_soc_component *component,
 		      const struct wcd_mbhc_cb *mbhc_cb,
 		      const struct wcd_mbhc_intr *mbhc_cdc_intr_ids,

-- 
2.34.1


