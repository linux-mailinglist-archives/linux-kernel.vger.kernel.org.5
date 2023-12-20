Return-Path: <linux-kernel+bounces-6935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEFB819F7F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0891F21792
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE3B2574F;
	Wed, 20 Dec 2023 13:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WcVLDHae"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8693325544;
	Wed, 20 Dec 2023 13:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BKBtaFs016456;
	Wed, 20 Dec 2023 13:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=vJkqdUhLHB88+PTf3CYLIQbeu6YXydGvrQYc3difmhI=; b=Wc
	VLDHaewDttiZocK2PgvCPyY8UGsCVv5xhsWT2fN5T5ZnHdu8mvV1c0RVrqfvWlZH
	mDTpB07LiOJ89bLWlzQeevtt+Cmt3CRWQJuEvmUCnz1U1lpOmIWXx9x9Hjg6/hAm
	hjgjrdtxIwpfB8h88HaOlsbJTdzx7P51hy9LsCuJE0BakdvpVuUoGX1L4EHUOYvL
	Tee07DvP7SIeTfTuoMxD4ZIhhXFTCRlXPGjtj7Pis3YFvkzV5Vo1ygPPXnwPC0Ki
	glDZrrrUb6Q8r01OUVoh6hGyAhv1io8mDW6MEuopGADbNEjjJQlHV+onuZtJ9iBH
	hfbxwkcdQOoUzd1PmVbA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3tnw0wsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 13:07:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BKD7Xri000406
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 13:07:33 GMT
Received: from [10.239.133.49] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 05:07:30 -0800
Message-ID: <439916dc-8f71-4998-b145-1d183d9e68f5@quicinc.com>
Date: Wed, 20 Dec 2023 21:07:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: Add coresight nodes for sm8450
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross
	<agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang
	<quic_taozha@quicinc.com>, <coresight@lists.linaro.org>
References: <20231220124009.16816-1-quic_jinlmao@quicinc.com>
 <dfc7fe85-7418-410c-bd82-6e08799e6417@linaro.org>
From: Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <dfc7fe85-7418-410c-bd82-6e08799e6417@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cA0P0lDPm2Fuje6RtSNXk-8rwH3-Rst-
X-Proofpoint-ORIG-GUID: cA0P0lDPm2Fuje6RtSNXk-8rwH3-Rst-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312200093



On 12/20/2023 8:46 PM, Krzysztof Kozlowski wrote:
> On 20/12/2023 13:40, Mao Jinlong wrote:
>> Add coresight components on Qualcomm SM8450 Soc. The components include
>> TMC ETF/ETR, ETE, STM, TPDM, CTI.
>>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 742 +++++++++++++++++++++++++++
>>   1 file changed, 742 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> index 1783fa78bdbc..112b5a069c94 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> @@ -285,6 +285,192 @@ CLUSTER_SLEEP_1: cluster-sleep-1 {
>>   		};
>>   	};
>>   
>> +	ete0 {
> 
> ete-0
Thanks for the review.

In arm,embedded-trace-extension.yaml, the node name pattern is 
"^ete([0-9a-f]+)$".

examples:

# An ETE node without legacy CoreSight connections
   - |
     ete0 {
       compatible = "arm,embedded-trace-extension";
       cpu = <&cpu_0>;
     };
# An ETE node with legacy CoreSight connections
   - |
    ete1 {
       compatible = "arm,embedded-trace-extension";
       cpu = <&cpu_1>;

       out-ports {        /* legacy coresight connection */
          port {
              ete1_out_port: endpoint {
                 remote-endpoint = <&funnel_in_port0>;
              };
          };
       };
    };
> 
>> +		compatible = "arm,embedded-trace-extension";
>> +		cpu = <&CPU0>;
>> +
>> +		out-ports {
>> +			port {
>> +				ete0_out_funnel_ete: endpoint {
>> +				remote-endpoint = <&funnel_ete_in_ete0>;
> 
> Missing indentation.
> 
> ...
> 
>> +	funnel_ete {
> 
> funnel
> Anyway underscores are not allowed
> 
>> +		compatible = "arm,coresight-static-funnel";
>> +
>> +		out-ports {
>> +			port {
>> +				funnel_ete_out_funnel_apss: endpoint {
>> +					remote-endpoint =
>> +					<&funnel_apss_in_funnel_ete>;
> 
> Messed indentation
> 
> Errors above look all over this patch, so fix all instances in this patch.
> 
> Best regards,
> Krzysztof
> 

