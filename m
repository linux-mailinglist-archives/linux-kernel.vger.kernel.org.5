Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C2F80BCBF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 20:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjLJThN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 14:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJThG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 14:37:06 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B902BE7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 11:37:12 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d04c097e34so28374525ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 11:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1702237032; x=1702841832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wj8Hd4lGCgripGvVsJUh/sN5wUyBalDJjlWk5HNgirc=;
        b=Iy4Vf1vkrz83JZtf4NBAHAWqGmq5yGbs2JIoSBeH0vwx2X7Xeh/fRm+vF96Ekfpu+e
         Zhq7mXNNXxhunZs0mJc/itI6tM+B+XHlTCdCL7Df8V6jGJ5zBXUqt1fcBnAYQyNqxl5e
         Zd3ZjHwCIu6FeH/Ewla2n8azet/Db4ChXhmxIwfr1P0eEU4pa+vkB6rGhUF2U2+2ZEMy
         hYOluTQC9kjSjYuBmssMpQD27HHmcqYsOXAjjIxSM6X7yz1prhXg+xuRljcWUDiDFw51
         dCv36muIVXlICHbTYvPQkypzSDitXy3jWAARoo6vAM3YI46ZdvU4l9EdODZb/JYSVndc
         HqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702237032; x=1702841832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wj8Hd4lGCgripGvVsJUh/sN5wUyBalDJjlWk5HNgirc=;
        b=gQZy6OEvujgr4StIdSGXinWIBIzZfNea0uYqEyQ/gfEUhILPEGcQOlOn6aTus81Sdd
         kWvhj++2J7LyWi1BXrK3HOsKYhRRSR51IOTr3PaBYE02LPKWUAICR+SLD/h2WtvzKz88
         E6ana+RB7+90TPXOIAlTd/53Cws6SbDg9ru2tkhBiESU7CsFBN19j680jgICgnKRknqP
         kyDFdiW9KHPi/UVsHV3LLKqr7QnUjrsDwBShG3GW+OS8V6dCRnCbzzCdAtVw7kDUtSKp
         7f8buP3dwCy4zSZDrEArXKAuxnvoshRdWbpNSpO3R85xPWGq0SxxunpFo1vysOqOqTeN
         gnfw==
X-Gm-Message-State: AOJu0YwKu7n7OpTcfXGY07o/GSix7Z+TBxcROYTyvtqXEaCwLfNCR/Q4
        4NozxPYCwtOpvsZx+QfbaeiC/A==
X-Google-Smtp-Source: AGHT+IEOmedNGJhoLZQdFfmyi211smkBgEiDDRbyF2scO0icDkWVNTqrFlrBkNxibm2I3D1d91Yw1g==
X-Received: by 2002:a17:902:d490:b0:1d1:d30a:17ba with SMTP id c16-20020a170902d49000b001d1d30a17bamr4370107plg.36.1702237032255;
        Sun, 10 Dec 2023 11:37:12 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902c40900b001b9e9edbf43sm5117419plk.171.2023.12.10.11.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 11:37:11 -0800 (PST)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 3/4] Staging: rtl8192e: Remove variable bEncrypt
Date:   Sun, 10 Dec 2023 11:37:04 -0800
Message-Id: <20231210193705.2131807-4-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231210193705.2131807-1-tdavies@darkphysics.net>
References: <20231210193705.2131807-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove variable bEncrypt as it is defined but never used.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index fb399acb7157..224774b1ba31 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -103,7 +103,6 @@ struct cb_desc {
 	/* Tx Desc Related flags (8-9) */
 	u8 bLastIniPkt:1;
 	u8 bCmdOrInit:1;
-	u8 bEncrypt:1;
 	u8 tx_dis_rate_fallback:1;
 	u8 tx_use_drv_assinged_rate:1;
 	u8 bHwSec:1;
-- 
2.39.2

