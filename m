Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737207B86AF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbjJDRgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243845AbjJDRa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:30:57 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB933E5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 10:30:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so91544f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 10:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696440650; x=1697045450; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zvrXWY1QpQnW0edLxa6ocHxSKKIvEAzmMKl87ie/2wE=;
        b=zCp8skS95XSesJBLqzdZhNcG1l4Q203WxqqyfiLHy5EsPJYqm/5FnrVeDfXMNCc8uz
         cSX66DlqMk0wZwviLJWkGTDlDv395/GAyAf7Q1OhlUmacdRqNnGaZavxjH2cfq+V4dBL
         h/o1HuDgKNT206WEdcfHUXCaWYINbOq5c0KwoGWlHiAwr9AfJYm4Sw2ov1L9dA16DbPn
         yVx+4hMdlcFSJ8i4hQk3fioPlqamC6iQ76+vgzNqexHgCiP/DJQKL279jaMUyk35LP7R
         9rRfqKUcGJ5CzgBkixUrzK5M5b+shHbPIc8Y9G5wnLP5glvegNm+0LAsSnNaL8Ckc5CD
         t3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696440650; x=1697045450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zvrXWY1QpQnW0edLxa6ocHxSKKIvEAzmMKl87ie/2wE=;
        b=ArHKKezgRLttUZ3qlX2+0uw48nS1OADIubQuGrEIjnkDWKYKbn3iVHJITYFOKX0eEi
         LlWCFtjdub1I3JAoDmsBjbsLfUJ4xPvJkZPU2FmNDufD8x1HyHuR9SFAftRwV6OHwC/6
         lFwRg1MsYpThtUm2uHpvctKnDq9wLJleCRht9YP97/o18PHU6rPnNzuxWRk8hjlk42Jt
         mg3hXttCuT/dHVyH33Rru21+8eMadXOgKg3uhlEeRRAjdhomQP0jYVSuDlcWLK8RmYIR
         kdKxb2c8BlLVcJz1sP3lbw/y+rFo8BO+KjZov0pFFaB0HyDiXtXENYcfNjc4NBfpwykC
         HZqg==
X-Gm-Message-State: AOJu0YxihC9U1sGXMEiT5JBMeXE3gFgjCigR9ueGec3ZQyviwImv1TBf
        WcerOdAMBEXRi1IdwMQdnFYn8QGMLahBPlFdS40/Aw==
X-Google-Smtp-Source: AGHT+IGfMDyfRamGtlieUxyA2xrAhzUElGO1tjVKYMovnF3/GP3iETWYohsJHn0JsV5ro8l31i4gnkDvxMFEJLEecgo=
X-Received: by 2002:a5d:680d:0:b0:317:6ef1:7939 with SMTP id
 w13-20020a5d680d000000b003176ef17939mr2930753wru.23.1696440650250; Wed, 04
 Oct 2023 10:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230906124756.3480579-1-a-nandan@ti.com> <ZP9ELdOQ9WMj2Rxd@p14s> <6605ac2e-6217-e554-2456-20f35500683d@ti.com>
In-Reply-To: <6605ac2e-6217-e554-2456-20f35500683d@ti.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 4 Oct 2023 11:30:38 -0600
Message-ID: <CANLsYky9Mz7FeJjU-jo9q2QrkPFnHR+_8a97iT+SGizR_-Z+rg@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: k3-r5: Wait for core0 power-up before
 powering up core1
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Bjorn Andersson <andersson@kernel.org>,
        Suman Anna <s-anna@ti.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Devarsh Thakkar <devarsht@ti.com>,
        Hari Nagalla <hnagalla@ti.com>, Udit Kumar <u-kumar1@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2023 at 07:51, Apurva Nandan <a-nandan@ti.com> wrote:
>
> Hi Mathieu,
>
> On 11/09/23 22:15, Mathieu Poirier wrote:
> > Hi Apurva,
> >
> > On Wed, Sep 06, 2023 at 06:17:56PM +0530, Apurva Nandan wrote:
> >> PSC controller has a limitation that it can only power-up the second core
> >> when the first core is in ON state. Power-state for core0 should be equal
> >> to or higher than core1, else the kernel is seen hanging during rproc
> >> loading.
> >>
> >> Make the powering up of cores sequential, by waiting for the current core
> >> to power-up before proceeding to the next core, with a timeout of 2sec.
> >> Add a wait queue event in k3_r5_cluster_rproc_init call, that will wait
> >> for the current core to be released from reset before proceeding with the
> >> next core.
> >>
> >> Fixes: 6dedbd1d5443 ("remoteproc: k3-r5: Add a remoteproc driver for R5F subsystem")
> >>
> >> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> >> ---
> >>
> >>   kpv report: https://gist.githubusercontent.com/apurvanandan1997/feb3b304121c265b7827be43752b7ae8/raw
> >>
> >>   drivers/remoteproc/ti_k3_r5_remoteproc.c | 23 +++++++++++++++++++++++
> >>   1 file changed, 23 insertions(+)
> >>
> >> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> >> index ad3415a3851b..ba5e503f7c9c 100644
> >> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> >> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> >> @@ -103,12 +103,14 @@ struct k3_r5_soc_data {
> >>    * @dev: cached device pointer
> >>    * @mode: Mode to configure the Cluster - Split or LockStep
> >>    * @cores: list of R5 cores within the cluster
> >> + * @core_transition: wait queue to sync core state changes
> >>    * @soc_data: SoC-specific feature data for a R5FSS
> >>    */
> >>   struct k3_r5_cluster {
> >>      struct device *dev;
> >>      enum cluster_mode mode;
> >>      struct list_head cores;
> >> +    wait_queue_head_t core_transition;
> >>      const struct k3_r5_soc_data *soc_data;
> >>   };
> >>
> >> @@ -128,6 +130,7 @@ struct k3_r5_cluster {
> >>    * @atcm_enable: flag to control ATCM enablement
> >>    * @btcm_enable: flag to control BTCM enablement
> >>    * @loczrama: flag to dictate which TCM is at device address 0x0
> >> + * @released_from_reset: flag to signal when core is out of reset
> >>    */
> >>   struct k3_r5_core {
> >>      struct list_head elem;
> >> @@ -144,6 +147,7 @@ struct k3_r5_core {
> >>      u32 atcm_enable;
> >>      u32 btcm_enable;
> >>      u32 loczrama;
> >> +    bool released_from_reset;
> >>   };
> >>
> >>   /**
> >> @@ -460,6 +464,8 @@ static int k3_r5_rproc_prepare(struct rproc *rproc)
> >>                      ret);
> >>              return ret;
> >>      }
> >> +    core->released_from_reset = true;
> >> +    wake_up_interruptible(&cluster->core_transition);
> >>
> >>      /*
> >>       * Newer IP revisions like on J7200 SoCs support h/w auto-initialization
> >> @@ -1140,6 +1146,7 @@ static int k3_r5_rproc_configure_mode(struct k3_r5_rproc *kproc)
> >>              return ret;
> >>      }
> >>
> >> +    core->released_from_reset = c_state;
> >>      ret = ti_sci_proc_get_status(core->tsp, &boot_vec, &cfg, &ctrl,
> >>                                   &stat);
> >>      if (ret < 0) {
> >> @@ -1280,6 +1287,21 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
> >>                  cluster->mode == CLUSTER_MODE_SINGLECPU ||
> >>                  cluster->mode == CLUSTER_MODE_SINGLECORE)
> >>                      break;
> >> +
> >> +            /* R5 cores require to be powered on sequentially, core0
> >> +             * should be in higher power state than core1 in a cluster
> >> +             * So, wait for current core to power up before proceeding
> >> +             * to next core and put timeout of 2sec for each core.
> >> +             */
> > Wrong multi-line comment format.
> Okay will fix this.
> >> +            ret = wait_event_interruptible_timeout(cluster->core_transition,
> >> +                                                   core->released_from_reset,
> >> +                                                   msecs_to_jiffies(2000));
> >> +            if (ret <= 0) {
> >> +                    dev_err(dev,
> >> +                            "Timed out waiting for %s core to power up!\n",
> >> +                            rproc->name);
> >> +                    return ret;
> >> +            }
> >  From my perspective, this is needed because rproc_auto_boot_callback() for core1
> > can be called before core0 due to thread execution order.  Am I correct?
> Yes
> > If so please add this explanation to the comment you have above.  Also, let's
> > say a user decides to switch both cores off after reboot.  At that time, what
> > prevents a user from switching on core1 before core0 via sysfs?
> Okay, will add the explanation.
> Currently, adding support for graceful shutdown is in progress. As of
> now in order
> to stop/start core or change firmware, we recommend users to restart the
> OS.

You will need to address access via debugfs and sysfs if you want this
patch to move forward.

> > Thanks,
> > Mathieu
> >
> >>      }
> >>
> >>      return 0;
> >> @@ -1709,6 +1731,7 @@ static int k3_r5_probe(struct platform_device *pdev)
> >>      cluster->dev = dev;
> >>      cluster->soc_data = data;
> >>      INIT_LIST_HEAD(&cluster->cores);
> >> +    init_waitqueue_head(&cluster->core_transition);
> >>
> >>      ret = of_property_read_u32(np, "ti,cluster-mode", &cluster->mode);
> >>      if (ret < 0 && ret != -EINVAL) {
> >> --
> >> 2.34.1
> >>
