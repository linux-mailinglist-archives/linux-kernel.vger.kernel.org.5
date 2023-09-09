Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A49779969D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 08:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245358AbjIIGg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 02:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244997AbjIIGgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 02:36:24 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F451BC1;
        Fri,  8 Sep 2023 23:36:20 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50078e52537so4646083e87.1;
        Fri, 08 Sep 2023 23:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694241378; x=1694846178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKJx+LKqmWSduMS/Rvqr7LYuPIf+jkXHy5f3h87Azkw=;
        b=H4Ox8u8yy9ABsxk16CKHLjNoDwe55IDziBqaIIcgYQ/u4q3Xtu2SWfI2mIooXz2Vml
         oqIVueK9KCJg0sQXDBMy3YODP8RsMNJetkuNmVZ9WI998COf9+kIT3FW2V8bWlpyPKyH
         tyfTv+Dj+4XYLW41mQ8H28ZuoedzxruQpF2k1hOUmPjWvWJW7TBz5Vkx+Pp/nYX6bZFf
         pjxGK9L2o3BGBAxBYmoTiuJsjqscZZzXnX2XdW2doRO8FULCevl5d+AsBuQpOad5Mvut
         YHHMGk00ncR/9yN8dXFnL6sxjnGNkVGiUAUCMMfIZHgQyR0KwRoj03otFEtxfgjN8CEL
         k4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694241378; x=1694846178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKJx+LKqmWSduMS/Rvqr7LYuPIf+jkXHy5f3h87Azkw=;
        b=g512C0WA9dmh1JTiIKARnsPpIq1Pv2FbZ7JMqgJx+i4N1Dcns5GZ6JigjURRkBZSfe
         6PdXuMesMr2VPSLxElvurv2r6Ce2YyzgMA3fKSxD9ZAhigCUbmWanlWPLWNF363rXuY6
         IoAUEZsypQt0hW9SmVrjqMSpjTURunUY5Pd0KT7W/oZ8rMtP3zAY8qeqkKh6dXffmWQq
         Eay/HJvQLtYfAQ1fdUPa7Wr5hSIlQBO/RCJtDN+K5o0phfAD0zz/8m427ZGUnetZLYPc
         fjUy9FCNTzSpNtlxQyBP7Jdyi0YFvTQXc66si8KlAqvWS/bLiXnUfpO38JbAxdAZ0w/l
         oJtA==
X-Gm-Message-State: AOJu0YyOcCEHKMUWRbOMrFgLHXAqERHqPfKKLkBRrv7wmIh1mQT7/d3a
        9xjB9/sTVysFpzlCEYpDvT4=
X-Google-Smtp-Source: AGHT+IErHcq9ubq4i/fLo8BpmE3piWI6lH/Iz6S/+VWsWigOE7ElgCdtELO6Ynn+weWfTOET4g2wNA==
X-Received: by 2002:a05:6512:688:b0:500:9b7d:ee22 with SMTP id t8-20020a056512068800b005009b7dee22mr4318820lfe.60.1694241378054;
        Fri, 08 Sep 2023 23:36:18 -0700 (PDT)
Received: from localhost.localdomain (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id z26-20020aa7cf9a000000b005232c051605sm1817525edx.19.2023.09.08.23.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 23:36:17 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 2/2] pinctrl: pinmux: Use dev_err_probe() in pin_request()
Date:   Sat,  9 Sep 2023 08:36:13 +0200
Message-ID: <20230909063613.2867-3-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230909063613.2867-1-jernej.skrabec@gmail.com>
References: <20230909063613.2867-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dev_err_probe() when printing error message in pin_request() since
it may fail with -EPROBE_DEFER.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/pinctrl/pinmux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index 301fe0157b02..4a9776a99d20 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -188,8 +188,8 @@ static int pin_request(struct pinctrl_dev *pctldev,
 	}
 out:
 	if (status)
-		dev_err(pctldev->dev, "pin-%d (%s) status %d\n",
-			pin, owner, status);
+		dev_err_probe(pctldev->dev, "pin-%d (%s) status %d\n",
+			      pin, owner, status);
 
 	return status;
 }
-- 
2.42.0

