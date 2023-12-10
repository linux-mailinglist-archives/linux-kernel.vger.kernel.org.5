Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B4480BBF6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 16:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjLJP07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 10:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbjLJP0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 10:26:42 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421A7193
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 07:26:48 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40c192f488cso5991535e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 07:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702222006; x=1702826806; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W1A/KEgyt6f82zEHVyS55QzynSt7PFOs4Ej8iQWUE3o=;
        b=fm4V0PNeZ/AF2JECUxMGN7RSPUbZjr8VwGvRjjS2H3wjWNQUZFSYmJSfB9IHG4opdY
         6cX6qb7c1VRfkvu72S21g1DpYgd4PdvTcVEoXa/VYkJfRGiLcd8vadPv0KDMy9EZXKHh
         KdxfhRDIKSE8pVoUEGurul15mdk1KGutiumY150mpqOwWlaj16Q7W9CJumXfPv6nHQDO
         LBGhtQdtx05iHmhNRO2gXPy7JQgrc9y4TEU7PwNhA/gYjuv0/x9rhI3EptApt58r/0Hj
         gz82ZHB6JaXaBgf+01Y1kSKmaCPUDOGmpMiMclRz6YCG/cnQZNfryii2WSA995g4/7NB
         MDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702222006; x=1702826806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1A/KEgyt6f82zEHVyS55QzynSt7PFOs4Ej8iQWUE3o=;
        b=RjtbjpoC0NwPI0MADrIzvpLX0vbIu4qqVo8kUx/R5M+FqoYlkN02yz+heHFd62fNgl
         0gvU4rkG7HZMVGri+wzRR3tAOopvkeN5YnX87LZkc4o3sL3RaMme33giyFiSTYmWUup0
         wEwyRZomjSMY9Cme0PbOWD6ynUa4Kdqyof2/KkxqgGHA7bRYSQWsRj82MH13Z+XMuRNp
         K6c17LK5N7j4cBiu4RlunT6KsmDIVlRRZ0o+PmD7R9NAy0b/u/Z2iUkKDnqlDgPwmvjz
         OoxzoHwGvphRLGbuyCdR80w+2lEAWcDhFvje20jnnOJod0zi0oV2WL8jm4EDZxLUPCSN
         //ZQ==
X-Gm-Message-State: AOJu0Yw9ZfaHTbZbAykyMTpwORWpVJQv1Z93WE4uBuuRQXAeCXT2WTeQ
        a72VItg5xvfQBYmM6tuFcfY=
X-Google-Smtp-Source: AGHT+IG+egokZ4LpUcvK7T07fDpzPhtz85ZEe6LZDMNFDLu9BGAD1guVZLyFzvbqnXFmVFnxHOJrlw==
X-Received: by 2002:a05:600c:524e:b0:40b:2708:2a52 with SMTP id fc14-20020a05600c524e00b0040b27082a52mr4018180wmb.1.1702222006500;
        Sun, 10 Dec 2023 07:26:46 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b0040c4620b9fasm1534010wmq.11.2023.12.10.07.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 07:26:46 -0800 (PST)
Date:   Sun, 10 Dec 2023 16:26:44 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] staging: rtl8192e: Remove variable ForcedAMSDUMode
Message-ID: <ae8ea27e2c3708754b798f09ba43ed50a24b8a55.1702212003.git.philipp.g.hortmann@gmail.com>
References: <cover.1702212003.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1702212003.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ForcedAMSDUMode is set to 1 and then never evaluated.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 1 -
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index d249062e7b66..670affe9d57b 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -115,7 +115,6 @@ struct rt_hi_throughput {
 	u8 current_mpdu_density;
 	u8 forced_ampdu_factor;
 	u8 forced_mpdu_density;
-	enum ht_aggre_mode ForcedAMSDUMode;
 	u8 forced_short_gi;
 	u8 current_op_mode;
 	u8 self_mimo_ps;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 0a5885d6c0a0..bedee290e7f5 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -513,7 +513,6 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 					      pPeerHTCap->MPDUDensity);
 	if (ht_info->iot_action & HT_IOT_ACT_TX_USE_AMSDU_8K) {
 		ht_info->current_ampdu_enable = false;
-		ht_info->ForcedAMSDUMode = HT_AGG_FORCE_ENABLE;
 	}
 	ht_info->cur_rx_reorder_enable = ht_info->reg_rx_reorder_enable;
 
-- 
2.43.0

