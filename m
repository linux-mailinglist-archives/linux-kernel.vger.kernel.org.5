Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322317EA8B7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 03:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjKNCZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 21:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjKNCZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 21:25:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC125197
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 18:25:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3185AC433CA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 02:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699928754;
        bh=CYcpvfJ9TQDQEuovsOAJb8HhEEnIA1oyhQK4KMPS/uU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dRTt9l1jAszL3jEAH5Y4UPSa8dxQd+1eo9ROoYH0KlVlgeLEXaFPQRdNTxPWnckqy
         14OXuJ+77GqjM0s+C4IRD/d3hfbGrifQ6JJUN9dGfAX0c/x/3QKHYf7j+AOUiKZ3Sk
         3qNg1WJwJnVnbtGTpGQ5BdidMLmN70xsus6xyOywzSpLlN2Jh7G2Tz6GeOk70zhWpS
         54GOrcta9ZEyeqzE7WzxiiUMqAu7eNFx3zsnTlcu6QwyuS3ZXVKPJcLhWBNdLWMPCq
         Eo2WkS/1AhqPlfHCIRaj6PsRvA6Kh9QGNGQdwHHQVXCJgSoOVUI4zNO6yPqYFEJIr7
         ZJWlz8AlQ5sSA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5079f6efd64so6773355e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 18:25:54 -0800 (PST)
X-Gm-Message-State: AOJu0YweoBWBZVlEcEQfOibbu1Mt7rjKQlX3hbg4RqBNtpZV7naUcqWp
        abOP4Zk/oCPMVdmbhkNwfw3txXdIyPL3UTYw690=
X-Google-Smtp-Source: AGHT+IH96uIZur/Swgs8Pnes7TyGIuTRoYkArdusQcGT/ZdWM/PnBw6U9MGYDuEAIhZ9josJXqxtd5XOPbnbYX4a7HA=
X-Received: by 2002:ac2:5147:0:b0:508:1889:bfc0 with SMTP id
 q7-20020ac25147000000b005081889bfc0mr5372698lfd.5.1699928752304; Mon, 13 Nov
 2023 18:25:52 -0800 (PST)
MIME-Version: 1.0
References: <202311120926.cjYHyoYw-lkp@intel.com> <03b4e787-53bb-4a9c-afa5-dbb51599a8ce@arm.com>
In-Reply-To: <03b4e787-53bb-4a9c-afa5-dbb51599a8ce@arm.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 14 Nov 2023 10:25:40 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6PfKc7+p3iFpDF=Hv45b+2ouCOWZ0w-tHxRauprtbaYA@mail.gmail.com>
Message-ID: <CAAhV-H6PfKc7+p3iFpDF=Hv45b+2ouCOWZ0w-tHxRauprtbaYA@mail.gmail.com>
Subject: Re: drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     kernel test robot <lkp@intel.com>, loongarch@lists.linux.dev,
        kernel@xen0n.name, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Robin,

Could you please try this patch?
https://lore.kernel.org/loongarch/20231113032511.860159-1-chenhuacai@loongs=
on.cn/T/#u

Huacai

On Mon, Nov 13, 2023 at 11:45=E2=80=AFPM Robin Murphy <robin.murphy@arm.com=
> wrote:
>
> On 2023-11-12 1:38 am, kernel test robot wrote:
> > Hi Robin,
> >
> > First bad commit (maybe !=3D root cause):
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master
> > head:   3ca112b71f35dd5d99fc4571a56b5fc6f0c15814
> > commit: f9bd34e3753ea8f1433a3ba70f03a165a1416f98 perf/arm_cspmu: Clean =
up ACPI dependency
> > date:   5 months ago
> > config: loongarch-randconfig-r133-20231107 (https://download.01.org/0da=
y-ci/archive/20231112/202311120926.cjYHyoYw-lkp@intel.com/config)
> > compiler: loongarch64-linux-gcc (GCC) 13.2.0
> > reproduce: (https://download.01.org/0day-ci/archive/20231112/2023111209=
26.cjYHyoYw-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202311120926.cjYHyoYw-l=
kp@intel.com/
> >
> > sparse warnings: (new ones prefixed by >>)
> >>> drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse: sparse: incorrect t=
ype in argument 1 (different address spaces) @@     expected void *ptr @@  =
   got unsigned int [noderef] __percpu * @@
> >     drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     expected void=
 *ptr
> >     drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     got unsigned =
int [noderef] __percpu *
>
> Unpicking the macros, I guess this must stem from:
>
> for_each_sibling_event()
>   -> lockdep_assert_event_ctx()
>      ->this_cpu_read(hardirqs_enabled)
>
> which appears to be the only obvious place to involve a __percpu pointer
> in this area.
>
>  From there it would seem to be a preexisting Loongarch bug - AFAICS
> __percpu_read() (and presumably at least __percpu_write() as well)
> should not be expecting a raw void * argument, but still the __percpu
> pointer, since the final dereference is done right down in the asm using
> the per-cpu offset stashed in r21?
>
> Thanks,
> Robin.
>
> >>> drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse: sparse: incorrect t=
ype in argument 1 (different address spaces) @@     expected void *ptr @@  =
   got unsigned int [noderef] __percpu * @@
> >     drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     expected void=
 *ptr
> >     drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     got unsigned =
int [noderef] __percpu *
> >>> drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse: sparse: incorrect t=
ype in argument 1 (different address spaces) @@     expected void *ptr @@  =
   got unsigned int [noderef] __percpu * @@
> >     drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     expected void=
 *ptr
> >     drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     got unsigned =
int [noderef] __percpu *
> >>> drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse: sparse: incorrect t=
ype in argument 1 (different address spaces) @@     expected void *ptr @@  =
   got unsigned int [noderef] __percpu * @@
> >     drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     expected void=
 *ptr
> >     drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     got unsigned =
int [noderef] __percpu *
> >>> drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse: sparse: incorrect t=
ype in argument 1 (different address spaces) @@     expected void *ptr @@  =
   got int [noderef] __percpu * @@
> >     drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     expected void=
 *ptr
> >     drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     got int [node=
ref] __percpu *
> >>> drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse: sparse: incorrect t=
ype in argument 1 (different address spaces) @@     expected void *ptr @@  =
   got int [noderef] __percpu * @@
> >     drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     expected void=
 *ptr
> >     drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     got int [node=
ref] __percpu *
> >>> drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse: sparse: incorrect t=
ype in argument 1 (different address spaces) @@     expected void *ptr @@  =
   got int [noderef] __percpu * @@
> >     drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     expected void=
 *ptr
> >     drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     got int [node=
ref] __percpu *
> >>> drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse: sparse: incorrect t=
ype in argument 1 (different address spaces) @@     expected void *ptr @@  =
   got int [noderef] __percpu * @@
> >     drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     expected void=
 *ptr
> >     drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     got int [node=
ref] __percpu *
> >
> > vim +627 drivers/perf/arm_cspmu/arm_cspmu.c
> >
> > e37dfd65731dc4f Besar Wicaksono 2022-11-11  609
> > e37dfd65731dc4f Besar Wicaksono 2022-11-11  610  /*
> > e37dfd65731dc4f Besar Wicaksono 2022-11-11  611   * Make sure the group=
 of events can be scheduled at once
> > e37dfd65731dc4f Besar Wicaksono 2022-11-11  612   * on the PMU.
> > e37dfd65731dc4f Besar Wicaksono 2022-11-11  613   */
> > e37dfd65731dc4f Besar Wicaksono 2022-11-11  614  static bool arm_cspmu_=
validate_group(struct perf_event *event)
> > e37dfd65731dc4f Besar Wicaksono 2022-11-11  615  {
> > e37dfd65731dc4f Besar Wicaksono 2022-11-11  616       struct perf_event=
 *sibling, *leader =3D event->group_leader;
> > e37dfd65731dc4f Besar Wicaksono 2022-11-11  617       struct arm_cspmu_=
hw_events fake_hw_events;
> > e37dfd65731dc4f Besar Wicaksono 2022-11-11  618
> > e37dfd65731dc4f Besar Wicaksono 2022-11-11  619       if (event->group_=
leader =3D=3D event)
> > e37dfd65731dc4f Besar Wicaksono 2022-11-11  620               return tr=
ue;
> > e37dfd65731dc4f Besar Wicaksono 2022-11-11  621
> > e37dfd65731dc4f Besar Wicaksono 2022-11-11  622       memset(&fake_hw_e=
vents, 0, sizeof(fake_hw_events));
> > e37dfd65731dc4f Besar Wicaksono 2022-11-11  623
> > e37dfd65731dc4f Besar Wicaksono 2022-11-11  624       if (!arm_cspmu_va=
lidate_event(event->pmu, &fake_hw_events, leader))
> > e37dfd65731dc4f Besar Wicaksono 2022-11-11  625               return fa=
lse;
> > e37dfd65731dc4f Besar Wicaksono 2022-11-11  626
> > e37dfd65731dc4f Besar Wicaksono 2022-11-11 @627       for_each_sibling_=
event(sibling, leader) {
> > e37dfd65731dc4f Besar Wicaksono 2022-11-11  628               if (!arm_=
cspmu_validate_event(event->pmu, &fake_hw_events,
> > e37dfd65731dc4f Besar Wicaksono 2022-11-11  629                        =
                         sibling))
> > e37dfd65731dc4f Besar Wicaksono 2022-11-11  630                       r=
eturn false;
> > e37dfd65731dc4f Besar Wicaksono 2022-11-11  631       }
> > e37dfd65731dc4f Besar Wicaksono 2022-11-11  632
> > e37dfd65731dc4f Besar Wicaksono 2022-11-11  633       return arm_cspmu_=
validate_event(event->pmu, &fake_hw_events, event);
> > e37dfd65731dc4f Besar Wicaksono 2022-11-11  634  }
> > e37dfd65731dc4f Besar Wicaksono 2022-11-11  635
> >
> > :::::: The code at line 627 was first introduced by commit
> > :::::: e37dfd65731dc4f001fa7dfa7f705e6840017d5a perf: arm_cspmu: Add su=
pport for ARM CoreSight PMU driver
> >
> > :::::: TO: Besar Wicaksono <bwicaksono@nvidia.com>
> > :::::: CC: Will Deacon <will@kernel.org>
> >
