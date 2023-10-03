Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325867B631D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239234AbjJCIEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239205AbjJCIEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:04:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC2FA3;
        Tue,  3 Oct 2023 01:04:39 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3937UXkH029952;
        Tue, 3 Oct 2023 08:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/VgCu5h1nT1rdcGyJuB5n5ilmO0Vmv6JYljZEWurec0=;
 b=Dy3D6+GWlqV0MLxGJJwCA/glEYktMe5ihNFbs6SAnoUI9iSpIMuL+oeTpsNOJj2tu+Q/
 ktxJiZOxMB2WMEog/UYmYH2aUsy+n5qQ4p1sWvJTnrzt+mTJN5DeAp+6A1BpUUP41UTf
 LPsl2anTHYoeS1eWY61Gy+WdGIHA9EHCcjHd/eFiKolAniOJ4Kmz+Ljo4sGTTjdlYgVQ
 wjrQ1j6Y3bx/Gl/vL8oUpfjNGA1F9etvFd8JDeOMU4CopjEYwTccUdLSFhCFAffY166r
 kZ3Y3OoYQWFIHolzc/8CSbD6N92fCVtXn3UIckeqHjD28ctZlk+/Z2BFdmY6rDci8pID 0Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tgbjgrd21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 08:04:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39384UjL025473
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Oct 2023 08:04:30 GMT
Received: from [10.214.66.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 3 Oct
 2023 01:04:26 -0700
Message-ID: <5d99708e-95a0-401b-b636-4f535fdd5905@quicinc.com>
Date:   Tue, 3 Oct 2023 13:34:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: Add interconnect nodes for SDX75
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dmitry.baryshkov@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1695720564-2978-1-git-send-email-quic_rohiagar@quicinc.com>
 <1695720564-2978-2-git-send-email-quic_rohiagar@quicinc.com>
 <35703a29-5c5a-47a8-9a4b-04953dc3faba@linaro.org>
Content-Language: en-US
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <35703a29-5c5a-47a8-9a4b-04953dc3faba@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: voej0zTun7aGK_ecJJ7QpyWL5kctmoBL
X-Proofpoint-GUID: voej0zTun7aGK_ecJJ7QpyWL5kctmoBL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_04,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=694 phishscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030056
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/27/2023 4:17 PM, Konrad Dybcio wrote:
> On 26.09.2023 11:29, Rohit Agarwal wrote:
>> Add interconnect nodes to support interconnects on SDX75.
>> Also parallely add the interconnect property for UART required
>> so that the bootup to shell does not break with interconnects
>> in place.
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> ---
> [...]
>
>>   		scm: scm {
>>   			compatible = "qcom,scm-sdx75", "qcom,scm";
>> @@ -434,6 +448,8 @@
>>   			clock-names = "m-ahb",
>>   				      "s-ahb";
>>   			iommus = <&apps_smmu 0xe3 0x0>;
>> +			interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>;
> 0 -> QCOM_ICC_TAG_ALWAYS (dt-bindings/interconnect/qcom,icc.h)
Ok, Let me update this.

Thanks,
Rohit.
>
> Konrad
