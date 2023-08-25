Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7647E788AE7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343657AbjHYOHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243965AbjHYOG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:06:59 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEDA2680
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:33 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68c3b9f85b7so17214b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692972380; x=1693577180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuqWDfbkk1jArp3egowQBA6Br3DIlZvf5v8+1xse7q8=;
        b=Sprh4DX7bg6D1HVSkBfwA5ZnoMtTEsiW+BkhKjbK8IFFgAwlgM9dxNjflsmvGuN2IX
         LMSaIxPN+/Mn5LYk5ttBW1iDB7oRmKi+CkkR8RnX4DOgEKtw2p/W6hEVQL9+nbJITqy8
         0RgcEsr0oo4vJ3nAujWu7SGGkOAbvybs0i9diIwANGkmOLsKXfjryo4+7J+t97alvUs5
         /c6H+3eLRfsF4ft36RGBgdUmGBEC0tF5ixzPt2940KzuVz43oPEFY5vh59iNVTMeIpjK
         lBMaSXg0eow24thG7nUoigX1NApLpWJwFjT3VZ9UH+jXJV3/OP/yudm1W2lZJjCytsSV
         bMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692972380; x=1693577180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuqWDfbkk1jArp3egowQBA6Br3DIlZvf5v8+1xse7q8=;
        b=iw27xaXLfBE3ZJute0stEYDoSSVosY+NASpDomZcIzbFDq7/zOvHmexJ+uVC3bFTVU
         +Dc5aFoS4jLTPY69/FS9/0GugBBXgk2M/y6Nqw/g7vdY9Zb52VL0Kvw6pzxds36tmuqz
         iKdLTVm6XdzIyoQ9dqkA5CQguKWcB+z9oW/Cv7ldkign/bBfuScI+xpUQE72ATr8p4gJ
         T4iRCiKgOfaPKgz1tk2yZsDua1zyRnbcbwwYJA3B9PYgSBm+G164itkM3du/bk3+FCtE
         Fpwg0vkszpnTrO441FxmL/SMP2vfQaF8m1Nn4bmocBmq1/EhShVAo1LuMkvw8rruPyYq
         9x2w==
X-Gm-Message-State: AOJu0YzWflBWZ8JS/zM8ji2InIOPGslFqUODPxsW5bqR7At5nBbcnucN
        cLFrkr/tRO4a0IZc3CBUpMeRSw==
X-Google-Smtp-Source: AGHT+IGWz7urlOlDuqNC9Yba0/RyUDSNpdxDqxn6voytQ5ZyXHHehEW6SCzaaad+Hq03/RlWgGKVfA==
X-Received: by 2002:a05:6a00:124c:b0:68b:e321:285e with SMTP id u12-20020a056a00124c00b0068be321285emr6601605pfi.15.1692972380157;
        Fri, 25 Aug 2023 07:06:20 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id v23-20020a62a517000000b006870721fcc5sm1628232pfm.175.2023.08.25.07.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 07:06:19 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v4 04/16] Staging: rtl8192e: Rename variable pRxTs in function rtllib_ts_init_del_ba()
Date:   Fri, 25 Aug 2023 07:08:35 -0700
Message-ID: <20230825140847.501113-5-tdavies@darkphysics.net>
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

Rename variable pRxTs in function rtllib_ts_init_del_ba() to ts
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
index c584e9ec48b6..2aa624bcbfd1 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -499,11 +499,11 @@ void rtllib_ts_init_del_ba(struct rtllib_device *ieee,
 					(&pTxTs->TxPendingBARecord),
 					 TxRxSelect, DELBA_REASON_END_BA);
 	} else if (TxRxSelect == RX_DIR) {
-		struct rx_ts_record *pRxTs =
+		struct rx_ts_record *ts =
 				 (struct rx_ts_record *)pTsCommonInfo;
-		if (rx_ts_delete_ba(ieee, pRxTs))
+		if (rx_ts_delete_ba(ieee, ts))
 			rtllib_send_DELBA(ieee, pTsCommonInfo->Addr,
-					  &pRxTs->rx_admitted_ba_record,
+					  &ts->rx_admitted_ba_record,
 					  TxRxSelect, DELBA_REASON_END_BA);
 	}
 }
-- 
2.41.0

