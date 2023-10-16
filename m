Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE9B7CAE59
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjJPPzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbjJPPzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:55:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA0BB4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:55:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F301C433C8;
        Mon, 16 Oct 2023 15:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697471736;
        bh=sHaRlwbWssWeJYQh6HQwKzauVvxDIFF0zkURvlGW/8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J/Y7O9anXNZ6iq65xrYIz16QXcmlXdrngD+JzDIXRVvPvUcU4SmZel5cdMQRyR3iL
         Ww7JDzUhDXDYhRvYGHDFgPvMtqRpC/MOT1K84EBL7rYYQFAntWCDwtUxvoZTDNCe5B
         mXNPtPtqLpNG6rzM3rBryJphtWEAYoL4aiCGJ1YubMdfo7Ug1rvqguypj8E2c6ymIJ
         dsKKtcWMiurayU/XHKIdvHnJkCpXLQWk+CiDsCJhhldvPLb9zlOi3QcnJ/FEJvaI5P
         26WagFY0jgfUx177BzRQG9lojiAbILaHoTpL1f0Dw0x0snB+dKW8opuix1ucWKU7CD
         L32sE1hmVhRaQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EB66040016; Mon, 16 Oct 2023 12:55:33 -0300 (-03)
Date:   Mon, 16 Oct 2023 12:55:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3] perf bench sched pipe: Add -G/--cgroups option
Message-ID: <ZS1c9RCh9MkzPbFG@kernel.org>
References: <20231016044225.1125674-1-namhyung@kernel.org>
 <ZS0D53ckVx356k4o@gmail.com>
 <ZS1Y5PhXhp384ynY@kernel.org>
 <ZS1ajf/9HmgUyyCl@kernel.org>
 <ZS1cGMgyEDJQbwq9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS1cGMgyEDJQbwq9@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 16, 2023 at 12:51:52PM -0300, Arnaldo Carvalho de Melo escreveu:
> Now back at testing with with cgroups.


Humm, even without the -G I get:

[root@five ~]# perf stat -e context-switches,cgroup-switches perf bench sched pipe  -l 10000
# Running 'sched/pipe' benchmark:
# Executed 10000 pipe operations between two processes

     Total time: 0.082 [sec]

       8.246400 usecs/op
         121265 ops/sec

 Performance counter stats for 'perf bench sched pipe -l 10000':

            20,002      context-switches
            20,002      cgroup-switches

       0.091228041 seconds time elapsed

       0.007122000 seconds user
       0.087700000 seconds sys


[root@five ~]#

- Arnaldo
