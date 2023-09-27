Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AF87B0B7C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjI0R6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjI0R5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:57:47 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4D110A;
        Wed, 27 Sep 2023 10:57:43 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c1c66876aso1501383566b.2;
        Wed, 27 Sep 2023 10:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695837462; x=1696442262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIF24z+W4xSOOiQxGgE0N6mbcOqb2K0f4VACmgBIH2A=;
        b=MY+7TXiGutqbrMEdSTizXRAzYD3SVcs5Ym61Bbszoqa4ClM9cQQ26CG1enRQauurGo
         UIlt85qCuJeAvkdsqSCM9u2mqF3Gj3/dek46VjOdRTTVf95dQIMzREwGwmI1/mEHpcXn
         8o22Mcz5tfFnJoaX6/8NHHuh49pg3FuWaYXCKr5SS8p7VUbQk7AFyYxCZCIUcttorTZZ
         bFLkxvf4AqngexGgqz692kwIivARcf3fPcfsFTjjyvxomHS2wE9GbBMW38qbaHfVMYmr
         5wfx38wn6i+Jr4IOUr8GPWLd9+CUghGxPtS9DEOfoPyAUB25OQWZUVK34t7ub/S+Aury
         cIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695837462; x=1696442262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIF24z+W4xSOOiQxGgE0N6mbcOqb2K0f4VACmgBIH2A=;
        b=Xulmwa1KKYNe6NMCnbJjrHFFeBOvR44LKAn3eqkgQNl9JGmfyYxcQN5g45aeiQFN82
         9R9/rtgLPGiZrilNHDsdyOvKdNXm/bkRYvh1vmnYu5WEJJ9/Mu1wwYnaz6Ols3VKz+1+
         aGyTweifNvbIlKTg07do2yuTjv1slPodx5dOMMVfJC+nAa5nokoqC1GUHOtYYAleonyb
         Qm+HbpKYXQZli0dr9DyV/j8tqHf+yc4O4QXtlTVf8m3OJDQ1GbqxnBDA4R0mbwftAlxP
         rSl0WtHVUkzR0LrnzVfuC4NmMS5PFrYiZuCiSUBFIG9EZkah2L9ByTUcgIQ1sR0C9R9c
         p3+w==
X-Gm-Message-State: AOJu0YyWO0BjClJGtgjw4nrxwOaqtN/IzuSBE7vlU1EoxJGVHdICGp4r
        NQtVdV5XaG4DArITmxwVn0g=
X-Google-Smtp-Source: AGHT+IH1Q9tjD6rssGUuLjMyyepySAgaNFHRHoviVDMNRT4tI+seuCHDwQugbI51YIzArWGmR4TSxQ==
X-Received: by 2002:a17:906:5c:b0:9ae:63bd:a7fe with SMTP id 28-20020a170906005c00b009ae63bda7femr2493309ejg.10.1695837461874;
        Wed, 27 Sep 2023 10:57:41 -0700 (PDT)
Received: from primary.. ([212.34.12.50])
        by smtp.gmail.com with ESMTPSA id d4-20020a170906370400b0099bd8c1f67esm9654593ejc.109.2023.09.27.10.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 10:57:41 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v7 07/14] USB: typec: tps6598x: Apply patch again after power resume
Date:   Wed, 27 Sep 2023 13:53:41 -0400
Message-Id: <20230927175348.18041-8-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927175348.18041-1-alkuor@gmail.com>
References: <20230927175348.18041-1-alkuor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abdel Alkuor <abdelalkuor@geotab.com>

TPS25750 PD controller might be powered off externally at power suspend,
after resuming PD controller power back, apply the patch again.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v7:
  - Add driver name to commit subject
Changes in v6:
  - Check tps25750 using is_compatiable device node
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index faeee2ffc99c..56ffffe225f2 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -1204,6 +1204,18 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct tps6598x *tps = i2c_get_clientdata(client);
+	struct device_node *np = client->dev.of_node;
+	int ret;
+
+	ret = tps6598x_check_mode(tps);
+	if (ret < 0)
+		return ret;
+
+	if (of_device_is_compatible(np, "ti,tps25750") && ret == TPS_MODE_PTCH) {
+		ret = tps25750_apply_patch(tps);
+		if (ret)
+			return ret;
+	}
 
 	if (tps->wakeup) {
 		disable_irq_wake(client->irq);
-- 
2.34.1

