Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5073793AFF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239295AbjIFLYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbjIFLYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:24:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB02C10CE;
        Wed,  6 Sep 2023 04:23:39 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3869RcRn011677;
        Wed, 6 Sep 2023 11:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fMecGYWVMbKDPwlrF1uhldockoqisrqfdD57IoanxLk=;
 b=Lxbs6jjMi8oUwwRtqhARUCHEdTdk9XOxR0apJud6eNhos1WTndXQe9OURSyNdreerBL7
 Be3bhkXw5N2qFRyCQqX9n1CaRcV6fj13I89yFZ3Se0sWGI1DzkKlFffn4pvT6qlCDWN5
 6pG9OC4B95DXLzTqPzOdZCtjzFI7Ne5wn2H5g7Wq7RIqk5p1baq2sApk6kBlgorEw/+Z
 isxRfuB+mWzfn7v70dhYK75nrznsSnKOCNPLSskZwlpfstXfkSoJlSsbhijngp3ud21K
 rMCYiPz7Xuv78V+e3fhg2GDOHgagXF8FKhvTrdJN0jJEb47/ARZqrGuTtSPZjhPSBNPh eg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sxgk2s7rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 11:23:34 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 386BNXVM028530
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Sep 2023 11:23:33 GMT
Received: from [10.201.162.56] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 6 Sep
 2023 04:23:29 -0700
Message-ID: <11a37c52-51fd-40ec-8613-9c87a03cbd5a@quicinc.com>
Date:   Wed, 6 Sep 2023 16:53:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] arm64: dts: qcom: ipq5332: Fix hwlock index for
 SMEM
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>, <stable@vger.kernel.org>
References: <20230904172516.479866-1-quic_viswanat@quicinc.com>
 <20230904172516.479866-2-quic_viswanat@quicinc.com>
 <c3880fac-7ed4-4981-87a5-8243a81f7342@linaro.org>
Content-Language: en-US
From:   Vignesh Viswanathan <quic_viswanat@quicinc.com>
In-Reply-To: <c3880fac-7ed4-4981-87a5-8243a81f7342@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3E6WjnRFf7njn29ITaOvk-cv4vJiq-0H
X-Proofpoint-ORIG-GUID: 3E6WjnRFf7njn29ITaOvk-cv4vJiq-0H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=725 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060096
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/6/2023 3:22 PM, Konrad Dybcio wrote:
> On 4.09.2023 19:25, Vignesh Viswanathan wrote:
>> SMEM uses lock index 3 of the TCSR Mutex hwlock for allocations
>> in SMEM region shared by the Host and FW.
>>
>> Fix the SMEM hwlock index to 3 for IPQ5332.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: d56dd7f935e1 ("arm64: dts: qcom: ipq5332: add SMEM support")
>> Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
>> ---
> Your downstream says otherwise [1]. Perhaps you need to fix it there
> as well?
> 

Yes, the fix is already merged in the downstream branch but CLO is not
updated date yet.

Thanks,
Vignesh

> Konrad
> 
> [1] https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4.r1/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> 
