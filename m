Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F23C781BD8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 02:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjHTA6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjHTA5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:57:18 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B207D818
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 17:45:29 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-41090ef118eso2645831cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 17:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692492328; x=1693097128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Btu3fz/hzzEnWh5UsyHAJ9P5nBC3gu50dMe6Wq1vPYo=;
        b=kTWrON3fLsUFUr4nSK2n7mfl2MG/sQk/gxPMHkt9vaUS3CNvuJHXB7TFMvQpij7JVH
         XVjKn2oNCTGEkG8JXiFsNdlnSgP9obc///ecZaDEGy5A1JSpKbkTeUFbgSxdRH7xXn/I
         T/NbEv3DvXBQgsRFSahanawc3FEPgAqFhNxTAJgTeBu1qN9NzTzwf0XrCNKngFnuIci7
         oXnCzPQjX4fmKzMkxIzfNFmBH6iAKzX690QmoXcj4+6wgibTwRC9K+ogAKm3fZH4r5rA
         FT2ZZfU9mPXz538FwNOioDJ38q3gqJ3HOj8O3Kyk1DVsgZPAXTs1RUIVy/ggWLOlty3k
         pGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692492328; x=1693097128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Btu3fz/hzzEnWh5UsyHAJ9P5nBC3gu50dMe6Wq1vPYo=;
        b=h8kl05gB1x/F1t9DAD+HJxXsDPzI4moSY6V4brVVp3F0mMUTTliCHFled7ZODQXdey
         EVLIW7vQGJdujSWC480pULPTg/+tnNGpYKhXiooWByyDgdERH3eGMhY0tyitjzFY98KU
         JpIZOVM5CRrKqjoIrHt+4ix/0vyNMevmECd2iqg+SF9lTmhosghQFFrBoOHaW935S6TJ
         S0wY1EWzvcSJ34aen3efoZboMFBzMg4CJQGWOnHDkbWlbTYYoQVU1P/Jg+arTXYtnock
         DFnV5Nhkyd+gGbFW2pfgVT5bwJeDRl5M68cp6vl8SqWP3iUB0JMEYmPrKKLEKuzoGWrb
         oFWg==
X-Gm-Message-State: AOJu0YxXqvuYPxdZUPHz4Jol1JZ96oADoFXQsRzxzb443LizFge72BVK
        ZrWdYDEEfXnFBgX1psWCfxw7cA==
X-Google-Smtp-Source: AGHT+IGM/n/vdrW03aY5metSm1eKF1w8dj1Y569wGZwW/NOzkzFFXKmSi5/8w/FmHsRZB6VfzkCmvg==
X-Received: by 2002:ac8:7d13:0:b0:40f:f435:1b2b with SMTP id g19-20020ac87d13000000b0040ff4351b2bmr4985688qtb.24.1692492328492;
        Sat, 19 Aug 2023 17:45:28 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a1a1900b00268b439a0cbsm4004884pjk.23.2023.08.19.17.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 17:45:28 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 12/16] Staging: rtl8192e: Rename variable pTS in function AddReorderEntry()
Date:   Sat, 19 Aug 2023 17:47:40 -0700
Message-ID: <20230820004744.278022-13-tdavies@darkphysics.net>
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

Rename variable pTS in function AddReorderEntry() to ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 8a4029f26835..1d41f62fa346 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -435,12 +435,12 @@ static int is_duplicate_packet(struct rtllib_device *ieee,
 	return 1;
 }
 
-static bool AddReorderEntry(struct rx_ts_record *pTS,
+static bool AddReorderEntry(struct rx_ts_record *ts,
 			    struct rx_reorder_entry *pReorderEntry)
 {
-	struct list_head *pList = &pTS->rx_pending_pkt_list;
+	struct list_head *pList = &ts->rx_pending_pkt_list;
 
-	while (pList->next != &pTS->rx_pending_pkt_list) {
+	while (pList->next != &ts->rx_pending_pkt_list) {
 		if (SN_LESS(pReorderEntry->SeqNum, ((struct rx_reorder_entry *)
 		    list_entry(pList->next, struct rx_reorder_entry,
 		    List))->SeqNum))
-- 
2.41.0

