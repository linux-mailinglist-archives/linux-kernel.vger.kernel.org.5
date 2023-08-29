Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF3F78C25D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 12:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbjH2KhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbjH2Kgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:36:45 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42586199
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:36:42 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-79414715edeso971614241.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693305401; x=1693910201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hVBkVLH3QC7fHZ/BEssrc+xOo41yz88ko37ylycWuSU=;
        b=nETByJ1aa8cIYUWQbOS4D/ZJLgtAcE17So4tLSCO2AI0v8zsS9r0J7i1o10MrVinUD
         jh9aPRpFjwK29fS65/wBJpt8ojCEfb1vjWz1gDVnxxuG7zmYwxFfX9OUu92DTBHMynrC
         9GS/meqbm92mrtUGt4Rz2n1dzhhOJtp9me7y2NvDQWynXDNq/NGP4DlSFUy23omBoJHX
         k4MpUe0cOGitK0YP6fR7j4MgQcnEF4+o0flBLOjtBXzyXFKPULr6ZWK/BAFfbWdAFWpQ
         FduhvcMOlvHFkaDF73u4C0CvOQSfgn9H3aTNACnthq3EP6qDanXPM2mVVP+zwSdB3n4b
         /+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693305401; x=1693910201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hVBkVLH3QC7fHZ/BEssrc+xOo41yz88ko37ylycWuSU=;
        b=OeRF1WfcyPYeh5OPbprcQxg4guE4vVjDmIocWTcwvCSPBwGz1VImHuAG9w7iAtWD2W
         Xf0Ud5kjQa0w8jpQMmb4qu6mEc3ApcpzuPTPHCZhLurefdd7EKpzkohDubiIIiXYsEDO
         jEdjuTHMJQEAe5HfBYdkVfP20lhtMGm+NHD518VGSabPrRa4ERpoIdSPARMwnv1VY93+
         LCzkZdn87AgkRhxsuEGIkFRMhE9oEKU7I5J7BntMDD7yQ1gJgfdaLCmmR/RkBZixcieG
         tnRo+MnTDMzov0LP9lrD276ShmHHlDB/vFnhne6FBVZnwrumst+kW/f3DKznJ/BA7spN
         LWlw==
X-Gm-Message-State: AOJu0YyOYKQKeUZz2rIsXurFHSbyTySv4D15Ip2yfEuI/FCEn0FMwGii
        iH78ZU/Hdp4oqnTDrSYR94X2kh+3GWGbZTcdqUVvew==
X-Google-Smtp-Source: AGHT+IHrytUJH5I8zDaQ5yGNluZPFNS9cgWFNHOsNNTu4Do+ZfLoGsBEhECaztap0PP4+h41sb3j5k/P8KpBhAaNXrM=
X-Received: by 2002:a05:6102:b09:b0:44f:c528:6252 with SMTP id
 b9-20020a0561020b0900b0044fc5286252mr248799vst.2.1693305401145; Tue, 29 Aug
 2023 03:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230824153233.1006420-1-dianders@chromium.org> <20230824083012.v11.1.I1223c11c88937bd0cbd9b086d4ef216985797302@changeid>
In-Reply-To: <20230824083012.v11.1.I1223c11c88937bd0cbd9b086d4ef216985797302@changeid>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 29 Aug 2023 16:06:30 +0530
Message-ID: <CAFA6WYO7u5WTS8dfzqPUcLpHWTH+3sMNVL-9ob0stHE_nJw24Q@mail.gmail.com>
Subject: Re: [PATCH v11 1/6] irqchip/gic-v3: Enable support for SGIs to act as NMIs
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kgdb-bugreport@lists.sourceforge.net,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-perf-users@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, ito-yuichi@fujitsu.com,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023 at 21:03, Douglas Anderson <dianders@chromium.org> wrote:
>
> As of commit 6abbd6988971 ("irqchip/gic, gic-v3: Make SGIs use
> handle_percpu_devid_irq()") SGIs are treated the same as PPIs/EPPIs
> and use handle_percpu_devid_irq() by default. Unfortunately,
> handle_percpu_devid_irq() isn't NMI safe, and so to run in an NMI
> context those should use handle_percpu_devid_fasteoi_nmi().
>
> In order to accomplish this, we just have to make room for SGIs in the
> array of refcounts that keeps track of which interrupts are set as
> NMI. We also rename the array and create a new indexing scheme that
> accounts for SGIs.
>
> Also, enable NMI support prior to gic_smp_init() as allocation of SGIs
> as IRQs/NMIs happen as part of this routine.
>
> Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> In v10 I removed the previous Reviewed-by and Tested-by tags since the
> patch contents changed pretty drastically.
>
> I'll also note that this change is a little more black magic to me
> than others in this series. I don't have a massive amounts of
> familiarity with all the moving parts of gic-v3, so I mostly just
> followed Mark Rutland's advice [1]. Please pay extra attention to make
> sure I didn't do anything too terrible.

The changes look good to me. I am not sure if my review tag will be
valuable here since I am a co-developer here.

-Sumit

>
> Mark's advice wasn't a full patch and I ended up doing a bit of work
> to translate it to reality, so I did not add him as "Co-developed-by"
> here. Mark: if you would like this tag then please provide it and your
> Signed-off-by. I certainly won't object.
>
> [1] https://lore.kernel.org/r/ZNC-YRQopO0PaIIo@FVFF77S0Q05N.cambridge.arm.com
>
> (no changes since v10)
>
> Changes in v10:
> - Rewrite as needed for 5.11+ as per Mark Rutland and Sumit.
>
>  drivers/irqchip/irq-gic-v3.c | 54 ++++++++++++++++++++++++------------
>  1 file changed, 36 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index eedfa8e9f077..49d18cf3f636 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -78,6 +78,8 @@ static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
>  #define GIC_LINE_NR    min(GICD_TYPER_SPIS(gic_data.rdists.gicd_typer), 1020U)
>  #define GIC_ESPI_NR    GICD_TYPER_ESPIS(gic_data.rdists.gicd_typer)
>
> +#define SGI_NR         16
> +
>  /*
>   * The behaviours of RPR and PMR registers differ depending on the value of
>   * SCR_EL3.FIQ, and the behaviour of non-secure priority registers of the
> @@ -125,8 +127,8 @@ EXPORT_SYMBOL(gic_nonsecure_priorities);
>                 __priority;                                             \
>         })
>
> -/* ppi_nmi_refs[n] == number of cpus having ppi[n + 16] set as NMI */
> -static refcount_t *ppi_nmi_refs;
> +/* rdist_nmi_refs[n] == number of cpus having the rdist interrupt n set as NMI */
> +static refcount_t *rdist_nmi_refs;
>
>  static struct gic_kvm_info gic_v3_kvm_info __initdata;
>  static DEFINE_PER_CPU(bool, has_rss);
> @@ -519,9 +521,22 @@ static u32 __gic_get_ppi_index(irq_hw_number_t hwirq)
>         }
>  }
>
> -static u32 gic_get_ppi_index(struct irq_data *d)
> +static u32 __gic_get_rdist_idx(irq_hw_number_t hwirq)
> +{
> +       switch (__get_intid_range(hwirq)) {
> +       case SGI_RANGE:
> +       case PPI_RANGE:
> +               return hwirq;
> +       case EPPI_RANGE:
> +               return hwirq - EPPI_BASE_INTID + 32;
> +       default:
> +               unreachable();
> +       }
> +}
> +
> +static u32 gic_get_rdist_idx(struct irq_data *d)
>  {
> -       return __gic_get_ppi_index(d->hwirq);
> +       return __gic_get_rdist_idx(d->hwirq);
>  }
>
>  static int gic_irq_nmi_setup(struct irq_data *d)
> @@ -545,11 +560,14 @@ static int gic_irq_nmi_setup(struct irq_data *d)
>
>         /* desc lock should already be held */
>         if (gic_irq_in_rdist(d)) {
> -               u32 idx = gic_get_ppi_index(d);
> +               u32 idx = gic_get_rdist_idx(d);
>
> -               /* Setting up PPI as NMI, only switch handler for first NMI */
> -               if (!refcount_inc_not_zero(&ppi_nmi_refs[idx])) {
> -                       refcount_set(&ppi_nmi_refs[idx], 1);
> +               /*
> +                * Setting up a percpu interrupt as NMI, only switch handler
> +                * for first NMI
> +                */
> +               if (!refcount_inc_not_zero(&rdist_nmi_refs[idx])) {
> +                       refcount_set(&rdist_nmi_refs[idx], 1);
>                         desc->handle_irq = handle_percpu_devid_fasteoi_nmi;
>                 }
>         } else {
> @@ -582,10 +600,10 @@ static void gic_irq_nmi_teardown(struct irq_data *d)
>
>         /* desc lock should already be held */
>         if (gic_irq_in_rdist(d)) {
> -               u32 idx = gic_get_ppi_index(d);
> +               u32 idx = gic_get_rdist_idx(d);
>
>                 /* Tearing down NMI, only switch handler for last NMI */
> -               if (refcount_dec_and_test(&ppi_nmi_refs[idx]))
> +               if (refcount_dec_and_test(&rdist_nmi_refs[idx]))
>                         desc->handle_irq = handle_percpu_devid_irq;
>         } else {
>                 desc->handle_irq = handle_fasteoi_irq;
> @@ -1279,10 +1297,10 @@ static void gic_cpu_init(void)
>         rbase = gic_data_rdist_sgi_base();
>
>         /* Configure SGIs/PPIs as non-secure Group-1 */
> -       for (i = 0; i < gic_data.ppi_nr + 16; i += 32)
> +       for (i = 0; i < gic_data.ppi_nr + SGI_NR; i += 32)
>                 writel_relaxed(~0, rbase + GICR_IGROUPR0 + i / 8);
>
> -       gic_cpu_config(rbase, gic_data.ppi_nr + 16, gic_redist_wait_for_rwp);
> +       gic_cpu_config(rbase, gic_data.ppi_nr + SGI_NR, gic_redist_wait_for_rwp);
>
>         /* initialise system registers */
>         gic_cpu_sys_reg_init();
> @@ -1939,12 +1957,13 @@ static void gic_enable_nmi_support(void)
>                 return;
>         }
>
> -       ppi_nmi_refs = kcalloc(gic_data.ppi_nr, sizeof(*ppi_nmi_refs), GFP_KERNEL);
> -       if (!ppi_nmi_refs)
> +       rdist_nmi_refs = kcalloc(gic_data.ppi_nr + SGI_NR,
> +                                sizeof(*rdist_nmi_refs), GFP_KERNEL);
> +       if (!rdist_nmi_refs)
>                 return;
>
> -       for (i = 0; i < gic_data.ppi_nr; i++)
> -               refcount_set(&ppi_nmi_refs[i], 0);
> +       for (i = 0; i < gic_data.ppi_nr + SGI_NR; i++)
> +               refcount_set(&rdist_nmi_refs[i], 0);
>
>         pr_info("Pseudo-NMIs enabled using %s ICC_PMR_EL1 synchronisation\n",
>                 gic_has_relaxed_pmr_sync() ? "relaxed" : "forced");
> @@ -2061,6 +2080,7 @@ static int __init gic_init_bases(phys_addr_t dist_phys_base,
>
>         gic_dist_init();
>         gic_cpu_init();
> +       gic_enable_nmi_support();
>         gic_smp_init();
>         gic_cpu_pm_init();
>
> @@ -2073,8 +2093,6 @@ static int __init gic_init_bases(phys_addr_t dist_phys_base,
>                         gicv2m_init(handle, gic_data.domain);
>         }
>
> -       gic_enable_nmi_support();
> -
>         return 0;
>
>  out_free:
> --
> 2.42.0.rc1.204.g551eb34607-goog
>
