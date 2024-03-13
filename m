Return-Path: <linux-kernel+bounces-101271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C462287A4E0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A2F7281F5F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3735A20B3D;
	Wed, 13 Mar 2024 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dVGZ6Q/1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156091C6AB;
	Wed, 13 Mar 2024 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710321722; cv=none; b=jhrrJYy05RbcjzoEPAfQnsMVcVyg+248mXM/EeXfqItg4n6c3ahZtlAI84hZCMX2BWmTiE/ExFETeRosPPNv7EHSaAXtsNBAK9H+8KkQnwFj5CF95RaD/Hi5H8jrR35kp2Urr46IJYNxjtJSIHjRvP8RKcX7Xc29n23al8Lpjnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710321722; c=relaxed/simple;
	bh=raw2+FfisWfJFT08qDnQBVO8iyFRrffzMxBYqyLrj7w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4pYfN/S9osPJv3G94cXTjs/8TGav1drpeNVzX6g21QcQbedcYyvGSaX9C8eXo3bA1ESWgjrbUmyj5b9M3441cSDRVle8Q6X9opo64GVNtnRyQKfP9t6hD87mDYoooqlvngFSxrrJn8Y9UwQp9rMAi0U9LK+8hFOUEZm42Kx9NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dVGZ6Q/1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42D7jkRh028610;
	Wed, 13 Mar 2024 09:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:reply-to:references
	:mime-version:content-type:in-reply-to; s=qcppdkim1; bh=Ddp2qo1i
	6qR7lu69JmjaNBMJT0pRYnEyFux1jrc2EUQ=; b=dVGZ6Q/1X8Ad5jO7soDJJuGP
	wvxN5UQ/OqGTdYhRGp1s94c6TL3xTfQlCZHnzDjPquaMDlmo1cjFH9zoAfd5O0mi
	ZCAwCPv6/l4uL3zZUC0TFhaJzOz6aZCyH8JZCjKGRFClyVSpQa4S5h37H0sIxDQ3
	y+0XugGZIch4weB38Yb6CynlGuJjJIlSqa82KUQK3n/sZSW6kgWf64eznrQCwVU4
	XoptEYBurXHAAl46fsjbuAm5Lvv2uJ+Uj1MvdKbRr6yjcwmSUKTBfjnR2QJdmORy
	Mta5DQEtcJZXBeNIaigpWODaV8dUy/Jf75GjBWMMqlrz/RzYLN+hmER9jTWM/A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wu81m06vv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 09:21:46 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42D9Lj6X002981
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 09:21:45 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Mar
 2024 02:21:38 -0700
Date: Wed, 13 Mar 2024 14:51:33 +0530
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
Subject: Re: [PATCH v17 15/35] virt: gunyah: Add proxy-scheduled vCPUs
Message-ID: <20240313092133.GQ440762@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
 <20240222-gunyah-v17-15-1e9da6763d38@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20240222-gunyah-v17-15-1e9da6763d38@quicinc.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Q94xi6VH8SfTFSLQi7xRGsS-lVQu-XnL
X-Proofpoint-GUID: Q94xi6VH8SfTFSLQi7xRGsS-lVQu-XnL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_07,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 suspectscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403130068

* Elliot Berman <quic_eberman@quicinc.com> [2024-02-22 15:16:38]:

> Gunyah allows vCPUs that are configured as proxy-scheduled to be scheduled by
> another virtual machine (host) that holds capabilities to those vCPUs with
> suitable rights.
> 
> Gunyah also supports configuring regions of a proxy-scheduled VM's address
> space to be virtualized by the host VM. This permits a host VMM to emulate MMIO
> devices in the proxy-scheduled VM.
> 
> vCPUs are presented to the host as a Gunyah resource and represented to
> userspace as a Gunyah VM function.
> 
> Creating the vcpu function on the VM will create a file descriptor that:
>  - can handle an ioctl to run the vCPU. When called, Gunyah will directly
>    context-switch to the selected vCPU and run it until one of the following
>    events occurs:
>     * the host vcpu's time slice ends
>     * the host vcpu receives an interrupt or would have been pre-empted
>       by the hypervisor
>     * a fault occurs in the proxy-scheduled vcpu
>     * a power management event, such as idle or cpu-off call in the vcpu
>  - can be mmap'd to share the gunyah_vcpu_run structure with userspace. This
>    allows the vcpu_run result codes to be accessed, and for arguments to
>    vcpu_run to be passed, e.g. for resuming the vcpu when handling certain fault
>    and exit cases.
> 
> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

LGTM

Reviewed-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>

- vatsa

