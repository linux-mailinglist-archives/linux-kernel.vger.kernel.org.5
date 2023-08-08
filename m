Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBAD774664
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbjHHSzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbjHHSzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:55:13 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF21E161DDC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:13:32 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id d75a77b69052e-40fccbf38baso71997621cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691514812; x=1692119612;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EkVOcLFWZmwsoRL/5n714aziwI0sk9cLG75O5IT9Ok0=;
        b=Yxk1b2Egbi92ggvtHMHnWeHobqqCrUz7dHG86XqVSmG5SD6psdh8qtJzpyKYdUQbT+
         +TIhRstuFFN2dkr6neMKk/NyIZpaZDyvfnswVlpPcyXfqM8SkUMAhA0EHUNRikIoR7M+
         D8EFqmI3g60Pcx7bJM65sXJKaw9WfqrnGqyei8LitEGNPmhtHUJmlRNMKUtDfSYxdkIY
         ncgQkgZloE86z7qItjuZquG5OB0Y33ZzLeTYFlALVYJPbl4MluDlfebmAwjnLQ/1O7OJ
         bao/4LbYbU4ZXW1CsyVNX831/bsNB0briEIhVnGfq1Bs2bVkTQL2f33GZl74DJNI9D9E
         jMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514812; x=1692119612;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EkVOcLFWZmwsoRL/5n714aziwI0sk9cLG75O5IT9Ok0=;
        b=l29OIkT2MtB1VDroIWDOrIpqIcOPqe733PkKeH+/aAYi37U0SA3BTtoQrNivbAMyWr
         9xoVN2t5DKrecTwIfUMNzbcVx3y8ce2qiK5LZvqzcrn+pwyaUX3jyA7A6gk3w/r1rWqo
         u+/pMjgrLKUmcgg0EvwFoyRJ8Y5wT2m0RfDC7b0A1UyM1aEeOSkjwqowUFto6Rc/b/Dc
         4ylkA6ma9UrWPOh64KqXoaQkGDkdp4+fbmJLezLI3wpQDw/oyyidbL6q5A1YyzZWar28
         M7kBVJ2jvtTfTB0tQ7E7SxkltynNs+5glm/KWxkdJEW6b82W5wTFzTHuBROLAyepDTiH
         uSPg==
X-Gm-Message-State: AOJu0Yz4sUZmPIKcBZxMWnDnY5D8FeGxGAJEk5SNbhFxZvAiPrfjd7/L
        JbLJthrsEhiHxHFzpq0KCRFwBZi8UT8q7H0c/S5t4cimhiDRKE3PuRJ8tPCA+BBOxOqI3HmKhaa
        vX6mxB4ZG2dZBpvGhW0O3ejTPdsGfuggVerqbevqP0qvr8UYey+19ds3txQnedYwsEZ7wSVA=
X-Google-Smtp-Source: AGHT+IGY5bo9gGt3ht2Lvvv05+XvcWFuJDPaZwLcxGgGbVmFlK2D5Q2JnioQeOzyMHt6xIs51cT6zGaK/UKt
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a81:b54b:0:b0:586:a8ab:f8fe with SMTP id
 c11-20020a81b54b000000b00586a8abf8femr98066ywk.10.1691476022612; Mon, 07 Aug
 2023 23:27:02 -0700 (PDT)
Date:   Tue,  8 Aug 2023 06:26:40 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230808062658.391595-1-jstultz@google.com>
Subject: [RFC][PATCH 0/3] Fixes for test-ww_mutex stress test
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Li Zhijian <zhijianx.li@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of recent stabilizing of the proxy-execution series,
I've seen a number of issues from the test-ww_mutex module.

This is great for shaking out problems in the patches, but
in some cases it seems the patch series has made it easier
to uncover problems in the test-ww_mutex stress tests.

So this patch series provides a few fixes that I've come
up with in testing with qemu using large cpu counts.

Feedback would be greatly appreciated!

thanks
-john

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Li Zhijian <zhijianx.li@intel.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: kernel-team@android.com

John Stultz (3):
  test-ww_mutex: Use prng instead of rng to avoid hangs at bootup
  test-ww_mutex: Fix potential workqueue corruption
  test-ww_mutex: Make sure we bail out instead of livelock

 kernel/locking/test-ww_mutex.c | 48 ++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 14 deletions(-)

-- 
2.41.0.640.ga95def55d0-goog

