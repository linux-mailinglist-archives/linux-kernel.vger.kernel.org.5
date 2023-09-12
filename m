Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DE779D98D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbjILT2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235851AbjILT2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:28:32 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B2E199
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 12:28:28 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-401e6ce2d9fso17514355e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 12:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694546907; x=1695151707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VFhh3RYguSGZkGRqPmnmCXiDYtANu+EmtRXu+PYPOCI=;
        b=TD8fwNEB0ggJEY5mQyRUFyCA/icXFZariJH2zpYQ94Q/JaZygT1mjg/NsrMD6tEGfW
         A8vaVHrIvr05Pza9c2f6Rf47AYXoCcNDifpOj85CVdKcWCUqitrv0Vo/jdd4rVSB5hjL
         nwVBxb5NUhj0pGniZn4VqpYpeZJp1u22+GTD46LBXxI2QMpPBvx14PdM+wnWQx3CZJiQ
         II6+ZV/HmbyRvxdKU7LxEnN2VKNRY1DSwOYbPyvdYdKMnZaJAcCsnrVan9KQKbhw4FKg
         cpsIAzybvJGAB9pU9B03pSDtoe+WhGwymefqlMLEPdip+JrJ7yPY77kR6ZJVQRRFbmub
         ehBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694546907; x=1695151707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFhh3RYguSGZkGRqPmnmCXiDYtANu+EmtRXu+PYPOCI=;
        b=Lf1Ioq6eY7TvhsHDXtEf2xO43yv90Z0LSuM2bpdBNcLaot+5nEoJcbwGKBs2SGEqPz
         TRGZ8n+GOZdQt6vTppj2TljTIByGRgN7DONxjFRn2CcAnFH/zyuiaKvxqMNzkTsTJ8mS
         nXraH+3aYqMgbZ2jax4Sfa97OwxNqPDniFmLC61WpBblTDOs5ECyqGnP3esJhRifvc/i
         eICbeXnu6EKcYS6CMt9drHVWpxJRToLwLTuFaue5OSSQM7qIQQ1U7DzHRDYnpSrh7JW7
         1HpU99ZU8b0rdCu6qPkWG6yvBbfMPPtgrAChYNJSsBcNS9L5R6fAZmdbLeC7V/SEgjT0
         LWDA==
X-Gm-Message-State: AOJu0Yw5oHXHCYxdMuIV2DGz7IC6MKCdAiQfYlFhllGwQ2QVxUQZa+nQ
        04J0AGUTQaRw0Tj+To/4Cr5u/U60sd7LXQ==
X-Google-Smtp-Source: AGHT+IEWeO9Hgpc5nHkKHmZJfxWb6esn5cYbn63twoTBUk9Fy18fYsflOzliC1ojWtha+ePEtaKcKQ==
X-Received: by 2002:a05:600c:314b:b0:401:c6a2:3cd5 with SMTP id h11-20020a05600c314b00b00401c6a23cd5mr299818wmo.2.1694546906801;
        Tue, 12 Sep 2023 12:28:26 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id l40-20020a05600c1d2800b00402f7b50517sm13840629wms.40.2023.09.12.12.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 12:28:26 -0700 (PDT)
Date:   Tue, 12 Sep 2023 21:28:25 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] staging: rtl8192e: Use standard function in
 rtllib_rx_check_duplicate()
Message-ID: <b74b6ef5e266504b9e3d84495bcd8fe4978b4ded.1694546300.git.philipp.g.hortmann@gmail.com>
References: <cover.1694546300.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694546300.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use standard function ieee80211_is_beacon() to avoid proprietary code and
to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
v1->v2: Take wrongly removed definition of fc back in.
---
 drivers/staging/rtl8192e/rtllib_rx.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 89c8d66765fe..7c16d4db67ad 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -904,11 +904,9 @@ static int rtllib_rx_check_duplicate(struct rtllib_device *ieee,
 {
 	struct rtllib_hdr_4addr *hdr = (struct rtllib_hdr_4addr *)skb->data;
 	u16 fc, sc;
-	u8 frag, type, stype;
+	u8 frag;
 
 	fc = le16_to_cpu(hdr->frame_ctl);
-	type = WLAN_FC_GET_TYPE(fc);
-	stype = WLAN_FC_GET_STYPE(fc);
 	sc = le16_to_cpu(hdr->seq_ctl);
 	frag = WLAN_GET_SEQ_FRAG(sc);
 
@@ -916,8 +914,7 @@ static int rtllib_rx_check_duplicate(struct rtllib_device *ieee,
 		!ieee->current_network.qos_data.active ||
 		!IsDataFrame(skb->data) ||
 		IsLegacyDataFrame(skb->data)) {
-		if (!((type == RTLLIB_FTYPE_MGMT) &&
-		      (stype == RTLLIB_STYPE_BEACON))) {
+		if (!ieee80211_is_beacon(hdr->frame_ctl)) {
 			if (is_duplicate_packet(ieee, hdr))
 				return -1;
 		}
-- 
2.42.0

