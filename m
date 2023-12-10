Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EEE80BBF2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 16:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbjLJP0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 10:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjLJP0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 10:26:16 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC15E11A
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 07:26:21 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40b36e721fcso7375665e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 07:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702221980; x=1702826780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fHHEx4HhN/ZzvVnFKWTOzaSwu+z7Yx7t+wmiq/WZcOk=;
        b=ZODsqg3MlFhIbYKFa5XC1JS0q8/5t2RhMhP4m8yLUG5QQOPOEBSA9WPQ0P9QztHC52
         mUn3OgDWISSt1fd/XwRFg4r6btFaMA2k3mX8G1FSjgAoLfAozHy57idvA/bhRXcAQEBW
         Go7UQAkcOYV7gpw//d3kwoKB42lOsgC2u1hFOIBzc3K5tnWyY9f+DvLnKTUuR34u1Rc5
         QIF3i79O4JRVO+AccUJ/zGajK6ZAflPzaXkrlkgqd/iIrMClVtfRBIpZA+kwwnzoDid8
         hpTTvc7v086miYcKqIP2Sg0lpbLE00JZaqRYwpBiwIAFg0EqPcJj7Azid95W6f/Tyu37
         AFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702221980; x=1702826780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHHEx4HhN/ZzvVnFKWTOzaSwu+z7Yx7t+wmiq/WZcOk=;
        b=jc2Zx/5YWKlHZC+l/TgHYX3h0Cn5ia7u+5aeWp7Ih6A+Ph60+WUBTsHvyoft8ZtzMB
         FYsw6YyV9PkXXi0nvZ+7siPOu6PoNXpkEDbmagXdhdlPrK2jXjaqEuonidupnbmsuI2g
         AP89vVQ9vKhogEaYiNU0BJf6E3CwuimsMi9xaZ7okc2OJmbi07APEbSEPxatlYLPzJCi
         QPZiA4D37iN9rA9GyRlnHS5/Wj8kM2DsdpZuSwe1UqPV/RNT/tG7raeL/3hzlhY/oYJB
         d//9ZvZkbDcfsBFdczfxgcN0k9zgIwiDXe28oYqieQrpDk8mmWE2PTgsf1mqcVC26jqp
         ksKA==
X-Gm-Message-State: AOJu0Yw0jE1so14QwPeVlRBptSyd1xHSFGtxeDvR0vf9BIWOpq3eWxUu
        4+X9tP6xonqFo7NVWDZGfkE=
X-Google-Smtp-Source: AGHT+IFOsbIAp+/L+GqcUlyiseulJCLY2ArDFGZzJbFClxY3Zhcm+QVMnFMsDiUIRwD7wi0XpNvs0A==
X-Received: by 2002:a05:600c:1c86:b0:3fe:d637:7b25 with SMTP id k6-20020a05600c1c8600b003fed6377b25mr4069911wms.0.1702221979935;
        Sun, 10 Dec 2023 07:26:19 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id jg8-20020a05600ca00800b0040b54335d57sm12141082wmb.17.2023.12.10.07.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 07:26:19 -0800 (PST)
Date:   Sun, 10 Dec 2023 16:26:18 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] staging: rtl8192e: Remove variable
 ht_info->reg_supp_cck
Message-ID: <2c9be9efb1c0608a7fc2658d813b9adbc1185db1.1702212003.git.philipp.g.hortmann@gmail.com>
References: <cover.1702212003.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1702212003.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ht_info->reg_supp_cck is set to 1 and unchanged. Therefore all equations
result accordingly and ht_info->reg_supp_cck can be removed.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 1 -
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 8 ++------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index bbfdfb79c6f2..6556c5df958d 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -99,7 +99,6 @@ struct rt_hi_throughput {
 	u8 cur_short_gi_40mhz;
 	u8 reg_short_gi_20mhz;
 	u8 cur_short_gi_20mhz;
-	u8 reg_supp_cck;
 	u8 bCurSuppCCK;
 	enum ht_spec_ver ePeerHTSpecVer;
 	struct ht_capab_ele SelfHTCap;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index f81d9ba9c9f5..7acc8b4c11c4 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -74,8 +74,6 @@ void ht_update_default_setting(struct rtllib_device *ieee)
 	ht_info->reg_short_gi_20mhz = 1;
 	ht_info->reg_short_gi_40mhz = 1;
 
-	ht_info->reg_supp_cck = 1;
-
 	ht_info->amsdu_max_size = 7935UL;
 	ht_info->amsdu_support = 0;
 
@@ -281,7 +279,7 @@ void HTConstructCapabilityElement(struct rtllib_device *ieee, u8 *posHTCap,
 	pCapELE->RxSTBC			= 0;
 	pCapELE->DelayBA		= 0;
 	pCapELE->MaxAMSDUSize = (MAX_RECEIVE_BUFFER_SIZE >= 7935) ? 1 : 0;
-	pCapELE->DssCCk = (pHT->reg_supp_cck ? 1 : 0);
+	pCapELE->DssCCk = 1;
 	pCapELE->PSMP = 0;
 	pCapELE->LSigTxopProtect = 0;
 
@@ -480,9 +478,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 				     ((pPeerHTCap->ShortGI40Mhz == 1) ?
 				     true : false) : false);
 
-	ht_info->bCurSuppCCK = ((ht_info->reg_supp_cck) ?
-			       ((pPeerHTCap->DssCCk == 1) ? true :
-			       false) : false);
+	ht_info->bCurSuppCCK = ((pPeerHTCap->DssCCk == 1) ? true : false);
 
 	ht_info->bCurrent_AMSDU_Support = ht_info->amsdu_support;
 
-- 
2.43.0

