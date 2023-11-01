Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8DF7DDD6B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 08:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjKAHsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 03:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjKAHst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 03:48:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CB010A;
        Wed,  1 Nov 2023 00:48:43 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A15xZaA005874;
        Wed, 1 Nov 2023 07:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KRFrtO4kssHKHeqoPSDqQC9Dhp30rMg3dm5Abqs1GX0=;
 b=nSS91YSv9QqumndNrJYSTtNf32gojkhgnBc+lzI6TR4exsW1I066WcT5O0IWAtGUdcmP
 xlSBZlmBxAXMpapSLFulpwAPdr5Lpq4Da/d7jpLUaI8h4X2mFKua2eZ2v/F5Qmm2gwcN
 +s08CTPWdJpXZezOoKsTkYo0H7E4FuCNYJQR/at1ASXf6vXAjuI9mmPoTUD4lm2oR77Z
 ouPpGRQapADSFLvAgIKbm7aZ/QBW8engQTjxZVdBB7FPT48OT3r78jxnKy8eABD8+odH
 mvIp/mPq5xtqtKMpVybeyYqyixV8PaRS7bsEQch1FugU8cFub2hSpWM9fJRc6Rz1614m 2Q== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u30xeb6sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 07:48:16 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A17mFI5028726
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Nov 2023 07:48:15 GMT
Received: from [10.239.155.136] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 1 Nov
 2023 00:48:10 -0700
Message-ID: <5799c6dd-e9ae-ce9f-b9a6-096d03916584@quicinc.com>
Date:   Wed, 1 Nov 2023 15:48:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: ufs: qcom: Add msi-parent for UFS MCQ
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <quic_asutoshd@quicinc.com>, <quic_cang@quicinc.com>,
        <bvanassche@acm.org>, <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <junwoo80.lee@samsung.com>, <martin.petersen@oracle.com>,
        <quic_nguyenb@quicinc.com>, <quic_nitirawa@quicinc.com>,
        <quic_rampraka@quicinc.com>, <linux-scsi@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1698811270-76312-1-git-send-email-quic_ziqichen@quicinc.com>
 <20231101050116.GB2897@thinkpad>
From:   Ziqi Chen <quic_ziqichen@quicinc.com>
In-Reply-To: <20231101050116.GB2897@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fKYPe1GBJrDCZgPZMiZtf4iOlU-bTmg3
X-Proofpoint-ORIG-GUID: fKYPe1GBJrDCZgPZMiZtf4iOlU-bTmg3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_05,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311010064
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/1/2023 1:01 PM, Manivannan Sadhasivam wrote:
> On Wed, Nov 01, 2023 at 12:01:09PM +0800, Ziqi Chen wrote:
>> The Message Signaled Interrupt (MSI) has been used
>> by UFS driver since the MCQ be enabled. Hence in UFS
>> DT node, we need to give the msi-parent property that
>> point to the hardware entity that serves as the MSI
>> controller for this UFS controller.
>>
>> Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>> index 462ead5..d2f505a 100644
>> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>> @@ -103,6 +103,8 @@ properties:
>>       description:
>>         GPIO connected to the RESET pin of the UFS memory device.
>>   
>> +  msi-parent: true
>> +
> 
> This property is not Qcom specific. So this should be part of ufs-common.yaml.
Make sense, thanks for review, I will update to ufs-common.yam.
> 
> - Mani
> 
>>   required:
>>     - compatible
>>     - reg
>> @@ -318,5 +320,6 @@ examples:
>>                               <0 0>,
>>                               <0 0>;
>>               qcom,ice = <&ice>;
>> +            msi-parent = <&gic_its 0x60>;
>>           };
>>       };
>> -- 
>> 2.7.4
>>
> 
