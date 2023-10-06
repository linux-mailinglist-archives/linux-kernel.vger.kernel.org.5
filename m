Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F6C7BBF84
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 21:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbjJFTGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 15:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbjJFTFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 15:05:50 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1AA132
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 12:05:42 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9b2c5664cb4so91676466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 12:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696619141; x=1697223941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=50wAwYPZKotuW/XLuJMHGzTqySgRqtpp7TbieAYYB4c=;
        b=KkBCH9Hr4KDn48nh3htXhNoFZNypg3dLvbOaSdOazqdwhJEArF8GzVtnCji/bwRPiD
         ruWosttdzmeeQn+gM2Uz6OOrFCJ0TfBUFlq/MZE8MVtfwJlw1R9bAwO3x8bpczNDqSIF
         OZy19B9UWL6873vTwcosXnWCsarLipDHaBPZtrnIlwV0Q6StUsZuWsAf07KfcOXjpp5r
         080fXMEVWOQ8Vc+j3HTf5Ev68ox5X/Ubf6uZPmiyRHQ01iTrtd739Wx+kEPUp2Bxhnk3
         /x+bYyhjxJ8L85gC6DCH7pJ5YXZQVH5AWgBoiWAtLNkfrP0W2CVEr9y4hzuKigU14jRJ
         dBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696619141; x=1697223941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50wAwYPZKotuW/XLuJMHGzTqySgRqtpp7TbieAYYB4c=;
        b=hGnueNyfv+OmNZFm89JJqcH80crhAR0pycMEmZ0afb+QCJ1VC/+o6il4v3/5mnv57j
         B9XlABR1q3mFjLlkYe1qPNR3DfheYzp6K1tVKi5gAAtioEA6pesQah58IIdpptk8dBzS
         lLWfOtwiew2JbD2XJs5AZ5ERhcCAXzf0j4Ydvv+PqEzVKdnw8JgQ4VtDxAJ+jUintlTz
         MB+pOIuVkhOAehV8RHsJfB6RpIomLqkn4WtaW+MvBNiUvPnHpJUi59BziM4xGDveMazb
         /c1b2rCEiVmDVdcqGHJVYc5lqiISWxCkSxhxvOGubv9DAaoWLjhRM0BAAW3XWk2zpZQ1
         WFkA==
X-Gm-Message-State: AOJu0Yz8gxRQbE31R8VHDbCE73YYismFp9Xy24vFdr5pTbGBjdfH8tdk
        SzstLoybV0sGWxgwSWgI7WQ=
X-Google-Smtp-Source: AGHT+IEqE6zbj595QGffuxcQqPzMt5FYCve+/vlKmTRiKuQuL1v51WpzYFImS1wF/JMhli3D8sGv+Q==
X-Received: by 2002:a17:906:24e:b0:9a5:9f3c:961f with SMTP id 14-20020a170906024e00b009a59f3c961fmr7849157ejl.3.1696619140986;
        Fri, 06 Oct 2023 12:05:40 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id cd16-20020a170906b35000b00991faf3810esm3345530ejb.146.2023.10.06.12.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 12:05:40 -0700 (PDT)
Date:   Fri, 6 Oct 2023 21:05:39 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] staging: rtl8192e: Remove unused file rtllib_debug.h
Message-ID: <b7b61bd068e8090b954e3c025bc724d9e85fc568.1696548527.git.philipp.g.hortmann@gmail.com>
References: <cover.1696548527.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696548527.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove #define DRV_NAME "rtllib_92e" as it is already set. Remove enum
RTL_DEBUG as it is unused. Remove #include <linux/bits.h> as it is unused.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h       |  1 -
 drivers/staging/rtl8192e/rtllib_debug.h | 47 -------------------------
 2 files changed, 48 deletions(-)
 delete mode 100644 drivers/staging/rtl8192e/rtllib_debug.h

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 2f968c3c0229..b12a39ecdd9d 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -31,7 +31,6 @@
 #include <linux/delay.h>
 #include <linux/wireless.h>
 
-#include "rtllib_debug.h"
 #include "rtl819x_HT.h"
 #include "rtl819x_BA.h"
 #include "rtl819x_TS.h"
diff --git a/drivers/staging/rtl8192e/rtllib_debug.h b/drivers/staging/rtl8192e/rtllib_debug.h
deleted file mode 100644
index 06adfebd7c89..000000000000
--- a/drivers/staging/rtl8192e/rtllib_debug.h
+++ /dev/null
@@ -1,47 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
- *
- * Contact Information: wlanfae <wlanfae@realtek.com>
- */
-#ifndef _RTL_DEBUG_H
-#define _RTL_DEBUG_H
-
-#include <linux/bits.h>
-
-/* Allow files to override DRV_NAME */
-#ifndef DRV_NAME
-#define DRV_NAME "rtllib_92e"
-#endif
-
-/* These are the defines for rt_global_debug_component */
-enum RTL_DEBUG {
-	COMP_TRACE		= BIT(0),
-	COMP_DBG		= BIT(1),
-	COMP_INIT		= BIT(2),
-	COMP_RECV		= BIT(3),
-	COMP_POWER		= BIT(6),
-	COMP_SWBW		= BIT(8),
-	COMP_SEC		= BIT(9),
-	COMP_LPS		= BIT(10),
-	COMP_QOS		= BIT(11),
-	COMP_RATE		= BIT(12),
-	COMP_RXDESC		= BIT(13),
-	COMP_PHY		= BIT(14),
-	COMP_DIG		= BIT(15),
-	COMP_TXAGC		= BIT(16),
-	COMP_HALDM		= BIT(17),
-	COMP_POWER_TRACKING	= BIT(18),
-	COMP_CH			= BIT(19),
-	COMP_RF			= BIT(20),
-	COMP_FIRMWARE		= BIT(21),
-	COMP_RESET		= BIT(23),
-	COMP_CMDPKT		= BIT(24),
-	COMP_SCAN		= BIT(25),
-	COMP_PS			= BIT(26),
-	COMP_DOWN		= BIT(27),
-	COMP_INTR		= BIT(28),
-	COMP_ERR		= BIT(31)
-};
-
-#endif
-- 
2.42.0

