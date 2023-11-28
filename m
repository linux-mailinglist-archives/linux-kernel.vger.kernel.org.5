Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DC97FAFD6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 02:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbjK1B65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 20:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjK1B6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 20:58:55 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271651AA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 17:59:02 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so672856266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 17:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701136740; x=1701741540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PphOIqSqCVmNNOsOe5Hpj1iumuWnMQ+UeGD+TeZjx4U=;
        b=tIUWpXayImjFTCSBwCvC9k/n34K4SzVufu+DlrAXNVgLLhzvIhOwrkHntuzx4IP/xC
         rnYM1wcdm/0Q2i3LZK702k2LwSXQSYybW39h+BVdeIJkzZELV0NwKJUAlLpNTW8lP9P8
         Fyf2DosQAp8Si+hQ4R4+3pyTcuD2uFjcna3241igT0ugWvFDKxKE7F7+ze/VPxCs5Xt1
         p4IejA1H3AikSxJARZWPfYS3/DHEPOXP4hrxLxuZa5APO52LckTO4tT9jV6WubdgqhAX
         nJ+EqFk/3qGqstGZHm/NcZZKkRygbb6xY+I/4zOLn4F9aC7nlcC+P1sFU/DYi/yRcCgP
         3QsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701136740; x=1701741540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PphOIqSqCVmNNOsOe5Hpj1iumuWnMQ+UeGD+TeZjx4U=;
        b=rMp1in+yVnu4cj4Jj9nQYnrjHsHMjNYvGifXaVIbjkYoHMKdd3KWPezasiESlUZ4zv
         nGPGhPR5V0U8N25aVFifYI24SFtSX4XEIeQ1r6aikfsF2MGUlib5n/UmEOdu9xiNDmSv
         kqtE/MBlJ59BD/eI0ijAIIYS0TtmKSuUSeQhvIJZFmUz312soXa5KSF0M/GrP1oTJqo3
         r0zW/8OIfMWnpxBhBwI20QH4RRL14aPQuutwpbZ6b9Yc7rsCymopzh115egYvkBkPEPU
         kVlNM2DxPUg1uhHFYbMBGnISLa8U4XD7atKrhEG7HfqqUz91kIQWZAWvUuzouelymrSF
         4L0w==
X-Gm-Message-State: AOJu0Yxq1jL3ALBo37RXQXYaVDM8RFVCs5jAynuYNlYRbBaPXus+ZGtv
        Mgl3Yx1b5C7NtZqBM0nvAJMnujGNmOcEmK/HO6Cmew==
X-Google-Smtp-Source: AGHT+IHFydTp2xVa4ET3Zk3VpJsnsjThN5lHXwAhFmVBcv53GS0WQDvOENSxAYKSIGQKCBEJvRE4lARsexdWQUTfp2Y=
X-Received: by 2002:a17:906:c282:b0:9be:68db:b763 with SMTP id
 r2-20020a170906c28200b009be68dbb763mr7753564ejz.71.1701136740404; Mon, 27 Nov
 2023 17:59:00 -0800 (PST)
MIME-Version: 1.0
References: <20231116022411.2250072-4-yosryahmed@google.com>
 <202311221542.973f16ad-oliver.sang@intel.com> <CAJD7tkYnn6CxSJdo0QJ1hc6cFY_qWLuJ0=S6g_Pm=GBV+Ss-jw@mail.gmail.com>
 <ZWVGS2rNgueGH8uU@xsang-OptiPlex-9020>
In-Reply-To: <ZWVGS2rNgueGH8uU@xsang-OptiPlex-9020>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 27 Nov 2023 17:58:24 -0800
Message-ID: <CAJD7tkameJBrJQxRj+ibKL6-yd-i0wyoyv2cgZdh3ZepA1p7wA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] mm: memcg: make stats flushing threshold per-memcg
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        linux-kernel@vger.kernel.org
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

On Mon, Nov 27, 2023 at 5:46=E2=80=AFPM Oliver Sang <oliver.sang@intel.com>=
 wrote:
>
> hi, Yosry Ahmed,
>
> On Mon, Nov 27, 2023 at 01:13:44PM -0800, Yosry Ahmed wrote:
> > On Wed, Nov 22, 2023 at 5:54=E2=80=AFAM kernel test robot <oliver.sang@=
intel.com> wrote:
> > >
> > >
> > >
> > > Hello,
> > >
> > > kernel test robot noticed a -30.2% regression of will-it-scale.per_th=
read_ops on:
> > >
> > >
> > > commit: c7fbfc7b4e089c4a9b292b1973a42a5761c1342f ("[PATCH v3 3/5] mm:=
 memcg: make stats flushing threshold per-memcg")
> > > url: https://github.com/intel-lab-lkp/linux/commits/Yosry-Ahmed/mm-me=
mcg-change-flush_next_time-to-flush_last_time/20231116-103300
> > > base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-eve=
rything
> > > patch link: https://lore.kernel.org/all/20231116022411.2250072-4-yosr=
yahmed@google.com/
> > > patch subject: [PATCH v3 3/5] mm: memcg: make stats flushing threshol=
d per-memcg
> > >
> > > testcase: will-it-scale
> > > test machine: 104 threads 2 sockets (Skylake) with 192G memory
> > > parameters:
> > >
> > >         nr_task: 50%
> > >         mode: thread
> > >         test: fallocate2
> > >         cpufreq_governor: performance
> > >
> > >
> >
> > This regression was also reported in v2, and I explicitly mention it
> > in the cover letter here:
> > https://lore.kernel.org/lkml/20231116022411.2250072-1-yosryahmed@google=
.com/
>
> got it. this also reminds us to read cover letter for a patch set in the
> future. Thanks!
>
> >
> > In a nutshell, I think this microbenchmark regression does not
> > represent real workloads. On the other hand, there are demonstrated
> > benefits on real workloads from this series in terms of stats reading
> > time.
> >
>
> ok, if there are future versions of this patch, or when it is merged, we =
will
> ignore similar results.
>
> just a small question, since we focus on microbenchmark, if we found othe=
r
> regression (or improvement) on tests other than will-it-scale::fallocate,
> do you want us to send report or just ignore them, either?

I think it would be useful to know if there are
regressions/improvements in other microbenchmarks, at least to
investigate whether they represent real regressions.
