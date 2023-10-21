Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582C87D1CA7
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 13:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjJULCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 07:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJULCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 07:02:02 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38C499;
        Sat, 21 Oct 2023 04:01:58 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-5079c846dcfso2120043e87.2;
        Sat, 21 Oct 2023 04:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697886117; x=1698490917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W9Daja05OoueSFXSKgaA2RDObCdOKO/kxeq5hi1gOh8=;
        b=YIDSBn/YkwsFzD5tteiV4U2XRkvJPAzXvfCYyi4qlPEBsbinaQex6Vw4aDjbPnVXT4
         89fJsQNlGzzKW7h66hzCD9W1SVy9Snmr5zgvNzHTkkSWOgjxcEhXWDFxZFEb23fw+dAx
         OCW3Mpy5BqvJnzXU1OiTYvPJ5blstAz83wqjWTvoV4I8BN3uH3xigraZ34dk5SRjaH/5
         U4AeuNeh2ZOfo0X7eXY/VXmZaZGVVykA/xT3JmIOrG416IGQtfUfKSbVoTpkLx8wKEYJ
         cBHEhBmemplhlA/+Xihv4zaVQTuir1PqKtX8iKCgmw8X0xfT8D3wTbKF/M1rcScYYuLs
         cmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697886117; x=1698490917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W9Daja05OoueSFXSKgaA2RDObCdOKO/kxeq5hi1gOh8=;
        b=q27K64B9XmlN7UmGeSKt/PYRJcU0zxMadcge5ouVNYn2Nfoi5/L1cPA8uS7ZnwBni8
         qwp4KGZPaj5tc6uYK9lNisOXMbV7tV/X2LTGQ0cJs2DR/uCRQ+tw6K4aXQniyGBHbQ2k
         XuoRr3Iczxbaq7wY/dWOdyISi7JW2TTutWcEiAfHMVc9ioumlxwtKr34BTT+3ABypolQ
         cZD+hHBMuuMsRITjV/Gt6j3j+BVJKsgi0jMeVduUWvvzzftCtBIlWQz34nvKbaMVv/Vx
         aPJvtAqd04KiR/VvsnOBxF8CDMI41Jo2UfdgvAvhEgB1qFSHjCUM9/YhjRbMtDp7od4M
         bD1A==
X-Gm-Message-State: AOJu0Yz4N1yy9SA62TknVW5MPpiqSv+f5HCSbpVjMzlTSTEz1niQF1YM
        JQS1va2TnJkbhPCBzBr5LrQ=
X-Google-Smtp-Source: AGHT+IET6GR096PesPzyE5eDNenDTy1DQT520jQB2nzok6qX9/hVkjPzoVQMCDyBq6FyaMqazRXmYw==
X-Received: by 2002:a05:6512:1382:b0:507:a1dd:5a86 with SMTP id fc2-20020a056512138200b00507a1dd5a86mr3372712lfb.13.1697886116897;
        Sat, 21 Oct 2023 04:01:56 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id o13-20020ac24bcd000000b00507a622184dsm823093lfq.173.2023.10.21.04.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 04:01:56 -0700 (PDT)
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     hdegoede@redhat.com, gregkh@linuxfoundation.org
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH RESEND] staging: media: atomisp: Removed duplicate comment and fixed comment format
Date:   Sat, 21 Oct 2023 13:00:58 +0200
Message-Id: <20231021110058.85013-1-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed the following issues:
 * Removed a duplicate comment
 * Fixed up minor comment format issue

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/media/atomisp/i2c/gc2235.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/media/atomisp/i2c/gc2235.h b/drivers/staging/media/atomisp/i2c/gc2235.h
index 55ea422291ba..ade28950db73 100644
--- a/drivers/staging/media/atomisp/i2c/gc2235.h
+++ b/drivers/staging/media/atomisp/i2c/gc2235.h
@@ -74,9 +74,6 @@
 #define GC2235_COARSE_INTG_TIME_MIN 1
 #define GC2235_COARSE_INTG_TIME_MAX_MARGIN 6
 
-/*
- * GC2235 System control registers
- */
 /*
  * GC2235 System control registers
  */
@@ -167,7 +164,7 @@ enum gc2235_tok_type {
 	GC2235_TOK_MASK = 0xfff0
 };
 
-/**
+/*
  * struct gc2235_reg - MI sensor  register format
  * @type: type of the register
  * @reg: 8-bit offset to register
-- 
2.34.1

