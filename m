Return-Path: <linux-kernel+bounces-29126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8540D83093C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350F7281B7C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77942137D;
	Wed, 17 Jan 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dDVFeukT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E3320DE5;
	Wed, 17 Jan 2024 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705504229; cv=none; b=NSMwWbUn2/QYvPlFK2XEzp8Io3yxPclnxf8QXUYSs3i1X/MDf+nUI3QVEvpgkqybNViDjtmEAzvOawIUpCaqXfomu5bk+gcq/7TjW9S4M1IJdhpznwcwUUbWVxpoiUkIpkdqDHyuX/0zKBbJ8EV62Gy3MSkj1QfwVdXr0S8/jlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705504229; c=relaxed/simple;
	bh=zGRFJrEbFry3zxAMuxyIrn8e15iLX/mAR0sIiHyeias=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-QCInternal:X-Proofpoint-Virus-Version:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=ChXI+ZzRJzIVCZU6HAzGQMBeAVZ5fcvZGQxc5NyASnUTwfB1ADw458jOfHreZLlH4diKeVy33yWf0LeYEfPcXB7Ob1TVPe6y52EOF8YZeIyr8Oun/CJ3G2ox4xOJP928tc8pV+ri4ZU57g/wJZzad/kGwSU2jVpnvolmnAEzcUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dDVFeukT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40HEWJdn013589;
	Wed, 17 Jan 2024 15:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=XmbM1Ia5snyMUN+x/M4UwlFkuM1aPLiJeDDKEFNsN8Y=; b=dD
	VFeukTh5sLMNefzDKoVB2IWkEENH8lV2lI1VfSMylyAhsydILtqYxWB4kwTzp+IS
	9b30OzRX6CEdq4o+sGcGVLaqh+6cQgOB2duUc48tXOyUzPoDM9FKsbssAwAIZpke
	TEiq0hrOb2XgdHJw4rSabQ/vIOtYQ2ZDXUfJAejwGe3+KS2OAm3tQ6h+rb5pbIMt
	h//jHblBsLDzclT0sZvLk1RxZnwrBPawr59HsldZ3UbzZOwduGk9iMvaM/zsr/sO
	VOfUXibe05WBYudRO4veMELnMyfQdDiJfEBIHUdv52GYl4I/rFUZ7GmQIvee46UO
	fsPzHGUrIAj6MXGakJfQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vp4ak1mxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 15:10:15 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40HFAEbp017623
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 15:10:14 GMT
Received: from [10.253.79.191] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 17 Jan
 2024 07:10:10 -0800
Message-ID: <efe398ff-825b-4959-bcfc-ff0870d1932b@quicinc.com>
Date: Wed, 17 Jan 2024 23:10:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] arm64: dts: qcom: ipq5332: Add MDIO device tree
To: Andrew Lunn <andrew@lunn.ch>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <quic_kkumarcs@quicinc.com>, <quic_suruchia@quicinc.com>,
        <quic_soni@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_souravp@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>
References: <20240110112059.2498-1-quic_luoj@quicinc.com>
 <20240110112059.2498-4-quic_luoj@quicinc.com>
 <4bc0aff5-8a1c-44a6-89d8-460961a61310@lunn.ch>
 <e893c298-fbfa-4ae4-9b76-72a5030a5530@quicinc.com>
 <61973012-3f74-4b58-9575-3bc5199f61d9@lunn.ch>
 <5c88945b-4a80-4346-a77c-82a68ae02047@quicinc.com>
 <6975e79a-67eb-46d7-8445-92610b8b5198@lunn.ch>
Content-Language: en-US
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <6975e79a-67eb-46d7-8445-92610b8b5198@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EthOji6xAPZbL2nJE2QuW4h2Y10JP8N0
X-Proofpoint-GUID: EthOji6xAPZbL2nJE2QuW4h2Y10JP8N0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=369 mlxscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170110



On 1/17/2024 6:56 AM, Andrew Lunn wrote:
>> Another one is the MDIO slave(gpio25, 26), which is dedicated
>> for receiving the back pressure signal from the connected Ethernet switch
>> device QCA8386.
>>
>> There is a MDIO master block integrated in QCA8386 switch device, this
>> integrated MDIO master is dedicated for generating the back
>> pressure signal to IPQ5332 SoC.
>>
>> This MDIO slave block of IPQ5322 just needs to configure these PIN
>> mux for MDC and MDIO PINs. No additional driver is needed for this MDIO
>> slave block of IPQ5332.
> 
> So there is a proprietary protocol running over the MDIO bus? And its
> completely implemented in hardware in the slave block? Is this even
> MDIO? Does it use c22 or c45 bus transactions? How is the slave
> address configured, or is that also hard coded?
> 
> 	Andrew
> 

Hi Andrew,
Yes, this is a custom HW mechanism using the MDIO C22 frame, to enable 
back pressure from the QCA8386 switch to the IPQ5332 SoC. The slave 
block in the IPQ5332 SoC implements the back pressure function. There is 
no configuration for the MDIO slave address of IPQ5332 required, since 
the connection is one to one between slave and master.

However upon further review, we believe this node definition belongs to
the board DTS file, since the switch configuration is a board property.
We will move out this MDIO slave config from the patch series to
avoid the confusion. We will also rename the node from 'mdio0-state' to 
'backpressure-state' to make this clear.

Thanks.

