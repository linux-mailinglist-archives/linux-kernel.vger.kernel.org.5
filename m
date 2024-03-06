Return-Path: <linux-kernel+bounces-94226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F8D873BA8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D761F24664
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F13F13DBA0;
	Wed,  6 Mar 2024 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ndyeMeVr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151CE137914;
	Wed,  6 Mar 2024 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709741054; cv=none; b=nbv76ahbzbL5q7YqI4p+fXQOqV/Foe2sBELgjCZHJqH5bZ5i9p2Gp/nMkPi64c8maBkdazw+uqbx5DWMED0KohogOgNf8mLsqUv7Kj737FGFeSLlkfDGKPvtlcfQI5LuOKzUnwInj1Tcd+IxmLN91FlKTxh6w7lgNeoyXMu6RFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709741054; c=relaxed/simple;
	bh=40bdGBT8XRzmvg5qShRaJp5UfNUmwBBEmTZSZQhNSKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N/IH3C3xTfqNRB64Hm+fb18dHCIEfIvGfNwXiRYUNWwFZkn0IH2bjpx972PV45yJMog/21QqlEMmJnaHScLKplFs95UBPpZRopge/luHRRHa+rDjTKd99XFnLfiB1FgFZFVbRzIH9LL4YRNbDWpEiRjAkxt44pFOH5QsD0HJB2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ndyeMeVr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4267rSim029054;
	Wed, 6 Mar 2024 16:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=udjqwGjeA5cBD+ZblmObsFRwtHr3lpuOSBQ6XJh6FZ8=; b=nd
	yeMeVriIUUHglor/qaPslWmdHsRP4SwefpVPmfd4McrbwYXcv62+YH7MYRNhXO/R
	AOMRNvC5xJfPmioUw5WV6jNFleuIR8n6TJv/nfR1Sayd2KKYWkvogxbg5cqlemI0
	HtSw0UbsDqnntbJl8Mdq3YN5yKhlgl7zhafaWvU8o9XkJI81suyA9WI7rbeyZjmU
	8pGXb+JJFVujf3WVpP0W0UYSDMyf40/YC8cBTINh5AZzQi1i93mMJ6CdvBmkqvI1
	buGJSAPhnqUFPrXqATDYZIWiC3KpJep4vtmaZvEJd4YDodkgR1FfHtcYyKLew379
	MBVbUqBMT1quCpKd8+ww==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpepc9qqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 16:03:59 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 426G3wcw028610
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 16:03:58 GMT
Received: from [10.216.51.173] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Mar
 2024 08:03:52 -0800
Message-ID: <b832bd70-540f-4dab-955e-ba98f7a5f31d@quicinc.com>
Date: Wed, 6 Mar 2024 21:33:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] Enable firmware-managed USB resources on Qcom targets
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <andersson@kernel.org>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <quic_wcheng@quicinc.com>,
        <Thinh.Nguyen@synopsys.com>, <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_psodagud@quicinc.com>,
        <quic_nkela@quicinc.com>, <manivannan.sadhasivam@linaro.org>,
        <ulf.hansson@linaro.org>, <sudeep.holla@arm.com>,
        <quic_shazhuss@quicinc.com>
References: <1709657858-8563-1-git-send-email-quic_sriramd@quicinc.com>
 <1697b03c-56ab-4e8b-a268-f9ceeed91c31@linaro.org>
From: Sriram Dash <quic_sriramd@quicinc.com>
In-Reply-To: <1697b03c-56ab-4e8b-a268-f9ceeed91c31@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9wplb99ItW5xKvgU3B8r73zurArmM6xI
X-Proofpoint-ORIG-GUID: 9wplb99ItW5xKvgU3B8r73zurArmM6xI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_10,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 mlxlogscore=848 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403060129

On 3/6/2024 2:39 AM, Konrad Dybcio wrote:
> 
> 
> On 3/5/24 17:57, Sriram Dash wrote:
>> Some target systems allow multiple resources to be managed by firmware.
>> On these targets, tasks related to clocks, regulators, resets, and
>> interconnects can be delegated to the firmware, while the remaining
>> responsibilities are handled by Linux.
> 
> Aside from the comments you already got from others, please change
> [RFC m/n] to [PATCH RFC m/n] so that your series isn't filtered out
> out maintainers' inboxes due to the missing PATCH keyword..
> 

Sure. thanks Konrad.

> Konrad

