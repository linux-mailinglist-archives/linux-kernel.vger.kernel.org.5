Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE807542DC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbjGNSyH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Jul 2023 14:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbjGNSyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:54:05 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BDF3586;
        Fri, 14 Jul 2023 11:54:02 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-991f9148334so51459166b.1;
        Fri, 14 Jul 2023 11:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689360841; x=1689965641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9B/F9N2Gv0nlKZ4Pjku6eVDXCPCkPx+J5+8KkbLiGiY=;
        b=HZXLGzpH3vPpK7NRw3FD5rPViSg3WOZy+nqv9WMjT7G2Hq7w5vmDx2Ey8sWD1xlNbW
         X6KGPoZKoHUviU4bgetkMaeuGszg4RrZXkwFXg2KAHK5S7OQ8JJ80TkM/alab7H/FK6S
         kFmpkylOcxl7EZJ9O2tKiKFcPFcPQnDSTQw9FD2wHNAkr0enhQzt+DM7cVypYCNgHnI2
         eV78XGLnUUrh3VsTePn/HJwAVkzrlmV2O1tyJvRwlUrAB3p/Osv0SBG30LeelfJo2De8
         HWIVja0xc3TpeVYG/3gGMrRnp1JgBygD7ovD2QnpEMBP311LCAAck2P1f6HMdmOVUiN7
         7clg==
X-Gm-Message-State: ABy/qLYiR/qpZ2hQJs0w7p+b2G2i/dWACwk/+tgzOib9DcVVXDjgz75k
        NS79n+OfU30cMIW/j0ydWRKzfT/xAcWMlj9UBfI=
X-Google-Smtp-Source: APBJJlF43PZ1lXNODVSZ5tLMcK1J342n26C3wDGe2qLpc28UYX43wFxXrau7trMesO0FmTeAhdOBJDUWmhSkVS1o3IE=
X-Received: by 2002:a17:906:d4:b0:993:d88e:41e3 with SMTP id
 20-20020a17090600d400b00993d88e41e3mr3819919eji.4.1689360841175; Fri, 14 Jul
 2023 11:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230714174414.4054011-1-robh@kernel.org>
In-Reply-To: <20230714174414.4054011-1-robh@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Jul 2023 20:53:50 +0200
Message-ID: <CAJZ5v0giP7EXPdkcgXa0QP4nLg7ZutVcO60BMcQHSVdVAUDLjw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Explicitly include correct DT includes
To:     Rob Herring <robh@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 7:44 PM Rob Herring <robh@kernel.org> wrote:
>
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/cpufreq/armada-37xx-cpufreq.c  | 4 +---
>  drivers/cpufreq/mediatek-cpufreq-hw.c  | 3 ++-
>  drivers/cpufreq/ppc_cbe_cpufreq.c      | 2 +-
>  drivers/cpufreq/ppc_cbe_cpufreq_pmi.c  | 1 -
>  drivers/cpufreq/qcom-cpufreq-nvmem.c   | 1 -
>  drivers/cpufreq/scpi-cpufreq.c         | 2 +-
>  drivers/cpufreq/sti-cpufreq.c          | 2 +-
>  drivers/cpufreq/ti-cpufreq.c           | 2 +-
>  drivers/cpufreq/vexpress-spc-cpufreq.c | 1 -
>  9 files changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
> index b74289a95a17..bea41ccabf1f 100644
> --- a/drivers/cpufreq/armada-37xx-cpufreq.c
> +++ b/drivers/cpufreq/armada-37xx-cpufreq.c
> @@ -14,10 +14,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/mfd/syscon.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> -#include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_opp.h>
>  #include <linux/regmap.h>
> diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
> index b22f5cc8a463..c93e14eb6221 100644
> --- a/drivers/cpufreq/mediatek-cpufreq-hw.c
> +++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
> @@ -10,8 +10,9 @@
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_address.h>
> +#include <linux/of.h>
>  #include <linux/of_platform.h>
> +#include <linux/platform_device.h>
>  #include <linux/slab.h>
>
>  #define LUT_MAX_ENTRIES                        32U
> diff --git a/drivers/cpufreq/ppc_cbe_cpufreq.c b/drivers/cpufreq/ppc_cbe_cpufreq.c
> index e3313ce63b38..88afc49941b7 100644
> --- a/drivers/cpufreq/ppc_cbe_cpufreq.c
> +++ b/drivers/cpufreq/ppc_cbe_cpufreq.c
> @@ -9,7 +9,7 @@
>
>  #include <linux/cpufreq.h>
>  #include <linux/module.h>
> -#include <linux/of_platform.h>
> +#include <linux/of.h>
>
>  #include <asm/machdep.h>
>  #include <asm/cell-regs.h>
> diff --git a/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c b/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
> index 4fba3637b115..6f0c32592416 100644
> --- a/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
> +++ b/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
> @@ -11,7 +11,6 @@
>  #include <linux/types.h>
>  #include <linux/timer.h>
>  #include <linux/init.h>
> -#include <linux/of_platform.h>
>  #include <linux/pm_qos.h>
>  #include <linux/slab.h>
>
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index a88b6fe5db50..4590c2570086 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -22,7 +22,6 @@
>  #include <linux/module.h>
>  #include <linux/nvmem-consumer.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_opp.h>
> diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
> index fd2c16821d54..ac719aca49b7 100644
> --- a/drivers/cpufreq/scpi-cpufreq.c
> +++ b/drivers/cpufreq/scpi-cpufreq.c
> @@ -14,7 +14,7 @@
>  #include <linux/cpumask.h>
>  #include <linux/export.h>
>  #include <linux/module.h>
> -#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm_opp.h>
>  #include <linux/scpi_protocol.h>
>  #include <linux/slab.h>
> diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
> index 1a63aeea8711..9c542e723a15 100644
> --- a/drivers/cpufreq/sti-cpufreq.c
> +++ b/drivers/cpufreq/sti-cpufreq.c
> @@ -13,7 +13,7 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm_opp.h>
>  #include <linux/regmap.h>
>
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index d5cd2fd25cad..3c37d7899660 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -12,7 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/of.h>
> -#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm_opp.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
> index d295f405c4bb..865e50164803 100644
> --- a/drivers/cpufreq/vexpress-spc-cpufreq.c
> +++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
> @@ -18,7 +18,6 @@
>  #include <linux/device.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> -#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_opp.h>
>  #include <linux/slab.h>
> --
> 2.40.1
>
