Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629107CA0EF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjJPHnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjJPHnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:43:07 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FD383
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:43:04 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40535597f01so41452635e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697442183; x=1698046983; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=82ZZk+PdVHD4SgeMSwIuwPbebfsYW2eoRNAUDZyb4ZU=;
        b=XnaKEt7Ae9qRhDYc1iBMwWbn9QmHT8dbsUdaT24NOwivDmeCaRC3wcCFU9Hi6mAByq
         6rTt73jzSwh/2cg+GxN/LW1aWqci98bEt6KTMs4X+DHhSBGrktYw47lhmfOna65hGLyk
         HUFVsA//rQZVu4Xe4dgLyMLwQfr8fFcRJkL+xyaFkTZISL1B8X6ViIqqD2STV9JsQmdi
         ZDnOV52VBPpdQ1HEgASaEBNynqYBWaf5gfLfLC7rwEjhi/c8aV/7g3KVXTBeoskCWgUH
         H6ie8gmugeIU0yO4qxYteFg1P9eFUDr3zSkYwtoy4OOrhiWE9pkqSWnZocN8ZPQM4ymc
         R1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697442183; x=1698046983;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82ZZk+PdVHD4SgeMSwIuwPbebfsYW2eoRNAUDZyb4ZU=;
        b=WKaNNd4Q4IFnuFs4yuB1KG5mytJzD7YsP5JPtUukU9aYIbMDXJSYhiLLVo93FAjpuF
         Cti8CfN7WTQvPLXaM7c4oh345wv4L1W3RXRjJuvG100zpC8+jvR14zKsYZzTVwMpM0Yi
         ATVypI6xiqYj0nFdlg83lobwugzdk06rfXElUs3pvNcnrshmoQGq0ToyKL2GFYV9IlFj
         tP+w10ZKJNxZ+ogm+428Ky/cXnIOyU0Z5aN/18NEoOcxqMeaxCCzE1ZBqGdjLR+rXSYX
         M1Wksfj2mKLuJLuZR4KFwFpbu9nKJy+gf13rjqGJMV8OssHByYI7RnA2Wl+4ENithZBI
         cbnQ==
X-Gm-Message-State: AOJu0YwTBy8+cfODvii08NAAo3bWvNApbzyeRo6urf6LMzAD/iaV5zd+
        iQ/CzMEbUD0ChrFkZvUf1YEfjGw1R48lEQ==
X-Google-Smtp-Source: AGHT+IGiGMf1Qjq+nmSCG42rGlFyIuIJ6x7MSy7vJ7i9u/Hq1ziL0XDZYoa3a1ZD5JCV5mtlWPR9QQ==
X-Received: by 2002:a7b:c84d:0:b0:3fa:934c:8356 with SMTP id c13-20020a7bc84d000000b003fa934c8356mr29857003wml.10.1697442182984;
        Mon, 16 Oct 2023 00:43:02 -0700 (PDT)
Received: from lab-ubuntu ([41.90.67.11])
        by smtp.gmail.com with ESMTPSA id e28-20020adfa45c000000b0032d892e70b4sm12398417wra.37.2023.10.16.00.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 00:43:02 -0700 (PDT)
Date:   Mon, 16 Oct 2023 10:43:00 +0300
From:   Calvince Otieno <calvncce@gmail.com>
To:     gustavo@embeddedor.com, outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Calvince Otieno <calvncce@gmail.com>,
        Karl Relton <karllinuxtest.relton@ntlworld.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] staging: wlan-ng: remove undefined function
Message-ID: <ZSzphFeckE7dM5g/@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function p80211wext_get_wireless_stats() is declared in the code
but has neither been defined nor referenced.

It's definition was removed 13 years ago in the
commit cb3126e60ffc ("Staging: wlan-ng: Switch from wext to cfg80211")

Signed-off-by: Calvince Otieno <calvncce@gmail.com>
---
 drivers/staging/wlan-ng/p80211netdev.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/wlan-ng/p80211netdev.h b/drivers/staging/wlan-ng/p80211netdev.h
index f5186380b629..485f2c697f5f 100644
--- a/drivers/staging/wlan-ng/p80211netdev.h
+++ b/drivers/staging/wlan-ng/p80211netdev.h
@@ -114,9 +114,6 @@ struct p80211_frmrx {
 	u32 decrypt_err;
 };
 
-/* called by /proc/net/wireless */
-struct iw_statistics *p80211wext_get_wireless_stats(struct net_device *dev);
-
 /* WEP stuff */
 #define NUM_WEPKEYS 4
 #define MAX_KEYLEN 32
-- 
2.34.1

