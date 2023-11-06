Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF1B7E2A9A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 18:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjKFRFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 12:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjKFRFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 12:05:51 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E552191;
        Mon,  6 Nov 2023 09:05:48 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6ARCgu025332;
        Mon, 6 Nov 2023 17:05:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wnNHnFEMyfOZMGjEKUau1Yf64RRAah49EJ8lArNY59Q=;
 b=BtGTw+AzMmJD0qTvfHNn6fwP3qJXAUztU7Z/Kh4NguxnCxNaa+NlGiUPF3a3dAEI9fAA
 Xcfa4xWKpXg2gHB+dXaTvH3/etceFJ8eDTFKQnq607ecTKfbyXAvzXAjqnYYiTTYE0er
 dqh+DGb3TuW0QiZiAtX8/qoundcZ9+VVkvSLTmsQVHXhEhgWZJTQGTg074wWBbDgg3O9
 GLgPQ0igDhTMg2L/QtxMvPL1zzSXMJBBP5VT1kFVdoDQcGW1gQqkNj/MFPOVIdHp4LwH
 CKKYyLSes4Lh/kgvofkp++C2NafIdF/dqQ3JSzp3MSdORTbnXsO5HFl3ZU7CwZopJ06Y Zw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u5efymwhy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 17:05:37 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A6H5aMk002573
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Nov 2023 17:05:36 GMT
Received: from [10.71.108.203] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 6 Nov
 2023 09:05:36 -0800
Message-ID: <e2b73ea0-c659-431e-9275-88d1a98f37cf@quicinc.com>
Date:   Mon, 6 Nov 2023 09:05:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] dt-bindings: crypto: qcom,prng: Add SM8450
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231103225255.867243-1-quic_eberman@quicinc.com>
 <04707003-531c-4c58-af74-e770d22d85e4@linaro.org>
Content-Language: en-US
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <04707003-531c-4c58-af74-e770d22d85e4@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: o_DmlOkt3kEXJKMkLTRMgQjammDGuK-L
X-Proofpoint-ORIG-GUID: o_DmlOkt3kEXJKMkLTRMgQjammDGuK-L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_12,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=986 priorityscore=1501 malwarescore=0 mlxscore=0 clxscore=1015
 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/5/2023 5:03 AM, Krzysztof Kozlowski wrote:
> On 03/11/2023 23:52, Elliot Berman wrote:
>> From: Konrad Dybcio <konrad.dybcio@linaro.org>
>>
>> SM8450's PRNG does not require a core clock reference. Add a new
>> compatible with a qcom,prng-ee fallback and handle that.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>> I noticed this patch got missed while running make dtbs_check. No
>> changes to this patch from the original version:
>>
>> https://lore.kernel.org/all/2c208796-5ad6-c362-dabc-1228b978ca1d@linaro.org/
>>
> 
> I don't understand why do you send this. This is not a correct patch,
> was rejected. Different patch was already merged.

I see that 6.6 has

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/sm8450.dtsi?h=v6.6#n1741

but bindings not updated:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/crypto/qcom,prng.yaml?h=v6.6

I came up with similar-ish fix offline, then found Konrad had posted the patch when searching lore.
I didn't find any other patch on lore. 

I think you rejected a proposal to drop "p" from "prng", but this patch
doesn't do that and we stayed course with naming scheme.

Thanks,

Elliot
