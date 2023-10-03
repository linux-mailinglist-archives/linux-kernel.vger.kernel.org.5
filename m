Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BE67B71CE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240957AbjJCTeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240956AbjJCTd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:33:57 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40D0AF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:33:50 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9ae65c0e46fso53973066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 12:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696361629; x=1696966429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o0RrMuYVrq3C/m7QhaLpLvy+gp+gXjLQFOpM9VmMeE8=;
        b=iwoIcPttLzx6IH16t+lS2xK0hLtXCfq7lrNyN4pyNL0jS83yk07Lj+VfRIMbgTnCZ9
         LuRDwVF6zYXyECW2mziwWSVCU9OCH741fknCOBJZTfv5NphHLFj8iMp0mBQH1unIs2pe
         SfUS+y9L8ldURcniaigBxmI84GOm7WbkMpnt+lPw4we+iqlLY3E5HshEFsQDwdgOnMuc
         MBIPF0tnnqwQSphtXhA0gSTtF5X+hIIrSstMskbng2F6M7Bq76xyXthU1OhD9v7peDj1
         mS9wodYNgoyFlWH3CdI+/o0u+C65tRIp94hXBkOR4aP8adDzX4QGBI1LwQ3pEJ65GIPr
         KBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696361629; x=1696966429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0RrMuYVrq3C/m7QhaLpLvy+gp+gXjLQFOpM9VmMeE8=;
        b=GgB1sakdpoxWFM/l6YWWBZRcw6ZCFjm7uSJHJuONPw/rSEDlJ44He10KCR7Jy8l1+N
         uCThJ1AAZvsC7bP0aoldpMVIpZ8BPCiM52Xef0WOBatSsQyZERA/mCzW3o5VvAVhCjgz
         M/maaiVyATin/5Whgnyjm3vYRtEtsTozxAMim/NuUEn9uQvhoEUTQQVv1Z0TskNPL4Uu
         /E8jYWyF+zXHi0j3Cr4EbMXQBfWEY9M1An88hwCQuqXKaP3oEbS3iP7iw8BvS3yaBMAJ
         9f+6r2ALA3uDtgVHfz4GHwKQupYa7GHC+yeAWHirsuJaz0hphU1ePF2WI5G3wa7tUv7+
         yCiQ==
X-Gm-Message-State: AOJu0YyWOUXPM7yUiEvt1evMG39VdNWklm0YHjkDjO3EXrf02aEq9OB7
        hS+m417ecQQMXF1w31Frt6Y=
X-Google-Smtp-Source: AGHT+IHobplVFBd7oTI8JXZLs5UOsJpJEOw3+xuRTqAxwNWNs97e7p5j/GdH4pDpzGTJdRNktyW79g==
X-Received: by 2002:a17:906:29a:b0:9a6:ae76:d6ae with SMTP id 26-20020a170906029a00b009a6ae76d6aemr101117ejf.3.1696361629349;
        Tue, 03 Oct 2023 12:33:49 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id kj6-20020a170907764600b009b2c9476726sm1535909ejc.21.2023.10.03.12.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 12:33:49 -0700 (PDT)
Date:   Tue, 3 Oct 2023 21:33:47 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] staging: rtl8192e: Remove function
 _rtl92e_wx_get_promisc_mode()
Message-ID: <8b1735a3f249b1cf73189e98a07e134c5cd50974.1696360404.git.philipp.g.hortmann@gmail.com>
References: <cover.1696360403.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696360403.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove function _rtl92e_wx_get_promisc_mode() as this functionality is
not commonly used and the tool to access it is deprecated.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 34 ----------------------
 1 file changed, 34 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index 2f5acdd71339..d0b68b258af7 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -918,25 +918,6 @@ static int _rtl92e_wx_get_gen_ie(struct net_device *dev,
 	return ret;
 }
 
-static int _rtl92e_wx_get_promisc_mode(struct net_device *dev,
-				       struct iw_request_info *info,
-				       union iwreq_data *wrqu, char *extra)
-{
-	struct r8192_priv *priv = rtllib_priv(dev);
-	struct rtllib_device *ieee = priv->rtllib;
-
-	mutex_lock(&priv->wx_mutex);
-
-	snprintf(extra, 45, "PromiscuousMode:%d, FilterSrcSTAFrame:%d",
-		 ieee->intel_promiscuous_md_info.promiscuous_on,
-		 ieee->intel_promiscuous_md_info.fltr_src_sta_frame);
-	wrqu->data.length = strlen(extra) + 1;
-
-	mutex_unlock(&priv->wx_mutex);
-
-	return 0;
-}
-
 #define IW_IOCTL(x) ((x) - SIOCSIWCOMMIT)
 static iw_handler r8192_wx_handlers[] = {
 	[IW_IOCTL(SIOCGIWNAME)] = _rtl92e_wx_get_name,
@@ -995,9 +976,6 @@ static const struct iw_priv_args r8192_private_args[] = {
 		SIOCIWFIRSTPRIV + 0xb,
 		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, IW_PRIV_TYPE_NONE,
 		"lps_force"
-	}, {
-		SIOCIWFIRSTPRIV + 0x17,
-		0, IW_PRIV_TYPE_CHAR | IW_PRIV_SIZE_FIXED | 45, "getpromisc"
 	}
 
 };
@@ -1015,18 +993,6 @@ static iw_handler r8192_private_handler[] = {
 	(iw_handler)NULL,
 	(iw_handler)_rtl92e_wx_set_lps_awake_interval,
 	(iw_handler)_rtl92e_wx_set_force_lps,
-	(iw_handler)NULL,
-	(iw_handler)NULL,
-	(iw_handler)NULL,
-	(iw_handler)NULL,
-	(iw_handler)NULL,
-	(iw_handler)NULL,
-	(iw_handler)NULL,
-	(iw_handler)NULL,
-	(iw_handler)NULL,
-	(iw_handler)NULL,
-	(iw_handler)NULL,
-	(iw_handler)_rtl92e_wx_get_promisc_mode,
 };
 
 static struct iw_statistics *_rtl92e_get_wireless_stats(struct net_device *dev)
-- 
2.42.0

