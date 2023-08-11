Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F547784AD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 02:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjHKA5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 20:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjHKA5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 20:57:41 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2CB2703
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 17:57:41 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-76ca7b4782cso112932285a.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 17:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691715460; x=1692320260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n1rk0nvoi725Hpjwewuj7znFUKMprrVjrDU/HSW72rY=;
        b=NkVCkSqS5We+yo0QHLmRZTBS9xnqzV3wm4c+0Pfatc64s0mJ22vIb61bMrtGwvuwLX
         +tlhEQ6pikBzRilhrtbPBsWw2o9AMfGzNNAILf12d3+YfUaVm62OPYDfhnJt2jp+ZiuL
         Ofj3e2HJgxiDAlNBTzwphjZVzpAbndlRqTw3KzieYNDfO0CCoqnS0ZuBPZnSLItgtmr9
         CrsHUCrZZ1IVHd8V0O7wI8RQ7NfB+QclkyDqUgodeiFNBajSlrrt4LonXa8SvZEDvE8S
         6z7Qdy6bEbqTCs6HeWMHJX3Y77PEneSLts27q89Tucd2McNIcSvn1SZY7LUS6CCQjcpC
         gADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691715460; x=1692320260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n1rk0nvoi725Hpjwewuj7znFUKMprrVjrDU/HSW72rY=;
        b=UYK1iqN6bKps7Tpn5CetNB3vYTUk1Pb0HesN4rtmcWJ3sa2a0xz3at+m2Hhp8NrNoS
         Jz6pGbtc8yMRwQxYaf262L3t79XDrrRSSXyjt4nm+noozrkwpCmOrGM15KInDCXC1z1C
         vJqJpd3wpU61ztbRecXrJyp64ZC0DDwD1YZsbTL2OCJsfTszC7wU+oUCbsk/2botKkI1
         2zSa0ymZpdfOLp5KhKkZEsHPs3m9tAGux9lnLvWy4QEb1hURMyg86BTDAZPdTfH5t9lt
         h+IIjQDGQkGYS1s0BB7KH4OVnkSY5ixqc9Q+Uc4mudIYKCVoFRt3bP6+gIQmRUVu77N6
         jiIA==
X-Gm-Message-State: AOJu0Yxf2ms3SYqsvoXGWjSQxU/RLbY6M0A9DSwYUI6hwf4XKnsWvW8a
        TagM9v6q/ATgwCNRODMSM7FJqRNtdTw=
X-Google-Smtp-Source: AGHT+IHYOhPV+K+Oq16IuU9sCanAfPgMaCKYlOpLex58AfqS7GP0c1pCX2SLPRqtkdkHAa7U18FuUA==
X-Received: by 2002:a05:620a:25cd:b0:76c:d9e9:541 with SMTP id y13-20020a05620a25cd00b0076cd9e90541mr386901qko.78.1691715460046;
        Thu, 10 Aug 2023 17:57:40 -0700 (PDT)
Received: from localhost (2603-7080-3d03-3cb9-317d-7087-0f3e-bab3.res6.spectrum.com. [2603:7080:3d03:3cb9:317d:7087:f3e:bab3])
        by smtp.gmail.com with ESMTPSA id m14-20020ae9e70e000000b0076c7f3dd32csm862534qka.100.2023.08.10.17.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 17:57:39 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v2 0/6] bitmap: cleanup bitmap_*_region() implementation
Date:   Thu, 10 Aug 2023 17:57:26 -0700
Message-Id: <20230811005732.107718-1-yury.norov@gmail.com>
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

