Return-Path: <linux-kernel+bounces-92808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB00872637
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB40F28A688
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19BB241E0;
	Tue,  5 Mar 2024 18:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nmiYXkXB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9257512E7E;
	Tue,  5 Mar 2024 18:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709661876; cv=none; b=KdRIOqf1XbBU2ZLuCCWOMk/GZASYulKAMNscxlBTU4IH18Yp+5Lw4bFMxCGb01waJYwvSi4/Trr8q8mO5XptWUGl03/vDLiG9+HGq5FOw7zi4pm2Lf4xmg59yCcVRIz78LaEx6Qm69gkBBkez+8AjSebXu1sI3/+eQmksllU2J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709661876; c=relaxed/simple;
	bh=KKaXc5Gf1bPywyMA3vROKr+bIO/DG51ozDBuV4FN71I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k+449tUPePaZkParDF6rvegoExwy/ijd25BJyaZTJpgzleDExf6so2zv2AeBRGBRNzV0/bltX2RS2yme0k0vUJNLXFH+tjstKPc+oCtOh18sOpg52rDpgz7tLFKfN49B16AymxNpuwQItGoLMWOaiCwsoKcOxFh9DfOhFJmHLlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nmiYXkXB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 425ER8Pb032429;
	Tue, 5 Mar 2024 18:04:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=sghqC+om+7KfQnUHnhcBPIALJGyNo7LhaapE291B5b0=; b=nm
	iYXkXBm7jZSjeA42OzytxgY+zrHhWjnWN5eYlP17xcH70zIVD87ELqKuqWpUUr3Q
	RRLsAwgkD4FrsojfOb2VkUNll1GKNIufLtc2xmAxZNxmh18QpxWZf/L093ZQxauc
	Ea4f9NdoHLamn6Tb8A/aa1KLsXKzNQTGNaRJ2kIFu5jUXymDxIQmomUQfWXZnn+9
	QqMUTbrCd9TeppRhfpwiSv/p8Fij5fM+3/5BbCFkxnmWptAMRGsHl8NiT17vIwMM
	kL/8oeBxbiFr40fhPxOna3hxI5lDpiwaEjVdDHivHEST4xOdMhs5CwXI35KTT6FS
	Y7eJLPsZR2VoJMANmJCQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wp02898bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 18:04:20 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 425I4Kqj010381
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 18:04:20 GMT
Received: from [10.216.51.173] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Mar
 2024 10:04:12 -0800
Message-ID: <1a47c20a-abda-4493-a8f0-ff7b4e144d9c@quicinc.com>
Date: Tue, 5 Mar 2024 23:34:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] Enable firmware-managed USB resources on Qcom targets
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh@kernel.org>,
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
 <4d2501a7-d56d-4736-95d7-41556166859b@linaro.org>
From: Sriram Dash <quic_sriramd@quicinc.com>
In-Reply-To: <4d2501a7-d56d-4736-95d7-41556166859b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2IOJRVrWpQ7_YUUjAOmM_nf0gKuKdET4
X-Proofpoint-ORIG-GUID: 2IOJRVrWpQ7_YUUjAOmM_nf0gKuKdET4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_15,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=951 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 mlxscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403050144

On 3/5/2024 10:42 PM, Krzysztof Kozlowski wrote:
> On 05/03/2024 17:57, Sriram Dash wrote:
>> Some target systems allow multiple resources to be managed by firmware.
> 
> Which? Why this is so vague...
> 

SA8775 will be using it as pilot. Will include the target name.

>> On these targets, tasks related to clocks, regulators, resets, and
>> interconnects can be delegated to the firmware, while the remaining
>> responsibilities are handled by Linux.
>>
>> To support the management of partial resources in Linux and leave the rest
>> to firmware, multiple power domains are introduced. Each power domain can
>> manage one or more resources, depending on the specific use case.
>>
>> These power domains handle SCMI calls to the firmware, enabling the
>> activation and deactivation of firmware-managed resources.
>>
>> The driver is responsible for managing multiple power domains and
>> linking them to consumers as needed. Incase there is only single
>> power domain, it is considered to be a standard GDSC hooked on to
>> the qcom dt node which is read and assigned to device structure
>> (by genpd framework) before the driver probe even begins.
> 
> This will break the ABI. Sorry, come with an ABI stable solution.
> 

The plan is to include multiple power-domains and fw-managed
property or similar in the device tree and fw-managed property
will be deciding if we need some resource management offloaded
to firmware. So, OS is always in control here. The decision
making will be done in the drivers. Also, there will be no
separate vendor hooks.

> Best regards,
> Krzysztof
> 

