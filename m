Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DB47C8809
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjJMOn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjJMOnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:43:53 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0780CA
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:43:50 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4053e6e8ca7so6987185e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697208229; x=1697813029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w8SaTIPv9bZSjFBzeO1OYPVCHSjabEYQBQuyencb7Ig=;
        b=OnjQDnIKAKNIe05JaPfBkoGwvwJCTbY6lKC+sw+R9FUrj9vTV0LKl7aFaqnfaSrnuw
         7Tv3yUTgC7Den4ansQIN8WadDCktFG+bgu9EcUi9c/gwakn26ahSMIUxlp2gWI5zw9w7
         JmPsxP1Le5RqexwGrM+lAcGYOPEpoxHsaAH6u25eX+CRwsaNYiTzPJxni/SeQuUinY1O
         uV7dW7HfQ4Y79bM13zRofzl1FFdUqBpo9io9/RLZPTlqra4PTBJXpKI9wlJGWxvb5nfF
         U+Zphp4sWxhJASEB6ElplVTVFEip24u5khXkHoN2pfKfMQd+up/Qo5NsM57h5YiyQ+q0
         JgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697208229; x=1697813029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8SaTIPv9bZSjFBzeO1OYPVCHSjabEYQBQuyencb7Ig=;
        b=DGX6da0mue/w2upsyYs1uRJ4ytjc6qPkB+UAeUZvJRVTxtXs2miS601umBr346ffzx
         z072VMJAg2hIUvhIIxdTbIC2k/GOcdpElr1TX7o0TTED1odWx9RXLulaSRl5TSM6v/9l
         CUmgeJ5dVG92RP+fEUB4/oktKJ7af9MXy8XeNCUVhRgwP9FdQ3nh43tTT9pGLbvRsElI
         QyHyHp8BfI1bPPhi7T9QlaEnxNjAukQRGwhtOfZ4dyzLZh+vcrgREbyNBZcRzTYMFk3S
         2ShO5V32993Sfn2nUgiTWPnFsP1bikkEUrrVK7lRrrqAjKcKMLqc9+NNoCGwV+oJlE8b
         vD/Q==
X-Gm-Message-State: AOJu0YwLIkdbCT/fBN1QS+SxwW5y654GTsKU0xn613/L/jGPZQVZKhQy
        7rBIwdkug+zw8q/8E1Rc7bU=
X-Google-Smtp-Source: AGHT+IFwtt0CK9XdJ5BjERuoJ4zOPy+UTgy0+12btgC+iqHiQaBZg/OqTFwXi3H2W8zuotSwgh5e9A==
X-Received: by 2002:a05:600c:511d:b0:401:b53e:6c3e with SMTP id o29-20020a05600c511d00b00401b53e6c3emr24393440wms.1.1697208228764;
        Fri, 13 Oct 2023 07:43:48 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id s16-20020a05600c45d000b004063cced50bsm324486wmo.23.2023.10.13.07.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 07:43:48 -0700 (PDT)
Date:   Fri, 13 Oct 2023 16:43:46 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] staging: rtl8192e: Remove unchanged variable
 dig_enable_flag
Message-ID: <24a9245840093c5a14124f9fc896433c7d85d18c.1697127817.git.philipp.g.hortmann@gmail.com>
References: <cover.1697127817.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697127817.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove variable dig_enable_flag as its value is set to 1 at
initialization. No further writes to dig_enable_flag are done. The
equations result accordingly. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 11 -----------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h |  1 -
 2 files changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 01abe1e48468..bbd18b6cc252 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -913,8 +913,6 @@ static void _rtl92e_dm_dig_init(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	dm_digtable.dig_enable_flag	= true;
-
 	dm_digtable.dig_algorithm = DIG_ALGO_BY_RSSI;
 
 	dm_digtable.dig_algorithm_switch = 0;
@@ -941,9 +939,6 @@ static void _rtl92e_dm_dig_init(struct net_device *dev)
 
 static void _rtl92e_dm_ctrl_initgain_byrssi(struct net_device *dev)
 {
-	if (!dm_digtable.dig_enable_flag)
-		return;
-
 	if (dm_digtable.dig_algorithm == DIG_ALGO_BY_FALSE_ALARM)
 		_rtl92e_dm_ctrl_initgain_byrssi_false_alarm(dev);
 	else if (dm_digtable.dig_algorithm == DIG_ALGO_BY_RSSI)
@@ -976,9 +971,6 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_driver(struct net_device *dev)
 	u8 i;
 	static u8	fw_dig;
 
-	if (!dm_digtable.dig_enable_flag)
-		return;
-
 	if (dm_digtable.dig_algorithm_switch)
 		fw_dig = 0;
 	if (fw_dig <= 3) {
@@ -1007,9 +999,6 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_false_alarm(struct net_device *dev)
 	struct r8192_priv *priv = rtllib_priv(dev);
 	u8 i;
 
-	if (!dm_digtable.dig_enable_flag)
-		return;
-
 	if (dm_digtable.dig_algorithm_switch) {
 		dm_digtable.dig_state = DM_STA_DIG_MAX;
 		for (i = 0; i < 3; i++)
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
index 5ae2bf467158..faf08763c340 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
@@ -50,7 +50,6 @@
 
 /*------------------------------Define structure----------------------------*/
 struct dig_t {
-	u8		dig_enable_flag;
 	u8		dig_algorithm;
 	u8		dig_algorithm_switch;
 
-- 
2.42.0

