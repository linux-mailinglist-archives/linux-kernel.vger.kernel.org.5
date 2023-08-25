Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50330787F5E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 07:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbjHYFjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 01:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240893AbjHYFj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 01:39:27 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD3B1FF3;
        Thu, 24 Aug 2023 22:39:21 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4ff8a1746e0so797607e87.0;
        Thu, 24 Aug 2023 22:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692941959; x=1693546759;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxM4hun7J7j3+pA4h09bA4XVsK57JjdIEry9BgKjY3Q=;
        b=czfc5ny0qfUkRN4qcHiJLAkogPE+hwYtJcgx7VIVnu9wpxNhcdBPdjqqnJuf0Q1UOM
         oqEWLpPeHnJSdfy6dA4VBo1sHaRzu7ny3u1cyfyefRssEsB62r31K+PQ8qq1RzUUuIMj
         iSmhx7DPK3pMH//YQKv6qBvA6Tftn+VHelEaIZ6yXXy4TWzO9C55zXVhehfxByDu3o+p
         zesKgOyKD3FY06RAEXd0Dffpt8w9JhuDRyir0/Pxw7rpzTXQj9kOthzVprCGsitSgi41
         YRbh4dw18+l/HKvkPFdcv5akBsXfLSGfEt2su4zrzDI2PHmJGjyDvI613NropKfuGC/V
         6JlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692941959; x=1693546759;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxM4hun7J7j3+pA4h09bA4XVsK57JjdIEry9BgKjY3Q=;
        b=dw6P/YhKCBD9c3qCP9CSOVGYEEF/7xLPKaaIekBqDqg68HkiyarL5+8pnrPeW9J7DY
         8qnNvRq1IkpN0GXyfIEiPqSbyS9iyuKJSF/rSMOqKORzJa889AAToK6tPGblMg+/X4ib
         DCseWxkIofyVX/r17whY+HWV8kuxodhWWLMdnIx1InRw407lGlZ0cbxrkzTvS+WAumli
         zaa4a23fxwzpVEmaWQsZYZd7tFfIqJetw1egalHKkJ0Zs0UaJhVuqTZKumAyZiVrB0W+
         wHK9wjMY0HKdZXJdA3YFuqq+c+OLjuUCy6mGJ6oladNM9yhpxXPub7nuwFnFloR6QYjE
         DySw==
X-Gm-Message-State: AOJu0Yy0lprl/yZbrREWSVpjaSFFIK/anLqPqjALfj0PNXZBHITbtSlv
        mz9M9ORY6Xahrc7NyslMag0=
X-Google-Smtp-Source: AGHT+IGs7LI6eP5/RZSHTVEf9VXin5JHG9+q/5+tAOHoHiyBvuWVgn7WeG0XLuPmJgMT6OFGHiSdhA==
X-Received: by 2002:a19:8c0f:0:b0:500:7685:839 with SMTP id o15-20020a198c0f000000b0050076850839mr10472065lfd.65.1692941958921;
        Thu, 24 Aug 2023 22:39:18 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:98c5:e120:ff1e:7709])
        by smtp.gmail.com with ESMTPSA id m22-20020aa7d356000000b0052338f5b2a4sm598540edr.86.2023.08.24.22.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 22:39:17 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: remove obsolete pattern in RTC SUBSYSTEM section
Date:   Fri, 25 Aug 2023 07:39:10 +0200
Message-Id: <20230825053910.17941-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d890cfc25fe9 ("rtc: ds2404: Convert to GPIO descriptors") removes
the rtc-ds2404.h platform data and with that, there is no file remaining
matching the pattern 'include/linux/platform_data/rtc-*'. Hence,
./scripts/get_maintainer.pl --self-test=patterns complains about a broken
reference.

Remove the obsolete file pattern in the REAL TIME CLOCK (RTC) SUBSYSTEM.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Linus, please ack.

Alexandre, please pick this into your rtc tree.

 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 250c43c675cb..52277ee9c1b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18089,7 +18089,6 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git
 F:	Documentation/admin-guide/rtc.rst
 F:	Documentation/devicetree/bindings/rtc/
 F:	drivers/rtc/
-F:	include/linux/platform_data/rtc-*
 F:	include/linux/rtc.h
 F:	include/linux/rtc/
 F:	include/uapi/linux/rtc.h
-- 
2.17.1

