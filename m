Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDD17BBBA2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjJFPS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjJFPSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:18:52 -0400
Received: from out-191.mta0.migadu.com (out-191.mta0.migadu.com [91.218.175.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B0883
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 08:18:51 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696605529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FLvCKBjoIRy4tmBKqXgjqjKrcGEcT90AXXA8acJ55o4=;
        b=neSUwvrokSQShcafYLUcGek+WX3dU0wDkf5in4rNYjQtuYZIDOE9V7fq1TIioFt4WIL2Ut
        UjQgOwYOKyLKuTUn+2bAw3NgYPt4IvEJtUwjXnManbiy4yJICclbbuyJGlL0Y3fzJAP2FR
        VJU9r5HzuVEK1btzhoIx0JPpD5K3Xcs=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 0/5] kasan: assorted fixes and improvements
Date:   Fri,  6 Oct 2023 17:18:41 +0200
Message-Id: <cover.1696605143.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Andrey Konovalov (5):
  arm64, kasan: update comment in kasan_init
  kasan: unify printk prefixes
  kasan: use unchecked __memset internally
  kasan: fix and update KUNIT_EXPECT_KASAN_FAIL comment
  Documentation: *san: drop "the" from article titles

 Documentation/dev-tools/kasan.rst |  7 +++++--
 Documentation/dev-tools/kcsan.rst |  4 ++--
 Documentation/dev-tools/kmsan.rst |  6 +++---
 arch/arm64/mm/kasan_init.c        |  6 +++++-
 mm/kasan/kasan_test.c             | 11 ++++++-----
 mm/kasan/kasan_test_module.c      |  2 +-
 mm/kasan/quarantine.c             |  4 +++-
 mm/kasan/report.c                 |  4 ++--
 mm/kasan/report_generic.c         |  6 +++---
 mm/kasan/shadow.c                 |  2 +-
 10 files changed, 31 insertions(+), 21 deletions(-)

-- 
2.25.1

