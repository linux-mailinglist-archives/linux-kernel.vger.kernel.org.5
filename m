Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621F9787EE7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 06:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240550AbjHYEJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 00:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjHYEJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 00:09:11 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7831FCE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 21:09:09 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68a40d85593so445743b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 21:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692936549; x=1693541349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L+y28ESYQkGLlaBqKy1Si+JoLS1Nz1yNzmMOUxp7mWQ=;
        b=qnEGNFf1aF819DyDqN7jg0ypYvkRq9DPBcmJ6ZDIv4kJP/7ZiAN2jrtECT7qEYSjIZ
         9ih5ujgSmNq2kv6SFfs8Yj/2i0I7C0FpqjaGPFDBieJWQMb5JQD8L+nU1+MT6aGIDdXo
         Wz4+J20CRHcLaAR4jEdTkSyqCRKcl4DrGb/cRmZZrRjPiQoHR+V3pUV422fRHCvo2yFL
         EjyxaVf1GtRunHUTF5CNdyy61M0p4PXphY4fM3N2MR2B00wdovxrS4SRVDd/UfB8ZkX3
         cwBbijUtxDNOoNi9Dzfqkpgrn3fKjMcjLeDXxfw0u9gPp0I2ar0NmbKPhzVy6GT8HIeR
         rZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692936549; x=1693541349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L+y28ESYQkGLlaBqKy1Si+JoLS1Nz1yNzmMOUxp7mWQ=;
        b=Uz+rEXJrcMx6rTLFU+8uJ+F9fCwXR7AZlauf5Lvlq9NiHSiS4/xnqiM5ZF3IiX0rQd
         5HwAiJBwM1yV1uO3+mFC8wm9qNMGx+eQcapHIT+uw053SsilGMpYPWu9Ix4YxaIfBU8n
         G9uyUXBzQANHyNwKNKRQ2UlHgytXsU5kDw0O/6Ue+hHzLbSCZvfG1Z8XBELw1GnD78zg
         1MgHov/fwZyb43hh9KqPQ8w9OouhMMTIKsTpskVE0JpXD38+/HQJbL89shCixybkK19b
         QDjWqjvoAh3nE76uVY2uNZduBYCCpFLX6N16lvj1GffRzGJpu+n+PWoMPtyhc4/3gHhG
         4wug==
X-Gm-Message-State: AOJu0Yz3y6k+5RK/Ed/hlypsrNbnIDhDGc+My/1SkR3VXulYuyoSszjR
        qLmc9t6WPtvjuVYC+3837S8=
X-Google-Smtp-Source: AGHT+IHBTjAHrN3pa2PmuUg5gwVX9bDtjdBxYyoodan97cmNqluNdJzO9Gr8nwqCFvhFSfo0qJitnA==
X-Received: by 2002:a05:6a00:150a:b0:68a:6cf0:9400 with SMTP id q10-20020a056a00150a00b0068a6cf09400mr11167719pfu.21.1692936549105;
        Thu, 24 Aug 2023 21:09:09 -0700 (PDT)
Received: from VERNHAO-MC1.tencent.com ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id x22-20020a62fb16000000b0064fd4a6b306sm524056pfm.76.2023.08.24.21.09.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 24 Aug 2023 21:09:08 -0700 (PDT)
From:   Vern Hao <haoxing990@gmail.com>
X-Google-Original-From: Vern Hao <haoxing990gmail.com>
To:     akpm@linux-foundation.org
Cc:     zhaoyang.huang@unisoc.com, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, haoxing990@gmail.com,
        Vern Hao <vernhao@tencent.com>
Subject: [PATCH] mm/vmscan: Use folio_migratetype() instead of get_pageblock_migratetype()
Date:   Fri, 25 Aug 2023 12:08:47 +0800
Message-ID: <20230825040848.1542-1-user@VERNHAO-MC1>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vern Hao <vernhao@tencent.com>

In skip_cma(), we can use folio_migratetype() to replace get_pageblock_migratetype().

Fixes: 5da226dbfce3 ("mm: skip CMA pages when they are not available")
Signed-off-by: Vern Hao <vernhao@tencent.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 42e3893de2a7..d9e974b96144 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2271,7 +2271,7 @@ static bool skip_cma(struct folio *folio, struct scan_control *sc)
 {
 	return !current_is_kswapd() &&
 			gfp_migratetype(sc->gfp_mask) != MIGRATE_MOVABLE &&
-			get_pageblock_migratetype(&folio->page) == MIGRATE_CMA;
+			folio_migratetype(folio) == MIGRATE_CMA;
 }
 #else
 static bool skip_cma(struct folio *folio, struct scan_control *sc)
-- 
2.31.1

