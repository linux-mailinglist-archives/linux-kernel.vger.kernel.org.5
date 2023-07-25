Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302BE762387
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjGYUhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjGYUhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:37:10 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6801988
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:37:07 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-55b1238a013so4216754a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690317427; x=1690922227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tppdylk0o3RU6iRFgC5acPR+he8rkEb+eKspBj7RST0=;
        b=CDswuo0Ppz/RMLI26l0suYt7iqnZQQL9jsIa7tvwwvzx5N2EWZMkh61eSE4a3jgY1L
         RyUarTsCyibpS4rymF0dFRninecA2fWPvhT+ttJQqlJQC9wf43OfkU90OE14LY4hojeK
         VSljfpYLBp6w/EA/YeVmI046LSOuunRgKG6OA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690317427; x=1690922227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tppdylk0o3RU6iRFgC5acPR+he8rkEb+eKspBj7RST0=;
        b=hS78ZcFMHs5FGBiqRqCAhk/yg+PWst1isxMMYXuj7BoOOUCZTVcSpfh0FNrWFHtw4W
         82vzwyfpCy76JuaVwVseDc0LAK03tRDbV//WOiOM+vPwty8njLoMXb3ssdCGXYnG1pI7
         N8DVThB8ZIaMUWk2cFXQT2aN3xSfXLfldtG2iS9wIbH5WvMR95JTVvqIs+BsdIAaVeQ0
         XMbqKQAvYQWJ9Wcg4v33CjtYpD9IL9xZqBjDBXGSNWEpo6tEP7LoEMmE8gbi+3q6zpe2
         c7BV3nrlFW4JFH02Iifgdl9eR7jwuAUvc92K1B52nWRWW5u7qu9q6Q6mSKO0aPLMWb7U
         xs+g==
X-Gm-Message-State: ABy/qLZU2X4Gi1Ag/Nb5yGDvgxXcHCu7zFTXXwjlCkiJQEO/acHBvbix
        xATqGDYefTtrgKYl+IfP8Serdg==
X-Google-Smtp-Source: APBJJlFfGf6KWy8ToVhqAbS/rsUst92w7QBVdZCQBHQ7ANjrR2W54ngdHfWKPhtYtcS946Ocwz2MkQ==
X-Received: by 2002:a17:90a:d58f:b0:267:f9da:4611 with SMTP id v15-20020a17090ad58f00b00267f9da4611mr266815pju.14.1690317427135;
        Tue, 25 Jul 2023 13:37:07 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:c363:4681:f5b8:301])
        by smtp.gmail.com with ESMTPSA id bg1-20020a17090b0d8100b002676e961261sm1396951pjb.1.2023.07.25.13.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 13:37:06 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     cros-qcom-dts-watchers@chromium.org,
        Chris Morgan <macroalpha82@gmail.com>,
        linux-input@vger.kernel.org, hsinyi@google.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        yangcong5@huaqin.corp-partner.google.com,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v3 05/10] HID: i2c-hid: Switch to SYSTEM_SLEEP_PM_OPS()
Date:   Tue, 25 Jul 2023 13:34:40 -0700
Message-ID: <20230725133443.v3.5.Ib2a2865bd3c0b068432259dfc7d76cebcbb512be@changeid>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230725203545.2260506-1-dianders@chromium.org>
References: <20230725203545.2260506-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SYSTEM_SLEEP_PM_OPS() allows us to get rid of '#ifdef
CONFIG_PM_SLEEP', as talked about in commit 1a3c7bb08826 ("PM: core:
Add new *_PM_OPS macros, deprecate old ones").

This change is expected to have no functional effect.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 drivers/hid/i2c-hid/i2c-hid-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index efbba0465eef..19d985c20a5c 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -1085,7 +1085,6 @@ void i2c_hid_core_shutdown(struct i2c_client *client)
 }
 EXPORT_SYMBOL_GPL(i2c_hid_core_shutdown);
 
-#ifdef CONFIG_PM_SLEEP
 static int i2c_hid_core_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -1138,10 +1137,9 @@ static int i2c_hid_core_resume(struct device *dev)
 
 	return hid_driver_reset_resume(hid);
 }
-#endif
 
 const struct dev_pm_ops i2c_hid_core_pm = {
-	SET_SYSTEM_SLEEP_PM_OPS(i2c_hid_core_suspend, i2c_hid_core_resume)
+	SYSTEM_SLEEP_PM_OPS(i2c_hid_core_suspend, i2c_hid_core_resume)
 };
 EXPORT_SYMBOL_GPL(i2c_hid_core_pm);
 
-- 
2.41.0.487.g6d72f3e995-goog

