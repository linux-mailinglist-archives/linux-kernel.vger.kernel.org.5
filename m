Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B94876DE57
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 04:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbjHCCiX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Aug 2023 22:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbjHCCiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 22:38:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E794EB2;
        Wed,  2 Aug 2023 19:37:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F5B661BBB;
        Thu,  3 Aug 2023 02:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFFBC433C8;
        Thu,  3 Aug 2023 02:37:20 +0000 (UTC)
Date:   Wed, 2 Aug 2023 22:37:18 -0400
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
        linux-trace-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: Re: [RFC PATCH v4 1/7] libtraceevent: sync state char array with
 the kernel
Message-ID: <20230802223718.6e34d3ff@gandalf.local.home>
In-Reply-To: <CAD8CoPAPjuE5Ni2aTJcS5=M8TNOLqp3t4gfL=iWVrx39a25r2Q@mail.gmail.com>
References: <20230802121116.324604-1-zegao@tencent.com>
        <20230802121116.324604-2-zegao@tencent.com>
        <20230802103630.45d95c06@gandalf.local.home>
        <CAD8CoPAPjuE5Ni2aTJcS5=M8TNOLqp3t4gfL=iWVrx39a25r2Q@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2023 10:13:16 +0800
Ze Gao <zegao2021@gmail.com> wrote:

> FYI, I‘ve already cc-ed to it.  Do you mean I need to resend this patch
> to linux-trace-devel@vger.kernel.org solely and exclude this one from
> this series?
> 

I searched the Cc list and missed it. Anyway, you only need to Cc the
patches that touch libtracevent, and not the rest. No biggy, I just have to
mark them as "Handled elsewhere" in patchwork.

-- Steve
