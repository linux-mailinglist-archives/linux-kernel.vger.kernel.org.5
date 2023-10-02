Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E1A7B599F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238202AbjJBRxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237984AbjJBRxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:53:15 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425D083
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:53:12 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9b2c5664cb4so190904066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 10:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696269190; x=1696873990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BFQQ8VYOAr6qNDG5scul8J1mas0KU5lvrUkFm3jfx9c=;
        b=S7H5BP36OyXRBQ5Rxxyf/KVS0HROdy7TXxhm+dbOjAPTrKq2SlljcJcsPyEaV2UmH9
         ymEJ6XTn8Dgy8iHpkvQFA8hXrEAopZuyuhoo4ZnyT2yxdBeC3VyEd8zZBRao0i1fXUWm
         yb0eSOYhcOPpf9xkyqkVfNR/c62xtnfX5c82PbF806rwxf+Lea0YY/d0I50kz1y1R9w6
         9wr6eaLfimwcOYNzW8tXccUI3Ovg71Ybhp5MdITgMntX0ias7c9WB7XklbzLkHzD0av2
         xz7FOMsxBP9ca9kNt8sPlFdQeHfqTFt21F9bJT0miPWp7sIYsV7XW4Gdv4RelqK38T5u
         FO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696269190; x=1696873990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFQQ8VYOAr6qNDG5scul8J1mas0KU5lvrUkFm3jfx9c=;
        b=bhtW66D4JdyEcG87kIH04AeGRy69MWlZOh1kTQuG/HnBP8oNGgg2E/seMFZ72ufbbW
         QpF0H5EHXbIKN5Cf9CSo7dPUe8SH6IVjUiTAI0XryJBcKFXadCcoAkup203nyKCYvgYE
         7xZHFCiNcflkEZFPRYvABBLLRTK/nh34V7T7T8gcnNA89JjRTb39obhtw7pnKiHKRZJi
         GMMA6DhRhAQZpHbCQdfXYvvLbQnX+LfBUCTzXB1Ucf21zyRFzO+ZUxT/X2+otiMfpAR6
         tHeYd13Ko5/0JUwfNiOf7oTfG4H4Cllz8D/b6FpbRMteGbObLLk3ru5EoCeWH56yFw59
         fusw==
X-Gm-Message-State: AOJu0Yx6gc/7nWleyD1+CTBlWKxpsqWwMQuVfIX3U8wHpd/L3jKyMiCh
        WiA4uFek9ujNiiJtuE6AoXNaQ2iuAaA=
X-Google-Smtp-Source: AGHT+IGMa7Qaxlb1KlygBwVlzi54kQa7AeduKFnqNbPLRX9y8enMpw6ICJzR7bnbu6L2qmOZH/0yCQ==
X-Received: by 2002:a17:906:25d:b0:9b2:bf2d:6b65 with SMTP id 29-20020a170906025d00b009b2bf2d6b65mr11389311ejl.4.1696269190437;
        Mon, 02 Oct 2023 10:53:10 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id k5-20020a1709062a4500b009934b1eb577sm17589605eje.77.2023.10.02.10.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 10:53:10 -0700 (PDT)
Date:   Mon, 2 Oct 2023 19:53:08 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] staging: rtl8192e: Remove unused function
 rtl92e_dm_backup_state()
Message-ID: <104b248b35b4fda560056fc4ab4ac230dea98d3f.1696266964.git.philipp.g.hortmann@gmail.com>
References: <cover.1696266964.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696266964.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtl92e_dm_backup_state() is unused. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 19 -------------------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h |  1 -
 2 files changed, 20 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index c29bc85f9577..5217ace3f140 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -973,25 +973,6 @@ static void _rtl92e_dm_bb_initialgain_restore(struct net_device *dev)
 	rtl92e_set_bb_reg(dev, UFWP, bMaskByte1, 0x1);
 }
 
-void rtl92e_dm_backup_state(struct net_device *dev)
-{
-	struct r8192_priv *priv = rtllib_priv(dev);
-	u32 bit_mask = bMaskByte0;
-
-	priv->bswitch_fsync  = false;
-
-	if (dm_digtable.dig_algorithm == DIG_ALGO_BY_RSSI)
-		return;
-
-	rtl92e_set_bb_reg(dev, UFWP, bMaskByte1, 0x8);
-	priv->initgain_backup.xaagccore1 = rtl92e_get_bb_reg(dev, rOFDM0_XAAGCCore1, bit_mask);
-	priv->initgain_backup.xbagccore1 = rtl92e_get_bb_reg(dev, rOFDM0_XBAGCCore1, bit_mask);
-	priv->initgain_backup.xcagccore1 = rtl92e_get_bb_reg(dev, rOFDM0_XCAGCCore1, bit_mask);
-	priv->initgain_backup.xdagccore1 = rtl92e_get_bb_reg(dev, rOFDM0_XDAGCCore1, bit_mask);
-	bit_mask  = bMaskByte2;
-	priv->initgain_backup.cca = (u8)rtl92e_get_bb_reg(dev, rCCK0_CCA, bit_mask);
-}
-
 static void _rtl92e_dm_dig_init(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
index 01587e2fec65..9085a6454cbc 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
@@ -179,7 +179,6 @@ void    rtl92e_dm_txpower_tracking_wq(void *data);
 void rtl92e_dm_cck_txpower_adjust(struct net_device *dev, bool binch14);
 
 void    rtl92e_dm_restore_state(struct net_device *dev);
-void    rtl92e_dm_backup_state(struct net_device *dev);
 void    rtl92e_dm_init_edca_turbo(struct net_device *dev);
 void    rtl92e_dm_rf_pathcheck_wq(void *data);
 void rtl92e_dm_init_txpower_tracking(struct net_device *dev);
-- 
2.42.0

