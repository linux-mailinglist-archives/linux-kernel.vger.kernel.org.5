Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E62277E462
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343906AbjHPO6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343864AbjHPO56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:57:58 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD46310FF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:57:56 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c353a395cso895757666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692197875; x=1692802675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjO3mOShHLsaoichf6Eqrpw4fl2ak09M8zdPJ2UrN58=;
        b=eVFXG3FOuxdBG0DUvsQ/fx0N9sbRyGntltW2m8fanZFtHRRS/+J7MW0lJRj+JZnZ9P
         42VhD+xzI2yWmp6osTMu7+OBy5BKT/ZiRgyBftEpkq595uyxPe1FQ/Utq2Z1pAQ5MzQ6
         JnetWf0n3X04I1jffKKdIlejwMJ+fy/ppupLBXroALy2UPVz4tuLFCkSju739mTSdfoH
         EwsoXupBaMgeuqlCo7DgbndYIOdoa34j86lV1Hwi4LWR7nIC4It5HcztTs1XK+FiBSfm
         MixoAz8H1SZcxB+2EqaoblBljSRxZXyJebGpx1FODo0LDseXrE35QesOM6Ai5++J51Fb
         y6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692197875; x=1692802675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjO3mOShHLsaoichf6Eqrpw4fl2ak09M8zdPJ2UrN58=;
        b=RT7vZsksMRQb+FczyeJpVuAwlTuNjQedPzLzLNIbDbXDnV49WAwYAa/twc/U6fM53d
         3ycPkclDg2jBFxRcA5t0kl6YIbYyTCIcDDiE2RX9+h1qRD/meKM/Y5NNqB61AyzRHL83
         KOqk8sW3DR/iSkzV6bYvH8+DbigyYV1VpMtZ2PwZ4M+DBWfNIBdcQcjN2y3zcZbRzE6V
         ESruEq4uft40383SfoO6i62R1/5N/yXrz2ZdMvVHLzHn545WKq0q/uWMSEMGfpyFsLCO
         BDthlkfuqMrLf7jub8kQIxqoq23AgwxL49v0asruXguz66Lr19YfYfzUXjG4RAD0JdSd
         zW2g==
X-Gm-Message-State: AOJu0YyHROqoOqkIGDXPot3DYEAl5U1Xefb/Q2ybeGhlNGd+2ajJ0QI2
        988nwEYaIKlD9gmn7Gtn3ZfGCA==
X-Google-Smtp-Source: AGHT+IF8MjEinSQc37AIBbhkjkpbQm6kdgm/BOcGL/QhmwijZIBxjx0GVrO25dLrHE0cYi2xeBizuw==
X-Received: by 2002:a17:907:74c:b0:99c:fb44:d4b6 with SMTP id xc12-20020a170907074c00b0099cfb44d4b6mr1762255ejb.62.1692197875274;
        Wed, 16 Aug 2023 07:57:55 -0700 (PDT)
Received: from hackbox.lan ([84.232.191.92])
        by smtp.gmail.com with ESMTPSA id f16-20020a170906561000b00992076f4a01sm8610403ejq.190.2023.08.16.07.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 07:57:54 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Subject: [PATCH v2 3/6] clk: qcom: gdsc: Add set and get hwmode callbacks to switch GDSC mode
Date:   Wed, 16 Aug 2023 17:57:38 +0300
Message-Id: <20230816145741.1472721-4-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816145741.1472721-1-abel.vesa@linaro.org>
References: <20230816145741.1472721-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagadeesh Kona <quic_jkona@quicinc.com>

Add support for set and get hwmode callbacks to switch the GDSC between
SW and HW modes. Currently, the GDSC is moved to HW control mode
using HW_CTRL flag and if this flag is present, GDSC is moved to HW
mode as part of GDSC enable itself. The intention is to keep the
HW_CTRL flag functionality as is, since many older chipsets still use
this flag.

Introduce a new HW_CTRL_TRIGGER flag to switch the GDSC back and forth
between HW/SW modes dynamically at runtime. If HW_CTRL_TRIGGER flag is
present, register set_hwmode_dev callback to switch the GDSC mode which
can be invoked from consumer drivers using dev_pm_genpd_set_hwmode
function. Unlike HW_CTRL flag, HW_CTRL_TRIGGER won't move the GDSC to HW
control mode as part of GDSC enable itself, GDSC will be moved to HW
control mode only when consumer driver explicity calls
dev_pm_genpd_set_hwmode to switch to HW mode. Also add the
dev_pm_genpd_get_hwmode to allow the consumers to read the actual
HW/SW mode from hardware.

Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/qcom/gdsc.c | 32 ++++++++++++++++++++++++++++++++
 drivers/clk/qcom/gdsc.h |  1 +
 2 files changed, 33 insertions(+)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 5358e28122ab..3e4a721f1605 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -363,6 +363,34 @@ static int gdsc_disable(struct generic_pm_domain *domain)
 	return 0;
 }
 
+static int gdsc_set_mode(struct generic_pm_domain *domain, struct device *dev, bool mode)
+{
+	struct gdsc *sc = domain_to_gdsc(domain);
+
+	if (sc->rsupply && !regulator_is_enabled(sc->rsupply)) {
+		pr_err("Cannot set mode while parent is disabled\n");
+		return -EIO;
+	}
+
+	return gdsc_hwctrl(sc, mode);
+}
+
+static bool gdsc_get_mode(struct generic_pm_domain *domain, struct device *dev)
+{
+	struct gdsc *sc = domain_to_gdsc(domain);
+	u32 val;
+	int ret;
+
+	ret = regmap_read(sc->regmap, sc->gdscr, &val);
+	if (ret)
+		return ret;
+
+	if (val & HW_CONTROL_MASK)
+		return true;
+
+	return false;
+}
+
 static int gdsc_init(struct gdsc *sc)
 {
 	u32 mask, val;
@@ -451,6 +479,10 @@ static int gdsc_init(struct gdsc *sc)
 		sc->pd.power_off = gdsc_disable;
 	if (!sc->pd.power_on)
 		sc->pd.power_on = gdsc_enable;
+	if (sc->flags & HW_CTRL_TRIGGER) {
+		sc->pd.set_hwmode_dev = gdsc_set_mode;
+		sc->pd.get_hwmode_dev = gdsc_get_mode;
+	}
 
 	ret = pm_genpd_init(&sc->pd, NULL, !on);
 	if (ret)
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index 803512688336..1e2779b823d1 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -67,6 +67,7 @@ struct gdsc {
 #define ALWAYS_ON	BIT(6)
 #define RETAIN_FF_ENABLE	BIT(7)
 #define NO_RET_PERIPH	BIT(8)
+#define HW_CTRL_TRIGGER	BIT(9)
 	struct reset_controller_dev	*rcdev;
 	unsigned int			*resets;
 	unsigned int			reset_count;
-- 
2.34.1

