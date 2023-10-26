Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86FC7D7C63
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 07:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344143AbjJZFn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 01:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344023AbjJZFnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 01:43:45 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0B01BD
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:43:42 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53142351997so129034a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698299021; x=1698903821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PxIUWq0JvE8ZN9IeEN1TvTq6KPJTuoCETYsX6YOkfb8=;
        b=c2/vbcmXPgpO7FiDzvVKXPVvoVGl9pyy9+kvdgF8LWVOk9aOKjFAyFIZbagzSdXq4w
         pT5cS+NRI1j+UhsDIO29jxQ22ESQHNm4D/cpjGtiZKL9Rb0zov8CgzuXgMAFZ/8Ycz+u
         AHwzQJ3FWTERWQut5dTXUwLqOp875qwlFM12MyvmVwiMrV7uhIxumfMXUN04i7wdE4dl
         akawUvHWki86k92juF0h7RqJnYdk7jP3rL260jNI1Xi2J1HaNZJdRXJc4hId5J1rlbRy
         z0d+0WVVOCxcShX6ZdQIRx4GhqC6kMULhfT40FnXYBLTpJPxkVgKElTmLeqMOGGoCZl0
         hVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698299021; x=1698903821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxIUWq0JvE8ZN9IeEN1TvTq6KPJTuoCETYsX6YOkfb8=;
        b=tFwqB91T62GR6igt2PfSdYeCSX7ZXXP20Dan3MNQsuYeVVapVROHrjGVNLBKcqRAaq
         pCplNXd9rw6/LfpFS7JiH5MEDDFQoZS+rKeiKwWjJsdOWVfRb9BP9I9EiNJYzomalRgW
         IqCdhbS8Hp1bmRdsvoxsBN4nES6qgJ1QD3706wnH6E/TH6lhIRojh0mrxaTpgjLIRjwl
         gAIo/eCJthOO39OxnhfFcJhVkpVNHD/d17N4abTja+ij8mAznwOH4n2LLyYKzjRoTYs0
         W2nvwv63MY7mFFnH8NmVQTcnBmZAFRImD55CTUaCFaj7SkOKZ7YiP6Am5dOF63d+sF0H
         mUKA==
X-Gm-Message-State: AOJu0YzFR3O3QUPeHqQUu3xYLiyV3rIfdw5odJYA/yuM8A9y9oryn5aH
        4Atk+ddjS5y4a9fLPALgIqQ=
X-Google-Smtp-Source: AGHT+IEXiEKKpAMjTDrlioaK4ZFLi8ap0p6z3kKOWh0+t/48Y6ZojiTkv9gIaBG6ovvw9JNrx1vQGw==
X-Received: by 2002:a50:d4de:0:b0:52f:bedf:8ef1 with SMTP id e30-20020a50d4de000000b0052fbedf8ef1mr12268337edj.3.1698299020782;
        Wed, 25 Oct 2023 22:43:40 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id q20-20020a056402033400b0053dd8898f75sm10495724edw.81.2023.10.25.22.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 22:43:40 -0700 (PDT)
Date:   Thu, 26 Oct 2023 07:43:39 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] staging: rtl8192e: Remove HTIOTActIsDisableMCS15()
Message-ID: <004b43b098f14f82e9614578ea9f04ca95b48b4c.1698295861.git.philipp.g.hortmann@gmail.com>
References: <cover.1698295861.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698295861.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove HTIOTActIsDisableMCS15() as it always returns false which leads to
one evaluation that is always false. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 18659408bb69..ea01cfce77d8 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -207,11 +207,6 @@ static void HTIOTPeerDetermine(struct rtllib_device *ieee)
 	netdev_dbg(ieee->dev, "IOTPEER: %x\n", ht_info->IOTPeer);
 }
 
-static bool HTIOTActIsDisableMCS15(struct rtllib_device *ieee)
-{
-	return false;
-}
-
 static bool HTIOTActIsDisableMCSTwoSpatialStream(struct rtllib_device *ieee)
 {
 	return false;
@@ -691,10 +686,6 @@ void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
 		HTIOTPeerDetermine(ieee);
 
 		ht_info->iot_action = 0;
-		bIOTAction = HTIOTActIsDisableMCS15(ieee);
-		if (bIOTAction)
-			ht_info->iot_action |= HT_IOT_ACT_DISABLE_MCS15;
-
 		bIOTAction = HTIOTActIsDisableMCSTwoSpatialStream(ieee);
 		if (bIOTAction)
 			ht_info->iot_action |= HT_IOT_ACT_DISABLE_ALL_2SS;
-- 
2.42.0

