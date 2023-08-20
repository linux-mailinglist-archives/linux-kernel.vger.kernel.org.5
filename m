Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E73781BDC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 03:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjHTA6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjHTA6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:58:18 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FCD7D80A
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 17:45:27 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-26d2b3860daso1503202a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 17:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692492327; x=1693097127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5b24yTN6PgZpHb8A0TLFMxrHJdvHtJ3OKJgdjirWdIM=;
        b=e2WKAbCwUcFtqTbC3x8ysZWAiVu426Y/WcK0VO+rWvjjIcKnaKJVvgf1Yhs11eujm2
         7KJbR5xY+0wLEF1ErmtqiM/kXiHpabRu+IUemIy+kXOhk5JpWTH2cPaE1Zb8Gr5IS+8I
         PPxlMigWCnftIAyWH4Z3cBfODcWkFwDqKkMDuCh6H9ESeohTurDXS9BMJkwUtH0/ZMBf
         eEo5CWR1UYYZ2t9ZrDTYMxqvO68K4yqtfU5KxVcGQG7Yk2ghctaYrQao+5AqLWSFEkVW
         rvIatsJJI8ULbvR1CcqHju5BWcCmdQv+FAHD2DFOQ3PAMCsV5Z7KYDmXHcezkK/zUXnH
         9FmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692492327; x=1693097127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5b24yTN6PgZpHb8A0TLFMxrHJdvHtJ3OKJgdjirWdIM=;
        b=TljQphf4V4Cmt5D88gmolQ8/TG683QEn5KqC6Bo6J+Ecw+E3HGgL1eUSargF1ZaRtC
         my7tF9qqGBs9PoQNR7UK13pEWhjq/lSTCPp/jjnsb5rnCjuipdPcSk1POpV9NB/d1uNd
         ze9QVWv+jABlNhcSVVDd5G5PePTsXPB5TKl5s0ALyyTk+FG+Iz75+vt2vuHVACwlGYqa
         EuQ2xhcoHl2M64yXAFrtkdTqwrHAuQGmxSvqOpeM8+8f/OsPmpKL1UOczl8AGaG/voY+
         wJiq8OOl1L3MPDlnvln7u4FBTEZ+x8ISPpxFqJtW7HXAkaGslqJLfOTgCPu8pPrlV//0
         A5hQ==
X-Gm-Message-State: AOJu0YwC6x+AUIUAWhKmz9tEI8PscZEnV0nRzuZQrmTMBz+z+/enXyaf
        cFogCY2QMrKyerOXRn/9I2cMvw==
X-Google-Smtp-Source: AGHT+IHjEb6jdUNSvDcgsjopg+OwBVex/DQvMumX9weIIwoE/vfQ//iZffuyvCaEUoT/KzU1/XEd2A==
X-Received: by 2002:a17:90b:108d:b0:268:1e51:3496 with SMTP id gj13-20020a17090b108d00b002681e513496mr2752387pjb.21.1692492326964;
        Sat, 19 Aug 2023 17:45:26 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a1a1900b00268b439a0cbsm4004884pjk.23.2023.08.19.17.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 17:45:26 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 10/16] Staging: rtl8192e: Rename variable pRxTS in function RemoveTsEntry()
Date:   Sat, 19 Aug 2023 17:47:38 -0700
Message-ID: <20230820004744.278022-11-tdavies@darkphysics.net>
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

Rename variable pRxTS in function RemoveTsEntry() to ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 131a5d7b4599..944970272801 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -364,14 +364,14 @@ static void RemoveTsEntry(struct rtllib_device *ieee,
 
 	if (TxRxSelect == RX_DIR) {
 		struct rx_reorder_entry *pRxReorderEntry;
-		struct rx_ts_record *pRxTS = (struct rx_ts_record *)pTs;
+		struct rx_ts_record *ts = (struct rx_ts_record *)pTs;
 
-		if (timer_pending(&pRxTS->rx_pkt_pending_timer))
-			del_timer_sync(&pRxTS->rx_pkt_pending_timer);
+		if (timer_pending(&ts->rx_pkt_pending_timer))
+			del_timer_sync(&ts->rx_pkt_pending_timer);
 
-		while (!list_empty(&pRxTS->rx_pending_pkt_list)) {
+		while (!list_empty(&ts->rx_pending_pkt_list)) {
 			pRxReorderEntry = (struct rx_reorder_entry *)
-					list_entry(pRxTS->rx_pending_pkt_list.prev,
+					list_entry(ts->rx_pending_pkt_list.prev,
 					struct rx_reorder_entry, List);
 			netdev_dbg(ieee->dev,  "%s(): Delete SeqNum %d!\n",
 				   __func__, pRxReorderEntry->SeqNum);
-- 
2.41.0

