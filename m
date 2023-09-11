Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90AB79A2EE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 07:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbjIKFkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 01:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjIKFkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 01:40:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B1E1B8;
        Sun, 10 Sep 2023 22:40:30 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38B5Bnpl012956;
        Mon, 11 Sep 2023 05:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sk1Z3D5+cgXDrA4WA90F+J0Bcy/RvmZhsVZ+O5IE88s=;
 b=k6iavvVcml+2DPMIpgNwQf9ZwDEPcgS75ewKsgFwNB4mN4cAkL6NDrxmH0MegaoPVjUp
 5aM/o5NfunY+LeDMT2HhAMyn2dI0lMXjP/JEgK45n56sMaP6JY4y0el/KtmFs37RiaGZ
 tmguAFLW9q9wv9klgmdPp8XUg7d+vkSUr9Uwt60TeCL40e00daKXb3y3rW5kIqhcrIc1
 GLOiTO5aFLPCE4dUGS9iojIwIHImT6H06mlBOQMllc01eP3Bz2+onrYeKzCiiET5wB/q
 pbIpap0cdQy42Xci6F4q3WOWf8fImc97l0MFdFipX2OHWzU5kavIduf5Ww84eYh6ZqTa qg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t1u3yr5f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 05:40:05 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38B5e4g7022709
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 05:40:04 GMT
Received: from [10.239.155.136] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sun, 10 Sep
 2023 22:39:59 -0700
Message-ID: <ea1b8d2a-a519-c7f1-5a93-d73c16c4bd04@quicinc.com>
Date:   Mon, 11 Sep 2023 13:36:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] scsi: ufs: qcom: dt-bindings: Add MCQ ESI property
Content-Language: en-US
To:     <neil.armstrong@linaro.org>, <quic_asutoshd@quicinc.com>,
        <quic_cang@quicinc.com>, <bvanassche@acm.org>, <mani@kernel.org>,
        <adrian.hunter@intel.com>, <beanhuo@micron.com>,
        <avri.altman@wdc.com>, <junwoo80.lee@samsung.com>,
        <martin.petersen@oracle.com>, <quic_nguyenb@quicinc.com>,
        <quic_nitirawa@quicinc.com>
CC:     <linux-scsi@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1694163203-39123-1-git-send-email-quic_ziqichen@quicinc.com>
 <861a1baa-bbdb-49c2-b732-35c16f5e927e@linaro.org>
From:   Ziqi Chen <quic_ziqichen@quicinc.com>
In-Reply-To: <861a1baa-bbdb-49c2-b732-35c16f5e927e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tR4KC8Nr6gn_TtWPhsezR8nURtdWy87l
X-Proofpoint-ORIG-GUID: tR4KC8Nr6gn_TtWPhsezR8nURtdWy87l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 clxscore=1011 phishscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110051
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil，

Yes，I will post reg-name and msi-parent properties in next version as soon.
reg is required property and already exist. but I will make some changes
on this property.
As for qcom,esi-affinity-mask, we will put it off.

Thanks,
Ziqi

On 9/8/2023 5:35 PM, Neil Armstrong wrote:
> Hi,
> 
> On 08/09/2023 10:53, Ziqi Chen wrote:
>> Document the description for the qcom,esi-affinity-mask.
> 
> Do you plan to add all the other MCQ and ESI properties ? (reg, 
> reg-names, msi-parent)
> 
> Thanks,
> Neil
> 
>>
>> Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml 
>> b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>> index bdfa86a..323595f 100644
>> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>> @@ -97,6 +97,10 @@ properties:
>>       description:
>>         GPIO connected to the RESET pin of the UFS memory device.
>> +  qcom,esi-affinity-mask:
>> +    description:
>> +       UFS MCQ ESI affinity mask. Affine ESI on registration 
>> according to this CPU mask.
>> +
>>   required:
>>     - compatible
>>     - reg
> 
