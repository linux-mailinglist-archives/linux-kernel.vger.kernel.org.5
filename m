Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0141A7F0960
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 23:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjKSWQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 17:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjKSWQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 17:16:07 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097F31728
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:15:51 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9fd57d009fcso19857466b.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700432149; x=1701036949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aoxqGEFk9urPUCn7RYMpHrc4r9kPUjHKVpLcLoj2K+I=;
        b=B35Yp2OhfbkJlUvHwYDBt4Tsa6zxNU/Z8jnp00Ib22r7dJsM0Md0ttoJNtsP5cFKsi
         pxWnmGy8LPcNDhK54s7K/Kw1o1K4RDU1KnQ44vaSK6EgVjrBKiiNEWEaELFYrHrVVCAI
         zadN8yvCKVqSeIgr1215UvX5YxgeYb9redVu+oO36IBNOF8vfTYLkl/kyIx7uARFVLSj
         Nx5iddeAZET+ih4o67GFIK12O1AGwCZp5seD3rfagtUxO60Izoukf48E1lTu/jU5Zn1y
         l01LzW9s1PJN8MqC1yxYDjmw+XJI0D1eE92v6IytRUkwriti6phqScVYeg/CTtnvB2Jt
         AhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700432149; x=1701036949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoxqGEFk9urPUCn7RYMpHrc4r9kPUjHKVpLcLoj2K+I=;
        b=UNu5uGxWmvwTB/r/t1jlrEKuIHBbw1v8XgpyW6AkqwzpTolEcpomUtnuSizk0zxSey
         PYUz2BPLinK//EXKqsxepFfB2INidDwRZozO7bW7Ddh3ZpFElHxiaf34IY6bCM/AxEor
         VmMPwpZTK/JS83dkKiZ0jCLmftm1J22nu4YTl+B9hShnycHuHbZqh+mIguERMUtFApF9
         QJxcFWrt5lBXQsxEXYsZD1pj0H2nhDp8vZLV5W/I+HATfuFJD4wKgXKJxfcCQRLH37bI
         LJbvCF2s+nSPyKhfOl+EVrxAGAY+y17i9/U63tdrnl5VzbCdBnSNlDH6EeoSAgvr8/DP
         QQEQ==
X-Gm-Message-State: AOJu0Yygu5z4FWjzeC5k5NMLx2UJ+5/awPjCoJGhPTLYD8asc13KuyK6
        VpBHevSB6wVYsg6NaqMBnwo/mguUtuQ=
X-Google-Smtp-Source: AGHT+IF0nppcsVEy+uQJy8MCutCLr5TzKFZ9U+on2LhEGmKQzq7Kah7nSBX13282/CHLpSypbR7dmA==
X-Received: by 2002:a17:906:1da:b0:9be:4cf4:d62e with SMTP id 26-20020a17090601da00b009be4cf4d62emr4303045ejj.5.1700432149497;
        Sun, 19 Nov 2023 14:15:49 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id e2-20020a170906c00200b009fb1c3ce877sm1755880ejz.76.2023.11.19.14.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 14:15:49 -0800 (PST)
Date:   Sun, 19 Nov 2023 23:15:47 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 12/14] staging: rtl8192e: Remove unused function dot11d_init()
Message-ID: <d2e8d81ec9eefc7b7eeb9f6fd6a28b28db6b40f0.1700431464.git.philipp.g.hortmann@gmail.com>
References: <cover.1700431464.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700431464.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable dot11d_info->channel_map is initialized in dot11d_init() and
in dot11d_channel_map(). dot11d_init() is called only once just before
dot11d_channel_map(). Therefore dot11d_init() can be removed.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/dot11d.c            | 8 --------
 drivers/staging/rtl8192e/dot11d.h            | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 1 -
 3 files changed, 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/dot11d.c b/drivers/staging/rtl8192e/dot11d.c
index fd488e2fa815..9ec112e00e38 100644
--- a/drivers/staging/rtl8192e/dot11d.c
+++ b/drivers/staging/rtl8192e/dot11d.c
@@ -14,14 +14,6 @@ struct channel_list {
 
 static struct channel_list channel_array = {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13}, 13};
 
-void dot11d_init(struct rtllib_device *ieee)
-{
-	struct rt_dot11d_info *dot11d_info = GET_DOT11D_INFO(ieee);
-
-	memset(dot11d_info->channel_map, 0, MAX_CHANNEL_NUMBER + 1);
-}
-EXPORT_SYMBOL(dot11d_init);
-
 void dot11d_channel_map(struct rtllib_device *ieee)
 {
 	int i;
diff --git a/drivers/staging/rtl8192e/dot11d.h b/drivers/staging/rtl8192e/dot11d.h
index 82748b12bd82..767bbbc8b01d 100644
--- a/drivers/staging/rtl8192e/dot11d.h
+++ b/drivers/staging/rtl8192e/dot11d.h
@@ -31,7 +31,6 @@ struct rt_dot11d_info {
 #define GET_DOT11D_INFO(__ieee_dev)			\
 	 ((struct rt_dot11d_info *)((__ieee_dev)->dot11d_info))
 
-void dot11d_init(struct rtllib_device *dev);
 void dot11d_channel_map(struct rtllib_device *ieee);
 
 #endif
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 4b842a1789c2..c3466291e221 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -795,7 +795,6 @@ static short _rtl92e_get_channel_map(struct net_device *dev)
 
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	dot11d_init(priv->rtllib);
 	dot11d_channel_map(priv->rtllib);
 	for (i = 1; i <= 11; i++)
 		(priv->rtllib->active_channel_map)[i] = 1;
-- 
2.42.0

