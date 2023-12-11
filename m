Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D810780CAED
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343689AbjLKN0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343668AbjLKN0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:26:02 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637AAC3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:26:07 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40b5155e154so52474635e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702301166; x=1702905966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lYJ6ekCGIROBxHKfB9biqbpmrnuVuPrZ81c+TDg+RPI=;
        b=lR+XssDYJKjJQvoFa07zuBnlAsHyhD9WzclRs8MVQhxp6Ybdge9b1VaEy85cMlE5W9
         51Lnljs4C1OKDywnISecoE8ddlc96vLsaShrIWQ7oRvwnHFyBAEpo4N3WNEwmGJnHETn
         yiP3j5j56eOdn4iYH+uHsL6qhvD/95pnj+u59Vrzluaqa7qHlEXz+vX2NKdQS7+5a0m9
         47qSbj7QY5DYuFHvFAYuIN5B0RtSbm1cuvp+LY7ceRK35MffaPNd7n/OlIFc8ZYY7/TT
         /r7CBOMX+AvPByUahQNKohWBGTkzxYIl7gZ9L5gjqJ7mwB8vRoKkLUrLxkGbV0AnTVBr
         rfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702301166; x=1702905966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lYJ6ekCGIROBxHKfB9biqbpmrnuVuPrZ81c+TDg+RPI=;
        b=p40xMWhwhnZfUu914/hLi6ebKBu3rP2mizRI/eGuTyqFeLG3qjIFkKyJ2SM8nntDPi
         31EMNZ7LZIEXjjkq84sC6J9G/tLT4klBalc0hDnug4fdtdLjyUQfSaD+EacxASXbWX8v
         US+dk+qIRXVnwhRuHv2rO6r680exlP6wY9G7Gy4TOA/NiHo78EWj978FTSIc4Nm47zZ6
         KHew0NASWl5JOkzNOdgsReUZC5HHzdOmz4iy5Ku75OezYrXhcYV865Y2gbOiywJI56Ge
         fKaFHOsriWVy4leovHGQjk7RuIZjP74Z3XE2TTQudTF9dxYwml3DtoHrNYoX9X42OLS1
         luMQ==
X-Gm-Message-State: AOJu0Ywh3WL3NqDnWZPsu6BFvi3w08zPs+u3IhgMeI4GH80OSCXSXbfm
        Dzl5446f7S3EqAXFL3OEGO91O6s641Ke1+EX/7c=
X-Google-Smtp-Source: AGHT+IFf5HxSPeDK3DJfL40vWxPIVBU1BjyzisRjUU1H31RfJgiYx4xFZaO7SEXhS1VXxjIXyeb7Lg==
X-Received: by 2002:a7b:c4d0:0:b0:40c:3272:1fea with SMTP id g16-20020a7bc4d0000000b0040c32721feamr2173115wmk.87.1702301165789;
        Mon, 11 Dec 2023 05:26:05 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id jg8-20020a05600ca00800b0040b54335d57sm15152226wmb.17.2023.12.11.05.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 05:26:05 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: [PATCH] rtc: MAINTAINERS: drop Alessandro Zummo
Date:   Mon, 11 Dec 2023 14:26:00 +0100
Message-Id: <20231211132600.101090-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Last email from Alessandro was in 2016, so remove him from maintainers
of the RTC subsystem.  Stale maintainer entries hide information whether
subsystem needs help, has a bus-factor or is even orphaned.

Link: https://lore.kernel.org/all/?q=f%3A%22Alessandro+Zummo%22
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ec736fccbb26..82ef00014f41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18271,7 +18271,6 @@ X:	include/linux/srcu*.h
 X:	kernel/rcu/srcu*.c
 
 REAL TIME CLOCK (RTC) SUBSYSTEM
-M:	Alessandro Zummo <a.zummo@towertech.it>
 M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
 L:	linux-rtc@vger.kernel.org
 S:	Maintained
-- 
2.34.1

