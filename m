Return-Path: <linux-kernel+bounces-54479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5757184AFC3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC38AB24D41
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E147112AAF5;
	Tue,  6 Feb 2024 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dsKjjcPp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA56129A65;
	Tue,  6 Feb 2024 08:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707207361; cv=none; b=AeBhpa/xTf8uCI7IZhZXur9yEZrlEGjjtNSxPwBrg5jkKGlWIfzWkqCro1M8usiaZ6hCK3fvlM2aX7GWk82A0CMb0nSXQn0tMWOkPJqPYd9s+8fWyQZJEwBmv9WjIlBgqGRbtAaAmcArVrD2n/MKHdlOFYh84Xg6sn1PFMlfYCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707207361; c=relaxed/simple;
	bh=cub4FYAsAtjViW5On/iVxW1PAeLpBFVpa17WMqItZnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jfoqAtF6K6tQMLU5Wa+GXnsqW9fySbMiJg18S6yOxeNsHG1lVpLTDTiZMYP//gbrt5OxfuWFkdx8XLKExqADwrWPasskKcmzZ+tPrZiz/n6WE0YLOQHiZVn53QtnnY2fWgxlS5XoQiQmR/YqPlXFml2aSfc2T+TXawrYEXnyofE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dsKjjcPp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4165Fhth016095;
	Tue, 6 Feb 2024 08:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1e/DTNSMXnN3DnLzn8QmUo6oKBvQxl5Idk0yQUOi77U=; b=ds
	KjjcPpo5GG9pZo7oP0nuVCG8wUXEuFW1s2mDYsGsb3JAv0ZCBE3if1mi+TnTB22j
	BerE+owERQh0TCTZkxcYv2ZQ00VXmtaXHvDfHzFNE1z02RKWo5viA9xSwuuC5aEO
	r8DhgFxKWVoriM2IA75bWFdm1t3hf3u1LUzUNA3mCc45hY0a3ChlHEisT9okvled
	uZM/DMp0kGPq0HBEGO13MTQNx9COaMVO23g0jZO0Sa4AggCAkZcERj1+RU5P/ao9
	qBIEEn8HLzT/85oALRUfoHVr6sjafJi4Z+d27k/2axT7Jo+U5mD7QraWRRON3enY
	UpvVpXd63+PZZ3Zk0Ugw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3apjgqh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 08:15:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4168FlYS028732
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 08:15:47 GMT
Received: from [10.216.27.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 6 Feb
 2024 00:15:42 -0800
Message-ID: <f86cb527-3f91-4961-bbd5-4dc0e9a42df7@quicinc.com>
Date: Tue, 6 Feb 2024 13:45:35 +0530
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
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <CAA8EJpopE91TSCkworWts82tcD_6PLgLmes_FhVhnUovmQWz_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ft9Tr8C8KX6UB97_v1oF5jGtpHZtDBBS
X-Proofpoint-GUID: ft9Tr8C8KX6UB97_v1oF5jGtpHZtDBBS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=835 mlxscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 clxscore=1011 lowpriorityscore=0 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060057



On 2/6/2024 1:30 PM, Dmitry Baryshkov wrote:
> Hi Krishna,
> 
> On Tue, 6 Feb 2024 at 07:18, Krishna Kurapati <quic_kriskura@quicinc.com> wrote:
>>
>> Currently the DWC3 driver supports only single port controller which
>> requires at most two PHYs ie HS and SS PHYs. There are SoCs that has
>> DWC3 controller with multiple ports that can operate in host mode.
>> Some of the port supports both SS+HS and other port supports only HS
>> mode.
>>
>> This change primarily refactors the Phy logic in core driver to allow
>> multiport support with Generic Phy's.
>>
>> Changes have been tested on  QCOM SoC SA8295P which has 4 ports (2
>> are HS+SS capable and 2 are HS only capable).
> 
> Thank you for your patches! Have you tested how this patchset
> interacts with the USB role-switching?
> 
> I'm asking because it might be easier to define DT nodes for each of
> USB ports, which can carry the PHY properties (and also other DT
> properties if that's required, e.g. the ports / endpoints and
> usb-role-switch) rather than pushing all USB PHY links to the root DT
> node.
> 

Hi Dmitry,

  Role switching doesn't work for Multiport controller as it is host 
only capable. I don't think it will cause any issues for OTG capable 
controllers because they only have one HS and SS phy present. So there 
is no possibility or requirement for having endpoints per port in this case.

Regards,
Krishna,

