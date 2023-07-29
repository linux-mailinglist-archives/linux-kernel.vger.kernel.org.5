Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25231767CF0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 09:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjG2HxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 03:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjG2HxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 03:53:22 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E069749F5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 00:53:07 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-98273ae42d0so75725066b.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 00:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690617186; x=1691221986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JtNNMKVctD5AB1/ghPcVnIk7MTbF2tjuWXvT1X7yr94=;
        b=fSMC6wj31p92FQd0M6sBG77NpbA8cMu7xV8Tf+cbWzl5ka0pLFp9d5WJ8r3iMOP5ZC
         63+koSetpSqAmMoaRGWTBIH6FKJwrFrZzdxMdxNpk8yB30FXRNIwAFHO7Liaf1PHS555
         eKWE+I4AlfJodfb23CnWQ74+huvAPms4nvDBn41vczmpgEoc/K8E8rRPoh8Nz9iMcAcr
         z6ghqrzdJVoACTnlSx8q48liBKBB2BgvdzymKalrsPGMVuYW79/wQBAjriAzAJI2ZTjx
         iwSOFw768I1wmqoJmSzUwmWg67mE/4u+cY361Uqo+d7Y/JO2ITxFO9s4DcKAcIbqJHyc
         DV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690617186; x=1691221986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtNNMKVctD5AB1/ghPcVnIk7MTbF2tjuWXvT1X7yr94=;
        b=X9APH05pVZB7h+K3E44fhqhTbZihnUELjz3SAuBSwoEo806tQln8nFp3QGelgSzJof
         kTGWpmvAFmcYiA+5a94Lw6cKRn2gSahmILY6HQ0MOT1qW0TVxVUjbN0Mv3Oq+PEJxQwg
         l6zWtYOdmbTRlQXFeuGNv+sccjmyh65aGYT3y2Alsr+vCotnXs+nbchZh1m+e5WO7FMj
         xPwA6K+0SJVfGTfxO+eaoYPY2jKXVwnZefhRy8pr9c0vYRFDoGFJHUQlQUraNhzalGPD
         Lxqkj0PBegVCIijwIrTLxbVj8O/oilrpi0/TkaJG9nRLpfvuGRlawh9bs7HTgs6ga7SX
         +zQg==
X-Gm-Message-State: ABy/qLZzt4LwyrC/mX7lXdzkq3UysS4/eX6nCRBSWL9iRSICi3/vIwU8
        Ha28Dok0NPRJlJVIGM9zrk0=
X-Google-Smtp-Source: APBJJlHTzHLEeG0vOMaH+EkCFgU3IUP7z+nK1TOpr2dvGXKiJ+2zB5geKAdvUyZFiQQfGdHQf15nAQ==
X-Received: by 2002:a17:906:20d0:b0:993:eed1:8f7 with SMTP id c16-20020a17090620d000b00993eed108f7mr1467115ejc.3.1690617186162;
        Sat, 29 Jul 2023 00:53:06 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id n21-20020a170906689500b009944e955e19sm2974774ejr.30.2023.07.29.00.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 00:53:05 -0700 (PDT)
Date:   Sat, 29 Jul 2023 09:53:03 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] staging: rtl8192e: Remove empty function
 rtllib_rx_Mesh()
Message-ID: <7c1aee16a95cd52149faf80c83b6fa19d6499913.1690615475.git.philipp.g.hortmann@gmail.com>
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

Function rtllib_rx_Mesh() returns always 0. Variable ret is already
initialized with 0. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index b9d220b015f6..8a4029f26835 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1473,12 +1473,6 @@ static int rtllib_rx_Monitor(struct rtllib_device *ieee, struct sk_buff *skb,
 	return 1;
 }
 
-static int rtllib_rx_Mesh(struct rtllib_device *ieee, struct sk_buff *skb,
-		 struct rtllib_rx_stats *rx_stats)
-{
-	return 0;
-}
-
 /* All received frames are sent to this function. @skb contains the frame in
  * IEEE 802.11 format, i.e., in the format it was sent over air.
  * This function is called only as a tasklet (software IRQ).
@@ -1509,7 +1503,6 @@ int rtllib_rx(struct rtllib_device *ieee, struct sk_buff *skb,
 		ret = rtllib_rx_Monitor(ieee, skb, rx_stats);
 		break;
 	case IW_MODE_MESH:
-		ret = rtllib_rx_Mesh(ieee, skb, rx_stats);
 		break;
 	default:
 		netdev_info(ieee->dev, "%s: ERR iw mode!!!\n", __func__);
-- 
2.41.0

