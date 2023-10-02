Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95F37B59A1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238609AbjJBRxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238617AbjJBRx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:53:27 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3FFC4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:53:24 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9ae65c0e46fso488198066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 10:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696269203; x=1696874003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VI395aHYezAAbuS4rsTYZYM/myZs8mb+8AgHT/E9XGc=;
        b=Md2ebepqrXKtJYWXyzPseYWeJHVSBM7Oy/5oA8hg17AEb3ECJO/CJjQiO676hIV69I
         JcRpi12lErjJp57GBDnDjnmVh6sVx2WnkmajFV6/M5pmv1qcmll1I2Y8TYn7ouymVJ8K
         C/s+ocPWtBp42HTbiBmrtP8dj4GSdWipg83d9OwxunpADDD5ujS72e9akMvG1mr0/LDf
         bkI3h6CD70LpNqD23qA60jp6LaM5l4FHypdtn4hdCky2TYdQ9u28FWB9wYSey5XWlpai
         AhSelo+SuODBs21UUauN4bJ6oDagwkFm89Fafs/ORkOvbdghs7F9A/KF7tANkpXpAerd
         Fv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696269203; x=1696874003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VI395aHYezAAbuS4rsTYZYM/myZs8mb+8AgHT/E9XGc=;
        b=jXJfrF9Y3GqTugSPeXVimOJ69Wrf5bz1ujjzMgo18zvVBh3j5z2CkzFFGRKwvhQ9Zd
         NZHx0B172IoWNFLm2TQyJulTJwa7bAHUrwvK4ImZyjcViDzuC3CWiRM2uB7flIpOeHg2
         HrGVEFLrMd7pZ6ddfQIX4db/abn2PqOMI2KuU7V2gQbBTcOetbE+yhfLGAbcVwRPw7H4
         mAFhX5m0ha0y/m2dymimid0o1Nrg7xsZ8i328MnDTOq2j8y9jnbUGM3EEUWd3yX1R0Ix
         VqVp/8ojz+KL/haffQiywv1t2+/3/zvLWtTKyCDtDQCPuHO2E6aTwgfK57DfON2xd9IN
         YUKA==
X-Gm-Message-State: AOJu0YwZCm2FmXXTk4Rgo4VERITjD+jKaBg1all4UX9/XLT5uW3FShr+
        Fxz4BtzDKAZ5qYRkT5d1TBg=
X-Google-Smtp-Source: AGHT+IEl/lVkCLAPFxOzKUeloban6aKu5e6isDsY2DdbnoFz+c28BYtHiO0zeXm1LstVsjSB03+6Pg==
X-Received: by 2002:a17:906:104e:b0:9b2:bf2d:6b66 with SMTP id j14-20020a170906104e00b009b2bf2d6b66mr9954680ejj.7.1696269202530;
        Mon, 02 Oct 2023 10:53:22 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id dt18-20020a170906b79200b0099bcf9c2ec6sm17247780ejb.75.2023.10.02.10.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 10:53:22 -0700 (PDT)
Date:   Mon, 2 Oct 2023 19:53:20 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] staging: rtl8192e: Remove unused function
 rtl92e_cam_restore()
Message-ID: <4375f7909fe717555adca1338506fb6d4dad142e.1696266964.git.philipp.g.hortmann@gmail.com>
References: <cover.1696266964.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696266964.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtl92e_cam_restore() is unused. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c | 63 ---------------------
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.h |  1 -
 2 files changed, 64 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
index 14b48cacfbbd..9b280cee0ac1 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
@@ -121,66 +121,3 @@ void rtl92e_set_key(struct net_device *dev, u8 EntryNo, u8 KeyIndex,
 		}
 	}
 }
-
-void rtl92e_cam_restore(struct net_device *dev)
-{
-	u8 EntryId = 0;
-	struct r8192_priv *priv = rtllib_priv(dev);
-	u8 *MacAddr = priv->rtllib->current_network.bssid;
-
-	static u8	CAM_CONST_ADDR[4][6] = {
-		{0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
-		{0x00, 0x00, 0x00, 0x00, 0x00, 0x01},
-		{0x00, 0x00, 0x00, 0x00, 0x00, 0x02},
-		{0x00, 0x00, 0x00, 0x00, 0x00, 0x03}
-	};
-	static u8	CAM_CONST_BROAD[] = {
-		0xff, 0xff, 0xff, 0xff, 0xff, 0xff
-	};
-
-	if ((priv->rtllib->pairwise_key_type == KEY_TYPE_WEP40) ||
-	    (priv->rtllib->pairwise_key_type == KEY_TYPE_WEP104)) {
-		for (EntryId = 0; EntryId < 4; EntryId++) {
-			MacAddr = CAM_CONST_ADDR[EntryId];
-			if (priv->rtllib->swcamtable[EntryId].bused) {
-				rtl92e_set_key(dev, EntryId, EntryId,
-					       priv->rtllib->pairwise_key_type,
-					       MacAddr, 0,
-					       (u32 *)(&priv->rtllib->swcamtable
-						       [EntryId].key_buf[0]));
-			}
-		}
-
-	} else if (priv->rtllib->pairwise_key_type == KEY_TYPE_TKIP) {
-		rtl92e_set_key(dev, 4, 0,
-			       priv->rtllib->pairwise_key_type,
-			       MacAddr, 0,
-			       (u32 *)(&priv->rtllib->swcamtable[4].key_buf[0]));
-	} else if (priv->rtllib->pairwise_key_type == KEY_TYPE_CCMP) {
-		rtl92e_set_key(dev, 4, 0,
-			       priv->rtllib->pairwise_key_type, MacAddr,
-			       0, (u32 *)(&priv->rtllib->swcamtable[4].key_buf[0]));
-	}
-
-	if (priv->rtllib->group_key_type == KEY_TYPE_TKIP) {
-		MacAddr = CAM_CONST_BROAD;
-		for (EntryId = 1; EntryId < 4; EntryId++) {
-			if (priv->rtllib->swcamtable[EntryId].bused) {
-				rtl92e_set_key(dev, EntryId, EntryId,
-					       priv->rtllib->group_key_type,
-					       MacAddr, 0,
-					       (u32 *)(&priv->rtllib->swcamtable[EntryId].key_buf[0]));
-			}
-		}
-	} else if (priv->rtllib->group_key_type == KEY_TYPE_CCMP) {
-		MacAddr = CAM_CONST_BROAD;
-		for (EntryId = 1; EntryId < 4; EntryId++) {
-			if (priv->rtllib->swcamtable[EntryId].bused) {
-				rtl92e_set_key(dev, EntryId, EntryId,
-					       priv->rtllib->group_key_type,
-					       MacAddr, 0,
-					       (u32 *)(&priv->rtllib->swcamtable[EntryId].key_buf[0]));
-			}
-		}
-	}
-}
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.h b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.h
index bd33ef105107..615b84bca9b8 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.h
@@ -20,6 +20,5 @@ void rtl92e_set_key(struct net_device *dev, u8 EntryNo, u8 KeyIndex,
 		    u32 *KeyContent);
 void rtl92e_set_swcam(struct net_device *dev, u8 EntryNo, u8 KeyIndex,
 		      u16 KeyType, const u8 *MacAddr, u32 *KeyContent);
-void rtl92e_cam_restore(struct net_device *dev);
 
 #endif
-- 
2.42.0

