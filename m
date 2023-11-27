Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05CE7F98FB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 06:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjK0F6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 00:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjK0F6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 00:58:43 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C34139;
        Sun, 26 Nov 2023 21:58:49 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR5NX6R018172;
        Mon, 27 Nov 2023 05:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ljPu8Ir6MQffxqmkEQGJhg2zUpHKipO7TJg8/9VOwgw=;
 b=QFcOeOvBmw2ZRzWArU4vrLzAFD262nZpkD8K4tq9wz2T1TdaGwN7PBXNG4nUBTzJ+1ZA
 K1Omx5mSINDfUHrqFUJ6JOShNEAkhhvAqRhnIWzeAiJ81fFN79ck3Kvdb5ZlSIKigV7u
 ap0sjDSgtkaH1X5+pr4KE7RyS36TBnDgZzU51xaHRYcrExTAO02EDbiCvgfQ1edjFDjy
 Ku9I2s1jb7er14iPj2gmEVaw053Iur70HhIpOq1ib+j+2cpwWuTMoE+VM5dOqwaX5s7G
 BFAdWpn0bRQXd4ozdK9JZvPDvIswaG2lrmO9Nzo5ZMaDleRD2lVOd4dNjp7ihEP94ond jw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uk95cbbnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 05:58:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AR5wSWs019690
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 05:58:28 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 26 Nov
 2023 21:58:20 -0800
Message-ID: <ef0f23fa-03b2-45f3-b803-4bd319d91ee7@quicinc.com>
Date:   Mon, 27 Nov 2023 13:58:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] arm64: dts: qcom: sm4450-qrd: mark QRD4450
 reserved gpios
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <geert+renesas@glider.be>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <m.szyprowski@samsung.com>,
        <u-kumar1@ti.com>, <peng.fan@nxp.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tdas@quicinc.com>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <kernel@quicinc.com>
References: <20231031075004.3850-1-quic_tengfan@quicinc.com>
 <20231031075004.3850-6-quic_tengfan@quicinc.com>
 <6a799fc7-8d7d-4035-8e7e-458f9a61bf4e@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <6a799fc7-8d7d-4035-8e7e-458f9a61bf4e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xKm7vNjxWLIcxq4QGvXGr7YxCjvlGFae
X-Proofpoint-ORIG-GUID: xKm7vNjxWLIcxq4QGvXGr7YxCjvlGFae
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_03,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=911 spamscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270040
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 11/18/2023 8:45 AM, Konrad Dybcio 写道:
> On 31.10.2023 08:50, Tengfei Fan wrote:
>> Some gpios are reserved for other subsystems, so mark these reserved
>> gpios.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm4450-qrd.dts | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm4450-qrd.dts b/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
>> index bb8c58fb4267..e354bad57a9e 100644
>> --- a/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
>> @@ -23,6 +23,11 @@
>>   	status = "okay";
>>   };
>>   
>> +&tlmm {
>> +	/* Reserved for other subsystems */
> that much we can guess :D
> 
> it would be very appreciated if you could do e.g.
> 
> <0 4>, /* fingerprint scanner */
> <136 1>; /* coffee machine trigger */
> 
> Konrad
Hi Konrad,
Thank you for reviewing this patch series, I will update new patch 
series according to your suggestion.


-- 
Thx and BRs,
Tengfei Fan
