Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9155380751B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379327AbjLFQfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378300AbjLFQfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:35:33 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B66D4B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 08:35:37 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b422a274dso89155e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 08:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701880536; x=1702485336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwXChD+JHtHoNewTIq7HYYHZALw78wtpVyKJu1FT1Lk=;
        b=SdOs6O0osffINaMxi8LnooBm4HilVcu/sNKWgg0rPlSNpajM1yxb6tzdSyfit2oujM
         P4rzVyXLZ1LDUcMQC+DZeKpi+bXbVembUJeiGvAB3XS35j9INSUe7xWldDLkRiolXFI5
         ajCeVZ7R8IaQt5OJADd+ag0CGZuYXLw7DuFrD++9rfOjyX2+dkVWDNTRN2wXVpeREa8V
         nn9gMGrT/LYoAmHkd0GiLV64axFSh5rTfsE64Pwd6s7hIoa/A125fgd2b43cmCPBuGtT
         vIxP5vFsK6ahW2/m91/kxYCCIfybcB7yTdM0PJmd3GqNuRG50y3a5paHg1vTyNV59WBX
         +Utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701880536; x=1702485336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwXChD+JHtHoNewTIq7HYYHZALw78wtpVyKJu1FT1Lk=;
        b=gX8EURNSUKPYGkCthz68nMbGJ979KTDpQ2e+95jli5n8EkXNcogpMnWTadCvBR6baT
         hnNEOpGLK398cOeVFyqqakNhbvegiaiHyaqfA8JrUaFgkT612XYx1URGgnCetFZPGmLL
         aWuj6fROM/NJPx4AFflTAe3Bl6QF61qsZriHo2Ak4SuKsqgLOrpQ81QEIV0WcM4M/pkX
         QDPUnxDkC5OAFIctbWnlHLzu1X/NqNcY/2fUgxYy/mY0GsfZwgmQYF1zfys4N+b3pzs9
         RaZEkf+AGlcpSvPgc1QFFLh6inXu2I1DAu9MT5doJDVOOFpca4dWfqMaNgWVsXoMuZ5u
         qcPQ==
X-Gm-Message-State: AOJu0YwZB3/v2SYhyu24joY2itFbUNWetLpUTsjx9VM7nbGcKYRchC3P
        SY8JcnUq1iMAI3sINcQvBRHSMoL9XpyUh+x6aBVHUA==
X-Google-Smtp-Source: AGHT+IEasvFjjpDTNupV2KZHiyAZK/rOGxC1f33ZRbIA7wVMo6yktInLqOLX0shy4Qu6vYRpuxVZtqoJm9BwaRJf29k=
X-Received: by 2002:a05:600c:231a:b0:405:320a:44f9 with SMTP id
 26-20020a05600c231a00b00405320a44f9mr80482wmo.5.1701880535614; Wed, 06 Dec
 2023 08:35:35 -0800 (PST)
MIME-Version: 1.0
References: <20230614090710.680330-1-sandipan.das@amd.com> <1320e6e3-c029-2a8c-e8b7-2cfbb781518a@amd.com>
 <ZXByT1K6enTh2EHT@kernel.org>
In-Reply-To: <ZXByT1K6enTh2EHT@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 6 Dec 2023 08:35:23 -0800
Message-ID: <CAP-5=fUoD=s9yyVPgV7tqGwZsJVQMSmHKd8MV_vJW438AcK9qQ@mail.gmail.com>
Subject: Re: [PATCH] perf test: Retry without grouping for all metrics test
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ayush Jain <ayush.jain3@amd.com>,
        Sandipan Das <sandipan.das@amd.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, Ingo Molnar <mingo@kernel.org>,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, kjain@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, barnali@linux.ibm.com,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
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

On Wed, Dec 6, 2023 at 5:08=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Wed, Jun 14, 2023 at 05:08:21PM +0530, Ayush Jain escreveu:
> > On 6/14/2023 2:37 PM, Sandipan Das wrote:
> > > There are cases where a metric uses more events than the number of
> > > counters. E.g. AMD Zen, Zen 2 and Zen 3 processors have four data fab=
ric
> > > counters but the "nps1_die_to_dram" metric has eight events. By defau=
lt,
> > > the constituent events are placed in a group. Since the events cannot=
 be
> > > scheduled at the same time, the metric is not computed. The all metri=
cs
> > > test also fails because of this.
>
> Humm, I'm not being able to reproduce here the problem, before applying
> this patch:
>
> [root@five ~]# grep -m1 "model name" /proc/cpuinfo
> model name      : AMD Ryzen 9 5950X 16-Core Processor
> [root@five ~]# perf test -vvv "perf all metrics test"
> 104: perf all metrics test                                           :
> --- start ---
> test child forked, pid 1379713
> Testing branch_misprediction_ratio
> Testing all_remote_links_outbound
> Testing nps1_die_to_dram
> Testing macro_ops_dispatched
> Testing all_l2_cache_accesses
> Testing all_l2_cache_hits
> Testing all_l2_cache_misses
> Testing ic_fetch_miss_ratio
> Testing l2_cache_accesses_from_l2_hwpf
> Testing l2_cache_misses_from_l2_hwpf
> Testing op_cache_fetch_miss_ratio
> Testing l3_read_miss_latency
> Testing l1_itlb_misses
> test child finished with 0
> ---- end ----
> perf all metrics test: Ok
> [root@five ~]#

Please don't apply the patch. The patch masks a bug in metrics/PMUs
and the proper fix was:
8d40f74ebf21 perf vendor events amd: Fix large metrics
https://lore.kernel.org/r/20230706063440.54189-1-sandipan.das@amd.com

> [root@five ~]# perf stat -M nps1_die_to_dram -a sleep 2
>
>  Performance counter stats for 'system wide':
>
>                  0      dram_channel_data_controller_4   #  10885.3 MiB  =
nps1_die_to_dram       (49.96%)
>         31,334,338      dram_channel_data_controller_1                   =
                       (50.01%)
>                  0      dram_channel_data_controller_6                   =
                       (50.04%)
>         54,679,601      dram_channel_data_controller_3                   =
                       (50.04%)
>         38,420,402      dram_channel_data_controller_0                   =
                       (50.04%)
>                  0      dram_channel_data_controller_5                   =
                       (49.99%)
>         54,012,661      dram_channel_data_controller_2                   =
                       (49.96%)
>                  0      dram_channel_data_controller_7                   =
                       (49.96%)
>
>        2.001465439 seconds time elapsed
>
> [root@five ~]#
>
> [root@five ~]# perf stat -v -M nps1_die_to_dram -a sleep 2
> Using CPUID AuthenticAMD-25-21-0
> metric expr dram_channel_data_controller_0 + dram_channel_data_controller=
_1 + dram_channel_data_controller_2 + dram_channel_data_controller_3 + dram=
_channel_data_controller_4 + dram_channel_data_controller_5 + dram_channel_=
data_controller_6 + dram_channel_data_controller_7 for nps1_die_to_dram
> found event dram_channel_data_controller_4
> found event dram_channel_data_controller_1
> found event dram_channel_data_controller_6
> found event dram_channel_data_controller_3
> found event dram_channel_data_controller_0
> found event dram_channel_data_controller_5
> found event dram_channel_data_controller_2
> found event dram_channel_data_controller_7
> Parsing metric events 'dram_channel_data_controller_4/metric-id=3Ddram_ch=
annel_data_controller_4/,dram_channel_data_controller_1/metric-id=3Ddram_ch=
annel_data_controller_1/,dram_channel_data_controller_6/metric-id=3Ddram_ch=
annel_data_controller_6/,dram_channel_data_controller_3/metric-id=3Ddram_ch=
annel_data_controller_3/,dram_channel_data_controller_0/metric-id=3Ddram_ch=
annel_data_controller_0/,dram_channel_data_controller_5/metric-id=3Ddram_ch=
annel_data_controller_5/,dram_channel_data_controller_2/metric-id=3Ddram_ch=
annel_data_controller_2/,dram_channel_data_controller_7/metric-id=3Ddram_ch=
annel_data_controller_7/'
> dram_channel_data_controller_4 -> amd_df/metric-id=3Ddram_channel_data_co=
ntroller_4,dram_channel_data_controller_4/
> dram_channel_data_controller_1 -> amd_df/metric-id=3Ddram_channel_data_co=
ntroller_1,dram_channel_data_controller_1/
> Multiple errors dropping message: Cannot find PMU `dram_channel_data_cont=
roller_1'. Missing kernel support? (<no help>)
> dram_channel_data_controller_6 -> amd_df/metric-id=3Ddram_channel_data_co=
ntroller_6,dram_channel_data_controller_6/
> Multiple errors dropping message: Cannot find PMU `dram_channel_data_cont=
roller_6'. Missing kernel support? (<no help>)
> dram_channel_data_controller_3 -> amd_df/metric-id=3Ddram_channel_data_co=
ntroller_3,dram_channel_data_controller_3/
> Multiple errors dropping message: Cannot find PMU `dram_channel_data_cont=
roller_3'. Missing kernel support? (<no help>)
> dram_channel_data_controller_0 -> amd_df/metric-id=3Ddram_channel_data_co=
ntroller_0,dram_channel_data_controller_0/
> Multiple errors dropping message: Cannot find PMU `dram_channel_data_cont=
roller_0'. Missing kernel support? (<no help>)
> dram_channel_data_controller_5 -> amd_df/metric-id=3Ddram_channel_data_co=
ntroller_5,dram_channel_data_controller_5/
> Multiple errors dropping message: Cannot find PMU `dram_channel_data_cont=
roller_5'. Missing kernel support? (<no help>)
> dram_channel_data_controller_2 -> amd_df/metric-id=3Ddram_channel_data_co=
ntroller_2,dram_channel_data_controller_2/
> Multiple errors dropping message: Cannot find PMU `dram_channel_data_cont=
roller_2'. Missing kernel support? (<no help>)
> dram_channel_data_controller_7 -> amd_df/metric-id=3Ddram_channel_data_co=
ntroller_7,dram_channel_data_controller_7/
> Matched metric-id dram_channel_data_controller_4 to dram_channel_data_con=
troller_4
> Matched metric-id dram_channel_data_controller_1 to dram_channel_data_con=
troller_1
> Matched metric-id dram_channel_data_controller_6 to dram_channel_data_con=
troller_6
> Matched metric-id dram_channel_data_controller_3 to dram_channel_data_con=
troller_3
> Matched metric-id dram_channel_data_controller_0 to dram_channel_data_con=
troller_0
> Matched metric-id dram_channel_data_controller_5 to dram_channel_data_con=
troller_5
> Matched metric-id dram_channel_data_controller_2 to dram_channel_data_con=
troller_2
> Matched metric-id dram_channel_data_controller_7 to dram_channel_data_con=
troller_7
> Control descriptor is not initialized
> dram_channel_data_controller_4: 0 2001175127 999996394
> dram_channel_data_controller_1: 32346663 2001169897 1000709803
> dram_channel_data_controller_6: 0 2001168377 1001193443
> dram_channel_data_controller_3: 47551247 2001166947 1001198122
> dram_channel_data_controller_0: 38975242 2001165217 1001182923
> dram_channel_data_controller_5: 0 2001163067 1000464054
> dram_channel_data_controller_2: 49934162 2001160907 999974934
> dram_channel_data_controller_7: 0 2001150317 999968825
>
>  Performance counter stats for 'system wide':
>
>                  0      dram_channel_data_controller_4   #  10297.2 MiB  =
nps1_die_to_dram       (49.97%)
>         32,346,663      dram_channel_data_controller_1                   =
                       (50.01%)
>                  0      dram_channel_data_controller_6                   =
                       (50.03%)
>         47,551,247      dram_channel_data_controller_3                   =
                       (50.03%)
>         38,975,242      dram_channel_data_controller_0                   =
                       (50.03%)
>                  0      dram_channel_data_controller_5                   =
                       (49.99%)
>         49,934,162      dram_channel_data_controller_2                   =
                       (49.97%)
>                  0      dram_channel_data_controller_7                   =
                       (49.97%)
>
>        2.001196512 seconds time elapsed
>
> [root@five ~]#
>
> What am I missing?
>
> Ian, I also stumbled on this:
>
> [root@five ~]# perf stat -M dram_channel_data_controller_4
> Cannot find metric or group `dram_channel_data_controller_4'
> ^C
>  Performance counter stats for 'system wide':
>
>         284,908.91 msec cpu-clock                        #   32.002 CPUs =
utilized
>          6,485,456      context-switches                 #   22.763 K/sec
>                719      cpu-migrations                   #    2.524 /sec
>             32,800      page-faults                      #  115.125 /sec
>    189,779,273,552      cycles                           #    0.666 GHz  =
                       (83.33%)
>      2,893,165,259      stalled-cycles-frontend          #    1.52% front=
end cycles idle        (83.33%)
>     24,807,157,349      stalled-cycles-backend           #   13.07% backe=
nd cycles idle         (83.33%)
>     99,286,488,807      instructions                     #    0.52  insn =
per cycle
>                                                   #    0.25  stalled cycl=
es per insn     (83.33%)
>     24,120,737,678      branches                         #   84.661 M/sec=
                       (83.33%)
>      1,907,540,278      branch-misses                    #    7.91% of al=
l branches             (83.34%)
>
>        8.902784776 seconds time elapsed
>
>
> [root@five ~]#
> [root@five ~]# perf stat -e dram_channel_data_controller_4
> ^C
>  Performance counter stats for 'system wide':
>
>                  0      dram_channel_data_controller_4
>
>        1.189638741 seconds time elapsed
>
>
> [root@five ~]#
>
> I.e. -M should bail out at that point (Cannot find metric or group `dram_=
channel_data_controller_4'), no?

We could. I suspect the code has always just not bailed out. I'll put
together a patch adding the bail out.

Thanks,
Ian

> - Arnaldo
>
> > > Before announcing failure, the test can try multiple options for each
> > > available metric. After system-wide mode fails, retry once again with
> > > the "--metric-no-group" option.
> > >
> > > E.g.
> > >
> > >    $ sudo perf test -v 100
> > >
> > > Before:
> > >
> > >    100: perf all metrics test                                        =
   :
> > >    --- start ---
> > >    test child forked, pid 672731
> > >    Testing branch_misprediction_ratio
> > >    Testing all_remote_links_outbound
> > >    Testing nps1_die_to_dram
> > >    Metric 'nps1_die_to_dram' not printed in:
> > >    Error:
> > >    Invalid event (dram_channel_data_controller_4) in per-thread mode,=
 enable system wide with '-a'.
> > >    Testing macro_ops_dispatched
> > >    Testing all_l2_cache_accesses
> > >    Testing all_l2_cache_hits
> > >    Testing all_l2_cache_misses
> > >    Testing ic_fetch_miss_ratio
> > >    Testing l2_cache_accesses_from_l2_hwpf
> > >    Testing l2_cache_misses_from_l2_hwpf
> > >    Testing op_cache_fetch_miss_ratio
> > >    Testing l3_read_miss_latency
> > >    Testing l1_itlb_misses
> > >    test child finished with -1
> > >    ---- end ----
> > >    perf all metrics test: FAILED!
> > >
> > > After:
> > >
> > >    100: perf all metrics test                                        =
   :
> > >    --- start ---
> > >    test child forked, pid 672887
> > >    Testing branch_misprediction_ratio
> > >    Testing all_remote_links_outbound
> > >    Testing nps1_die_to_dram
> > >    Testing macro_ops_dispatched
> > >    Testing all_l2_cache_accesses
> > >    Testing all_l2_cache_hits
> > >    Testing all_l2_cache_misses
> > >    Testing ic_fetch_miss_ratio
> > >    Testing l2_cache_accesses_from_l2_hwpf
> > >    Testing l2_cache_misses_from_l2_hwpf
> > >    Testing op_cache_fetch_miss_ratio
> > >    Testing l3_read_miss_latency
> > >    Testing l1_itlb_misses
> > >    test child finished with 0
> > >    ---- end ----
> > >    perf all metrics test: Ok
> > >
> >
> > Issue gets resolved after applying this patch
> >
> >   $ ./perf test 102 -vvv
> >   $102: perf all metrics test                                          =
 :
> >   $--- start ---
> >   $test child forked, pid 244991
> >   $Testing branch_misprediction_ratio
> >   $Testing all_remote_links_outbound
> >   $Testing nps1_die_to_dram
> >   $Testing all_l2_cache_accesses
> >   $Testing all_l2_cache_hits
> >   $Testing all_l2_cache_misses
> >   $Testing ic_fetch_miss_ratio
> >   $Testing l2_cache_accesses_from_l2_hwpf
> >   $Testing l2_cache_misses_from_l2_hwpf
> >   $Testing l3_read_miss_latency
> >   $Testing l1_itlb_misses
> >   $test child finished with 0
> >   $---- end ----
> >   $perf all metrics test: Ok
> >
> > > Reported-by: Ayush Jain <ayush.jain3@amd.com>
> > > Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> >
> > Tested-by: Ayush Jain <ayush.jain3@amd.com>
> >
> > > ---
> > >   tools/perf/tests/shell/stat_all_metrics.sh | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > >
> > > diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/=
tests/shell/stat_all_metrics.sh
> > > index 54774525e18a..1e88ea8c5677 100755
> > > --- a/tools/perf/tests/shell/stat_all_metrics.sh
> > > +++ b/tools/perf/tests/shell/stat_all_metrics.sh
> > > @@ -16,6 +16,13 @@ for m in $(perf list --raw-dump metrics); do
> > >     then
> > >       continue
> > >     fi
> > > +  # Failed again, possibly there are not enough counters so retry sy=
stem wide
> > > +  # mode but without event grouping.
> > > +  result=3D$(perf stat -M "$m" --metric-no-group -a sleep 0.01 2>&1)
> > > +  if [[ "$result" =3D~ ${m:0:50} ]]
> > > +  then
> > > +    continue
> > > +  fi
> > >     # Failed again, possibly the workload was too small so retry with=
 something
> > >     # longer.
> > >     result=3D$(perf stat -M "$m" perf bench internals synthesize 2>&1=
)
> >
> > Thanks & Regards,
> > Ayush Jain
>
> --
>
> - Arnaldo
