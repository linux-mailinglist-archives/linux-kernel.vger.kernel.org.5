Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7177F095D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 23:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjKSWP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 17:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjKSWPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 17:15:43 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA2FD60
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:15:30 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53e2308198dso917442a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700432129; x=1701036929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M96xGnsTaxvh/GugqakyW3PVEINvxqNUDY6nmJN518w=;
        b=KvJtx4svczW2gRlDGCGLtO59XJ+AYyxAlzBq5BQrX55RqY+s+681oCWV+6Fo29F8QT
         f7A5rfe/QkBJZfeA69eSnJhYtE8IK8Meso9BTv0WDiaiRkdrP3vk3OpmCB1M6QhgynKb
         5AaWe+v0jm1mouJ7sLd7bNPrC0+yAGH4NfnEiDItyu7ecvg3aMUyzjAi8E4I4k+2KYTw
         0+QEEytFdWfKl0NwRsn95+PCBBW1x02GjWYV07tWhiCP1pZ2kaSmbGz8emz74IjQqXkz
         Y5JWek4IqH4oNYcdsAg2IMRFf48z5MVpsY5Kj87Y+HOFeLhPStcSI+rwZPRi+qyTFNN6
         oAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700432129; x=1701036929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M96xGnsTaxvh/GugqakyW3PVEINvxqNUDY6nmJN518w=;
        b=ZyXt8gaj98yumRr+S1KaYsycNlQLmN4j3e89shFMOGRRe7Fi1/NmR5w96MQkVRBzRP
         LOxqubRYlj4eHXAINEsrMgix3EGQPC01oF1IU1uI3tPNz3YZkorcpjYZG4eOm9Pq4aH3
         alqs4kpiOZ1oGFV/ttdeR4aplaIS7y0P1L1w+XVcLRZWc0T4vLOYSL4273y93gfu3ju6
         cwjN/ff/fT3wFj1xRhLRRbCCgJ8HjaQ35X/5+GRptwna15UHtXmEQQNMU4n4HauYKDNn
         pM/Dm10AvGL27nYQwCxMdzC8K7pHS7yPnbhR3G5YfU2nUBadlD8gcHR3d33nmyfVQY11
         2aSA==
X-Gm-Message-State: AOJu0YzUlIN5weLsAkt0EAWrgopcZzTZiEYS0cdIplSRaQHFu2XjQY+J
        JBr907F5Xom+F36ODdyQQCo=
X-Google-Smtp-Source: AGHT+IGCqcpoqkPHVkbsl8wRZnw2336e7c4mDnffCQE0+l/HiMGDj1l+o6w5qI1dchl2sooI+rbIWA==
X-Received: by 2002:a17:906:5191:b0:9e6:69d:46aa with SMTP id y17-20020a170906519100b009e6069d46aamr4332001ejk.6.1700432128727;
        Sun, 19 Nov 2023 14:15:28 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id xa1-20020a170907b9c100b009fe3e9dee25sm523882ejc.61.2023.11.19.14.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 14:15:28 -0800 (PST)
Date:   Sun, 19 Nov 2023 23:15:26 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 09/14] staging: rtl8192e: Remove unused variables from struct
 rt_dot11d_info
Message-ID: <eeb9915d68c353554973e1056893371d15381f88.1700431464.git.philipp.g.hortmann@gmail.com>
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

Remove unused variables country_len, country_buffer, country_src_addr and
max_tx_power_list. Remove comments about usage as well.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/dot11d.c | 2 --
 drivers/staging/rtl8192e/dot11d.h | 9 +--------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/dot11d.c b/drivers/staging/rtl8192e/dot11d.c
index 08cf95d26911..b524ebe31869 100644
--- a/drivers/staging/rtl8192e/dot11d.c
+++ b/drivers/staging/rtl8192e/dot11d.c
@@ -18,9 +18,7 @@ void dot11d_init(struct rtllib_device *ieee)
 {
 	struct rt_dot11d_info *dot11d_info = GET_DOT11D_INFO(ieee);
 
-	dot11d_info->country_len = 0;
 	memset(dot11d_info->channel_map, 0, MAX_CHANNEL_NUMBER + 1);
-	memset(dot11d_info->max_tx_power_list, 0xFF, MAX_CHANNEL_NUMBER + 1);
 	RESET_CIE_WATCHDOG(ieee);
 }
 EXPORT_SYMBOL(dot11d_init);
diff --git a/drivers/staging/rtl8192e/dot11d.h b/drivers/staging/rtl8192e/dot11d.h
index c7d35ec86aae..64fd39cddc22 100644
--- a/drivers/staging/rtl8192e/dot11d.h
+++ b/drivers/staging/rtl8192e/dot11d.h
@@ -17,23 +17,16 @@ struct chnl_txpow_triple {
 };
 
 /**
- * struct rt_dot11d_info * @country_len: value greater than 0 if
- *		  @country_buffer contains valid country information element.
+ * struct rt_dot11d_info
  * @channel_map: holds channel values
  *		0 - invalid,
  *		1 - valid (active scan),
  *		2 - valid (passive scan)
- * @country_src_addr - Source AP of the country IE
  */
 
 struct rt_dot11d_info {
-	u16 country_len;
-	u8  country_buffer[MAX_IE_LEN];
-	u8  country_src_addr[6];
 	u8  country_watchdog;
-
 	u8  channel_map[MAX_CHANNEL_NUMBER + 1];
-	u8  max_tx_power_list[MAX_CHANNEL_NUMBER + 1];
 };
 
 #define GET_DOT11D_INFO(__ieee_dev)			\
-- 
2.42.0

