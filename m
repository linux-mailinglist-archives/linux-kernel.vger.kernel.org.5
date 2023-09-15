Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8654A7A234D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbjIOQKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236179AbjIOQKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:10:08 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB322716
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:09:33 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31f8ddc349bso314597f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694794172; x=1695398972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e6zJX8M1AWA9AzHjlXWzMk/8ZyhOyB9WL4ZHECa3qZU=;
        b=fpucHhPnB0eLhyTTKFfklfQFWh7bzKixQKPIArllb3g52mXPgfSZN6/h8CoTg+XgXg
         pE61Hx0NXXCxPbKu6KuyIBrFAIO6SCKdPuoz2Asv/zBG8e46RWFWiOyryQa6tL13nxTj
         pN+nOXZ4t0ufnvd8cHnh5IvFJvlEEOSjqTorjKd25iYbJcdGvYr9/Gjcb0Jq1twSYwjH
         WAJUVihDICZqeGYh0ejAQoo+OCooLdb07QBAB1oxLbHszpdaJ3k1HQ4x08FgkVJcJAKS
         0Ty82RYUQSsSn8L4k16ug+I6tOZDOaZF7Skp6cCJu577SJig7Ms0GjQIogffZ5E0BuvZ
         dffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694794172; x=1695398972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6zJX8M1AWA9AzHjlXWzMk/8ZyhOyB9WL4ZHECa3qZU=;
        b=pQcIWyyIpGftZ5JBJzDIGHBvqhrM9I4DIhB1+J0lxBiAWcNwc+x1MhMtFH+r0l493T
         /GqejKf4AMeuQt7IIRLCKk4LlSDaj9AiF9OoGCFG3DG816YWHDPd9p6UM0gs6SxPtTqD
         fR+QXjDUSSmT3+/Tn+d4t7jKnju0IgXhr5iyw5EjdZmNrAYnanB+VikrcqeCz7/xWSvF
         CRlNX1r5rn4eFjPltXqbmg9XWSWPkc7OsAzneWEvyGgmwSrTpRfb4mUTl6wV343KOuTd
         j4FUfTpvjJzg3sgcQmmqTGnowPeI70HbdSpRQ0tWUcj86CqZZJex7eWLBJx3hG2ZdrlX
         FsIQ==
X-Gm-Message-State: AOJu0Yx9ZVpzQAOx1XjXH1AfMewLxk2HQ7gc4sBWsGWFZaGezAGXaYEl
        sgkryJcn35XbvVBhDuivwkXncBenVuocuA==
X-Google-Smtp-Source: AGHT+IFyxrTxRAsIwCf8BBHzAO91OQPuLLNKoI3058A7oHSnOlVsCIqQIHOdGDmOvw6/Wy6NNCrTLg==
X-Received: by 2002:adf:ef88:0:b0:317:3d36:b2c1 with SMTP id d8-20020adfef88000000b003173d36b2c1mr1777666wro.7.1694794172048;
        Fri, 15 Sep 2023 09:09:32 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id f13-20020a5d568d000000b0031fd849e797sm4720098wrv.105.2023.09.15.09.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 09:09:31 -0700 (PDT)
Date:   Fri, 15 Sep 2023 18:09:30 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 12/16] staging: rtl8192e: Remove struct rtllib_pspoll_hdr
Message-ID: <a4bd004fcbba81f96fd09f5adec5f029e2de3d6d.1694792595.git.philipp.g.hortmann@gmail.com>
References: <cover.1694792595.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694792595.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace struct rtllib_pspoll_hdr with struct ieee80211_pspoll to avoid
proprietary code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h         | 7 -------
 drivers/staging/rtl8192e/rtllib_softmac.c | 8 ++++----
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 24060c9722e6..ef6e2187f847 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -672,13 +672,6 @@ enum rtllib_mfie {
  * information to determine what type of underlying data type is actually
  * stored in the data.
  */
-struct rtllib_pspoll_hdr {
-	__le16 frame_ctl;
-	__le16 aid;
-	u8 bssid[ETH_ALEN];
-	u8 ta[ETH_ALEN];
-} __packed;
-
 struct rtllib_info_element {
 	u8 id;
 	u8 len;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 3c61b6f4f69f..e51bdfd847d2 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -936,21 +936,21 @@ static struct sk_buff *rtllib_null_func(struct rtllib_device *ieee, short pwr)
 static struct sk_buff *rtllib_pspoll_func(struct rtllib_device *ieee)
 {
 	struct sk_buff *skb;
-	struct rtllib_pspoll_hdr *hdr;
+	struct ieee80211_pspoll *hdr;
 
-	skb = dev_alloc_skb(sizeof(struct rtllib_pspoll_hdr) + ieee->tx_headroom);
+	skb = dev_alloc_skb(sizeof(struct ieee80211_pspoll) + ieee->tx_headroom);
 	if (!skb)
 		return NULL;
 
 	skb_reserve(skb, ieee->tx_headroom);
 
-	hdr = skb_put(skb, sizeof(struct rtllib_pspoll_hdr));
+	hdr = skb_put(skb, sizeof(struct ieee80211_pspoll));
 
 	ether_addr_copy(hdr->bssid, ieee->current_network.bssid);
 	ether_addr_copy(hdr->ta, ieee->dev->dev_addr);
 
 	hdr->aid = cpu_to_le16(ieee->assoc_id | 0xc000);
-	hdr->frame_ctl = cpu_to_le16(RTLLIB_FTYPE_CTL | RTLLIB_STYPE_PSPOLL |
+	hdr->frame_control = cpu_to_le16(RTLLIB_FTYPE_CTL | RTLLIB_STYPE_PSPOLL |
 			 RTLLIB_FCTL_PM);
 
 	return skb;
-- 
2.42.0

