Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06ACA785958
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbjHWN3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236076AbjHWN3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:29:05 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B65E7A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:45 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-986d8332f50so750787366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692797297; x=1693402097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++XkycmXXP25RSGckkmcwf1QKwi7KQ7LDbgEwWwhLO8=;
        b=Q9jdVoIreGWro8kt3lpxPpCeRyZOTW4/YLdMEAE7Qi0bx+EW1SKTxHfrr+hKcJNN5y
         q+aNS85ji9Tb9NSOzNs23zuRLRTNkJWn2wEBIrWd4nhTEfaN4AcM/sLojduJRIIYtjLc
         x+RWoR2+Ys9yxEwaX+dYo1PslLqjZAvywdPvPs5yGp2qaHLiFcasG+0wQtoLeHR5qNa0
         zAr8uMYugCqKDGnzozIsZDGxdpFItrmg4rh+ekx1zEJSs6bxMQ7A84gWTRGdal8vLJ9K
         CE0qTGlRKMNzjXEFkkLyDle0Bvckec9tA6ASmBeLo+wVQQpwz3e3B5rlJX2uLXAUm9AQ
         vL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797297; x=1693402097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++XkycmXXP25RSGckkmcwf1QKwi7KQ7LDbgEwWwhLO8=;
        b=hldSlyz8DywrSXUy07CGyiAblnhsfQZwjcLykRHuk72Xqjj7xhbKLTHpB2ow1b42mX
         tZ6ALPSis7o6qGD1infHLGCj/7izUoIokKikHt3/ps997Kse64tUpjUnS9W+5kY8lAGN
         e8lZnMnxO/SjHx5coqLa7saWWN5Nst8SlhGDAMJq/wpUPqEB4Z7G8mnXCacx5B9Trtl9
         jJ9LL0xYlknlRC6/bdzrL00CdyoJhtOALfWyizzhuEhKWqQGJ2m+I1yQ4T1PKWrFiWNu
         4VJlLrx1GY1uhLbQxcgpamTY8KjmcO0npJe883ho1EBpg7RJ1uR+Ttwh2uLUTud5ZVqu
         vwJA==
X-Gm-Message-State: AOJu0YyKxgYw1AByD/l/Lp2rqrvMTcJ3CplkAI9r8COtGS0Q8vI9FWvh
        9qCzvyljOLeMffjFpLJHxKoIw1SzCA1fqYN95Gc=
X-Google-Smtp-Source: AGHT+IF8NFgRRkkbrIqLQ69tZm03Rp5SJ7e5RUtAsYgYTiSoQW/K9FnwAx5Fy3U4hr/ZRxYiiaSiJQ==
X-Received: by 2002:a17:907:b15:b0:99c:aa43:b20c with SMTP id h21-20020a1709070b1500b0099caa43b20cmr9597586ejl.33.1692797296918;
        Wed, 23 Aug 2023 06:28:16 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709066b8900b009a168ab6ee2sm8918202ejr.164.2023.08.23.06.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:28:16 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 19/22] nvmem: core: Create all cells before adding the nvmem device
Date:   Wed, 23 Aug 2023 14:27:41 +0100
Message-Id: <20230823132744.350618-20-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
References: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1228; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=tzSWq81mF65xk+MYqzMMZ8I1dmRgY9KwDtUUm0FsU+0=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBk5glJWeiNR+s11RN1zh0XJ2eqco8jme4qlpOsi 9tIc+gYQ2SJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZOYJSQAKCRB6of1ZxzRV N5cZB/9sVa6bIYIHheU1ziPF7RXhfSzET7EV/RunkLZB/43j1HSTuVkhHlijxlJNB9LeDzp6Yhl tbne/2EOPxUyyyhUbjlao6p4FcT+o6WMRKFKCsu0mbG3V7xJ/dIrLs4NtfF/Zv7mB3ucb/RTAtV Tt2fK11YfbzOaBmf2842zc5tWy1s2lqWXmQWUoUGjRR1fRjABk64OAQHg4Go78hmmcuCu3tkJas 2aAp7Gqc3YegsMDAuykafa+WjSsoapJfpbr0nA2zS7tKoIwTmaAVm4DZ7qEgM4ooZqWY9iQm65O kJT1+kttO45u3TB931yj7LSfmExUfJVsrfV/J5fsrAjlS6hM
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

Let's pack all the cells creation in one place, so they are all created
before we add the nvmem device.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Michael Walle <michael@walle.cc>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 2251103b2c5f..bc7ea001a446 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -997,17 +997,17 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (rval)
 		goto err_remove_cells;
 
-	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
-
-	rval = device_add(&nvmem->dev);
+	rval = nvmem_add_cells_from_fixed_layout(nvmem);
 	if (rval)
 		goto err_remove_cells;
 
-	rval = nvmem_add_cells_from_fixed_layout(nvmem);
+	rval = nvmem_add_cells_from_layout(nvmem);
 	if (rval)
 		goto err_remove_cells;
 
-	rval = nvmem_add_cells_from_layout(nvmem);
+	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
+
+	rval = device_add(&nvmem->dev);
 	if (rval)
 		goto err_remove_cells;
 
-- 
2.25.1

