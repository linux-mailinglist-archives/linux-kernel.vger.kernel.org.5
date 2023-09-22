Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A837B7AA7DE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 06:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjIVEge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 00:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjIVEg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 00:36:29 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A990122
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 21:36:24 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59bfccec7f3so25745457b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 21:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695357383; x=1695962183; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wb1Iw9NYXgo0vQhW3xtBazJ18EX/K35qNPNM7O7eg4s=;
        b=Grn58Zba5/F7XGjCIaHt1Pfw5yJZPQGcm2DQUTLVVV0REPffF/FSx7IEU4y9wb1zWn
         MhJx6KfjPf1bgs/tkO5KlUuz8Aw+4H8JWAyn64b7vv0GlJubcuxcDV0LDSKPrhzoSXBl
         DzEpq3STxPKxZr1zDkZVQV6YTBrCDz9KIPan0WuDVk2tM4uJP2be73swv6w3p8OmZXSv
         rk4SqFG1/Y4B0qup1l0T4sSDVJTep5MHGVnMbCwYX1Ol82vSwuk0u8KkGTigMoKSllB+
         aJkLSjGfTZBT4BOTlZCNCGmzMFHgTLfQX7s2UInRVtE8fXlF7i7Yg2wwH43Y9ZStv4zw
         gAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695357383; x=1695962183;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wb1Iw9NYXgo0vQhW3xtBazJ18EX/K35qNPNM7O7eg4s=;
        b=DAEdLnC1gbO89EQxcIQhOZPwO7CitQfGg/ri2LI9OcGtgP2P6rKr5dBpXqKyuPNlMY
         B5hhIU21+BXio+CA8dKHnihDVNqCJpT7BZ3VOCfb74P9Nx8h8vLLmA2a1/2lheBD6sQL
         3x95igpfUaqNq24SYkJYBQilDn4q4tfg0rq5yhKUF9QwvQc9Dek47YiiYrIHs2doz0GZ
         +DUSbUAZU48PuPwG/co0cQSQR0vQpi0aHzft/UFg1cvirgt7Gta5wkEK97Y3KzMtw17V
         eGGSIjNo1fV0r/ZAYZdOW5OBYvFQEn4qZhMWSxgHpl7Hnpb8QQChT2FnA44/Ez0masXx
         I0lg==
X-Gm-Message-State: AOJu0YxBC5veHUQnd3MlzWOWzDToycZaFExnB11ES8kLI3WZa2JB1JkG
        JB5RCc81lYXI5QkNTFJoIReAu30iiRqXWvDKdFvkHuWQNw/sz4ZdDZb4UeTRQ1vL+jISrtD7v/1
        kp2siHFFj+J3kpr6JTPgxCuJnOBHnzDiRdd/AIkMNLZWuMFpmZzqWlF6xvnB541RdU6mm6vA=
X-Google-Smtp-Source: AGHT+IGbd6AWEysig4QWQuxkv28qojZ8CcpMG/2rUN3pSzwc+TYYl61hbfoK80M81eVfa+nIynPS23nFnSsL
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a81:d105:0:b0:59c:b9b:8940 with SMTP id
 w5-20020a81d105000000b0059c0b9b8940mr111966ywi.8.1695357383116; Thu, 21 Sep
 2023 21:36:23 -0700 (PDT)
Date:   Fri, 22 Sep 2023 04:35:58 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922043616.19282-1-jstultz@google.com>
Subject: [PATCH 0/3] Fixes for test-ww_mutex stress test
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of recent stabilizing of the proxy-execution series,
I've seen a number of issues from the test-ww_mutex module.

This test is great for shaking out problems in the patches, but
in some cases it seems the patch series has made it easier to
uncover problems in the test-ww_mutex stress tests.

So this patch series provides a few fixes that I've come up with
in testing with qemu using large cpu counts.

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
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: kernel-team@android.com

John Stultz (3):
  test-ww_mutex: Use prng instead of rng to avoid hangs at bootup
  test-ww_mutex: Fix potential workqueue corruption
  test-ww_mutex: Make sure we bail out instead of livelock

 kernel/locking/test-ww_mutex.c | 48 ++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 14 deletions(-)

-- 
2.42.0.515.g380fc7ccd1-goog

