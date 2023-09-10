Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25CF799E9C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 16:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243376AbjIJOGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 10:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjIJOGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 10:06:04 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6C2CC5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 07:05:59 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31dcf18f9e2so3558748f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 07:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694354757; x=1694959557; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L9zTfLEefQSg+FCeLVUeQsY+dv2zrbCIrvEk0gyu8Qs=;
        b=V5QEelikLWOFK3z2Pp2V/uwIvJEk4sr9EQxoCv98X+c1ncrFnGJe/FgSqnnJUbUl/0
         E0pDSfNuodiET/FOb4VuHK0W2yHNJU5s6P2mb+ZFAmxJfweLRpZYtOm1uHZAp/q3wC/s
         86IqaiVzF4j1H5fKXrzeRfFOYEgde+/gsbz6FWJ3jX+rOwWyZEbyGKr/fiEsqR3iFKf0
         S8mBPphVIqWLy5HuLF54TbvLhP+ld0r5ysddzMs2PCbqijGdXNdpuB93+UkyJrv5ahRq
         UuVR9m79P+7E1RPthsydI8uOehWffJyUrmJ8bF3Pk8Md2WDee4GiEBt5isnrMGeFLcEF
         CXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694354757; x=1694959557;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L9zTfLEefQSg+FCeLVUeQsY+dv2zrbCIrvEk0gyu8Qs=;
        b=Sl1bhb7+vPMgNIL61FXYZ3VGlOUgiNMZsNWBg9OkHq/Wi/miNWpnfcnS9+9qknFu/n
         iQAYRYuU0v5cNTL/uJzwe7Ii3spaVcQ2U2VtPuPuJrw4D5G2tsGaSmg9rKqqLhzjePn4
         WmoZnA+t/7/+DnUq6yw9rUz7r+06eZbtJVhx/vw6If9DoHruXcLbmOrTC42wiAQX9aYR
         Cu53aGe4y4xA6n2L+Kw/BwANbaJUMNeVC61XU2FbxxOSb9TdukaZAjfYdczujHCrGkRS
         XIokUxzqMe8dAXn46vWHUI0/tFRmRWKYPxW729DaRivJIBuKGlgGBxYa809jUyO5u8ii
         pYIA==
X-Gm-Message-State: AOJu0YzHnbWGzL65YX3KkQrg4kyK2X1tKgaqtO65ECuusLYOrMEUWtk6
        Igi2o74t7hHrAKBjZxxfIBUBCl9KOxIKPw==
X-Google-Smtp-Source: AGHT+IGiIP1LCVYGCbKGbK5jIv7WgPIaD+hCnxAjqKZjbbb4i9IEUX1MZ7toWvkhaq1sYQn70CPUrg==
X-Received: by 2002:adf:f3c9:0:b0:313:ecd3:7167 with SMTP id g9-20020adff3c9000000b00313ecd37167mr5060916wrp.42.1694354756710;
        Sun, 10 Sep 2023 07:05:56 -0700 (PDT)
Received: from daniel-ubuntu ([94.202.157.108])
        by smtp.gmail.com with ESMTPSA id j12-20020adfe50c000000b003176aa612b1sm7389425wrm.38.2023.09.10.07.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 07:05:56 -0700 (PDT)
Date:   Sun, 10 Sep 2023 18:05:53 +0400
From:   Daniel Hammer <daniel.hammer120@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wlan-ng: prism2mgmt.c: remove needless parentheses
 to align with kernel coding style.
Message-ID: <ZP3NQSQwnmYAHQq+@daniel-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses as detected by checkpatch.pl.

Signed-off-by: Daniel Hammer <daniel.hammer120@gmail.com>
---
 drivers/staging/wlan-ng/prism2mgmt.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/wlan-ng/prism2mgmt.c b/drivers/staging/wlan-ng/prism2mgmt.c
index d5737166564e..201f07229962 100644
--- a/drivers/staging/wlan-ng/prism2mgmt.c
+++ b/drivers/staging/wlan-ng/prism2mgmt.c
@@ -1227,9 +1227,9 @@ int prism2mgmt_wlansniff(struct wlandevice *wlandev, void *msgp)
 				     word, result);
 				goto failed;
 			}
-			if ((msg->keepwepflags.status ==
-			     P80211ENUM_msgitem_status_data_ok) &&
-			    (msg->keepwepflags.data != P80211ENUM_truth_true)) {
+			if (msg->keepwepflags.status ==
+			     P80211ENUM_msgitem_status_data_ok &&
+			    msg->keepwepflags.data != P80211ENUM_truth_true) {
 				/* Set the wepflags for no decryption */
 				word = HFA384x_WEPFLAGS_DISABLE_TXCRYPT |
 				    HFA384x_WEPFLAGS_DISABLE_RXCRYPT;
@@ -1249,9 +1249,9 @@ int prism2mgmt_wlansniff(struct wlandevice *wlandev, void *msgp)
 		}
 
 		/* Do we want to strip the FCS in monitor mode? */
-		if ((msg->stripfcs.status ==
-		     P80211ENUM_msgitem_status_data_ok) &&
-		    (msg->stripfcs.data == P80211ENUM_truth_true)) {
+		if (msg->stripfcs.status ==
+		     P80211ENUM_msgitem_status_data_ok &&
+		    msg->stripfcs.data == P80211ENUM_truth_true) {
 			hw->sniff_fcs = 0;
 		} else {
 			hw->sniff_fcs = 1;
@@ -1288,9 +1288,9 @@ int prism2mgmt_wlansniff(struct wlandevice *wlandev, void *msgp)
 
 		/* Set the driver state */
 		/* Do we want the prism2 header? */
-		if ((msg->prismheader.status ==
-		     P80211ENUM_msgitem_status_data_ok) &&
-		    (msg->prismheader.data == P80211ENUM_truth_true)) {
+		if (msg->prismheader.status ==
+		     P80211ENUM_msgitem_status_data_ok &&
+		    msg->prismheader.data == P80211ENUM_truth_true) {
 			hw->sniffhdr = 0;
 			wlandev->netdev->type = ARPHRD_IEEE80211_PRISM;
 		} else if ((msg->wlanheader.status ==
-- 
2.34.1

