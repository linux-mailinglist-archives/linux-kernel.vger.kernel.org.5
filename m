Return-Path: <linux-kernel+bounces-166281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CC48B9876
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C853CB20E2B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE73556B95;
	Thu,  2 May 2024 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AE8R0PEy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753C342AAB;
	Thu,  2 May 2024 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714644342; cv=none; b=rPFOLb0XajGps5k4URLqWC6HysjhppVwK0R6EWa3fs+2t0YMs8ofi6yEQ1TWDqZVlmoIY53+C/fNnLZGkuVHiB3uzK+b3I0cpL1e3ei5b+ObCwSGTKd9sADj3PUnmTOXA+iFyA7BKvVAbRWXK/rWkMYTyvfK19om8LUlb33NyII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714644342; c=relaxed/simple;
	bh=CSMF8TVTmfpyLAZ8iFxB/1Lk5CprpPEhzH86+AomcuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Gnbi+L9U29w9I2xy4As3wwRBbMH3hGoRRdyToVuhx7sMk1mXb6fuqpvDAuJsSt3NbAgfw4dEOYaSRXC3glGmLLUm2pWz+k85HscjPmhzinpzhwKkET79WMSnKGgD5vQlQRVzLcQXCtfOwaJwjh74/D9Uhwbt5ISndiI/ucnxp/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AE8R0PEy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4426kp2E012287;
	Thu, 2 May 2024 10:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=TJq2/i5Zj8Gb1ky2H4os8IPFUg6ME1ot9K9spfIJlm4=; b=AE
	8R0PEyAL7hWQhtx5WwtS8e1xKc+Ekg5QrNJw724SqKlqUMEzr3/H3GLwWpA9OY0F
	cnNUx/OfcRLnNAC0E0WVZcGhPscCPiLvYkp48KiZFRQ0bP/nU7iUqgPijgYAmj+9
	jJeIzY5oBLQbrHXNxbvYLloXmQgztyxQzwIFu6GrOF8QpxU3sY1Vi433GxpdXTmv
	Erq55rJ3NtkzL/jW551diuVS8B6rXPGQhSS/OTcNnAZ+sZ88JPS2oE5/4us9BES+
	UT279cDpne5xeUJB//3zpsn2EjLuMzT9tJjyWEjaiQo/XijPV7PHYAXpsEb0f2b9
	/Dk493PV7rGYrlTpcKyA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xv41mgjgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 10:05:35 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 442A5YpV020501
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 May 2024 10:05:34 GMT
Received: from [10.216.26.108] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 2 May 2024
 03:05:29 -0700
Message-ID: <46e4000b-e588-d1b7-153e-047ed565565a@quicinc.com>
Date: Thu, 2 May 2024 15:35:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: qcom: Add AHB clock for SM8150
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen
 Boyd" <sboyd@kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        "Jagadeesh
 Kona" <quic_jkona@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20240501-videocc-sm8150-dt-node-v3-0-2c4bd9ef48bd@quicinc.com>
 <20240501-videocc-sm8150-dt-node-v3-1-2c4bd9ef48bd@quicinc.com>
 <CAA8EJpotvs3AOYO3ct=_JabBdYDops4Yfdutga9KBAbVPoZ5yw@mail.gmail.com>
From: "Satya Priya Kakitapalli (Temp)" <quic_skakitap@quicinc.com>
In-Reply-To: <CAA8EJpotvs3AOYO3ct=_JabBdYDops4Yfdutga9KBAbVPoZ5yw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: M8lt5M0Jugx5xPU3ML55SjwMf0gpsb3D
X-Proofpoint-ORIG-GUID: M8lt5M0Jugx5xPU3ML55SjwMf0gpsb3D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-05-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 mlxscore=0 bulkscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405020062


On 5/1/2024 5:36 PM, Dmitry Baryshkov wrote:
> On Wed, 1 May 2024 at 11:32, Satya Priya Kakitapalli
> <quic_skakitap@quicinc.com> wrote:
>> SM8150 videocc needs AHB clock, so update the bindings for sm8150
>> to add the AHB clock.
>>
>> Fixes: 35d26e9292e2 ("dt-bindings: clock: Add YAML schemas for the QCOM VIDEOCC clock bindings")
> The tag is incorrect. The mentioned commit didn't add sm8150 bindings,
> so it didn't have a bug.


Thanks, will correct the tag.


>> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>> ---
>>   .../devicetree/bindings/clock/qcom,videocc.yaml         | 17 ++++++++++++++++-
>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
>> index 6999e36ace1b..68bac801adb0 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
>> @@ -75,7 +75,6 @@ allOf:
>>             enum:
>>               - qcom,sc7180-videocc
>>               - qcom,sdm845-videocc
>> -            - qcom,sm8150-videocc
>>       then:
>>         properties:
>>           clocks:
>> @@ -101,6 +100,22 @@ allOf:
>>               - const: bi_tcxo
>>               - const: bi_tcxo_ao
>>
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          enum:
>> +            - qcom,sm8150-videocc
> Could you please extend the sm8250 case instead of defining a new one?
> Also could you please check if there is a clock (like ahb_clk_src)
> that uses bi_tcxo_ao instead of bi_tcxo? If so, we have to add this
> clock to the bindings even if the driver doesn't use/model it at this
> point.


There are no clocks using the bi_tcxo_ao on sm8150. Hence added separate 
case for sm8150 instead of re-using sm8250.


>> +    then:
>> +      properties:
>> +        clocks:
>> +          items:
>> +            - description: AHB
>> +            - description: Board XO source
>> +        clock-names:
>> +          items:
>> +            - const: iface
>> +            - const: bi_tcxo
>> +
>>     - if:
>>         properties:
>>           compatible:
>>
>> --
>> 2.25.1
>>
>

