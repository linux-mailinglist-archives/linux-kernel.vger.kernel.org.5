Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE13A781BE0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 03:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjHTA6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjHTA6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:58:05 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450407D803
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 17:45:25 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-410487ca3d6so15260231cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 17:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692492324; x=1693097124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LjrlfpbfTpftGZcF5StkTdptZ9z68CeCu6EmjZizZM=;
        b=K8DZSeZkpZ1p7FOiMND2Zva+xw0J4ttBgmbng0+qXHPA2f3MEDMVgGUlWFMAbiOBQq
         e026tqSqu0pyBMiRQDdCyABSLr83SyKyOcyBEN3lr8rU7D/b2RpnwRS/5DfQzAdcwD14
         /3J1MrH8M07O5fygwjNnLDimz6iRaQE4FFMDDOCcTYpbvZ+2/6ith7q8qIsOGDaZr73K
         tIiI/17QYsJfDbzSzrfp37geRpLiigSlpFhJgzF6Thc3mTpZVmda+KP2oubcN7OEMot/
         kqNGXyprzP/AqkYj9foyoQDUT60lyk1Ms2lWViJ8KVxY3bbtWCbU4fIcT6hCPFsLdRDy
         ybHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692492324; x=1693097124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LjrlfpbfTpftGZcF5StkTdptZ9z68CeCu6EmjZizZM=;
        b=hnd8tFxZJnv1LIjFXfUJ1cFeAn8wclWtUK0GJKjBBEEswmSUnQdOm2fM/isVxNBgyJ
         csenR2ZaJ6nX6883hgdBMEWxsiNf2u0AIaIGYTmPAAlsBgRUoEyEAYiTMlMeN2KtGAOW
         n/HbnpV5+oJHNH5JNY9/9n6KhXHi+VpdeV4PqFpVdqGfVFcYAVO8IM/TETHOsK3siMrs
         bZaZuRc1tVMnIzP0Xp0gz0VaVdtxhqOeLoc7CdGtfeXK6Fz6yDEesdxy5PTUzP0oRjEX
         h4VSc1l0mPEiD3MKcy/5OOnk2eAv0UuQ6bwAPU8zU677IgXJRHta7pPvJpdn1iFGDGCF
         IzNw==
X-Gm-Message-State: AOJu0YwLTwxqAfsKRH0vboCARV7cLPUuyx4l9yD6glAlUgeF4A2hf1rE
        GXpOcUvVfYVOnSzrNo2NpXDX8x3ELYXaBjEQjdwhXNkN
X-Google-Smtp-Source: AGHT+IGd8yrFtbZdtxSLHzY7AXTZ3j5s/h8OTlruqiWp4XBbLCJcw9jADxu1nn/f/Ygoa5uyqoAKog==
X-Received: by 2002:a05:622a:13cc:b0:407:fb08:c44c with SMTP id p12-20020a05622a13cc00b00407fb08c44cmr3148730qtk.47.1692492324417;
        Sat, 19 Aug 2023 17:45:24 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a1a1900b00268b439a0cbsm4004884pjk.23.2023.08.19.17.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 17:45:24 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 07/16] Staging: rtl8192e: Rename variable pTS in function ResetRxTsEntry()
Date:   Sat, 19 Aug 2023 17:47:35 -0700
Message-ID: <20230820004744.278022-8-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230820004744.278022-1-tdavies@darkphysics.net>
References: <20230820004744.278022-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable pTS in function ResetRxTsEntry() to ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2:Resend as 16 patch series - no longer throttled by email provider
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 75bf59d267c2..c892fe044f29 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -112,12 +112,12 @@ static void ResetTxTsEntry(struct tx_ts_record *pTS)
 	rtllib_reset_ba_entry(&pTS->TxPendingBARecord);
 }
 
-static void ResetRxTsEntry(struct rx_ts_record *pTS)
+static void ResetRxTsEntry(struct rx_ts_record *ts)
 {
-	ResetTsCommonInfo(&pTS->ts_common_info);
-	pTS->rx_indicate_seq = 0xffff;
-	pTS->rx_timeout_indicate_seq = 0xffff;
-	rtllib_reset_ba_entry(&pTS->rx_admitted_ba_record);
+	ResetTsCommonInfo(&ts->ts_common_info);
+	ts->rx_indicate_seq = 0xffff;
+	ts->rx_timeout_indicate_seq = 0xffff;
+	rtllib_reset_ba_entry(&ts->rx_admitted_ba_record);
 }
 
 void TSInitialize(struct rtllib_device *ieee)
-- 
2.41.0

