Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E788127EE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 07:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjLNG2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 01:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjLNG2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 01:28:32 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF28DB7;
        Wed, 13 Dec 2023 22:28:38 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id 46e09a7af769-6da16eab6fcso3145755a34.3;
        Wed, 13 Dec 2023 22:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702535318; x=1703140118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DACrLAWMgkdWOj6IS64GGQr5aAGYXSH/tnwt+3cBGmE=;
        b=Zsdu44nmfZvBRgJsZBZQgtI3hXMPq6tS2T5oBJ+rUho4v4tJ9vGD8RZ6psoU8rKxgt
         rTbu7P21lpsfNf1O/LL8IP+jLUXEE+4eZP7CeNqNwjGRtQXb6qI+vkv7XxQ9Wns5XSf7
         vI9o1Qtaxl01S1+mnqOXb64UwqjGecxPXE0ae5WFh74aRYwaJJGxGjjMVmFNNGDoQUZw
         qkRaJDw/Q67bpILd5wr1X8l5uxDiOMgO0ihd8bPlNMgOSFbIPTi+4CFNOKIhYHPD8sGf
         ZbNpnracPCpwV8Ie7CI3EXp+WCpxJIiRcHleD37SOJ2Hjxj6JWyds5/tTx95txJWKQxg
         DmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702535318; x=1703140118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DACrLAWMgkdWOj6IS64GGQr5aAGYXSH/tnwt+3cBGmE=;
        b=KNs+WGYIu8bYNCsWmZdFQeE694o7NU7YK5Mi7+totwx5FUWiMuYZZrBYG6xZxdUHGV
         ooAqILpNNr13Ym1Jm+Db+sI8Esy9zTgk+upa/S6Rlt51XVBADBgLAl4PGiNZUkNz93Ei
         IGf3RB2/G7vj+s0/tEMSITYc2op/h8qYwz9RIhYCyJrUTzPLVi3hGyMbaVZuRmYUt+Zy
         ILU/iC4Uz+uDGos4ykdY40rjbHtZgsV1doZZE5434VWCD/BaOpZi/6sJ0GKmw5+pRvnf
         GzLspSM9Cc3vwnuIhOu6xmpvfSuRZ8AJkQfRfetW5eqakEzTnms4ch+fQgm2QqI7I58b
         MCqw==
X-Gm-Message-State: AOJu0YyO9Yffd3R3Bz0pRPWgG/3U+it6IL8oEZebIx/6PAr8P4C2NYnN
        mKJoE7xJjDblbGqgRrebphI=
X-Google-Smtp-Source: AGHT+IGc+XSLEwAysJ/H6XUnxDX2fwwVEBl4Vm5agEu1aA3vS9QI53pf03vr2XUVPiVCYs0opkMChw==
X-Received: by 2002:a05:6808:1307:b0:3b9:ee89:541b with SMTP id y7-20020a056808130700b003b9ee89541bmr11183525oiv.28.1702535317951;
        Wed, 13 Dec 2023 22:28:37 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id z7-20020a63e107000000b005af08f65227sm10744770pgh.80.2023.12.13.22.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 22:28:37 -0800 (PST)
From:   Menglong Dong <menglong8.dong@gmail.com>
To:     andrii@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <menglong8.dong@gmail.com>
Subject: [PATCH bpf-next v3 0/2] bpf: support to track BPF_JNE
Date:   Thu, 14 Dec 2023 14:24:32 +0800
Message-Id: <20231214062434.3565630-1-menglong8.dong@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For now, the reg bounds is not handled for BPF_JNE case, which can cause
the failure of following case:

  /* The type of "a" is u16 */
  if (a > 0 && a < 100) {
    /* the range of the register for a is [0, 99], not [1, 99],
     * and will cause the following error:
     *
     *   invalid zero-sized read
     *
     * as a can be 0.
     */
    bpf_skb_store_bytes(skb, xx, xx, a, 0);
  }

In the code above, "a > 0" will be compiled to "jmp xxx if a == 0". In the
TRUE branch, the dst_reg will be marked as known to 0. However, in the
fallthrough(FALSE) branch, the dst_reg will not be handled, which makes
the [min, max] for a is [0, 99], not [1, 99].

In the 1st patch, we reduce the range of the dst reg if the src reg is a
const and is exactly the edge of the dst reg For BPF_JNE.

In the 2nd patch, we just activate the test case for this logic in
range_cond(), which is committed by Andrii in the
commit 8863238993e2 ("selftests/bpf: BPF register range bounds tester").

Changes since v2:
- fix a typo in the subject of the 1st patch
- add some comments to the 1st patch, as Eduard advised
- add some cases to the "crafted_cases"

Changes since v1:
- simplify the code in the 1st patch
- introduce the 2nd patch for the testing

Menglong Dong (2):
  bpf: make the verifier tracks the "not equal" for regs
  selftests/bpf: activate the OP_NE login in range_cond()

 kernel/bpf/verifier.c                         | 38 ++++++++++++++++++-
 .../selftests/bpf/prog_tests/reg_bounds.c     | 25 +++++++++---
 2 files changed, 56 insertions(+), 7 deletions(-)

-- 
2.39.2

