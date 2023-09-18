Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A52E7A4F80
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjIRQo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjIRQoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:44:25 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB8A59DA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:43:08 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4046f7d49a9so14370565e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695055387; x=1695660187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ruq6IMO2lTDXcNQxdpreOyS38HS9l5XKxLPIpBNqQNk=;
        b=jx127TXCDOvKDZ2zVWF3kD+NoL2+DaFjgAUUjhmpbpaowy7B+zyH+R3RYUE6N/qksZ
         8bmPuzuh989BlrapzmT1z+q/mv/7ncUUYcKg7/rbqXGseiFeBpno9+3kl10ZZJvvdli6
         eAXN+DDBOM1kMUFyAvExn954pdOPBMdHrQQmjBeL1M24hGgh6Ki3Djst0P32cVSmdDfH
         EZPpsdJ0oP1ZSj30xsWcvMqCQ7DaF9EsjKW3n7SYucxgyQPWSL+mKGQRcHv8c10gqdgO
         uZLU+B6HA6g43FHdIOhk5f22+3y1W4E+uDAmgnIrjKwXH4np1b3RbQ6dQlVF4Tt8Ebea
         H3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695055387; x=1695660187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ruq6IMO2lTDXcNQxdpreOyS38HS9l5XKxLPIpBNqQNk=;
        b=APyevwZevCeMbXV9+z/WyXgspJSMTHwOEhPcy6efnX25itTRdSKrqTkzTZbgPhFg2E
         ulhVPulaT7Q1TFz5DjoT/pFUtJTzLH8+EOuOKRbOr2ltkiXMn0X2R3YvbELnAYTTFg88
         iqi5Tgji3DMAaT1nE0QHrnjTTBDHmGlHcOz6Br5PHZmvRtE4BJrV2lLu7BoZUI6++gqN
         u4WFR51dHoijRwmvhKRJ1f70VNq80zrbZngAOFX3oZ63vN7TOMweaySz3w2cBor3Qa2C
         O7nY0BLRdSq68EYY04O7WCzww/raEcbsNZjBiIXksb0cZKrSsDTYEi3Uys4gpjjyjJtx
         oYEQ==
X-Gm-Message-State: AOJu0YxabBH8dXvLuw0e8Is+4VoecQlgdqfQKb7gSpSLX3xfLpOFpL6o
        gAHOpS8jLz8G9R4KAZ4121dSwkym3Nq+Bw==
X-Google-Smtp-Source: AGHT+IFPI+l/sh5ZJkDOFkf7/cvVILK9nAx5PDkk9MnFFcbVlcO+ZIQqqW5+6/M+xIJQV71rmF70Yg==
X-Received: by 2002:a5d:484a:0:b0:316:ef5f:7d8f with SMTP id n10-20020a5d484a000000b00316ef5f7d8fmr7602213wrs.3.1695055386501;
        Mon, 18 Sep 2023 09:43:06 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id m12-20020a056000024c00b0031989784d96sm10957489wrz.76.2023.09.18.09.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 09:43:06 -0700 (PDT)
Date:   Mon, 18 Sep 2023 18:43:04 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: rtl8192e: Fix alignment of structs in rtllib.h
 to two
Message-ID: <3140277dca915a1af9f66b1e7b4b47f5c7f6cd77.1695054044.git.philipp.g.hortmann@gmail.com>
References: <cover.1695054044.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1695054044.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix alignment of structs to even addresses to support all architectures.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309171733.Gl96cmYd-lkp@intel.com/
Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 5517b9df65be..7d26910a0b16 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -642,23 +642,23 @@ struct rtllib_authentication {
 	__le16 status;
 	/*challenge*/
 	struct rtllib_info_element info_element[];
-} __packed;
+} __packed __aligned(2);
 
 struct rtllib_disauth {
 	struct ieee80211_hdr_3addr header;
 	__le16 reason;
-} __packed;
+} __packed __aligned(2);
 
 struct rtllib_disassoc {
 	struct ieee80211_hdr_3addr header;
 	__le16 reason;
-} __packed;
+} __packed __aligned(2);
 
 struct rtllib_probe_request {
 	struct ieee80211_hdr_3addr header;
 	/* SSID, supported rates */
 	struct rtllib_info_element info_element[];
-} __packed;
+} __packed __aligned(2);
 
 struct rtllib_probe_response {
 	struct ieee80211_hdr_3addr header;
@@ -669,7 +669,7 @@ struct rtllib_probe_response {
 	 * CF params, IBSS params, TIM (if beacon), RSN
 	 */
 	struct rtllib_info_element info_element[];
-} __packed;
+} __packed __aligned(2);
 
 /* Alias beacon for probe_response */
 #define rtllib_beacon rtllib_probe_response
@@ -680,7 +680,7 @@ struct rtllib_assoc_request_frame {
 	__le16 listen_interval;
 	/* SSID, supported rates, RSN */
 	struct rtllib_info_element info_element[];
-} __packed;
+} __packed __aligned(2);
 
 struct rtllib_assoc_response_frame {
 	struct ieee80211_hdr_3addr header;
@@ -688,7 +688,7 @@ struct rtllib_assoc_response_frame {
 	__le16 status;
 	__le16 aid;
 	struct rtllib_info_element info_element[]; /* supported rates */
-} __packed;
+} __packed __aligned(2);
 
 struct rtllib_txb {
 	u8 nr_frags;
-- 
2.42.0

