Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2343375973D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjGSNn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGSNnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:43:25 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1F2189
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:43:24 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b9cd6a0051so43831595ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689774204; x=1690379004;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uj4bycoHIi78Tfh9p5PlVQ04avMBcEsGppMMatw0U6g=;
        b=CJrnhE7Trr0nlNCxZ6FHqOnklJL3pq5ya/g8BUqmj2ArNdHTcyWdHwtH3q+eK3gIdA
         F2LT4d11H0PEw+LgU+8f/C3zPwukCl2hJ9XfUpxCcGk4RTGadMyQWD3tWKT+cZKoEyOY
         6OUHM6T2BwKCGljZ1dwOkIHrqr3reMjvxFI/kFGoYHTRFV8O1ECpZJ/4ABfETLag/RRe
         7GCyFZK/OcqBVl2auOmO6W4Ema4K6EdVlLkyvnmPlhPnqxZAj+S91H3dN4VFYRwWYQcH
         SIO82jrJaXfflRhYWhtVVlILQbP2LmpgEJ/LpKLBn1WblL5xUCrvaYjALr3TZtbyOzUl
         8NZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689774204; x=1690379004;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uj4bycoHIi78Tfh9p5PlVQ04avMBcEsGppMMatw0U6g=;
        b=BKjMMK12FY9ziLmix0nqAxI1iYs9iB3FtK7jAO/R5z3hSr8ZQuiEE+3SwJ6E9QwgDE
         PVClSHyEcJ4Ke/aZotU+UysjngnUbLKziY/OSNjudZLhawqSiImVopZ7V2CY4B/nzbSK
         N46AyicgiLvPyw4QxMgZXetxwwXwtvGN+Ej8iBcasaNOfbW1xkyRGb1Tc9vwnecisklz
         EzP+GwSnDQW4oiIG/QwlseE/UTWFrK+pOZqbSC3fQfuRTJl5v3OEwMbHOjGfjNAetMVW
         KHhPf39jxfLT1i9RvSP5x/NEscuXAV8YHgTAb109XFYOZELqYiNGrkWdn8s5/r0kG/px
         +STw==
X-Gm-Message-State: ABy/qLaJ1iAxWSIcSmIQCSseV7/uJ7lWbsxQ/mt/H9qFj/HGykYSRWTY
        zPISKnodiGaTKTyLoAmO8+A=
X-Google-Smtp-Source: APBJJlF8PGF3kIOqDDcd8iBgMQDwo5SHYLCSJ23t56NouDYZxRwNMVfNh4+/C0uNHBeZG1qHtYxJFA==
X-Received: by 2002:a17:902:b28b:b0:1b8:6cab:db7f with SMTP id u11-20020a170902b28b00b001b86cabdb7fmr4807352plr.53.1689774203465;
        Wed, 19 Jul 2023 06:43:23 -0700 (PDT)
Received: from ubuntu ([59.178.102.25])
        by smtp.gmail.com with ESMTPSA id iz9-20020a170902ef8900b001a1b66af22fsm3991568plb.62.2023.07.19.06.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 06:43:22 -0700 (PDT)
Date:   Wed, 19 Jul 2023 06:43:14 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Fabio <fmdefrancesco@gmail.com>, Deepak R Varma <drv@mailo.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH] Remove unnecessary calls to kmap{,_local_page}() when
 acquiring pages using GFP_DMA32.
Message-ID: <20230719134314.GA7590@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GFP_DMA32 uses the DMA32 zone to satisfy the allocation
requests. Therefore, pages allocated with GFP_DMA32 cannot
come from Highmem.

Avoid using calls to kmap() / kunmap() as the kmap() is being
deprecated [1].

Avoid using calls to kmap_local_page() / kunmap_local() as the
code does not depends on the implicit disable of migration of
local mappings and is, in fact, an unnecessary overhead for
the main code [2].

Hence, use a plain page_address() directly in the
psb_mmu_alloc_pd function.

[1]: https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com/
[2]: https://lwn.net/Articles/836503/

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---
 drivers/gpu/drm/gma500/mmu.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/gma500/mmu.c b/drivers/gpu/drm/gma500/mmu.c
index a70b01ccdf70..1a44dd062fd1 100644
--- a/drivers/gpu/drm/gma500/mmu.c
+++ b/drivers/gpu/drm/gma500/mmu.c
@@ -184,20 +184,15 @@ struct psb_mmu_pd *psb_mmu_alloc_pd(struct psb_mmu_driver *driver,
 		pd->invalid_pte = 0;
 	}
 
-	v = kmap_local_page(pd->dummy_pt);
+	v = page_address(pd->dummy_pt);
 	for (i = 0; i < (PAGE_SIZE / sizeof(uint32_t)); ++i)
 		v[i] = pd->invalid_pte;
 
-	kunmap_local(v);
-
-	v = kmap_local_page(pd->p);
+	v = page_address(pd->p);
 	for (i = 0; i < (PAGE_SIZE / sizeof(uint32_t)); ++i)
 		v[i] = pd->invalid_pde;
 
-	kunmap_local(v);
-
-	clear_page(kmap(pd->dummy_page));
-	kunmap(pd->dummy_page);
+	clear_page(page_address(pd->dummy_page));
 
 	pd->tables = vmalloc_user(sizeof(struct psb_mmu_pt *) * 1024);
 	if (!pd->tables)
-- 
2.25.1

