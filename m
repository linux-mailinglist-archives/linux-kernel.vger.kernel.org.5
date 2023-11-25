Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F43C7F8974
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 10:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjKYJDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 04:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjKYJDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 04:03:02 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BD518B;
        Sat, 25 Nov 2023 01:03:07 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc9b626a96so19513105ad.2;
        Sat, 25 Nov 2023 01:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700902987; x=1701507787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lO9T1f7+xQGxacGqr4UGfolgAcK+nTqINcLwMQXMAsg=;
        b=cuSaSWpYZKDgP5OZznBQC+hhG5HpKPrbP5shtmLwgz5AMkLuF6ouFTwNuBLxkgr69r
         lZEu4ScQ+Oyko6jH+WHOr3DBSRVrHbAxOOElT98QCMV8Y8BDmdo2vBeB8jL2quclGMtw
         WYdP3+syqXKG0GgmhCvn6Apts4Y3mb+MYileTT2JiLvc0L5JTpaeTEvi6ajYlPfi0c2M
         ycH6T2ZBPtgL2PiZbvXNFElLUQ41Jldr/ttTdYBpeFD+2oDW/npnIe3dRt7Eupy2NQVv
         ln208jFf9fFoEVdNsRgUxO70reY0J1Qq6ApE629KD3qbyZALate/3Ix66wN0MDhSJ1M4
         KDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700902987; x=1701507787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lO9T1f7+xQGxacGqr4UGfolgAcK+nTqINcLwMQXMAsg=;
        b=bpbXgo3tw/NoHQbSKT2qtiTTSUvwGrOP0or+mW7jRRbkikSGtUxq6UlIKCoucHIHCM
         CmcfluoS8IsId5TdJ/8f9V5Xz7jN2io14dlFtEld43piNnZtVn4r5Nntu+aB6/FNMlkX
         lOL+Vum+DduRVKgie0FK4bRep4g7Cdm9mhswL4OBybuXs3vrAXQFFByXno35Dy1H9YvP
         1QTaApPIJYVY5X6hCj7+Mkyz+b9JOoZ+FXVUw9mF+uWG2SPrKPcw3nFbVNFvgaTtn5pv
         VBHwsEJLrxrBnv0PXR0XOpqdj1b+Lv9+G0J3shSr2uWi9udyP9YiHvThWnmJGMPbSwOM
         NV8A==
X-Gm-Message-State: AOJu0Yw/QAlyDmjdSTRReziH6+GvWfWXaPId3K2ziuPSWYnGWqrgugOZ
        x1eCvNFEVVYXdtMUVAqYN98=
X-Google-Smtp-Source: AGHT+IHzHe+EX24z8BHIjaM3k4H/XwNhsDntn0KLOhQQwYivmHfHFxBAmxTh6FhgpXNa1WfjFYXxJQ==
X-Received: by 2002:a05:6a20:6a22:b0:18c:346c:d59f with SMTP id p34-20020a056a206a2200b0018c346cd59fmr1985559pzk.62.1700902986672;
        Sat, 25 Nov 2023 01:03:06 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:716a:b035:7b6d:4b79:e0d7:1a84])
        by smtp.gmail.com with ESMTPSA id o10-20020a17090a3d4a00b0027dafa55306sm4511646pjf.40.2023.11.25.01.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 01:03:06 -0800 (PST)
From:   Ghanshyam Agrawal <ghanshyam1898@gmail.com>
To:     ezequiel@vanguardiasur.com.ar, mchehab@kernel.org
Cc:     Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Phillip Potter <phil@philpotter.co.uk>
Subject: [PATCH V4] media: stk1160: Fixed high volume of stk1160_dbg messages
Date:   Sat, 25 Nov 2023 14:32:36 +0530
Message-Id: <20231125090236.654605-1-ghanshyam1898@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function stk1160_dbg gets called too many times, which causes
the output to get flooded with messages. Since stk1160_dbg uses
printk, it is now replaced with printk_ratelimited.

Suggested-by: Phillip Potter <phil@philpotter.co.uk>
Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
---
V4:
Updated printk_ratelimited to KERN_DEBUG level instead of
KERN_WARNING level since the original function in use,
stk1160_dbg, uses KERN_DEBUG level.

V3:
Fixed the issue with my patch needing previous versions being applied
first.

Used printk_ratelimited instead of dev_warn_ratelimited because
of compiler error "incompatible pointer type".

V2:
To add KERN_WARNING in printk_ratelimited, and later as per warning by
the checkpatch script, replaced  printk_ratelimited with
dev_warn_ratelimited.

V1:
The function stk1160_dbg gets called too many times, which causes
the output to get flooded with messages. Since stk1160_dbg uses
printk, it is now replaced with dev_warn_ratelimited.

 drivers/media/usb/stk1160/stk1160-video.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/stk1160/stk1160-video.c b/drivers/media/usb/stk1160/stk1160-video.c
index 4e966f6bf608..366f0e4a5dc0 100644
--- a/drivers/media/usb/stk1160/stk1160-video.c
+++ b/drivers/media/usb/stk1160/stk1160-video.c
@@ -107,8 +107,7 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
 
 	/*
 	 * TODO: These stk1160_dbg are very spammy!
-	 * We should 1) check why we are getting them
-	 * and 2) add ratelimit.
+	 * We should check why we are getting them.
 	 *
 	 * UPDATE: One of the reasons (the only one?) for getting these
 	 * is incorrect standard (mismatch between expected and configured).
@@ -151,7 +150,7 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
 
 	/* Let the bug hunt begin! sanity checks! */
 	if (lencopy < 0) {
-		stk1160_dbg("copy skipped: negative lencopy\n");
+		printk_ratelimited(KERN_DEBUG "copy skipped: negative lencopy\n");
 		return;
 	}
 
-- 
2.25.1

