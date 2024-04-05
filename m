Return-Path: <linux-kernel+bounces-133228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B4B89A0DB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E05BBB23D14
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD2D16F8F0;
	Fri,  5 Apr 2024 15:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mGBrHVle"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F3A16D9B3;
	Fri,  5 Apr 2024 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330336; cv=none; b=LyoGhpa9IJI9597tNwFRCJFyGgaexATbXDjwnoAnU/k0eFUl+2JNwAc9oJqGuDRYBHS+O+5ZOw8BnZht8qoHV8zC1cxfcO2J3Z4hpM24zpGFlZyAtVns9+xwjxI96or6MTgXy/nj7TPpxsyyD8H1rEc4HqoJX8QINA345XNI8as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330336; c=relaxed/simple;
	bh=UYOdpa/8pHqVym6VpaSkDbZAqFnWlJYd8BjyiDqqpn4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mv5qSAieo5OnC8zsL3YtKs0DqVho8XED9EQ0UIwEOEhoEeDXQxWtPot3r9CiT4/B84a51Lu69QBB6BOHfT6kUbRS8M7kTs51DQ73oImoiUrhDd5f8M8lxfeVfvSB+SXQ9VVMZq88kD2lxqdkv5ahaJZXcQ1gfK/oV4xzHra/Fag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mGBrHVle; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435Ahedp005076;
	Fri, 5 Apr 2024 15:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=ncxB/ucen8xf9GK05q5WG
	n6xgxfyQW7w7MNwVaEY0yE=; b=mGBrHVleu+oRXvjsJqfkGxbHF6mYf1L1VcNGw
	WrsqFsAgGvblTGLGxDzR0eTUecPf47Kt9Q1oYsiYyIYnbO9+jqFeDAIMZ9RjHXXI
	e38H1x1ahk2N1f0jZAXzJ4egTxNj27rqqRutoec/a9gqViUYMu2VnyczjpS6MtKr
	E1HWbk6nWHBMWN7s+X/ZCZficNd17JEzA2+wFI+ccKh8pTVurRLwrpyuWkceHuiD
	R9aANR87MC0K8oCF6mmtBYf6qM6vI4RKIT7s7x5YGft5qlpkbxujVTHT+6EDczNM
	gKOgx5/VDUGeiA+OOA8BC+JmQ4RT1FySQEzYsL9PvBadTZnsA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa8fc1hk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 15:18:32 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 435FIVbG026932
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 15:18:31 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 5 Apr 2024 08:18:30 -0700
Date: Fri, 5 Apr 2024 08:18:30 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Pavan Kondeti <quic_pkondeti@quicinc.com>
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
Message-ID: <20240405081735319-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
 <20240222-gunyah-v17-11-1e9da6763d38@quicinc.com>
 <ff6a3fb2-5f1a-4baa-b42a-a7767e92885a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ff6a3fb2-5f1a-4baa-b42a-a7767e92885a@quicinc.com>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CjpQNiJgepbUe_PWBObBh6vdhvVm1JNM
X-Proofpoint-ORIG-GUID: CjpQNiJgepbUe_PWBObBh6vdhvVm1JNM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_16,2024-04-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=901 bulkscore=0 suspectscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404050110

On Fri, Apr 05, 2024 at 08:40:40AM +0530, Pavan Kondeti wrote:
> On Thu, Feb 22, 2024 at 03:16:34PM -0800, Elliot Berman wrote:
> > When booting a Gunyah virtual machine, the host VM may gain capabilities
> > to interact with resources for the guest virtual machine. Examples of
> > such resources are vCPUs or message queues. To use those resources, we
> > need to translate the RM response into a gunyah_resource structure which
> > are useful to Linux drivers. Presently, Linux drivers need only to know
> > the type of resource, the capability ID, and an interrupt.
> > 
> > On ARM64 systems, the interrupt reported by Gunyah is the GIC interrupt
> > ID number and always a SPI or extended SPI.
> > 
> > Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> > ---
> >  arch/arm64/include/asm/gunyah.h | 36 ++++++++++++++++++++++
> >  drivers/virt/gunyah/rsc_mgr.c   | 67 +++++++++++++++++++++++++++++++++++++++++
> >  drivers/virt/gunyah/rsc_mgr.h   |  5 +++
> >  include/linux/gunyah.h          |  2 ++
> >  4 files changed, 110 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/gunyah.h b/arch/arm64/include/asm/gunyah.h
> > new file mode 100644
> > index 0000000000000..0cd3debe22b64
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/gunyah.h
> > @@ -0,0 +1,36 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> > + */
> > +#ifndef _ASM_GUNYAH_H
> > +#define _ASM_GUNYAH_H
> > +
> > +#include <linux/irq.h>
> > +#include <linux/irqdomain.h>
> > +
> > +static inline int arch_gunyah_fill_irq_fwspec_params(u32 virq,
> > +						 struct irq_fwspec *fwspec)
> > +{
> > +	/* Assume that Gunyah gave us an SPI or ESPI; defensively check it */
> > +	if (WARN(virq < 32, "Unexpected virq: %d\n", virq)) {
> > +		return -EINVAL;
> > +	} else if (virq <= 1019) {
> > +		fwspec->param_count = 3;
> > +		fwspec->param[0] = 0; /* GIC_SPI */
> > +		fwspec->param[1] = virq - 32; /* virq 32 -> SPI 0 */
> > +		fwspec->param[2] = IRQ_TYPE_EDGE_RISING;
> > +	} else if (WARN(virq < 4096, "Unexpected virq: %d\n", virq)) {
> > +		return -EINVAL;
> > +	} else if (virq < 5120) {
> > +		fwspec->param_count = 3;
> > +		fwspec->param[0] = 2; /* GIC_ESPI */
> > +		fwspec->param[1] = virq - 4096; /* virq 4096 -> ESPI 0 */
> > +		fwspec->param[2] = IRQ_TYPE_EDGE_RISING;
> > +	} else {
> > +		WARN(1, "Unexpected virq: %d\n", virq);
> > +		return -EINVAL;
> > +	}
> > +	return 0;
> > +}
> > +
> 
> __get_intid_range() in gic-v3 driver looks more pleasing. Other than
> that the logic for the translation looks good to me.

Agreed, updated for v18.

static inline int arch_gunyah_fill_irq_fwspec_params(u32 virq,
						 struct irq_fwspec *fwspec)
{
	/* Assume that Gunyah gave us an SPI or ESPI; defensively check it */
	switch (virq) {
	case 32 ... 1019:
		fwspec->param_count = 3;
		fwspec->param[0] = 0; /* GIC_SPI */
		fwspec->param[1] = virq - 32; /* virq 32 -> SPI 0 */
		fwspec->param[2] = IRQ_TYPE_EDGE_RISING;
		break;
	case 4096 ... 5119:
		fwspec->param_count = 3;
		fwspec->param[0] = 2; /* GIC_ESPI */
		fwspec->param[1] = virq - 4096; /* virq 4096 -> ESPI 0 */
		fwspec->param[2] = IRQ_TYPE_EDGE_RISING;
		break;
	default:
		WARN(1, "Unexpected virq: %d\n", virq)
		return -EINVAL;
	}
	return 0;
}


