Return-Path: <linux-kernel+bounces-95828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C4887538D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEFFC1C220BE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DB612FF65;
	Thu,  7 Mar 2024 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RiMQ0OlE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD7412F36F;
	Thu,  7 Mar 2024 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709826038; cv=none; b=psFORPL5/8bZNN4k/juwmBwJ5KFmf+4+PZt7Bm3TxZbmENDMdEMZCBLGwBpG18u5jZX/4PDAYKo2FdvhxVDVYAQ4BwSLhMzP2t+ds0K5NKGy798KM1AwhKyXjlWf03BOVfNsCMNhqxZCigVNK0Tzn9TjksJuoFDcrOwkwtYpUXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709826038; c=relaxed/simple;
	bh=fh0n5w9BpVHFCfMA3Um/TOAMScuRvA2TPQcLoKcwmuc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGZcsoYwcQxFs2EUUTRK2Oedq4rs04MSZsabwoFfiHj9rG7STN4/YXlkgjC6vXbI0yFeqvC/s7ehqG27DoDhAtiQ9bzQzhW25QeqPSO02wkG3eU1ffezqA5YbLP3bDZLAjy7YxLtbRaN5VHdtYceIeea+ozedA7sKVnA2GK9W7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RiMQ0OlE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 427EBpmu019389;
	Thu, 7 Mar 2024 15:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:reply-to:references
	:mime-version:content-type:in-reply-to; s=qcppdkim1; bh=x9mSKt+D
	jroHiBhsJgaO1YAzStTlyxwFwrm/zxwZK+Q=; b=RiMQ0OlEAfMlt4L0tlo0fRjU
	SO6T952gb2ZEJjPH4sJXhfyw2VRkAndG0pmT06UrNnWB84wwz8iW7RFH5jNfXEak
	wNmK0pASi31rHtFvh9RIochTlHkIQdo0XaeIx0ZY6dEyUSRsqrjJoSh3ZLPkYF+9
	yDYR+sIz50H2PKf0AmJD8DQMvx+Gw1oQcMU3daHY/o4rsPstsfIe+jtNvvSFmjBd
	JC53IvSnKM+sxPyZtGCvg5Rx74qxgxlz5pCTUFM6PgTOMzWc6OkgUlUMYvMRXxeC
	k8nosLzj0auisXPMWIMfdKGJGjcwtp1+LqgutxxyZ/3C6C7SkYXgNhs+ddxWrA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wqf4r0ekv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 15:40:03 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 427Fe1GE010812
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Mar 2024 15:40:01 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 7 Mar
 2024 07:39:54 -0800
Date: Thu, 7 Mar 2024 21:09:50 +0530
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
Subject: Re: [PATCH v17 09/35] gunyah: rsc_mgr: Add VM lifecycle RPC
Message-ID: <20240307153950.GB1696249@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
 <20240222-gunyah-v17-9-1e9da6763d38@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20240222-gunyah-v17-9-1e9da6763d38@quicinc.com>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _uZlOP-jl2koKQHOhQe9grwGA8_vX3Ph
X-Proofpoint-ORIG-GUID: _uZlOP-jl2koKQHOhQe9grwGA8_vX3Ph
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_07,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxlogscore=508 suspectscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403070086

* Elliot Berman <quic_eberman@quicinc.com> [2024-02-22 15:16:32]:

> Add Gunyah Resource Manager RPC interfaces to launch an unauthenticated
> virtual machine.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

LGTM

Reviewed-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>

- vatsa

