Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08C0792AD9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244117AbjIEQn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354142AbjIEJ4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:56:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D2718C;
        Tue,  5 Sep 2023 02:56:28 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3859Ex9I002295;
        Tue, 5 Sep 2023 09:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BJU/aztU2Sgiooahz+oauJme3H4sup1zMkbjfNJYZDs=;
 b=WCiiCTEgpz0sU0aZYPR7WFYhrV9plDX/Ya3RgcyDyZI6u769TAPTju0bomC/pMJimiOO
 E1pibZmC+K8b/Ag1+L3MmDs/abL1TbdFg+BePKkTogjk6Kiho0JT7fvMfVX+P4nf9P8A
 5LzSRXIUdx+oHNlG7VSpGycGtf+QG+msfyvuf8V5ZRnbEznM/dvi64hqGNFwr6EpY14g
 z66DQBp/EKttlbsrVETkkmmFj6Cterpp0/ROe0nmA08H4i1GRMXQK+M1DFDu21C+/pgt
 /cajiSQiNe7ABi79Tb95h+pJJ/ip87mWilzwgeMiv8fy5NQ/g0Qgg3Qgc3uicKLsTKIt hA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3swtevgs9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 09:56:19 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3859uI3M027116
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Sep 2023 09:56:18 GMT
Received: from [10.201.162.56] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 5 Sep
 2023 02:56:12 -0700
Message-ID: <bd754243-a04f-466a-9c19-2163ee7008c4@quicinc.com>
Date:   Tue, 5 Sep 2023 15:26:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hwspinlock: qcom: Drop unused qcom,ipq6018-tcsr-mutex
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ohad@wizery.com>,
        <baolin.wang@linux.alibaba.com>, <linux-remoteproc@vger.kernel.org>
CC:     <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>
References: <20230904055010.4118982-1-quic_viswanat@quicinc.com>
 <20230904055010.4118982-3-quic_viswanat@quicinc.com>
 <17c8ba39-2bcf-5799-13ff-bb96249dbf61@linaro.org>
 <880706cd-0987-47c7-8785-f8e4cb1c1907@linaro.org>
 <90795790-a5e4-419f-9e40-989731c1c685@quicinc.com>
 <246760a3-3230-e14d-0541-72d8f0da5fd2@linaro.org>
Content-Language: en-US
From:   Vignesh Viswanathan <quic_viswanat@quicinc.com>
In-Reply-To: <246760a3-3230-e14d-0541-72d8f0da5fd2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: r8O-vwmHhyBMaPAd1K5R6KkZtkDXIwau
X-Proofpoint-ORIG-GUID: r8O-vwmHhyBMaPAd1K5R6KkZtkDXIwau
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_07,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=690
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309050088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/2023 11:46 PM, Krzysztof Kozlowski wrote:
> On 04/09/2023 18:09, Vignesh Viswanathan wrote:
>>
>>
>> On 9/4/2023 9:31 PM, Konrad Dybcio wrote:
>>> On 4.09.2023 08:42, Krzysztof Kozlowski wrote:
>>>> On 04/09/2023 07:50, Vignesh Viswanathan wrote:
>>>>> qcom,ipq6018-tcsr-mutex maps to incorrect config of IPQ6018 and is
>>>>> dropped from the devictree.
>>>>
>>>> No, it is not dropped.
>>>>
>>>>
>>>>> IPQ6018 will use qcom,tcsr-mutex compatible
>>>>> string.
>>>>
>>>> No, it will not.
>>>>
>>>>>
>>>>> Drop qcom,ipq6018-tcsr-mutex compatible string from
>>>>> qcom_hwspinlock_of_match table.
>>>>
>>>> Why? Do not write what you are doing here, but why you are doing it.
>>> More importantly, looks like the ipq6018 compatible was added after
>>> support for this SoC was introduced (see f5e303aefc06 and 5bf635621245a),
>>> so if it's going to use of_tcsr_mutex data with the fallback compat, the
>>> SoC-specific compatible can be removed from the driver.
>>>
>> Hi Konrad, Krzysztof,
>>
>> I was planning to update the SOC-specific compatible for IPQ6018
>> qcom,ipq6018-tcsr-mutex to point to of_tcsr_mutex data in the of_match
>> table in the hwspinlock driver in V2.
>>
>> Do you think this would be okay? or should I go ahead with removal of
>> IPQ6018 specific compatible so that it falls back to of_tcsr_mutex?
> 
> Remove, it's not needed in the driver.

Ack, will remove in V2.
> 
> Best regards,
> Krzysztof
> 
