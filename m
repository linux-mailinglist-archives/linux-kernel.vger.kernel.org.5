Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14F17BBF7B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 21:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjJFTFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 15:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbjJFTFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 15:05:20 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60160ED
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 12:05:18 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5221bd8f62eso777124a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 12:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696619117; x=1697223917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L+5/W8zfr89+jzPHersBFwpSIge2gJvw1XUex3kLRTw=;
        b=RxffgPUq5lYECZajZM5GZzWgLAQiD9CInxzvBr7WLR84wSgJu3VRkIHFnOpG8am7Z0
         lLeMwifdSsEXnssAYjsG+jK87MtzNNXfqV2jQMh9ViSneh1CSoHs914xSCS5CEVKhlAq
         GwuRKMLksIlKNZG6SlYGH/V8KKSvQLotzME6Py+o2xVngWaGiTN7m/Rs5QzmnwIe9SDC
         IYlzX8FXzxOaCJb1pACHTYTVbVbpOjmlBguRhT64/7d+smteRdfQ7nvtnsvjq1sQ4r6u
         JditJADJ8Y5lFntpJs+wrGzpZ0mDEkQIhiuGda1X5JYt/JD0YUJukWKLZ+DMHK0b358L
         XhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696619117; x=1697223917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+5/W8zfr89+jzPHersBFwpSIge2gJvw1XUex3kLRTw=;
        b=PKsHT40cUJAXdkTSUJjEjq98evCT5NcqEpc8C5rLb+56Dm/Q/X0DB3oYjCGeiRZGMo
         qLf1OHNpChRxMJpBK7tpcrJSkD0LTGZd4X3jZtC72eO6BwCJenyy7khnhr2WYvmxtFDY
         Z2RvFt5FkeDs5i/dPIA1xKu5sRhTq3lXhDetPtgWj9Nz/CdeaOepUiXbihwu2bT4XLkm
         BcTdCcRj6bmseCIUGkLFt2NJrmzdu29UOlIdcdGSPiX8oMvBYmKfupVmyzJzqLRBeRBN
         ktCde2N4w8FAGBAosiKL/H+ZfRsdgDbIpNb6tutLMxD4U2Ne2PCRFj6gmKVq51RfUKX6
         Lleg==
X-Gm-Message-State: AOJu0YxocEBAXJCFQFQzb9ZyuzXrJVTR8GA0zllSxjOqOidAejypQ8pO
        ouEU9ychEh0BBAkP//Xr7sg=
X-Google-Smtp-Source: AGHT+IEvANf54FpArnQMlxmNuMfePdWnNr1sJEIJQOKWvwvG7U+yoh110mg1nWK9jpRaYXH9ABew8g==
X-Received: by 2002:a05:6402:524a:b0:530:8a69:c6da with SMTP id t10-20020a056402524a00b005308a69c6damr7326575edd.4.1696619116810;
        Fri, 06 Oct 2023 12:05:16 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id r19-20020a056402035300b00522828d438csm2993147edw.7.2023.10.06.12.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 12:05:16 -0700 (PDT)
Date:   Fri, 6 Oct 2023 21:05:14 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] staging: rtl8192e: Remove function
 _rtl92e_wx_set_scan_type()
Message-ID: <8a0ce95447dbd736e3aeec5f7aa0e997f916b7d8.1696548527.git.philipp.g.hortmann@gmail.com>
References: <cover.1696548527.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696548527.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove function _rtl92e_wx_set_scan_type() as this functionality is not
commonly used and the tool to access it is deprecated.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index 27309df925ba..d4d8d66df82c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -627,22 +627,6 @@ static int _rtl92e_wx_set_enc(struct net_device *dev,
 	return ret;
 }
 
-static int _rtl92e_wx_set_scan_type(struct net_device *dev,
-				    struct iw_request_info *aa,
-				    union iwreq_data *wrqu, char *p)
-{
-	struct r8192_priv *priv = rtllib_priv(dev);
-	int *parms = (int *)p;
-	int mode = parms[0];
-
-	if (priv->hw_radio_off)
-		return 0;
-
-	priv->rtllib->active_scan = mode;
-
-	return 1;
-}
-
 #define R8192_MAX_RETRY 255
 static int _rtl92e_wx_set_retry(struct net_device *dev,
 				struct iw_request_info *info,
@@ -896,16 +880,12 @@ static const struct iw_priv_args r8192_private_args[] = {
 	{
 		SIOCIWFIRSTPRIV + 0x0,
 		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "set_debugflag"
-	}, {
-		SIOCIWFIRSTPRIV + 0x1,
-		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "activescan"
 	}
 
 };
 
 static iw_handler r8192_private_handler[] = {
 	(iw_handler)_rtl92e_wx_set_debug,   /*SIOCIWSECONDPRIV*/
-	(iw_handler)_rtl92e_wx_set_scan_type,
 };
 
 static struct iw_statistics *_rtl92e_get_wireless_stats(struct net_device *dev)
-- 
2.42.0

