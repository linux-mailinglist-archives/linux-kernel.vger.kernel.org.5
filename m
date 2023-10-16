Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07717CA3F1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjJPJUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjJPJUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:20:47 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECADB4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:20:42 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40684f53ef3so46199615e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697448040; x=1698052840; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rJfBRp5VD6FpfPviX6UT8LSGqMMMF7yFcNY8gKLmCHs=;
        b=KU+JIrafauGh0xleZcyryREmUSiYVY/ZCjTLfyv/pyEG6vTlsliHgxeYKoYw39pFgK
         SQm0aj1e+DfXSSdeUqEV2yIUn1RgsN+FHa8sW7ueCYtFkGz4qSsrNep/RCGQKY2hZiVs
         PcaxyR7piQNfawELyy347h4fvBcQIVhJ47POCzr2EfYby5ODsGtpD9ji9AZjyMw51fy0
         O02AqzdqAX3fMQnl06IpK1Z0hF1c5PZr/6+u1U8s32eIL5oiwoqdfQV7i4O6/nWL8aMK
         CAuJ8H1NHSkc9AeHuSpC9k2qsaAr8xhlvjQmHDYvr1F6OmqHEtECfvvMlipUPg/91bb1
         iX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697448040; x=1698052840;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJfBRp5VD6FpfPviX6UT8LSGqMMMF7yFcNY8gKLmCHs=;
        b=F+5HtNT21HgtKs1Ihn8F3QENPoBSQKf+fVLcl1TNbpsyPUhyY6O6c3EuZf9R500780
         NlcdVreBYBJziKl0NQEz3BgcgwxOay6syCUhCLI5tVGVs2SeJC6pi5YYCFCHJhjavh11
         /Ltomzpke/b7Z6i2G7bS1jcNNBXTNwCtxXJD3tEA+AS9NNZOPt3RfIrt66Qy/k79GcTy
         zxWsmy4JLnw1M/ATrQpHrpGk7nLyRUTi530uau4UeMT+kG6eSkMUb2IcaJdbWcX0Cwtp
         2pIziVZYmIY9pxORW63UvHQ1SLDjFioJ2UzosAniEwqTiKJPdoGO/SvvgKxFO6VJyi0/
         5K1Q==
X-Gm-Message-State: AOJu0Yx8RNLY7EU9jZzZIXYcvM5WwhRKTKpMNbpwxYqnw3kK25kM01IT
        In/u0AmuWrEozrLE9uTJJns=
X-Google-Smtp-Source: AGHT+IEzEWonZB1xm24SGr71/E3ez9Wnn2Ifz8W/kECAf52uERj4/tTjaZw6skTUUAGecguYZCnOXA==
X-Received: by 2002:a7b:c5c9:0:b0:405:40ab:7693 with SMTP id n9-20020a7bc5c9000000b0040540ab7693mr27898824wmk.31.1697448040274;
        Mon, 16 Oct 2023 02:20:40 -0700 (PDT)
Received: from lab-ubuntu ([41.90.67.11])
        by smtp.gmail.com with ESMTPSA id i12-20020a05600c290c00b0040588d85b3asm6573166wmd.15.2023.10.16.02.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 02:20:39 -0700 (PDT)
Date:   Mon, 16 Oct 2023 12:20:37 +0300
From:   Calvince Otieno <calvncce@gmail.com>
To:     gustavo@embeddedor.com, outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Calvince Otieno <calvncce@gmail.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] staging: wlan-ng: replace pr_debug() with netdev_dbg()
Message-ID: <ZS0AZahhusLoN4b/@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces the usage of pr_debug() with netdev_dbg().
The change is made to enhance context-aware debugging,
improve code clarity, and maintain compatibility with established
network debugging practices. There were no functional code changes.

Signed-off-by: Calvince Otieno <calvncce@gmail.com>
---
 drivers/staging/wlan-ng/p80211conv.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/wlan-ng/p80211conv.c b/drivers/staging/wlan-ng/p80211conv.c
index 048e1c3fe19b..8336435eccc2 100644
--- a/drivers/staging/wlan-ng/p80211conv.c
+++ b/drivers/staging/wlan-ng/p80211conv.c
@@ -312,8 +312,8 @@ int skb_p80211_to_ether(struct wlandevice *wlandev, u32 ethconv,
 				  payload_length - 4);
 		if (foo) {
 			/* de-wep failed, drop skb. */
-			pr_debug("Host de-WEP failed, dropping frame (%d).\n",
-				 foo);
+			netdev_dbg(netdev, "Host de-WEP failed, dropping frame (%d).\n",
+				   foo);
 			wlandev->rx.decrypt_err++;
 			return 2;
 		}
@@ -340,7 +340,7 @@ int skb_p80211_to_ether(struct wlandevice *wlandev, u32 ethconv,
 	    (e_llc->dsap != 0xaa || e_llc->ssap != 0xaa) &&
 	    ((!ether_addr_equal_unaligned(daddr, e_hdr->daddr)) ||
 	     (!ether_addr_equal_unaligned(saddr, e_hdr->saddr)))) {
-		pr_debug("802.3 ENCAP len: %d\n", payload_length);
+		netdev_dbg(netdev, "802.3 ENCAP len: %d\n", payload_length);
 		/* 802.3 Encapsulated */
 		/* Test for an overlength frame */
 		if (payload_length > (netdev->mtu + ETH_HLEN)) {
@@ -367,7 +367,7 @@ int skb_p80211_to_ether(struct wlandevice *wlandev, u32 ethconv,
 		   (p80211_stt_findproto(be16_to_cpu(e_snap->type)))) ||
 		   (memcmp(e_snap->oui, oui_rfc1042, WLAN_IEEE_OUI_LEN) !=
 			0))) {
-		pr_debug("SNAP+RFC1042 len: %d\n", payload_length);
+		netdev_dbg(netdev, "SNAP+RFC1042 len: %d\n", payload_length);
 		/* it's a SNAP + RFC1042 frame && protocol is in STT */
 		/* build 802.3 + RFC1042 */
 
@@ -397,7 +397,7 @@ int skb_p80211_to_ether(struct wlandevice *wlandev, u32 ethconv,
 		(e_llc->dsap == 0xaa) &&
 		(e_llc->ssap == 0xaa) &&
 		(e_llc->ctl == 0x03)) {
-		pr_debug("802.1h/RFC1042 len: %d\n", payload_length);
+		netdev_dbg(netdev, "802.1h/RFC1042 len: %d\n", payload_length);
 		/* it's an 802.1h frame || (an RFC1042 && protocol not in STT)
 		 * build a DIXII + RFC894
 		 */
@@ -433,7 +433,7 @@ int skb_p80211_to_ether(struct wlandevice *wlandev, u32 ethconv,
 		/* chop off the 802.11 CRC */
 		skb_trim(skb, skb->len - WLAN_CRC_LEN);
 	} else {
-		pr_debug("NON-ENCAP len: %d\n", payload_length);
+		netdev_dbg(netdev, "NON-ENCAP len: %d\n", payload_length);
 		/* any NON-ENCAP */
 		/* it's a generic 80211+LLC or IPX 'Raw 802.3' */
 		/*  build an 802.3 frame */
-- 
2.34.1

