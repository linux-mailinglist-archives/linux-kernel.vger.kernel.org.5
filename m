Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99A37ACE3A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 04:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjIYCia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 22:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjIYCi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 22:38:28 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0291BD3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:38:22 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d81dd7d76e0so6290614276.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695609501; x=1696214301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cJ9z0a078b5wySKL6bV53uNSbGG+QsbIcm3OZtpNsys=;
        b=CZHNsAzcnr6O3VSVUnqxyNgnF/HvXugBACJ9doiL2tXvEbt+7xzTXJ4n4sj3dnDNuC
         85TRby4nxsuYjbfF7OuBMlj1hpuCXLmtdUO7tE+BlRLvWHAdsKfbS54QgAJmSmR4xNo8
         fSEsSJuShxNgpMkW8eHbrwbhU1Gd8MseNtNPi96HKnW6lRudVL77AfsHnnEkjBsNMK7G
         7Lt67H2gLwGJMk2ycgxAehRc+hQhThBdg6gjF4CVkW9OqcQ4k/YxKvIqpgb6sLV+JIPw
         MozFBrYiL4Q+kC4h83OEihEbwsTOFdFIcdGStDHA2ZtN6+1/vx11h9zp2Mh9mlm6pUkF
         RHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695609501; x=1696214301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cJ9z0a078b5wySKL6bV53uNSbGG+QsbIcm3OZtpNsys=;
        b=nv9Au+FG+RocY5fwjaFOu2wMsc1Uont+az7bX588YOK3qnpBrNtRHTho3gamnih/SA
         ij3H54cNBvD+KvJSSlXuWgQThMFvCaf/43W8hi5lrLIhWXFiqdOZ8jX7x59ow54ThDUS
         aXfqdeqcTBTnoLmlkvlqMHRtUYVJctxSZjFZgUCA8SXvLkt5lFjATjSYNFkR1GOxnCuy
         8sKNTbZQ3JrVhotZpvE7oxS8hoUpIuBSJKT3Y1qB7H+g6o/b/o/kjBQCskpkMuO0yJdE
         5awD8DWhCUy4+xKgvBz8MvNCpkJMR4zuIF069rnM6+3Q5kmEEsKbNIQsEjpC3CUy/YPB
         lgOg==
X-Gm-Message-State: AOJu0YzKy0HKintqsZBvbIJWeb19HKiRq0okoMCuxIQOzUbihXroyP8s
        mfoGfDJ3VDXX/Q1ElCCg/ZHNlKJJ4HE=
X-Google-Smtp-Source: AGHT+IG6/VvvyMe2bKWnO68RxZ+FR6N11DXG0tNZPI/hmg0pi1eb3G9xbe4YRMGGQ31kAABFRqGEqA==
X-Received: by 2002:a25:d344:0:b0:d84:b0f8:910 with SMTP id e65-20020a25d344000000b00d84b0f80910mr3606908ybf.6.1695609500684;
        Sun, 24 Sep 2023 19:38:20 -0700 (PDT)
Received: from localhost ([2607:fb90:3eac:cd78:b6b5:ba0f:9e64:f2e1])
        by smtp.gmail.com with ESMTPSA id u205-20020a2560d6000000b00d749bc5b169sm1123661ybb.43.2023.09.24.19.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 19:38:20 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 0/8] bitmap: cleanup bitmap_*_region() implementation
Date:   Sun, 24 Sep 2023 19:38:09 -0700
Message-Id: <20230925023817.782509-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
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

bitmap_{allocate,find_free,release}_region() functions are implemented
on top of _reg_op() machinery. It duplicates existing generic functionality
with no benefits. In fact, generic alternatives may work even better
because they optimized for small_const_nbits() case and overall very well
optimized for performance and code generation.

This series drops _reg_op() entirely.

v2: https://lore.kernel.org/lkml/20230811005732.107718-2-yury.norov@gmail.com/T/
v3: https://lore.kernel.org/lkml/20230815233628.45016-2-yury.norov@gmail.com/T/
v4: https://lore.kernel.org/lkml/20230829023911.64335-1-yury.norov@gmail.com/T/
v5: - fix bitmap_release_region() implementation;
    - address nits for commits comments.

Yury Norov (8):
  bitmap: align __reg_op() wrappers with modern coding style
  bitmap: add test for bitmap_*_region() functions
  bitmap: fix opencoded bitmap_allocate_region()
  bitmap: replace _reg_op(REG_OP_ALLOC) with bitmap_set()
  bitmap: replace _reg_op(REG_OP_RELEASE) with bitmap_clear()
  bitmap: replace _reg_op(REG_OP_ISFREE) with find_next_bit()
  bitmap: drop _reg_op() function
  bitmap: move bitmap_*_region() functions to bitmap.h

 include/linux/bitmap.h |  63 ++++++++++++++++++-
 lib/bitmap.c           | 140 -----------------------------------------
 lib/test_bitmap.c      |  24 +++++++
 3 files changed, 84 insertions(+), 143 deletions(-)

-- 
2.39.2

