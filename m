Return-Path: <linux-kernel+bounces-79291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D53D7862023
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AE101F25DF5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CAB14CADB;
	Fri, 23 Feb 2024 22:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h3c/Xzch"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3084A2208E;
	Fri, 23 Feb 2024 22:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708729144; cv=none; b=KNtHvEhZETMXZsTcixduKS6ES6HBPYi2HoTh+EELXTvzuLa4u3OfkKcaasLFhY7FzDyE/H2zkOxCi0iJ9BB4YXb1G599xUJQjg9/h2bDwZX6cmOzPk3gAeR5WYhyoKrW/T8+6kgxwYFMlgrzyYASkewsuXTazi9KAQXVQU2jIyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708729144; c=relaxed/simple;
	bh=Iky9mt4IFQ4238vl6hslSCEzTdMRADmFjH1aOU0JahA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEzeVZIGRcvsBjrpyNcv8rvkt6+d0O2NMF2Zj8hvEsAMJv3QrxKxod6IvYUbXnnAxqGVBLb5GXimrMnKasEkUFZQv830ktxgXXJeOK6V6kGKGFidMoYU21UdjUqk1DhtI26OD4FohijSYznvOKIEAFhn3PXTVQImB3oDbBwOIdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h3c/Xzch; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NGqr7d032592;
	Fri, 23 Feb 2024 22:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=xPrNabtICTcT3vIUG3kFM
	Z6Om4CgJ2wIFuGOLFzaKxM=; b=h3c/Xzchc19KgFTkKGJ2KloVPB7OKYyXtrxh9
	3NPcR5+doz66d2y8PR4HOE2ZntArg989jWWZeJNQcAowm01TAgJwLEOlrfHqvz/7
	cOtXpAlnn/byWJmuztl6G9upTBBx057BT3eyTEJKiqIoWGvqyJvPrLTC7uURvY//
	5qyMOX9Hq4EMG9BljNPX6s1BD/mxlfcif0XcRnAF8JZtoxWengc0dXVC+9mqNlZT
	itsyrefjzxETnnhG8U+7to0ATUHYU3XPYg3L5HdVq6u/IkvwCy9n/YWrsfJ7RVPu
	EM+YfyeIDJasWqtJgqV7jUWxRAD0wnFbYHm9cNnQGP20ZOZww==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wer8mst8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 22:58:45 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41NMwi5f030081
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 22:58:44 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 14:58:43 -0800
Date: Fri, 23 Feb 2024 14:58:43 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
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
        Will Deacon <will@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Fuad Tabba <tabba@google.com>,
        "Sean
 Christopherson" <seanjc@google.com>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>
Subject: Re: Re: [PATCH v17 05/35] virt: gunyah: Add hypervisor driver
Message-ID: <20240223144844667-0800.eberman@hu-eberman-lv.qualcomm.com>
Mail-Followup-To: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Alex Elder <elder@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Murali Nalajal <quic_mnalajal@quicinc.com>, Trilok Soni <quic_tsoni@quicinc.com>, 
	Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>, Carl van Schaik <quic_cvanscha@quicinc.com>, 
	Philip Derrin <quic_pderrin@quicinc.com>, Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>, 
	Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Fuad Tabba <tabba@google.com>, Sean Christopherson <seanjc@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
 <20240222-gunyah-v17-5-1e9da6763d38@quicinc.com>
 <a3356079-bd55-4852-9bb3-b5362a1c953e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a3356079-bd55-4852-9bb3-b5362a1c953e@linaro.org>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YPAwTj7bUcX3EtoIiGC9hJQ_EHC82MxR
X-Proofpoint-ORIG-GUID: YPAwTj7bUcX3EtoIiGC9hJQ_EHC82MxR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 mlxlogscore=472 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230165

On Fri, Feb 23, 2024 at 10:10:47PM +0100, Konrad Dybcio wrote:
> On 23.02.2024 00:16, Elliot Berman wrote:
> > Add driver to detect when running under Gunyah. It performs basic
> > identification hypercall and populates the platform bus for resource
> > manager to probe.
> > 
> > Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> > ---
> 
> [...]
> 
> > +
> > +	/* Might move this out to individual drivers if there's ever an API version bump */
> > +	if (gunyah_api_version(&gunyah_api) != GUNYAH_API_V1) {
> > +		pr_info("Unsupported Gunyah version: %u\n",
> > +			gunyah_api_version(&gunyah_api));
> 
> Weird for this not to be an error, but it's probably not worth resending
> over if it's the only thing

It is an error, but maybe I misunderstood:

> > +	/* Might move this out to individual drivers if there's ever an API version bump */
> > +	if (gunyah_api_version(&gunyah_api) != GUNYAH_API_V1) {
> > +		pr_info("Unsupported Gunyah version: %u\n",
> > +			gunyah_api_version(&gunyah_api));
> > +		return -ENODEV;
> > +	}


