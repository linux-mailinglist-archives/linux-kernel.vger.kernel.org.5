Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4527B47A7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 15:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbjJANoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 09:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbjJANoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 09:44:13 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7B0F0
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 06:44:10 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-533c71c5f37so3313408a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 06:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696167848; x=1696772648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=522MwXZqJUWHyXjMD6+ZKRNyT+zr9qIsF/KHqubKWwA=;
        b=jEsvwHUXLf0DBNe5Nm+ImP8hcNZ14U9GPgZ83hseQeSTmxtTtpyYDFCCMBGzIe8Sha
         A8c28ULtw0rAxMGqjxuHDsd4XvicpKjGn3FJdqO7EBGFO0q2E40LGbUaSeBDglEfrm1x
         UkTBApX1oINiIzcd7iW225DexmiDrR9mTFpWymVdoqp6alY2aPkAzuLl7WAJxMGRKyyb
         jxrP5LUHJYKwbgupztqU9A6NdS4z5yLYsGenCRovkG8UROC5Bci/G2woPRbjnZHbzRQm
         BIOzEPP+UeLO+tMloXLZ/mkjS1L2c9ck+LMeUEzj/1XwSaXwXP0WH6C6N5eo+BT6DQQG
         kZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696167848; x=1696772648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=522MwXZqJUWHyXjMD6+ZKRNyT+zr9qIsF/KHqubKWwA=;
        b=IjPu/1PsO3YpBklnXmewwacBXg2Uaij60Zn2Ae/SqiKJSWaHFZNES/zse09mAh+VKf
         k1g/yVOdfIL7qXbFUcVIDyWFfOjGPAmFX1aTlPSBsQJfaAd8YA/FCoCP416/kqFUozlj
         15rJMA8yh18Jvemqmp5Ee506EjfBPWS6e2T3gOy3u9ihjzQW2w+fgXxQBRIBWezmnH41
         8SguXjBvWdaXCmOJXUNMNdw9N092zwPT+N22n3j8HIkApMvwxmJUTtbRUNmz8TQFQ87N
         7y3YTGkQEQ2ob9WwDvQTP/KGbpse5GIOQ/6kW1SZgiCDR8U92WGmr7HxN9CBLNN7npWc
         RWug==
X-Gm-Message-State: AOJu0YwagHENZqhJJZbcp8dshoJIxd+9NB5kTXx4/ihjBgZ11lDssC6O
        9BL4J1FKljpCt6XfZXLm0x21iHK/Ft0=
X-Google-Smtp-Source: AGHT+IH1X/sCWgQUa5MwEqVHyRwzYptm0N4XJUzsCkcGYjg1aLdr7kQqWgTAJMGC/YuZsOPhr/n/MQ==
X-Received: by 2002:a05:6402:5243:b0:51d:cfeb:fc3b with SMTP id t3-20020a056402524300b0051dcfebfc3bmr6777839edd.1.1696167848673;
        Sun, 01 Oct 2023 06:44:08 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id k15-20020aa7c38f000000b00537fee52351sm2743509edq.28.2023.10.01.06.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 06:44:08 -0700 (PDT)
Date:   Sun, 1 Oct 2023 15:44:06 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] staging: rtl8192e: Remove dead code from
 _rtl92e_if_check_reset()
Message-ID: <5f29332205dd76896e981fa627925d62a6bf7f63.1696165351.git.philipp.g.hortmann@gmail.com>
References: <cover.1696165351.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696165351.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of _rtl92e_tx_check_stuck() and _rtl92e_rx_check_stuck()
can only be RESET_TYPE_SILENT or RESET_TYPE_NORESET. This functions are
only used in _rtl92e_if_check_reset(). In _rtl92e_if_check_reset() the
return values are checked for RESET_TYPE_NORMAL which cannot occur.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 87f5441fbb10..f67923ccf790 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -975,12 +975,7 @@ static enum reset_type _rtl92e_if_check_reset(struct net_device *dev)
 	    (priv->rtllib->link_state == MAC80211_LINKED))
 		RxResetType = _rtl92e_rx_check_stuck(dev);
 
-	if (TxResetType == RESET_TYPE_NORMAL ||
-	    RxResetType == RESET_TYPE_NORMAL) {
-		netdev_info(dev, "%s(): TxResetType is %d, RxResetType is %d\n",
-			    __func__, TxResetType, RxResetType);
-		return RESET_TYPE_NORMAL;
-	} else if (TxResetType == RESET_TYPE_SILENT ||
+	if (TxResetType == RESET_TYPE_SILENT ||
 		   RxResetType == RESET_TYPE_SILENT) {
 		netdev_info(dev, "%s(): TxResetType is %d, RxResetType is %d\n",
 			    __func__, TxResetType, RxResetType);
-- 
2.42.0

