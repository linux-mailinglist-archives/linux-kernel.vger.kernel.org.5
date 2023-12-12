Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9D380F5B6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376620AbjLLStu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Dec 2023 13:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbjLLStr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:49:47 -0500
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53CBE4;
        Tue, 12 Dec 2023 10:49:53 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-590a21e977aso171251eaf.1;
        Tue, 12 Dec 2023 10:49:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702406993; x=1703011793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pqr+YhuXzfTM4+m6XEVLjTwX25jI2nCG9xSO0tY1jqg=;
        b=aDuPMqRQ9H3cdvq3qrSurmQhydz5pSDBc5F1+FBhxfQpwoO8jW5uvwzzsAXc8TglTg
         +4HKWDckehmcoXL4hVud58OhALyW4ML0WxF3cA0GeVzAND3RK6apJ+qkjC3VZIPk8ON7
         +2qkMQ5ypxL05IQlrkEmTSlOXrIUTtpNKYsqk12yFLF3ArXPpp5ed+fEWFBlP0CZsLrp
         B7GpW6dS5YqKP7tqV3GW5JQIpNiLHJX2HvjJqCh031gBZ40b7UtaY0Qr1+TB+e46+AhR
         6s6R7N7aGbTcM5CW17IoWoZb4OPDQXmam+pnPYLPrKeOPXrnv3nAIQtlLoxBoi2QgqYV
         O0OQ==
X-Gm-Message-State: AOJu0YxJ+gFX3mXOgzrygprvkEu+LTb+iAC3oqmAzKS3Hmr/oN7y6MNr
        3iEMQ/XdH2RRYBIJQgt+zOOLwO9ET4n/udF0wUI=
X-Google-Smtp-Source: AGHT+IHpNEkq0Fl3OG5kkHtB8rx6BF/sQVJWXNQm0yNODaxuPYUFryM+Lb+eW3EY/GOgHcJZ6vf1y6y7PJjjOKjmkb8=
X-Received: by 2002:a4a:c487:0:b0:58d:ddcb:db1a with SMTP id
 f7-20020a4ac487000000b0058dddcbdb1amr11137734ooq.1.1702406992728; Tue, 12 Dec
 2023 10:49:52 -0800 (PST)
MIME-Version: 1.0
References: <20231129110853.94344-1-lukasz.luba@arm.com>
In-Reply-To: <20231129110853.94344-1-lukasz.luba@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Dec 2023 19:49:41 +0100
Message-ID: <CAJZ5v0gqAGv50MK9oAVW=+w+7unavQ86cHF6zmyJjmVvNYjzUg@mail.gmail.com>
Subject: Re: [PATCH v5 00/23] Introduce runtime modifiable Energy Model
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, dietmar.eggemann@arm.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org, pavel@ucw.cz,
        mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Beata Michalska <Beata.Michalska@arm.com>,
        Sumit Gupta <sumitg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Wed, Nov 29, 2023 at 12:08 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi all,
>
> This patch set adds a new feature which allows to modify Energy Model (EM)
> power values at runtime. It will allow to better reflect power model of
> a recent SoCs and silicon. Different characteristics of the power usage
> can be leveraged and thus better decisions made during task placement in EAS.
>
> It's part of feature set know as Dynamic Energy Model. It has been presented
> and discussed recently at OSPM2023 [3]. This patch set implements the 1st
> improvement for the EM.
>
> The concepts:
> 1. The CPU power usage can vary due to the workload that it's running or due
> to the temperature of the SoC. The same workload can use more power when the
> temperature of the silicon has increased (e.g. due to hot GPU or ISP).
> In such situation the EM can be adjusted and reflect the fact of increased
> power usage. That power increase is due to static power
> (sometimes called simply: leakage). The CPUs in recent SoCs are different.
> We have heterogeneous SoCs with 3 (or even 4) different microarchitectures.
> They are also built differently with High Performance (HP) cells or
> Low Power (LP) cells. They are affected by the temperature increase
> differently: HP cells have bigger leakage. The SW model can leverage that
> knowledge.
>
> 2. It is also possible to change the EM to better reflect the currently
> running workload. Usually the EM is derived from some average power values
> taken from experiments with benchmark (e.g. Dhrystone). The model derived
> from such scenario might not represent properly the workloads usually running
> on the device. Therefore, runtime modification of the EM allows to switch to
> a different model, when there is a need.
>
> 3. The EM can be adjusted after boot, when all the modules are loaded and
> more information about the SoC is available e.g. chip binning. This would help
> to better reflect the silicon characteristics. Thus, this EM modification
> API allows it now. It wasn't possible in the past and the EM had to be
> 'set in stone'.
>
> More detailed explanation and background can be found in presentations
> during LPC2022 [1][2] or in the documentation patches.
>
> Some test results.
> The EM can be updated to fit better the workload type. In the case below the EM
> has been updated for the Jankbench test on Pixel6 (running v5.18 w/ mainline backports
> for the scheduler bits). The Jankbench was run 10 times for those two configurations,
> to get more reliable data.
>
> 1. Janky frames percentage
> +--------+-----------------+---------------------+-------+-----------+
> | metric |    variable     |       kernel        | value | perc_diff |
> +--------+-----------------+---------------------+-------+-----------+
> | gmean  | jank_percentage | EM_default          |  2.0  |   0.0%    |
> | gmean  | jank_percentage | EM_modified_runtime |  1.3  |  -35.33%  |
> +--------+-----------------+---------------------+-------+-----------+
>
> 2. Avg frame render time duration
> +--------+---------------------+---------------------+-------+-----------+
> | metric |      variable       |       kernel        | value | perc_diff |
> +--------+---------------------+---------------------+-------+-----------+
> | gmean  | mean_frame_duration | EM_default          | 10.5  |   0.0%    |
> | gmean  | mean_frame_duration | EM_modified_runtime |  9.6  |  -8.52%   |
> +--------+---------------------+---------------------+-------+-----------+
>
> 3. Max frame render time duration
> +--------+--------------------+---------------------+-------+-----------+
> | metric |      variable      |       kernel        | value | perc_diff |
> +--------+--------------------+---------------------+-------+-----------+
> | gmean  | max_frame_duration | EM_default          | 251.6 |   0.0%    |
> | gmean  | max_frame_duration | EM_modified_runtime | 115.5 |  -54.09%  |
> +--------+--------------------+---------------------+-------+-----------+
>
> 4. OS overutilized state percentage (when EAS is not working)
> +--------------+---------------------+------+------------+------------+
> |    metric    |       wa_path       | time | total_time | percentage |
> +--------------+---------------------+------+------------+------------+
> | overutilized | EM_default          | 1.65 |   253.38   |    0.65    |
> | overutilized | EM_modified_runtime | 1.4  |   277.5    |    0.51    |
> +--------------+---------------------+------+------------+------------+
>
> 5. All CPUs (Little+Mid+Big) power values in mW
> +------------+--------+---------------------+-------+-----------+
> |  channel   | metric |       kernel        | value | perc_diff |
> +------------+--------+---------------------+-------+-----------+
> |    CPU     | gmean  | EM_default          | 142.1 |   0.0%    |
> |    CPU     | gmean  | EM_modified_runtime | 131.8 |  -7.27%   |
> +------------+--------+---------------------+-------+-----------+
>
> The time cost to update the EM decreased in this v5 vs v4:
> big: 5us vs 2us -> 2.6x faster
> mid: 9us vs 3us -> 3x faster
> little: 16us vs 16us -> no change
>
> We still have to update the inefficiency in the cpufreq framework, thus
> a bit of overhead will be there.
>
> Changelog:
> v5:
> - removed 2 tables design
> - have only one table (runtime_table) used also in thermal (Wei, Rafael)
> - refactored update function and removed callback call for each opp
> - added faster EM table swap, using only the RCU pointer update
> - added memory allocation API and tracking with kref
> - avoid overhead for computing 'cost' for each OPP in update, it can be
>   pre-computed in device drivers EM earlier
> - add support for device drivers providing EM table
> - added API for computing 'cost' values in EM for EAS
> - added API for thermal/powercap to use EM (using RCU wrappers)
> - switched to single allocation and 'state[]' array (Rafael)
> - changed documentation to align with current design
> - added helper API for computing cost values
> - simplified EM free in unregister path (thanks to kref)
> - split patch updating EM clients and changed them separetly
> - added seperate patch removing old static EM table
> - added EM debugfs change patch to dump the runtime_table
> - addressed comments in v4 for spelling/comments/headers
> - added review tags

I like this one more than the previous one and thanks for taking my
feedback into account.

I would still like other people having a vested interest in the EM to
look at it and give feedback (or just tags), so I'm not inclined to
apply it just yet.  However, I don't have any specific comments on it.
