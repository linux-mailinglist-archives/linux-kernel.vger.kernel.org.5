Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D208C767CF9
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 09:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjG2Hyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 03:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjG2Hyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 03:54:37 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D423D49ED
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 00:54:08 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-991f9148334so71550466b.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 00:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690617235; x=1691222035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/cWNXtNWkZB1EXNrbyq7/j6lsC1SsNmw/WUGK+ol4U4=;
        b=OP8cB46YwORbeq8DePcyMkG0DslF+lYefcJarWenP3neEwdqUPNgikMAU2QkMTDHBA
         5lNgMpt8x00OfxhxD4bch2EUVEhGro0yi1/a8xhAvIXFbK/a9qNgGGU7Niivv1TCKpvg
         WKY7A2m27wZngPMys4ZMQD0j/1aIhSsABSk0skhkUcjtwpRzuBsmGtW0ZId2tlOap+FA
         5sgRAgKh8H43i3MetGvuB8744b4PsxHbugfd3j474TDLsrbzt8TOVKys1SsvUZe76C4I
         WzeKbLdrZSoS1VLrDKWlUvrOChP3AYvkiuitG19OtxaP0RA8jYtDMlCJucg4d0+F27RJ
         YWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690617235; x=1691222035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cWNXtNWkZB1EXNrbyq7/j6lsC1SsNmw/WUGK+ol4U4=;
        b=KbeivOeMen41LCs3xKz+hDlzYTcDDzd1Ui4RSfDAr7ZgZmmqNMPgrxAXPTzbNaMD9b
         +e0hhZb87f81hdcFebapKmpCY1HPd89xCZyWevI4ehEisNlUwOFNeJpXXKOV81thqIwK
         Gq3NJfc88ImODUYlL5pZMemnPry2x/MyNlnMwOJBKf4QahtSfDV+Q823808jSYa89GZf
         UZbsS0KSAn2ZF08tCtamBZ5bd9YXq2Z708tFOeiZ2mS0pqlsjOvMvqt/XkOF/iyTXiYj
         t2WngfUZm9XcIKUNf+5hDwCIUg4TpzL+Xqbwg5ZVuGOGzy8106FZy8PjeiHYOa1vDNbB
         JlnQ==
X-Gm-Message-State: ABy/qLbnp/98fzZ63zuHlb+ZAeGTBtBFjske0potspnoVbRQAH/cjL8v
        qGcDtu6ZkwXJ/nHVGEdFaD4=
X-Google-Smtp-Source: APBJJlEy1d3dMdMhZQIrxMTC2h/2G5mapgplcTZ5OPNc0ppw6M0covT6fayqx1AvveNGYEpq3ygd0g==
X-Received: by 2002:a17:906:6489:b0:993:d88e:41e3 with SMTP id e9-20020a170906648900b00993d88e41e3mr1297335ejm.4.1690617235540;
        Sat, 29 Jul 2023 00:53:55 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id qq5-20020a17090720c500b009882e53a42csm2994460ejb.81.2023.07.29.00.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 00:53:55 -0700 (PDT)
Date:   Sat, 29 Jul 2023 09:53:53 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] staging: rtl8192e: Remove DefaultKey from
 rtl92e_set_swcam
Message-ID: <9390014fe045028ac2a32ce7c9745c7cddbd4adf.1690615475.git.philipp.g.hortmann@gmail.com>
References: <cover.1690615475.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1690615475.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtl92e_set_swcam() has parameter DefaultKey which is in all calls
0. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c | 5 ++---
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.h | 3 +--
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c  | 8 ++++----
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
index f9ddb8384752..944cc73fb2b6 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
@@ -49,8 +49,7 @@ void rtl92e_enable_hw_security_config(struct net_device *dev)
 }
 
 void rtl92e_set_swcam(struct net_device *dev, u8 EntryNo, u8 KeyIndex,
-		      u16 KeyType, const u8 *MacAddr, u8 DefaultKey,
-		      u32 *KeyContent)
+		      u16 KeyType, const u8 *MacAddr, u32 *KeyContent)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rtllib_device *ieee = priv->rtllib;
@@ -62,7 +61,7 @@ void rtl92e_set_swcam(struct net_device *dev, u8 EntryNo, u8 KeyIndex,
 	ieee->swcamtable[EntryNo].key_index = KeyIndex;
 	ieee->swcamtable[EntryNo].key_type = KeyType;
 	memcpy(ieee->swcamtable[EntryNo].macaddr, MacAddr, 6);
-	ieee->swcamtable[EntryNo].useDK = DefaultKey;
+	ieee->swcamtable[EntryNo].useDK = 0;
 	memcpy(ieee->swcamtable[EntryNo].key_buf, (u8 *)KeyContent, 16);
 }
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.h b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.h
index fcfde5f6cf2f..bd33ef105107 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.h
@@ -19,8 +19,7 @@ void rtl92e_set_key(struct net_device *dev, u8 EntryNo, u8 KeyIndex,
 		    u16 KeyType, const u8 *MacAddr, u8 DefaultKey,
 		    u32 *KeyContent);
 void rtl92e_set_swcam(struct net_device *dev, u8 EntryNo, u8 KeyIndex,
-		      u16 KeyType, const u8 *MacAddr, u8 DefaultKey,
-		      u32 *KeyContent);
+		      u16 KeyType, const u8 *MacAddr, u32 *KeyContent);
 void rtl92e_cam_restore(struct net_device *dev);
 
 #endif
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index 644762f925b7..189798852568 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -712,7 +712,7 @@ static int _rtl92e_wx_set_enc(struct net_device *dev,
 			rtl92e_set_key(dev, key_idx, key_idx, KEY_TYPE_WEP104,
 				       zero_addr[key_idx], 0, hwkey);
 			rtl92e_set_swcam(dev, key_idx, key_idx, KEY_TYPE_WEP104,
-					 zero_addr[key_idx], 0, hwkey);
+					 zero_addr[key_idx], hwkey);
 		} else {
 			netdev_info(dev,
 				    "wrong type in WEP, not WEP40 and WEP104\n");
@@ -857,19 +857,19 @@ static int _rtl92e_wx_set_encode_ext(struct net_device *dev,
 			if (ext->key_len == 13)
 				ieee->pairwise_key_type = alg = KEY_TYPE_WEP104;
 			rtl92e_set_key(dev, idx, idx, alg, zero, 0, key);
-			rtl92e_set_swcam(dev, idx, idx, alg, zero, 0, key);
+			rtl92e_set_swcam(dev, idx, idx, alg, zero, key);
 		} else if (group) {
 			ieee->group_key_type = alg;
 			rtl92e_set_key(dev, idx, idx, alg, broadcast_addr, 0,
 				       key);
-			rtl92e_set_swcam(dev, idx, idx, alg, broadcast_addr, 0, key);
+			rtl92e_set_swcam(dev, idx, idx, alg, broadcast_addr, key);
 		} else {
 			if ((ieee->pairwise_key_type == KEY_TYPE_CCMP) &&
 			     ieee->ht_info->bCurrentHTSupport)
 				rtl92e_writeb(dev, 0x173, 1);
 			rtl92e_set_key(dev, 4, idx, alg,
 				       (u8 *)ieee->ap_mac_addr, 0, key);
-			rtl92e_set_swcam(dev, 4, idx, alg, (u8 *)ieee->ap_mac_addr, 0, key);
+			rtl92e_set_swcam(dev, 4, idx, alg, (u8 *)ieee->ap_mac_addr, key);
 		}
 	}
 
-- 
2.41.0

