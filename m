Return-Path: <linux-kernel+bounces-95827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC392875387
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE632846BB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F017012F58A;
	Thu,  7 Mar 2024 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o1ZNHpUm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CCC12F37A;
	Thu,  7 Mar 2024 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709825992; cv=none; b=Z5pF8maBUE+ACEmAi35NAPCHVeXnRqElO1PMZOSSk1hxFnWLHxPErQTym2Kx8ksC0Wl00WP7XdY6wC9RSCwkOzYBmYTqhgEfOUTtfJJgXYq6M2vkGkOwIqdlVTPNecizqyulcvO6rHGH6TL9z6ie3dO18Y9tiuDhnbcj2hjrvP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709825992; c=relaxed/simple;
	bh=zRNrEs5TtW9qcCA2nmW8SXbat4SbAFWzs2r7CLe6aEg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5RG55O5cA/+kbmRwh8mdtDX+LE1Mpq2L692oQ2NKvWpimliXhoiQKtelwW/ILy20XL+ciofsGBg94liyxWuAwrXEd0MhTY5PcBpaiuoqZ42HEiKYbbrDgIJvAn4cviuJB7r/k6CLL64D5X7CymQ76kNduwhzjzDP+gSbqn3wz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o1ZNHpUm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 427AL3X8010644;
	Thu, 7 Mar 2024 15:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:reply-to:references
	:mime-version:content-type:in-reply-to; s=qcppdkim1; bh=+Lt52Grw
	3semIojBWxsnFO3FccGRgYPSJgUu85p37/o=; b=o1ZNHpUmnPJxcT2gawv/CtTK
	6xy7sVF7OCK5qxs8/fhcl/Uc5xAMfrx0P+uwfiwF101l0Azwu0XI+NSL1nqOQzn7
	tkRRNXznYNG9EZuax0XNx2TRj4m1XbpTBR3LjwLGZ1Q8xsXTDeMPd3c/y/YRntGM
	38ddX7bU+qS5m2hyVGujSCyse13A4RrWo0blE2a3C7P+Ru+heIli/T9l29efFQnb
	fPVzGvSjW6JU8qoeMZKBUOVCOjRWA2TOpeS0/XNHProkjcwMoVuxIKhc2LzIkdYr
	xP/a9b9n55j4n5BER/59KegCIAT5/XxQUYwdWzGcuqkdm0YuUFUBqAA3nPO3EA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wqbqphe9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 15:39:27 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 427FdPiG006657
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Mar 2024 15:39:25 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 7 Mar
 2024 07:39:18 -0800
Date: Thu, 7 Mar 2024 21:09:14 +0530
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
Subject: Re: [PATCH v17 08/35] gunyah: vm_mgr: Introduce basic VM Manager
Message-ID: <20240307153914.GA1696249@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
 <20240222-gunyah-v17-8-1e9da6763d38@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20240222-gunyah-v17-8-1e9da6763d38@quicinc.com>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UVRun7HedOnzctRn7xvXdb-oRUkkxn7c
X-Proofpoint-GUID: UVRun7HedOnzctRn7xvXdb-oRUkkxn7c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=680 suspectscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403070087

* Elliot Berman <quic_eberman@quicinc.com> [2024-02-22 15:16:31]:

> Gunyah VM manager is a kernel moduel which exposes an interface to
> userspace to load, run, and interact with other Gunyah virtual machines.
> The interface is a character device at /dev/gunyah.
> 
> Add a basic VM manager driver. Upcoming patches will add more ioctls
> into this driver.
> 
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-by: Alex Elder <elder@linaro.org>
> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

LGTM

Reviewed-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>

- vatsa

