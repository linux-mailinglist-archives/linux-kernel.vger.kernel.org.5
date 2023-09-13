Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4660479F581
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 01:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjIMXaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 19:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjIMXaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 19:30:11 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABAF1BD1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 16:30:06 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c1f8aaab9aso2799485ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 16:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694647806; x=1695252606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D8BEuyRIkqA0kbODSrFEJ9LM8ANlZ5MuwmNVEnUG8nE=;
        b=I4RzppyNU7YncV55OkMU8+X7/vBgwDYhwMxCBR4uY4skKChXESvRr+7E+KlXzjFx4B
         GiF6oG6O3ISAtK24b99DyXtYHSwHIjVWf54C8Is5hE+yI2PLfEAjTwZraqo/yI8bEQmt
         c+IxHuUrPaEZu7du/wbjChuhUgZamRR80fvL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694647806; x=1695252606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8BEuyRIkqA0kbODSrFEJ9LM8ANlZ5MuwmNVEnUG8nE=;
        b=BAqJiAvhxfF08UCXAzTENhYQ+LXap2emAyiikp1U4etrp3x3y5OCWOUZXBho0WOkpJ
         l1kV1TgawXMNz1meLqHg9vRPsxqKfSRpVdVDjXXU+b4mIp9PIGDsVBPc5bJPsjXd8/AY
         hK1nMZUUsDU+NNEz6+CbZt1UpAv+ExqsFL7jazS3CFc0lshiN+XXfHlYCWktITA0d2Qs
         5GgBupTnkFVPVATV6+Ygre+eIgX1v948n9Pvw+wsZzzWdtjrxoED0o9dPl+Cv6TqdSyQ
         m6AeK9z3WFBOtPo6fXl9YOVeECxDoTQzHqgrnN6ZUgprDds/58TF8obeKEFJUcgQtYxp
         XFxw==
X-Gm-Message-State: AOJu0YxHxLoEMenMy+wGlsz6tCVtZvwzvnctvIoH3UH0GRqZtX+PpQgm
        SL40BXQudKnN+4Zyr6KNOMzpPA==
X-Google-Smtp-Source: AGHT+IG6+9IB6uFxWZM3GIOXMU3BPqs4EX0RKLfedlqEvbvt0BgIgu7ki0WNkT/tohlFIibQd5bGSA==
X-Received: by 2002:a17:902:db11:b0:1bc:9651:57c6 with SMTP id m17-20020a170902db1100b001bc965157c6mr5121186plx.57.1694647806167;
        Wed, 13 Sep 2023 16:30:06 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u15-20020a170902e5cf00b001b3bf8001a9sm167730plf.48.2023.09.13.16.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 16:30:05 -0700 (PDT)
Date:   Wed, 13 Sep 2023 16:30:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     corbet@lwn.net, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tony.luck@intel.com, gpiccoli@igalia.com,
        mathieu.poirier@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, linus.walleij@linaro.org,
        andy.shevchenko@gmail.com, vigneshr@ti.com, nm@ti.com,
        matthias.bgg@gmail.com, kgene@kernel.org, alim.akhtar@samsung.com,
        bmasney@redhat.com, quic_tsoni@quicinc.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, kernel@quicinc.com
Subject: Re: [REBASE PATCH v5 11/17] qcom_minidump: Register ramoops region
 with minidump
Message-ID: <202309131624.0371D7E@keescook>
References: <1694429639-21484-1-git-send-email-quic_mojha@quicinc.com>
 <1694429639-21484-12-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1694429639-21484-12-git-send-email-quic_mojha@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 04:23:53PM +0530, Mukesh Ojha wrote:
> Register all the pstore frontend with minidump, so that they can
> be dumped as default Linux minidump region to be collected on
> SoC where minidump is enabled.
> 
> Helper functions is written in separate file and built along with
> the minidump driver, since it is client of minidump and also call
> it at appropriate place from minidump probe so that they always
> get registered.
> 
> While at it also rename the out minidump module object name during
> build as qcom_apss_minidump which basically depicts as Qualcomm
> Application processor subsystem minidump.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  drivers/soc/qcom/Kconfig                 |  1 +
>  drivers/soc/qcom/Makefile                |  3 +-
>  drivers/soc/qcom/qcom_minidump.c         |  4 ++
>  drivers/soc/qcom/qcom_ramoops_minidump.c | 88 ++++++++++++++++++++++++++++++++
>  drivers/soc/qcom/qcom_ramoops_minidump.h | 10 ++++
>  5 files changed, 105 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/soc/qcom/qcom_ramoops_minidump.c
>  create mode 100644 drivers/soc/qcom/qcom_ramoops_minidump.h
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 0ac7afc2c67d..9f1a1e128fef 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -306,6 +306,7 @@ config QCOM_MINIDUMP
>  	tristate "QCOM APSS Minidump driver"
>  	depends on ARCH_QCOM || COMPILE_TEST
>  	depends on QCOM_SMEM
> +	depends on PSTORE
>  	help
>  	  This config enables linux core infrastructure for Application
>  	  processor subsystem (APSS) minidump collection i.e, it enables
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 4b5f72f78d3c..69df41aba7a9 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -33,4 +33,5 @@ obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
>  qcom_ice-objs			+= ice.o
>  obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= qcom_ice.o
>  obj-$(CONFIG_QCOM_RPROC_MINIDUMP)	+= qcom_rproc_minidump.o
> -obj-$(CONFIG_QCOM_MINIDUMP)		+= qcom_minidump.o
> +obj-$(CONFIG_QCOM_MINIDUMP)		+= qcom_apss_minidump.o
> +qcom_apss_minidump-objs			+= qcom_minidump.o qcom_ramoops_minidump.o
> diff --git a/drivers/soc/qcom/qcom_minidump.c b/drivers/soc/qcom/qcom_minidump.c
> index 4ce36f154e89..7930a80b9100 100644
> --- a/drivers/soc/qcom/qcom_minidump.c
> +++ b/drivers/soc/qcom/qcom_minidump.c
> @@ -23,6 +23,7 @@
>  #include <soc/qcom/qcom_minidump.h>
>  
>  #include "qcom_minidump_internal.h"
> +#include "qcom_ramoops_minidump.h"
>  
>  /**
>   * struct minidump_ss_data - Minidump subsystem private data
> @@ -688,6 +689,8 @@ static int qcom_apss_minidump_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	qcom_ramoops_minidump_register(md->dev);
> +
>  	mutex_lock(&md_plist.plock);
>  	platform_set_drvdata(pdev, md);
>  	qcom_apss_register_pending_regions(md);
> @@ -701,6 +704,7 @@ static int qcom_apss_minidump_remove(struct platform_device *pdev)
>  	struct minidump *md = platform_get_drvdata(pdev);
>  	struct minidump_ss_data *mdss_data;
>  
> +	qcom_ramoops_minidump_unregister();
>  	mdss_data = md->apss_data;
>  	memset(mdss_data->md_ss_toc, cpu_to_le32(0), sizeof(struct minidump_subsystem));
>  	md = NULL;
> diff --git a/drivers/soc/qcom/qcom_ramoops_minidump.c b/drivers/soc/qcom/qcom_ramoops_minidump.c
> new file mode 100644
> index 000000000000..eb97310e3858
> --- /dev/null
> +++ b/drivers/soc/qcom/qcom_ramoops_minidump.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pstore.h>
> +#include <linux/slab.h>
> +#include <soc/qcom/qcom_minidump.h>
> +
> +#include "qcom_ramoops_minidump.h"
> +
> +static LIST_HEAD(ramoops_region_list);
> +
> +struct md_region_list {
> +	struct qcom_minidump_region md_region;
> +	struct list_head list;
> +};
> +
> +static int qcom_ramoops_region_register(struct device *dev, int type)
> +{
> +	struct qcom_minidump_region *md_region;
> +	struct md_region_list *mdr_list;
> +	struct pstore_record record;
> +	unsigned int max_dump_cnt;
> +	phys_addr_t phys;
> +	const char *name;
> +	void *virt;
> +	size_t size;
> +	int ret;
> +
> +	record.type = type;
> +	record.id = 0;
> +	max_dump_cnt = 0;
> +	name = pstore_type_to_name(record.type);
> +	do {
> +		ret = pstore_region_defined(&record, &virt, &phys, &size, &max_dump_cnt);

I really don't want this happening: you're building your own pstore_record
(which has a common initializer that isn't used here) and manually
scraping the ramoops regions.

It looks to me like you just want a way to talk all the records in
pstore and then export their location to minidump. The record walker
needs to be in the pstore core, and likely should be shared with
fs/pstore/inode.c which does the same thing.

Then, in this code, you can just do something like:

	for (record = pstore_get_record(NULL); record; record = pstore_get_record(record)) {
		if (ramoops_get_record_details(record, &virt, &phys) < 0)
			continue
		...
		md_region->virt_addr = virt;
		md_region->phys_addr = phys;
		md_region->size = record->size;

		ret = qcom_minidump_region_register(md_region);
		...
	}

Probably some way to check the backend is ramoops is needed too.

-- 
Kees Cook
