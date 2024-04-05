Return-Path: <linux-kernel+bounces-132368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D681E8993A8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056E11C20C3C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307761B299;
	Fri,  5 Apr 2024 03:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IZzO4Ehu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E134E20313;
	Fri,  5 Apr 2024 03:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712286671; cv=none; b=eunkccl9NBJAzHSiu/hjWh5f/I2YOM3CbL98Zpu5/wIMKhZercItlyY85MDtKs+rRoMF6PUgJlnPhNMb6wiOjetNZ7Lf4fd84oVuSreLNtAdaP+4zzVHctJNwmrHh1u4+6e1ktJJLfAgHdjbOURFlXmFnBdKFsPM2yBvqFZzqaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712286671; c=relaxed/simple;
	bh=c/nS0D1RD43be7oZ49NydcU4l66Mke80I2ljTSJyyrs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lr6JEyj9whuiWseHoT38D6UVYO962rpvQ8+vyx7ww+sDqFAiqk5rPmi+zYpmzKLBWIznzJK0YR756qcigUfTuWF1BRyvJm19DMpAoxL+4cy8XXyVBpJf5zDaGv8tYNb2X2DGju6yRjn5P5mS+3DTTyMH3mECiSHrqTZ29Le0tSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IZzO4Ehu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43527dFH015699;
	Fri, 5 Apr 2024 03:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=FwLCTYvyG2BzUyu75wDdV
	Y/7/PCyyGgukkUMUtOcK3k=; b=IZzO4EhuASwXIFpHvWAC//BtUgN5aVUembQHM
	HtqVK6KAsGAILT5EiKpFiZr1/y1pG/itxOo7OJFRY3cEI8jghfsPbDf6FxFAjJ7T
	Wlu3wixX2pg+BBmu+0Rz+KisxtBdN1t62bT4ZjnzdTGuOQvk6alsvdIxzHc5ySd7
	TqPadYKtcefw5BjNSGrBCsPFdUfEPZ62NL+4Rwu9JZHABZxqc9Zt5IrlZPhXRCgD
	J3DGegdHJlJunQ8Vbew+AstCUVsJUlOfs/2AvE4eHJNSkFT91/Ih2SgZq7HQ65Oz
	NN+EB4aYXbXiy77ynOXwG4/w8jl3HaC5GXiHfYjj3ki9JAR0g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa7m5g46f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 03:10:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4353AoLx021530
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 03:10:50 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 4 Apr 2024 20:10:43 -0700
Date: Fri, 5 Apr 2024 08:40:40 +0530
From: Pavan Kondeti <quic_pkondeti@quicinc.com>
To: Elliot Berman <quic_eberman@quicinc.com>
CC: Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>,
        Murali Nalajal <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri
	<quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Philip Derrin <quic_pderrin@quicinc.com>,
        Prakruthi Deepak Heragu
	<quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Fuad
 Tabba" <tabba@google.com>,
        Sean Christopherson <seanjc@google.com>,
        "Andrew
 Morton" <akpm@linux-foundation.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH v17 11/35] virt: gunyah: Translate gh_rm_hyp_resource
 into gunyah_resource
Message-ID: <ff6a3fb2-5f1a-4baa-b42a-a7767e92885a@quicinc.com>
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
 <20240222-gunyah-v17-11-1e9da6763d38@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240222-gunyah-v17-11-1e9da6763d38@quicinc.com>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8XJxnYRnZpwG_GTOUSD6n18PMOkK3sY8
X-Proofpoint-GUID: 8XJxnYRnZpwG_GTOUSD6n18PMOkK3sY8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_02,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1011
 mlxlogscore=825 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404050022

On Thu, Feb 22, 2024 at 03:16:34PM -0800, Elliot Berman wrote:
> When booting a Gunyah virtual machine, the host VM may gain capabilities
> to interact with resources for the guest virtual machine. Examples of
> such resources are vCPUs or message queues. To use those resources, we
> need to translate the RM response into a gunyah_resource structure which
> are useful to Linux drivers. Presently, Linux drivers need only to know
> the type of resource, the capability ID, and an interrupt.
> 
> On ARM64 systems, the interrupt reported by Gunyah is the GIC interrupt
> ID number and always a SPI or extended SPI.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  arch/arm64/include/asm/gunyah.h | 36 ++++++++++++++++++++++
>  drivers/virt/gunyah/rsc_mgr.c   | 67 +++++++++++++++++++++++++++++++++++++++++
>  drivers/virt/gunyah/rsc_mgr.h   |  5 +++
>  include/linux/gunyah.h          |  2 ++
>  4 files changed, 110 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/gunyah.h b/arch/arm64/include/asm/gunyah.h
> new file mode 100644
> index 0000000000000..0cd3debe22b64
> --- /dev/null
> +++ b/arch/arm64/include/asm/gunyah.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +#ifndef _ASM_GUNYAH_H
> +#define _ASM_GUNYAH_H
> +
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +
> +static inline int arch_gunyah_fill_irq_fwspec_params(u32 virq,
> +						 struct irq_fwspec *fwspec)
> +{
> +	/* Assume that Gunyah gave us an SPI or ESPI; defensively check it */
> +	if (WARN(virq < 32, "Unexpected virq: %d\n", virq)) {
> +		return -EINVAL;
> +	} else if (virq <= 1019) {
> +		fwspec->param_count = 3;
> +		fwspec->param[0] = 0; /* GIC_SPI */
> +		fwspec->param[1] = virq - 32; /* virq 32 -> SPI 0 */
> +		fwspec->param[2] = IRQ_TYPE_EDGE_RISING;
> +	} else if (WARN(virq < 4096, "Unexpected virq: %d\n", virq)) {
> +		return -EINVAL;
> +	} else if (virq < 5120) {
> +		fwspec->param_count = 3;
> +		fwspec->param[0] = 2; /* GIC_ESPI */
> +		fwspec->param[1] = virq - 4096; /* virq 4096 -> ESPI 0 */
> +		fwspec->param[2] = IRQ_TYPE_EDGE_RISING;
> +	} else {
> +		WARN(1, "Unexpected virq: %d\n", virq);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +

__get_intid_range() in gic-v3 driver looks more pleasing. Other than
that the logic for the translation looks good to me.

Thanks,
Pavan

