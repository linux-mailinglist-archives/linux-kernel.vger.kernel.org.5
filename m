Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2431E7FDBE7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343973AbjK2Prc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbjK2PrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:47:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212A510DF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:47:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9DEC433C8;
        Wed, 29 Nov 2023 15:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701272849;
        bh=va2Tar7pxnejs3M1VcAGZWrzhchuLOk49oqr393r88A=;
        h=From:To:Cc:Subject:Date:From;
        b=BPg89qL7zrSnlQbpUPKqMUHJ6XP5jT4axiCT8fXb1nUmV8APdQcnJcuIqDuBfUJNX
         QpgWwk7pw0SNDGOC/ZnNmVEdSG7K7eikvlGGD8HGSZPp4J8pH8Ocy/LnhkuGTYthlY
         cAxFqHk7w+o87epGY5B+WTHJ3HyAWeGVIv6R8DUKk8YgWrgSG/b7s8x1jnMTBvkFg/
         n3uLM7K4PnmSuaOIq+MGDUZ+6iFajMDJ3OBnM9ZJhdaF1d32nmoeHwrcCSAsLUhtNT
         qFcy2WMQ3qtstEmYc07HpiYibj8sEkoGSN1hg4yzwBCR53DTbAA7lFq2RNKKeAXdYt
         HhmFyGXOSziJA==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Marco Elver <elver@google.com>, Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/2] Skip the 'perf test sigtrap' on kernels with sleepable spinlocks
Date:   Wed, 29 Nov 2023 12:47:16 -0300
Message-ID: <20231129154718.326330-1-acme@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi,

	Please take a look,

- Arnaldo

Arnaldo Carvalho de Melo (2):
  perf test sigtrap: Generalize the BTF routine to reuse it in this test
  perf tests sigtrap: Skip if running on a kernel with sleepable
    spinlocks

 tools/perf/tests/sigtrap.c | 106 +++++++++++++++++++++++++++++--------
 1 file changed, 84 insertions(+), 22 deletions(-)

-- 
2.41.0

