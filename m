Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB101788AED
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343587AbjHYOIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343520AbjHYOHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:07:22 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EAF213B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:53 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68bed2c786eso771129b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692972391; x=1693577191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FGGGv73VeY42LvPjIqtiS9blPOkXId6Nd8Sz/hLLOI=;
        b=TSvgwQv8y2plVGg5I306gSi3HWoOuVr08FkLnvvCUq5+u5vC3HY+v91i9Rl2QKdmAN
         imRStohI9RCO36oYx+s1dTs/+d48deUr/zFyQ1JNt95xjjl1b/VF7iQH+pfnmOGpBILH
         Y7qdZcNT69wbd2/gd7+c94PG+SMgVBRRJmTYWbHCPCcoM7zI7H1VucOEpEkrO2g3PPy+
         ZQJs24z812snoD1c7NIZ3R5wCL4vjSwSokR/P7YHwlDZwIYSObHZTvBHTUzA7Ykd2SOg
         U5bLXSrSKrfsUzZgv4ll0yw7A3a6XTFFNINAfQJKBshSbZjleyfl0brDn3G1J8VsuEAP
         eJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692972391; x=1693577191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3FGGGv73VeY42LvPjIqtiS9blPOkXId6Nd8Sz/hLLOI=;
        b=aBIlBvpqzOJc/1hf0h906L3Npr/vBXwFnSXa210Cv3seG4OhUlm2lo6GPARx02wKjG
         bZu5bfap+ujqU0efdls0lrBaiDjqtnLp/mv2XaMDLSRjIDdd/MuaD+eWq+kstxJfBe3G
         spZR6KJd5IVj7eB6NQ0DKo0WRZ6md01HFK2pCoOiVsbMFMUuVkXn1cbLQMde/F6pfHAW
         58mJV1Ymy8oJBVB+82ruN9exM12l5vfHqei4YsAa0nz2y2+UaQfAkoDgZEU1V914yYEQ
         FfcN00hvNCJVjEq565Nzi5M03XscAGbmYsxD59SG6eh1VmpwW03BieMK//LP2dngrgLU
         fiyA==
X-Gm-Message-State: AOJu0YzOI/yki4g5FBegCNSsWXEmoIHoLwJ2c262X0u+DZa203FTd7sH
        +xZvYbCrAU4b2dyqVKs4vYKu0g==
X-Google-Smtp-Source: AGHT+IEwyB9RpdgBZjRX6l2F02nupL7sUgtm5kSiukh2FirApgxjoXhvdm+ae1v+Zvcd/Ezh90SS9Q==
X-Received: by 2002:a05:6a00:cc2:b0:68b:a137:3739 with SMTP id b2-20020a056a000cc200b0068ba1373739mr9927201pfv.4.1692972391319;
        Fri, 25 Aug 2023 07:06:31 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id v23-20020a62a517000000b006870721fcc5sm1628232pfm.175.2023.08.25.07.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 07:06:30 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v4 15/16] Staging: rtl8192e: Rename variable pRxTS in function rtllib_rx_check_duplicate()
Date:   Fri, 25 Aug 2023 07:08:46 -0700
Message-ID: <20230825140847.501113-16-tdavies@darkphysics.net>
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

Rename variable pRxTS in function rtllib_rx_check_duplicate() to ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
v4:Resending whole series as v4
v3:No Changes
v2:No Changes
 drivers/staging/rtl8192e/rtllib_rx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index e97debe6a7d2..491789ebcc08 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -922,15 +922,15 @@ static int rtllib_rx_check_duplicate(struct rtllib_device *ieee,
 				return -1;
 		}
 	} else {
-		struct rx_ts_record *pRxTS = NULL;
+		struct rx_ts_record *ts = NULL;
 
-		if (GetTs(ieee, (struct ts_common_info **)&pRxTS, hdr->addr2,
+		if (GetTs(ieee, (struct ts_common_info **)&ts, hdr->addr2,
 			(u8)Frame_QoSTID((u8 *)(skb->data)), RX_DIR, true)) {
-			if ((fc & (1 << 11)) && (frag == pRxTS->rx_last_frag_num) &&
-			    (WLAN_GET_SEQ_SEQ(sc) == pRxTS->rx_last_seq_num))
+			if ((fc & (1 << 11)) && (frag == ts->rx_last_frag_num) &&
+			    (WLAN_GET_SEQ_SEQ(sc) == ts->rx_last_seq_num))
 				return -1;
-			pRxTS->rx_last_frag_num = frag;
-			pRxTS->rx_last_seq_num = WLAN_GET_SEQ_SEQ(sc);
+			ts->rx_last_frag_num = frag;
+			ts->rx_last_seq_num = WLAN_GET_SEQ_SEQ(sc);
 		} else {
 			netdev_warn(ieee->dev, "%s(): No TS! Skip the check!\n",
 				    __func__);
-- 
2.41.0

