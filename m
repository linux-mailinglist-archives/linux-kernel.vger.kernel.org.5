Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E1676A1F7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 22:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjGaUcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 16:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjGaUcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:32:17 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7101FFA;
        Mon, 31 Jul 2023 13:31:49 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6bc9de53ee2so1112135a34.2;
        Mon, 31 Jul 2023 13:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690835509; x=1691440309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TwRSmfU6RJWP4ZN9Da8lv+MVwRca/bs+SmazkO+4OqA=;
        b=Jyhx/7DtIEcu4CsTRBgHUv3ubhTc9rMPIj/ph+21A9SsjaNzhIKUQ4ZQUeSUvyuEBh
         9eRuwL+5CrTelz7Gw929iORd8Swi3j5ZgHRliUZcsaXwtC1Od3uJWZt8uWx+XSDsBVtI
         cYGnsAyj+Xc/gcD49RJ9B0YMq/cvIJRVB7tgnGW/5RbKQsgFRv+iufdgNadXdLhhKDic
         w71VxohNoe5olylTYg4a80D7WXZ+oHYs1NA3G9lqDm2PrDdo1rojKVn78BnLJbmzuibm
         6SYp97tkIx3Mu/nDiyEWs8In7f95wpSxveUtCUznT53fAD3x8r0MYk9/k/ecDNG6BOFP
         lqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690835509; x=1691440309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwRSmfU6RJWP4ZN9Da8lv+MVwRca/bs+SmazkO+4OqA=;
        b=dv2Lcr4EJAFhlUniQP4k2repEFSZHmFePb8x8167Fw/9A9cm9aICSlzhv0w2Mm3r77
         4kqtd4UXap9+ETfrGVhRbveUqSGBPeWZpPw4ENvhk8Kzgf0fkZQjRgvF+fxeu3ROMV35
         +bP3R3Yo12PNhpyFV69ickxwF1KsmVLwEQ8df3QM5HSz7DZniyH9qvPzHT5NUm/5BveY
         DeMYEWSaX+IVJSe6XQvjV6bPSoWII4q7Ltp3w7BpWS1RF0PSkc8CePutHLpVLCDxo7Be
         r7aqi02J9L5y3tMcc+lo7pAcHHvomrqB1UqBfyOwmj2fFHJjpXb5L0Bl9GHwU1ZrEHpG
         +7Xw==
X-Gm-Message-State: ABy/qLY1VQNZ4GaGhf2KSPaZmP8also3saOJxoqnPNSGgfB2IS1DHsNI
        dmA36SSRnzr/bN7pdKs4cJM=
X-Google-Smtp-Source: APBJJlETEAJS60DwTtNbNSUOHXYlkWJVgBY6u8u258sPi0mEePE8jWnT8wuWHm/zLy9tbOBErxIfug==
X-Received: by 2002:a9d:75d5:0:b0:6b9:cf84:8cdd with SMTP id c21-20020a9d75d5000000b006b9cf848cddmr9544789otl.24.1690835509105;
        Mon, 31 Jul 2023 13:31:49 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:b620:ce9:47eb:26ab])
        by smtp.gmail.com with ESMTPSA id g8-20020a9d6208000000b006b9848f8aa7sm4498841otj.45.2023.07.31.13.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 13:31:48 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com, dan.carpenter@linaro.org
Subject: [PATCH 5/8] hp-bioscfg: Change how order list size is evaluated
Date:   Mon, 31 Jul 2023 15:31:38 -0500
Message-Id: <20230731203141.30044-6-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731203141.30044-1-jorge.lopez2@hp.com>
References: <20230731203141.30044-1-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update steps how order list size is evaluated

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next
---
 drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
index 71f588cbdf88..3b073910b430 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
@@ -243,9 +243,12 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
 			break;
 
 		case ORD_LIST_SIZE:
+			if (int_value > MAX_ELEMENTS_SIZE) {
+				pr_warn("Order List size value exceeded the maximum number of elements supported or data may be malformed\n");
+				int_value = MAX_ELEMENTS_SIZE;
+			}
 			ordered_list_data->elements_size = int_value;
-			if (int_value > MAX_ELEMENTS_SIZE)
-				pr_warn("Ordered List size value exceeded the maximum number of elements supported or data may be malformed\n");
+
 			/*
 			 * This step is needed to keep the expected
 			 * element list pointing to the right obj[elem].type
-- 
2.34.1

