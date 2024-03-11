Return-Path: <linux-kernel+bounces-98485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB961877AB5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587F41F214E5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C72CA47;
	Mon, 11 Mar 2024 05:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fEAv3/aM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507961118B;
	Mon, 11 Mar 2024 05:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710135572; cv=none; b=d3N2ttZliWV+45+4xpI5JWIGGx/ycd/HcvEiGfAkol/ORwtvJl0hI8f5G9iB04tifSU5zVCHLbLPw8AXqBDRo34ShGEX5/ZwWnIIUSkhaceiPe+NnarrJPgXYPFzAhdJ5jP7QOCSohTzsj0A69QXR7uFOd+2S4g1h4KvWBSzxHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710135572; c=relaxed/simple;
	bh=Ka56Z2TcjSC1k5aIslx4wiCYsvuC+7+F9E44sweIR+I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChoDw6seYju4CmMTdx+blePUa9epCi5dThZTCqGsTYFrkBA0dhJptD5o68Af/DoZ5SM0uukZzU8pbcYWhc2jZxMWBBkh8s+/oOkljVePhfv61WPZc84WZ//aESwMZUTut6jnmYunvE97DvQ71u+1u+VPfd2fTXvWUB9Lxl2pomc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fEAv3/aM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B4SW71008209;
	Mon, 11 Mar 2024 05:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:reply-to:references
	:mime-version:content-type:in-reply-to; s=qcppdkim1; bh=LmmM6Mle
	Qg7vLFazyHImNbnBaOz3grFitf91olyQU6M=; b=fEAv3/aMWYtirJq0zXcH6ajx
	/kugt7oM1cJHlSZFFqb+0tdx3T97wpaXwBbUanXlVd0IgS+grYfEk0Hg+Ky1EHMQ
	xVWUXnVhXHf+L3uhiYPhxJBVy1fqIhoiqiXJlkZiFD4zGrjCOWFVRtRjTCawtama
	RaAWyPiyvaGQ0OfbRI4qPMSPg2KVvb2dxYhqEWhK4vyhUzWcOI7ykwqjF5AyfjHe
	dm007Y6/PMTGVyj903ZYKssWWn3uFOXJ3U7wh91WrOCBW4YyramNz7olKy3cSUUI
	O0pA+duiisZo+Y4ErjTAoSS7bU0CcLbeZvQc61KEhfYuFiptnRyJd/oOUREaUg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wss1gr81p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 05:39:17 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42B5dG9l024078
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 05:39:16 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 10 Mar
 2024 22:39:08 -0700
Date: Mon, 11 Mar 2024 11:09:05 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: Elliot Berman <quic_eberman@quicinc.com>
CC: Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>,
        Murali Nalajal <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Carl van Schaik
	<quic_cvanscha@quicinc.com>,
        Philip Derrin <quic_pderrin@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet
	<corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <20240311053905.GN440762@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
 <20240222-gunyah-v17-11-1e9da6763d38@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20240222-gunyah-v17-11-1e9da6763d38@quicinc.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: V2xhelRylHxeRMVsunfbTeMlRPUvSRSA
X-Proofpoint-GUID: V2xhelRylHxeRMVsunfbTeMlRPUvSRSA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_02,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=559
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403110041

* Elliot Berman <quic_eberman@quicinc.com> [2024-02-22 15:16:34]:

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

Minor nit below. LGTM otherwise

Reviewed-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>

> +struct gunyah_resource *
> +gunyah_rm_alloc_resource(struct gunyah_rm *rm,
> +			 struct gunyah_rm_hyp_resource *hyp_resource)
> +{
> +	struct gunyah_resource *ghrsc;
> +	int ret;
> +
> +	ghrsc = kzalloc(sizeof(*ghrsc), GFP_KERNEL);
> +	if (!ghrsc)
> +		return NULL;
> +
> +	ghrsc->type = hyp_resource->type;
> +	ghrsc->capid = le64_to_cpu(hyp_resource->cap_id);
> +	ghrsc->irq = IRQ_NOTCONNECTED;
> +	ghrsc->rm_label = le32_to_cpu(hyp_resource->resource_label);
> +	if (hyp_resource->virq) {
> +		struct irq_fwspec fwspec;
> +
> +
> +		fwspec.fwnode = rm->parent_fwnode;
> +		ret = arch_gunyah_fill_irq_fwspec_params(le32_to_cpu(hyp_resource->virq), &fwspec);
> +		if (ret) {
> +			dev_err(rm->dev,
> +				"Failed to translate interrupt for resource %d label: %d: %d\n",
> +				ghrsc->type, ghrsc->rm_label, ret);

Not bailing on error here appears wrong. Can you check?

> +		}
> +
> +		ret = irq_create_fwspec_mapping(&fwspec);
> +		if (ret < 0) {
> +			dev_err(rm->dev,
> +				"Failed to allocate interrupt for resource %d label: %d: %d\n",
> +				ghrsc->type, ghrsc->rm_label, ret);
> +			kfree(ghrsc);
> +			return NULL;
> +		}
> +		ghrsc->irq = ret;
> +	}
> +
> +	return ghrsc;
> +}

