Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0817A7C6F5F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378935AbjJLNf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378876AbjJLNfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:35:55 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D123CBA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:35:53 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c9d4f08d7cso176585ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697117753; x=1697722553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/IHfa2K6n1mcSpH55sMGbJybaWLv+iEOtk/2jmt1/I=;
        b=TcapRLni3kBnPSMWOjsFa7AGkQazBF7Y9KJPRMMjSAOO2HLbwgWghUxmYq7jjL4eNq
         yklG2penf3S0lpko2ILIpCl1zQsijTOOFfnn49wd8Ms7VFmDNzaTaqyWF03euMPnF/ri
         ILVmiADK0V6lnoJMSBkfMUmSJSI+1wQdCbTts+02JJesW7e3844cb6wJu61mpDjCbQUo
         JoWsPbdUQzuvfsbFr/edrwzkyYf500pJoZ2LRPHPZy3mnvRTaCoSZ9K2cxfonnvQ5+Z+
         +66Qu2h/QGYNRqPUl/oud9R0zkrvlY/+ShzHL4e7u3a59NyvB3wo74SjzPla22TulwHI
         a/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697117753; x=1697722553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/IHfa2K6n1mcSpH55sMGbJybaWLv+iEOtk/2jmt1/I=;
        b=H0jzObgdFDtS3zBYcXlBEnR5s5uufukrcmCLwDdvDvgwB8aN2r2eYfcXnN0IrYlUzN
         4fLx7Me5XdBwJ1+YMTg1jrqto+JhbP6q4XnMbIgluUELVFZ6BIxCYnLxfbxGSw1L5Uks
         9NS90vJQYdRnMVHZo6AmgFSCmFbBl3MnDwemyCSx+f0bOUYnnSF4n/FsVIAfEC5k937W
         3fpE9vuXvHELQc8yRXEtfSIiqZqgw8tV7xqm12IEYNBlskwgezegS4yw5CPVLjfbUrof
         ZOUlgyxpDjuEfnFhMW9NUNyitG8AaY6g6v4ICeF4gj6jhsTZnfPXTwVHy3GxShINxN71
         iNMA==
X-Gm-Message-State: AOJu0Yzcvm52/X8zbn47btI6H+FaBLZDrzcIUbzxEDz8MEDtzXeaYPK+
        bvZ3yHkIxrFxEZWG9pr0und0EHRlTYvGD3rNk8+Cpw==
X-Google-Smtp-Source: AGHT+IFIQPiUjxAepWYWkZcNl2QcaX7znO99g+5O/6OHWHM+twceLTKy3udHT9xGrmOpBud3ydIlVyHq67mULq4BbXc=
X-Received: by 2002:a17:903:2444:b0:1c3:3649:1f6a with SMTP id
 l4-20020a170903244400b001c336491f6amr444875pls.7.1697117752910; Thu, 12 Oct
 2023 06:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231010032117.1577496-1-yosryahmed@google.com>
 <20231010032117.1577496-4-yosryahmed@google.com> <CALvZod5nQrf=Y24u_hzGOTXYBfnt-+bo+cYbRMRpmauTMXJn3Q@mail.gmail.com>
 <CAJD7tka=kjd42oFpTm8FzMpNedxpJCUj-Wn6L=zrFODC610A-A@mail.gmail.com>
 <CAJD7tkZSanKOynQmVcDi_y4+J2yh+n7=oP97SDm2hq1kfY=ohw@mail.gmail.com>
 <20231011003646.dt5rlqmnq6ybrlnd@google.com> <CAJD7tkaZzBbvSYbCdvCigcum9Dddk8b6MR2hbCBG4Q2h4ciNtw@mail.gmail.com>
 <CALvZod7NN-9Vvy=KRtFZfV7SUzD+Bn8Z8QSEdAyo48pkOAHtTg@mail.gmail.com>
 <CAJD7tkbHWW139-=3HQM1cNzJGje9OYSCsDtNKKVmiNzRjE4tjQ@mail.gmail.com> <CAJD7tkbSBtNJv__uZT+uh9ie=-WeqPe9oBinGOH2wuZzJMvCAw@mail.gmail.com>
In-Reply-To: <CAJD7tkbSBtNJv__uZT+uh9ie=-WeqPe9oBinGOH2wuZzJMvCAw@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 12 Oct 2023 06:35:41 -0700
Message-ID: <CALvZod6zssp88j6e6EKTbu_oHS7iW5ocdTWH7f27Hg0byzut6g@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 1:04=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Wed, Oct 11, 2023 at 8:13=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Wed, Oct 11, 2023 at 5:46=E2=80=AFAM Shakeel Butt <shakeelb@google.c=
om> wrote:
> > >
> > > On Tue, Oct 10, 2023 at 6:48=E2=80=AFPM Yosry Ahmed <yosryahmed@googl=
e.com> wrote:
> > > >
> > > > On Tue, Oct 10, 2023 at 5:36=E2=80=AFPM Shakeel Butt <shakeelb@goog=
le.com> wrote:
> > > > >
> > > > > On Tue, Oct 10, 2023 at 03:21:47PM -0700, Yosry Ahmed wrote:
> > > > > [...]
> > > > > >
> > > > > > I tried this on a machine with 72 cpus (also ixion), running bo=
th
> > > > > > netserver and netperf in /sys/fs/cgroup/a/b/c/d as follows:
> > > > > > # echo "+memory" > /sys/fs/cgroup/cgroup.subtree_control
> > > > > > # mkdir /sys/fs/cgroup/a
> > > > > > # echo "+memory" > /sys/fs/cgroup/a/cgroup.subtree_control
> > > > > > # mkdir /sys/fs/cgroup/a/b
> > > > > > # echo "+memory" > /sys/fs/cgroup/a/b/cgroup.subtree_control
> > > > > > # mkdir /sys/fs/cgroup/a/b/c
> > > > > > # echo "+memory" > /sys/fs/cgroup/a/b/c/cgroup.subtree_control
> > > > > > # mkdir /sys/fs/cgroup/a/b/c/d
> > > > > > # echo 0 > /sys/fs/cgroup/a/b/c/d/cgroup.procs
> > > > > > # ./netserver -6
> > > > > >
> > > > > > # echo 0 > /sys/fs/cgroup/a/b/c/d/cgroup.procs
> > > > > > # for i in $(seq 10); do ./netperf -6 -H ::1 -l 60 -t TCP_SENDF=
ILE --
> > > > > > -m 10K; done
> > > > >
> > > > > You are missing '&' at the end. Use something like below:
> > > > >
> > > > > #!/bin/bash
> > > > > for i in {1..22}
> > > > > do
> > > > >    /data/tmp/netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K &
> > > > > done
> > > > > wait
> > > > >
> > > >
> > > > Oh sorry I missed the fact that you are running instances in parall=
el, my bad.
> > > >
> > > > So I ran 36 instances on a machine with 72 cpus. I did this 10 time=
s
> > > > and got an average from all instances for all runs to reduce noise:
> > > >
> > > > #!/bin/bash
> > > >
> > > > ITER=3D10
> > > > NR_INSTANCES=3D36
> > > >
> > > > for i in $(seq $ITER); do
> > > >   echo "iteration $i"
> > > >   for j in $(seq $NR_INSTANCES); do
> > > >     echo "iteration $i" >> "out$j"
> > > >     ./netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K >> "out$j" =
&
> > > >   done
> > > >   wait
> > > > done
> > > >
> > > > cat out* | grep 540000 | awk '{sum +=3D $5} END {print sum/NR}'
> > > >
> > > > Base: 22169 mbps
> > > > Patched: 21331.9 mbps
> > > >
> > > > The difference is ~3.7% in my runs. I am not sure what's different.
> > > > Perhaps it's the number of runs?
> > >
> > > My base kernel is next-20231009 and I am running experiments with
> > > hyperthreading disabled.
> >
> > Using next-20231009 and a similar 44 core machine with hyperthreading
> > disabled, I ran 22 instances of netperf in parallel and got the
> > following numbers from averaging 20 runs:
> >
> > Base: 33076.5 mbps
> > Patched: 31410.1 mbps
> >
> > That's about 5% diff. I guess the number of iterations helps reduce
> > the noise? I am not sure.
> >
> > Please also keep in mind that in this case all netperf instances are
> > in the same cgroup and at a 4-level depth. I imagine in a practical
> > setup processes would be a little more spread out, which means less
> > common ancestors, so less contended atomic operations.
>
>
> (Resending the reply as I messed up the last one, was not in plain text)
>
> I was curious, so I ran the same testing in a cgroup 2 levels deep
> (i.e /sys/fs/cgroup/a/b), which is a much more common setup in my
> experience. Here are the numbers:
>
> Base: 40198.0 mbps
> Patched: 38629.7 mbps
>
> The regression is reduced to ~3.9%.
>
> What's more interesting is that going from a level 2 cgroup to a level
> 4 cgroup is already a big hit with or without this patch:
>
> Base: 40198.0 -> 33076.5 mbps (~17.7% regression)
> Patched: 38629.7 -> 31410.1 (~18.7% regression)
>
> So going from level 2 to 4 is already a significant regression for
> other reasons (e.g. hierarchical charging). This patch only makes it
> marginally worse. This puts the numbers more into perspective imo than
> comparing values at level 4. What do you think?

This is weird as we are running the experiments on the same machine. I
will rerun with 2 levels as well. Also can you rerun the page fault
benchmark as well which was showing 9% regression in your original
commit message?
