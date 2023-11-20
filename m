Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0397F0C08
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 07:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjKTG42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 01:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKTG41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 01:56:27 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACC1F2;
        Sun, 19 Nov 2023 22:56:23 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK6ZnM5002535;
        Mon, 20 Nov 2023 06:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OKEJjm5aN1l4o2f+SqNh6eGORVtx0Z2xW2ehY6xaRn4=;
 b=EIvEs93dnOtbvuq3TnoVoIM9X7ubxnpB29Ke9egYAx4D+ewllwsFgjimqoshgQ51pUNn
 7tCxf9neYLDrKtM+3ldKb7E1OGmH+qNtxITcOJ+X2xU1C5Nd5wM/wVip+N7oSaNL1SPg
 gqSlzNZHDPMOYRCzARwhTRW8eT62ndo70MspQQOqDE5IPeEweFlLD8lmOZqH8hAERpmI
 rKOK3PBPpDHffqRdvguwnDnl1UA13REl9QSbqKtsGRElT3C1xSVX/cZ1c/O3dALCBiWv
 Sc7DpM2u4InSYgEb8VJfd/slemkvYUaLUYtkTE5DXCveR/x1Cg994Svt/2vW+Mo+sN+o Ag== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ug2ax8121-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 06:56:20 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AK6uJJ6021950
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 06:56:19 GMT
Received: from [10.79.43.91] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 19 Nov
 2023 22:56:14 -0800
Message-ID: <a4ec96b7-0bb1-ea3c-26cb-999d0c8c111a@quicinc.com>
Date:   Mon, 20 Nov 2023 12:26:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 1/2] dt-bindings: cache: qcom,llcc: Add X1E80100
 compatible
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <agross@kernel.org>, <conor+dt@kernel.org>,
        <quic_rjendra@quicinc.com>, <abel.vesa@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <neil.armstrong@linaro.org>
References: <20231117095315.2087-1-quic_sibis@quicinc.com>
 <20231117095315.2087-2-quic_sibis@quicinc.com>
 <f3cd8531-faa8-4ec4-b1b8-ba327b7df5cd@linaro.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <f3cd8531-faa8-4ec4-b1b8-ba327b7df5cd@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jGVR5QIae_IRCrZDHaLQMiMyseC9Ea6B
X-Proofpoint-ORIG-GUID: jGVR5QIae_IRCrZDHaLQMiMyseC9Ea6B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_04,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0
 mlxlogscore=647 impostorscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311200043
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/18/23 05:07, Konrad Dybcio wrote:
> On 17.11.2023 10:53, Sibi Sankar wrote:
>> From: Rajendra Nayak <quic_rjendra@quicinc.com>
>>
>> Add the compatible for X1E80100 platforms.
>>
>> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
>> Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
> Unrelated to this patch alone, but I noticed that with this new naming
> scheme, patterns in Documentation/devicetree/bindings/arm/qcom-soc.yaml will
> require an update as well.

Thanks for catching ^^. Will include it in the next re-spin of
the appropriate series.

-Sibi

> 
> Konrad
