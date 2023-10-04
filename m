Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1887B78B1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 09:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241500AbjJDH04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 03:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjJDH0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 03:26:55 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C2598;
        Wed,  4 Oct 2023 00:26:52 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99de884ad25so318325866b.3;
        Wed, 04 Oct 2023 00:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696404410; x=1697009210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ampmjb5nn6WsDhiRi4sd5xEjXsA9NxoOOxrN/nCo4sk=;
        b=WpceyEMNR+xjdVzqOpNYMoQkfJudTbdhgF1ygspyMhP/doH0CnLUfc3PN79CxsbVwH
         WUK756ZlNpNKwtxeINrVyxsjkY3ABfSdS1oQGJpSju4Wuj9QCB1PIkdsuVQgY4QfHg3E
         Vpc7r57M2LcO3ycqeEWv7/b8ddcOOS7yVV3UcYfnaDPeIssfXPcubHdDJZkQTRFNdIZ0
         UFjY2dtH/JdphGDV3R7BQkvIYyIZmSy89//L00wJsu1FQiyuaa/s1+0gflESbBhcSlZc
         JGRQl2H7+8crv90PB5fMVbQMI2NLunnecq6PcuXEh8Tgcy8G3/c2kvm/hhZsXp1SgNFe
         ISBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696404410; x=1697009210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ampmjb5nn6WsDhiRi4sd5xEjXsA9NxoOOxrN/nCo4sk=;
        b=qyjuokW8eNatZYFYWXy/bPPWkq9UK7zQy64WJB9SenapCDevhP7w4BceEdNV6Tdy92
         xnj8jKg6dSVHx1wGCycPgkbmp1uD3NCX8Vv1dLzHS3rwdZ3wwBWkpGUxirpGEnxN6s/L
         tshz4nOnWGW4ZgMmXwYzdCEEtL5PaDKaz1Kx2aXRQ6Gg/1fk9gWon/23vA++1e3clMNO
         Uk9XUgw26iYsHFSkhP5WHZcTY6qiM+pzzcK0Rihfsq7/g7qrTzPYcgHgkgrOnnq3hBo0
         z/4O9EXkp7V/Ar9XTJX2c9mBy7VM5576fp7pmy+6plXtMehpGYMU03aMCRXhkBKCM52k
         srDw==
X-Gm-Message-State: AOJu0Yx0+AiGhsijjRqE7DqK1H57/XTWOkdonNLcjz9jfMe/jE98dcmL
        iSY+/4WMCM6Kmhqqf1V7ZwIz+Z9defQ=
X-Google-Smtp-Source: AGHT+IHhM8GYxYqCvvWUMJ1UlRFlRa9ZWycKMdjOnVw3AuuLqBB6baMgb10S45O9mpMn312cfDlGxQ==
X-Received: by 2002:a17:906:30db:b0:9ae:41db:c27f with SMTP id b27-20020a17090630db00b009ae41dbc27fmr1568311ejb.10.1696404410443;
        Wed, 04 Oct 2023 00:26:50 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id l7-20020a1709061c4700b00997d7aa59fasm2320059ejg.14.2023.10.04.00.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 00:26:48 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 4 Oct 2023 09:26:46 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH] perf/core: Introduce cpuctx->cgrp_ctx_list
Message-ID: <ZR0TtjhGT+Em+/ti@gmail.com>
References: <20231004040844.797044-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004040844.797044-1-namhyung@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Namhyung Kim <namhyung@kernel.org> wrote:

> AFAIK we don't have a tool to measure the context switch overhead
> directly.  (I think I should add one to perf ftrace latency).  But I can
> see it with a simple perf bench command like this.
> 
>   $ perf bench sched pipe -l 100000
>   # Running 'sched/pipe' benchmark:
>   # Executed 100000 pipe operations between two processes
> 
>        Total time: 0.650 [sec]
> 
>          6.505740 usecs/op
>            153710 ops/sec
> 
> It runs two tasks communicate each other using a pipe so it should
> stress the context switch code.  This is the normal numbers on my
> system.  But after I run these two perf stat commands in background,
> the numbers vary a lot.
> 
>   $ sudo perf stat -a -e cycles -G user.slice -- sleep 100000 &
>   $ sudo perf stat -a -e uncore_imc/cas_count_read/ -- sleep 10000 &
> 
> I will show the last two lines of perf bench sched pipe output for
> three runs.
> 
>         58.597060 usecs/op    # run 1
>             17065 ops/sec
> 
>         11.329240 usecs/op    # run 2
>             88267 ops/sec
> 
>         88.481920 usecs/op    # run 3
>             11301 ops/sec
> 
> I think the deviation comes from the fact that uncore events are managed
> a certain number of cpus only.  If the target process runs on a cpu that
> manages uncore pmu, it'd take longer.  Otherwise it won't affect the
> performance much.

The numbers of pipe-message context switching will vary a lot depending on 
CPU migration patterns as well.

The best way to measure context-switch overhead is to pin that task
to a single CPU with something like:

   $ taskset 1 perf stat --null --repeat 10 perf bench sched pipe -l 10000 >/dev/null

   Performance counter stats for 'perf bench sched pipe -l 10000' (10 runs):

            0.049798 +- 0.000102 seconds time elapsed  ( +-  0.21% )

as you can see the 0.21% stddev is pretty low.

If we allow 2 CPUs, both runtime and stddev is much higher:

   $ taskset 3 perf stat --null --repeat 10 perf bench sched pipe -l 10000 >/dev/null

   Performance counter stats for 'perf bench sched pipe -l 10000' (10 runs):

              1.4835 +- 0.0383 seconds time elapsed  ( +-  2.58% )

Thanks,

	Ingo
