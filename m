Return-Path: <linux-kernel+bounces-118519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B29988BC0C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA272E39D6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E6A134415;
	Tue, 26 Mar 2024 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AGXxRVPG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED75118C38;
	Tue, 26 Mar 2024 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711440730; cv=none; b=lE81B2R9qVbnIMi4woLm/xnCvAkaunpgRexiIKdWZIG+5DtsYzCZgH7U4cqeO2liMVfuLufgRBjSdpzeuD2ov8MFqfRCQdXbkkNTuTg/PH2+q11LC4maGzpTkjph18HrbEiK/RLjYWzs4pM8AamevuaSSIELDO3UCW3+w9KARUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711440730; c=relaxed/simple;
	bh=BFDVAFnUc+43+s1CESozz6wdE9YCqo+LSQNQCYQEEq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bzw/zOEXFk6vgIVMocozU4ThYylActRE9UGo7hCkivao2AzbBrB3f8jrn29kezwJSRRvltheZkvqcELE/AIRJdwg7xeCa4JpPANpVpIx9Hqrp6qG2EeJXB8D51/KlQ0PUzWBWHjJNIMdBNqUADW1denIXpRinAeM+RSeeES7TAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AGXxRVPG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42Q43lrK013328;
	Tue, 26 Mar 2024 08:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=K89+wmzn3wsPsL5w7i3MbruOa5IqBekvsiGBON5GpHU=; b=AG
	XxRVPGItttULZU74CTJMP6OmGLB0PApkaA+UPgbiBrcBmc6TYPFHRApfpZn4dxAV
	mbUAVjxtC6pD2iTHTzPFHTuqeXFKutFDMn7sOFRC99bjV9TpE2SklZSaShByt6aW
	JJGZXk7bInMZMam7hmLYrdtxh9xa04nfYCa5uMgJvVgvXjYJptirKcBk2cexmoiO
	ARQ9aEGZdGv7n85oT4RFJW0sutaM77gvbNTDzxHfoGxsBVw/lngHnnRH5/5h1Omd
	mleZk4in5VlRHRIu8u9Dzk88mTrdXrFjfJZY/oIRf4VIm1Kl595WNaw+6/8vviFw
	5bq1JRvqV+iaMnrzaI4g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3q0n0nup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 08:12:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42Q8C0kN018610
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 08:12:00 GMT
Received: from [10.216.25.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 26 Mar
 2024 01:11:55 -0700
Message-ID: <7b4a6d7f-76ad-471f-a178-dc598fbc0e22@quicinc.com>
Date: Tue, 26 Mar 2024 13:41:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 7/9] usb: dwc3: qcom: Refactor IRQ handling in glue
 driver
To: Johan Hovold <johan@kernel.org>
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
References: <20240307062052.2319851-1-quic_kriskura@quicinc.com>
 <20240307062052.2319851-8-quic_kriskura@quicinc.com>
 <ZgFyukBXIIwZo7v-@hovoldconsulting.com>
 <50926b91-3c61-4dbf-85c9-7558ab96e628@quicinc.com>
 <ZgF6zvaT2OkrbkHK@hovoldconsulting.com>
 <807015d4-c5ed-4e04-9948-fd1ff894a04e@quicinc.com>
 <ZgHUR-Rk-YzqiTtt@hovoldconsulting.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZgHUR-Rk-YzqiTtt@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 36CckDkS1r-KWMwa0tYKTmWGfEf7tjyw
X-Proofpoint-ORIG-GUID: 36CckDkS1r-KWMwa0tYKTmWGfEf7tjyw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_04,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=910
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2403260055



On 3/26/2024 1:15 AM, Johan Hovold wrote:

> Just change the logic in dwc3_qcom_find_num_ports() so that it returns 1
> if "dp_hs_phy_1" is missing, and otherwise you determine the number of
> ports by iterating from 2 to DWC3_MAX_PORTS - 1.

Hi Johan,

I made this change and it works. Removed any return value check for the 
find_num_ports call as it can return only 1/2/3/4 now.

---
     irq = platform_get_irq_byname_optional(pdev, "qusb2_phy");
         if (irq > 0)
                 return 1;

         irq = platform_get_irq_byname_optional(pdev, "dp_hs_phy_irq");
         if (irq > 0)
                 return 1;

         irq = platform_get_irq_byname_optional(pdev, "dp_hs_phy_1");
         if (irq <= 0)
                 return 1;

         for (port_index = 1; port_index < DWC3_MAX_PORTS - 1; 
port_index++) {
                 sprintf(irq_name, "dp_hs_phy_%d", port_index + 1);

                 irq = platform_get_irq_byname_optional(pdev, irq_name);
                 if (irq <= 0)
                         return port_index;
         }

         return DWC3_MAX_PORTS;

---

Let me know if this is fine and I can push out v17.

Regards,
Krishna,

