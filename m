Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FFB7F4F72
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbjKVSYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235206AbjKVSYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:24:41 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4307D5E;
        Wed, 22 Nov 2023 10:24:32 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50a6ff9881fso10412927e87.1;
        Wed, 22 Nov 2023 10:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700677471; x=1701282271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uth/Y2BnPWq3gQU+80s2O0ynUT/ngATxDsls3eMwpZI=;
        b=blYM6UpjStu3K+0aiGxyNx3p0Ijh8X+fQhPk1e3mSuLxJNLIlZqeeMDHwpryxlHr3u
         Gv2DiOpHID+SM7Y4nB950JsClp4jP94ID/YV6lmXw46aINc4YHD/W6biIwWwuEvgZl8X
         hIINPi/g2H33W+OFut49wPfbO786ucJZB36QJxIobGQzkYPugG87nNi92WmmFLJGZGor
         U/qEzhrNYkThGCWDyo1byycinGcWIVGVbOCkz2XhNlQ+IQHaX10eKmKmp8ChC6vtN2CY
         xARi64x5GXk1f1U9cmyVKemvjeIL1kqYpw+I6v2EUA8jhNF8ysFYK0NeIaae1jhYaDMf
         6E3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700677471; x=1701282271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uth/Y2BnPWq3gQU+80s2O0ynUT/ngATxDsls3eMwpZI=;
        b=RIqDr3BCnDH6wLZjrUKR26U/vs4fdZSRA9ZgbOlFuJEuEVHipxrCtD05vYDn++I1Nx
         lmRxlZjpO9/xejL22erCsunepagO8V+6/UNjoZeZQXN5L3n4WdVfSq/fIGMlESSm5oss
         2hSW2wMccFGZYKE2sX5L3I6KyOt1A3H+5pLkTSEU/xOdSEUWWrptaRdpQd8gLgfXLKYR
         gTUYBU3x+eFOpl5O6v1E9U8acvhbhekKA8Lh9pWdreOk2g9QUVWZbpKSYPxzFUZIrO+m
         95EuDcLgzNlPk0OsHCJG/Q69HPcfhCWYchlsQ1sd1ow2tHxIUlZXTmeqQF+SnKKP9+78
         cFsQ==
X-Gm-Message-State: AOJu0Yw/QlIr0XaBbNZ5Ext0eQLINknBUGgzXdsIEAb74zrJ1buuMN3P
        BrvZAH8+tSkZDk9dOszyhos=
X-Google-Smtp-Source: AGHT+IEWqYrpMTLtxw6L9izmb8PcfN1bR92Xt7CidFbWzvvA08wTTg9UoMDWL2iVdmmyJOFzTDnDHg==
X-Received: by 2002:a05:6512:3083:b0:508:1470:6168 with SMTP id z3-20020a056512308300b0050814706168mr1101474lfd.57.1700677470889;
        Wed, 22 Nov 2023 10:24:30 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id d14-20020ac25ece000000b00509447753c5sm1926536lfq.308.2023.11.22.10.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 10:24:30 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
        Aleksandar Rikalo <arikalo@gmail.com>,
        Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>,
        Chao-ying Fu <cfu@wavecomp.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Yinglu Yang <yangyinglu@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] mips: Optimize max_mapnr init procedure
Date:   Wed, 22 Nov 2023 21:24:02 +0300
Message-ID: <20231122182419.30633-5-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231122182419.30633-1-fancer.lancer@gmail.com>
References: <20231122182419.30633-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

max_mapnr defines the upper boundary of the pages space in the system.
Currently in case if HIGHMEM is available it's calculated based on the
upper high memory PFN limit value. Seeing there is a case when it isn't
fully correct let's optimize out the max_mapnr variable initialization
procedure to cover all the handled in the paging_init() method cases:
1. If CPU has DC-aliases, then high memory is unavailable so the PFNs
upper boundary is determined by max_low_pfn.
2. Otherwise if high memory is available, use highend_pfn value
representing the upper high memory PFNs limit.
3. Otherwise no high memory is available so set max_mapnr with the
low-memory upper limit.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Since I haven't seen any problem the denoted misconfiguration on my setup
the patch isn't marked as fixes, but as an optimization.
---
 arch/mips/mm/init.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 6e368a4658b5..b2dce07116e8 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -421,9 +421,13 @@ void __init paging_init(void)
 		       " %ldk highmem ignored\n",
 		       (highend_pfn - max_low_pfn) << (PAGE_SHIFT - 10));
 		max_zone_pfns[ZONE_HIGHMEM] = max_low_pfn;
-	}
 
-	max_mapnr = highend_pfn ? highend_pfn : max_low_pfn;
+		max_mapnr = max_low_pfn;
+	} else if (highend_pfn) {
+		max_mapnr = highend_pfn;
+	} else {
+		max_mapnr = max_low_pfn;
+	}
 #else
 	max_mapnr = max_low_pfn;
 #endif
-- 
2.42.1

