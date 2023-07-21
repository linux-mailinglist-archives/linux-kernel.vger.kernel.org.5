Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49D275D7CD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 01:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjGUXGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 19:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGUXGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 19:06:12 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22155273E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 16:06:11 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-668711086f4so1652338b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 16:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689980770; x=1690585570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zSrDjDHl7M7aRHZl+hH2qRE/q2U1EWsUQrb4m16evQQ=;
        b=e7VYFNcPtyxA/7YKqgz+xaSqDqrgxBZEJxkRVKCYUW+3k1SfKVAN23A3c5vvZhnewY
         ifNUYUIS7egzud2wfJdOFWULD/8J4kk148hIO5vpDCAgS7htthDK/RcvIRT0mN19mUoH
         FBd95ghUzERqMViWl0W5cJXcieWcN8vSJ0vNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689980770; x=1690585570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zSrDjDHl7M7aRHZl+hH2qRE/q2U1EWsUQrb4m16evQQ=;
        b=TSFYDH6c4rJqd1fDGgiFT+LFVxwo5XMaFNUy7EQ3TsZPZGpiww/NadQ8iGhJ2rsx2m
         6C+vBh8kQvXPsMgXZD9fgJtncAGvyVIbcUGVf2M+IWfeFvE+f8fwaOPNrtEXSZ2l5sPG
         xjq5GLIG8TrQXeoK9zShgyqtfoJILa0/AtY6VEKdRoMq6IzBjOjqCB0jDC2t8+ixEeoC
         SitZmWaU745y0yN0lW1X/UeCdkrqoU2NfCKY1D8FDiViCOI65Q06sEelJfCzmSoN5gln
         JH6/SCtAzT1ti0X14V4cUzq8Y2wCgDDoiKVlUC4hX/r8Cee5zkCkgzdjDYNHGFjj3nOA
         n+8A==
X-Gm-Message-State: ABy/qLZtn9lauVMDTsPyB4ebNsu8gG5V76JYKAudQ5YSGAPZeFsrxpV0
        jRS5gyznNFTdDIm6tJi+nkgu2w==
X-Google-Smtp-Source: APBJJlEsrquSi/UMk8rheYMDnKjcyfuaU5Z1aEcK19lv6UzJyylMbD4qg8/9ka36cgx8szXD3ViFEQ==
X-Received: by 2002:a05:6a20:6a11:b0:12e:caac:f263 with SMTP id p17-20020a056a206a1100b0012ecaacf263mr4280993pzk.20.1689980770572;
        Fri, 21 Jul 2023 16:06:10 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:4fa:e795:a6b:cf7f])
        by smtp.gmail.com with UTF8SMTPSA id fm10-20020a056a002f8a00b006783ee5df8asm3422249pfb.189.2023.07.21.16.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 16:06:10 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     linux-wireless@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>
Subject: [PATCH] MAINTAINERS: Update mwifiex maintainer list
Date:   Fri, 21 Jul 2023 16:06:04 -0700
Message-ID: <20230721160603.1.Idf0e8025f59c62d73c08960638249b58cf215acc@changeid>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We haven't heard anything from these folks in years. I've been reviewing
many submissions and plan to keep doing so.

Cc: Amitkumar Karwar <amitkarwar@gmail.com>
Cc: Ganapathi Bhat <ganapathi017@gmail.com>
Cc: Sharvari Harisangam <sharvari.harisangam@nxp.com>
Cc: Xinming Hu <huxinming820@gmail.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 MAINTAINERS | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index dfbb271f1667..42e78a696be6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12579,12 +12579,9 @@ F:	Documentation/devicetree/bindings/net/marvell,pp2.yaml
 F:	drivers/net/ethernet/marvell/mvpp2/
 
 MARVELL MWIFIEX WIRELESS DRIVER
-M:	Amitkumar Karwar <amitkarwar@gmail.com>
-M:	Ganapathi Bhat <ganapathi017@gmail.com>
-M:	Sharvari Harisangam <sharvari.harisangam@nxp.com>
-M:	Xinming Hu <huxinming820@gmail.com>
+M:	Brian Norris <briannorris@chromium.org>
 L:	linux-wireless@vger.kernel.org
-S:	Maintained
+S:	Odd Fixes
 F:	drivers/net/wireless/marvell/mwifiex/
 
 MARVELL MWL8K WIRELESS DRIVER
-- 
2.41.0.487.g6d72f3e995-goog

