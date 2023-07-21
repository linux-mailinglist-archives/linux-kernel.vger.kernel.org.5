Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79E275BC16
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 04:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjGUCGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 22:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGUCGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 22:06:02 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B2A271E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 19:06:01 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fba8f2197bso2309878e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 19:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689905159; x=1690509959;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+WpuRuD44V8tB1Z4DhstXdLxqQiDb9Sg+pb4Wlm/ll4=;
        b=rYb8gxiTQeC9GCW8j+UryB8sw0O51zGtvLmECHiHtO8Lt1YLTCTCiK6CRbTxot14Ha
         y6JsEDJgqyu/szBtAkJk0oUkY+cl4vRHche8UeyIEs8bPxa4ErYdKC5TkYgUpKlYMuAP
         clBtJHchLeh0HmYblzw6oxlGmiOc8zGy2lUsMBP57jEvvX0jzxEJ77E/Wk9D3dMWN2eA
         NNjf2bp5LoSkkF+t3aZEQjPVsCoKxxUlsViu23yZI/pNjnL7jIyn6iGc3j9mqYxnWN/L
         T1b4BtmQEH+uXFMsx76iu38lBVXbiGAU0iKiuUcaYZAbyq+Ge/DIDJonKoRQ+6qVQriG
         BdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689905159; x=1690509959;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+WpuRuD44V8tB1Z4DhstXdLxqQiDb9Sg+pb4Wlm/ll4=;
        b=RaZu+8aPaDOEaUh9heER1SVQ7g671D+kKZ/HnDk+NeZ0Be6nf5wReEtZ6qdgi3oU5t
         3CJ9m1Op0A4G7LQpIkxqaalzFWnbFqgGvgCLxbZvMWD0ULteBQdGNc8Kw0s05nWJv3SF
         51hsNhNFPL7VPoK6JUKyKq08EqTQGtxl3mZLaX9VYTdo3lZvYlFExB0NtWsqiNMZsQBw
         Q0h/HLmQjYqBUCyoY6+hy3OJHi1xTJx7bGXs4lClKZw1aC1QwW5tk24HzzHi4sj/zRvw
         xAyNna8u4UeQIB44zFnwP/j+0HarxSWJLZdkN2BiWucxt2smNQgMepHNN75+fdTfihxx
         lt8g==
X-Gm-Message-State: ABy/qLa7+GwyRxnEUXONQ5OTeAcYeWkm6/ZLfXwpUN/6S7lkDdJwUJa7
        qZE2+AWs9qKz9AxnQVCpCFo=
X-Google-Smtp-Source: APBJJlHfjc2XWbQeOKHUOQzcP41EPdkwde+4BfJSFeygyfhhgi+IAPaLoPaPyPdWBR1S0sEhzbYfNQ==
X-Received: by 2002:a19:770a:0:b0:4f5:a181:97b8 with SMTP id s10-20020a19770a000000b004f5a18197b8mr275838lfc.25.1689905159139;
        Thu, 20 Jul 2023 19:05:59 -0700 (PDT)
Received: from terra ([46.0.16.157])
        by smtp.gmail.com with ESMTPSA id q4-20020ac25284000000b004fb75943aa0sm475924lfm.196.2023.07.20.19.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 19:05:58 -0700 (PDT)
Date:   Fri, 21 Jul 2023 06:05:57 +0400
From:   Sergey Rozhnov <rozhnov.sergey.89@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8712: Remove redundant braces in if statements
Message-ID: <ZLnoBYlsTiLixTah@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract masked value to improve readability, apply fix suggested by checkpatch.
---
 drivers/staging/rtl8712/ieee80211.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/ieee80211.c b/drivers/staging/rtl8712/ieee80211.c
index 7d8f1a29d18a..fe53453ab9a7 100644
--- a/drivers/staging/rtl8712/ieee80211.c
+++ b/drivers/staging/rtl8712/ieee80211.c
@@ -63,8 +63,9 @@ uint r8712_is_cckrates_included(u8 *rate)
 	u32 i = 0;
 
 	while (rate[i] != 0) {
-		if ((((rate[i]) & 0x7f) == 2) || (((rate[i]) & 0x7f) == 4) ||
-		    (((rate[i]) & 0x7f) == 11) || (((rate[i]) & 0x7f) == 22))
+		u8 val = rate[i] & 0x7f;
+
+		if (val == 2 || val == 4 || val == 11 || val == 22)
 			return true;
 		i++;
 	}
-- 
2.40.1

