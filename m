Return-Path: <linux-kernel+bounces-54522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A1784B041
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E69A282A5B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003F912BEA2;
	Tue,  6 Feb 2024 08:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kXKDQlwc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A772031A60;
	Tue,  6 Feb 2024 08:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707209162; cv=none; b=VVy6wzNjixOisKFZm3ZeaMjg5qo3yQiX3Nq1V2khW244s/e/dYTvzmJrjFP28b1kATLfBAhCvBNmjzLh+whnuvJhTALi78CqLfPINpvcs0cHo27B9R/V2pBTNaKO88jPT5rMY/hJW7whGtTaz7iRI37WMLtwiEDQjwnkFUu0BMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707209162; c=relaxed/simple;
	bh=BD1l4lumxt68WiMmoR89WFIhk95du9x5SjyQdTh+KWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=loVOmRnUx6GrVDmapoUCRSEVCzrTZqqnC85a+9tqvqWtQr3ga4GdiUhDHyoXHLEOSV25eFwUfeHMamENnFr64JgOyzRpmoTlaV7moc1vkTzJl5qaJ7mzX0PrQzBzT9S7ItzGzBEdK2GqphLri/pVby7qrUxU6hb6L4InpuBx/vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kXKDQlwc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4168NscM018116;
	Tue, 6 Feb 2024 08:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=LnWIOZ2Rn6Y+g8S7StK+troST7mIUOflfziv0eFZ+5c=; b=kX
	KDQlwcr1qeqAPvUNjqsXO6DZbffLtki25qBVueWWHWRdV808c8HebDE/yZ4jugVs
	TLkU8uFYR9gwcKmrOAVKmV+w1Ys50BLPUwY7WY8sNEDJhdHDwUBWowoRvVanf0DQ
	CnAUnWoFTecn8WJjT6HmO9odBCxJ604O/CiuFkzpAG34+UP86tmLPcTKfjgZP8tj
	VkbEgCeR6Q8LZzWDrMwcV0eEiTodu8pIE4jwYBd1VP1YSoQew0uWpc4fPPA6HPad
	C/9GpfQXKQ4KaVgYZpO9q/pFSqcDRfjh3iwZXP9kWViwXeUc6qQ+J6BsXtC+UYHV
	IY0/Y9n2pWsJMcn0f5bA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3h7hr1ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 08:45:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4168jlFB030429
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 08:45:47 GMT
Received: from [10.216.27.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 6 Feb
 2024 00:45:42 -0800
Message-ID: <cc4ff2c9-4c1e-49f1-9297-2662d8ae4ae9@quicinc.com>
Date: Tue, 6 Feb 2024 14:15:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 0/9] Add multiport support for DWC3 controllers
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wesley Cheng
	<quic_wcheng@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi
	<balbi@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>
References: <20240206051825.1038685-1-quic_kriskura@quicinc.com>
 <CAA8EJpopE91TSCkworWts82tcD_6PLgLmes_FhVhnUovmQWz_w@mail.gmail.com>
 <f86cb527-3f91-4961-bbd5-4dc0e9a42df7@quicinc.com>
 <CAA8EJpqWt6a5mHcSyYKkEGu_nZ7vn5gjok07kSNe7mVzDE7gRA@mail.gmail.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <CAA8EJpqWt6a5mHcSyYKkEGu_nZ7vn5gjok07kSNe7mVzDE7gRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5BOVjQlf-FmTJATOyLONjj-s1LyPA5Rj
X-Proofpoint-ORIG-GUID: 5BOVjQlf-FmTJATOyLONjj-s1LyPA5Rj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=801 mlxscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060061



On 2/6/2024 2:13 PM, Dmitry Baryshkov wrote:
> On Tue, 6 Feb 2024 at 10:15, Krishna Kurapati PSSNV
> <quic_kriskura@quicinc.com> wrote:
>>
>>
>>
>> On 2/6/2024 1:30 PM, Dmitry Baryshkov wrote:
>>> Hi Krishna,
>>>
>>> On Tue, 6 Feb 2024 at 07:18, Krishna Kurapati <quic_kriskura@quicinc.com> wrote:
>>>>
>>>> Currently the DWC3 driver supports only single port controller which
>>>> requires at most two PHYs ie HS and SS PHYs. There are SoCs that has
>>>> DWC3 controller with multiple ports that can operate in host mode.
>>>> Some of the port supports both SS+HS and other port supports only HS
>>>> mode.
>>>>
>>>> This change primarily refactors the Phy logic in core driver to allow
>>>> multiport support with Generic Phy's.
>>>>
>>>> Changes have been tested on  QCOM SoC SA8295P which has 4 ports (2
>>>> are HS+SS capable and 2 are HS only capable).
>>>
>>> Thank you for your patches! Have you tested how this patchset
>>> interacts with the USB role-switching?
>>>
>>> I'm asking because it might be easier to define DT nodes for each of
>>> USB ports, which can carry the PHY properties (and also other DT
>>> properties if that's required, e.g. the ports / endpoints and
>>> usb-role-switch) rather than pushing all USB PHY links to the root DT
>>> node.
>>>
>>
>> Hi Dmitry,
>>
>>    Role switching doesn't work for Multiport controller as it is host
>> only capable. I don't think it will cause any issues for OTG capable
>> controllers because they only have one HS and SS phy present. So there
>> is no possibility or requirement for having endpoints per port in this case.
> 
> Is it going to remain host-only in future?
> 
> 
Yes. I believe these are designed that way. I don't know of any 
controllers that have multiple ports and device mode works. Device mode 
can work only on one port AFAIK.

Regards,
Krishna,

