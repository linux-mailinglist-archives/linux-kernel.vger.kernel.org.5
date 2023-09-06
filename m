Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2A37939BB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238303AbjIFKYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjIFKYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:24:03 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DDC10C7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 03:23:58 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d7ba4c5f581so2974327276.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 03:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693995838; x=1694600638; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ukp5s+yUao7QKt/jBc8w9DnD0YtYgjkSUOZArAv43DA=;
        b=eYJIAgHE/m7RFBK2N5uBnpqIfEoRV7KkxHLShf3uIr2PC2J0tMQQHHpWi/G6HtKr4a
         4t1msnPKdxZSlp+5ad1nkEOQnb6C6p2EBuokbumn8OhLVLmpos365/b03Mh41UojC1Se
         PX5cjc4OrKXXEArm6bZd1zO93YDq3zqDpBnZhWicrkvujopZr8UKkWaCqao93ti4HVoh
         h9aRH5GlrJrzOQyJRMmes//X29LJ2G5BBXwdycOBZWpogObwBxBfxpQVZjxW6ryD2FIj
         qNXjijmhkAa/xJDBuNwpm6yFH50nmgwgRgisd0dgJjKBLQBtWNJ3nEzyxBNQfNlBRkVm
         YKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693995838; x=1694600638;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ukp5s+yUao7QKt/jBc8w9DnD0YtYgjkSUOZArAv43DA=;
        b=EZsPy88rEqTupCY64BcAJmj9tZC3lBhySd5+3L5KDOBAj4mAzfyIgjDUgwvREmcz42
         f6cNA4p2L6q8KT9yVU78YVQvbW08KbzUBZdDgDLh2IdNRCyDwSBJJ4s89uO9LyIU2YXu
         OECiNJphCMMJiMd0yX5uKHGN86LbH6pMuD9cKvk8AzcLSEwObnrExz9utYkoujoSeZLc
         a1Ifh5C7g809nUbzj9S5qc7LVaeXtY5CC4UxEEN72kHBdlMZmQ+YkxNNiufp9FSkXkDY
         csTPMAVZqSFzsxOefknAdiOs2hevwY+uVK7YNkpBBK8mG7zMH+6dSVooz5t9T7ine7Zx
         QwMA==
X-Gm-Message-State: AOJu0YwWoIdmp3honz1lX8LJnwW3xOuoqDE4wHNdOHZPfqcahT2DMTOw
        3cJaV29Lbcls5idlbz+1T668vGxEYaCr2u+1TRxqsg==
X-Google-Smtp-Source: AGHT+IEXapV3LzfxCKINXMoXC3jaR2W2NaMIm408ir2exxJSnl6Laf3IB2GWwIr5RWv4+zYb/g8BKK39Z3eNg7JRnk4=
X-Received: by 2002:a25:8a03:0:b0:d7f:cdc8:e17a with SMTP id
 g3-20020a258a03000000b00d7fcdc8e17amr259484ybl.28.1693995838071; Wed, 06 Sep
 2023 03:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org> <20230217-topic-cpr3h-v14-8-9fd23241493d@linaro.org>
In-Reply-To: <20230217-topic-cpr3h-v14-8-9fd23241493d@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 6 Sep 2023 12:23:21 +0200
Message-ID: <CAPDyKFrNprXpdQBEzezyOJg6NJ8LLarZQV_mnQn5QyCrNmsRUw@mail.gmail.com>
Subject: Re: [PATCH v14 8/9] soc: qcom: Add support for Core Power Reduction
 v3, v4 and Hardened
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 at 13:42, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>
> This commit introduces a new driver, based on the one for cpr v1,
> to enable support for the newer Qualcomm Core Power Reduction
> hardware, known downstream as CPR3, CPR4 and CPRh, and support
> for MSM8998 and SDM630 CPU power reduction.
>
> In these new versions of the hardware, support for various new
> features was introduced, including voltage reduction for the GPU,
> security hardening and a new way of controlling CPU DVFS,
> consisting in internal communication between microcontrollers,
> specifically the CPR-Hardened and the Operating State Manager.
>
> The CPR v3, v4 and CPRh are present in a broad range of SoCs,
> from the mid-range to the high end ones including, but not limited
> to, MSM8953/8996/8998, SDM630/636/660/845.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> [Konrad: rebase, apply review comments]
> Tested-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

[...]

> +
> +static unsigned int cpr_get_performance_state(struct generic_pm_domain *genpd,
> +                                             struct dev_pm_opp *opp)
> +{
> +       return dev_pm_opp_get_level(opp);
> +}

The OPP core doesn't use pm_genpd_opp_to_performance_state() anymore,
but defaults to use dev_pm_opp_get_level(). Meaning that you can drop
the above function.

I am planning to remove pm_genpd_opp_to_performance_state(), in the
next cycle, as it's no longer needed.

> +
> +static int cpr_power_off(struct generic_pm_domain *domain)
> +{
> +       struct cpr_thread *thread = container_of(domain, struct cpr_thread, pd);
> +
> +       return cpr_disable(thread);
> +}
> +
> +static int cpr_power_on(struct generic_pm_domain *domain)
> +{
> +       struct cpr_thread *thread = container_of(domain, struct cpr_thread, pd);
> +
> +       return cpr_enable(thread);
> +}
> +
> +static void cpr_pd_detach_dev(struct generic_pm_domain *domain,
> +                             struct device *dev)
> +{
> +       struct cpr_thread *thread = container_of(domain, struct cpr_thread, pd);
> +       struct cpr_drv *drv = thread->drv;
> +
> +       mutex_lock(&drv->lock);
> +
> +       dev_dbg(drv->dev, "detach callback for: %s\n", dev_name(dev));
> +       thread->attached_cpu_dev = NULL;
> +
> +       mutex_unlock(&drv->lock);

Don't you need to do some additional cleanup here? Like calling
dev_pm_opp_of_remove_table() for example?

> +}
> +
> +static int cpr_pd_attach_dev(struct generic_pm_domain *domain,
> +                            struct device *dev)
> +{
> +       struct cpr_thread *thread = container_of(domain, struct cpr_thread, pd);
> +       struct cpr_drv *drv = thread->drv;
> +       const struct acc_desc *acc_desc = drv->acc_desc;
> +       bool cprh_opp_remove_table = false;
> +       int ret = 0;
> +
> +       mutex_lock(&drv->lock);
> +
> +       dev_dbg(drv->dev, "attach callback for: %s\n", dev_name(dev));
> +
> +       /*
> +        * This driver only supports scaling voltage for a CPU cluster
> +        * where all CPUs in the cluster share a single regulator.
> +        * Therefore, save the struct device pointer only for the first
> +        * CPU device that gets attached. There is no need to do any
> +        * additional initialization when further CPUs get attached.
> +        * This is not an error condition.
> +        */
> +       if (thread->attached_cpu_dev)
> +               goto unlock;
> +
> +       /*
> +        * cpr_scale_voltage() requires the direction (if we are changing
> +        * to a higher or lower OPP). The first time
> +        * cpr_set_performance_state() is called, there is no previous
> +        * performance state defined. Therefore, we call
> +        * cpr_find_initial_corner() that gets the CPU clock frequency
> +        * set by the bootloader, so that we can determine the direction
> +        * the first time cpr_set_performance_state() is called.
> +        */
> +       thread->cpu_clk = devm_clk_get(dev, NULL);
> +       if (drv->desc->cpr_type < CTRL_TYPE_CPRH && IS_ERR(thread->cpu_clk)) {
> +               ret = PTR_ERR(thread->cpu_clk);
> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(drv->dev, "could not get cpu clk: %d\n", ret);
> +               goto unlock;
> +       }
> +       thread->attached_cpu_dev = dev;
> +
> +       /*
> +        * We are exporting the APM and MEM-ACC thresholds to the caller;
> +        * while APM is necessary in the CPU CPR case, MEM-ACC may not be,
> +        * depending on the SoC and on fuses.
> +        * Initialize both to an invalid value, so that the caller can check
> +        * if they got calculated or read from fuses in this driver.
> +        */
> +       thread->ext_data.apm_threshold_uV = -1;
> +       thread->ext_data.mem_acc_threshold_uV = -1;
> +       dev_set_drvdata(thread->attached_cpu_dev, &thread->ext_data);
> +
> +       dev_dbg(drv->dev, "using cpu clk from: %s\n",
> +               dev_name(thread->attached_cpu_dev));
> +
> +       /*
> +        * Everything related to (virtual) corners has to be initialized
> +        * here, when attaching to the power domain, since we need to know
> +        * the maximum frequency for each fuse corner, and this is only
> +        * available after the cpufreq driver has attached to us.
> +        * The reason for this is that we need to know the highest
> +        * frequency associated with each fuse corner.
> +        */
> +       ret = dev_pm_opp_get_opp_count(&thread->pd.dev);
> +       if (ret < 0) {
> +               dev_err(drv->dev, "could not get OPP count\n");
> +               thread->attached_cpu_dev = NULL;
> +               goto unlock;
> +       }
> +       thread->num_corners = ret;
> +
> +       thread->corners = devm_kcalloc(drv->dev,
> +                                      thread->num_corners +
> +                                      drv->extra_corners,
> +                                      sizeof(*thread->corners),
> +                                      GFP_KERNEL);
> +       if (!thread->corners) {
> +               ret = -ENOMEM;
> +               goto unlock;
> +       }
> +
> +       /*
> +        * If we are on CPR-Hardened we have to make sure that the attached
> +        * device has a OPP table installed, as we're going to modify it here
> +        * with our calculations based on qfprom values.
> +        */
> +       if (drv->desc->cpr_type == CTRL_TYPE_CPRH) {
> +               ret = dev_pm_opp_of_add_table(dev);
> +               if (ret && ret != -EEXIST) {
> +                       dev_err(drv->dev, "Cannot add table: %d\n", ret);
> +                       goto unlock;
> +               }
> +               cprh_opp_remove_table = true;
> +       }
> +
> +       ret = cpr3_corner_init(thread);
> +       if (ret)
> +               goto exit;
> +
> +       if (drv->desc->cpr_type < CTRL_TYPE_CPRH) {
> +               ret = cpr3_find_initial_corner(thread);
> +               if (ret)
> +                       goto exit;
> +
> +               if (acc_desc->config)
> +                       regmap_multi_reg_write(drv->tcsr, acc_desc->config,
> +                                              acc_desc->num_regs_per_fuse);
> +
> +               /* Enable ACC if required */
> +               if (acc_desc->enable_mask)
> +                       regmap_update_bits(drv->tcsr, acc_desc->enable_reg,
> +                                          acc_desc->enable_mask,
> +                                          acc_desc->enable_mask);
> +       }
> +       dev_info(drv->dev, "thread %d initialized with %u OPPs\n",
> +                thread->id, thread->num_corners);
> +exit:
> +       /*
> +        * If we are on CPRh and we reached an error condition, we installed
> +        * the OPP table but we haven't done any setup on it, nor we ever will.
> +        * In order to leave a clean state, remove the table.
> +        */
> +       if (ret && cprh_opp_remove_table)
> +               dev_pm_opp_of_remove_table(thread->attached_cpu_dev);
> +unlock:
> +       mutex_unlock(&drv->lock);
> +
> +       return ret;
> +}

[...]

> +/**
> + * cpr_thread_init() - Initialize CPR thread related parameters
> + * @drv: Main driver structure
> + * @tid: Thread ID
> + *
> + * Return: Zero for success, negative number on error
> + */
> +static int cpr_thread_init(struct cpr_drv *drv, int tid)
> +{
> +       const struct cpr_desc *desc = drv->desc;
> +       const struct cpr_thread_desc *tdesc = desc->threads[tid];
> +       struct cpr_thread *thread = &drv->threads[tid];
> +       bool pd_registered = false;
> +       int ret, i;
> +
> +       if (tdesc->step_quot_init_min > CPR3_CPR_STEP_QUOT_MIN_MASK ||
> +           tdesc->step_quot_init_max > CPR3_CPR_STEP_QUOT_MAX_MASK)
> +               return -EINVAL;
> +
> +       thread->id = tid;
> +       thread->drv = drv;
> +       thread->desc = tdesc;
> +       thread->fuse_corners = devm_kcalloc(drv->dev,
> +                                           tdesc->num_fuse_corners +
> +                                           drv->extra_corners,
> +                                           sizeof(*thread->fuse_corners),
> +                                           GFP_KERNEL);
> +       if (!thread->fuse_corners)
> +               return -ENOMEM;
> +
> +       thread->cpr_fuses = cpr_get_fuses(drv->dev, tid,
> +                                         tdesc->num_fuse_corners);
> +       if (IS_ERR(thread->cpr_fuses))
> +               return PTR_ERR(thread->cpr_fuses);
> +
> +       ret = cpr_populate_ring_osc_idx(thread->drv->dev, thread->fuse_corners,
> +                                       thread->cpr_fuses,
> +                                       tdesc->num_fuse_corners);
> +       if (ret)
> +               return ret;
> +
> +       ret = cpr_fuse_corner_init(thread);
> +       if (ret)
> +               return ret;
> +
> +       thread->pd.name = devm_kasprintf(drv->dev, GFP_KERNEL,
> +                                        "%s_thread%d",
> +                                        drv->dev->of_node->full_name,
> +                                        thread->id);
> +       if (!thread->pd.name)
> +               return -EINVAL;
> +
> +       thread->pd.power_off = cpr_power_off;
> +       thread->pd.power_on = cpr_power_on;
> +       thread->pd.opp_to_performance_state = cpr_get_performance_state;
> +       thread->pd.attach_dev = cpr_pd_attach_dev;
> +       thread->pd.detach_dev = cpr_pd_detach_dev;
> +
> +       /* CPR-Hardened performance states are managed in firmware */
> +       if (desc->cpr_type == CTRL_TYPE_CPRH)
> +               thread->pd.set_performance_state = cprh_dummy_set_performance_state;

The dummy function above always returns 0, without actually doing
anything. I am trying to understand the purpose of this.

Would you mind elaborating on this a bit?

> +       else
> +               thread->pd.set_performance_state = cpr_set_performance_state;
> +
> +       /* Anything later than CPR1 must be always-on for now */
> +       thread->pd.flags = GENPD_FLAG_ALWAYS_ON;
> +
> +       drv->cell_data.domains[tid] = &thread->pd;
> +
> +       ret = pm_genpd_init(&thread->pd, NULL, false);
> +       if (ret < 0)
> +               goto fail;
> +       else
> +               pd_registered = true;
> +
> +       /* On CPRhardened, the interrupts are managed in firmware */
> +       if (desc->cpr_type < CTRL_TYPE_CPRH) {
> +               INIT_WORK(&thread->restart_work, cpr_restart_worker);
> +
> +               ret = devm_request_threaded_irq(drv->dev, drv->irq,
> +                                               NULL, cpr_irq_handler,
> +                                               IRQF_ONESHOT |
> +                                               IRQF_TRIGGER_RISING,
> +                                               "cpr", drv);
> +               if (ret)
> +                       goto fail;
> +       }
> +
> +       return 0;
> +
> +fail:
> +       /* Unregister all previously registered genpds */
> +       for (i = tid - pd_registered; i >= 0; i--)
> +               pm_genpd_remove(&drv->threads[i].pd);
> +
> +       return ret;
> +}

[...]

> +
> +static int cpr_remove(struct platform_device *pdev)
> +{
> +       struct cpr_drv *drv = platform_get_drvdata(pdev);
> +       int i;
> +
> +       of_genpd_del_provider(pdev->dev.of_node);
> +
> +       for (i = 0; i < drv->desc->num_threads; i++) {
> +               cpr_ctl_disable(&drv->threads[i]);
> +               cpr_irq_set(&drv->threads[i], 0);
> +               pm_genpd_remove(&drv->threads[i].pd);
> +       }
> +
> +       debugfs_remove_recursive(drv->debugfs);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id cpr3_match_table[] = {
> +       { .compatible = "qcom,msm8998-cprh", .data = &msm8998_cpr_acc_desc },
> +       { .compatible = "qcom,sdm630-cprh", .data = &sdm630_cpr_acc_desc },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, cpr3_match_table);
> +
> +static struct platform_driver cpr3_driver = {
> +       .probe          = cpr_probe,
> +       .remove         = cpr_remove,

There is this .remove_new callback, that you probably should use instead.

> +       .driver         = {
> +               .name   = "qcom-cpr3",
> +               .of_match_table = cpr3_match_table,
> +       },
> +};
> +module_platform_driver(cpr3_driver)
> +

[...]

Note that, this was mostly a drive-by-review, looking at the genpd
provider specific parts. In general this looks good to me, other than
the minor comments I had above.

Kind regards
Uffe
