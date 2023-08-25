Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0798F788AE2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343575AbjHYOH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343513AbjHYOG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:06:58 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748D926AD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:33 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68a3082c771so734965b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692972379; x=1693577179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRPP7TQ9KfSawkNqM8uvBK91gxMIgkxn+DlDjJdQVs8=;
        b=M0dHbT4ffxh7h/+nBJRWUmR9zOdNMG0aqKSpypPyKDFy9YMuZ7F72PuwxclWYVg28g
         fL8UHBruubmlndOfGd/6LcjFKtBGCHi6Z7r+H8hFNTtA5PvAkjTXwahbgkb1aPji9UpY
         OEdkqK82U67b5n/kGyKQXLVJvEN2hvb3pFj9arFpaAAcGff8OxfL2j11Zvxp13J2/+nQ
         WKNFF4FSmBr5i1K7NAA12Cb+ED3HmFsLbINo4uggvWBSBZiy7+e1nzThR2RDzQCSX7VK
         ozBs8BFpHQLBxbxNnuCaOQSaAEE5bz6cln32zdKIxDaYr+Le8/LKSOVSJpIi1i4OdrQN
         tgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692972379; x=1693577179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRPP7TQ9KfSawkNqM8uvBK91gxMIgkxn+DlDjJdQVs8=;
        b=XMYCwjcA4y3ClmDWIlDHu2cnYj2u3ZHL4xLmf6GXKSdfTLPJeA+0MGAz+/e+UTLSO7
         J02JxyA8FTEUfVI+OnYm0zFYZV3E+Jrh+Z29h87V3xZiHIN6XNOvtTxLykYk7xpbIhyT
         RCRoI13v714E+uYZ2Wwwc1GUcx+kYUCEXZZaBMd5BT9YJZYOPVamiZQXiJWy8F5nb7o8
         weAY2V1se0+LlUjrniqXFf49+FSDdXboMEttvx+RY6zK3bQj2pM7bV+005UGz0HwxX3f
         +LIj+wbB6SRwZET/JABtWXMq9IRztwOwkNqoU3If6qDOzA5SgNMzfainHwOWSeIgpmrq
         Ayuw==
X-Gm-Message-State: AOJu0Yy4d6417q8lYI9NTgE4mNhtCoGgF0jTbuYkFUeeSdvCuS1YyWdy
        uzeUNaY+Wv4XfKNMncUaZNJgYA==
X-Google-Smtp-Source: AGHT+IGplBzchvbqmi/hMnA20xZfDwTwABqVEKfA+gaXK0j4yB7R7jeHWAAnpfGCzJHUMKH/z/+6FQ==
X-Received: by 2002:a05:6a20:1456:b0:13f:c159:63ec with SMTP id a22-20020a056a20145600b0013fc15963ecmr27546337pzi.24.1692972379208;
        Fri, 25 Aug 2023 07:06:19 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id v23-20020a62a517000000b006870721fcc5sm1628232pfm.175.2023.08.25.07.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 07:06:18 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v4 03/16] Staging: rtl8192e: Rename variable pRxTs in function rtllib_rx_DELBA()
Date:   Fri, 25 Aug 2023 07:08:34 -0700
Message-ID: <20230825140847.501113-4-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825140847.501113-1-tdavies@darkphysics.net>
References: <20230825140847.501113-1-tdavies@darkphysics.net>
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

Rename variable pRxTs in function rtllib_rx_DELBA() to ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
v4:Resending as v4
v3:Resend as 16 patch series - no longer throttled by email provider
v2:Resending in smaller patch series
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 03d76765e85f..c584e9ec48b6 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -430,9 +430,9 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 	pDelBaParamSet = (union delba_param_set *)&delba->payload[2];
 
 	if (pDelBaParamSet->field.initiator == 1) {
-		struct rx_ts_record *pRxTs;
+		struct rx_ts_record *ts;
 
-		if (!GetTs(ieee, (struct ts_common_info **)&pRxTs, dst,
+		if (!GetTs(ieee, (struct ts_common_info **)&ts, dst,
 			   (u8)pDelBaParamSet->field.tid, RX_DIR, false)) {
 			netdev_warn(ieee->dev,
 				    "%s(): can't get TS for RXTS. dst:%pM TID:%d\n",
@@ -441,7 +441,7 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 			return -1;
 		}
 
-		rx_ts_delete_ba(ieee, pRxTs);
+		rx_ts_delete_ba(ieee, ts);
 	} else {
 		struct tx_ts_record *pTxTs;
 
-- 
2.41.0

