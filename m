Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F7F7D85AA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345381AbjJZPL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjJZPL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:11:56 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1346F18A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:11:53 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-27ddc1b1652so852420a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698333112; x=1698937912; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ytsMrbKsot6WqXNJXipm4PjB22ZW+bd5xJwfX2BfFqw=;
        b=xNrR6YmeDBcRl/LMCaJskbH+tvvcBWrVWyOdLswjoDtw2xvU2HWoIo/9Fbw8FpQR3G
         RyderwScS5nuF6odSBy1fBonmK64/YTtyQdJ7O+I7xMYXbAYQmJxEAPGqLTiRTImQ4i6
         R4pBB1AbDYgYIe91Ov4C3FfuPOrlOyPc2pKZ9Y0f5w6JHBnLho0HwZs2zEV4UsorR9XZ
         5n4KoNwb3RH+x8UEl2qaV89mY1zrkWk8Yced1DRC+tsfzEKrQzNO085N6HliHkxitfSE
         zIJQWNhiBzXF94Rlr9p0eGteo3XsJTrN4dcEWWlNBLQbQ5LcDEfYeOsieNGydAYCeo3p
         gO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698333112; x=1698937912;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ytsMrbKsot6WqXNJXipm4PjB22ZW+bd5xJwfX2BfFqw=;
        b=AjGxz6ocmAzKgi4Ypw5Np8q8vSxVN/ZYLA5v/zJ/AyHlv12ufLifb1RU+mReVbD8lx
         y3OHP1Fx3gGZsufh8VuBTg8GRIGvzIyrCaUeDYd5x2g2KqvFsosMGXhGcJAn9KFtnDal
         tnMSnNe01/l+oOH3vkZbkKzAyJRjK+YQPgXuTL4zQEuPRq4/2dRQi+ynu6q5vestk8BZ
         Fal4RuTS+nY5V75LACMF0lp7Ep2QwIeIvQdczLt0RpfVzrPDXc2BXb+TPpyKACm2Tfdp
         poXqvb7b8wlF5pMCDC/nyB07Vl42AkBQ7fj8ip0eBpbE2yHfpVfirUmCr/OYF+eKBSF/
         uNTg==
X-Gm-Message-State: AOJu0Ywrr+NNen42iq9e6x2Y5grsCDfcpXB713isS1YRh94IUnmi7Gzv
        638JTKPNndYPKwEWhKzbSkT4F4BhNFTm5ZkTyD8BDg==
X-Google-Smtp-Source: AGHT+IHEqfVw5yZzhWJoBelucQkwYypQPy+fwFGVC3DqN1XMc2p4jSCcTNaOLvj+aj+bajUcTWoYmYQ9sIr9SL5Y6fw=
X-Received: by 2002:a17:90a:1602:b0:27d:4dae:3c62 with SMTP id
 n2-20020a17090a160200b0027d4dae3c62mr17689374pja.27.1698333112298; Thu, 26
 Oct 2023 08:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231013151450.257891-1-vincent.guittot@linaro.org> <20231026101731.2q6u4mhfhuqrnmbk@BLR-5CG13462PL.amd.com>
In-Reply-To: <20231026101731.2q6u4mhfhuqrnmbk@BLR-5CG13462PL.amd.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 26 Oct 2023 17:11:40 +0200
Message-ID: <CAKfTPtDcS3H5rqd3NpxpUYOttNWsRS8ifZKHg=RePC2_NT3OVQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Rework interface between scheduler and schedutil governor
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rafael@kernel.org, viresh.kumar@linaro.org, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wyes,

On Thu, 26 Oct 2023 at 12:19, Wyes Karny <wyes.karny@amd.com> wrote:
>
> Hi Vincent,
>
> On 13 Oct 17:14, Vincent Guittot wrote:
> > Following the discussion with Qais [1] about how to handle uclamp
> > requirements and after syncing with him, we agreed that I should move
> > forward on the patchset to rework the interface between scheduler and
> > schedutil governor to provide more information to the latter. Scheduler
> > (and EAS in particular) doesn't need anymore to guess estimate which
> > headroom the governor wants to apply and will directly ask for the target
> > freq. Then the governor directly gets the actual utilization and new
> > minimum and maximum boundaries to select this target frequency and
> > doesn't have to deal anymore with scheduler internals like uclamp when
> > including iowait boost.
>
> I ran a duty_cycle (one cpu 1) test which does timed busy and idle repeatedly based on user input.
>

Thanks for the tests. IIUC your result below, you don't see any
significant difference in the figures with and without the patch which
is exactly the goal in your case. The difference happens when you use
either uclamp_min/max or deadline tasks or EAS or
cpufreq_driver_adjust_perf()

> I used below bpftrace program to trace effective utilization:
> bpftrace -e 'kretprobe:effective_cpu_util / cpu == 1/ { @eff_util[cpu] = stats(retval); @eff_util_hist[cpu] = hist(retval);}'

Minor point but this should not make any difference in your case
The new effective_cpu_util() replaces the legacy
effective_cpu_util(cpu, util_cfs, type == ENERGY_UTIL, p)
And the new sugov_effective_cpu_perf() replaces the legacy
effective_cpu_util(cpu, util_cfs, type == FREQUENCY_UTIL, p) + dvfs
headroom

Thanks,
Vincent

>
> Below are the results on AMD server system:
>
> --------------------------------------------------------------------------------+ -------------------------------------------------------------------------------+
>                            Without patches on 6.6-rc6                           |                             With patches on 6.6-rc6                            |
> ------------------------------------------------------------------------------- | -------------------------------------------------------------------------------|
> busy: 0%, idle: 100% :                                                          | busy: 0%, idle: 100% :                                                         |
>                                                                                 |                                                                                |
> @eff_util[1]: count 4923, average 22, total 110935                              | @eff_util[1]: count 5556, average 10, total 58857                              |
>                                                                                 |                                                                                |
> @eff_util_hist[1]:                                                              | @eff_util_hist[1]:                                                             |
> [1]                    6 |                                                    | | [1]                   14 |                                                    ||
> [2, 4)                10 |                                                    | | [2, 4)                16 |                                                    ||
> [4, 8)               862 |@@@@@@@@@@@                                         | | [4, 8)              1628 |@@@@@@@@@@@@@@@@@@@@@                               ||
> [8, 16)             3782 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@| | [8, 16)             3896 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@||
> [16, 32)              52 |                                                    | | [16, 32)               2 |                                                    ||
> [32, 64)              44 |                                                    | |                                                                                |
> [64, 128)             40 |                                                    | |                                                                                |
> [128, 256)            38 |                                                    | |                                                                                |
> [256, 512)            43 |                                                    | |                                                                                |
> [512, 1K)             40 |                                                    | |                                                                                |
> [1K, 2K)               6 |                                                    | |                                                                                |
> ------------------------------------------------------------------------------- | -------------------------------------------------------------------------------|
> busy: 100%, idle: 0% :                                                          | busy: 100%, idle: 0% :                                                         |
>                                                                                 |                                                                                |
> @eff_util[1]: count 5544, average 974, total 5400203                            | @eff_util[1]: count 5588, average 972, total 5435602                           |
>                                                                                 |                                                                                |
> @eff_util_hist[1]:                                                              | @eff_util_hist[1]:                                                             |
> [0]                    9 |                                                    | | [0]                   17 |                                                    ||
> [1]                    0 |                                                    | | [1]                    0 |                                                    ||
> [2, 4)                 0 |                                                    | | [2, 4)                 0 |                                                    ||
> [4, 8)                 0 |                                                    | | [4, 8)                 0 |                                                    ||
> [8, 16)                0 |                                                    | | [8, 16)                0 |                                                    ||
> [16, 32)               0 |                                                    | | [16, 32)               0 |                                                    ||
> [32, 64)               0 |                                                    | | [32, 64)               0 |                                                    ||
> [64, 128)              0 |                                                    | | [64, 128)              0 |                                                    ||
> [128, 256)             1 |                                                    | | [128, 256)             0 |                                                    ||
> [256, 512)             0 |                                                    | | [256, 512)             0 |                                                    ||
> [512, 1K)           5532 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@| | [512, 1K)           5571 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@||
> [1K, 2K)               2 |                                                    | |                                                                                |
> ------------------------------------------------------------------------------- | -------------------------------------------------------------------------------|
> busy: 10%, idle: 90% :                                                          | busy: 10%, idle: 90% :                                                         |
>                                                                                 |                                                                                |
> @eff_util[1]: count 5073, average 102, total 519454                             | @eff_util[1]: count 5555, average 101, total 566563                            |
>                                                                                 |                                                                                |
> @eff_util_hist[1]:                                                              | @eff_util_hist[1]:                                                             |
> [1]                   10 |                                                    | | [1]                   21 |                                                    ||
> [2, 4)                 6 |                                                    | | [2, 4)                10 |                                                    ||
> [4, 8)                 0 |                                                    | | [4, 8)                 0 |                                                    ||
> [8, 16)                0 |                                                    | | [8, 16)                0 |                                                    ||
> [16, 32)               0 |                                                    | | [16, 32)               0 |                                                    ||
> [32, 64)               0 |                                                    | | [32, 64)               0 |                                                    ||
> [64, 128)           5057 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@| | [64, 128)           5524 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@||
> ------------------------------------------------------------------------------- | -------------------------------------------------------------------------------|
> busy: 20%, idle: 80% :                                                          | busy: 20%, idle: 80% :                                                         |
>                                                                                 |                                                                                |
> @eff_util[1]: count 5112, average 198, total 1017056                            | @eff_util[1]: count 5553, average 201, total 1118650                           |
>                                                                                 |                                                                                |
> @eff_util_hist[1]:                                                              | @eff_util_hist[1]:                                                             |
> [1]                   13 |                                                    | | [2, 4)                22 |                                                    ||
> [2, 4)                 6 |                                                    | | [4, 8)                10 |                                                    ||
> [4, 8)                 0 |                                                    | | [8, 16)                0 |                                                    ||
> [8, 16)                1 |                                                    | | [16, 32)               0 |                                                    ||
> [16, 32)               0 |                                                    | | [32, 64)               0 |                                                    ||
> [32, 64)               0 |                                                    | | [64, 128)              0 |                                                    ||
> [64, 128)              0 |                                                    | | [128, 256)          5521 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@||
> [128, 256)          5092 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@| |                                                                                |
> ------------------------------------------------------------------------------- | -------------------------------------------------------------------------------|
> busy: 30%, idle: 70% :                                                          | busy: 30%, idle: 70% :                                                         |
>                                                                                 |                                                                                |
> @eff_util[1]: count 5136, average 297, total 1528840                            | @eff_util[1]: count 5548, average 297, total 1650683                           |
>                                                                                 |                                                                                |
> @eff_util_hist[1]:                                                              | @eff_util_hist[1]:                                                             |
> [1]                    7 |                                                    | | [0]                   17 |                                                    ||
> [2, 4)                 8 |                                                    | | [1]                    0 |                                                    ||
> [4, 8)                 0 |                                                    | | [2, 4)                 0 |                                                    ||
> [8, 16)                1 |                                                    | | [4, 8)                 0 |                                                    ||
> [16, 32)               0 |                                                    | | [8, 16)                0 |                                                    ||
> [32, 64)               0 |                                                    | | [16, 32)               0 |                                                    ||
> [64, 128)              0 |                                                    | | [32, 64)               0 |                                                    ||
> [128, 256)             0 |                                                    | | [64, 128)              0 |                                                    ||
> [256, 512)          5120 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@| | [128, 256)             0 |                                                    ||
>                                                                                 | [256, 512)          5531 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@||
> ------------------------------------------------------------------------------- | -------------------------------------------------------------------------------|
> busy: 40%, idle: 60% :                                                          | busy: 40%, idle: 60% :                                                         |
>                                                                                 |                                                                                |
> @eff_util[1]: count 5161, average 394, total 2036421                            | @eff_util[1]: count 5552, average 394, total 2189976                           |
>                                                                                 |                                                                                |
> @eff_util_hist[1]:                                                              | @eff_util_hist[1]:                                                             |
> [0]                    2 |                                                    | | [0]                   16 |                                                    ||
> [1]                    9 |                                                    | | [1]                    0 |                                                    ||
> [2, 4)                 2 |                                                    | | [2, 4)                 0 |                                                    ||
> [4, 8)                 0 |                                                    | | [4, 8)                 0 |                                                    ||
> [8, 16)                0 |                                                    | | [8, 16)                0 |                                                    ||
> [16, 32)               0 |                                                    | | [16, 32)               0 |                                                    ||
> [32, 64)               0 |                                                    | | [32, 64)               0 |                                                    ||
> [64, 128)              0 |                                                    | | [64, 128)              0 |                                                    ||
> [128, 256)             0 |                                                    | | [128, 256)             0 |                                                    ||
> [256, 512)          5148 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@| | [256, 512)          5536 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@||
> ------------------------------------------------------------------------------- | -------------------------------------------------------------------------------|
> busy: 50%, idle: 50% :                                                          | busy: 50%, idle: 50% :                                                         |
>                                                                                 |                                                                                |
> @eff_util[1]: count 5226, average 491, total 2567889                            | @eff_util[1]: count 5559, average 489, total 2722999                           |
>                                                                                 |                                                                                |
> @eff_util_hist[1]:                                                              | @eff_util_hist[1]:                                                             |
> [0]                   10 |                                                    | | [0]                    2 |                                                    ||
> [1]                    0 |                                                    | | [1]                   20 |                                                    ||
> [2, 4)                 0 |                                                    | | [2, 4)                 6 |                                                    ||
> [4, 8)                 0 |                                                    | | [4, 8)                 0 |                                                    ||
> [8, 16)                0 |                                                    | | [8, 16)                0 |                                                    ||
> [16, 32)               0 |                                                    | | [16, 32)               0 |                                                    ||
> [32, 64)               0 |                                                    | | [32, 64)               0 |                                                    ||
> [64, 128)              0 |                                                    | | [64, 128)              0 |                                                    ||
> [128, 256)             0 |                                                    | | [128, 256)             0 |                                                    ||
> [256, 512)          5188 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@| | [256, 512)          5526 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@||
> [512, 1K)             28 |                                                    | | [512, 1K)              5 |                                                    ||
> ------------------------------------------------------------------------------- | -------------------------------------------------------------------------------|
> busy: 60%, idle: 40% :                                                          | busy: 60%, idle: 40% :                                                         |
>                                                                                 |                                                                                |
> @eff_util[1]: count 5303, average 587, total 3115494                            | @eff_util[1]: count 5549, average 588, total 3264071                           |
>                                                                                 |                                                                                |
> @eff_util_hist[1]:                                                              | @eff_util_hist[1]:                                                             |
> [1]                    2 |                                                    | | [0]                   17 |                                                    ||
> [2, 4)                 8 |                                                    | | [1]                    0 |                                                    ||
> [4, 8)                 4 |                                                    | | [2, 4)                 0 |                                                    ||
> [8, 16)                0 |                                                    | | [4, 8)                 0 |                                                    ||
> [16, 32)               0 |                                                    | | [8, 16)                0 |                                                    ||
> [32, 64)               0 |                                                    | | [16, 32)               0 |                                                    ||
> [64, 128)              0 |                                                    | | [32, 64)               0 |                                                    ||
> [128, 256)             0 |                                                    | | [64, 128)              0 |                                                    ||
> [256, 512)             0 |                                                    | | [128, 256)             0 |                                                    ||
> [512, 1K)           5289 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@| | [256, 512)             0 |                                                    ||
>                                                                                 | [512, 1K)           5532 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@||
> ------------------------------------------------------------------------------- | -------------------------------------------------------------------------------|
> busy: 70%, idle: 30% :                                                          | busy: 70%, idle: 30% :                                                         |
>                                                                                 |                                                                                |
> @eff_util[1]: count 5325, average 685, total 3648392                            | @eff_util[1]: count 5542, average 685, total 3796277                           |
>                                                                                 |                                                                                |
> @eff_util_hist[1]:                                                              | @eff_util_hist[1]:                                                             |
> [0]                    9 |                                                    | | [0]                   15 |                                                    ||
> [1]                    0 |                                                    | | [1]                    2 |                                                    ||
> [2, 4)                 0 |                                                    | | [2, 4)                 0 |                                                    ||
> [4, 8)                 0 |                                                    | | [4, 8)                 0 |                                                    ||
> [8, 16)                0 |                                                    | | [8, 16)                0 |                                                    ||
> [16, 32)               0 |                                                    | | [16, 32)               0 |                                                    ||
> [32, 64)               0 |                                                    | | [32, 64)               0 |                                                    ||
> [64, 128)              1 |                                                    | | [64, 128)              0 |                                                    ||
> [128, 256)             0 |                                                    | | [128, 256)             0 |                                                    ||
> [256, 512)             0 |                                                    | | [256, 512)             0 |                                                    ||
> [512, 1K)           5315 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@| | [512, 1K)           5525 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@||
> ------------------------------------------------------------------------------- | -------------------------------------------------------------------------------|
> busy: 80%, idle: 20% :                                                          | busy: 80%, idle: 20% :                                                         |
>                                                                                 |                                                                                |
> @eff_util[1]: count 5327, average 780, total 4160266                            | @eff_util[1]: count 5541, average 780, total 4326164                           |
>                                                                                 |                                                                                |
> @eff_util_hist[1]:                                                              | @eff_util_hist[1]:                                                             |
> [1]                    8 |                                                    | | [0]                   17 |                                                    ||
> [2, 4)                 6 |                                                    | | [1]                    0 |                                                    ||
> [4, 8)                 0 |                                                    | | [2, 4)                 0 |                                                    ||
> [8, 16)                0 |                                                    | | [4, 8)                 0 |                                                    ||
> [16, 32)               0 |                                                    | | [8, 16)                0 |                                                    ||
> [32, 64)               0 |                                                    | | [16, 32)               0 |                                                    ||
> [64, 128)              0 |                                                    | | [32, 64)               0 |                                                    ||
> [128, 256)             0 |                                                    | | [64, 128)              0 |                                                    ||
> [256, 512)             0 |                                                    | | [128, 256)             0 |                                                    ||
> [512, 1K)           5313 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@| | [256, 512)             0 |                                                    ||
>                                                                                 | [512, 1K)           5524 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@||
> ------------------------------------------------------------------------------- | -------------------------------------------------------------------------------|
> busy: 90%, idle: 10% :                                                          | busy: 90%, idle: 10% :                                                         |
>                                                                                 |                                                                                |
> @eff_util[1]: count 5424, average 877, total 4762032                            | @eff_util[1]: count 5548, average 877, total 4869975                           |
>                                                                                 |                                                                                |
> @eff_util_hist[1]:                                                              | @eff_util_hist[1]:                                                             |
> [0]                    9 |                                                    | | [0]                   17 |                                                    ||
> [1]                    0 |                                                    | | [1]                    0 |                                                    ||
> [2, 4)                 0 |                                                    | | [2, 4)                 0 |                                                    ||
> [4, 8)                 0 |                                                    | | [4, 8)                 0 |                                                    ||
> [8, 16)                0 |                                                    | | [8, 16)                0 |                                                    ||
> [16, 32)               0 |                                                    | | [16, 32)               0 |                                                    ||
> [32, 64)               0 |                                                    | | [32, 64)               0 |                                                    ||
> [64, 128)              1 |                                                    | | [64, 128)              0 |                                                    ||
> [128, 256)             0 |                                                    | | [128, 256)             0 |                                                    ||
> [256, 512)             0 |                                                    | | [256, 512)             0 |                                                    ||
> [512, 1K)           5412 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@| | [512, 1K)           5531 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@||
> [1K, 2K)               2 |                                                    | |                                                                                |
> --------------------------------------------------------------------------------+ -------------------------------------------------------------------------------|
>
> Thanks,
> Wyes
> >
> > [1] https://lore.kernel.org/lkml/CAKfTPtA5JqNCauG-rP3wGfq+p8EEVx9Tvwj6ksM3SYCwRmfCTg@mail.gmail.com/
> >
> > Vincent Guittot (2):
> >   sched/schedutil: rework performance estimation
> >   sched/schedutil: rework iowait boost
> >
> >  include/linux/energy_model.h     |  1 -
> >  kernel/sched/core.c              | 85 ++++++++++++--------------------
> >  kernel/sched/cpufreq_schedutil.c | 72 +++++++++++++++++----------
> >  kernel/sched/fair.c              | 22 +++++++--
> >  kernel/sched/sched.h             | 84 +++----------------------------
> >  5 files changed, 105 insertions(+), 159 deletions(-)
> >
> > --
> > 2.34.1
> >
