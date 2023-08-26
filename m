Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C3A7892B4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 02:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjHZAXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 20:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjHZAXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 20:23:00 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB48AE79
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 17:22:57 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-76da0ed3b7aso80194085a.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 17:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693009376; x=1693614176;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5OOg8+maoDUe9q7mOudOl/p44V4LSOgvZCREz8VZty8=;
        b=iVXaew1tf0ApfM4nIuXHiCVbGuT7TvqLGv8qxhnZzkfXIAOizyGJJyVCEUwB4PMmVL
         0UK+IFdouET8Tg9mt8HwjSGkNoe0H8Wh2SzzwhI/MFdo99DP/9qTif/ES0GswK9witIf
         MOK1bbHep6uPUbq0SR8nr2MoUGL5A2eAZnOBOiHtNj2b2T6F067nDr+cALLtnKEmUPRG
         Gj3DXCR9PmySyY3f8K5PZjylHecxe7lPHFwjW2Ae8+S2lCcfndHAI6NaU3CZH5obQpnf
         KS9/lLQXH2dnBLrnYIWlqR8HTyJ6Q4b1/UVybSwRkgEyUQNDH+iVCY8suDU+2yHpsEd1
         EKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693009376; x=1693614176;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5OOg8+maoDUe9q7mOudOl/p44V4LSOgvZCREz8VZty8=;
        b=U5Wvuyf0sYw/Nuv++He6957MiedWjYpFRVmBVpwagcvNGfnNErPI20pqZrdnA5RDci
         oJkrCvWnap9O9/oX/RbXPq/2ubgvOm/iwiz+fAxWUYekWzYWGZeCK4eh9dyrEPaM6r6Y
         FUK6ppvQ6ppgmkUOR+xJLZ4L6vPJhZfrgheYt+JMvO2Mons5kr2sIwZBXFdy7Nf1pKx9
         IVHxjJ8V8sIpthMmwind/wRwS5i92my9hjtkgaMVp1cT1xaMBhPBS8hqqbxzPCd4oTT/
         h6ltqIc9Ru5/tuEJpiKI/5+nRuL+ZhOKFdG2jrdD2/9DP3M1gJpbsfEJTzGAR6fg8rRN
         8lIw==
X-Gm-Message-State: AOJu0Yy11+PQk6JJn1FiTmwBliz56BMfy2RkByCQyHvBmRxXQyOr9s18
        Uai63EODm+E8xtKsV4/a9Xo9wvCE0Ks=
X-Google-Smtp-Source: AGHT+IFLF4hJm3gn4k1ab4MFpGTxMhuzuE63NOvvcDuLSxNOKGOEpaPxxCo3ZrIkPUfks0lrTo6xQA==
X-Received: by 2002:a05:620a:a52:b0:76d:7102:28e8 with SMTP id j18-20020a05620a0a5200b0076d710228e8mr20877304qka.76.1693009375603;
        Fri, 25 Aug 2023 17:22:55 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:82ea:8c7c:b784:3f92:988a])
        by smtp.gmail.com with ESMTPSA id k9-20020a05620a142900b0076e672f535asm851849qkj.57.2023.08.25.17.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 17:22:55 -0700 (PDT)
Date:   Fri, 25 Aug 2023 21:22:50 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH] staging: vme_user: fix check unnecessary blank lines in
 vme_fake.c
Message-ID: <ZOlF2p7mjYomUWya@alolivei-thinkpadt480s.gru.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed all CHECK: Blank lines aren't necessary before a close brace '}'
as reported by checkpatch to adhere to the Linux kernel
coding-style guidelines.

Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
---
 drivers/staging/vme_user/vme_fake.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index dbaf050f88e5..4258ed6033e7 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -584,7 +584,6 @@ static ssize_t fake_master_read(struct vme_master_resource *image, void *buf,
 					aspace, cycle);
 			done += 1;
 		}
-
 	}
 
 	if ((dwidth == VME_D16) || (dwidth == VME_D32)) {
@@ -770,7 +769,6 @@ static ssize_t fake_master_write(struct vme_master_resource *image, void *buf,
 				       aspace, cycle);
 			done += 1;
 		}
-
 	}
 
 	if ((dwidth == VME_D16) || (dwidth == VME_D32)) {
-- 
2.41.0

