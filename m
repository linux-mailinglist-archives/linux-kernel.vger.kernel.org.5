Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E514783FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbjHVLsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbjHVLso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:48:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D264CD5;
        Tue, 22 Aug 2023 04:48:20 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MB20kY004797;
        Tue, 22 Aug 2023 11:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=V4vOZFtzK7Tj4Uf+tFK0ITfcORF2PwxYw6T0iO2VaPo=;
 b=k5EaO5Nui/xazPYhtX6+0KqwBodTS5wMCiq+MmAmExrVS15WfhJBb4gQnGr0/F2VZKF4
 l98Y1RHErvgB8Pmaqg2Zee6m3pahA9WJdZu2IlJRLmMQMnv7ZmCIOosMNV9kDDKlzSFk
 Fh7h9Ya0A85sDUjZFIDPXWy9ZqvZQ6K6dvcygVJaeaxb+OvCMAXDj3R7FiD0HINnucxu
 NqZRKqmU9Mb55RJuNW+BYG0N9XuwOg/4JW9TcE9YSu5vme9gsjKv7IjANuYNMoOX8LuI
 6cxVfdg+uaJIi3utZBCxMVZbOBkY4Rp7SKCx7Mvy77OrgN/p+hx9U7n/a366stKQS1sS 7Q== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3smusbr2r7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 11:47:06 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37MBl5Ux006587
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 11:47:05 GMT
Received: from [10.216.34.168] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 22 Aug
 2023 04:47:00 -0700
Message-ID: <bdb155fe-aed1-e29b-e1c5-560495ee3ef1@quicinc.com>
Date:   Tue, 22 Aug 2023 17:16:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 4/4] arm64: dts: qcom: qdu1000: Add ECPRI clock controller
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20230808051407.647395-1-quic_imrashai@quicinc.com>
 <20230808051407.647395-5-quic_imrashai@quicinc.com>
 <28452f19-be57-46db-bfc8-4ba8573de1d0@linaro.org>
From:   Imran Shaik <quic_imrashai@quicinc.com>
In-Reply-To: <28452f19-be57-46db-bfc8-4ba8573de1d0@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: c_OlHcvxv7Mbfwfyc09OnYbLCqAL-lWZ
X-Proofpoint-GUID: c_OlHcvxv7Mbfwfyc09OnYbLCqAL-lWZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_10,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 mlxlogscore=869 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308220089
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/2023 1:30 AM, Konrad Dybcio wrote:
> On 8.08.2023 07:14, Imran Shaik wrote:
>> Add device node for ECPRI clock controller on qcom QDU1000
>> and QRU1000 SoCs.
>>
>> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/qdu1000.dtsi | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>> index 1c0e5d271e91..63930f944b65 100644
>> --- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>> @@ -381,6 +381,20 @@ gcc: clock-controller@80000 {
>>   			#power-domain-cells = <1>;
>>   		};
>>   
>> +		ecpricc: clock-controller@280000 {
>> +			compatible = "qcom,qdu1000-ecpricc";
>> +			reg = <0x0 0x00280000 0x0 0x31c00>;
>> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
>> +				<&gcc GCC_ECPRI_CC_GPLL0_CLK_SRC>,
>> +				<&gcc GCC_ECPRI_CC_GPLL1_EVEN_CLK_SRC>,
>> +				<&gcc GCC_ECPRI_CC_GPLL2_EVEN_CLK_SRC>,
>> +				<&gcc GCC_ECPRI_CC_GPLL3_CLK_SRC>,
>> +				<&gcc GCC_ECPRI_CC_GPLL4_CLK_SRC>,
>> +				<&gcc GCC_ECPRI_CC_GPLL5_EVEN_CLK_SRC>;
> Please align the entries with the first < (probably missing a single
> space in the front)
> 
> Konrad

Sure, will update and push next series.

Thanks,
Imran
