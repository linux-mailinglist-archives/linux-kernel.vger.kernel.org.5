Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B24578B76F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjH1SoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbjH1SoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:44:00 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28F1FF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:43:57 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a8506f5b73so2567853b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693248237; x=1693853037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=txjj3QvXdwOFCbvITIz9cY62QS5vUcgoe9+VToaiTZA=;
        b=aLj9ubWh9jaezxggBtluSGaJOlPEWdRUQZQrWfNm0HilGSgd2QspPAvPBTCsgU+Yr9
         BGLj4/tCsIYb4wVILPpAsE6IWBB4EMsenOPnlXJy3mVfYkZ0gefu7BWJQxFUj8MrwqSz
         jPLZfmIS7YCcWDjR+zQTdf94rIW6Z40XDnshxAU4bzyoE6rYNDr4igYMcgW/BxQZ+l7O
         v8zPq/8PjkMDCqe8Vdi/Y1P64Zzd1QzA8GixjHGeiaMoKvMJzZgdTpkdG8Yc/Tmildbl
         Nczfzr1mG28VzcRiZZvYW1wfD0Wkap/mBG1nZcm79snDu3GVzhNLKPThliwhZrLjsdKK
         Z9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693248237; x=1693853037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=txjj3QvXdwOFCbvITIz9cY62QS5vUcgoe9+VToaiTZA=;
        b=CrFmE9Pt7W7ngEOR8PueoZ11RdKPO3znPA19G525PyFzfsTtYPOK2TxdpgU8wMX94l
         tkH5eFYDaNue8qTBf8Y9z8ZkQH6vVgf1gEpdDUES8rCbjRUZipbn/ToPQIQveKKblqgI
         BXYNSw+ji2xy6XThcMnMCRGOHZcMMQVgrksI816GEGEUm7L7mR72ZZIOGhmpFO5h+Gvv
         hqxFd/qc7wj2K49z4ZIk6Tf67o/wpf4bw1y+3FfTthB+l/wKxdkgve/Rmt68aqp0CTOD
         SsSH5ATs4oFr/Y2fTnO45ssiVi6HDDClVpgDlUhjK1oau3YUSjqJSVnkItA+gzA/Ypa6
         kUhQ==
X-Gm-Message-State: AOJu0YxfMVw7D84m/oBFogkexcA2T9WBdI514N+UDaNlWqEEEZrirD+r
        Sa8/evspR25ZGLt9g5z/YhhA5ffwyYc=
X-Google-Smtp-Source: AGHT+IE3pjNiFnyF0aParH6X3A6V84B2Q/ee3PteyQhfQBkKkjvQX7lAQUZKwVpQIQCQh5xdufCg6w==
X-Received: by 2002:a05:6808:1511:b0:3a3:60f0:5e0c with SMTP id u17-20020a056808151100b003a360f05e0cmr15484236oiw.17.1693248236682;
        Mon, 28 Aug 2023 11:43:56 -0700 (PDT)
Received: from localhost ([2600:6c5e:2a00:5805:e348:56d4:5da8:636d])
        by smtp.gmail.com with ESMTPSA id a27-20020a056808099b00b00396050dca14sm3669022oic.28.2023.08.28.11.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 11:43:55 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 00/12] bitmap: rework bitmap_{bit,}remap()
Date:   Mon, 28 Aug 2023 11:43:40 -0700
Message-Id: <20230828184353.5145-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a test, const-time optimizaton and fixes O(N^2)
complexity problem for the functions. It's based on discussion in
bitmap: optimize bitmap_remap() series [1], but there's much more work
here, so I decided to give it a separete run, and don't name it as v2.

bitmap_remap() API has just one user in generic code, and few more in
drivers, so this may look like an overkill. But the work gives ~10x
better performance for a 1000-bit bitmaps, which is typical for nodemasks
in major distros like Ubuntu.

Anyways, the work is done, so guys please review.

[1] https://lore.kernel.org/lkml/20230815235934.47782-1-yury.norov@gmail.com/T/
Yury Norov (12):
  bitmap: add find_nth_bit_from()
  bitmap: add bitmap_weight_from()
  bitmap: add test for bitmap_remap()
  bitmap: add test for bitmap_bitremap()
  bitmap: update comment for bitmap_{bit,}remap()
  bitmap: add small_cont_nbits() optimization for bitmap_remap()
  bitmap: add small_const_nbits() optimization for bitmap_bitremap()
  bitmap: optiimze bitmap_bitremap()
  bitmap: optimize bitmap_remap() when 'new' is empty map
  bitmap: separate handling of identity and remapping parts in
    bitmap_remap()
  bitmap: defer calculating weight of 'new' in bitmap_remap()
  bitmap: don't count bits from the beginning in bitmap_remap()

 include/linux/bitmap.h | 116 +++++++++++++++++++++++++++++++--
 include/linux/find.h   |  37 +++++++++++
 lib/bitmap.c           | 145 ++++++++++++++++++++---------------------
 lib/find_bit.c         |  29 +++++++++
 lib/test_bitmap.c      | 142 +++++++++++++++++++++++++++++++++++++++-
 5 files changed, 388 insertions(+), 81 deletions(-)

-- 
2.39.2

