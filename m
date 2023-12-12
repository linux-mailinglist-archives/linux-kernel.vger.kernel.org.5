Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A505980DFED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 01:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345411AbjLLAOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 19:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjLLAOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 19:14:04 -0500
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BF4B5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:14:10 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1702340048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AncAwIfqeN0IVwxDTP835Z83czb+v0Xl5CDrKJjV5+4=;
        b=bKtKFMTe4X+F9hC2vZUIc+SdwIvl8nKxxDHUQBLtCYSlg/5BI0SQcodYeoublgM3pciaVy
        L1YBni0auXLjPsMCYv3Z6VLXoQAywdCRwh4TMj822eZSeKpMC+jb99rzzkSTTdIQq5BaDL
        M6UPUAcMd3pkIm8Uadx+FSPhbBPHWos=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm 0/4] lib/stackdepot, kasan: fixes for stack eviction series
Date:   Tue, 12 Dec 2023 01:13:59 +0100
Message-Id: <cover.1702339432.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

A few fixes for the stack depot eviction series.

Andrey Konovalov (4):
  lib/stackdepot: add printk_deferred_enter/exit guards
  kasan: handle concurrent kasan_record_aux_stack calls
  kasan: memset free track in qlink_free
  lib/stackdepot: fix comment in include/linux/stackdepot.h

 include/linux/stackdepot.h |  2 --
 lib/stackdepot.c           |  9 +++++++++
 mm/kasan/generic.c         | 15 +++++++++++++--
 mm/kasan/quarantine.c      |  2 +-
 4 files changed, 23 insertions(+), 5 deletions(-)

-- 
2.25.1

