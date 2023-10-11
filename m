Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A42C7C592C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbjJKQdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 12:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjJKQc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:32:59 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B1BA4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 09:32:58 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-579de633419so143237b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 09:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697041977; x=1697646777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YcrSTPiKgGvBMhWL3rTX/4I3RdS194oyF0Rj5hOezM0=;
        b=meYXHD0VebO+zFYZD6nKADU5X2FR6mVimctzdSWNx+mqHWvaeKdi3oTx9GH7D4Myql
         cY38qEkLTNlSvIoPVRD1bch6xTKc76hkpcTLr2sZzvl6EKSjPF0u1DSynermCs4z48QO
         bEV7/IA9Bcbf9NaUukos0XwOMyBNx1ohubIkJy9NpeYhtLx2ZyySnZ4bKW/veDT40GsX
         Za+84cjykYWXKoEvbdrMkbb0FzYlYfrGuXMGqjlijr5IE8nKIfap4ybKETfLS12sitEz
         zztvKHm0v5TREAEG6P4TLWj5prSSpcZbhFPhIT0F4HGEKK/sOQFCRXvFOig9UpalKbhf
         6Iuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697041977; x=1697646777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YcrSTPiKgGvBMhWL3rTX/4I3RdS194oyF0Rj5hOezM0=;
        b=lqRl0yjzpoD0wvTauI98gwAOegIMT0v4Hj3/EYWjC7dyxvtc41yCSOSU0NB3RveUBj
         pD7APY/eht1BFYUa2b1SJBbfERkzkAU74yji8ZQaT1svMVaToTwj0+sJt9OmIszDoMiq
         cKAmOHhO7N4h+G8BnzUYyz8wyhVcv/EoTgXNAfBtCc8GHHmUwX5L78zM1qQyD6fd494C
         JMAVolsgy8v9h10W+FIr6q4W2UjDDC8yCLynkgo9sluP/jpAIQpi9iS4nDqVQcg3MTKs
         bqzg6F9WIuJo9NiHQQgDLtBOydc++p8d1fJ0vA/hcX+ckiDu+RaCbzLMoAIJ0J3Zfaxx
         JBVg==
X-Gm-Message-State: AOJu0YzJAQmssfNSAlMNqdeL8YdMcTf4fuB1KIuqfY8kyGAAmm8vRDsV
        zhJP3YyFrC4Q/gre54MeTy8=
X-Google-Smtp-Source: AGHT+IG9MyyVRFyjc1GyvqBpuEqq1Yx1XB84LZFroeRGcHITvKl+B4s+4k3qeYqMEN+AZCM6ENNJ4g==
X-Received: by 2002:a81:6c8b:0:b0:59f:67f5:66c6 with SMTP id h133-20020a816c8b000000b0059f67f566c6mr22505291ywc.16.1697041977391;
        Wed, 11 Oct 2023 09:32:57 -0700 (PDT)
Received: from policorp.cardume.local ([177.91.232.53])
        by smtp.gmail.com with ESMTPSA id i23-20020ab04757000000b007ab975b8eb9sm2798097uac.10.2023.10.11.09.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 09:32:57 -0700 (PDT)
From:   drosdeck <edson.drosdeck@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        edson.drosdeck@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs:Fix coding style errors and warning
Date:   Wed, 11 Oct 2023 13:42:32 -0300
Message-Id: <20231011164232.28866-1-edson.drosdeck@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warning found by checkpatch.pl script. Fixes warning replacing printk to
pr_crit and fixes conding style.

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 21 +++++++++-----------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index 490431484524..e178a6881e0c 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -48,7 +48,6 @@ static void sd_sync_int_hdl(struct sdio_func *func)
 {
 	struct dvobj_priv *psdpriv;
 
-
 	psdpriv = sdio_get_drvdata(func);
 
 	if (!psdpriv->if1)
@@ -73,7 +72,7 @@ static int sdio_alloc_irq(struct dvobj_priv *dvobj)
 	err = sdio_claim_irq(func, &sd_sync_int_hdl);
 	if (err) {
 		dvobj->drv_dbg.dbg_sdio_alloc_irq_error_cnt++;
-		printk(KERN_CRIT "%s: sdio_claim_irq FAIL(%d)!\n", __func__, err);
+		pr_crit("%s: sdio_claim_irq FAIL(%d)!\n", __func__, err);
 	} else {
 		dvobj->drv_dbg.dbg_sdio_alloc_irq_cnt++;
 		dvobj->irq_alloc = 1;
@@ -81,7 +80,7 @@ static int sdio_alloc_irq(struct dvobj_priv *dvobj)
 
 	sdio_release_host(func);
 
-	return err?_FAIL:_SUCCESS;
+	return err ? _FAIL : _SUCCESS;
 }
 
 static void sdio_free_irq(struct dvobj_priv *dvobj)
@@ -102,8 +101,9 @@ static void sdio_free_irq(struct dvobj_priv *dvobj)
 				netdev_err(dvobj->if1->pnetdev,
 					   "%s: sdio_release_irq FAIL(%d)!\n",
 					   __func__, err);
-			} else
+			} else {
 				dvobj->drv_dbg.dbg_sdio_free_irq_cnt++;
+			}
 			sdio_release_host(func);
 		}
 		dvobj->irq_alloc = 0;
@@ -169,6 +169,7 @@ static void sdio_deinit(struct dvobj_priv *dvobj)
 		sdio_release_host(func);
 	}
 }
+
 static struct dvobj_priv *sdio_dvobj_init(struct sdio_func *func)
 {
 	int status = _FAIL;
@@ -239,8 +240,8 @@ static void sd_intf_stop(struct adapter *padapter)
 	rtw_hal_disable_interrupt(padapter);
 }
 
-
-static struct adapter *rtw_sdio_if1_init(struct dvobj_priv *dvobj, const struct sdio_device_id  *pdid)
+static struct adapter *rtw_sdio_if1_init(struct dvobj_priv *dvobj,
+					 const struct sdio_device_id  *pdid)
 {
 	int status = _FAIL;
 	struct net_device *pnetdev;
@@ -273,7 +274,6 @@ static struct adapter *rtw_sdio_if1_init(struct dvobj_priv *dvobj, const struct
 	/* 4 3.1 set hardware operation functions */
 	rtw_set_hal_ops(padapter);
 
-
 	/* 3 5. initialize Chip version */
 	padapter->intf_start = &sd_intf_start;
 	padapter->intf_stop = &sd_intf_stop;
@@ -290,7 +290,7 @@ static struct adapter *rtw_sdio_if1_init(struct dvobj_priv *dvobj, const struct
 
 	rtw_hal_chip_configure(padapter);
 
-	hal_btcoex_Initialize((void *) padapter);
+	hal_btcoex_Initialize((void *)padapter);
 
 	/* 3 6. read efuse/eeprom data */
 	rtw_hal_read_chip_info(padapter);
@@ -359,9 +359,7 @@ static void rtw_sdio_if1_deinit(struct adapter *if1)
  * notes: drv_init() is called when the bus driver has located a card for us to support.
  *        We accept the new device by returning 0.
  */
-static int rtw_drv_init(
-	struct sdio_func *func,
-	const struct sdio_device_id *id)
+static int rtw_drv_init(struct sdio_func *func, const struct sdio_device_id *id)
 {
 	int status = _FAIL;
 	struct adapter *if1 = NULL;
@@ -501,6 +499,5 @@ static void __exit rtw_drv_halt(void)
 	rtw_ndev_notifier_unregister();
 }
 
-
 module_init(rtw_drv_entry);
 module_exit(rtw_drv_halt);
-- 
2.39.2

