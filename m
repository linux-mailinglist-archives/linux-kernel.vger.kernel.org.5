Return-Path: <linux-kernel+bounces-87779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 834C386D8EE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 129D0283672
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588492E415;
	Fri,  1 Mar 2024 01:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c7UFXKtO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34024A92E;
	Fri,  1 Mar 2024 01:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709256971; cv=none; b=m7zhoKgNuzGvjOJiz3O8bVlS5HGu4SKxJ+c7funvTe7ISWC7fcfMd8x0X5L791hyp2yh5v2bPrQMYPgaBQ8exialYJJnMzHJ8LP9RfyLK2V5axJj1s158uTyJ4jasxy3vZnd1n9sIjPgoVPJj4rWnrAXqjdaEjMAT0ZO9LEQRA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709256971; c=relaxed/simple;
	bh=lnWUWgTACekg7SxM68wQvGPTavjyMmJFPT+m1gI3OdU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a02xOODT9+5U+m7GA2UzzVvh8y2oztkN+M5f8amz1YkMUfOj+hVR8H0BM7omdDIA3xgNxefZmznP2xaLKmDIlqEvWRSMNK8FsLn71uRAtE5cTIK3FGWlICJ/fIQP4G+VDrcrwyqXMwyv5lfQUNxsQ30qDKh21bZxnR4v9tnXx7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c7UFXKtO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41TEQpkM006786;
	Fri, 1 Mar 2024 01:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=TtHNnTfGoMKg5efEVBnGq
	6NLMyaY4z6AKIS0EWb8b0s=; b=c7UFXKtONcJtN6LV0x+OL5V7yrZXGu59BzQKX
	LWMwCrvJmYd/hSonLiwG7dDdZ+M0V+TCrJYW3aUJ5qKNXpsTUB6xptdTVglYKVjr
	Ej2UHzevU5p0RNcumlKmSujtgrm46wxF518KGPvKCt67SwXuBL9B9LfECWpPwU4j
	InVfdIT0OzttKH2+fWcXrECDDzwsy+/4kh7qqp8fLy/Jkhv5OHBm7pg4zXnqwr2P
	QRW9LLuE+3v/QAJubXyk7Qn/KdO/JbHpU1SKRdoEn1nNTc4ae3kyxVzSErRxkxaw
	PV7dpP/YdiSVP3+a2l8RVY4IZZNP4O8I/dT34XmEYQTlNPomQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wjupp1sgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 01:35:47 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4211ZkLN012568
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Mar 2024 01:35:46 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 29 Feb 2024 17:35:45 -0800
Date: Thu, 29 Feb 2024 17:35:45 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
To: David Hildenbrand <david@redhat.com>
CC: Christoph Hellwig <hch@infradead.org>, Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Chris Goldsworthy
	<quic_cgoldswo@quicinc.com>,
        Android KVM <android-kvm@google.com>,
        "Patrick
 Daly" <quic_pdaly@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        "Srinivas
 Kandagatla" <srinivas.kandagatla@linaro.org>,
        Murali Nalajal
	<quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa
 Vaddagiri" <quic_svaddagi@quicinc.com>,
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
Subject: Re: Re: [PATCH v17 19/35] arch/mm: Export direct {un,}map functions
Message-ID: <20240229170329275-0800.eberman@hu-eberman-lv.qualcomm.com>
Mail-Followup-To: David Hildenbrand <david@redhat.com>, 
	Christoph Hellwig <hch@infradead.org>, Will Deacon <will@kernel.org>, 
	Quentin Perret <qperret@google.com>, Chris Goldsworthy <quic_cgoldswo@quicinc.com>, 
	Android KVM <android-kvm@google.com>, Patrick Daly <quic_pdaly@quicinc.com>, 
	Alex Elder <elder@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Murali Nalajal <quic_mnalajal@quicinc.com>, Trilok Soni <quic_tsoni@quicinc.com>, 
	Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>, Carl van Schaik <quic_cvanscha@quicinc.com>, 
	Philip Derrin <quic_pderrin@quicinc.com>, Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>, 
	Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Fuad Tabba <tabba@google.com>, Sean Christopherson <seanjc@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
 <20240222-gunyah-v17-19-1e9da6763d38@quicinc.com>
 <ZdhEtH7xzbzdhS2j@infradead.org>
 <20240223071006483-0800.eberman@hu-eberman-lv.qualcomm.com>
 <Zdxwo0abvklfam-Z@infradead.org>
 <2f4c44ad-b309-4baa-ac21-2ae19efd31fb@redhat.com>
 <20240226092020370-0800.eberman@hu-eberman-lv.qualcomm.com>
 <49d14780-56f4-478d-9f5f-0857e788c667@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <49d14780-56f4-478d-9f5f-0857e788c667@redhat.com>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OYxMkhK68XESzq23hFsSJIpyHes2RpDe
X-Proofpoint-GUID: OYxMkhK68XESzq23hFsSJIpyHes2RpDe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_08,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403010011

On Tue, Feb 27, 2024 at 10:49:32AM +0100, David Hildenbrand wrote:
> On 26.02.24 18:27, Elliot Berman wrote:
> > On Mon, Feb 26, 2024 at 12:53:48PM +0100, David Hildenbrand wrote:
> > > On 26.02.24 12:06, Christoph Hellwig wrote:
> > > > The point is that we can't we just allow modules to unmap data from
> > > > the kernel mapping, no matter how noble your intentions are.
> > > 
> > > I absolutely agree.
> > > 
> > 
> > Hi David and Chirstoph,
> > 
> > Are your preferences that we should make Gunyah builtin only or should add
> > fixing up S2 PTW errors (or something else)?
> 
> Having that built into the kernel certainly does sound better than exposing
> that functionality to arbitrary OOT modules. But still, this feels like it
> is using a "too-low-level" interface.
> 

What are your thoughts about fixing up the stage-2 fault instead? I
think this gives mmu-based isolation a slight speed boost because we
avoid modifying kernel mapping. The hypervisor driver (KVM or Gunyah)
knows that the page isn't mapped. Whether we get S2 or S1 fault, the
kernel is likely going to crash, except in the rare case where we want
to fix the exception. In that case, we can modify the S2 fault handler
to call fixup_exception() when appropriate.

> > 
> > Also, do you extend that preference to modifying S2 mappings? This would
> > require any hypervisor driver that supports confidential compute
> > usecases to only ever be builtin.
> > 
> > Is your concern about unmapping data from kernel mapping, then module
> > being unloaded, and then having no way to recover the mapping? Would a
> > permanent module be better? The primary reason we were wanting to have
> > it as module was to avoid having driver in memory if you're not a Gunyah
> > guest.
> 
> What I didn't grasp from this patch description: is the area where a driver
> would unmap/remap that memory somehow known ahead of time and limited?
> 
> How would the driver obtain that memory it would try to unmap/remap the
> direct map of? Simply allocate some pages and then unmap the direct map?

That's correct.

> 
> For example, we do have mm/secretmem.c, where we unmap the directmap on
> allocation and remap when freeing a page. A nice abstraction on alloc/free,
> so one cannot really do a lot of harm.
> 
> Further, we enlightened the remainder of the system about secretmem, such
> that we can detect that the directmap is no longer there. As one example,
> see the secretmem_active() check in kernel/power/hibernate.c.
> 

I'll take a look at this. guest_memfd might be able to use PM notifiers here
instead, but I'll dig in the archives to see why secretmem isn't using that.

> A similar abstraction would make sense (I remember a discussion about having
> secretmem functionality in guest_memfd, would that help?), but the question
> is "which" memory you want to unmap the direct map of, and how the driver
> became "owner" of that memory such that it would really be allowed to mess
> with the directmap.

