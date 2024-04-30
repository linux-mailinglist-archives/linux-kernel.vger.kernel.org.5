Return-Path: <linux-kernel+bounces-164027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 604C68B7754
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83D0D1C22258
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D586171E5E;
	Tue, 30 Apr 2024 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W0E+2ny+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C498171678;
	Tue, 30 Apr 2024 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714484331; cv=none; b=JrjOxwzkqlJeF5O11rryjSyhyCTY4/XKRkBJqC5pWpf9lzLRX1lE7+gWMm+C9b9KWDKLpR0N0Lw2hIL+p8T8gcEsxrcYsibyxn1Nu8m28LZ2QmV5Z86+6Nso4QRcHE3hT157YwWiul8Y2BWs+76GMHVQbAAjL8/BQqQGM6HD+Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714484331; c=relaxed/simple;
	bh=mO+dhWGAB5hNdHMRm8RNEWiQsl/fSWldi+JeNPslrAE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiJfy423f6eM3V93Bok6/7dPor4I2/FFVkk1BC8I/FXiK4+uu/UncFf204bDW2nvQ6xnXvJItmvFrY4M94vdAIvqX8dOh5UKT3g1Nb4gDPPDHq3dMBbFDR4be//0Rm6MNfMvJaalffFTWZdbaGm+xYK0IQT1bSrAPI/so7Q5Gb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W0E+2ny+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UC8bWw027011;
	Tue, 30 Apr 2024 13:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=96duwTqpWozDGSxy1qFvA
	FKHc4Hh17ESTt+z44KvZ4s=; b=W0E+2ny+Gbu+l+pMSG39Rr2sMfj3rGjNZnBUE
	vbdjmyxZ1u2fo8zkTMckNfBzwoc+C4rAqqOilwICMPA09Z14VXzuDZdBUC9jM9yi
	PsroleEyHCzM8MZQmi+NJV3rUf/2kH65+m3VrVyfu01nn0yx9P00DrNgENsH26Td
	9pZRtATiBBA6F/cRnVXZRJJ4X3uXgsW5HemBcyWN1kIIoSPQ7ONv82pmNN1XQmxp
	z7MHifgGyjQfZsFvDBXPqf7aFU/xC36KkpQJSVV+Ferq5EeABWqJ0S/X8VZuj+Li
	y9FdxJbJMz5xEAv3qqoAKjR5R3eeSd+p9EQfwf4mbCm4RJh8Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtfys3m4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 13:38:45 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UDcioM025055
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 13:38:44 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 30 Apr 2024 06:38:44 -0700
Date: Tue, 30 Apr 2024 06:38:42 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Mukesh Ojha <quic_mojha@quicinc.com>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mathieu.poirier@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
Subject: Re: [PATCH v9 1/3] soc: qcom: Add qcom_rproc_minidump module
Message-ID: <ZjD0Yr72qv0ul3jK@hu-bjorande-lv.qualcomm.com>
References: <1711462394-21540-1-git-send-email-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1711462394-21540-1-git-send-email-quic_mojha@quicinc.com>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8A930RImmklqcmasu4LqKbEmw7FEMwTd
X-Proofpoint-ORIG-GUID: 8A930RImmklqcmasu4LqKbEmw7FEMwTd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_07,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300096

On Tue, Mar 26, 2024 at 07:43:12PM +0530, Mukesh Ojha wrote:
> Add qcom_rproc_minidump module in a preparation to remove
> minidump specific code from driver/remoteproc/qcom_common.c
> and provide needed exported API, this as well helps to
> abstract minidump specific data layout from qualcomm's
> remoteproc driver.
> 
> It is just a copying of qcom_minidump() functionality from
> driver/remoteproc/qcom_common.c into a separate file under
> qcom_rproc_minidump().
> 

I'd prefer to see this enter the git history as one patch, extracting
this logic from the remoteproc into its own driver - rather than as
presented here give a sense that it's a new thing added. (I'll take care
of the maintainer sync...)

I also would prefer for this to include a problem description,
documenting why this is done.


I've not compared patch 1 and 3, but I'd also like a statement in the
commit message telling if there are any changes, or if the functions are
cleanly moved from one place to another.

Regards,
Bjorn

> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
> Changes in v9:
>  - Added source file driver/remoteproc/qcom_common.c copyright
>    to qcom_rproc_minidump.c 
>  - Dissociated it from minidump series as this can go separately
>    and minidump can put it dependency for the data structure files.
> 
> Nothing much changed in these three patches from previous version,
> However, giving the link of their older versions.
> 
> v8: https://lore.kernel.org/lkml/20240131105734.13090-1-quic_mojha@quicinc.com/
> v7: https://lore.kernel.org/lkml/20240109153200.12848-1-quic_mojha@quicinc.com/
> v6: https://lore.kernel.org/lkml/1700864395-1479-1-git-send-email-quic_mojha@quicinc.com/
> v5: https://lore.kernel.org/lkml/1694429639-21484-1-git-send-email-quic_mojha@quicinc.com/
> v4: https://lore.kernel.org/lkml/1687955688-20809-1-git-send-email-quic_mojha@quicinc.com/
> 
>  drivers/soc/qcom/Kconfig                  |  10 +++
>  drivers/soc/qcom/Makefile                 |   1 +
>  drivers/soc/qcom/qcom_minidump_internal.h |  64 +++++++++++++++++
>  drivers/soc/qcom/qcom_rproc_minidump.c    | 115 ++++++++++++++++++++++++++++++
>  include/soc/qcom/qcom_minidump.h          |  23 ++++++
>  5 files changed, 213 insertions(+)
>  create mode 100644 drivers/soc/qcom/qcom_minidump_internal.h
>  create mode 100644 drivers/soc/qcom/qcom_rproc_minidump.c
>  create mode 100644 include/soc/qcom/qcom_minidump.h
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 5af33b0e3470..ed23e0275c22 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -277,4 +277,14 @@ config QCOM_PBS
>  	  This module provides the APIs to the client drivers that wants to send the
>  	  PBS trigger event to the PBS RAM.
>  
> +config QCOM_RPROC_MINIDUMP
> +	tristate "QCOM Remoteproc Minidump Support"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on QCOM_SMEM
> +	help
> +	  Enablement of core Minidump feature is controlled from boot firmware
> +	  side, so if it is enabled from firmware, this config allow Linux to
> +	  query predefined Minidump segments associated with the remote processor
> +	  and check its validity and end up collecting the dump on remote processor
> +	  crash during its recovery.
>  endmenu
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index ca0bece0dfff..44664589263d 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -36,3 +36,4 @@ obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
>  qcom_ice-objs			+= ice.o
>  obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= qcom_ice.o
>  obj-$(CONFIG_QCOM_PBS) +=	qcom-pbs.o
> +obj-$(CONFIG_QCOM_RPROC_MINIDUMP)	+= qcom_rproc_minidump.o
> diff --git a/drivers/soc/qcom/qcom_minidump_internal.h b/drivers/soc/qcom/qcom_minidump_internal.h
> new file mode 100644
> index 000000000000..71709235b196
> --- /dev/null
> +++ b/drivers/soc/qcom/qcom_minidump_internal.h
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _QCOM_MINIDUMP_INTERNAL_H_
> +#define _QCOM_MINIDUMP_INTERNAL_H_
> +
> +#define MAX_NUM_OF_SS           10
> +#define MAX_REGION_NAME_LENGTH  16
> +#define SBL_MINIDUMP_SMEM_ID	602
> +#define MINIDUMP_REGION_VALID	   ('V' << 24 | 'A' << 16 | 'L' << 8 | 'I' << 0)
> +#define MINIDUMP_SS_ENCR_DONE	   ('D' << 24 | 'O' << 16 | 'N' << 8 | 'E' << 0)
> +#define MINIDUMP_SS_ENABLED	   ('E' << 24 | 'N' << 16 | 'B' << 8 | 'L' << 0)
> +
> +/**
> + * struct minidump_region - Minidump region
> + * @name		: Name of the region to be dumped
> + * @seq_num:		: Use to differentiate regions with same name.
> + * @valid		: This entry to be dumped (if set to 1)
> + * @address		: Physical address of region to be dumped
> + * @size		: Size of the region
> + */
> +struct minidump_region {
> +	char	name[MAX_REGION_NAME_LENGTH];
> +	__le32	seq_num;
> +	__le32	valid;
> +	__le64	address;
> +	__le64	size;
> +};
> +
> +/**
> + * struct minidump_subsystem - Subsystem's SMEM Table of content
> + * @status : Subsystem toc init status
> + * @enabled : if set to 1, this region would be copied during coredump
> + * @encryption_status: Encryption status for this subsystem
> + * @encryption_required : Decides to encrypt the subsystem regions or not
> + * @region_count : Number of regions added in this subsystem toc
> + * @regions_baseptr : regions base pointer of the subsystem
> + */
> +struct minidump_subsystem {
> +	__le32	status;
> +	__le32	enabled;
> +	__le32	encryption_status;
> +	__le32	encryption_required;
> +	__le32	region_count;
> +	__le64	regions_baseptr;
> +};
> +
> +/**
> + * struct minidump_global_toc - Global Table of Content
> + * @status : Global Minidump init status
> + * @md_revision : Minidump revision
> + * @enabled : Minidump enable status
> + * @subsystems : Array of subsystems toc
> + */
> +struct minidump_global_toc {
> +	__le32				status;
> +	__le32				md_revision;
> +	__le32				enabled;
> +	struct minidump_subsystem	subsystems[MAX_NUM_OF_SS];
> +};
> +
> +#endif /* _QCOM_MINIDUMP_INTERNAL_H_ */
> diff --git a/drivers/soc/qcom/qcom_rproc_minidump.c b/drivers/soc/qcom/qcom_rproc_minidump.c
> new file mode 100644
> index 000000000000..c41714dedbfb
> --- /dev/null
> +++ b/drivers/soc/qcom/qcom_rproc_minidump.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2016 Linaro Ltd
> + * Copyright (C) 2015 Sony Mobile Communications Inc
> + * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/remoteproc.h>
> +#include <linux/soc/qcom/smem.h>
> +#include <linux/string.h>
> +#include <soc/qcom/qcom_minidump.h>
> +
> +#include "qcom_minidump_internal.h"
> +
> +static void qcom_minidump_cleanup(struct rproc *rproc)
> +{
> +	struct rproc_dump_segment *entry, *tmp;
> +
> +	list_for_each_entry_safe(entry, tmp, &rproc->dump_segments, node) {
> +		list_del(&entry->node);
> +		kfree(entry->priv);
> +		kfree(entry);
> +	}
> +}
> +
> +static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsystem *subsystem,
> +			void (*rproc_dumpfn_t)(struct rproc *rproc, struct rproc_dump_segment *segment,
> +				void *dest, size_t offset, size_t size))
> +{
> +	struct minidump_region __iomem *ptr;
> +	struct minidump_region region;
> +	int seg_cnt, i;
> +	dma_addr_t da;
> +	size_t size;
> +	char *name;
> +
> +	if (WARN_ON(!list_empty(&rproc->dump_segments))) {
> +		dev_err(&rproc->dev, "dump segment list already populated\n");
> +		return -EUCLEAN;
> +	}
> +
> +	seg_cnt = le32_to_cpu(subsystem->region_count);
> +	ptr = ioremap((unsigned long)le64_to_cpu(subsystem->regions_baseptr),
> +		      seg_cnt * sizeof(struct minidump_region));
> +	if (!ptr)
> +		return -EFAULT;
> +
> +	for (i = 0; i < seg_cnt; i++) {
> +		memcpy_fromio(&region, ptr + i, sizeof(region));
> +		if (le32_to_cpu(region.valid) == MINIDUMP_REGION_VALID) {
> +			name = kstrndup(region.name, MAX_REGION_NAME_LENGTH - 1, GFP_KERNEL);
> +			if (!name) {
> +				iounmap(ptr);
> +				return -ENOMEM;
> +			}
> +			da = le64_to_cpu(region.address);
> +			size = le64_to_cpu(region.size);
> +			rproc_coredump_add_custom_segment(rproc, da, size, rproc_dumpfn_t, name);
> +		}
> +	}
> +
> +	iounmap(ptr);
> +	return 0;
> +}
> +
> +void qcom_rproc_minidump(struct rproc *rproc, unsigned int minidump_id,
> +		void (*rproc_dumpfn_t)(struct rproc *rproc,
> +		struct rproc_dump_segment *segment, void *dest, size_t offset,
> +		size_t size))
> +{
> +	int ret;
> +	struct minidump_subsystem *subsystem;
> +	struct minidump_global_toc *toc;
> +
> +	/* Get Global minidump ToC*/
> +	toc = qcom_smem_get(QCOM_SMEM_HOST_ANY, SBL_MINIDUMP_SMEM_ID, NULL);
> +
> +	/* check if global table pointer exists and init is set */
> +	if (IS_ERR(toc) || !toc->status) {
> +		dev_err(&rproc->dev, "Minidump TOC not found in SMEM\n");
> +		return;
> +	}
> +
> +	/* Get subsystem table of contents using the minidump id */
> +	subsystem = &toc->subsystems[minidump_id];
> +
> +	/**
> +	 * Collect minidump if SS ToC is valid and segment table
> +	 * is initialized in memory and encryption status is set.
> +	 */
> +	if (subsystem->regions_baseptr == 0 ||
> +	    le32_to_cpu(subsystem->status) != 1 ||
> +	    le32_to_cpu(subsystem->enabled) != MINIDUMP_SS_ENABLED ||
> +	    le32_to_cpu(subsystem->encryption_status) != MINIDUMP_SS_ENCR_DONE) {
> +		dev_err(&rproc->dev, "Minidump not ready, skipping\n");
> +		return;
> +	}
> +
> +	ret = qcom_add_minidump_segments(rproc, subsystem, rproc_dumpfn_t);
> +	if (ret) {
> +		dev_err(&rproc->dev, "Failed with error: %d while adding minidump entries\n", ret);
> +		goto clean_minidump;
> +	}
> +	rproc_coredump_using_sections(rproc);
> +clean_minidump:
> +	qcom_minidump_cleanup(rproc);
> +}
> +EXPORT_SYMBOL_GPL(qcom_rproc_minidump);
> +
> +MODULE_DESCRIPTION("Qualcomm remoteproc minidump(smem) helper module");
> +MODULE_LICENSE("GPL");
> diff --git a/include/soc/qcom/qcom_minidump.h b/include/soc/qcom/qcom_minidump.h
> new file mode 100644
> index 000000000000..cd87caef919d
> --- /dev/null
> +++ b/include/soc/qcom/qcom_minidump.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _QCOM_MINIDUMP_H_
> +#define _QCOM_MINIDUMP_H_
> +
> +struct rproc;
> +struct rproc_dump_segment;
> +
> +#if IS_ENABLED(CONFIG_QCOM_RPROC_MINIDUMP)
> +void qcom_rproc_minidump(struct rproc *rproc, unsigned int minidump_id,
> +		   void (*rproc_dumpfn_t)(struct rproc *rproc,
> +		   struct rproc_dump_segment *segment, void *dest, size_t offset,
> +		   size_t size));
> +#else
> +static inline void qcom_rproc_minidump(struct rproc *rproc, unsigned int minidump_id,
> +		   void (*rproc_dumpfn_t)(struct rproc *rproc,
> +		   struct rproc_dump_segment *segment, void *dest, size_t offset,
> +		   size_t size)) { }
> +#endif /* CONFIG_QCOM_RPROC_MINIDUMP */
> +#endif /* _QCOM_MINIDUMP_H_ */
> -- 
> 2.7.4
> 

