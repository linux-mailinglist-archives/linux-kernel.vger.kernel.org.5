Return-Path: <linux-kernel+bounces-82058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97157867E72
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42561C217B8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575D612DDBB;
	Mon, 26 Feb 2024 17:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iGXtAiZe"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E5A12C800;
	Mon, 26 Feb 2024 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708968485; cv=none; b=lwUO6GMQPPOiAGmHIwbOlj042YLe15A5RZwa5YKuzCAtjYjtLWdh98hXClfjhAqoH64Gz+ambWHdL4Och+TsU2t3JgIKlPQw9q8LzEa8rs7/9uc4yywWdfDRavoauDe3Jlru3PRHx7hHnuSeeSuL1/8WA43ltY5GVtTs4nplwVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708968485; c=relaxed/simple;
	bh=2HBgRJuzD/DEzOuUlPeELaZHx85jbXyYOMRMlHWPSzc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qo8rfRTqDJmCj3QEzlEWEjjxTzP1XDNZZKYT//XGWayQrftwPX0DUigFMmCaohDMpgdGSADTiiAl1Cgej8w2f0DGlP+e80fKegqJxzHiSjzrZ3s6tpGbwquwAs1J1h1sFSYnTyEjnIIC+pKJlZanjE6luDpiOcJpU/iOkwEcths=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iGXtAiZe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41QF8hTo032325;
	Mon, 26 Feb 2024 17:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=xo8BL5z8F/dpS6FAXBqND
	ypdFj4PXEGX78m0qafgn+w=; b=iGXtAiZeAnwWh00/pCFGofQ1KwaPva7d/Ihol
	0Ov4ZNEBvedo37tPPfAZwlFnbSuYct7ZSAWsgiPahpvbN+eEsVP8OL3+8pOQBg8U
	u4HD3ZjcPt/2yDsZDxiR+mL+Fc1E4XVPrmU3lbPgQU+9afqdXyMHNUNlr9Kr3WHh
	1ZI2W8z+f+9NFZaGJ4424ErG+q/uE4SdilrHmGbSS97kY/6Mw/y7VkzEDPVQF0ZO
	gBPG2xT23IB74x5kxPKpVNyWs4AwivfqAZA5Ay7flOnWAJCSXAjQ+jNGtBc+HyXG
	x5IvoYWAMaen/lCj+g1+r/OwN/NRhKan+MMrgHgj8rDHDQMVw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxq9hfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 17:27:42 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QHRWV4026940
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 17:27:32 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 26 Feb 2024 09:27:31 -0800
Date: Mon, 26 Feb 2024 09:27:31 -0800
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
Message-ID: <20240226092020370-0800.eberman@hu-eberman-lv.qualcomm.com>
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2f4c44ad-b309-4baa-ac21-2ae19efd31fb@redhat.com>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LdjTkC-YCMeGWoOjKwhoFF8DF33-q3k1
X-Proofpoint-GUID: LdjTkC-YCMeGWoOjKwhoFF8DF33-q3k1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260133

On Mon, Feb 26, 2024 at 12:53:48PM +0100, David Hildenbrand wrote:
> On 26.02.24 12:06, Christoph Hellwig wrote:
> > The point is that we can't we just allow modules to unmap data from
> > the kernel mapping, no matter how noble your intentions are.
> 
> I absolutely agree.
> 

Hi David and Chirstoph,

Are your preferences that we should make Gunyah builtin only or should add
fixing up S2 PTW errors (or something else)?

Also, do you extend that preference to modifying S2 mappings? This would
require any hypervisor driver that supports confidential compute
usecases to only ever be builtin.

Is your concern about unmapping data from kernel mapping, then module
being unloaded, and then having no way to recover the mapping? Would a
permanent module be better? The primary reason we were wanting to have
it as module was to avoid having driver in memory if you're not a Gunyah
guest.

Thanks,
Elliot


