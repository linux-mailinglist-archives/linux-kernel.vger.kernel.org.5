Return-Path: <linux-kernel+bounces-124427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F88891768
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBDC0B24210
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2836A329;
	Fri, 29 Mar 2024 11:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N2PeXwpO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED90269DF7;
	Fri, 29 Mar 2024 11:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711710169; cv=none; b=GBkmPMSBA/Wcz7V3CmP/IeoFEwH/u/TNGmHP72TgLjAa2UWcZHuYLKDdHsLJWj7WoK1zBC2MikaFJPStywj5M55xIPMw4wZ+a+tZVgY7XmnUcem9ZuGMjHtKGxx8YFQQ2ymdbMbzM7G6tbgYJpx9yIrViDeWg647q1+c/Viqa0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711710169; c=relaxed/simple;
	bh=GoCaekO/19UT8HrRm+Nme7XMHifqCOmq4ykhULwCrVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ei/vDg5KzYlkBly07xJHwF3g77cVLByoR579C3HfdjZOuHoQ0ZALZi35DzW/BDJPgAnkk9dD0PPpxPmfrQjQHqCIBIOf0amERwqFRhxZblaQhp2qPVSj/egzhZVxnBzL+w6loqVKwJ8QQ1Zw1gmvVSrfOHQAZHxLqYAz7UgHvxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N2PeXwpO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42T9RgFN020121;
	Fri, 29 Mar 2024 11:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=bJ3pIo5rQ0zAm0yJhgdX2lzFSSi5b0T18UtJsKBRNpY=; b=N2
	PeXwpO6NMIct/ZFap856FZRbbM7LXiP5JG2j4pvxIac+mxWJfXbmAXDIs3fiihdw
	pfVWOuLpWeQ0skjnqsHnthD45bjQYWzjRP+0glOoxx0wRMKvzd35/UWBuCCdr0eB
	o4Fr3X1tEpbvETi4SS/W2L245gd1zHswzijVknNh0zNO1CgycnCWnkhEhAdoT3JF
	AcqPppa3AP/GhHKs4dV8fmkKIsdjDxBqJZfk7AVBviS52XsaJUnMjO1oeFpkBvTL
	CBKMs9jIL78Iy35p2X3G3UIJ/SymRi0yHFKmZclB0smceZ9yG5c2dRkbqhBED2iX
	Oeg6HEt8EvH6+8ZeVADA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5np29440-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 11:02:29 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TB2SPp000309
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 11:02:28 GMT
Received: from [10.214.67.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 Mar
 2024 04:02:23 -0700
Message-ID: <a04f9185-af77-55c2-db52-bbb3bde50836@quicinc.com>
Date: Fri, 29 Mar 2024 16:32:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 0/4] Add USB Support on Qualcomm's QDU/QRU1000 Platform
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        "Kishon Vijay
 Abraham I" <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
References: <20240319090729.14674-1-quic_kbajaj@quicinc.com>
 <CAA8EJpojQg2BHvR5kZtRxyXWRKy6zV=88_bdcuMH+QE-n4k73A@mail.gmail.com>
Content-Language: en-US
From: Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <CAA8EJpojQg2BHvR5kZtRxyXWRKy6zV=88_bdcuMH+QE-n4k73A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NbMObZ7yG2ZEikEosG1W_jCoZQAo9DzO
X-Proofpoint-GUID: NbMObZ7yG2ZEikEosG1W_jCoZQAo9DzO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_11,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 mlxlogscore=805 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2403290097



On 3/19/2024 3:05 PM, Dmitry Baryshkov wrote:
> On Tue, 19 Mar 2024 at 11:08, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>>
>> This series adds support of USB3 PHY support for Qualcomm's QDU/QRU1000 Platform.
>>
>> ---------
>> Changes in v2:
>> * Dropped extra lines
>> * Sorted the tables alphabetically
>> * Link to v1: https://lore.kernel.org/linux-arm-msm/20240311120215.16845-1-quic_kbajaj@quicinc.com/
> 
> So, this is v2, but you didn't mark patches as v2. Please use b4 for
> sending patches. It can handle patch revisions automatically.

Apologies for this, forgot to mark patches as v2.
I will be careful next time.

> 
>>
>> Komal Bajaj (4):
>>    dt-bindings: phy: qcom,usb-snps-femto-v2: Add bindings for QDU1000
>>    dt-bindings: phy: qcom,qmp-usb: Add QDU1000 USB3 PHY
>>    dt-bindings: usb: dwc3: Add QDU1000 compatible
>>    phy: qcpm-qmp-usb: Add support for QDU1000/QRU1000
>>
>>   .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml   |  2 +
>>   .../bindings/phy/qcom,usb-snps-femto-v2.yaml  |  1 +
>>   .../devicetree/bindings/usb/qcom,dwc3.yaml    |  3 ++
>>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c       | 49 +++++++++++++++++++
>>   4 files changed, 55 insertions(+)
> 
> 
> 

