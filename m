Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093737EFE93
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 09:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbjKRIvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 03:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbjKRIve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 03:51:34 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F5D1725
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 00:51:28 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9e28215db77so83283666b.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 00:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700297487; x=1700902287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vMytCypAKR6h1wsB0OQEQ+cFMOVYMGL6IbHLXc4UGuE=;
        b=QOp7DghVXLTjC7R4yi8ZRl2+m7Ks6D7zvTmqscPCGjqJoimRC7hISTveXUzivvDWIi
         PaZLyrvkdS5+vDv3MoHQm4XiJ5Rwn2UOaGY8f41CxZ/5GdKwNn+2aCE1cd85HBkqR/iT
         FFL+I+N/xllw4a/t9pp6ovuyzQCNq4m7dRS6CJkSb4eItyUHEkMH0GeH3fSS88G/Vy47
         skFZzevMIe/TCQMLZiFKkcG/4MNh9ZIpELJwcl++9NE+e6ht61Kxc1AfQSUCuPOYaAsf
         EKNus/6XYnn0wdwN3iGU0JTVj5Mmyam2ROXBExECcQEoV9TDz16PGAc372SNJfdJBTOv
         fbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700297487; x=1700902287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMytCypAKR6h1wsB0OQEQ+cFMOVYMGL6IbHLXc4UGuE=;
        b=RYS2Sjj4qcAH31bxdsUuI5P0AiRlJr3AHEJRiFQb5Tewix1Th22dUb65DlDSI+eU/o
         zU/WV6783jYgv4jMrtgwKit2vkzpaPcpY5uVAJY7b8Jr1PukO6G5JVaKyseYSWqD5iu4
         0lr6xhlIbW37gLNY47VsN/rT40bKCZl9NLvti3NBiLHyyrT45MmsJL3iXwwSx67YXQ2H
         xndPHu+l5GN5EqnvJ6gKwW3THFzlDak43IicDkvOpXcmutUV/QMRcwB4lmYDk6fs0wr1
         8FW/vnJy64EZrgOGTbdcfVtOrqEZjsViGOZJ4mdrJKClkgAhrNPFhBpSi7aOYzPb4gFA
         JsWQ==
X-Gm-Message-State: AOJu0Ywf0s44QEw6blaEFHcDUOkOroI319Rdu+l5YPOo4ESUCpMLWntf
        R+AN3ndT5t4HJ84s9ETGPOU=
X-Google-Smtp-Source: AGHT+IEJxyDYevO9u1ZvQlIAYKwA1u1hwMrPRuZiGLG7Gd0x+Re1XWYG1WT1bSHyS+iyT5Sg+atNYA==
X-Received: by 2002:a17:906:10cf:b0:9e6:dfee:8154 with SMTP id v15-20020a17090610cf00b009e6dfee8154mr1036711ejv.3.1700297487250;
        Sat, 18 Nov 2023 00:51:27 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57ba2f20.dip0.t-ipconnect.de. [87.186.47.32])
        by smtp.gmail.com with ESMTPSA id jz12-20020a170906bb0c00b00988f168811bsm1675679ejb.135.2023.11.18.00.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 00:51:27 -0800 (PST)
Date:   Sat, 18 Nov 2023 09:51:25 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] staging: rtl8192e: Remove equation that results in
 constant for chnl_plan
Message-ID: <d6fbe3d2297d1d5502b183785f14df51a81e3331.1700296319.git.philipp.g.hortmann@gmail.com>
References: <cover.1700296319.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700296319.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove equation for chnl_plan as the last line sets chnl_plan to a
constant.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index e93394c51264..44898e0be21c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -387,23 +387,15 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 
 	rtl92e_init_adaptive_rate(dev);
 
-	priv->chnl_plan = priv->eeprom_chnl_plan;
-
 	switch (priv->eeprom_customer_id) {
 	case EEPROM_CID_NetCore:
 		priv->customer_id = RT_CID_819X_NETCORE;
 		break;
 	case EEPROM_CID_TOSHIBA:
 		priv->customer_id = RT_CID_TOSHIBA;
-		if (priv->eeprom_chnl_plan & 0x80)
-			priv->chnl_plan = priv->eeprom_chnl_plan & 0x7f;
-		else
-			priv->chnl_plan = 0x0;
 		break;
 	}
 
-	if (priv->chnl_plan > CHANNEL_PLAN_LEN - 1)
-		priv->chnl_plan = 0;
 	priv->chnl_plan = COUNTRY_CODE_WORLD_WIDE_13;
 
 	if (priv->eeprom_vid == 0x1186 &&  priv->eeprom_did == 0x3304)
-- 
2.42.0

