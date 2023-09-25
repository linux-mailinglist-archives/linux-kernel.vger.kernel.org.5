Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AD67ADC3C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbjIYPsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjIYPrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:47:36 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0016CDD
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:47:24 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4050bd2e33aso70703385e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695656843; x=1696261643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ULa3MlvTg8hdkVamNSIOKh6gGISQMp+o/MnpLuMkMw=;
        b=CoIa8wF5+G+9paPu3DsV7tlZQlCYsdgLjYXarfRsMUMMSlUJ113jQD1esOz1w1qWR0
         ZhJ8wd2FkHqfnJVlgaCTsMF4mklKJ0m3cRIUh9VDOPBtRIY7jyShsaPI20PZ4amb371E
         AbUVdktik3vvr6dyde9Xaqdot/MbmtGk8J9NAJhFOOpw7hELDV+ajXSsyyd8O61xD/rl
         X0AS72R2scCBe5LA2hytAkZNA1Ut6RjnbaAipDwxnSgrrc9+cjSdZRfFuKjd6hasacc4
         VVMXi03IZoDONXtJi53Aj23xpr7aRnw9rDWaDSCAj4teToIwQOXoSxPWnaqTrrc/R0H9
         6lDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695656843; x=1696261643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ULa3MlvTg8hdkVamNSIOKh6gGISQMp+o/MnpLuMkMw=;
        b=PYCSMHnGJjbNLp4ApNLrVIHJBAQvaJMDkwqbZ6TKOwG6OEjef7JUY4NAWJig50qaeD
         5suxB8xz9bADW484ccd+iNpa5rTU6rJ6VzV9859Eno/gwGHQSC3rb6GzbmXZaodXlK7w
         K1xJyyq8fPBkZOPu8SAvs1ESDt4M61KmTh3RzsJMyVmqLJUaW0E6aQ+tR+bqWMsVCR9C
         9C4q6u3TSZ1ZmM/klJEAaJZkLjRangyx4DWn/SVT+irnVY09g0ThUqYU6ZxuEcjzHrBf
         l/fawZFD9bjaPRA7eOwgRLE/2w42wpjc88eNV5E91al1ROjLMTmfts2gqzbGmBG6DyhF
         KcVg==
X-Gm-Message-State: AOJu0Yzew/CnlWXhme9jM/tS0VqwyQg+xD2YZ8ZIaIafMN+9L729iyN8
        JwO1otp/dUTRWvKiCqmI/vg1nQ==
X-Google-Smtp-Source: AGHT+IFaTtE2r2aD+gOeeOLNCKtL4Sp+uvnRBvHv+FBQpBtDux414w82G/M3U4xGGNghpEkdiiLbMg==
X-Received: by 2002:a05:600c:2108:b0:404:7480:d821 with SMTP id u8-20020a05600c210800b004047480d821mr5866400wml.37.1695656843248;
        Mon, 25 Sep 2023 08:47:23 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d4-20020adffd84000000b0031f34a395e7sm12077536wrr.45.2023.09.25.08.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:47:22 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com,
        rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, andrey.konovalov@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [RESEND PATCH v6 11/17] media: qcom: camss: Allow clocks vfeN vfe_liteN or vfe_lite
Date:   Mon, 25 Sep 2023 16:47:01 +0100
Message-ID: <20230925154707.837542-12-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925154707.837542-1-bryan.odonoghue@linaro.org>
References: <20230925154707.837542-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of Video Front End - VFE or Image Front End - IFE supported
with new SoCs can vary both for the full and lite cases.

For example sdm845 has one vfe_lite and two vfe interfaces with the vfe
clock called simply "vfe_lite" with no integer postfix. sc8280xp has four
vfe and four vfe lite blocks.

At the moment we declare vfe_lite0 and vfe_lite1 for sm8250 but never set
those clocks because we don't match the strings.

We need to support the following clock name formats

- vfeN
- vfe_liteN
- vfe_lite

with N being any reasonably sized integer.

There are two sites in this code which need to do the same thing,
constructing and matching strings with the pattern above, so encapsulate
the logic in one function.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-vfe.c | 22 ++++++++++++++-----
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index db8f68819ded9..4db0d0a1c6a51 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -431,6 +431,20 @@ void vfe_isr_reset_ack(struct vfe_device *vfe)
 	complete(&vfe->reset_complete);
 }
 
+static int vfe_match_clock_names(struct vfe_device *vfe,
+				 struct camss_clock *clock)
+{
+	char vfe_name[7]; /* vfeXXX\0 */
+	char vfe_lite_name[12]; /* vfe_liteXXX\0 */
+
+	snprintf(vfe_name, sizeof(vfe_name), "vfe%d", vfe->id);
+	snprintf(vfe_lite_name, sizeof(vfe_lite_name), "vfe_lite%d", vfe->id);
+
+	return (!strcmp(clock->name, vfe_name) ||
+		!strcmp(clock->name, vfe_lite_name) ||
+		!strcmp(clock->name, "vfe_lite"));
+}
+
 /*
  * vfe_set_clock_rates - Calculate and set clock rates on VFE module
  * @vfe: VFE device
@@ -454,9 +468,7 @@ static int vfe_set_clock_rates(struct vfe_device *vfe)
 	for (i = 0; i < vfe->nclocks; i++) {
 		struct camss_clock *clock = &vfe->clock[i];
 
-		if (!strcmp(clock->name, "vfe0") ||
-		    !strcmp(clock->name, "vfe1") ||
-		    !strcmp(clock->name, "vfe_lite")) {
+		if (vfe_match_clock_names(vfe, clock)) {
 			u64 min_rate = 0;
 			long rate;
 
@@ -537,9 +549,7 @@ static int vfe_check_clock_rates(struct vfe_device *vfe)
 	for (i = 0; i < vfe->nclocks; i++) {
 		struct camss_clock *clock = &vfe->clock[i];
 
-		if (!strcmp(clock->name, "vfe0") ||
-		    !strcmp(clock->name, "vfe1") ||
-		    !strcmp(clock->name, "vfe_lite")) {
+		if (vfe_match_clock_names(vfe, clock)) {
 			u64 min_rate = 0;
 			unsigned long rate;
 
-- 
2.42.0

