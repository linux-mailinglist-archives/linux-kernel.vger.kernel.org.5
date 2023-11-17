Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1657EF2F6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 13:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjKQMtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 07:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjKQMtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 07:49:31 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A3CD5B;
        Fri, 17 Nov 2023 04:49:29 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHAASCm007053;
        Fri, 17 Nov 2023 12:49:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=k5CTRmP8Dr8pIKGgnBBikkofnWOfhOYKNVD3rB3RnQQ=;
 b=OR46SmrF8hN+QgflLW60ruS3pCNQcy0HDUBnjlxyZHbcRfMHDocQxYi5tlwIOY2ZaBm7
 ROAtx5RSYkNLnTxfTEc+LGpsrZ6jF6trMmKx2l/3yEv3vOSZsYGfWXMQWPOOWNnKMG+X
 WnVWEdsoaawes+PS3+ULrlZcNq/cyjM+B8V998B8lLTA42lqhzx9xCzXFq/ddBSQFSY6
 jXtisnDqd8yA+zaK7TSEsA1DZ558XMwnoYW3U4/NY4yyMuZOr2235t6Nvmmiu9jox011
 kqQfuzIvPeZh5PcMkdWlImEstzfDGUTsXGQd+7Ga4NE+I/Rhrx8yKJ2aHgdFtROlzdd7 /A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ue2na0srq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 12:49:25 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AHCnOcC008154
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 12:49:24 GMT
Received: from [10.214.67.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 17 Nov
 2023 04:49:20 -0800
Message-ID: <eaf356c5-2fbe-0c45-f324-219b079d697b@quicinc.com>
Date:   Fri, 17 Nov 2023 18:19:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH 2/2] arm64: dts: qcom: qcm6490: Add qcm6490 idp and
 rb3 board
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_nainmeht@quicinc.com>
References: <20231103184655.23555-1-quic_kbajaj@quicinc.com>
 <20231103184655.23555-3-quic_kbajaj@quicinc.com>
 <62860baa-4a0f-4a69-bbe4-94579c28a1cb@linaro.org>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <62860baa-4a0f-4a69-bbe4-94579c28a1cb@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nOOG34vjfKN3nuS5Zau7DRCqXtMS8sIZ
X-Proofpoint-ORIG-GUID: nOOG34vjfKN3nuS5Zau7DRCqXtMS8sIZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_11,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=804 phishscore=0 suspectscore=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311170095
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/4/2023 6:02 PM, Konrad Dybcio wrote:
>
>
> On 11/3/23 19:46, Komal Bajaj wrote:
>> Add qcm6490 devicetree file for QCM6490 IDP and QCM6490 RB3
>> platform. QCM6490 is derived from SC7280 meant for various
>> form factor including IoT.
>>
>> Supported features are, as of now:
>> * Debug UART
>> * eMMC (only in IDP)
>> * USB
>>
>> Co-developed-by: Naina Mehta <quic_nainmeht@quicinc.com>
>> Signed-off-by: Naina Mehta <quic_nainmeht@quicinc.com>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
> [...]
>
>> +
>> +&sdhc_1 {
>> +    non-removable;
>> +    no-sd;
>> +    no-sdio;
>> +
>> +    vmmc-supply = <&vreg_l7b_2p952>;
>> +    vqmmc-supply = <&vreg_l19b_1p8>;
> I think you also need to add regulator-allow-set-mode and something
> something regulator allowed modes to VQMMC

Okay, will add properties "regulator-allow-set-load" and 
"regulator-allowed-modes" to regulator vreg_l19b_1p8.

>
> [...]
>
>> +    model = "Qualcomm Technologies, Inc. QCM6490 RB3";
> Is the name just "QCM6490 RB3"? One already exists, based on SDM845.

Yeah, I missed that, this board is RB3Gen2, will update that in next 
patchset.

Thanks
Komal

>
> Otherwise, this looks very good to me now, thanks.
>
> With these nits addressed:
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>
> Konrad

