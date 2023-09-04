Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F453791A14
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352079AbjIDOyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjIDOyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:54:23 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DFBCCB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 07:54:18 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-414c54b2551so211991cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 07:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693839258; x=1694444058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9hfWfWY22r/nAQN4Fk2G0eS7ww0D8iDK5bgmn+N/bU=;
        b=rWt+rEgC2w4kt+7SdCipjUDeFLpLtyTFeEoYZ7ne6DKykuca2bbnA1KaN+AqbtBfSu
         gspESAGyDSSMTdlnLV7f7yxv8VZ+DDQLOcOJ7p2RD/R2fERGnlxlSX+Hq7N+rcqg/8S9
         NdXU6eNkNYK5CRSMMkGWVR6WwuHPbfMxvSob6D4SNj6K7xug5pkWGLK+ahXamQd71Bnb
         1qh8ndu/Lpx+IB6MH17sZutHezmZ5yxDkC4D1txnXTFR3rWFNXAYFrZqt/IsFW5jEkTL
         qymkxe88HAVeXryyah3DzBIQxoaNytQKggN70YqlyQVSHZxd3jr0fxV/7Es6NhP0kvky
         FQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693839258; x=1694444058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9hfWfWY22r/nAQN4Fk2G0eS7ww0D8iDK5bgmn+N/bU=;
        b=Od1iHFHRSKvVan3ZFAgxpqAw+HoCd7h7pw9ZI/OLd4LAvGmCHcgcrjy6OsahNQLV+p
         ZrwLHmhoVN+vKA3bG4fAhyikXytNU7StQbAOM5N0mFOamaVCGCq11IKQwe4AJnNNx7sK
         EStowm1CvNNg5zm4cEmJpoVjKIN2UrZWNKw/7o7LBZpky9C0xlc+AvnwPLe1sTNPDu33
         LJnVjGf2E/BUJNvDkjwXXXFAbQLPOtJArR10igexFQ2DT/0JK5Ek7DRHpT87SIDHG6ns
         GmxgU1tz9cbjMrfOq04+gBxKxK49kkpdDmJjiXIVPlAU6eamTzwAiACzlyTBLigAX7xU
         3HEA==
X-Gm-Message-State: AOJu0YzEaZ9bcfeXQjkQ9ElSO010MnqMDwd2yGxY1a7PmUBq5bCaspIU
        u0TAXK8GV7O3cRGIELNiC1a5ebhopw2opf9D1eSvsA==
X-Google-Smtp-Source: AGHT+IHlilG1ZOHhzUqmSGKqiusLBAl2QErUcciTBiukxokv+Jqy6ZzicHxwmn9Fd0mEcrYdriNE6Sv0Ge0GOuaZvb0=
X-Received: by 2002:a05:622a:1a08:b0:410:a4cb:9045 with SMTP id
 f8-20020a05622a1a0800b00410a4cb9045mr296128qtb.18.1693839257823; Mon, 04 Sep
 2023 07:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230812084917.169338-1-yangjihong1@huawei.com>
 <CAP-5=fXYBD2LYo9Fx8Uky+RKx+qfPypo7nkqA1YnYMS3iVwryw@mail.gmail.com> <61f78bea-0846-1e7a-b64e-470a3f59285a@huawei.com>
In-Reply-To: <61f78bea-0846-1e7a-b64e-470a3f59285a@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 4 Sep 2023 07:54:05 -0700
Message-ID: <CAP-5=fVTM3xV9feaZv4z53Pv-AM9Ldj7SC8rZcNsMwJcj2ZViQ@mail.gmail.com>
Subject: Re: [RFC v1 00/16] perf kwork: Implement perf kwork top
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, sandipan.das@amd.com,
        ravi.bangoria@amd.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 4, 2023 at 4:59=E2=80=AFAM Yang Jihong <yangjihong1@huawei.com>=
 wrote:
>
> Hello,
>
> On 2023/9/4 13:13, Ian Rogers wrote:
> > On Sat, Aug 12, 2023 at 1:52=E2=80=AFAM Yang Jihong <yangjihong1@huawei=
.com> wrote:
> >>
> >> Some common tools for collecting statistics on CPU usage, such as top,
> >> obtain statistics from timer interrupt sampling, and then periodically
> >> read statistics from /proc/stat.
> >>
> >> This method has some deviations:
> >> 1. In the tick interrupt, the time between the last tick and the curre=
nt
> >>     tick is counted in the current task. However, the task may be runn=
ing
> >>     only part of the time.
> >> 2. For each task, the top tool periodically reads the /proc/{PID}/stat=
us
> >>     information. For tasks with a short life cycle, it may be missed.
> >>
> >> In conclusion, the top tool cannot accurately collect statistics on th=
e
> >> CPU usage and running time of tasks.
> >>
> >> The statistical method based on sched_switch tracepoint can accurately
> >> calculate the CPU usage of all tasks. This method is applicable to
> >> scenarios where performance comparison data is of high precision.
> >>
> >> In addition to parsing the perf.data file, the provides BPF-based CPU =
usage
> >> statistics to reduce the load of the perf process.
> >>
> >> Example usage:
> >>
> >>    # perf kwork top -h
> >>
> >>     Usage: perf kwork top [<options>]
> >>
> >>        -C, --cpu <cpu>       list of cpus to profile
> >>        -i, --input <file>    input file name
> >>        -n, --name <name>     event name to profile
> >>        -s, --sort <key[,key2...]>
> >>                              sort by key(s): rate, runtime, tid
> >>            --time <str>      Time span for analysis (start,stop)
> >>
> >>    # ./perf kwork -k sched,irq,softirq record -- ./perf bench sched me=
ssaging -g 1 -l 10000
> >>    # Running 'sched/messaging' benchmark:
> >>    # 20 sender and receiver processes per group
> >>    # 1 groups =3D=3D 40 processes run
> >>
> >>         Total time: 1.854 [sec]
> >>    [ perf record: Woken up 13 times to write data ]
> >>    [ perf record: Captured and wrote 27.436 MB perf.data (235986 sampl=
es) ]
> >>    #
> >>    # perf kwork top
> >>
> >>    Total  :  22419.068 ms, 12 cpus
> >>    %Cpu(s):  17.99% id,   0.00% hi,   0.09% si
> >>    %Cpu0   [||||||||||||||||||||||||        82.56%]
> >>    %Cpu1   [||||||||||||||||||||||||        81.73%]
> >>    %Cpu2   [||||||||||||||||||||||||        83.00%]
> >>    %Cpu3   [||||||||||||||||||||||||        81.01%]
> >>    %Cpu4   [||||||||||||||||||||||||        81.66%]
> >>    %Cpu5   [||||||||||||||||||||||||        82.10%]
> >>    %Cpu6   [||||||||||||||||||||||||        81.65%]
> >>    %Cpu7   [||||||||||||||||||||||||        82.00%]
> >>    %Cpu8   [||||||||||||||||||||||||        82.54%]
> >>    %Cpu9   [||||||||||||||||||||||||        81.02%]
> >>    %Cpu10  [||||||||||||||||||||||||        81.78%]
> >>    %Cpu11  [||||||||||||||||||||||||        81.87%]
> >>
> >>          PID    %CPU           RUNTIME  COMMMAND
> >>      ----------------------------------------------------
> >>      2913025   27.62        516.976 ms  sched-messaging
> >>      2913017   27.56        516.273 ms  sched-messaging
> >>      2913018   27.56        516.152 ms  sched-messaging
> >>      2913008   27.54        515.447 ms  sched-messaging
> >>      2913010   27.50        514.890 ms  sched-messaging
> >>      2913007   27.48        514.411 ms  sched-messaging
> >>      2913015   27.36        512.563 ms  sched-messaging
> >>      2913026   27.35        512.198 ms  sched-messaging
> >>      2913011   27.32        511.632 ms  sched-messaging
> >>      2913014   27.32        511.381 ms  sched-messaging
> >>      2913012   27.30        511.138 ms  sched-messaging
> >>      2913013   27.30        511.109 ms  sched-messaging
> >>      2913009   27.30        510.997 ms  sched-messaging
> >>      2913019   27.25        510.488 ms  sched-messaging
> >>      2913021   27.23        509.661 ms  sched-messaging
> >>      2913023   27.21        509.400 ms  sched-messaging
> >>      2913020   27.20        509.677 ms  sched-messaging
> >>      2913022   27.19        509.061 ms  sched-messaging
> >>      2913016   27.18        509.231 ms  sched-messaging
> >>      2913024   27.18        509.108 ms  sched-messaging
> >>      2912999   21.79        407.929 ms  sched-messaging
> >>      2913000   21.78        408.045 ms  sched-messaging
> >>      2912998   21.75        407.579 ms  sched-messaging
> >>      2912993   21.69        406.166 ms  sched-messaging
> >>      2912991   21.59        404.378 ms  sched-messaging
> >>      2912992   21.57        403.845 ms  sched-messaging
> >>      2913005   21.56        403.715 ms  sched-messaging
> >>      2913001   21.55        403.803 ms  sched-messaging
> >>      2912990   21.54        403.601 ms  sched-messaging
> >>      2912994   21.52        403.087 ms  sched-messaging
> >>      2912995   21.49        402.421 ms  sched-messaging
> >>      2912996   21.48        402.666 ms  sched-messaging
> >>      2912989   21.46        402.303 ms  sched-messaging
> >>      2913003   21.46        402.034 ms  sched-messaging
> >>      2912988   21.44        401.820 ms  sched-messaging
> >>      2913004   21.37        400.242 ms  sched-messaging
> >>      2912987   21.28        398.512 ms  sched-messaging
> >>      2913002   21.27        398.759 ms  sched-messaging
> >>      2912997   21.27        398.518 ms  sched-messaging
> >>      2913006   21.23        397.888 ms  sched-messaging
> >>            0   18.89        353.061 ms  swapper/3
> >>            0   18.89        353.026 ms  swapper/9
> >>            0   18.26        341.190 ms  swapper/6
> >>            0   18.25        341.048 ms  swapper/4
> >>            0   18.13        338.844 ms  swapper/10
> >>            0   18.12        338.686 ms  swapper/1
> >>            0   18.05        337.333 ms  swapper/11
> >>            0   17.92        334.903 ms  swapper/7
> >>            0   17.80        332.691 ms  swapper/5
> >>            0   17.38        324.762 ms  swapper/8
> >>            0   17.29        323.102 ms  swapper/0
> >>            0   16.89        315.630 ms  swapper/2
> >>      2912984    2.10         39.452 ms  perf
> >>      2912985    0.73         14.004 ms  sched-messaging
> >>       660381    0.14          3.527 ms  containerd
> >>      3006112    0.07          1.402 ms  redis-server
> >>      2904655    0.05          1.071 ms  kworker/0:0
> >>       659822    0.03          1.729 ms  containerd
> >>       659824    0.03          1.346 ms  containerd
> >>         1053    0.01          0.353 ms  zabbix_agentd
> >>      2895571    0.01          0.349 ms  kworker/8:1
> >>           10    0.00          0.535 ms  rcu_sched
> >>      2912192    0.00          0.272 ms  kworker/u24:2
> >>      2903540    0.00          0.182 ms  sshd
> >>          801    0.00          0.120 ms  jbd2/sda4-8
> >>      2929605    0.00          0.108 ms  grpc_global_tim
> >>      2912986    0.00          0.075 ms  perf
> >>      2897765    0.00          0.073 ms  kworker/7:1
> >>      2912817    0.00          0.070 ms  kworker/2:1
> >>       391756    0.00          0.067 ms  grpc_global_tim
> >>      2901459    0.00          0.056 ms  kworker/3:0
> >>      2908185    0.00          0.052 ms  kworker/10:1
> >>      2901521    0.00          0.050 ms  kworker/6:1
> >>      2902444    0.00          0.046 ms  kworker/5:1
> >>      2898513    0.00          0.041 ms  kworker/1:1
> >>      2912280    0.00          0.039 ms  kworker/11:3
> >>         1057    0.00          0.037 ms  zabbix_agentd
> >>      2908010    0.00          0.037 ms  kworker/9:3
> >>      2912951    0.00          0.036 ms  kworker/4:3
> >>          793    0.00          0.027 ms  multipathd
> >>           42    0.00          0.023 ms  ksoftirqd/5
> >>            9    0.00          0.022 ms  ksoftirqd/0
> >>           24    0.00          0.019 ms  ksoftirqd/2
> >>           59    0.00          0.019 ms  migration/8
> >>      2929607    0.00          0.018 ms  wecode-db
> >>           29    0.00          0.012 ms  migration/3
> >>           11    0.00          0.012 ms  migration/0
> >>           65    0.00          0.012 ms  migration/9
> >>           17    0.00          0.011 ms  migration/1
> >>           71    0.00          0.011 ms  migration/10
> >>           53    0.00          0.011 ms  migration/7
> >>           23    0.00          0.011 ms  migration/2
> >>           47    0.00          0.011 ms  migration/6
> >>          789    0.00          0.010 ms  multipathd
> >>           35    0.00          0.010 ms  migration/4
> >>          480    0.00          0.009 ms  kworker/4:1H
> >>           41    0.00          0.008 ms  migration/5
> >>           54    0.00          0.006 ms  ksoftirqd/7
> >>           36    0.00          0.005 ms  ksoftirqd/4
> >>           72    0.00          0.005 ms  ksoftirqd/10
> >>           66    0.00          0.005 ms  ksoftirqd/9
> >>           30    0.00          0.004 ms  ksoftirqd/3
> >>      2898362    0.00          0.003 ms  kworker/u24:0
> >>
> >>    # perf kwork top -C 2,4,5
> >>
> >>    Total  :   5604.885 ms, 3 cpus
> >>    %Cpu(s):  17.65% id,   0.00% hi,   0.09% si
> >>    %Cpu2   [||||||||||||||||||||||||        83.00%]
> >>    %Cpu4   [||||||||||||||||||||||||        81.66%]
> >>    %Cpu5   [||||||||||||||||||||||||        82.10%]
> >>
> >>          PID    %CPU           RUNTIME  COMMMAND
> >>      ----------------------------------------------------
> >>            0   18.25        341.048 ms  swapper/4
> >>            0   17.80        332.691 ms  swapper/5
> >>            0   16.89        315.630 ms  swapper/2
> >>      2913012    8.99        168.201 ms  sched-messaging
> >>      2913021    8.74        163.456 ms  sched-messaging
> >>      2913026    8.34        156.120 ms  sched-messaging
> >>      2913010    8.14        152.372 ms  sched-messaging
> >>      2913007    7.74        144.754 ms  sched-messaging
> >>      2913016    7.42        138.977 ms  sched-messaging
> >>      2913022    7.28        136.279 ms  sched-messaging
> >>      2913013    7.00        130.894 ms  sched-messaging
> >>      2913019    6.96        130.455 ms  sched-messaging
> >>      2913023    6.91        129.364 ms  sched-messaging
> >>      2913008    6.47        121.331 ms  sched-messaging
> >>      2913018    6.47        121.124 ms  sched-messaging
> >>      2912994    6.42        120.213 ms  sched-messaging
> >>      2913025    6.42        120.140 ms  sched-messaging
> >>      2913020    6.37        119.386 ms  sched-messaging
> >>      2913011    6.35        118.921 ms  sched-messaging
> >>      2913014    6.24        116.779 ms  sched-messaging
> >>      2913009    6.01        112.661 ms  sched-messaging
> >>      2913005    5.96        111.587 ms  sched-messaging
> >>      2913003    5.94        111.142 ms  sched-messaging
> >>      2913024    5.87        109.876 ms  sched-messaging
> >>      2912988    5.84        109.396 ms  sched-messaging
> >>      2912987    5.80        108.550 ms  sched-messaging
> >>      2912990    5.51        103.322 ms  sched-messaging
> >>      2912993    5.45        102.045 ms  sched-messaging
> >>      2912996    5.42        101.622 ms  sched-messaging
> >>      2913006    5.42        101.592 ms  sched-messaging
> >>      2913000    5.41        101.511 ms  sched-messaging
> >>      2913002    5.41        101.420 ms  sched-messaging
> >>      2912997    5.40        101.315 ms  sched-messaging
> >>      2913004    5.33         99.872 ms  sched-messaging
> >>      2913015    5.29         99.252 ms  sched-messaging
> >>      2913017    5.22         97.822 ms  sched-messaging
> >>      2912991    5.11         95.773 ms  sched-messaging
> >>      2912992    5.11         95.579 ms  sched-messaging
> >>      2913001    5.07         95.033 ms  sched-messaging
> >>      2912989    4.93         92.425 ms  sched-messaging
> >>      2912995    4.85         90.892 ms  sched-messaging
> >>      2912998    4.78         89.617 ms  sched-messaging
> >>      2912999    4.56         85.576 ms  sched-messaging
> >>      3006112    0.07          1.402 ms  redis-server
> >>       660381    0.02          0.566 ms  containerd
> >>      2912984    0.02          0.452 ms  perf
> >>       659824    0.01          0.369 ms  containerd
> >>       659822    0.00          0.316 ms  containerd
> >>           10    0.00          0.176 ms  rcu_sched
> >>          801    0.00          0.120 ms  jbd2/sda4-8
> >>      2912985    0.00          0.107 ms  sched-messaging
> >>      2912986    0.00          0.075 ms  perf
> >>      2912817    0.00          0.070 ms  kworker/2:1
> >>      2912192    0.00          0.056 ms  kworker/u24:2
> >>      2929605    0.00          0.046 ms  grpc_global_tim
> >>      2902444    0.00          0.046 ms  kworker/5:1
> >>      2912951    0.00          0.036 ms  kworker/4:3
> >>           42    0.00          0.023 ms  ksoftirqd/5
> >>           24    0.00          0.019 ms  ksoftirqd/2
> >>           23    0.00          0.011 ms  migration/2
> >>           35    0.00          0.010 ms  migration/4
> >>          480    0.00          0.009 ms  kworker/4:1H
> >>           41    0.00          0.008 ms  migration/5
> >>           36    0.00          0.005 ms  ksoftirqd/4
> >>
> >>    # perf kwork top -n perf
> >>
> >>    Total  :  22419.068 ms, 12 cpus
> >>    %Cpu(s):  17.99% id,   0.00% hi,   0.09% si
> >>    %Cpu0   [                                 0.00%]
> >>    %Cpu1   [                                 0.00%]
> >>    %Cpu2   [                                 0.02%]
> >>    %Cpu3   [                                 0.00%]
> >>    %Cpu4   [                                 0.00%]
> >>    %Cpu5   [                                 0.00%]
> >>    %Cpu6   [                                 0.00%]
> >>    %Cpu7   [                                 0.00%]
> >>    %Cpu8   [                                 0.03%]
> >>    %Cpu9   [                                 0.09%]
> >>    %Cpu10  [                                 0.00%]
> >>    %Cpu11  [                                 1.96%]
> >>
> >>          PID    %CPU           RUNTIME  COMMMAND
> >>      ----------------------------------------------------
> >>      2912984    2.10         39.452 ms  perf
> >>      2912986    0.00          0.075 ms  perf
> >>
> >>    # perf kwork top -s tid -n sched-messaging
> >>
> >>    Total  :  22419.068 ms, 12 cpus
> >>    %Cpu(s):  17.99% id,   0.00% hi,   0.09% si
> >>    %Cpu0   [||||||||||||||||||||||||        81.80%]
> >>    %Cpu1   [||||||||||||||||||||||||        81.65%]
> >>    %Cpu2   [||||||||||||||||||||||||        82.88%]
> >>    %Cpu3   [||||||||||||||||||||||||        80.96%]
> >>    %Cpu4   [||||||||||||||||||||||||        81.64%]
> >>    %Cpu5   [||||||||||||||||||||||||        82.04%]
> >>    %Cpu6   [||||||||||||||||||||||||        81.63%]
> >>    %Cpu7   [||||||||||||||||||||||||        81.97%]
> >>    %Cpu8   [||||||||||||||||||||||||        82.43%]
> >>    %Cpu9   [||||||||||||||||||||||||        80.86%]
> >>    %Cpu10  [||||||||||||||||||||||||        81.72%]
> >>    %Cpu11  [|||||||||||||||||||||||         79.89%]
> >>
> >>          PID    %CPU           RUNTIME  COMMMAND
> >>      ----------------------------------------------------
> >>      2912985    0.04          1.111 ms  sched-messaging
> >>      2912987   21.28        398.512 ms  sched-messaging
> >>      2912988   21.44        401.820 ms  sched-messaging
> >>      2912989   21.46        402.303 ms  sched-messaging
> >>      2912990   21.54        403.601 ms  sched-messaging
> >>      2912991   21.59        404.378 ms  sched-messaging
> >>      2912992   21.57        403.845 ms  sched-messaging
> >>      2912993   21.69        406.166 ms  sched-messaging
> >>      2912994   21.52        403.087 ms  sched-messaging
> >>      2912995   21.49        402.421 ms  sched-messaging
> >>      2912996   21.48        402.666 ms  sched-messaging
> >>      2912997   21.27        398.518 ms  sched-messaging
> >>      2912998   21.75        407.579 ms  sched-messaging
> >>      2912999   21.79        407.929 ms  sched-messaging
> >>      2913000   21.78        408.045 ms  sched-messaging
> >>      2913001   21.55        403.803 ms  sched-messaging
> >>      2913002   21.27        398.759 ms  sched-messaging
> >>      2913003   21.46        402.034 ms  sched-messaging
> >>      2913004   21.37        400.242 ms  sched-messaging
> >>      2913005   21.56        403.715 ms  sched-messaging
> >>      2913006   21.23        397.888 ms  sched-messaging
> >>      2913007   27.48        514.411 ms  sched-messaging
> >>      2913008   27.54        515.447 ms  sched-messaging
> >>      2913009   27.30        510.997 ms  sched-messaging
> >>      2913010   27.50        514.890 ms  sched-messaging
> >>      2913011   27.32        511.632 ms  sched-messaging
> >>      2913012   27.30        511.138 ms  sched-messaging
> >>      2913013   27.30        511.109 ms  sched-messaging
> >>      2913014   27.32        511.381 ms  sched-messaging
> >>      2913015   27.36        512.563 ms  sched-messaging
> >>      2913016   27.18        509.231 ms  sched-messaging
> >>      2913017   27.56        516.273 ms  sched-messaging
> >>      2913018   27.56        516.152 ms  sched-messaging
> >>      2913019   27.25        510.488 ms  sched-messaging
> >>      2913020   27.20        509.677 ms  sched-messaging
> >>      2913021   27.23        509.661 ms  sched-messaging
> >>      2913022   27.19        509.061 ms  sched-messaging
> >>      2913023   27.21        509.400 ms  sched-messaging
> >>      2913024   27.18        509.108 ms  sched-messaging
> >>      2913025   27.62        516.976 ms  sched-messaging
> >>      2913026   27.35        512.198 ms  sched-messaging
> >>
> >>    # perf kwork top -b
> >>    Starting trace, Hit <Ctrl+C> to stop and report
> >>    ^C
> >>    Total  :  89209.004 ms, 4 cpus
> >>    %Cpu(s):  13.47% id,   0.01% hi,   0.24% si
> >>    %Cpu0   [|||||||||||||||||||||||||       86.08%]
> >>    %Cpu1   [||||||||||||||||||||||||||      87.08%]
> >>    %Cpu2   [|||||||||||||||||||||||||       86.10%]
> >>    %Cpu3   [|||||||||||||||||||||||||       85.86%]
> >>
> >>          PID     SPID    %CPU           RUNTIME  COMMMAND
> >>      -------------------------------------------------------------
> >>            0        0   13.86       3092.482 ms  [swapper/3]
> >>            0        0   13.71       3057.756 ms  [swapper/0]
> >>            0        0   13.65       3044.987 ms  [swapper/2]
> >>            0        0   12.63       2818.079 ms  [swapper/1]
> >>          320      320    1.32        295.427 ms  bash
> >>          414      320    1.09        247.658 ms  sched-messaging
> >>          678      320    1.09        246.881 ms  sched-messaging
> >>          354      320    1.09        246.683 ms  sched-messaging
> >>          409      320    1.08        246.839 ms  sched-messaging
> >>          554      320    1.07        243.045 ms  sched-messaging
> >>          405      320    1.04        237.340 ms  sched-messaging
> >>          525      320    1.04        235.718 ms  sched-messaging
> >>          486      320    1.03        235.369 ms  sched-messaging
> >>          714      320    1.03        235.142 ms  sched-messaging
> >>          435      320    1.03        233.290 ms  sched-messaging
> >>          408      320    1.03        231.687 ms  sched-messaging
> >>          716      320    1.02        233.513 ms  sched-messaging
> >>          453      320    1.02        233.181 ms  sched-messaging
> >>          522      320    1.02        230.101 ms  sched-messaging
> >>          651      320    1.02        229.554 ms  sched-messaging
> >>          418      320    1.01        231.359 ms  sched-messaging
> >>          644      320    1.01        229.848 ms  sched-messaging
> >>          535      320    1.01        229.655 ms  sched-messaging
> >>          536      320    1.01        229.147 ms  sched-messaging
> >>          410      320    1.01        227.700 ms  sched-messaging
> >>          689      320    1.00        227.988 ms  sched-messaging
> >>          412      320    1.00        227.052 ms  sched-messaging
> >>          489      320    1.00        226.374 ms  sched-messaging
> >>          521      320    1.00        225.499 ms  sched-messaging
> >>          530      320    1.00        225.262 ms  sched-messaging
> >>          681      320    1.00        225.187 ms  sched-messaging
> >>          415      320    0.99        225.714 ms  sched-messaging
> >>          643      320    0.99        225.090 ms  sched-messaging
> >>          325      320    0.99        223.385 ms  sched-messaging
> >>          498      320    0.99        222.936 ms  sched-messaging
> >>          413      320    0.98        225.213 ms  sched-messaging
> >>          645      320    0.98        223.211 ms  sched-messaging
> >>          544      320    0.98        222.714 ms  sched-messaging
> >>          441      320    0.98        222.590 ms  sched-messaging
> >>          697      320    0.98        222.426 ms  sched-messaging
> >>          523      320    0.98        221.841 ms  sched-messaging
> >>          402      320    0.98        221.776 ms  sched-messaging
> >>    <SNIP>
> >>
> >> Yang Jihong (16):
> >>    perf kwork: Fix incorrect and missing free atom in work_push_atom()
> >>    perf kwork: Add the supported subcommands to the document
> >>    perf kwork: Set ordered_events for perf_tool
> >>    perf kwork: Add `kwork` and `src_type` to work_init() for struct
> >>      kwork_class
> >>    perf kwork: Overwrite original atom in the list when a new atom is
> >>      pushed.
> >>    perf kwork: Set default events list if not specified in
> >>      setup_event_list()
> >>    perf kwork: Add sched record support
> >>    perf kwork: Add `root` parameter to work_sort()
> >>    perf kwork: Implement perf kwork top
> >>    perf evsel: Add evsel__intval_common() helper
> >>    perf kwork top: Add statistics on hardirq event support
> >>    perf kwork top: Add statistics on softirq event support
> >>    perf kwork top: Add -C/--cpu -i/--input -n/--name -s/--sort --time
> >>      options
> >>    perf kwork top: Implements BPF-based cpu usage statistics
> >>    perf kwork top: Add BPF-based statistics on hardirq event support
> >>    perf kwork top: Add BPF-based statistics on softirq event support
> >
> > Besides documentation nits, series:
> > Reviewed-by: Ian Rogers <irogers@google.com>
>
> Thanks for reivew.
>
> >
> > Whilst looking at the series, could we clean up
> > tools/perf/util/kwork.h ? Generally none of the structs are commented.
>
> Okay, I'll put up a separate patch and add comments about it.
> > Some like:
> >  > struct kwork_atom {
> >         struct list_head list;
> >         u64 time;
> >         struct kwork_atom *prev;
> >
> >         void *page_addr;
> >         unsigned long bit_inpage;
> > };
> >
> > Why is it an atom? Why is there a prev when the kwork_atom is also on
> > a list (which has a prev) ?
> >
> An atom indicates a minimum granularity event.
> For example, an "irq_hander_entry" event of an IRQ whose irqnum=3D=3D10 i=
s
> an atom.
>
> The prev member is used to store the sequence of events.
> For example, the sequence of events is as follows:
> raise -> entry -> exit
>
> Then:
> entry_atom->prev =3D raise_atom
>
> This relationship needs to be saved because need to calculate latency
> time and running time at the same time in the "perf kwork timehist"

Thanks Yang, this is good context. Could it be added to the header
file? I'm also wondering at some point we should start generating
kerneldoc from comments in the code. I don't know if you want to look
into kerneldoc style comments.

Thanks,
Ian

> Thanks,
> Yang
