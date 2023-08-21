Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B033782C4B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbjHUOmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236090AbjHUOmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:42:16 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509AFE7;
        Mon, 21 Aug 2023 07:42:08 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3a7f74134e7so2514443b6e.1;
        Mon, 21 Aug 2023 07:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692628927; x=1693233727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=niRR0I8vNh+UgrE9dgAw0mTmrgJypa/tdMhRQCasF5c=;
        b=Mp3wQbMkztPW2+/ZUoIKP0tCMDSg6ni4R8HJgOhd9ZpQAaMToJInGltabwGA1B82ER
         oB6Ajmp1sgDbCvqeK8leUtrIjUvkzPfSJ2NdTJEctyUjFjzTwfaSCS4hvV8g7H1TmJO+
         IOj2SuMZEut+6uw5rfUDa6VPgczcbYIbzDJyla4mSr1IXaNET+qR4y9+sjJaBzm4kGbc
         2veFTNX11P3S4jnwQ02WGYBS7pVOUgGvPME4qRV4r1yumJHmwWbrpML7LOcwXw8OjIDN
         WOOr4qmM/TxQYFooUTYTMztUedWWTFzRwwoLBDwKHXqxvtc8wAO0sVqB3SQ6HDXdvvQ+
         SR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692628927; x=1693233727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=niRR0I8vNh+UgrE9dgAw0mTmrgJypa/tdMhRQCasF5c=;
        b=TjXqOY63ReA4tRPPhVfx2WRZlLtGaKuGlM6ItZWPw/lgtTkrPjAR0603hk64ghDpk8
         qz6POQBRPqaMKFa7sRURItdPu8uRN0fGC2c1fjP+qtMi3nuz3Bw3Ux3V5x9o+gNgqJyJ
         j1Ze4Qkdjo1+RyHPUBb3SXyVNQi4o1NkoOYX7XMYqnbvKMdQjGs9jfAB+RsJ1FA677C9
         RqgEmiMjJ/5Jz5FCJhW9sXyt8/zXYgYk2jmiFr2uFEYieyn7vKoyHi/0KkOBgVfElSe2
         S1n5tFhWa206siFAtCvI14zpokOjRlQSHUGQoBGmeGBxFMyd8tySb670VLDIfw9dqpCw
         /w+Q==
X-Gm-Message-State: AOJu0YxjVWZC4OSA2VAu8qMn4a7gUG9aPG/a3r21bx9PtXFD9apMl9DQ
        kDz1xlx2/eWrHI1H0WSLaVI=
X-Google-Smtp-Source: AGHT+IFz/ERShvBKzkGk13sAA0L+8DpvEfRtYs29tFk4Hv62VEK12oyztzlVHpwJY+hR1dRu0JuGmA==
X-Received: by 2002:a05:6808:2028:b0:3a7:5557:16c2 with SMTP id q40-20020a056808202800b003a7555716c2mr12056866oiw.0.1692628927554;
        Mon, 21 Aug 2023 07:42:07 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:33b3:b7f9:ce8a:596a])
        by smtp.gmail.com with ESMTPSA id k1-20020a544401000000b003a371c611f6sm3599856oiw.18.2023.08.21.07.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 07:42:07 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com, dan.carpenter@linaro.org
Subject: [PATCH] Update steps order list elements are evaluated
Date:   Mon, 21 Aug 2023 09:42:05 -0500
Message-Id: <20230821144205.13529-1-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
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

Update steps how order list elements data and elements size are
evaluated

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next
---
 .../platform/x86/hp/hp-bioscfg/order-list-attributes.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
index cffc1c9ba3e7..1ff09dfb7d7e 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
@@ -258,7 +258,6 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
 				eloc++;
 			break;
 		case ORD_LIST_ELEMENTS:
-			size = ordered_list_data->elements_size;
 
 			/*
 			 * Ordered list data is stored in hex and comma separated format
@@ -270,17 +269,14 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
 
 			part_tmp = tmpstr;
 			part = strsep(&part_tmp, COMMA_SEP);
-			if (!part)
-				strscpy(ordered_list_data->elements[0],
-					tmpstr,
-					sizeof(ordered_list_data->elements[0]));
 
-			for (olist_elem = 1; olist_elem < MAX_ELEMENTS_SIZE && part; olist_elem++) {
+			for (olist_elem = 0; olist_elem < MAX_ELEMENTS_SIZE && part; olist_elem++) {
 				strscpy(ordered_list_data->elements[olist_elem],
 					part,
 					sizeof(ordered_list_data->elements[olist_elem]));
-				part = strsep(&part_tmp, SEMICOLON_SEP);
+				part = strsep(&part_tmp, COMMA_SEP);
 			}
+			ordered_list_data->elements_size = olist_elem;
 
 			kfree(str_value);
 			str_value = NULL;
-- 
2.34.1

