Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CE078BCE4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 04:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbjH2Cju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 22:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjH2CjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 22:39:17 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCDACA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 19:39:15 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6bca3588edbso2657809a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 19:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693276754; x=1693881554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zQaddOzDcrvd3bgaH++xIJwU6LMDlx9WVttxzuSP50E=;
        b=QITltsVgAwGefkE1S0ZnHy7ggfAlrUIChuBnk4nTSktC7hLP0Ml+wTqYxG2fNZluZD
         wjuKFSXGVEZuhwn0DX89xFVVldpkbTL4GOqJdtSLSK6ApIxqWdkNfKIgfZqZk9XkIaAI
         6j3oP5BBCmo6H/kvTiPth6TCcgk1cmdqdH0vI71CCgpJwlnbJQqdI8R1n+jNK44OOZGu
         QR+bWmSIYY0YB+fjjodDU5hOzhNcwBkY3uiDa1mRqNzISCpNA/kFUWnJZCUs3bPGLuMy
         ePJPpIFFScMn56YINmC38PCwkvDm7qVNmB0fFH7ge24RjNlGw4X9JuWu+lEYCAdkl0LY
         ZuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693276754; x=1693881554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQaddOzDcrvd3bgaH++xIJwU6LMDlx9WVttxzuSP50E=;
        b=Lb1MVbco7LHgSqEP5p0ixbMqmVMx/dmd6MZCAp4V7chaku4SrKyBwuVmQP2cHXSMTD
         fXEnnWpkb371+dgI8hCPT+XVeJS5KDuFh5391ZAIeKYZNgWv/4Pg0Q/bh7V9vjX5EtTw
         sek3qUIfIek1J8rOiKv9H0K2XMTXI4pmGBKrDRXKBgcKTIkop3QBydsO+vJe5x2FOoq0
         c9XvVZwYSdbh/TLPk6qFbeNc7tAhuQzB+yPzjzEfcQP4xhQ2V1Y+6zAJvBGuu2IBQlYW
         OZkgnL0XF1ePY2P45qGcRrSTvGCgcyrYclEqNaypuBxVTIlE9eRsIWmDkyo0MO4bKY7/
         XD9Q==
X-Gm-Message-State: AOJu0Yx2XhcvHc0pdOdQB8iDBJpMsXDy32IJpvxL/2SKdsl0uHvF64iN
        79DTpI+tQRK/cbsj+hZL8Y58RG/PyyA=
X-Google-Smtp-Source: AGHT+IFCUwPNy9SXqrYZTK9sNz60Y+drax8t37iR/Ssg0OxBqQzwoOvKmcIxaLOjX6sc3RMnIBGwrA==
X-Received: by 2002:a05:6830:1188:b0:6b9:a9a8:7807 with SMTP id u8-20020a056830118800b006b9a9a87807mr14635077otq.23.1693276754045;
        Mon, 28 Aug 2023 19:39:14 -0700 (PDT)
Received: from localhost ([2600:6c5e:2a00:5805:c222:580f:7592:7110])
        by smtp.gmail.com with ESMTPSA id d5-20020a056830044500b006b89dafb721sm1494447otc.78.2023.08.28.19.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 19:39:13 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 0/8] bitmap: cleanup bitmap_*_region() implementation
Date:   Mon, 28 Aug 2023 19:39:03 -0700
Message-Id: <20230829023911.64335-1-yury.norov@gmail.com>
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

bitmap_{allocate,find_free,release}_region() functions are implemented
on top of _reg_op() machinery. It duplicates existing generic functionality
with no benefits. In fact, generic alternatives may work even better
because they optimized for small_const_nbits() case and overall very well
optimized for performance and code generation.

This series drops _reg_op() entirely.

v2: https://lore.kernel.org/lkml/20230811005732.107718-2-yury.norov@gmail.com/T/
v3: https://lore.kernel.org/lkml/20230815233628.45016-2-yury.norov@gmail.com/T/
v4: address nits for v3.

Yury Norov (8):
  bitmap: align __reg_op() wrappers with modern coding style
  bitmap: add test for bitmap_*_regoon() functions
  bitmap: fix opencoded bitmap_allocate_region()
  bitmap: replace _reg_op(REG_OP_ALLOC) with bitmap_set()
  bitmap: replace _reg_op(REG_OP_RELEASE) with bitmap_clear()
  bitmap: replace _reg_op(REG_OP_ISFREE) with find_next_bit()
  bitmap: drop _reg_op() function
  bitmap: move bitmap_*_region functions to bitmap.h

 include/linux/bitmap.h |  63 ++++++++++++++++++-
 lib/bitmap.c           | 140 -----------------------------------------
 lib/test_bitmap.c      |  24 +++++++
 3 files changed, 84 insertions(+), 143 deletions(-)

-- 
2.39.2

