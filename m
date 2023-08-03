Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1EF76EFC6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbjHCQlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235753AbjHCQlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:41:10 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E82420B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 09:40:53 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fba8e2aa52so11815635e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 09:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20221208.gappssmtp.com; s=20221208; t=1691080851; x=1691685651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lX7ZmxV6sUKOfhm6A9JqnUZ04X66QXptGmyw3ia1hSI=;
        b=dYzjHKoX9HMc0OZquV/tdH8XUpfDXAFCPBRDVrypHihgyyf0XpYYM6ToFd76CDqBEh
         +oJF6kWgvS14RHWLdb8X83GZ66CB1CwpHopYIZ+iOSS/g7n5cN8NND4/eteXet4ABJs/
         YHXlZlIpOyvzxmfDEmenByGIm/WDlY+5dttKb0ImYPO+jsYKswe91CWN31UPnuWpErNH
         lcP5SEh8r6W0fKsFx7xUsHqRw+WUFESEeyiw6A/WpN8TraDz2Ai5DoeFz/B0KU9DyTec
         lLzaNGuyAE1w4LQN9QZWMkrLgCU8BxV1tYCQ++occCaVhMjobXArfnTckIMvycoyXYG6
         nbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691080851; x=1691685651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lX7ZmxV6sUKOfhm6A9JqnUZ04X66QXptGmyw3ia1hSI=;
        b=ODWobI8rKL8VZGA/3eL9hJfEfVzoN89W/DiHWoRu4n20PuJVbeq2Guqqhw4kpkprlx
         tuZFceYk8nbjL6twwKNwkRPSVCyOVe2CvfVsM/dqDwWwLzAPxgtkEY3Vx6unkuaqIs9F
         KffaVVWsvrXqAr5Hk/ti/gG9SvwnYuDk7i7fnobeq3c6fsROyzW1Mf0ebcwmnFABmPJ0
         l1pZATi5zmTit3iji7zTPHONt5Bo024RHuzyyInmX51nlY/mJW8p8QyaPC4Q/+WPx81z
         e/Pfji0XrWUaVyRhRKK2Q36BFmIuV9Ffi4nlb3Ll+JWJgSz2Q2z3fRrnXRpuDLIIbFuK
         9NMg==
X-Gm-Message-State: ABy/qLZFN2csra//g1eL77UWN8GoCNyryDaGmovuD2D9xW5xEsQE46Q5
        /EFKk6t+bhaZ0qzYP2cfA0hVhQ==
X-Google-Smtp-Source: APBJJlEtFk/8Lz8CIklvF9OECplOfi/k4QZDPUg0bwjBJNy9a91uTEArW6J8gD6xhoTP3eyeLZ4DdQ==
X-Received: by 2002:a7b:cbd4:0:b0:3fe:1232:93fa with SMTP id n20-20020a7bcbd4000000b003fe123293famr8362954wmi.22.1691080850823;
        Thu, 03 Aug 2023 09:40:50 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id c7-20020a7bc847000000b003fe22da3bc5sm4626929wml.42.2023.08.03.09.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 09:40:50 -0700 (PDT)
From:   Yoann Congal <yoann.congal@smile.fr>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH] kconfig: avoid an infinite loop in oldconfig/syncconfig
Date:   Thu,  3 Aug 2023 18:40:22 +0200
Message-Id: <20230803164022.2232051-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exit on error when asking for value that has an invalid default value
and stdin is closed. Previously, this case would loop.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 scripts/kconfig/conf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 33d19e419908b..38ff9c81e071d 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -376,6 +376,15 @@ static int conf_string(struct menu *menu)
 		}
 		if (def && sym_set_string_value(sym, def))
 			return 0;
+		else {
+			if (feof(stdin) && !sym_string_valid(sym, sym_get_string_value(sym))) {
+				fprintf(stderr,
+						"Symbol %s has invalid default value and stdin reached EOF\n",
+						sym->name);
+				exit(1);
+			}
+		}
+
 	}
 }
 
-- 
2.30.2

