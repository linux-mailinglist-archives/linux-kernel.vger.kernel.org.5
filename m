Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC41676F86B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 05:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjHDDlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 23:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjHDDl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 23:41:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9752C449D;
        Thu,  3 Aug 2023 20:41:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 344D761EFC;
        Fri,  4 Aug 2023 03:41:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4045C433C8;
        Fri,  4 Aug 2023 03:41:25 +0000 (UTC)
Date:   Thu, 3 Aug 2023 23:41:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ze Gao <zegao2021@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: Re: [RFC PATCH v6 1/5] perf sched: sync state char array with the
 kernel
Message-ID: <20230803234122.19b3d3a4@rorschach.local.home>
In-Reply-To: <CAD8CoPAFN7Wor+LZVqTwy5krJ15tav6gSKRzGiaegF--Xak3HQ@mail.gmail.com>
References: <20230803083352.1585-1-zegao@tencent.com>
        <20230803083352.1585-2-zegao@tencent.com>
        <20230803111031.056b3446@gandalf.local.home>
        <CAD8CoPBy4Q1khVyhROMMnS=cfbSZuL0GCuSxMcKLRuTb2qtMjQ@mail.gmail.com>
        <CAD8CoPA+rWQfEbuPdmRqk3+6Bpocm5oP2d-cku=Kz_-DSfUVjg@mail.gmail.com>
        <CAD8CoPAFN7Wor+LZVqTwy5krJ15tav6gSKRzGiaegF--Xak3HQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2023 11:19:06 +0800
Ze Gao <zegao2021@gmail.com> wrote:

> I realize this is not perfect as well after second thoughts, since this does not
> take offline use of perf into consideration.  People might run perf on different
> machines than where the perf.data gets recorded, in which way what we get
> from  /sys/kernel/debug/tracing/events/sched/sched_switch/format is likely
> different from the perf.data.

If perf data files does what trace.dat files do, it should save the
file formats in the data files. It should not be reading the kernel
when reading the data file.

With trace-cmd, you can do: trace-cmd dump --events

And it will show you all the formats of the events that it saved in the
file.

-- Steve
