Return-Path: <linux-kernel+bounces-101269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EBB87A4D3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2301C20D37
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511A320309;
	Wed, 13 Mar 2024 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VNY9u517"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CD81BF3D;
	Wed, 13 Mar 2024 09:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710321676; cv=none; b=sDNulM/ee6sOJtXwf9lzHVTBWTs7je0hBPj3QQehhz3r5d+qpjhzGlyPhHE3PfpWH/ImXPuQN65D1eDxQHW1OqiCPFOTmMKSQXIZyOl6rTut9Nk3XyYu5PQY+FFEb3IJZ+S+YIpSy60RhKUjPa/uNz/Pz16NbuguMMc2p640Hbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710321676; c=relaxed/simple;
	bh=U4UJ1jKOg1j9hk50TUGhKBacc2FG/ZP9Ob3hP31vV6Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otsxB/rjP9rezxZiJTh6et17zE/mlz3wqV6Uuzbi29U9K5xICR1Ob8rFbHaAupN3xGBYCr8q6y6vCBoe3dSUwVz/8Lx3Il3rsPiD36hCjlLDZlOugENXxOKNgRFonPQnaTexJN1LFC6mjLd7H5BaktAAT7kUn6L0acLorJndXxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VNY9u517; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42D8Z0OJ006689;
	Wed, 13 Mar 2024 09:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:reply-to:references
	:mime-version:content-type:in-reply-to; s=qcppdkim1; bh=xP66Ihxb
	wHSzo3BS0aAaFRWAp/ZD5ZoLJGqOG2l+yeQ=; b=VNY9u5179yOH9zQvMevWSnz/
	RM1NRqncsGQ5WIRIZj6vZX97OjI58Ks4mLEIM1H9v/xGvV/4w/WOiz8U0FEU8mY2
	/V02Hwo10yptTQU9UhbOLdx3P1bmhDDtZgHk+L5E4eRRMBLi8+ZQy2czpUGUw9zv
	Iw+rsgM2eTzwweBMA9kK2L2yuqQmwQyDIqVGn2jeamrSAk9CLubDbY/uvWqaXieU
	Yojw1lzC6dviUlpzOTZNrzjkFU1XvYHawAZFiUbY8SG4OvE1SFsr55Y0Y4hsve8s
	ZDEi+8F0F9z9zOMAY8yq+PUmEiRCvZkyGeHSWIop2Phx4G+hvJmkgL4OgLkOEg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wtug01r5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 09:20:50 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42D9Knk9005016
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 09:20:49 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Mar
 2024 02:20:41 -0700
Date: Wed, 13 Mar 2024 14:50:37 +0530
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
Subject: Re: [PATCH v17 13/35] gunyah: vm_mgr: Add framework for VM Functions
Message-ID: <20240313092037.GO440762@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
 <20240222-gunyah-v17-13-1e9da6763d38@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20240222-gunyah-v17-13-1e9da6763d38@quicinc.com>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: W3OLSKAGZJ5FEm8fdz8CXglbYAd8OJN2
X-Proofpoint-ORIG-GUID: W3OLSKAGZJ5FEm8fdz8CXglbYAd8OJN2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_07,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=807 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403130068

* Elliot Berman <quic_eberman@quicinc.com> [2024-02-22 15:16:36]:

> Introduce a framework for Gunyah userspace to install VM functions. VM
> functions are optional interfaces to the virtual machine. vCPUs,
> ioeventfs, and irqfds are examples of such VM functions and are
> implemented in subsequent patches.
> 
> A generic framework is implemented instead of individual ioctls to
> create vCPUs, irqfds, etc., in order to simplify the VM manager core
> implementation and allow dynamic loading of VM function modules.
>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

Minor nit below. LGTM otherwise

Reviewed-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>

> +static struct gunyah_vm_function *gunyah_vm_get_function(u32 type)
> +{
> +	struct gunyah_vm_function *fn;
> +
> +	fn = xa_load(&gunyah_vm_functions, type);
> +	if (!fn) {
> +		request_module("ghfunc:%d", type);

s/%d/%u

> +
> +		fn = xa_load(&gunyah_vm_functions, type);
> +	}
> +
> +	if (!fn || !try_module_get(fn->mod))
> +		fn = ERR_PTR(-ENOENT);
> +
> +	return fn;
> +}

