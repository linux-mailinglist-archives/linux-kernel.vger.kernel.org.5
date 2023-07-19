Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7F5759FD1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjGSUbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjGSUbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:31:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A99D26B5;
        Wed, 19 Jul 2023 13:31:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C8DD61839;
        Wed, 19 Jul 2023 20:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271EFC433C8;
        Wed, 19 Jul 2023 20:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689798618;
        bh=1vKuor530DqdUWvj3A6ZHk0xp319J5oxWV8iIp7ZRbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=axJJJjhoB1d/V6B78nfcClFeFzN+j9vXDmKWCJzen95hI+swQxVX+VdaG0a2O5c4s
         nlF0uxBUP4V1KrZgcZz4NCyx3WIVUugAkbvepB993BYq4HXagq141aYuXdZnDg4JhF
         +GEptC79VWgkDYJh+XZLfNQUbm7OeVL89Klo/SimsXdf9Cy8NyecwWphk6Q2EZOAti
         vhWwRIa9JNrSe23rEwvvQwXUUicOaHoim+QxujoLdBPxZIqWr3FXriRGAqjdTPci/U
         1cjsOq8gawDrT8WdQWEYfmyIIwRexQqgUHPIXXuSLRozVXmobJ4sFetz8w6YOSKtci
         HHQekA+dmgvDA==
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
        John Garry <john.g.garry@oracle.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 6/6] MAINTAINERS: Add git information for perf-tools and perf-tools-next trees/branches
Date:   Wed, 19 Jul 2023 17:29:51 -0300
Message-ID: <20230719202951.534582-7-acme@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719202951.534582-1-acme@kernel.org>
References: <20230719202951.534582-1-acme@kernel.org>
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

Now the perf tools development is done on these trees/branches:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git perf-tools
  git git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next

For a while I'll continue mirroring what is these to the same branches
in my git tree.

Suggested-by: John Garry <john.g.garry@oracle.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/CAP-5=fVGOP6-k=BTRd_bn=N0HVy+1ShpdW5rk5ND0ZGhm_fQkg@mail.gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aee340630ecaea38..e351cfc7cd41c570 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16629,6 +16629,8 @@ L:	linux-kernel@vger.kernel.org
 S:	Supported
 W:	https://perf.wiki.kernel.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git perf-tools
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
 F:	arch/*/events/*
 F:	arch/*/events/*/*
 F:	arch/*/include/asm/perf_event.h
-- 
2.41.0

