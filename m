Return-Path: <linux-kernel+bounces-75948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A12485F109
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6181C21918
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6225A111B2;
	Thu, 22 Feb 2024 05:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iriWfVDK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D3679F9;
	Thu, 22 Feb 2024 05:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708580562; cv=none; b=PrbXFHjHBM/45IF2sBlJ+IArVLweOOcMy2LbfsOvP3nAev9upK4suRyQNeJv5xCp0Q7A0MdFZZM/Ry4m2RZ7m56t2niU4xWUVX/rZce1NSe0Utin/VMYGoB3rFDsn9kRF0uzrn6wHrqLNg63G7be/7aH3MVzYJwP5bGlxmxh42U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708580562; c=relaxed/simple;
	bh=kLK2h+T0JfPCs0QHXVU5UYc4hufsEtwYHo/PYd3TAEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ndRv32xlZzZHIJ9v6tf777xBqIwX1+RYnsXsbhIUPo7AkcPakVcmtTN7El/3uZ4eJgq95gKgmGZyCqcxmFOIfI5fvKe+AGUPzXuHKwPcpzQ7FFi+wHdJG1DtY/qtSkbvDRa/Ed9CYQBjWrLhS2aMRmM81FnZ/AqJazSA55UQI6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iriWfVDK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M1cPAN002620;
	Thu, 22 Feb 2024 05:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Znncx6d1BYRx0r4T6MJOLkgq0dGqyZgNPe6BwvwZsn4=; b=ir
	iWfVDKmCnVFWwl3eiRd+QKpck7Ha7AA12glSX4+/o1UvSh1DAO1/Mmar7lUFdf19
	XJ029fNQWeMCkJaqn+791IK56bHs0PxQdx12NIPj+YaF+tYNbif+msMe0VINnlBR
	+ZGUVT3OKWhrv8Jgqd1onH7RQ+/6mLQUQdJTMl5yn4tgVkEBOsweKugf9F06DPzz
	VteA17o4iGV9bIQP93sGT2OMSJ1/gMbaS1ZaehT+9syvsFHFOtXb2Bhjnjbkxm1+
	8t0v7HuycB94JEMCM961B32VF01h9lR7P3vjaMWkdyK4HUvXpoAL8y7wGeqqj3tr
	R/XbzJel7mZkP9V9WkcA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdvsegdc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 05:42:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41M5gNHn023963
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 05:42:23 GMT
Received: from [10.214.82.119] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 21:42:19 -0800
Message-ID: <71a6eb2e-bb13-4b6b-82b6-f51bdb6d164e@quicinc.com>
Date: Thu, 22 Feb 2024 11:12:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] remoteproc: Add TEE support
Content-Language: en-US
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jens
 Wiklander <jens.wiklander@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <op-tee@lists.trustedfirmware.org>, <devicetree@vger.kernel.org>
References: <20240214172127.1022199-1-arnaud.pouliquen@foss.st.com>
 <20240214172127.1022199-2-arnaud.pouliquen@foss.st.com>
From: Naman Jain <quic_namajain@quicinc.com>
In-Reply-To: <20240214172127.1022199-2-arnaud.pouliquen@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xMO9mgWNtk2KhjEwdv1uc3pG8iVzqPGk
X-Proofpoint-GUID: xMO9mgWNtk2KhjEwdv1uc3pG8iVzqPGk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_03,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 phishscore=0 impostorscore=0 mlxscore=0 clxscore=1011
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402220041

On 2/14/2024 10:51 PM, Arnaud Pouliquen wrote:
> From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> 
> Add a remoteproc TEE (Trusted Execution Environment) driver
> that will be probed by the TEE bus. If the associated Trusted
> application is supported on secure part this device offers a client
> interface to load a firmware in the secure part.
> This firmware could be authenticated and decrypted by the secure
> trusted application.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---

<...>

> +};
> +
> +static struct tee_rproc__context *tee_rproc_ctx;
> +
> +static void prepare_args(struct tee_rproc *trproc, int cmd,
> +			 struct tee_ioctl_invoke_arg *arg,
> +			 struct tee_param *param, unsigned int num_params)

s/prepare_args/tee_rproc_prepare_args ?

please align function args in nextline with (.
Eg: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/remoteproc/remoteproc_sysfs.c?h=v6.8-rc5#n13

> +{
> +	memset(arg, 0, sizeof(*arg));
> +	memset(param, 0, MAX_TEE_PARAM_ARRY_MEMBER * sizeof(*param));
> +
> +	arg->func = cmd;

Regards,
Naman Jain


