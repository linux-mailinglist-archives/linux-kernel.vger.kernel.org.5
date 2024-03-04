Return-Path: <linux-kernel+bounces-91410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 568F3871123
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3B51C21BC7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0057CF26;
	Mon,  4 Mar 2024 23:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YgBG4vkN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FF97CF1F;
	Mon,  4 Mar 2024 23:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709595501; cv=none; b=Ri8zFkdXQyzjM3GnP5RQFTZPXhirT7DC+w7PNPQGamNeaDRAx3edWNo5SaL2N9IlbSYbCms5fzSBLZWuiesFpQ5E9H6HaoNMvOv3L3s1GguofS8IIs/AWv+emwySa4k4RbYbvEDLQneUPzKsHehR5+Yno5AJE2r6dp0fumwAXpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709595501; c=relaxed/simple;
	bh=bjapdOzSpG6/EEi9GeF2HdEhMLKu2TdtZOkHv8LOaro=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Esumc27XnIH2X4MOD/cvrSx4wImrdN0QAscpSa14LkvXgI+LXGkOWbhzTMlAUn6yOE3KIgnwXYifYQe4omj0GEg7uqxL6sEJvpdtDWeJodWCX3YI8oyHhW/4i/TKHxFncYP1uQ0yI422AHQmKuMDlBQC36VTc9O1pX5UU7YapNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YgBG4vkN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 424NSdCb005853;
	Mon, 4 Mar 2024 23:37:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=uKjDd80FGy/SXXVWkcCr2
	CwjDneS2/5OgR/fSz8cyMA=; b=YgBG4vkN7z+ndBrQN2oDjS0orZ/i3gPbP8Weu
	nrwmrnVhXZumPT8H7vablWKclm+7KXfO9eIUBhMYjQiUmM1Y/2QOGR0tmz65hFns
	w5QxnW+Gaz8vSIqjO5r+OsnyHpjecgr3n2CChPrAJPs9zqCqAfU00O1vFkYieTrK
	A6u+JJ+IjLQc/5RxSGnuAS9MzDpAOlAYklXN/fHj1WqJgCKUGuUiZIywL4OorbnJ
	/z8dKn416B+iZisK6J/sAcM+MC2ejJrsZiUcjVrewGKciKIrvIIcoLuWn5bZ9Wao
	tgkxaTlmhR/9U5iLUwt3/CCWmGHuvv41uNwSImj+FGtQnKybw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wnjtbgr6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 23:37:52 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 424NbhGk018095
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Mar 2024 23:37:43 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Mar 2024 15:37:42 -0800
Date: Mon, 4 Mar 2024 15:37:41 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
To: Quentin Perret <qperret@google.com>
CC: Christoph Hellwig <hch@infradead.org>, Will Deacon <will@kernel.org>,
        Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        Android KVM
	<android-kvm@google.com>,
        Patrick Daly <quic_pdaly@quicinc.com>, Alex Elder
	<elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Murali Nalajal <quic_mnalajal@quicinc.com>,
        Trilok Soni
	<quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Philip Derrin
	<quic_pderrin@quicinc.com>,
        Prakruthi Deepak Heragu
	<quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Dmitry
 Baryshkov" <dmitry.baryshkov@linaro.org>,
        Fuad Tabba <tabba@google.com>,
        "Sean Christopherson" <seanjc@google.com>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>
Subject: Re: Re: Re: [PATCH v17 19/35] arch/mm: Export direct {un,}map
 functions
Message-ID: <20240304094828133-0800.eberman@hu-eberman-lv.qualcomm.com>
Mail-Followup-To: Quentin Perret <qperret@google.com>, 
	Christoph Hellwig <hch@infradead.org>, Will Deacon <will@kernel.org>, 
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
 <20240223071006483-0800.eberman@hu-eberman-lv.qualcomm.com>
 <ZeXIWBLVWzVycm0r@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZeXIWBLVWzVycm0r@google.com>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sjPu5sIWWRGDh-oe0xUU5hU_E0NcZLdz
X-Proofpoint-ORIG-GUID: sjPu5sIWWRGDh-oe0xUU5hU_E0NcZLdz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_18,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403040182

On Mon, Mar 04, 2024 at 01:10:48PM +0000, Quentin Perret wrote:
> On Friday 23 Feb 2024 at 16:37:23 (-0800), Elliot Berman wrote:
> > On Thu, Feb 22, 2024 at 11:09:40PM -0800, Christoph Hellwig wrote:
> > > On Thu, Feb 22, 2024 at 03:16:42PM -0800, Elliot Berman wrote:
> > > > Firmware and hypervisor drivers can donate system heap memory to their
> > > > respective firmware/hypervisor entities. Those drivers should unmap the
> > > > pages from the kernel's logical map before doing so.
> > > > 
> > > > Export can_set_direct_map, set_direct_map_invalid_noflush, and
> > > > set_direct_map_default_noflush.
> > > 
> > > Err, not they should not.  And not using such super low-level interfaces
> > > from modular code.
> > 
> > Hi Cristoph,
> >  
> > We've observed a few times that Linux can unintentionally access a page
> > we've unmapped from host's stage 2 page table via an unaligned load from
> > an adjacent page. The stage 2 is managed by Gunyah. There are few
> > scenarios where even though we allocate and own a page from buddy,
> > someone else could try to access the page without going through the
> > hypervisor driver. One such instance we know about is
> > load_unaligned_zeropad() via pathlookup_at() [1].
> >  
> > load_unaligned_zeropad() could be called near the end of a page. If the
> > next page isn't mapped by the kernel in the stage one page tables, then
> > the access from to the unmapped page from load_unaligned_zeropad() will
> > land in __do_kernel_fault(), call fixup_exception(), and fill the
> > remainder of the load with zeroes. If the page in question is mapped in
> > stage 1 but was unmapped from stage 2, then the access lands back in
> > Linux in do_sea(), leading to a panic().
> >  
> > Our preference would be to add fixup_exception() to S2 PTW errors for
> > two reasons:
> > 1. It's cheaper to do performance wise: we've already manipulated S2
> >    page table and prevent intentional access to the page because
> >    pKVM/Gunyah drivers know that access to the page has been lost.
> > 2. Page-granular S1 mappings only happen on arm64 with rodata=full.
> >  
> > In an off-list discussion with the Android pkvm folks, their preference
> > was to have the pages unmapped from stage 1. I've gone with that
> > approach to get started but welcome discussion on the best approach.
> >  
> > The Android (downstream) implementation of arm64 pkvm is currently
> > implementing a hack where s2 ptw faults are given back to the host as s1
> > ptw faults (i.e. __do_kernel_fault() gets called and not do_sea()) --
> > allowing the kernel to fixup the exception.
> >  
> > arm64 pKVM will also face this issue when implementing guest_memfd or
> > when donating more memory to the hyp for s2 page tables, etc. As far as
> > I can tell, this isn't an issue for arm64 pKVM today because memory
> > isn't being dynamically donated to the hypervisor.
> 
> FWIW pKVM already donates memory dynamically to the hypervisor, to store
> e.g. guest VM metadata and page-tables, and we've never seen that
> problem as far as I can recall.
> 
> A key difference is that pKVM injects a data abort back into the kernel
> in case of a stage-2 fault, so the whole EXTABLE trick/hack in
> load_unaligned_zeropad() should work fine out of the box.
> 
> As discussed offline, Gunyah injecting an SEA into the kernel is
> questionable, but I understand that the architecture is a bit lacking in
> this department, and that's probably the next best thing.
>
> Could the Gunyah driver allocate from a CMA region instead? That would
> surely simplify unmapping from EL1 stage-1 (similar to how drivers
> usually donate memory to TZ).

In my opinion, CMA is overly restrictive because we'd have to define the
region up front and we don't know how much memory the virtual machines
the user will want to launch.

Thanks,
Elliot


