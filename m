Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F66E781BDB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 03:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjHTA6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjHTA6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:58:03 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434507C9F3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 17:45:22 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso1595343a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 17:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692492321; x=1693097121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omkWyR4xIKDeiUIHgBXUEIHWvvX1GVtW/wpsSw0X3Og=;
        b=jAZL4vLogMuyo6I2DmdYidBZVvrPJs0328rHjlEWaqYOhFy4NPpdy+Ep/CVCRp2XVf
         zO+x7l8s4mFpjsuc2P01++QQ/wLcfl8stKpQ5oTXp2mzu6a0qEJCThnvQVja2/I21pTG
         bMXARE/Gj37qimwUNnYZIEt4oETn13/CZUnIeFoHgmsXWpdBiTVuEFOjcG/ynjS5TkTc
         +90ZfZJ1Ex+oYiYrzEvJdXMcYKh0WhF39zsQ6vj5eMZJcxn2aB5FkzWV49C3iPz/KHWJ
         gtRagnL9uEAs21MfJ4i0y2DRerSURBC/phi2/29XSRQMGsRoJgY0FH1oXE9KryvJ0USb
         LaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692492321; x=1693097121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omkWyR4xIKDeiUIHgBXUEIHWvvX1GVtW/wpsSw0X3Og=;
        b=BDwVY3gOTpj28DvlD/n8xq9WT3Xrsv3+HjIp3rFFcDPH8JVl/ld65BxTibrTkGVPEP
         H+8GnvO+GFWOL3sg0hbSZOhTZrGpVKAIqPBnCdSnF/2OFldX2FJ0/LT9HPgnnTkyQa0K
         b/DDI0qqdrzdj4EysYPhH66s+4bqnjr/fVObsw0ai0le9aVIuz9YJg1ksnlpv6oqSzFn
         cgaryvupNmfG4n2B2GBgpAvmvTNaEQX4GcJHqo/r82A8Tkgw+XRHEl9kI8u/YAcyFBrH
         Y9OUxEDulwrs19yDVSz73qyuPr/U85MtFxA8ZZANRmqt7D53q1Nf4QZXvFrvyaW+72Vn
         8ahw==
X-Gm-Message-State: AOJu0YxwK5PIZuPjbhueWql4L/Yn/o/BJbyC/iT4xFCO8f4bgkfx3fDI
        15tR1bL+KKNoelecAC9ahMh42g==
X-Google-Smtp-Source: AGHT+IFNjKz6Ddyj1m7sOsb3A96bX7j+amzrtBbhni/k5+OSCW3aN/0EMl8Urq67u7Kh3WN7QjNc6g==
X-Received: by 2002:a17:90a:e28d:b0:26d:43f0:7ce4 with SMTP id d13-20020a17090ae28d00b0026d43f07ce4mr2733062pjz.8.1692492321677;
        Sat, 19 Aug 2023 17:45:21 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a1a1900b00268b439a0cbsm4004884pjk.23.2023.08.19.17.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 17:45:21 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v3 04/16] Staging: rtl8192e: Rename variable pRxTs in function rtllib_ts_init_del_ba()
Date:   Sat, 19 Aug 2023 17:47:32 -0700
Message-ID: <20230820004744.278022-5-tdavies@darkphysics.net>
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

Rename variable pRxTs in function rtllib_ts_init_del_ba() to ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
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

