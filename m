Return-Path: <linux-kernel+bounces-24780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 951CF82C25D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33CE61F25654
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF3A6E2D4;
	Fri, 12 Jan 2024 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aPP/EA2D"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52506DD07;
	Fri, 12 Jan 2024 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40CDLlW6030090;
	Fri, 12 Jan 2024 15:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Nt/sEVIDai5Q8pS8pgV/u7mjDZ+NS62VC4KAIb5S5MM=; b=aP
	P/EA2DldXlpghdwXF7VXxi20HKajXZe4z3q1PIiHxrStCS0E3pEAxMXmWwV5sUw5
	gGMFQ6b1vvVyzi5kTjfCQesB1xijKg3lAhr0KqABXyAPH2nVbQuRXKEzjyVzZzDg
	1F15x0eqEn58sW6rDaYCDS1dYxbz4opEXkwFDn0NDNrGaFlkmrhS/M47xpnXwRvg
	FlbAVRZc/Ah2oHyNjEoKb1cY1LHPN8FRqpifRGiGRIjm9vXoZS/NDPhae08qBzNL
	jd3EH4MiMncGk3HmQhsjpILwwyLX9hR8+oUAzBPghV/t6GvM62RI0VVlGycSZNMT
	blG22eF0/Suei5GDMELw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjymn9agm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 15:00:44 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40CF0hid010713
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 15:00:43 GMT
Received: from [10.253.78.164] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 12 Jan
 2024 07:00:38 -0800
Message-ID: <840fc48b-956d-47e8-8307-c419afb1efc2@quicinc.com>
Date: Fri, 12 Jan 2024 23:00:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Add PPE device tree node for Qualcomm IPQ SoC
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <quic_kkumarcs@quicinc.com>, <quic_suruchia@quicinc.com>,
        <quic_soni@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_souravp@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>
References: <20240110112059.2498-1-quic_luoj@quicinc.com>
 <458ded82-b200-4946-9b22-31cda68f1c8c@linaro.org>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <458ded82-b200-4946-9b22-31cda68f1c8c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GDThB25HhrPiZt1J6QblhAeyuRjVe6HS
X-Proofpoint-GUID: GDThB25HhrPiZt1J6QblhAeyuRjVe6HS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=532 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401120117



On 1/10/2024 8:13 PM, Krzysztof Kozlowski wrote:
> On 10/01/2024 12:20, Luo Jie wrote:
>> The PPE(packet process engine) hardware block is supported by Qualcomm
>> IPQ platforms, such as IPQ9574 and IPQ5332. The PPE includes the various
>> packet processing modules such as the routing and bridging flow engines,
>> L2 switch capability, VLAN and tunnels. Also included are integrated
>> ethernet MAC and PCS(uniphy), which is used to connect with the external
>> PHY devices by PCS.
>>
>> This patch series enables support for the following DTSI functionality
>> for Qualcomm IPQ9574 and IPQ5332 chipsets.
>>
>> 1. Add PPE (Packet Processing Engine) HW support
>>
>> 2. Add IPQ9574 RDP433 board support, where the PPE is connected
>>     with qca8075 PHY and AQ PHY.
>>
>> 3. Add IPQ5332 RDP441 board support, where the PPE is connected
>>     with qca8386 and SFP
>>
>> PPE DTS depends on the NSSCC clock driver below, which provides the
>> clocks for the PPE driver.
> 
> DTS cannot depend on clock drivers. Maybe you meant that it depends on
> NSSCC clock controller DTS changes, which would be fine. However
> depending on drivers is neither necessary nor allowed.
> 
> Best regards,
> Krzysztof
> 

Yes, this DTSI series depends on the NSSCC clock controller DTS patches 
which are referred to in the cover letter. I will rectify the cover 
letter text when the series resumes later.


