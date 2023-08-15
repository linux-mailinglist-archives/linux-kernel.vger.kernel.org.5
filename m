Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B19877C542
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjHOBmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbjHOBm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:42:28 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFDBE7;
        Mon, 14 Aug 2023 18:42:26 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 7BD255C0053;
        Mon, 14 Aug 2023 21:42:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 14 Aug 2023 21:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1692063743; x=1692150143; bh=3JXm4bHOCb
        kD2/F5u79KkMptwDjPTtVVNoaOoSGIkrU=; b=WQ4wrxJJKMY1kNd4lu1bduOHLy
        cBTdF7Ak7j+rDKmWMNkgcjaO8WJxOGTcfd28vRuS54RbnjRkWrPrW1kQDmp99Rrr
        vvb/7MMatA5ZJ1xmEDbOmzjre54E+y2fZ+kOWU5NudilA0vVoDj5Wws/LvhC4PN6
        Hef4CPHmqa3AhCcjrmNekL3MrpuZ+U4NF8Bpzm5Ncj2YhbytgHmr7T4PVIlMF+Re
        YUP+ylFvKNDPJj9fxkmzIVxDfMfa9e3iopnL33ws/E9ppUa+Q27lzykPFDro76h0
        qAaie3T1PMti8lGQsAiPMj2tBzkOckGpoz+I5gEX2mThfwupK07iULjMh0ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692063743; x=1692150143; bh=3JXm4bHOCbkD2
        /F5u79KkMptwDjPTtVVNoaOoSGIkrU=; b=gvbXJtsfQgfHoCYKoGtyEjtHim4W9
        aLtOTSDowBc8zrEdxSRMtsUhpWPuzfMuvw3MyV2+QV72ho8RCs/QsUTiEIpgdrqZ
        fpxIv/2Th6IdQZIxToYussqwEBb1ME6fmzBmeYwfC84NTu16FHL+CvhRRZlZhtsL
        R8biPXz46QFzb5ytSo7LS7YPKZdvOet3LgQR/M5SuVg0IoweDsFpvIgVkNvttcbO
        rrKiIcGdxJvTxTWfYy6lkhIQoei25KGvc6qNraZab80jE8yR5JtR9HdQ825Wextq
        lyvk25EXDqpT+YXv1SmPbwws7Bd5tJooh1QnK2eiRpgRc56PFfsgY/UsA==
X-ME-Sender: <xms:_9faZIH3oFVebyjHj7-N0VCLae3eZC0lP75mMfHis1g19PXf3I1ZeA>
    <xme:_9faZBVkyWRmr5185RaHSuY-4OVdmMeEipFTSSOdsdqJ1dpTWZhPgtO7Fc02IYfcP
    ocTwHmFFm-_Zg7vfG4>
X-ME-Received: <xmr:_9faZCLTZkqqC_jf_juHL0yMF5UD7LWfcMFEDjxEvhFgx5MnBBBZA1OCA3Jh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtiedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:_9faZKHds3PUfkq30WEAK4zx9U9MAUWOWnKSuecc4pCJLrPBtBNvqA>
    <xmx:_9faZOXHYwd5Mbqf6wpWDYZ9oMvt4blqMRn88oTMfXk-TtK2qilqCA>
    <xmx:_9faZNN2Finw9GghjR8HcXSPNfCf0rmw2T-Q1BWV1pv5EF2IN7GRsw>
    <xmx:_9faZAI_rzE09N-FROCyX9gpCkf0N6huL5uEZqa7F82Mr_FtIHa6GQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Aug 2023 21:42:20 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, markgross@kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] Fixes: a23870110a38 ("asus-wmi: add support for showing middle fan RPM")
Date:   Tue, 15 Aug 2023 13:42:09 +1200
Message-ID: <20230815014209.44903-1-luke@ljones.dev>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the addition of the mid fan custom curve functionality various
incorrect behaviour was uncovered. This commit fixes these areas.

- Ensure mid fan attributes actually use the correct fan ID
- Correction to a bit mask for selecting the correct fan data
- Refactor the curve show/store functions to be cleaner and and
  match each others layout

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 78 ++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 40 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index d14d0ea9d65f..14ee43c61eb2 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -2902,9 +2902,8 @@ static int fan_curve_get_factory_default(struct asus_wmi *asus, u32 fan_dev)
 {
 	struct fan_curve_data *curves;
 	u8 buf[FAN_CURVE_BUF_LEN];
-	int fan_idx = 0;
+	int err, fan_idx;
 	u8 mode = 0;
-	int err;
 
 	if (asus->throttle_thermal_policy_available)
 		mode = asus->throttle_thermal_policy_mode;
@@ -2914,13 +2913,6 @@ static int fan_curve_get_factory_default(struct asus_wmi *asus, u32 fan_dev)
 	else if (mode == 1)
 		mode = 2;
 
-	if (fan_dev == ASUS_WMI_DEVID_GPU_FAN_CURVE)
-		fan_idx = FAN_CURVE_DEV_GPU;
-
-	if (fan_dev == ASUS_WMI_DEVID_MID_FAN_CURVE)
-		fan_idx = FAN_CURVE_DEV_MID;
-
-	curves = &asus->custom_fan_curves[fan_idx];
 	err = asus_wmi_evaluate_method_buf(asus->dsts_id, fan_dev, mode, buf,
 					   FAN_CURVE_BUF_LEN);
 	if (err) {
@@ -2928,9 +2920,17 @@ static int fan_curve_get_factory_default(struct asus_wmi *asus, u32 fan_dev)
 		return err;
 	}
 
-	fan_curve_copy_from_buf(curves, buf);
+	fan_idx = FAN_CURVE_DEV_CPU;
+	if (fan_dev == ASUS_WMI_DEVID_GPU_FAN_CURVE)
+		fan_idx = FAN_CURVE_DEV_GPU;
+
+	if (fan_dev == ASUS_WMI_DEVID_MID_FAN_CURVE)
+		fan_idx = FAN_CURVE_DEV_MID;
+
+	curves = &asus->custom_fan_curves[fan_idx];
 	curves->device_id = fan_dev;
 
+	fan_curve_copy_from_buf(curves, buf);
 	return 0;
 }
 
@@ -2960,7 +2960,7 @@ static struct fan_curve_data *fan_curve_attr_select(struct asus_wmi *asus,
 {
 	int index = to_sensor_dev_attr(attr)->index;
 
-	return &asus->custom_fan_curves[index & FAN_CURVE_DEV_GPU];
+	return &asus->custom_fan_curves[index];
 }
 
 /* Determine which fan the attribute is for if SENSOR_ATTR_2 */
@@ -2969,7 +2969,7 @@ static struct fan_curve_data *fan_curve_attr_2_select(struct asus_wmi *asus,
 {
 	int nr = to_sensor_dev_attr_2(attr)->nr;
 
-	return &asus->custom_fan_curves[nr & FAN_CURVE_DEV_GPU];
+	return &asus->custom_fan_curves[nr & ~FAN_CURVE_PWM_MASK];
 }
 
 static ssize_t fan_curve_show(struct device *dev,
@@ -2978,13 +2978,13 @@ static ssize_t fan_curve_show(struct device *dev,
 	struct sensor_device_attribute_2 *dev_attr = to_sensor_dev_attr_2(attr);
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 	struct fan_curve_data *data;
-	int value, index, nr;
+	int value, pwm, index;
 
 	data = fan_curve_attr_2_select(asus, attr);
+	pwm = dev_attr->nr & FAN_CURVE_PWM_MASK;
 	index = dev_attr->index;
-	nr = dev_attr->nr;
 
-	if (nr & FAN_CURVE_PWM_MASK)
+	if (pwm)
 		value = data->percents[index];
 	else
 		value = data->temps[index];
@@ -3027,23 +3027,21 @@ static ssize_t fan_curve_store(struct device *dev,
 	struct sensor_device_attribute_2 *dev_attr = to_sensor_dev_attr_2(attr);
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 	struct fan_curve_data *data;
+	int err, pwm, index;
 	u8 value;
-	int err;
-
-	int pwm = dev_attr->nr & FAN_CURVE_PWM_MASK;
-	int index = dev_attr->index;
 
 	data = fan_curve_attr_2_select(asus, attr);
+	pwm = dev_attr->nr & FAN_CURVE_PWM_MASK;
+	index = dev_attr->index;
 
 	err = kstrtou8(buf, 10, &value);
 	if (err < 0)
 		return err;
 
-	if (pwm) {
+	if (pwm)
 		data->percents[index] = value;
-	} else {
+	else
 		data->temps[index] = value;
-	}
 
 	/*
 	 * Mark as disabled so the user has to explicitly enable to apply a
@@ -3156,7 +3154,7 @@ static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point8_temp, fan_curve,
 			       FAN_CURVE_DEV_CPU, 7);
 
 static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point1_pwm, fan_curve,
-			       FAN_CURVE_DEV_CPU | FAN_CURVE_PWM_MASK, 0);
+				FAN_CURVE_DEV_CPU | FAN_CURVE_PWM_MASK, 0);
 static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point2_pwm, fan_curve,
 			       FAN_CURVE_DEV_CPU | FAN_CURVE_PWM_MASK, 1);
 static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point3_pwm, fan_curve,
@@ -3209,40 +3207,40 @@ static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point8_pwm, fan_curve,
 			       FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 7);
 
 /* MID */
-static SENSOR_DEVICE_ATTR_RW(pwm3_enable, fan_curve_enable, FAN_CURVE_DEV_GPU);
+static SENSOR_DEVICE_ATTR_RW(pwm3_enable, fan_curve_enable, FAN_CURVE_DEV_MID);
 static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point1_temp, fan_curve,
-			       FAN_CURVE_DEV_GPU, 0);
+			       FAN_CURVE_DEV_MID, 0);
 static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point2_temp, fan_curve,
-			       FAN_CURVE_DEV_GPU, 1);
+			       FAN_CURVE_DEV_MID, 1);
 static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point3_temp, fan_curve,
-			       FAN_CURVE_DEV_GPU, 2);
+			       FAN_CURVE_DEV_MID, 2);
 static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point4_temp, fan_curve,
-			       FAN_CURVE_DEV_GPU, 3);
+			       FAN_CURVE_DEV_MID, 3);
 static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point5_temp, fan_curve,
-			       FAN_CURVE_DEV_GPU, 4);
+			       FAN_CURVE_DEV_MID, 4);
 static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point6_temp, fan_curve,
-			       FAN_CURVE_DEV_GPU, 5);
+			       FAN_CURVE_DEV_MID, 5);
 static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point7_temp, fan_curve,
-			       FAN_CURVE_DEV_GPU, 6);
+			       FAN_CURVE_DEV_MID, 6);
 static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point8_temp, fan_curve,
-			       FAN_CURVE_DEV_GPU, 7);
+			       FAN_CURVE_DEV_MID, 7);
 
 static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point1_pwm, fan_curve,
-			       FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 0);
+			       FAN_CURVE_DEV_MID | FAN_CURVE_PWM_MASK, 0);
 static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point2_pwm, fan_curve,
-			       FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 1);
+			       FAN_CURVE_DEV_MID | FAN_CURVE_PWM_MASK, 1);
 static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point3_pwm, fan_curve,
-			       FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 2);
+			       FAN_CURVE_DEV_MID | FAN_CURVE_PWM_MASK, 2);
 static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point4_pwm, fan_curve,
-			       FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 3);
+			       FAN_CURVE_DEV_MID | FAN_CURVE_PWM_MASK, 3);
 static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point5_pwm, fan_curve,
-			       FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 4);
+			       FAN_CURVE_DEV_MID | FAN_CURVE_PWM_MASK, 4);
 static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point6_pwm, fan_curve,
-			       FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 5);
+			       FAN_CURVE_DEV_MID | FAN_CURVE_PWM_MASK, 5);
 static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point7_pwm, fan_curve,
-			       FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 6);
+			       FAN_CURVE_DEV_MID | FAN_CURVE_PWM_MASK, 6);
 static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point8_pwm, fan_curve,
-			       FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 7);
+			       FAN_CURVE_DEV_MID | FAN_CURVE_PWM_MASK, 7);
 
 static struct attribute *asus_fan_curve_attr[] = {
 	/* CPU */
-- 
2.41.0

