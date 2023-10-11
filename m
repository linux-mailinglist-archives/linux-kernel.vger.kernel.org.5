Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0C57C5A81
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbjJKRsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjJKRsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:48:52 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D693B9D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 10:48:50 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6934202b8bdso29522b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 10:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697046530; x=1697651330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bM2ZtT57neAX/wQjDtY6kTjEfhq5pvyurdRnUuf/xJM=;
        b=Hy+o3VdJuO81ausf8llhFOkBB+r0xZ6d0wk7L0qSa5i+aZhL4RextZ9fB7FSwgS+Oy
         k3KwIb2SiLl6llCsCkKMCpyGeLe7e0g7s6OkSKT+Das1JzqohH2+oPDF3g9eoK8cKS0t
         nMFpuTVfbeLtnENhoz2VSu5sO2DoZgy8NoQE409qg/v7AQ4Uy3OjBIAsgSsaXr+KecOD
         g6/NJaXV47xu6f88z0jh9gTZG8ivVTj/lpFDLsYawtfCLKYUbcNCnK+HuKUhHbEqnL4w
         CHEe1z5l+XfGgkfOVfTQd6rx3mNdBHVPceNbuqZTTJS/OQuzmnZp6jGAQQPj8H63UnNv
         01iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697046530; x=1697651330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bM2ZtT57neAX/wQjDtY6kTjEfhq5pvyurdRnUuf/xJM=;
        b=iRF+kWKv5hJfCtGpq/ApHS1XvYBUrtVy+yL8qctjb92nZtCVomhsbai+K1WJXAqgNf
         3mWEW81Y9HTn85tK+Jo1Wsl1kPOi61KsSmRPQJJTST5EUaLLCWlZePJbM/E0EDJDY1Kg
         4otaNPC3eTUfBjwrCZpiPk7fN1lGbPVw+hZWdVL92JaKUCQT9bBDRtY/k3SHQXomQBBm
         oT0YbH6fg6on8Xp4muYt6x/gwQIJR/vZApj5jN9gbSYt6ARlA7rmoDyTdBLSLpakSanP
         sy6CozGeYaHxuNgF8yiptlp9gVYXDwWXIKeObIOUrXGsAnjN/gskr+lAsOQQ+BWef4Z0
         O/yw==
X-Gm-Message-State: AOJu0YzR+hOy+bZbDiOTuASFQKxCxSLzdqcCkn13uGk5zjjOggomAufP
        7mR0Nezjz6aTc4z1KAFglXX/lg==
X-Google-Smtp-Source: AGHT+IF4MffnY6FNeJJc1juHDvYlAxYH24seuPoeHgjPkWoCKjPIY6tr0GTX+skm36H1sgCf0PrVBQ==
X-Received: by 2002:a05:6a00:1687:b0:68a:5395:7aa5 with SMTP id k7-20020a056a00168700b0068a53957aa5mr24585337pfc.17.1697046530225;
        Wed, 11 Oct 2023 10:48:50 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:fbd6:ce83:3759:dbcc])
        by smtp.gmail.com with ESMTPSA id c4-20020a62e804000000b00690c9fda0fesm10327293pfi.169.2023.10.11.10.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 10:48:49 -0700 (PDT)
Date:   Wed, 11 Oct 2023 11:48:45 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     corbet@lwn.net, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org, linus.walleij@linaro.org,
        andy.shevchenko@gmail.com, vigneshr@ti.com, nm@ti.com,
        matthias.bgg@gmail.com, kgene@kernel.org, alim.akhtar@samsung.com,
        bmasney@redhat.com, quic_tsoni@quicinc.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, kernel@quicinc.com
Subject: Re: [REBASE PATCH v5 04/17] remoteproc: qcom: Remove minidump
 related data from qcom_common.c
Message-ID: <ZSbf/VqpBIlhyUIG@p14s>
References: <1694429639-21484-1-git-send-email-quic_mojha@quicinc.com>
 <1694429639-21484-5-git-send-email-quic_mojha@quicinc.com>
 <bb29aba3-9378-6405-5f6d-a7d77e0374ad@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb29aba3-9378-6405-5f6d-a7d77e0374ad@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 08:38:52PM +0530, Mukesh Ojha wrote:
> Hi Bjorn/Mathieu,
> 
> Patches from 2/17-4/17  is just a movement of functions to separate
> config/file.
> 
> Do you think, these can be picked independently from this series ?
> I can send them separately, if required.

Bjorn handles submissions for Qualcomm - I will defer to him.

> 
> @Bjorn: I have sent 13/17-15/17 separately [1] as it is needed
> by some folks and independent from this series.
> 
> [1]
> https://lore.kernel.org/all/1696440338-12561-1-git-send-email-quic_mojha@quicinc.com/
> 
> -Mukesh
> 
> On 9/11/2023 4:23 PM, Mukesh Ojha wrote:
> > As minidump specific data structure and functions move under
> > config QCOM_RPROC_MINIDUMP, so remove minidump specific data
> > from driver/remoteproc/qcom_common.c .
> > 
> > Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> > ---
> >   drivers/remoteproc/qcom_common.c | 160 ---------------------------------------
> >   1 file changed, 160 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
> > index 03e5f5d533eb..085fd73fa23a 100644
> > --- a/drivers/remoteproc/qcom_common.c
> > +++ b/drivers/remoteproc/qcom_common.c
> > @@ -17,7 +17,6 @@
> >   #include <linux/rpmsg/qcom_smd.h>
> >   #include <linux/slab.h>
> >   #include <linux/soc/qcom/mdt_loader.h>
> > -#include <linux/soc/qcom/smem.h>
> >   #include "remoteproc_internal.h"
> >   #include "qcom_common.h"
> > @@ -26,61 +25,6 @@
> >   #define to_smd_subdev(d) container_of(d, struct qcom_rproc_subdev, subdev)
> >   #define to_ssr_subdev(d) container_of(d, struct qcom_rproc_ssr, subdev)
> > -#define MAX_NUM_OF_SS           10
> > -#define MAX_REGION_NAME_LENGTH  16
> > -#define SBL_MINIDUMP_SMEM_ID	602
> > -#define MINIDUMP_REGION_VALID		('V' << 24 | 'A' << 16 | 'L' << 8 | 'I' << 0)
> > -#define MINIDUMP_SS_ENCR_DONE		('D' << 24 | 'O' << 16 | 'N' << 8 | 'E' << 0)
> > -#define MINIDUMP_SS_ENABLED		('E' << 24 | 'N' << 16 | 'B' << 8 | 'L' << 0)
> > -
> > -/**
> > - * struct minidump_region - Minidump region
> > - * @name		: Name of the region to be dumped
> > - * @seq_num:		: Use to differentiate regions with same name.
> > - * @valid		: This entry to be dumped (if set to 1)
> > - * @address		: Physical address of region to be dumped
> > - * @size		: Size of the region
> > - */
> > -struct minidump_region {
> > -	char	name[MAX_REGION_NAME_LENGTH];
> > -	__le32	seq_num;
> > -	__le32	valid;
> > -	__le64	address;
> > -	__le64	size;
> > -};
> > -
> > -/**
> > - * struct minidump_subsystem - Subsystem's SMEM Table of content
> > - * @status : Subsystem toc init status
> > - * @enabled : if set to 1, this region would be copied during coredump
> > - * @encryption_status: Encryption status for this subsystem
> > - * @encryption_required : Decides to encrypt the subsystem regions or not
> > - * @region_count : Number of regions added in this subsystem toc
> > - * @regions_baseptr : regions base pointer of the subsystem
> > - */
> > -struct minidump_subsystem {
> > -	__le32	status;
> > -	__le32	enabled;
> > -	__le32	encryption_status;
> > -	__le32	encryption_required;
> > -	__le32	region_count;
> > -	__le64	regions_baseptr;
> > -};
> > -
> > -/**
> > - * struct minidump_global_toc - Global Table of Content
> > - * @status : Global Minidump init status
> > - * @md_revision : Minidump revision
> > - * @enabled : Minidump enable status
> > - * @subsystems : Array of subsystems toc
> > - */
> > -struct minidump_global_toc {
> > -	__le32				status;
> > -	__le32				md_revision;
> > -	__le32				enabled;
> > -	struct minidump_subsystem	subsystems[MAX_NUM_OF_SS];
> > -};
> > -
> >   struct qcom_ssr_subsystem {
> >   	const char *name;
> >   	struct srcu_notifier_head notifier_list;
> > @@ -90,110 +34,6 @@ struct qcom_ssr_subsystem {
> >   static LIST_HEAD(qcom_ssr_subsystem_list);
> >   static DEFINE_MUTEX(qcom_ssr_subsys_lock);
> > -static void qcom_minidump_cleanup(struct rproc *rproc)
> > -{
> > -	struct rproc_dump_segment *entry, *tmp;
> > -
> > -	list_for_each_entry_safe(entry, tmp, &rproc->dump_segments, node) {
> > -		list_del(&entry->node);
> > -		kfree(entry->priv);
> > -		kfree(entry);
> > -	}
> > -}
> > -
> > -static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsystem *subsystem,
> > -			void (*rproc_dumpfn_t)(struct rproc *rproc, struct rproc_dump_segment *segment,
> > -				void *dest, size_t offset, size_t size))
> > -{
> > -	struct minidump_region __iomem *ptr;
> > -	struct minidump_region region;
> > -	int seg_cnt, i;
> > -	dma_addr_t da;
> > -	size_t size;
> > -	char *name;
> > -
> > -	if (WARN_ON(!list_empty(&rproc->dump_segments))) {
> > -		dev_err(&rproc->dev, "dump segment list already populated\n");
> > -		return -EUCLEAN;
> > -	}
> > -
> > -	seg_cnt = le32_to_cpu(subsystem->region_count);
> > -	ptr = ioremap((unsigned long)le64_to_cpu(subsystem->regions_baseptr),
> > -		      seg_cnt * sizeof(struct minidump_region));
> > -	if (!ptr)
> > -		return -EFAULT;
> > -
> > -	for (i = 0; i < seg_cnt; i++) {
> > -		memcpy_fromio(&region, ptr + i, sizeof(region));
> > -		if (le32_to_cpu(region.valid) == MINIDUMP_REGION_VALID) {
> > -			name = kstrndup(region.name, MAX_REGION_NAME_LENGTH - 1, GFP_KERNEL);
> > -			if (!name) {
> > -				iounmap(ptr);
> > -				return -ENOMEM;
> > -			}
> > -			da = le64_to_cpu(region.address);
> > -			size = le64_to_cpu(region.size);
> > -			rproc_coredump_add_custom_segment(rproc, da, size, rproc_dumpfn_t, name);
> > -		}
> > -	}
> > -
> > -	iounmap(ptr);
> > -	return 0;
> > -}
> > -
> > -void qcom_minidump(struct rproc *rproc, unsigned int minidump_id,
> > -		void (*rproc_dumpfn_t)(struct rproc *rproc,
> > -		struct rproc_dump_segment *segment, void *dest, size_t offset,
> > -		size_t size))
> > -{
> > -	int ret;
> > -	struct minidump_subsystem *subsystem;
> > -	struct minidump_global_toc *toc;
> > -
> > -	/* Get Global minidump ToC*/
> > -	toc = qcom_smem_get(QCOM_SMEM_HOST_ANY, SBL_MINIDUMP_SMEM_ID, NULL);
> > -
> > -	/* check if global table pointer exists and init is set */
> > -	if (IS_ERR(toc) || !toc->status) {
> > -		dev_err(&rproc->dev, "Minidump TOC not found in SMEM\n");
> > -		return;
> > -	}
> > -
> > -	/* Get subsystem table of contents using the minidump id */
> > -	subsystem = &toc->subsystems[minidump_id];
> > -
> > -	/**
> > -	 * Collect minidump if SS ToC is valid and segment table
> > -	 * is initialized in memory and encryption status is set.
> > -	 */
> > -	if (subsystem->regions_baseptr == 0 ||
> > -	    le32_to_cpu(subsystem->status) != 1 ||
> > -	    le32_to_cpu(subsystem->enabled) != MINIDUMP_SS_ENABLED) {
> > -		return rproc_coredump(rproc);
> > -	}
> > -
> > -	if (le32_to_cpu(subsystem->encryption_status) != MINIDUMP_SS_ENCR_DONE) {
> > -		dev_err(&rproc->dev, "Minidump not ready, skipping\n");
> > -		return;
> > -	}
> > -
> > -	/**
> > -	 * Clear out the dump segments populated by parse_fw before
> > -	 * re-populating them with minidump segments.
> > -	 */
> > -	rproc_coredump_cleanup(rproc);
> > -
> > -	ret = qcom_add_minidump_segments(rproc, subsystem, rproc_dumpfn_t);
> > -	if (ret) {
> > -		dev_err(&rproc->dev, "Failed with error: %d while adding minidump entries\n", ret);
> > -		goto clean_minidump;
> > -	}
> > -	rproc_coredump_using_sections(rproc);
> > -clean_minidump:
> > -	qcom_minidump_cleanup(rproc);
> > -}
> > -EXPORT_SYMBOL_GPL(qcom_minidump);
> > -
> >   static int glink_subdev_start(struct rproc_subdev *subdev)
> >   {
> >   	struct qcom_rproc_glink *glink = to_glink_subdev(subdev);
