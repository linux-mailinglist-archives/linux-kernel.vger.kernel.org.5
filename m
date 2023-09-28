Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7577B138E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjI1HGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjI1HGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:06:19 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7D919C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:06:16 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40572aeb673so97541865e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695884775; x=1696489575; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PAG8D+7zuIve2pCqK3iu3OyENEASiaU2T/4K8Fq5/EU=;
        b=J73xg+7gVDi282sCPQLHbpLJn/N0Yty5Oay6KaFKgiameHgFyGg2PTDsdkN83UnJi7
         /sOlfi9DflcBczE6+r89PPmD+T83ec49893aVb0LfLsTsDrGjzS46p7duunqI9D6Xmod
         di7e5hFyyTooLLNDNMvYobokVkD277d5PpGBRyzMVU3bn1/HLW77xbEzjFhXjmtnRxmU
         N9/CHk25Wk98nN3E2lRD4MbBWwQUwpNpj406fpa+/zOyqAJzfPQqS/yR6Tj2af53EBFM
         UxluqduTpg0qjUaBKceMHbNjvFck2EEQx95n7baE1nc5YMSu2jlQhByH6xcErlliSPv3
         VzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695884775; x=1696489575;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PAG8D+7zuIve2pCqK3iu3OyENEASiaU2T/4K8Fq5/EU=;
        b=sYEG8IdhuJ+klaKqgUxnGm/hE1tM0Z2y1FFZ6lYAJjIdRqi7Z2SD4Sj2ltPUmNfTZ6
         O8c4OpQWeetQNGPN+YwT7BHvIPQNgkNPcx0sWHB9DjQmreCbHzEL59e+lYWC9jE5XJvp
         yhWNR+5SDSV13S82qnguAcAz/es2xr4bvVqERuIbtgHcu3tCJU39YYHxwy20bItytS7Z
         VOf93eZ178JpnlHD7OPlDRlqK46MKk6afnfhb8kNh+vWoDQdzlGSMgRGckppwg3ABr3B
         xPIKs1Xmlp4zM162Vwd5uZr8CQzVqab7vZjdXKo7F1ciyEXt6+CV75RDsU0eGPoX7/TJ
         W3aQ==
X-Gm-Message-State: AOJu0Yz0NWhmO58r8+QciO2WDvUXErfbpjISl3SrEc2BuI5SQtmwG7Gs
        9LUlmgN5VdT/bE8bvrll8/iHRg==
X-Google-Smtp-Source: AGHT+IHlAP5EqB0zVUlx46YcvgYnVP7smY2dmmz7uWLiuhrOA/+Ay0Wd0+FcEnrx+Rhe2owYUHA24g==
X-Received: by 2002:a7b:cc8d:0:b0:401:38dc:8916 with SMTP id p13-20020a7bcc8d000000b0040138dc8916mr420957wma.10.1695884774706;
        Thu, 28 Sep 2023 00:06:14 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a24-20020a05600c225800b004063c9f68f2sm5656463wmm.26.2023.09.28.00.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 00:06:14 -0700 (PDT)
Date:   Thu, 28 Sep 2023 10:06:11 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] locktorture: Check the correct variable for allocation
 failure
Message-ID: <ec2c9ecf-9360-41fa-934d-6854d2615799@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a typo so this checks the wrong variable.  "chains" plural vs
"chain" singular.  We already know that "chains" is non-zero.

Fixes: 7f993623e9eb ("locktorture: Add call_rcu_chains module parameter")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 kernel/locking/locktorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index a3abcd136f56..69d3cd2cfc3b 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -1075,7 +1075,7 @@ static int call_rcu_chain_init(void)
 	if (call_rcu_chains <= 0)
 		return 0;
 	call_rcu_chain = kcalloc(call_rcu_chains, sizeof(*call_rcu_chain), GFP_KERNEL);
-	if (!call_rcu_chains)
+	if (!call_rcu_chain)
 		return -ENOMEM;
 	for (i = 0; i < call_rcu_chains; i++) {
 		call_rcu_chain[i].crc_stop = false;
-- 
2.39.2

