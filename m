Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7067076738E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbjG1RhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjG1RhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:37:16 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B584223
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:36:52 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-407db3e9669so15161cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690565807; x=1691170607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MiqbSlCh4A2mRbWwF0zI0J8GGrBtWSoOpef1Mjqsfh4=;
        b=pYUZQ/F9GVmQGyqoYdTsX+D9YZN6NwIGsDTIETwQbNjV5huvfiAY8Pq67nPF5tVJfJ
         2M4Se4AN1zkO34pOAlXZ75av4zan7pFfSxmIncOE6rNpALf5IzYEBfr0tUq5oNNWs9cs
         q9CAoUcyg9dgE5uR/u+7A/Scx7vGweSOsizgArz2JN9QvVbHw8IwcFIzh29f4D3H5JcS
         LRAsmXRns6fjOSWVu5Gxx4LdGgDp2d211uX6cK/VLe0KBlXyH0LBWiIWR5W3YKNMPy8S
         Vnyd2hCm3pYXQHoHolR001syOUPZIoHOMk8TSJpQtsQBb2Tqwtn/tktEWVkf4bdLV5qs
         cfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690565807; x=1691170607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MiqbSlCh4A2mRbWwF0zI0J8GGrBtWSoOpef1Mjqsfh4=;
        b=Svpn4VFW1GUgulEFO3vYjXEqnzzHt2H1f6ooe4aR9iewymb2+13dfUrBHuAde0vaWT
         gNOX6oZspebxUw6YF2bjwlrWXgJKFpi+jH1nJD+HRbEqpEkQOkpeI3g4sKU7P5wDp35E
         O+VJNnOjYTvi6PETP8NGIgi95GArcF7MgeNttSUtz7uEybGKBVLfGqJpSXnBMneqT3sR
         eA/RWvVlYND+KY/fRkGPNq+UQ3RUrIL0uu9fx0HeCu+gjCV65ga2D4HfTWd3JHOhcPnQ
         sB2hB0r5h6s9PvT7X3ziPAc6O61bWlFW2gWuKAhMMl0cPz79tUe2MNt9NpERh3dG/els
         tVJg==
X-Gm-Message-State: ABy/qLYLLV9JqPjsOCQuzWSMhys0KOGhkFjRywz/4Xx+2rCLFTGtxCYB
        9xuo+yXTQmzZsfIvvcFXuh89o6KKMQ399Upjy/kKBw==
X-Google-Smtp-Source: APBJJlGU8OmELhr7YpQrzOL8HDorgVHUOukFdXrzdpJfthXqD1XAJrcQCyz6QuDg7DEdynM99rxwJh3HnDPBuZF+NtE=
X-Received: by 2002:ac8:5a92:0:b0:3f9:ab2c:88b9 with SMTP id
 c18-20020ac85a92000000b003f9ab2c88b9mr4923qtc.25.1690565807279; Fri, 28 Jul
 2023 10:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <202307271413.eb0fd426-oliver.sang@intel.com>
In-Reply-To: <202307271413.eb0fd426-oliver.sang@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 28 Jul 2023 10:36:30 -0700
Message-ID: <CAP-5=fUAcG+CzneUx0M0+3bxCvs6iTb=roaLp_qxi3j_KsUVpg@mail.gmail.com>
Subject: Re: [linus:master] [perf map/maps/thread] bffb5b0c09: perf-sanity-tests.probe_libc's_inet_pton_&_backtrace_it_with_ping.fail
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Brian Robbins <brianrob@linux.microsoft.com>,
        Changbin Du <changbin.du@huawei.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Fangrui Song <maskray@google.com>,
        German Gomez <german.gomez@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        James Clark <james.clark@arm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Wenyu Liu <liuwenyu7@huawei.com>,
        Will Deacon <will@kernel.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ye Xingchen <ye.xingchen@zte.com.cn>,
        Yuan Can <yuancan@huawei.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 11:43=E2=80=AFPM kernel test robot
<oliver.sang@intel.com> wrote:
>
>
> hi, Ian Rogers,
>
> we noticed this is a fix commit, and we really found some perf-sanity-tes=
ts
> can pass on this commit now.
> however, probe_libc's_inet_pton_&_backtrace_it_with_ping started to fail =
on this
> commit.
>
> 1981da1fe2499823 bffb5b0c0976aa46aaa961dd19a
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :6          100%           6:6     perf-sanity-tests.Check_bra=
nch_stack_sampling.pass
>            :6          100%           6:6     perf-sanity-tests.Cumulate_=
child_hist_entries.pass
>            :6          100%           6:6     perf-sanity-tests.dlfilter_=
C_API.pass
>            :6          100%           6:6     perf-sanity-tests.perf_pipe=
_recording_and_injection_test.pass
>            :6          100%           6:6     perf-sanity-tests.probe_lib=
c's_inet_pton_&_backtrace_it_with_ping.fail
>
> below is detail.
>
> Hello,
>
> kernel test robot noticed "perf-sanity-tests.probe_libc's_inet_pton_&_bac=
ktrace_it_with_ping.fail" on:
>
> commit: bffb5b0c0976aa46aaa961dd19a47c9d6301cfe1 ("perf map/maps/thread: =
Changes to reference counting")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> [test failed on linus/master 18b44bc5a67275641fb26f2c54ba7eef80ac5950]
> [test failed on linux-next/master 0ba5d07205771c50789fd9063950aa75e7f1183=
f]

Is this failing at head or is this another please use my time machine
and go fix the past request? The most recent fixes in this area were
in May by Thomas Richter:
https://lore.kernel.org/r/20230503081255.3372986-1-tmricht@linux.ibm.com
This isn't failing for me either in 6.5-rc3 or at perf-tools-next
head. The test output doesn't contain an indication of what the error
is. I don't think there is anything actionable here.

Thanks,
Ian

> in testcase: perf-sanity-tests
> version: perf-x86_64-00c7b5f4ddc5-1_20230402
> with following parameters:
>
>         perf_compiler: gcc
>
>
>
> compiler: gcc-12
> test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapp=
hire Rapids) with 256G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202307271413.eb0fd426-oliver.san=
g@intel.com
>
>
> ...
>  88: perf pipe recording and injection test                          : Ok
>  89: Add vfs_getname probe to get syscall args filenames             : Sk=
ip
>  90: probe libc's inet_pton & backtrace it with ping                 : FA=
ILED!   <---
>  91: Use vfs_getname probe to get syscall args filenames             : Sk=
ip
>  92: Zstd perf.data compression/decompression                        : Ok
> ...
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in=
 this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file =
for lkp run
>         sudo bin/lkp run generated-yaml-file
>
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
>
