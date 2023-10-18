Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684FF7CD337
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 06:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjJREqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 00:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJREqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 00:46:14 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D39C59E9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 21:46:12 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-27d3c886671so4199622a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 21:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697604372; x=1698209172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z0plYRgApYCDuFiFfuBG96gzOa5vfFs6SazUXLUEig0=;
        b=fh6JwCyq1yJ89yuwgBlixgi79ugd18Ez/hDpr2A7AAg+R6RucxzrMJwO5gwXreN2vG
         /x2pcGqHq4MtMekfpOiauh0pp+LA9wY19wk5/nK726cvu04ol7VZ+/BaGdYACIu+kSx8
         Yfz8xgr5hpxW9MJX0P3C0zbYKJE3yx0aE8PKuvN6cUl0KRO8mPcfdAkTBpvJiimQCHKW
         5P4CMebzbqsPMDLGnnmFRgbVnkm32U7UXs+v5ppegqomkh9cjolc8CXCboPXf/uA7ahu
         VK988XJnWiqL7UaQwTsIQAPSO6SNJd9MzJib0LWXyPdb8JayK5uovIa2M5FUrqtziRJ1
         AVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697604372; x=1698209172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0plYRgApYCDuFiFfuBG96gzOa5vfFs6SazUXLUEig0=;
        b=KCyGWH2TvYgQvZMnFErcIL/QjVKoV10PIEKtbsfFAs503iR+MuZLyDq6qncp9h3w9j
         lV8gLEnLoNMte7nVFT+hc57UvieLocv8TJk648+epGOEV+/JpJnrRtrO932+VnaZLdVR
         ApIYIataHNkEux3f3F8B3gv2dxK+sdSoXXQr4SrxSl65PncC1Fa0vDls31Xjh5NE2eck
         ZXhTvxo0vyFVbVwrvkiJ9o/RJwQk12Qo5BFx8LMJqFjxAJT3oGT+/zQYYA12SiNTx8V3
         l8Q21x5hAXmjsZICXM8vOiTndv+12Cx8vLmQlwkUrG3wjluJXdeMvCggslpFGOK/HpTL
         VrnQ==
X-Gm-Message-State: AOJu0YzIYBqRm7q03mBSYHj57hoI9DguoDSpiAdmf3ls5E473pz2L/LI
        Hv68djq1H/CeJqnSgMWqVXCYrrkHmARpzw==
X-Google-Smtp-Source: AGHT+IG5MMc2IDFm6/s5mb/T+WlATudIS8dQjYZ9X6U8jeZvpsuXVcSU0e1Wqfw387f1jRYxkxGFaw==
X-Received: by 2002:a17:90a:1910:b0:26b:4a9e:3c7e with SMTP id 16-20020a17090a191000b0026b4a9e3c7emr4380729pjg.4.1697604371635;
        Tue, 17 Oct 2023 21:46:11 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id a15-20020a17090a740f00b0027360359b70sm354997pjg.48.2023.10.17.21.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 21:46:11 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Jonathan Kim <jonathankim@gctsemi.com>,
        Dean ahn <deanahn@gctsemi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Soumya Negi <soumya.negi97@gmail.com>, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: gdm724x: Add blank line after declaration
Date:   Tue, 17 Oct 2023 21:46:07 -0700
Message-ID: <20231018044609.22616-1-soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix WARNING: Missing a blank line after declarations
Issue found by checkpatch.pl

Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
---
Changes in v2:
* Change "tty:" in patch subject to "staging:"

 drivers/staging/gdm724x/gdm_tty.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index 4e5cac76db58..0c61eaff6122 100644
--- a/drivers/staging/gdm724x/gdm_tty.c
+++ b/drivers/staging/gdm724x/gdm_tty.c
@@ -160,6 +160,7 @@ static ssize_t gdm_tty_write(struct tty_struct *tty, const u8 *buf, size_t len)
 
 	while (remain) {
 		size_t sending_len = min_t(size_t, MUX_TX_MAX_SIZE, remain);
+
 		gdm->tty_dev->send_func(gdm->tty_dev->priv_dev,
 					(void *)(buf + sent_len),
 					sending_len,
-- 
2.42.0

