Return-Path: <linux-kernel+bounces-79370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDE0862146
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7F41C24842
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D5B4416;
	Sat, 24 Feb 2024 00:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NHes8mXW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7334C139D;
	Sat, 24 Feb 2024 00:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708735067; cv=none; b=XtxTKGWUuoCnpYjnJkuQRWHYRAMIKljbyEaED9Esn9ucMFt+3RcXJTG9Ay+sid0f5nFLAWSckNPKE/MbDwLLnalsNtIZCFAIYj7K+Zqz/8kNFT6bsoKmtVieToSxaajGobl5VevlowIMb5FMbVvWKH3KScyY2jLIAXO+NL2bQDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708735067; c=relaxed/simple;
	bh=o+dopF+3QwhP/VzUwOvK66g+AD4WW3W8duM1P1rkaZA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNKne2VT+JxzDd3KuQ80VT2KabSgWJ4ewknGH/nxvzLBz0CZmRmlAFy9QuvoV6UiTxezxUq95aEjBWK+wiRJ2fRsypkWIdqJ7fhXj7TFFLx/pagZ15rVLadHp3oqrZ1DLnt/nH/zHODXYpbE/2T+NqqtKqR0wsI5lm8e0odMBJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NHes8mXW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41O0KQ2Y031296;
	Sat, 24 Feb 2024 00:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=TAeKBPeqKN87BGLYsho5A
	H76OwarAu5agw9ZvchmLfo=; b=NHes8mXWQwz+Zos60T+OXib+qAd5JkD7dW26c
	MImKO0FPFpCh58zeMhEvB09Tze2Ok9lYUzTEDazN+cROyP+yDbWzhVOReN3A3k9s
	r4wto++of7SWLXR3tiuMBVXHJXY0z+mrC65Jy5gTawMM3miTNhaU9EpJnyLz5qGA
	RDr9zor2WwX/ssKl4UrzuiOR8MhZB/vnB5gKsCmkttGxsfg7tG3XwxWsjnU1wFDz
	BprDCg64EDrhfjZGil1A5Lr5orGF/+SVq1/h4/6yjuJ+5Pe64Ug4PTtKR6FXT/6K
	dVTkNTzNzEoXmPEYb6ctfQu3+dk92VKi7A5oBTLFKwHLkocgw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wf5tt80mr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Feb 2024 00:37:25 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41O0bOEZ019289
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Feb 2024 00:37:24 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 16:37:23 -0800
Date: Fri, 23 Feb 2024 16:37:23 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
To: Christoph Hellwig <hch@infradead.org>, Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Chris Goldsworthy
	<quic_cgoldswo@quicinc.com>,
        Android KVM <android-kvm@google.com>,
        "Patrick
 Daly" <quic_pdaly@quicinc.com>
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
Subject: Re: Re: [PATCH v17 19/35] arch/mm: Export direct {un,}map functions
Message-ID: <20240223071006483-0800.eberman@hu-eberman-lv.qualcomm.com>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, 
	Will Deacon <will@kernel.org>, Quentin Perret <qperret@google.com>, 
	Chris Goldsworthy <quic_cgoldswo@quicinc.com>, Android KVM <android-kvm@google.com>, 
	Patrick Daly <quic_pdaly@quicinc.com>, Alex Elder <elder@linaro.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Murali Nalajal <quic_mnalajal@quicinc.com>, 
	Trilok Soni <quic_tsoni@quicinc.com>, Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>, 
	Carl van Schaik <quic_cvanscha@quicinc.com>, Philip Derrin <quic_pderrin@quicinc.com>, 
	Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>, Jonathan Corbet <corbet@lwn.net>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
 <20240222-gunyah-v17-19-1e9da6763d38@quicinc.com>
 <ZdhEtH7xzbzdhS2j@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZdhEtH7xzbzdhS2j@infradead.org>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gNcA6io5WictnmGGjeI8Vk68WZWdapO8
X-Proofpoint-GUID: gNcA6io5WictnmGGjeI8Vk68WZWdapO8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_07,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 spamscore=0 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402240001

On Thu, Feb 22, 2024 at 11:09:40PM -0800, Christoph Hellwig wrote:
> On Thu, Feb 22, 2024 at 03:16:42PM -0800, Elliot Berman wrote:
> > Firmware and hypervisor drivers can donate system heap memory to their
> > respective firmware/hypervisor entities. Those drivers should unmap the
> > pages from the kernel's logical map before doing so.
> > 
> > Export can_set_direct_map, set_direct_map_invalid_noflush, and
> > set_direct_map_default_noflush.
> 
> Err, not they should not.  And not using such super low-level interfaces
> from modular code.

Hi Cristoph,
 
We've observed a few times that Linux can unintentionally access a page
we've unmapped from host's stage 2 page table via an unaligned load from
an adjacent page. The stage 2 is managed by Gunyah. There are few
scenarios where even though we allocate and own a page from buddy,
someone else could try to access the page without going through the
hypervisor driver. One such instance we know about is
load_unaligned_zeropad() via pathlookup_at() [1].
 
load_unaligned_zeropad() could be called near the end of a page. If the
next page isn't mapped by the kernel in the stage one page tables, then
the access from to the unmapped page from load_unaligned_zeropad() will
land in __do_kernel_fault(), call fixup_exception(), and fill the
remainder of the load with zeroes. If the page in question is mapped in
stage 1 but was unmapped from stage 2, then the access lands back in
Linux in do_sea(), leading to a panic().
 
Our preference would be to add fixup_exception() to S2 PTW errors for
two reasons:
1. It's cheaper to do performance wise: we've already manipulated S2
   page table and prevent intentional access to the page because
   pKVM/Gunyah drivers know that access to the page has been lost.
2. Page-granular S1 mappings only happen on arm64 with rodata=full.
 
In an off-list discussion with the Android pkvm folks, their preference
was to have the pages unmapped from stage 1. I've gone with that
approach to get started but welcome discussion on the best approach.
 
The Android (downstream) implementation of arm64 pkvm is currently
implementing a hack where s2 ptw faults are given back to the host as s1
ptw faults (i.e. __do_kernel_fault() gets called and not do_sea()) --
allowing the kernel to fixup the exception.
 
arm64 pKVM will also face this issue when implementing guest_memfd or
when donating more memory to the hyp for s2 page tables, etc. As far as
I can tell, this isn't an issue for arm64 pKVM today because memory
isn't being dynamically donated to the hypervisor.
 
Thanks,
Elliot

[1]:
path_lookupat+0x340/0x3228
filename_lookup+0xbc/0x1c0
__arm64_sys_newfstatat+0xb0/0x4a0
invoke_syscall+0x58/0x118


