Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1967B71CD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240960AbjJCTd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240924AbjJCTdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:33:54 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EE9AD
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:33:51 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40646537450so3193145e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 12:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696361630; x=1696966430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J8N2tOkDAA669roEY7JwJC/ZX0XtgD+W4+RzL+0SA5k=;
        b=YTDzUWMSBGU5+MM/qpKIVeWh4zEidj+E57FL1DT8I4MSlJxBsvAlt4EzvyFHW8B4/i
         Re0PV6aYozsjWHAnzvO7Kd4r2rNRPnSR5vZkcNTTtVJlifxrhrEcJXXEaDliil9gZkZl
         uyHz2kRWg7nbUZHLRiTcJ4eiekK4zq5MW1tzWt+s1yItof/3bGHjAcDDVX1I0xerhcCH
         zYJuzMq1f2a4oItWBOxNZk53XkfJ/hj7UnwCNchMLLGHp9b8IpNdNIBmDIzk267rcRa8
         d2CCUE7X65+EDi7REXUxovFU+4PPLKKfG+UTv7qwmPf4xTA/9IAGlZ6tEfHA6BN15z/M
         vEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696361630; x=1696966430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8N2tOkDAA669roEY7JwJC/ZX0XtgD+W4+RzL+0SA5k=;
        b=U+5VgTww4OsUuvXaKfAeKrGkFGyfzX3ModCmEpwXuMzOO0Bun4PAIpKF5qAMibY/On
         0i+BxX+G8GuZYVldWSh94Vtzz0uTkcNBW2ccr/PfWB1jAV4xESV9dxlDXh338YgR/Y4h
         SWTWEXRjW9CjRt4VTIq6F3ZhPvhBwZiZgXAv2mO09NrYrWEGT3LxcatiUnzhAWLtxHOj
         O4Hw+ZXoi/kjufL0CufHInY3sATVz9Wz6i9y4wR+LDN/7ptgILp0lugvE0tUAr1TYvxs
         PfhIIhqVQ9DvV/4BeTMut0jm5n4/KQpRqYHCOtdVhXHzA+W8IoFHLdmGiza/EI1bQCq9
         KMkQ==
X-Gm-Message-State: AOJu0Yyneznff3n92c0NISdgoh0jy067EnZEsnDhtSv5FBYasOkQTcul
        VZLTjg7n/1ApjQTfMcONHy4htDhyHOk=
X-Google-Smtp-Source: AGHT+IE1ExQhIDPmWaPm2sKRCbrelt0383LJTft1aBkzY75A2GfQaAR+G2AMC8lMZajUWLNIrbM4OA==
X-Received: by 2002:a17:906:530c:b0:9ae:6552:4af6 with SMTP id h12-20020a170906530c00b009ae65524af6mr148050ejo.1.1696361609136;
        Tue, 03 Oct 2023 12:33:29 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id pk13-20020a170906d7ad00b0099bc08862b6sm1541785ejb.171.2023.10.03.12.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 12:33:28 -0700 (PDT)
Date:   Tue, 3 Oct 2023 21:33:27 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] staging: rtl8192e: Remove unused variable raw_tx
Message-ID: <7ab7606ba836746d28afdb72914fb4e05824dac8.1696360403.git.philipp.g.hortmann@gmail.com>
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

Remove unused variable raw_tx as it is just set to 0 and not used.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h        | 1 -
 drivers/staging/rtl8192e/rtllib_module.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 98b8b7db027e..41b34331380c 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1364,7 +1364,6 @@ struct rtllib_device {
 	u64 ps_time;
 	bool polling;
 
-	short raw_tx;
 	/* used if IEEE_SOFTMAC_TX_QUEUE is set */
 	short queue_stop;
 	short scanning_continue;
diff --git a/drivers/staging/rtl8192e/rtllib_module.c b/drivers/staging/rtl8192e/rtllib_module.c
index abd6bfd4dfa3..195d8aa88138 100644
--- a/drivers/staging/rtl8192e/rtllib_module.c
+++ b/drivers/staging/rtl8192e/rtllib_module.c
@@ -114,7 +114,6 @@ struct net_device *alloc_rtllib(int sizeof_priv)
 	ieee->drop_unencrypted = 0;
 	ieee->privacy_invoked = 0;
 	ieee->ieee802_1x = 1;
-	ieee->raw_tx = 0;
 	ieee->hwsec_active = 0;
 
 	memset(ieee->swcamtable, 0, sizeof(struct sw_cam_table) * 32);
-- 
2.42.0

