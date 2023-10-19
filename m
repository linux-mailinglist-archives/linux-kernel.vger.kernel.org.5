Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF127D03D6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 23:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjJSVXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 17:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbjJSVWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 17:22:42 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3DB1705
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 14:22:01 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c9bca1d96cso831715ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 14:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697750520; x=1698355320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2Zb52xqU9YG10pBRwWVILZJr4eqiLRUY7pMspVelCk=;
        b=hNgF4d53t1HA2mDAiAdDE9c9nVJHEPGUZqHkg3NeHxn85laVdDehQK9z1ycwLxQODN
         DTbMmL7wVWQPGP1lf4hmtWN2yK4Kw/heKkSVi9tOSafCbRZYGwECPErqE1CKz53oDK16
         3w4MmJyur+WiKN0nEPaNo9wouRRPAAeD0z34o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697750520; x=1698355320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2Zb52xqU9YG10pBRwWVILZJr4eqiLRUY7pMspVelCk=;
        b=NRvELA/pu12G5/TAxfkTW98e1emM0kEgdgxMVreYx5tZHmZjfIpcnvEynFdV1wmqud
         jrkAmBuuJfvEJo02GKkTu4ZWlSXTw5PkHHhjf9+yUGLgFY7A8UeRGOO6Em1c0humUqsC
         orNL0KkwT0ZGq9EcBkVvOcqP8JfwLiUTMVs7ptyVyins7HrhQk8yFo4/lFiRA0dhsyWO
         6g3eVUdBm0nqBoJAi6R9xfRYuLYUzVFpX96CUdmx6bDYKUaXnOaX8W9NIHe4j6rjzubi
         ouB6MnMDWvYzscdqXtuB5UVFbbu6jOCmGe38GCH2jyAT3OQwiNW+bcDavcBTt4FS04+i
         /3TA==
X-Gm-Message-State: AOJu0YxhKOLzCQ5KzrRCDZYaU2BYRGxL3ZyZwJh6E7Rui0KvMrUXJmg5
        6x5IawIOfyDbZ6TFG82ONFvJ3CV2awtgId2CP/vt2w==
X-Google-Smtp-Source: AGHT+IGJt6j2mTd8SV07ZZuKDgTE+QfqVgU0qKZcGmDh43UvCguz82GGBb8VkqQyAqaN860xbIStgA==
X-Received: by 2002:a17:902:d492:b0:1b2:4852:9a5f with SMTP id c18-20020a170902d49200b001b248529a5fmr59681plg.54.1697750520517;
        Thu, 19 Oct 2023 14:22:00 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:a6da:6f08:412:e04b])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902d34200b001bbdd44bbb6sm154100plk.136.2023.10.19.14.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 14:21:59 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Grant Grundler <grundler@chromium.org>,
        Edward Hill <ecgh@chromium.org>, linux-usb@vger.kernel.org,
        Simon Horman <horms@kernel.org>,
        Laura Nao <laura.nao@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Douglas Anderson <dianders@chromium.org>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v4 3/5] r8152: Check for unplug in r8153b_ups_en() / r8153c_ups_en()
Date:   Thu, 19 Oct 2023 14:20:22 -0700
Message-ID: <20231019142019.v4.3.I6405b1587446c157c6d6263957571f2b11f330a7@changeid>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231019212130.3146151-1-dianders@chromium.org>
References: <20231019212130.3146151-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the adapter is unplugged while we're looping in r8153b_ups_en() /
r8153c_ups_en() we could end up looping for 10 seconds (20 ms * 500
loops). Add code similar to what's done in other places in the driver
to check for unplug and bail.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- ("Check for unplug in r8153b_ups_en() / r8153c_ups_en()") new for v2.

 drivers/net/usb/r8152.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index fff2f9e67b5f..888d3884821e 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -3663,6 +3663,8 @@ static void r8153b_ups_en(struct r8152 *tp, bool enable)
 			int i;
 
 			for (i = 0; i < 500; i++) {
+				if (test_bit(RTL8152_UNPLUG, &tp->flags))
+					return;
 				if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
 				    AUTOLOAD_DONE)
 					break;
@@ -3703,6 +3705,8 @@ static void r8153c_ups_en(struct r8152 *tp, bool enable)
 			int i;
 
 			for (i = 0; i < 500; i++) {
+				if (test_bit(RTL8152_UNPLUG, &tp->flags))
+					return;
 				if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
 				    AUTOLOAD_DONE)
 					break;
-- 
2.42.0.758.gaed0368e0e-goog

