Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB06F7EFE94
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 09:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjKRIv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 03:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbjKRIvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 03:51:44 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEDCD79
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 00:51:37 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9e3eaf098f1so76682966b.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 00:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700297496; x=1700902296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fFLHsxGK7k/8eykGJrZMJGzqZ9wJ0aqJSpq01GUYpM8=;
        b=LGr98wLgCyrn/CP4yhiyJ8KiFXJNPcWRY3B9lj0LMh77PcmwVQN1x8K0emcRhHzKvA
         N5Q+hnN0f/Mlqtu/NVPZiygwVqmkzpfu+wwNFA++EICSHFLv1tTPFnWPQbLjfeQvlJ+2
         VILLJr8AX/7QqJje+3R3mfUqC4Xu9/V+Hy5EcweXhjgJ/FxLuFWEthBlJKAVcDVDE/Y9
         LVaouIkYzF0H2Av1nqAVbdwcolQLS0MsP3zwV45jVimsxJxk02AKfQSTGHHd6n/IHxTu
         fd1H9zyFfyusyUd3cf3F3bwEvJ6r6KI6YcfcnLzEvGr7EMeTe8bBNb/QXWMLL131OMro
         Sa2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700297496; x=1700902296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFLHsxGK7k/8eykGJrZMJGzqZ9wJ0aqJSpq01GUYpM8=;
        b=oDCyaUfKVvEpnKnDZQ9j7L+XJa76hs8JajQHLPzXe1KLaPRRKNgFVZ6EEwouCBZ+qo
         Z8TTdEIlUnMJivYnUWNqXqTOZdMPLE1Ciz7Tx8r3MZ+D8w72vzJ96F4Fec/CProwuCnm
         7FFnIsqPNYNX2EoM/NpwzrA+b9gWIhDq9m2KJZLBLyFT6qY/GHDIfq5QPF64RKB43eCD
         v/nGRcIQ6v7DwxvLb0M0Lz4P63dXEk0XkXQ2Ca3KcN/E8lhxHz5+J6nyvNYsWe/6Q2VN
         ACoILM76qv4EG/GwJtTGG+9a+PYWUp8jW8QhLqbhimpZ7MW5e+BLpJAm27hXLtw95J2o
         eicQ==
X-Gm-Message-State: AOJu0Yz2/5UY4CV5KMLDf2IHdbGhrVS4ncU31ORBR1wuhOX1eqvs3sCo
        Y5waynji+dbTfiz0JoEMl9Q=
X-Google-Smtp-Source: AGHT+IGRibVfC9vsxr71T3msML2jvfXftKU6rYG8jk8iYmowTNsklN78jaPALqMcQoG9VhQlI2kNFA==
X-Received: by 2002:a17:906:1da:b0:9cf:7d6e:2c3e with SMTP id 26-20020a17090601da00b009cf7d6e2c3emr1133601ejj.7.1700297495823;
        Sat, 18 Nov 2023 00:51:35 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57ba2f20.dip0.t-ipconnect.de. [87.186.47.32])
        by smtp.gmail.com with ESMTPSA id l2-20020a170906230200b009fb1fc8c405sm214001eja.179.2023.11.18.00.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 00:51:35 -0800 (PST)
Date:   Sat, 18 Nov 2023 09:51:34 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] staging: rtl8192e: Remove constant variable chnl_plan
Message-ID: <e46f16227877fe9853c9d15992e7fd27a0ceeae6.1700296319.git.philipp.g.hortmann@gmail.com>
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

Remove constant variable chnl_plan and replace it with its constant.
Remove equation that limits maximum value of chnl_plan as it is always
false.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 --
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 7 +------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   | 1 -
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 44898e0be21c..9b51deba149b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -396,8 +396,6 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 		break;
 	}
 
-	priv->chnl_plan = COUNTRY_CODE_WORLD_WIDE_13;
-
 	if (priv->eeprom_vid == 0x1186 &&  priv->eeprom_did == 0x3304)
 		priv->rtllib->bSupportRemoteWakeUp = true;
 	else
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 2789f428e4f9..68bd03500267 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -795,13 +795,8 @@ static short _rtl92e_get_channel_map(struct net_device *dev)
 
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	if (priv->chnl_plan >= COUNTRY_CODE_MAX) {
-		netdev_info(dev,
-			    "rtl819x_init:Error channel plan! Set to default.\n");
-		priv->chnl_plan = COUNTRY_CODE_FCC;
-	}
 	dot11d_init(priv->rtllib);
-	dot11d_channel_map(priv->chnl_plan, priv->rtllib);
+	dot11d_channel_map(COUNTRY_CODE_WORLD_WIDE_13, priv->rtllib);
 	for (i = 1; i <= 11; i++)
 		(priv->rtllib->active_channel_map)[i] = 1;
 	(priv->rtllib->active_channel_map)[12] = 2;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 348df71e122e..addaa1eb39ee 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -310,7 +310,6 @@ struct r8192_priv {
 
 	bool tx_pwr_data_read_from_eeprom;
 
-	u16 chnl_plan;
 	u8 hw_rf_off_action;
 
 	bool rf_change_in_progress;
-- 
2.42.0

