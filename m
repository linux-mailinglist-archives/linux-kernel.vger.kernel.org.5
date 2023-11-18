Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29117EFE95
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 09:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjKRIwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 03:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjKRIvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 03:51:51 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D3E1986
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 00:51:45 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54488f19b6cso739664a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 00:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700297504; x=1700902304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=60TEIsDbZcJztid9/FBNOOfGZ+ibynkio00841tSlME=;
        b=bGkjW9qOWgjdRgjCrxeFeKdA4GUEP1/gc+CrKSnqPpYTO6sm+cf/iIBGpJD5p6I6V9
         BQZIUYDHXIyrjooCQ8N2XKAbA8+rmK80VKF+cJ7Nw54X3ymbUoFfI5uXFBu3LwAXkww7
         /+JW6yONZw3FCQ9QHdsIcUzskS6ZJHOTAQFGgdiKkWB+2X9nPjSgS4F85z5IQIbkklYu
         cf89yn+SLyULxygTGCRF1n7FM9juFKUimKBJUO4+egW8K908mYZxUtR5ee2APCn9oHWc
         a/qnwd/WfLlwmLesaCTQCiPLG5+D2XOi2V2V5Y1C2E7y2V4p9XtXGqZ4tFyRcGXimZOM
         eP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700297504; x=1700902304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60TEIsDbZcJztid9/FBNOOfGZ+ibynkio00841tSlME=;
        b=llAavbHsq18v0Ieeh9SOkgR158691at8kc8L2Z82drkyl8ADXAcuXUjbf7AMYDRBNC
         5IW/2U6uAHIBzIH6kueMO/C8RVHsrTNxTgkbBMTCByT2sNppp57QK7kbLh+4jb9NTYvg
         JQ+ic7v35LFJB2vvzA7BaVXBfQwgzyvEMCswOBQnjPCJLUURm59SRP48wOJeKOImw3YK
         huttKBQFBPSSXyxpv4RW0zoVQW7hNVdkgRygvTKEvR4HliQmyYIdBfjYZb9afwhFVCAs
         Ir5oR0Z4rGhYinCULBpPVguCLjMy+hthjaqxEUcHXo5pba9JkW59IgirueRD7/kWA9G/
         uqAA==
X-Gm-Message-State: AOJu0Yxb1R+tAijktyMiZwVEaYmpC6seA0EgU91eHHgJp49MyO0OJBZf
        auiEvyYqUtQPrrQ50aQqGWE=
X-Google-Smtp-Source: AGHT+IHpDvqR83tfTWq7GrzTx5Ftu0W4/DcSCPG8Olvrsf3Se+/xJDhPTqZHJf/14sHUGjSXHeNG/w==
X-Received: by 2002:aa7:ca50:0:b0:548:5671:8330 with SMTP id j16-20020aa7ca50000000b0054856718330mr1236640edt.3.1700297503703;
        Sat, 18 Nov 2023 00:51:43 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57ba2f20.dip0.t-ipconnect.de. [87.186.47.32])
        by smtp.gmail.com with ESMTPSA id u10-20020aa7d88a000000b0052febc781bfsm1504123edq.36.2023.11.18.00.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 00:51:43 -0800 (PST)
Date:   Sat, 18 Nov 2023 09:51:42 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] staging: rtl8192e: Remove unused variable
 eeprom_chnl_plan
Message-ID: <ffc592edd61332d2d8f9b0da68fc956d76e68fe0.1700296319.git.philipp.g.hortmann@gmail.com>
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

Remove unused variable eeprom_chnl_plan.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 --
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 9b51deba149b..8fe4c03b19c1 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -261,7 +261,6 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 		priv->eeprom_customer_id = usValue & 0xff;
 		usValue = rtl92e_eeprom_read(dev,
 					     EEPROM_ICVersion_ChannelPlan >> 1);
-		priv->eeprom_chnl_plan = usValue & 0xff;
 		IC_Version = (usValue & 0xff00) >> 8;
 
 		ICVer8192 = IC_Version & 0xf;
@@ -283,7 +282,6 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 		priv->eeprom_vid = 0;
 		priv->eeprom_did = 0;
 		priv->eeprom_customer_id = 0;
-		priv->eeprom_chnl_plan = 0;
 	}
 
 	if (!priv->autoload_fail_flag) {
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index addaa1eb39ee..e7b331c4661c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -284,7 +284,6 @@ struct r8192_priv {
 	u16 eeprom_vid;
 	u16 eeprom_did;
 	u8 eeprom_customer_id;
-	u16 eeprom_chnl_plan;
 
 	u8 eeprom_tx_pwr_level_cck[14];
 	u8 eeprom_tx_pwr_level_ofdm24g[14];
-- 
2.42.0

