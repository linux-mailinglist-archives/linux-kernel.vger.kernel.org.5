Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F7876336E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbjGZKXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbjGZKXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:23:06 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3321FF3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:23:00 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5222bc91838so4973522a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690366979; x=1690971779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QY6O4JMKcAmB6QZ1MNPutfIOv3s7LyNGyN9dXItuO8=;
        b=AeyaPuhAHwTungo++3Xd600Rig9S4IdFepMHcR2z92PYyXUur85MBInZDBo0ScaIq3
         oedajDSNkD3UHN5Cl6X59D8ArTNxMQ9oeUYo86Kl5D0ImCw+Fp/AV7yqrLZeRr51E2GO
         vzBHo96Dj5xJPdUnVf8VsmZIG6xTqVat3eLuwW41SYjfVpF3QFwun4Z0ld1QsFIo8Tq1
         lDnJO8lZUFTpRC1XPJfW55UupOxft4c0jQLqbJQhFvpY94d2vsQnyPScfgVVZrTikzzc
         geRchpDGMJ/16WaBHGaiw8zPdDtQt3Z6+aTNAgK/hU4VwZSZh0+xAYWbamSuTgawi66Q
         uKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690366979; x=1690971779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QY6O4JMKcAmB6QZ1MNPutfIOv3s7LyNGyN9dXItuO8=;
        b=FPTsI02zc0qJgIkhpfKShpITlUZk+mVot2T7mgkYTetMgtAKG8jnOqKM/RxyR3FZC9
         ZlooUblSuEqRlLvgj3ba293xHp2Po7A1PuhxZM37c/3qD+aa3oQovOX5oQymevkbcqdf
         Ld9sHNCWZs3vInt5XlfahWvO6fX8P7kbT/ABMSpAMquMQpqtULGUEi3BiJIIxtbkYQdr
         ZWcJrb5/KD9KA4Kcqggnn0FJHDRPKljciKykuUfqFVPX5acCp1eKZ3tg6w7bYdm+bMx/
         KphgAkggZmOSI6rVuzGKLjd6gJhZqaMT/DVgXTkiLeVrbbBeGYvEbJJMo18sinohxbYS
         i/rQ==
X-Gm-Message-State: ABy/qLbHYne1bhZyrzY8qK/GKpfvs75v9E5/rio7pHPi9W9TYlDnS3+A
        Bh9oPl+O0zpXrCbt2qRpM745/g==
X-Google-Smtp-Source: APBJJlGsBFjlnQQY/dz2cDxA2af5Xf4zcALlyaB140hrR2z7rMU2kEHrQZJZsvWACLXRU/10FqaxmQ==
X-Received: by 2002:a17:907:762b:b0:99b:c949:5ef8 with SMTP id jy11-20020a170907762b00b0099bc9495ef8mr886245ejc.54.1690366978993;
        Wed, 26 Jul 2023 03:22:58 -0700 (PDT)
Received: from blaptop.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q16-20020a170906b29000b00992316f0690sm9450258ejz.74.2023.07.26.03.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 03:22:58 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     hminas@synopsys.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [RFC PATCH 1/1] usb: dwc2: Don't set DEV_DMA_L by default for isoc transfer
Date:   Wed, 26 Jul 2023 12:22:52 +0200
Message-ID: <20230726102252.2236314-2-abailon@baylibre.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726102252.2236314-1-abailon@baylibre.com>
References: <20230726102252.2236314-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, by default, we set DEV_DMA_L to notify DMA that the current
descriptor is the last one.
But, to get better performances, the driver doesn't stop the DMA and add
a new descriptor at the end of the list and clear DEV_DMA_L bit from
previous descriptor. This works well except if the DMA has already fetched
the descriptor. Updating the descriptor owned by DMA can cause some issues.

This updates the driver to no update descriptor while it is in use.
Instead, this assumes that we are always going to queue a request
and feed the DMA with new descriptors.
In case where we don't feed the DMA, we stop the transfer using a BNA.

NOTE:
To be tested!!!
Currently, only tested and validated using UAC2.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 drivers/usb/dwc2/gadget.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 8b15742d9e8a..c542811468ce 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -928,10 +928,6 @@ static int dwc2_gadget_fill_isoc_desc(struct dwc2_hsotg_ep *hs_ep,
 		return 1;
 	}
 
-	/* Clear L bit of previous desc if more than one entries in the chain */
-	if (hs_ep->next_desc)
-		hs_ep->desc_list[index - 1].status &= ~DEV_DMA_L;
-
 	dev_dbg(hsotg->dev, "%s: Filling ep %d, dir %s isoc desc # %d\n",
 		__func__, hs_ep->index, hs_ep->dir_in ? "in" : "out", index);
 
@@ -939,8 +935,9 @@ static int dwc2_gadget_fill_isoc_desc(struct dwc2_hsotg_ep *hs_ep,
 	desc->status |= (DEV_DMA_BUFF_STS_HBUSY	<< DEV_DMA_BUFF_STS_SHIFT);
 
 	desc->buf = dma_buff;
-	desc->status |= (DEV_DMA_L | DEV_DMA_IOC |
-			 ((len << DEV_DMA_NBYTES_SHIFT) & mask));
+	desc->status |= (DEV_DMA_IOC | ((len << DEV_DMA_NBYTES_SHIFT) & mask));
+	if ((hs_ep->next_desc+1) >= MAX_DMA_DESC_NUM_HS_ISOC)
+		desc->status |= DEV_DMA_L;
 
 	if (hs_ep->dir_in) {
 		if (len)
@@ -968,6 +965,15 @@ static int dwc2_gadget_fill_isoc_desc(struct dwc2_hsotg_ep *hs_ep,
 	if (hs_ep->next_desc >= MAX_DMA_DESC_NUM_HS_ISOC)
 		hs_ep->next_desc = 0;
 
+
+	/*
+	 * Safeguard: Make sure we stop transfer if we don't have a valid descriptor.
+	 */
+	index = hs_ep->next_desc;
+	desc = &hs_ep->desc_list[index];
+	desc->status = 0;
+	desc->status |= (DEV_DMA_BUFF_STS_HBUSY	<< DEV_DMA_BUFF_STS_SHIFT);
+
 	return 0;
 }
 
-- 
2.41.0

