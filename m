Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAF77662C7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 06:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjG1EIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 00:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjG1EIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 00:08:34 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792C430EA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 21:08:30 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-407db3e9669so53721cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 21:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690517309; x=1691122109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTPzb3rb/gmto9ara7xlmi33Mo+qRIpZpkA6OxihvQI=;
        b=2v+eCZWRkCo+GrbSIBgKeqXZ+INlQ7KZlqy8x1oUUUT9CmHWsmTn5ji26xvwHTwK/k
         LBfIFSM+E18RKKqRVCyAeq/R4Q3A+k57eCG4390hy28v4goVzd8AkcTjJvBD2LW3kq15
         Cqav8MYqa8CzocyXEwJGLCdtTTU7gg1n+fhrHmX4jWTD2K65t7ubvtAkI9Gydabw6VmK
         +GQORiAC36A9caQnBoOxl6H64EaX439vlffHYNg745zBYzoxN0Iz8+CqsZoXyuuWQC1E
         P/ByzynMAi8CqQocpXGfSd4W4FTFw+UT99e1w3EafB0Hv2cfkpPZZeIcnHRAJDt+Mj+3
         hGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690517309; x=1691122109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTPzb3rb/gmto9ara7xlmi33Mo+qRIpZpkA6OxihvQI=;
        b=YmQ1RaoMrWHYxgdss073SDQ9zCHiV/tH9EWceIUGqY12Mi2tb5VBZ1+Z1gvo6uXp1L
         5q3s6rSXmFqYnqqfNDaB1BsR8IY2okAZaE8HgqnxhNZg4kwq7gzFHY20m0aw+0fqqgZI
         ziyfJnhn9Q/I0z0OW3p0id9bVpCJKgw/WVwrleF/yS4WYlJzaBVHfaFKgCOIbJaLbj/e
         uZPBMbVUMdbS4FakWsy345s8yjH4X55SRHu8tift58tmXM1c80DIdHSb1dW6FffBV95Q
         nwHbSgQPO1Zr6A7tREsVi7cQbeZfLpjtaZSqBGfIbxySga7TZcWELgFcANwWSEgMxI95
         Oo4g==
X-Gm-Message-State: ABy/qLZ2yCY47Uf1rtczIIQQWrOrLTnBYtqDqQfT4mLEO3ezV6RptApu
        U2RrPaoR4d2JnEeUgfKL7MWSkT+9kaCMolqMVstIpg==
X-Google-Smtp-Source: APBJJlF/B8BCPcpCjkUOs2mffCGLpBCM9Xl7lBDh1eCwox9S7i16Z0rf9/jcT2gk1wOiKg+kcz0CxT0Pc/scfQTmiyA=
X-Received: by 2002:ac8:59c7:0:b0:3ef:404a:b291 with SMTP id
 f7-20020ac859c7000000b003ef404ab291mr97010qtf.7.1690517309321; Thu, 27 Jul
 2023 21:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <202307271322.40c2fc50-oliver.sang@intel.com>
In-Reply-To: <202307271322.40c2fc50-oliver.sang@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 27 Jul 2023 21:08:17 -0700
Message-ID: <CAP-5=fV3N1h84yMBN2mA2TpasCy2trX0_cvq6MxJSH3oMVMjGQ@mail.gmail.com>
Subject: Re: [linus:master] [perf pmu] a0c41caeba: kmsg.sanitizer.direct_leak/__interceptor_malloc/perf_cpu_map__alloc/perf_cpu_map__empty_new/cpu_map__from_range/cpu_map__new_data/perf_event__fprintf_event_update
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        James Clark <james.clark@arm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Leo Yan <leo.yan@linaro.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Ming Wang <wangming01@loongson.cn>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 6:07=E2=80=AFPM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "kmsg.sanitizer.direct_leak/__interceptor_mallo=
c/perf_cpu_map__alloc/perf_cpu_map__empty_new/cpu_map__from_range/cpu_map__=
new_data/perf_event__fprintf_event_update" on:
>
> commit: a0c41caebab2fa224454d50dd4e29ae008ead25f ("perf pmu: Add CPU map =
for "cpu" PMUs")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> [test failed on linus/master 18b44bc5a67275641fb26f2c54ba7eef80ac5950]
> [test failed on linux-next/master 0ba5d07205771c50789fd9063950aa75e7f1183=
f]
>
> in testcase: perf-test
> version: perf-test-x86_64-git-1_20220520
> with following parameters:
>
>         type: lkp
>         group: group-01
>
> test-description: The internal Perf Test suite.
>
>
> compiler: gcc-12
> test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapp=
hire Rapids) with 256G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> we also noticed there are 2 other "Direct leak" but exist on both this co=
mmit
> and parent. (there are 3 "Indrect leak", but since exist on both this com=
mit
> and parent, we don't highlight below, details are in attached dmesg)
>
> we are not sure enough the impact of those 2 other "Direct leak", which w=
e will
> check further if we can capture the first commit caused them. we just rep=
ort
> this difference we found in our tests FYI.
>
>
> 1578e63d3ac292ab a0c41caebab2fa224454d50dd4e
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>           6:6            0%           6:6     kmsg.sanitizer.direct_leak/=
__interceptor_calloc/map__new2/machine__addnew_module_map/machine__process_=
kernel_mmap_event/machine__process_mmap_event/perf_event__process_mmap
>           6:6            0%           6:6     kmsg.sanitizer.direct_leak/=
__interceptor_malloc/__maps__insert/maps__insert/thread__insert_map/machine=
__process_mmap2_event/perf_event__process_mmap2
>            :6          100%           6:6     kmsg.sanitizer.direct_leak/=
__interceptor_malloc/perf_cpu_map__alloc/perf_cpu_map__empty_new/cpu_map__f=
rom_range/cpu_map__new_data/perf_event__fprintf_event_update
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202307271322.40c2fc50-oliver.san=
g@intel.com
>
>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D16107=3D=3DERROR: LeakSanitizer: detected memory leaks
>
> Direct leak of 17544 byte(s) in 51 object(s) allocated from:     <----- a=
lso happens on parent
>     #0 0x7f77a26ad037 in __interceptor_calloc ../../../../src/libsanitize=
r/asan/asan_malloc_linux.cpp:154
>     #1 0x55eae21bcf4a in map__new2 util/map.c:226
>     #2 0x55eae21a1b8b in machine__addnew_module_map util/machine.c:1039
>     #3 0x55eae21a80d9 in machine__process_kernel_mmap_event util/machine.=
c:1809
>     #4 0x55eae21aa396 in machine__process_mmap_event util/machine.c:1996
>     #5 0x55eae2069f1c in perf_event__process_mmap util/event.c:371
>     #6 0x55eae21daa15 in machines__deliver_event util/session.c:1565
>     #7 0x55eae21dc2f5 in perf_session__deliver_event util/session.c:1645
>     #8 0x55eae21df380 in perf_session__process_event util/session.c:1881
>     #9 0x55eae21e622c in process_simple util/session.c:2442
>     #10 0x55eae21e527c in reader__read_event util/session.c:2371
>     #11 0x55eae21e5bbc in reader__process_events util/session.c:2420
>     #12 0x55eae21e69e5 in __perf_session__process_events util/session.c:2=
467
>     #13 0x55eae21e991d in perf_session__process_events util/session.c:263=
3
>     #14 0x55eae1d248dc in __cmd_report /usr/src/perf_selftests-x86_64-rhe=
l-8.3-bpf-a0c41caebab2fa224454d50dd4e29ae008ead25f/tools/perf/builtin-repor=
t.c:989
>     #15 0x55eae1d30f76 in cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-bpf-a0c41caebab2fa224454d50dd4e29ae008ead25f/tools/perf/builtin-report.=
c:1709
>     #16 0x55eae200824f in run_builtin /usr/src/perf_selftests-x86_64-rhel=
-8.3-bpf-a0c41caebab2fa224454d50dd4e29ae008ead25f/tools/perf/perf.c:323
>     #17 0x55eae2008ad1 in handle_internal_command /usr/src/perf_selftests=
-x86_64-rhel-8.3-bpf-a0c41caebab2fa224454d50dd4e29ae008ead25f/tools/perf/pe=
rf.c:377
>     #18 0x55eae2009003 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.=
3-bpf-a0c41caebab2fa224454d50dd4e29ae008ead25f/tools/perf/perf.c:421
>     #19 0x55eae200972f in main /usr/src/perf_selftests-x86_64-rhel-8.3-bp=
f-a0c41caebab2fa224454d50dd4e29ae008ead25f/tools/perf/perf.c:537
>     #20 0x7f77a1854d09 in __libc_start_main (/lib/x86_64-linux-gnu/libc.s=
o.6+0x23d09)

This was already fixed by:
https://lore.kernel.org/r/20230608232823.4027869-20-irogers@google.com

Thanks,
Ian

> Direct leak of 904 byte(s) in 1 object(s) allocated from:
>     #0 0x7f77a26ace8f in __interceptor_malloc ../../../../src/libsanitize=
r/asan/asan_malloc_linux.cpp:145
>     #1 0x55eae2648cdd in perf_cpu_map__alloc (/usr/src/perf_selftests-x86=
_64-rhel-8.3-bpf-a0c41caebab2fa224454d50dd4e29ae008ead25f/tools/perf/perf+0=
x19a5cdd)
>     #2 0x55eae22f7525 in perf_cpu_map__empty_new util/cpumap.c:163
>     #3 0x55eae22f6dae in cpu_map__from_range util/cpumap.c:121
>     #4 0x55eae22f7278 in cpu_map__new_data util/cpumap.c:144
>     #5 0x55eae2179b4c in perf_event__fprintf_event_update util/header.c:4=
348
>     #6 0x55eae217a084 in perf_event__process_event_update util/header.c:4=
410
>     #7 0x55eae21dcbb1 in perf_session__process_user_event util/session.c:=
1679
>     #8 0x55eae21df1b7 in perf_session__process_event util/session.c:1867
>     #9 0x55eae21e622c in process_simple util/session.c:2442
>     #10 0x55eae21e527c in reader__read_event util/session.c:2371
>     #11 0x55eae21e5bbc in reader__process_events util/session.c:2420
>     #12 0x55eae21e69e5 in __perf_session__process_events util/session.c:2=
467
>     #13 0x55eae21e991d in perf_session__process_events util/session.c:263=
3
>     #14 0x55eae1d248dc in __cmd_report /usr/src/perf_selftests-x86_64-rhe=
l-8.3-bpf-a0c41caebab2fa224454d50dd4e29ae008ead25f/tools/perf/builtin-repor=
t.c:989
>     #15 0x55eae1d30f76 in cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-bpf-a0c41caebab2fa224454d50dd4e29ae008ead25f/tools/perf/builtin-report.=
c:1709
>     #16 0x55eae200824f in run_builtin /usr/src/perf_selftests-x86_64-rhel=
-8.3-bpf-a0c41caebab2fa224454d50dd4e29ae008ead25f/tools/perf/perf.c:323
>     #17 0x55eae2008ad1 in handle_internal_command /usr/src/perf_selftests=
-x86_64-rhel-8.3-bpf-a0c41caebab2fa224454d50dd4e29ae008ead25f/tools/perf/pe=
rf.c:377
>     #18 0x55eae2009003 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.=
3-bpf-a0c41caebab2fa224454d50dd4e29ae008ead25f/tools/perf/perf.c:421
>     #19 0x55eae200972f in main /usr/src/perf_selftests-x86_64-rhel-8.3-bp=
f-a0c41caebab2fa224454d50dd4e29ae008ead25f/tools/perf/perf.c:537
>     #20 0x7f77a1854d09 in __libc_start_main (/lib/x86_64-linux-gnu/libc.s=
o.6+0x23d09)
>
> Direct leak of 64 byte(s) in 2 object(s) allocated from:     <----- also =
happens on parent
>     #0 0x7f77a26ace8f in __interceptor_malloc ../../../../src/libsanitize=
r/asan/asan_malloc_linux.cpp:145
>     #1 0x55eae21c15b1 in __maps__insert util/maps.c:43
>     #2 0x55eae21c1a2a in maps__insert util/maps.c:70
>     #3 0x55eae22038ba in thread__insert_map util/thread.c:355
>     #4 0x55eae21a9bed in machine__process_mmap2_event util/machine.c:1959
>     #5 0x55eae2069f70 in perf_event__process_mmap2 util/event.c:379
>     #6 0x55eae21dac1e in machines__deliver_event util/session.c:1569
>     #7 0x55eae21dc2f5 in perf_session__deliver_event util/session.c:1645
>     #8 0x55eae21c7f35 in ordered_events__deliver_event util/session.c:188
>     #9 0x55eae21f7824 in do_flush util/ordered-events.c:245
>     #10 0x55eae21f863f in __ordered_events__flush util/ordered-events.c:3=
24
>     #11 0x55eae21f8b1a in ordered_events__flush util/ordered-events.c:342
>     #12 0x55eae21e6a08 in __perf_session__process_events util/session.c:2=
471
>     #13 0x55eae21e991d in perf_session__process_events util/session.c:263=
3
>     #14 0x55eae1d248dc in __cmd_report /usr/src/perf_selftests-x86_64-rhe=
l-8.3-bpf-a0c41caebab2fa224454d50dd4e29ae008ead25f/tools/perf/builtin-repor=
t.c:989
>     #15 0x55eae1d30f76 in cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-bpf-a0c41caebab2fa224454d50dd4e29ae008ead25f/tools/perf/builtin-report.=
c:1709
>     #16 0x55eae200824f in run_builtin /usr/src/perf_selftests-x86_64-rhel=
-8.3-bpf-a0c41caebab2fa224454d50dd4e29ae008ead25f/tools/perf/perf.c:323
>     #17 0x55eae2008ad1 in handle_internal_command /usr/src/perf_selftests=
-x86_64-rhel-8.3-bpf-a0c41caebab2fa224454d50dd4e29ae008ead25f/tools/perf/pe=
rf.c:377
>     #18 0x55eae2009003 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.=
3-bpf-a0c41caebab2fa224454d50dd4e29ae008ead25f/tools/perf/perf.c:421
>     #19 0x55eae200972f in main /usr/src/perf_selftests-x86_64-rhel-8.3-bp=
f-a0c41caebab2fa224454d50dd4e29ae008ead25f/tools/perf/perf.c:537
>     #20 0x7f77a1854d09 in __libc_start_main (/lib/x86_64-linux-gnu/libc.s=
o.6+0x23d09)
>
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
