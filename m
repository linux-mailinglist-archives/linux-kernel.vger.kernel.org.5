Return-Path: <linux-kernel+bounces-95817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AC487534A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41AC28454E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6BA12F387;
	Thu,  7 Mar 2024 15:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eyN/asCw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D9E125D5;
	Thu,  7 Mar 2024 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709825904; cv=none; b=bFhszXZW+WxbcIlTU/ix58g/yk+XK2CyPuhqm76pK4wHqKG326e/9BC72CKgIEGKklNdLBIEbo/ebyHMPb/dsajemnHBzZhgUHGz3hXCH4jAC3m9Cn4RmHMzB7PSjP2qBlxCEb3oSYuFftkUtDK5EiEnSPgTeFSaCFY09WzP9u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709825904; c=relaxed/simple;
	bh=7ZE0ScB5HUfAHIymGIixtJSOwrT16z36Q+BWEBSYb5E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIRaN89ymIy20SCyM9BgEMAHYi8QiGkp4Nb3NyGKpHhBBFS9psvoxPz3+yit6+nnN3SUjuiHO5mHbyqNkd1vLE1DJzlzkfn4oRlsr9TlCGsZmzZiiOWN/oZSKLEeHVXKQ9EYzlBXhRVZYf0CJL5z7kpjB68xrA7oBtmQ91yHM7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eyN/asCw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 427AL4iT012314;
	Thu, 7 Mar 2024 15:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:reply-to:references
	:mime-version:content-type:in-reply-to; s=qcppdkim1; bh=AERJNdMQ
	dUcc77JzPbCxr+bYduc7vK2w7u9SAMJqtFU=; b=eyN/asCwApH3kBf7+opmpRWk
	VOAm8ii2Qd7Q33UMT6r3MXRcH2BQIpkmMl5eVVlQX525pjg2tGRE86YBF2Du7iTJ
	eoZNyLc9b9CfgdQBdRyTBR4dqU4OuyYLl+zYAFpOYk5C6SwkAWEZRrCAbQq533Oi
	dCyEVp07q1yVv1SjxRICqJMG90IdI324wUWiFTjca0QMpUWggTD2mvfN5ojTGAXX
	3dJnUla8ARfUhrDTRjqn+pxh0BO3o6bZopZtcERtriqwLrPuoZ7ktQBZzi6zSUas
	d/zAMIraqs9xmJhNJPkNxCHw54np2zrv8IgDsO19KioSCDJA49qhrkYvRjPsPw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wqbrhsdxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 15:37:46 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 427FbhEM030778
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Mar 2024 15:37:43 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 7 Mar
 2024 07:37:36 -0800
Date: Thu, 7 Mar 2024 21:07:32 +0530
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
Subject: Re: [PATCH v17 01/35] docs: gunyah: Introduce Gunyah Hypervisor
Message-ID: <20240307153732.GA1695516@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
 <20240222-gunyah-v17-1-1e9da6763d38@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20240222-gunyah-v17-1-1e9da6763d38@quicinc.com>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EBk-ZkuEYBZiWX12ZYbttDTYzSiR8dEm
X-Proofpoint-ORIG-GUID: EBk-ZkuEYBZiWX12ZYbttDTYzSiR8dEm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_07,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 mlxlogscore=403 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403070084

* Elliot Berman <quic_eberman@quicinc.com> [2024-02-22 15:16:24]:

> Gunyah is an open-source Type-1 hypervisor developed by Qualcomm. It
> does not depend on any lower-privileged OS/kernel code for its core
> functionality. This increases its security and can support a smaller
> trusted computing based when compared to Type-2 hypervisors.
> 
> Add documentation describing the Gunyah hypervisor and the main
> components of the Gunyah hypervisor which are of interest to Linux
> virtualization development.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

LGTM.

Reviewed-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>

- vatsa

