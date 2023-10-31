Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8F47DCCB5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344180AbjJaMFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbjJaMFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:05:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E48565595;
        Tue, 31 Oct 2023 05:05:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4403CC15;
        Tue, 31 Oct 2023 05:06:18 -0700 (PDT)
Received: from dsg-hive-n1sdp-01.. (dsg-hive-n1sdp-01.cambridge.arm.com [10.2.2.18])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1964D3F738;
        Tue, 31 Oct 2023 05:05:34 -0700 (PDT)
From:   Nick Forrington <nick.forrington@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Nick Forrington <nick.forrington@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 0/2] Perf lock improvements
Date:   Tue, 31 Oct 2023 12:05:23 +0000
Message-ID: <20231031120526.11502-1-nick.forrington@arm.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf lock improvements, to re-introduce aggregation by caller to perf
lock report, and improve command line handling for perf lock info.

These changes are technically independent, but submitted together to
ensure they apply cleanly.

Nick Forrington (2):
  perf lock report: Restore aggregation by caller by default
  perf lock info: Enforce exactly one of --map and --thread

 tools/perf/Documentation/perf-lock.txt |  4 +++
 tools/perf/builtin-lock.c              | 49 ++++++++++++++++++++++++--
 2 files changed, 50 insertions(+), 3 deletions(-)

-- 
2.42.0

