Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD48781BE2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 03:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjHTA6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjHTA6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:58:05 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419627C9FF
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 17:45:23 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2685bcd046eso1183861a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 17:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692492322; x=1693097122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbcFNW0BUC/zpWNLlWYI8k63oVquqAWvkdReaUZSuGI=;
        b=bNjB0cfZYCXhEY7OmJ3sdza6OGLKW1KL1jjyMBsP9QTIz15gPoC2h/tEvp+PfwH57i
         V8D1fEUhywM/NJMMjMdBTwzdVk8dkdoU+ujfAW6U8hk6Rn6z+yuemkRZF88lh7ywisg/
         oOcyoL4oHzX5k5j4fXxuKmjJ+U3q4A4hlK9lIi/a0iBOz2cZdRiO/6ntUF1sThZZoTGc
         zgqoQryngFcjGugUZZx8jajcGElAhaLkERi5JCRwytZHCvWDTe4HizdVHLKtz4eOKt7+
         T9FikaXXts5JxOdgaY8I76atlR128GkhnbVo7H/NGxcd+aSQZLgiQrUlZxwEPyBrSXP0
         Kb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692492322; x=1693097122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbcFNW0BUC/zpWNLlWYI8k63oVquqAWvkdReaUZSuGI=;
        b=XPfrxAtCYq0/+xnTvlsJsBeZfgGDZxmrLxA5a3R45IbTQdbOCxNtPcxLVxh0mOoBe9
         GOHo+lLn9eqyqoxklvimE3sQP6RO//rL0Q4lRu93f8p27NdnPU+BLT/NJHVgpafNTXd7
         X5L93+MNIVlLfUlNVsXRZuResvvxSBI620DIGQH1MWqx8MhTheKJ+vnfUHcFkXPJTzgF
         ylq1DxCORR8ABzAqtW8PhlLsfWa1vhUXlXSSVk97WhifpXDiiYEfcLvZAQrvB9kVYAaE
         nHTMzHxrnp4rLvdAuhvyF8D1HuaTASfkSZExxpOjcK8l6tpg2M6pcDL9jX0XgE8yOnwt
         ORWQ==
X-Gm-Message-State: AOJu0YzSWMkXhvBN7XP+aXVbGVTVZYVPKRmHjNaxmiosYO+slQCZSIpX
        nnRUXRa5Rp/EI5Q4VvCuD7fPMw==
X-Google-Smtp-Source: AGHT+IEfZe+qfAxhdSXOQwOGeaumbxBXE/LXnlt3hImQYRepy/BjDaazhz+yYbS4H9KIo1i1WCa9UQ==
X-Received: by 2002:a17:90a:6282:b0:268:5c3c:866f with SMTP id d2-20020a17090a628200b002685c3c866fmr1785727pjj.46.1692492322720;
        Sat, 19 Aug 2023 17:45:22 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a1a1900b00268b439a0cbsm4004884pjk.23.2023.08.19.17.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 17:45:22 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v3 05/16] Staging: rtl8192e: Rename variable pRxTs in function rtllib_rx_ba_inact_timeout()
Date:   Sat, 19 Aug 2023 17:47:33 -0700
Message-ID: <20230820004744.278022-6-tdavies@darkphysics.net>
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

Rename varialbe pRxTs in function rtllib_rx_ba_inact_timeout() to ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v3:Resend as 16 patch series - no longer throttled by email provider
v2:Resending in smaller patch series
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 2aa624bcbfd1..bc6f9e8c5dd8 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -532,13 +532,13 @@ void rtllib_tx_ba_inact_timeout(struct timer_list *t)
 
 void rtllib_rx_ba_inact_timeout(struct timer_list *t)
 {
-	struct rx_ts_record *pRxTs = from_timer(pRxTs, t,
+	struct rx_ts_record *ts = from_timer(ts, t,
 					      rx_admitted_ba_record.timer);
-	struct rtllib_device *ieee = container_of(pRxTs, struct rtllib_device,
-				     RxTsRecord[pRxTs->num]);
+	struct rtllib_device *ieee = container_of(ts, struct rtllib_device,
+				     RxTsRecord[ts->num]);
 
-	rx_ts_delete_ba(ieee, pRxTs);
-	rtllib_send_DELBA(ieee, pRxTs->ts_common_info.Addr,
-			  &pRxTs->rx_admitted_ba_record, RX_DIR,
+	rx_ts_delete_ba(ieee, ts);
+	rtllib_send_DELBA(ieee, ts->ts_common_info.Addr,
+			  &ts->rx_admitted_ba_record, RX_DIR,
 			  DELBA_REASON_TIMEOUT);
 }
-- 
2.41.0

