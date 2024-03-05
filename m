Return-Path: <linux-kernel+bounces-92188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6ADA871C6E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52AE31F25B11
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA32F5CDC5;
	Tue,  5 Mar 2024 10:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KvjwfHYP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8740B548E0;
	Tue,  5 Mar 2024 10:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636022; cv=none; b=eCW8tTv6lmk5QekYsLTSNKtU8rQFqgdLyyRFXK5P+2rYIjvVPhgqdEZdqjpD+uMNm741+LIzennOLRbK6i7NdMxAopxi0KYe4N6Rw8jQnPZBJM59tfmrWZsCkDQIEGlXm4c39QwmD1NasqpXZ2HejDwsNhme+r/9po85/96WORE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636022; c=relaxed/simple;
	bh=+EDeY2yT2n/cIzmd+Fwdxy+Nb2MpMS4znvqdlwWBR9E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBdJ56HZ8BvsBfWJxDaXIP1dgczhpmLtC8Y0BdHKwres1lT+Sp8Ct0ZEKq7iQ9qucgh0yYLx09mV5PJ7/30ohcxRBXY6AuddXEnxGIeJx6bnLPxQ49zndK8e1KljPmOPDDtjbXYYn3mK7zWsteuN0jPc1o3wcsICSUFq7UXvhyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KvjwfHYP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4258cUul014068;
	Tue, 5 Mar 2024 10:53:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=xiVexQtak33mp1KuoCuep
	OlA2edRPR1tpbMxzI9BHVY=; b=KvjwfHYPrmlHqli1tRWm2GhLJEdakPWXjivsE
	s427SYHZQ34BHDEjEZm5mCGI8GlvQvzkEb1C+srNBsR71fioWZylU1ve03x91M9h
	Rq/gt0XeQB8UK9nlevn5SsVBd093VJT2OJK7k5lzNXZNoHoMEaonPb6+j6fRQgYZ
	ki41oI46rgUTv2yYrrvAXm/Mecof47hWXSpEp0PP2NTeT58GvRqo2XaRKcWB1Vhi
	ZFP2CeiiX88a60XZQ5tKkO7hjHVg4f17dKUaAGqt33SxKtmaFIbD6Yn0uh9IFKzA
	AMsZKKRiy49Ua6wilU6IWKLHb+RTs9wQu1e0fliAPtmw1Z5gw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wp028892c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 10:53:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 425ArMGH012399
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 10:53:22 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Mar 2024 02:53:14 -0800
Date: Tue, 5 Mar 2024 16:23:12 +0530
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
Subject: Re: [PATCH v17 01/35] docs: gunyah: Introduce Gunyah Hypervisor
Message-ID: <6f98238d-25d9-4120-810a-4b8b19c1ef5d@quicinc.com>
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
 <20240222-gunyah-v17-1-1e9da6763d38@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240222-gunyah-v17-1-1e9da6763d38@quicinc.com>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WVHQJJ_TVjtAPqZKVZkx35bx7TCdrEtx
X-Proofpoint-ORIG-GUID: WVHQJJ_TVjtAPqZKVZkx35bx7TCdrEtx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_08,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=248 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 mlxscore=0 clxscore=1011 bulkscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403050087

On Thu, Feb 22, 2024 at 03:16:24PM -0800, Elliot Berman wrote:
> Gunyah is an open-source Type-1 hypervisor developed by Qualcomm. It
> does not depend on any lower-privileged OS/kernel code for its core
> functionality. This increases its security and can support a smaller
> trusted computing based when compared to Type-2 hypervisors.

%s/based/base

> 
> Add documentation describing the Gunyah hypervisor and the main
> components of the Gunyah hypervisor which are of interest to Linux
> virtualization development.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> +- Virtual platform:
> +
> +  Architectural devices such as interrupt controllers and CPU timers are
> +  directly provided by the hypervisor as well as core virtual platform devices
> +  and system APIs such as ARM PSCI.
> +
> +- Device Virtualization:
> +
> +  Para-virtualization of devices is supported using inter-VM communication and
> +  virtio transport support. Select stage 2 faults by virtual machines that use

%s/Select/Selected

> +  proxy-scheduled vCPUs can be handled directly by Linux to provide Type-2
> +  hypervisor style on-demand paging and/or device emulation.
> +


The doc patch looks good to me.

Thanks,
Pavan

