Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFAD7D8B69
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 00:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344860AbjJZWJK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 26 Oct 2023 18:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjJZWJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 18:09:08 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD81E91;
        Thu, 26 Oct 2023 15:09:06 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-27d18475ed4so1241224a91.0;
        Thu, 26 Oct 2023 15:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698358146; x=1698962946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aVUcrbGUMw0ppD1wYsBtYUJw806ZaiQ+vq+hatkWY30=;
        b=j2Hw3NrQhTVzD2LQ52cNRHCHI08u8dN1XGY1eOjAKZga2Ew5hkkP3pSkzKXVV9g9EN
         cjNjY6KBcNl7rL+lYI4/zjzO0y1v26X5tpa1wXQ0a0ptSi/ITXRcu6rPPewAC9RQIdf0
         +r+hhnWcPKHoXu5cqJ5UFUOLeQ6/TDVb10j9Ch0RMPBBFglvIqM162xGuK8O6An5uePz
         Tg02R7koXtgzeA4ZzUBDfRhJVNfiUEeFIYnLwrA5/q8nPQrSaVMRo7NNKFs0CQWxEHhB
         GP4W63vnoCJcvKz/lcIc8hMZTBO+/JguWlO4+wAkGgxy5EnIgBcKov0taBQvUf50DdgM
         Z6EA==
X-Gm-Message-State: AOJu0YzjeM3A+6NNtuAxCvvV9wLX6ePZHKKqF3mowv3sI6+8u/Lwusfz
        MVpGtc5JotVe/AA25vVccHWtzO3xg5tJK4TRnDI=
X-Google-Smtp-Source: AGHT+IF1Eztk9O6B5GNlWTQCMsNv4J4w3eJLPrhsWk5fPODMQq7Q3d0B288OOj70RxtmdbuVBRUPWhr0Blr4OYJcSXk=
X-Received: by 2002:a17:90b:111:b0:27d:c95:b0ad with SMTP id
 p17-20020a17090b011100b0027d0c95b0admr857862pjz.21.1698358146005; Thu, 26 Oct
 2023 15:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231023033144.1011896-1-yangjihong1@huawei.com> <ZTrCS5Z3PZAmfPdV@kernel.org>
In-Reply-To: <ZTrCS5Z3PZAmfPdV@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 26 Oct 2023 15:08:54 -0700
Message-ID: <CAM9d7cjhSSV+18ZCHLdTFpMM+MmpoDkYSGjUa5JKZp02Kx9XRw@mail.gmail.com>
Subject: Re: [PATCH] perf evsel: Rename evsel__increase_rlimit to rlimit__increase_nofile
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Thu, Oct 26, 2023 at 12:47 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Oct 23, 2023 at 03:31:44AM +0000, Yang Jihong escreveu:
> > evsel__increase_rlimit() helper does nothing with evsel, and description
> > of the functionality is inaccurate, rename it and move to util/rlimit.c.
>
> > By the way, fix a checkppatch warning about misplaced license tag:
>
> >   WARNING: Misplaced SPDX-License-Identifier tag - use line 1 instead
> >   #160: FILE: tools/perf/util/rlimit.h:3:
> >   /* SPDX-License-Identifier: LGPL-2.1 */
>
> > No functional change.
>
> Please run 'perf test' before sending patches upstream, I'm checking if
> what is in perf-tools-next/perf-tools-next is building and I noticed
> this:
>
> ⬢[acme@toolbox perf-tools-next]$ perf test -v python
> Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
>  14: 'import perf' in python                                         :
> --- start ---
> test child forked, pid 2912462
> python usage test: "echo "import sys ; sys.path.insert(0, '/tmp/build/perf-tools-next/python'); import perf" | '/usr/bin/python3' "
> Traceback (most recent call last):
>   File "<stdin>", line 1, in <module>
> ImportError: /tmp/build/perf-tools-next/python/perf.cpython-311-x86_64-linux-gnu.so: undefined symbol: rlimit__increase_nofile
> test child finished with -1
> ---- end ----
> 'import perf' in python: FAILED!
> ⬢[acme@toolbox perf-tools-next]$
>
> The following patch cures it, Namhyung, can you please fold it and force
> push perf-tools-next/perf-tools-next or let me know if you prefer that I
> submit a patch fixing this separately.

Thanks for fixing this.  I prefer having a separate fix.
Please send it as a formal patch.

Thanks,
Namhyung


>
> - Arnaldo
>
> diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
> index 26e1c8d973ea0b95..593b660ec75e24e1 100644
> --- a/tools/perf/util/python-ext-sources
> +++ b/tools/perf/util/python-ext-sources
> @@ -40,6 +40,7 @@ util/rwsem.c
>  util/hashmap.c
>  util/perf_regs.c
>  util/fncache.c
> +util/rlimit.c
>  util/perf-regs-arch/perf_regs_aarch64.c
>  util/perf-regs-arch/perf_regs_arm.c
>  util/perf-regs-arch/perf_regs_csky.c
