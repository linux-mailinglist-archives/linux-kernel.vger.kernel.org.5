Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787F07BBF7A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 21:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbjJFTFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 15:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbjJFTFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 15:05:31 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92F3FF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 12:05:25 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9ae65c0e46fso99004266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 12:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696619124; x=1697223924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U+br5pLFUbrcZI/srFnTe6wEnu5xbIzdKc9qsVerSfI=;
        b=QAoNzbO9BslYJ6dbOyeQmcVbJDB6tNTUztFvhJq7ofwVvnr0+XUZbY28TbBbHiENVG
         FQ2wVQTgngngL/tBPUHr/N4oJRH05TSyeEr/+IowEhadtlbHxfOs3rgONvcjnwQ8Jp/+
         lgDMUC9W6PgCzQEdEpQS9TPx3YnYByiJbh6/pjh6NEOc2ZUVB625x+b+Fs/tj5I/UU/8
         o2PgU/6BKSLQLdzm51t+oYV+kgJ806sUHuZWwusNr2qGi+zyZpUbM+Kdv/hvpZK63rAm
         NHSksTBngqGMOfb6acEidWFKl14VP98cRRKOqhMhapOm9QsNMbtE5LSCWMPVJw7oKVY6
         WiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696619124; x=1697223924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+br5pLFUbrcZI/srFnTe6wEnu5xbIzdKc9qsVerSfI=;
        b=rXeXCsvhpaYpkXNMRgE4nkMM7r3OuJHuPXSgRzlb1ZDJk/9I5+qSx7hmL45VF5jLLi
         iqZ+aQbUylpxuzuJRBjwAk+ao/BaBNuOhIivbZaYyxwrQ0BJYQH6DBTpo4/8GrhDQv8L
         qVO9ZdbSCS8auFeH0K6bH15ZMUS7EURlcxA0Ji29dBKo9jyZLkPkl/xvHiMdT364vjtt
         DCbf+r3k1qR/c+jxV+2xf04zE117bH+WnZS0uZeWF/t7f51mNws+RPpLO1yNqIRK0vP+
         kWbiF6DpKMJKq5RWOBXL3cJbYyOsujkPcK2Im17nxFfEbIYwvQVDl1HfI6/LlY5Dtxic
         29CQ==
X-Gm-Message-State: AOJu0YwUjyxq3gw47bZd06FYQMCTlAcKMcAZd8PXMPH3bVlULVkILQr2
        FgmCSCJfMR0cEj/sNLuV8AI=
X-Google-Smtp-Source: AGHT+IEutXgDyZOdv9yVVTprRGPh9isbDdiPgUuwIVR39hzY8szwJ/QP2DSNAsvvtn401hb70YVuJw==
X-Received: by 2002:a17:906:29a:b0:9a6:ae76:d6ae with SMTP id 26-20020a170906029a00b009a6ae76d6aemr7716382ejf.3.1696619123915;
        Fri, 06 Oct 2023 12:05:23 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id dv8-20020a170906b80800b0098ce63e36e9sm3393081ejb.16.2023.10.06.12.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 12:05:23 -0700 (PDT)
Date:   Fri, 6 Oct 2023 21:05:22 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] staging: rtl8192e: Remove unchanged variable
 active_scan
Message-ID: <eea9f6cb1feeb8aa5beb546034562f55a03da449.1696548527.git.philipp.g.hortmann@gmail.com>
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

Remove variable active_scan as its value is set to 1 at initialization.
No further writes to active_scan are done. The equation results
accordingly. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 1 -
 drivers/staging/rtl8192e/rtllib.h            | 2 --
 drivers/staging/rtl8192e/rtllib_softmac.c    | 3 +--
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 7db01d68000a..ba35ae4a21fa 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -755,7 +755,6 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 
 	priv->rtllib->current_network.beacon_interval = DEFAULT_BEACONINTERVAL;
 	priv->rtllib->iw_mode = IW_MODE_INFRA;
-	priv->rtllib->active_scan = 1;
 	priv->rtllib->be_scan_inprogress = false;
 
 	priv->rtllib->fts = DEFAULT_FRAG_THRESHOLD;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 307bcbb7fbb6..2f968c3c0229 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1332,8 +1332,6 @@ struct rtllib_device {
 	int rate;       /* current rate */
 	int basic_rate;
 
-	short active_scan;
-
 	/* this contains flags for selectively enable softmac support */
 	u16 softmac_features;
 
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index f84133744bc3..ff98b41c94e0 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -419,8 +419,7 @@ static void rtllib_send_probe(struct rtllib_device *ieee)
 
 static void rtllib_send_probe_requests(struct rtllib_device *ieee)
 {
-	if (ieee->active_scan && (ieee->softmac_features &
-	    IEEE_SOFTMAC_PROBERQ)) {
+	if (ieee->softmac_features & IEEE_SOFTMAC_PROBERQ) {
 		rtllib_send_probe(ieee);
 		rtllib_send_probe(ieee);
 	}
-- 
2.42.0

