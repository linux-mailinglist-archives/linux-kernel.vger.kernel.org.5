Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAD77784AC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 02:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjHKA4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 20:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjHKA42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 20:56:28 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6CF2703
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 17:56:28 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-63d0228d32bso9409486d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 17:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691715386; x=1692320186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n1rk0nvoi725Hpjwewuj7znFUKMprrVjrDU/HSW72rY=;
        b=ndi4CEE/DHsHYkn6Y9SYntf+mViRROJjRBiyqxvswo1HNfiaxftpsGX/2dQmuH8G4a
         iS36syBd34J9SLByCGfWRsNktT/ZVR+VpDgztOBNrwNb+furbvhSjn6a0fVr7/Hno3h/
         gnZCjLyzZtF+tTLDHgKx7SrEv1rJH7gjQFcUTTZOfPIiZHHE2WchnSL1OzuqG+klkDsx
         Ff3jWWs4r475L+xvwS6r+15yU/Dja5K7HLs+JyFn1KO6lK0Wb7m9Yc5Y8cV/2nC5xKT6
         eR1zH3pwjmfEI+lAPEptbXC6eKYB+xtbbh4TkNAT38zC2TTX9blbG5+M2f1DCmx92dCj
         KFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691715386; x=1692320186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n1rk0nvoi725Hpjwewuj7znFUKMprrVjrDU/HSW72rY=;
        b=QA4h6XbwrO0Rp7mN90i1LKVLttRGIJ5FqTzOpP8ZbsUkYeg4T6F2rpmiYCq128DMCi
         tKxTrd7vSyY2mroayBqkoRwxsGpcekRabDhGOkVLDB7SAHqOxdxOFkjjJcUeVN8tP/Fm
         UrHNCLpVT06oorejUuVwtMrkpE3G/pxM3zEjg1vmnT3XiF8KTafOtWnWFEPXC9u1zJ+K
         5Nx0jMEPajfzynSj0QxLRFm7S2tK81hs6NbBFjj4nr/6DFVm62wocyDd7M8hd3qBekyA
         E9hFwxtGoR160j7A/Jwb4A7oFVpvly6i80ZWqFiSngnvbcZrFj9fwshKv1M6F0A9s4wQ
         xeUg==
X-Gm-Message-State: AOJu0YybKSvop93pYIA9Qd/PdzuNfxHLeNyTvuMqA7NUxQBccweKOsef
        rga7jI8IvTurCG9zQzpgQiSH1U7/Qzs=
X-Google-Smtp-Source: AGHT+IFRBd/GRvcZ1vCTRbDWo0qmRdp2Lr1KS0kjNsYkhvo0FHMGhFepAIV3BNyBlGDMHLwm0Qw24Q==
X-Received: by 2002:a0c:b283:0:b0:63c:f5ee:438 with SMTP id r3-20020a0cb283000000b0063cf5ee0438mr278011qve.18.1691715386370;
        Thu, 10 Aug 2023 17:56:26 -0700 (PDT)
Received: from localhost (2603-7080-3d03-3cb9-317d-7087-0f3e-bab3.res6.spectrum.com. [2603:7080:3d03:3cb9:317d:7087:f3e:bab3])
        by smtp.gmail.com with ESMTPSA id u8-20020a0cdd08000000b006360778f314sm850651qvk.105.2023.08.10.17.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 17:56:25 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v2 0/6] bitmap: cleanup bitmap_*_region() implementation
Date:   Thu, 10 Aug 2023 17:56:15 -0700
Message-Id: <20230811005621.107581-1-yury.norov@gmail.com>
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

v2:
 - fix declaration order (patch6);
 - fix kernel-doc varnings;
 - don't use 'drop' wording where (patches 2-4);

Yury Norov (6):
  bitmap: fix opencoded bitmap_allocate_region()
  bitmap: replace _reg_op(REG_OP_ALLOC) with bitmap_set()
  bitmap: replace _reg_op(REG_OP_RELEASE) with bitmap_clear()
  bitmap: replace _reg_op(REG_OP_ISFREE) with find_next_bit()
  bitmap: drop _reg_op() function
  bitmap: move bitmap_*_region functions to bitmap.h

 include/linux/bitmap.h |  65 ++++++++++++++++++-
 lib/bitmap.c           | 140 -----------------------------------------
 2 files changed, 62 insertions(+), 143 deletions(-)

-- 
2.39.2

