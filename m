Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977887BB69E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjJFLkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjJFLkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:40:07 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A2CCA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 04:40:04 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-27b0d0c0ba0so1548986a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 04:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696592404; x=1697197204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QHm8jJJ/p1NoLY8+1C/Y6ziP56DyiQCP3smpzNPfPp0=;
        b=maTrAfgy7hC6pME8q5mZU5ka9fKo2g+c34tYzDCkdG3twv8y26d7yqNa6Q4Odd8CRT
         XKao+8bUGV89OK8huJhBH1a/0IXuN4DAMyedPw9dNjX4oVP0tp67FFC34uc16j2sKd3E
         RqeahPd5H5joye5EHTS5fpszeFhCDVgzbYRyw6TFM9mh/ryxRXKJPKTQPWzJayjruR1D
         PO/jdsGhHrTiBBzXt5sMu1wEFRRBS+YviZfFxnHBVtHe/WqDdJOmM/HuCwYr97ZBELML
         /2Im9dRIYh7CoCVJ+3o4DL3q+QaqdzsgtMnr9kx3+eNd4b5v+5Oam9CchC/yB/Hh0nMz
         +fng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696592404; x=1697197204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QHm8jJJ/p1NoLY8+1C/Y6ziP56DyiQCP3smpzNPfPp0=;
        b=Q3qGdCV0PP6xp1pFvOZ5GAWaagT/zkdgiJjZI+ViPdSFi8nuXankywiXQrwSHkAOcR
         derShM/hlwEaQeUKXT/uhLcHznWKE/3iagEVCsXe0esQ0Bz5Z29lvtnp5/efdjIyALGP
         zz0OsFggou7Xg74BNCLGlqYgGHauDFgk7IcClFv7hEa5z/myNN3o/u3IBB1UN7ODUrnh
         D/rLvYRvDqwma8nXgzWZCU0rZLl/r9Nae8ZewySKIKl2uCUyb5Uy2IvkCmZyKmRzGe1m
         sTnJYLRph8xosYQIquSRNbDl0Dha8HcSYa8DH7u1X+UNFgxoULIn7+KFHROMgCr8m8Dp
         6c8w==
X-Gm-Message-State: AOJu0YwpShx8xTjyHeAOazxIAy++2L6F8vhqct0GteVjmEZdiU6IEevj
        gjSJ5UQhR4fSJI9bRXe8Wys=
X-Google-Smtp-Source: AGHT+IFclY8UpQsOLgzSw3G/ekusP74Z1hTNKIYnYhamigGu9Gg5SztWr8eJBuLYTcU3/BvIBGXypQ==
X-Received: by 2002:a17:90a:e144:b0:26b:3751:652a with SMTP id ez4-20020a17090ae14400b0026b3751652amr8127055pjb.38.1696592404049;
        Fri, 06 Oct 2023 04:40:04 -0700 (PDT)
Received: from dreambig.dreambig.corp ([58.27.187.115])
        by smtp.gmail.com with ESMTPSA id m8-20020a17090a4d8800b00263f41a655esm3159068pjh.43.2023.10.06.04.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 04:40:03 -0700 (PDT)
From:   Muzammil <m.muzzammilashraf@gmail.com>
X-Google-Original-From: Muzammil <muzammil@dreambigsemi.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Subject: [PATCH] mm: rmap.c: fix kenrel-doc warning
Date:   Fri,  6 Oct 2023 16:39:48 +0500
Message-Id: <20231006113948.51673-1-muzammil@dreambigsemi.com>
X-Mailer: git-send-email 2.25.1
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

From: Muhammad Muzammil <m.muzzammilashraf@gmail.com>

after running make htmldocs, getting this warning
warning: Function parameter or member 'folio' not described in
'folio_move_anon_rmap'
and this patch resolves this warning

Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
---
 mm/rmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index c1f11c9dbe61..0863083b3472 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1129,7 +1129,7 @@ int folio_total_mapcount(struct folio *folio)
 
 /**
  * folio_move_anon_rmap - move a folio to our anon_vma
- * @page:	The folio to move to our anon_vma
+ * @folio:  struct folio - Represents a contiguous set of bytes.
  * @vma:	The vma the folio belongs to
  *
  * When a folio belongs exclusively to one process after a COW event,
-- 
2.27.0

