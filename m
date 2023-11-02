Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63767DF144
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjKBLjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKBLjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:39:32 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E4E130;
        Thu,  2 Nov 2023 04:39:29 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507a55302e0so1024208e87.0;
        Thu, 02 Nov 2023 04:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698925168; x=1699529968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pFAkU6GcGXUSqClGaG/Aj9mW9sz3PJshV1+U1L2egZM=;
        b=m7fXcSrC92SU9wfOQ8g0OCwFTCsXaluHI4CF39hHkcNSiqdHJof9Qm3B0lT4KhhFJv
         02L2RNGJLc9IuY+tFpVODfwbjvDvtxj/2FcxBfkyi03JI9oSMcg4FZSm531wANPdl28s
         OVcH5JbVxBmtzgmWHPz0/xTf1+LAflAHH+FlW1Phm+u1qIXh4zOq8H4qXhU2Orxud7ju
         00MOGEkOJOryWGHfh1YABGEXR9LdyVmbGsmjcwBTRoxQOknoFkucrm1s1dN+bg8b8Ob9
         fB4Ru2XBsRRvoVlOGJVpEDXwdebiW1zB//8PY5MFS2rRHCZRnjbrmD4CvdkTKnhBqG/e
         XxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698925168; x=1699529968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pFAkU6GcGXUSqClGaG/Aj9mW9sz3PJshV1+U1L2egZM=;
        b=JIpiVYDbVp16bhPClb+GfGBbNXif3F07LRHd5tkbC45YHTQuUyd1Kfgt9qyvzoxdov
         mg52dmvpPVsLGHhMUG7M/Itf9R4s5iBQ1EKxZ+Tkov5CMLgA93etXeNvOekBbX27ZxO/
         xQQzSQIL+aKUU7kwPEieCP0N2DiDVHiePefspvRmmuqueJotKIcjscFUpXqlELgMh53Y
         kxb2xA78+zJAA0HPKaQ7uS4XDoXem+5TP9AzuQQQkoV+tdKxb/Yld6N4J63IW3ydgj2/
         9CmSbOa+J+kOFFjimZWIzwSx7lQSfD31YYZGYMOlTOUc4k/9Mhr7dHCOAX8z8XrpCNGw
         yFOg==
X-Gm-Message-State: AOJu0YwN4B4nbEA34gqnWE6tgcxwLc6IRqYf3f2KQOlwN70K0eQJOhoH
        jiAxnbwEST2l/wecy8kpic8=
X-Google-Smtp-Source: AGHT+IEJc6VIAMYI45bW308VbYVXQjoxmI9eD46JPlsWaYNhKmPbYpAIt3cwQRbMpshNHbec3Dx5Vg==
X-Received: by 2002:ac2:5f6d:0:b0:506:899d:1989 with SMTP id c13-20020ac25f6d000000b00506899d1989mr11529967lfc.44.1698925167443;
        Thu, 02 Nov 2023 04:39:27 -0700 (PDT)
Received: from archlinux.. ([88.127.172.169])
        by smtp.gmail.com with ESMTPSA id i16-20020adfb650000000b003200c918c81sm386934wre.112.2023.11.02.04.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 04:39:27 -0700 (PDT)
From:   dimadrumspro@gmail.com
To:     dimadrumspro@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH 2/2] drivers: tty: vt: vt.c: fixed segmentation fault in vt.c
Date:   Thu,  2 Nov 2023 12:39:26 +0100
Message-ID: <20231102113926.2019-1-dimadrumspro@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dima <dimadrumspro@gmail.com>

The previous code lacked proper synchronization, leading to potential data corruption and crashes. Added a spin lock to protect shared variable 'scrollback_delta' to prevent concurrent access.

Signed-off-by: Dima <dimadrumspro@gmail.com>
---
 drivers/tty/vt/vt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 5c47f77804f0..29cf7fe11662 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -301,12 +301,13 @@ static inline unsigned short *screenpos(const struct vc_data *vc, int offset,
 }
 
 /* Called  from the keyboard irq path.. */
+static DEFINE_SPINLOCK(scrolldelta_lock);
+
 static inline void scrolldelta(int lines)
 {
-	/* FIXME */
-	/* scrolldelta needs some kind of consistency lock, but the BKL was
-	   and still is not protecting versus the scheduled back end */
+	spin_lock(&scrolldelta_lock);
 	scrollback_delta += lines;
+	spin_unlock(&scrolldelta_lock);
 	schedule_console_callback();
 }
 
-- 
2.42.0

