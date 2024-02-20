Return-Path: <linux-kernel+bounces-72990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3B485BB93
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F571C22583
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D0467E86;
	Tue, 20 Feb 2024 12:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ee73j2qk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC0E67C71;
	Tue, 20 Feb 2024 12:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431176; cv=none; b=day58RawakWyQyZ6DlYSCZgBF942Zw111HexQjdbfvaE1VXI3I+EfgwlSvfqpFbDzf49o1HMXxQLpUK1w1qvU/IN3D3C+U0h77OckoyxbMBlD+dNAgs9cK0pzpE1wTgdswI2YFL4TwlkdJABLxNyCLW9Tni332XkDCL1vPSrCtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431176; c=relaxed/simple;
	bh=vdq/fhL20CqvrgT/zXduzBt0JpmflD0QRaHYGsHg1Cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EEC2Ccc9HZskUFK0K3OAbIRbNd8xvSf4/EOkoN1flc6DbgYP1dfj622QXfNJbK5ocHMmyCGX9o6lFn/L4HhZeLLBABFpMNXE/FObLIM/FI0IPKEqd9v6uNENO9xN+R9DG/QPA1ryu8YNg8ZbiT8m2KH1tkrzvj8wlodyXK0eKDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ee73j2qk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41KAG1ec027660;
	Tue, 20 Feb 2024 12:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=drr88rP1gE8DZYd3IlmPEoaAL4ojdft/vQ7O5Df4b+g=; b=ee
	73j2qkNHIziBbzP0Ll8PR4rau6H2j8Hfh2pFDH1QgHDNr5ABxH0wGBzHLhyiYB0J
	oedtraPQOH9rGJjJdjHUyZ/yHiKjuQC63neUgGDXBRpMqHfAJHlFDhm6ZU6uyJ0p
	IQDXfMFqOq7RpqAAZjh/S6Su0n0eYFh9hKBlB7t+RIoxkyuVYiKSQ/J1ky0NZ0Tn
	MldD3RR9EqjDR3WVHliyz9F5AwooiqCKVwBoiDID31h6JSoNxiThKUo1IL0XoxyK
	f1X2AUcR3dhqiM/NVIVtutMJPw4o4uqSOaav2tIDuSnR9tySRJbLjf9qrPWit/ta
	HPEo6DlMNzJCAz9M/XYQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wct5786ta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 12:12:37 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41KCCbla024375
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 12:12:37 GMT
Received: from [10.216.16.129] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 04:12:30 -0800
Message-ID: <28a6a8f9-8be8-346b-64be-50844ac31ac7@quicinc.com>
Date: Tue, 20 Feb 2024 17:42:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 5/5] arm64: dts: qcom: ipq9574: Disable eMMC node
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <broonie@kernel.org>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <manivannan.sadhasivam@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>
References: <20240215134856.1313239-1-quic_mdalam@quicinc.com>
 <20240215134856.1313239-6-quic_mdalam@quicinc.com>
 <CAA8EJpqV=w38TqjfTp6OurAwHjR87PpmQTs2jUo6O7vF1-T-WQ@mail.gmail.com>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <CAA8EJpqV=w38TqjfTp6OurAwHjR87PpmQTs2jUo6O7vF1-T-WQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: au_RqYUsQNdgJd_KKX3r209aqYUAVbcQ
X-Proofpoint-GUID: au_RqYUsQNdgJd_KKX3r209aqYUAVbcQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=861 mlxscore=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402200088



On 2/15/2024 8:30 PM, Dmitry Baryshkov wrote:
> On Thu, 15 Feb 2024 at 15:49, Md Sadre Alam <quic_mdalam@quicinc.com> wrote:
>>
>> Disable eMMC node for rdp433, since rdp433 default boot mode
>> is norplusnand.
> 
> Are they exclusive?

   Yes its exclusive, gpios are shared b/w NAND and eMMC so that
   only one could get enable.
> 
>>
>> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>> index 1bb8d96c9a82..e33e7fafd695 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>> @@ -24,7 +24,7 @@ &sdhc_1 {
>>          mmc-hs400-enhanced-strobe;
>>          max-frequency = <384000000>;
>>          bus-width = <8>;
>> -       status = "okay";
>> +       status = "disabled";
>>   };
>>
>>   &tlmm {
>> --
>> 2.34.1
>>
>>
> 
> 

