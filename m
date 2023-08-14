Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C14E77BCC4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjHNPNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjHNPNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:13:04 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B933E73
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:13:03 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe426b86a8so41175005e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692025982; x=1692630782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9FgIR5BO1ZA/xwnNK7HzsY7163eVVAl221xkKgdSQ4=;
        b=d0XKVdJROqHz64+NzKJLv7ggTEC2T+UUELAWm3vTRWRRy8kJg11ZFS0JtVl1zgayDp
         sA0odmDqueyJDOWDdBSHrUPHwE7E/Zbp3HTYEMco70aIsOZCWHpP049PkPErFWpb7MUq
         hb6hokJjzkswJHDnoCRhe5vuwMF7Z+g1z44hgphVPVrLRKkKP6XzR9gv4Pl8zMInXL5H
         ST8IkGgQgzoygYMYdpHcWIRI8Q75+5XXcWghCP2K3HhKlBvg0Mkf7+WUNE9uRUiLL07W
         2t20Eq+CdotBHtdcXtD+FJlh59yWtHb0SxMWHULeWtKBWDB+Hl3M3Ss5WILbfm6jlK4X
         CRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692025982; x=1692630782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9FgIR5BO1ZA/xwnNK7HzsY7163eVVAl221xkKgdSQ4=;
        b=dJ7MyV+ZERdQMemEbwsPROYm26rWlh6YajWZ7CPev0LrRB7L+SXFg72W3ezTUgDak2
         S2FjMnEDttw7T7urcuIKEMs79pQr7e4IhSKaTbUQvAr18AWsVCVHiC2k9ANAPp/4UHqf
         CTo6gfKi/XeWSPS3DkZunlhL6ytZ4hhpR9Tzu196llpLq7pFNsVRfIorrLJT+Ngl19Ok
         BWo3XxbbwB/XhQPyyvTdm2c1FLBzWJ+P07zUEs88f5XV9HoJx1EtXH6vj/Ue1DuVYvPd
         RNk+auXfXhUIAipg+W6dj6KiGuyuQA/oAnHzSW5t1RSZ9HY2VWeGiAUq8xwoxPXOdUW8
         WdFw==
X-Gm-Message-State: AOJu0YyrGeEcyjIhk2Nc63wTcEig2DrIZJqEqBf165+4yidcDWQo8CYD
        T///CNwjV4Akt+UYqVA+X3aZ8Q==
X-Google-Smtp-Source: AGHT+IEZBO9hVdh7hDE9krFngD5XL9CpRlHhZ/LJA0vyApYOQ66jxhoBJOhZVYsBQSVGRvoV2LmJSw==
X-Received: by 2002:a05:600c:2990:b0:3fe:485f:ed13 with SMTP id r16-20020a05600c299000b003fe485fed13mr8031524wmd.29.1692025982131;
        Mon, 14 Aug 2023 08:13:02 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c021100b003fe1c332810sm17644572wmi.33.2023.08.14.08.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 08:13:01 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v0 12/13] media: qcom: camss: Functionally decompose CSIPHY clock lookups
Date:   Mon, 14 Aug 2023 16:12:42 +0100
Message-ID: <20230814151243.3801456-13-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814151243.3801456-1-bryan.odonoghue@linaro.org>
References: <20230814151243.3801456-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The csiphyX_timer and csiX_phy values need not be hard-coded. We can
functionally decompose the string matching inside of a loop.

Static string values are brittle, difficult to extend and not required
anyway since the camss->res->csiphy_num value informs us of the number
of CSIPHYs and hence the set of potential clocks for a given CSIPHY.

In simple terms if we have five CSIPHYs we can have no more and no less
than five csiphy_timer clocks. Similarly csi_phy core clocks have a 1:1
relationship with the PHY they clock.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../media/platform/qcom/camss/camss-csiphy.c  | 37 ++++++++++++-------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
index 0e8c2a59ea241..baf78c525fbfc 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
@@ -536,6 +536,15 @@ static int csiphy_init_formats(struct v4l2_subdev *sd,
 	return csiphy_set_format(sd, fh ? fh->state : NULL, &format);
 }
 
+static bool csiphy_match_clock_name(const char *clock_name, const char *format,
+				    int index)
+{
+	char name[CAMSS_RES_MAX];
+
+	snprintf(name, sizeof(name), format, index);
+	return !strcmp(clock_name, name);
+}
+
 /*
  * msm_csiphy_subdev_init - Initialize CSIPHY device structure and resources
  * @csiphy: CSIPHY device
@@ -550,7 +559,7 @@ int msm_csiphy_subdev_init(struct camss *camss,
 {
 	struct device *dev = camss->dev;
 	struct platform_device *pdev = to_platform_device(dev);
-	int i, j;
+	int i, j, k;
 	int ret;
 
 	csiphy->camss = camss;
@@ -666,19 +675,19 @@ int msm_csiphy_subdev_init(struct camss *camss,
 		for (j = 0; j < clock->nfreqs; j++)
 			clock->freq[j] = res->clock_rate[i][j];
 
-		if (!strcmp(clock->name, "csiphy0_timer") ||
-		    !strcmp(clock->name, "csiphy1_timer") ||
-		    !strcmp(clock->name, "csiphy2_timer") ||
-		    !strcmp(clock->name, "csiphy3_timer") ||
-		    !strcmp(clock->name, "csiphy4_timer") ||
-		    !strcmp(clock->name, "csiphy5_timer"))
-			csiphy->rate_set[i] = true;
-
-		if (camss->res->version == CAMSS_660 &&
-		    (!strcmp(clock->name, "csi0_phy") ||
-		     !strcmp(clock->name, "csi1_phy") ||
-		     !strcmp(clock->name, "csi2_phy")))
-			csiphy->rate_set[i] = true;
+		for (k = 0; k < camss->res->csiphy_num; k++) {
+			csiphy->rate_set[i] = csiphy_match_clock_name(clock->name,
+								      "csiphy%d_timer", k);
+			if (csiphy->rate_set[i])
+				break;
+
+			if (camss->res->version == CAMSS_660) {
+				csiphy->rate_set[i] = csiphy_match_clock_name(clock->name,
+									      "csi%d_phy", k);
+				if (csiphy->rate_set[i])
+					break;
+			}
+		}
 	}
 
 	return 0;
-- 
2.41.0

