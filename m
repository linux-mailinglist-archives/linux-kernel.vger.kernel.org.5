Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C067ABD98
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 05:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjIWD2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 23:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjIWD2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 23:28:49 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB996A9;
        Fri, 22 Sep 2023 20:28:42 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-57ba2cd3507so57735eaf.2;
        Fri, 22 Sep 2023 20:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695439722; x=1696044522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VNpi5MU32lqhvlFPPVlhf1T34olOc5AdM8aLJlax2ik=;
        b=W1X10i/Xwh9/FNjyWm5QlEtCciUR3pzHumQxDk3647OkVgV3jzYuh6cHRglVmVdtbE
         S5/CNhFO9Tl8fgkbQgCpvFkB3Lvoi4QjpxrmcnJLfRdkMvC+k76al+pYGHUoUcEDj21A
         CbAjxb5fuyMMHjCQK+wf8mPOLSMeUNeqaYvMOsYVQoLspP/mDnsMDiSf9R/h8OFiRkpN
         ApTIPDGXlB4WY8QlZtMH+4xZPZWrfNuatBA4/dGUa72gPKCXDsZBTmbHPFpEvLK65CAn
         TRpNj1HsTuPhf4xdRBmJbXvYQrJhfNB60VigkMLPZm+q5ZMtEUPqWwV1Vpv6zdvFi1C2
         ZYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695439722; x=1696044522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VNpi5MU32lqhvlFPPVlhf1T34olOc5AdM8aLJlax2ik=;
        b=Pth4RYbCvTlS6wb5kz+m6Kh2T7FQUCwuT7r0T80qbosnVEepmT4GOT6Rt1qZV9fKXu
         Yd5OUXrNiMowBdPiLEpOoA834sLP3Ezpqq855AQiT03kWzKTzv8iQm0Cg5LIikdBkduA
         N4oDprcP6AavwOjyxW0HCr1ZLFVj34eemUYMhQQvnl/6Z8yCAfhXaKvudlNS6BFRXXmU
         PH7lEHydAs3TLvLKt/g0EsmmeCIsg8UTut1IcV7MB0H01zyzi/eCQ2r+kePKHZvL4fGo
         8rW7aKMga3S6EmBluzpZsp17vJexcs8KvsIH2q1TeP2Awuhqm1EnQj6igbGST+TUOEXx
         CvfQ==
X-Gm-Message-State: AOJu0Yzmp7BpBW9BJy8TlDxbr8zF20AqorWgD2Zl77lOOk0fK7E5x8hF
        3/QWQrUspLgWUHak6h+1LLo=
X-Google-Smtp-Source: AGHT+IEpnijR6D192lOlnLVDZYJx5p7/zpCx+KgC1P6/xTsMfatf3u4hQQWHcyP5otAI7S54orzxaA==
X-Received: by 2002:a05:6358:52cb:b0:143:8084:e625 with SMTP id z11-20020a05635852cb00b001438084e625mr1563237rwz.11.1695439721791;
        Fri, 22 Sep 2023 20:28:41 -0700 (PDT)
Received: from instance-2.asia-northeast3-a.c.dynamic-net-399300.internal (214.81.64.34.bc.googleusercontent.com. [34.64.81.214])
        by smtp.gmail.com with ESMTPSA id bu20-20020a632954000000b0057c29fec795sm3585767pgb.37.2023.09.22.20.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 20:28:41 -0700 (PDT)
From:   roynatech@gmail.com
To:     johannes@sipsolutions.net
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mac80211: fix station hash table max_size config dependency
Date:   Sat, 23 Sep 2023 03:28:34 +0000
Message-Id: <20230923032834.9694-1-roynatech@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: roynatech2544 <whiteshell2544@naver.com>

Commit ebd82b3 ("mac80211: make station hash table max_size configurable") introduced config
MAC80211_STA_HASH_MAX_SIZE, which is defined unconditionally even if MAC80211 is not set.
It doesn't look like it is dependent of MAC80211_DEBUG_MENU either, as its only user is sta_info.c
which is compiled unconditionally when MAC80211 != n. And without this config set somewhere, compile
would error out.

Make it depend on MAC80211 to correctly hide the config when MAC80211=n

Fixes: ebd82b3 ("mac80211: make station hash table max_size configurable")
Signed-off-by: roynatech2544 <whiteshell2544@naver.com>

diff --git a/net/mac80211/Kconfig b/net/mac80211/Kconfig
index 51ec8256b..b9dc520b6 100644
--- a/net/mac80211/Kconfig
+++ b/net/mac80211/Kconfig
@@ -296,7 +296,8 @@ config MAC80211_DEBUG_COUNTERS
 	  If unsure, say N.
 
 config MAC80211_STA_HASH_MAX_SIZE
-	int "Station hash table maximum size" if MAC80211_DEBUG_MENU
+	int "Station hash table maximum size"
+	depends on MAC80211
 	default 0
 	help
 	  Setting this option to a low value (e.g. 4) allows testing the
-- 
2.34.1

