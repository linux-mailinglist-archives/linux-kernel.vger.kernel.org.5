Return-Path: <linux-kernel+bounces-16502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DA3823F6D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC0E1B219C4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F0A20B35;
	Thu,  4 Jan 2024 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P65Ak5q9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4BA20B1A;
	Thu,  4 Jan 2024 10:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4049bVa5023173;
	Thu, 4 Jan 2024 10:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=OjqOtZ8ntc57kqqSbuT5H821EMYkp3YYKdw1VCNYAs4=; b=P6
	5Ak5q9GqFC535lqFOqzm6AlhmEwFnBtUTf/mwS1Q/ROgH5TEAR+ISV46ITvZwVnf
	g45194PmY9szRIcF3VnwSDVDPc5aVyQqR/ouU8ZjD0nScfthXGUtNNNq6w9Iew/A
	hEabZ82U5wjOdUa9RLDxP/rKXTtc8zpZ6CMbm4M0B3GCilw9F6RScxe2khzf5Euk
	83TPAWTIZiOTChi0ALQWyqMxRsyB4UxG5AZyz5WQjiYmQOKNmFhR0j8AwtgYJsgw
	MhhQB8SZkGKRskYpqMvOKrxT7U3v3KR7DoqLpChc281ZzkrPoF5wtxucSVCjWBQo
	uhpIMwjKTEtpJ3T4H9cw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vd8s1jgsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 10:27:15 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 404ARE4r022470
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jan 2024 10:27:14 GMT
Received: from [10.239.154.73] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 4 Jan
 2024 02:27:08 -0800
Message-ID: <ce5b0ae5-e61a-40a3-8a83-278b56274aba@quicinc.com>
Date: Thu, 4 Jan 2024 18:27:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: ipq6018: add #power-domain-cells for
 gcc node
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        <quic_tdas@quicinc.com>, <quic_aiquny@quicinc.com>
CC: <kernel@quicinc.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240104-gcc-docs-update-v1-1-127e4816b798@quicinc.com>
 <CAA8EJprsGke9zZBy_x=YSxz7R1aSpx8r3ndjjXVVKhjKBxd=QQ@mail.gmail.com>
 <724f608a-cbfe-48f6-a1f7-59b961a7d724@quicinc.com>
 <56ee556d-ec31-4553-bce3-0c1e12c111ed@linaro.org>
From: Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <56ee556d-ec31-4553-bce3-0c1e12c111ed@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EDpcKrpjHAX5L9AZipH9LHlQ9VE4gyLL
X-Proofpoint-ORIG-GUID: EDpcKrpjHAX5L9AZipH9LHlQ9VE4gyLL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401040079



On 1/4/2024 6:16 PM, Konrad Dybcio wrote:
> On 4.01.2024 11:13, Fenglin Wu wrote:
>>
>>
>> On 1/4/2024 5:53 PM, Dmitry Baryshkov wrote:
>>> On Thu, 4 Jan 2024 at 10:06, Fenglin Wu via B4 Relay
>>> <devnull+quic_fenglinw.quicinc.com@kernel.org> wrote:
>>>>
>>>> From: Fenglin Wu <quic_fenglinw@quicinc.com>
>>>>
>>>> Property '#power-domain-cells' is required as per defined in qcom,gcc.yaml
>>>> so add it for ipq6018 gcc device node to eliminate following warning in
>>>> dtbs_check:
>>>>
>>>> arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: gcc@1800000:
>>>>           '#power-domain-cells' is a required property
>>>> from schema $id: http://devicetree.org/schemas/clock/qcom,gcc-ipq6018.yaml#
>>>
>>> But ipq6018 doesn't implement GDSC support. So for the sake of fixing
>>> the warning you are adding a bogus property.
>>>
>> I agree. However, there are also some gcc drivers not implementing GDSC support but the bindings are adding '#power-domain-cells' in the DT example, such as: qcom,gcc-apq8064.yaml, qcom,gcc-ipq4019.yaml, qcom,gcc-ipq6018.yaml, qcom,gcc-ipq8064.yaml, qcom,gcc-msm8660.yaml.
>>
>> Actually I thought that maybe we should do a clean up by removing '#power-domain-cells' out of the qcom,gcc.yaml binding and only adding it into individual qcom,gcc-xxx.yaml for the driver which has implemented GDSC support. I checked this with Taniya offline, but she prefers only fixing it in ipq6018.dtsi as it doesn't hurt anything by adding the property, and she expects the GDSC support should be existing in most of qcom,gcc drivers especially the newer Qcom chipsets.
> 
> Before we start changing anything, we should assess whether these
> platforms actually have GDSCs within this clock controller block,
> even if they are (currently) not described in the clk driver.
> 
I would assume '#power-domain-cells' is only required for drivers which 
register GDSC as power-domain device, for drivers that only configure 
GDSC during probe or for platforms have GDSC but not register them as 
power-domain device, making '#power-domain-cells' as a required property 
doesn't help anything but just generating more dtbs check warnings.

> Konrad

