Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32C080BBEF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 16:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjLJPZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 10:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjLJPZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 10:25:55 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F251C4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 07:26:01 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40b36e721fcso7374855e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 07:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702221960; x=1702826760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1HxTpgRZMqUaasDK2SQoows7vTW70XnRViyUroMPu9U=;
        b=njlxZ3SVKMNr1PdGKRq/wNtb7vSLaJi3Nnj53UeSUVtse+LfNEI6Vxk0o5CTD8imtK
         aeLuHEOvi1GxsKG+upcscV6q2oHdR2Jl2oOPQDC8nxo2u3UDh6FR2WXD1n8yCJDPDa7b
         p+SGSee5JblKivTt7/1Jihs6qCEgPQtkfPLCqPwdLb/FLkFnrumjhBJqAP6r1d1ERHu1
         qiY6vraehAgz8hhKsOLR8OyCzqMBMca8uxtq96bMvxf0TFxF2KVla3Mbchms0dsqmfpJ
         929hRwQpvQ66BMpZKtc8/ZK+lMZCXJkM3CRTmXUIZgLDvq9e4dfGzJqq+9zEsBNrOX46
         jFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702221960; x=1702826760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HxTpgRZMqUaasDK2SQoows7vTW70XnRViyUroMPu9U=;
        b=pTJPD/xpLw4zbY3q7I8TmMnjRsGgQ1/RoXr8Xe4iLT2uSQ/8lFdGp4sh1I473q+s4S
         zsVc6WYd6n3osqWWwR2nDwT/hEASSruBCCDytyXYuNRav7P1nrsk0bAXQpCJOSkEFLM3
         9f1F88oFhBpxz5ANZDocDQ5dlf0Tb2pyXIdWRW2DKxGcAJMjfT+UKqgmLOxDb/18xag+
         PaPMnw7UgV+i63oj7cB2b3ePSnmrMss2oDqKzeVYBmjbU12y6SKNSeuZDPkKOdJ6RTqS
         fpMCe5PIpnbkcxa3dVUQfhYY/BZDVeJPa1EjYVDWv8dggjcQg+4rY8BtMh41uSK7+GOD
         6pxw==
X-Gm-Message-State: AOJu0YzYuhNDEo8STBy0op3LHJC9kZLWHdYK8fG3fSbKmt04SW7GnmH4
        00s8LJh4KGkyyWq6UkZnlvU=
X-Google-Smtp-Source: AGHT+IH4EzRkwgg/9IU6xxKsto+E6fiddXvXCHiduD7imzBv3zqTn9K+VLHLteQrHMEJX5aVf67cYg==
X-Received: by 2002:a05:600c:511a:b0:40b:516a:3856 with SMTP id o26-20020a05600c511a00b0040b516a3856mr4029610wms.1.1702221959852;
        Sun, 10 Dec 2023 07:25:59 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id fc17-20020a05600c525100b0040c42681fcesm3080228wmb.15.2023.12.10.07.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 07:25:59 -0800 (PST)
Date:   Sun, 10 Dec 2023 16:25:58 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] staging: rtl8192e: Remove unused struct
 iw_range_with_scan_capa
Message-ID: <8b4532b8739ca0baa9fa7c736dab68130510ffe8.1702212003.git.philipp.g.hortmann@gmail.com>
References: <cover.1702212003.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1702212003.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused struct iw_range_with_scan_capa.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index 4371ab1239ee..4c884c5277f9 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -158,28 +158,6 @@ static int _rtl92e_wx_set_mode(struct net_device *dev,
 	return ret;
 }
 
-struct  iw_range_with_scan_capa {
-	/* Informative stuff (to choose between different interface) */
-	__u32	   throughput;     /* To give an idea... */
-	/* In theory this value should be the maximum benchmarked
-	 * TCP/IP throughput, because with most of these devices the
-	 * bit rate is meaningless (overhead an co) to estimate how
-	 * fast the connection will go and pick the fastest one.
-	 * I suggest people to play with Netperf or any benchmark...
-	 */
-
-	/* NWID (or domain id) */
-	__u32	   min_nwid;	/* Minimal NWID we are able to set */
-	__u32	   max_nwid;	/* Maximal NWID we are able to set */
-
-	/* Old Frequency (backward compat - moved lower ) */
-	__u16	   old_num_channels;
-	__u8	    old_num_frequency;
-
-	/* Scan capabilities */
-	__u8	    scan_capa;
-};
-
 static int _rtl92e_wx_get_range(struct net_device *dev,
 				struct iw_request_info *info,
 				union iwreq_data *wrqu, char *extra)
-- 
2.43.0

