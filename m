Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E647979F786
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 04:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbjINCFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 22:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbjINCF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:05:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C658A7A;
        Wed, 13 Sep 2023 18:59:58 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E0v5eP021892;
        Thu, 14 Sep 2023 01:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=x8n3MXEK2j8hijljFVUVtE3/21k8bAP/M6M7qZvc9lw=;
 b=SjnNt5rn/i4ZxE860ySihJWE6fUs4HQmfsLL6Px8bQLe6/Zf79K6H0pKb/cPwP5a7xS1
 eQQ2k9giwQftxhPbTYCApr30wjbdNt8cO0a9B/3ArLIiW4g5+Zqrgj4kKZVd7SwWV4L/
 afGk2hzPdLqnKb6A/gEu0ADhyofTmd5ygt6nhkLAuAsqODm4RNf0R6k7s23SgXXiTNvu
 QyvLP7EuEMkkxH9qmAoNpO4VlyTPHjZHkiIrxTErHdomuetEfPDl+EbKuf3o8iZzPptM
 6Na02fqagwbemqu0Z+OFux4uvWHFZ013mRbMwdy4qwTjkEQactXIzhsZMu+fMejWHnpG gg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3h0dh15m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 01:59:28 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38E1xRsG031046
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 01:59:27 GMT
Received: from [10.239.155.136] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 13 Sep
 2023 18:59:22 -0700
Message-ID: <ee823de5-d5b4-6719-a7e3-cc799cd15ad1@quicinc.com>
Date:   Thu, 14 Sep 2023 09:59:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] scsi: ufs: qcom: dt-bindings: Add MCQ ESI property
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <quic_asutoshd@quicinc.com>, <quic_cang@quicinc.com>,
        <bvanassche@acm.org>, <mani@kernel.org>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <junwoo80.lee@samsung.com>, <martin.petersen@oracle.com>,
        <quic_nguyenb@quicinc.com>, <quic_nitirawa@quicinc.com>
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
 <0231fa19-bc71-db11-ffd4-8c922d110447@linaro.org>
From:   Ziqi Chen <quic_ziqichen@quicinc.com>
In-Reply-To: <0231fa19-bc71-db11-ffd4-8c922d110447@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: p5-lBC98slKbgOoJUZwZ5RTPrf5DOIWG
X-Proofpoint-GUID: p5-lBC98slKbgOoJUZwZ5RTPrf5DOIWG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_19,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140016
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof，

Thanks for your comment very much ~
I will remove this property in next patch version.
We just plan to post "msi-parent" property for MCQ.


Best Regards,
Ziqi

On 9/11/2023 2:27 PM, Krzysztof Kozlowski wrote:
> On 08/09/2023 10:53, Ziqi Chen wrote:
>> Document the description for the qcom,esi-affinity-mask.
> 
> This tells me nothing what is this feature for.
> 
>>
>> Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>> index bdfa86a..323595f 100644
>> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>> @@ -97,6 +97,10 @@ properties:
>>       description:
>>         GPIO connected to the RESET pin of the UFS memory device.
>>   
>> +  qcom,esi-affinity-mask:
> 
> Not tested. You also miss proper type.
> 
>> +    description:
>> +       UFS MCQ ESI affinity mask. Affine ESI on registration according to this CPU mask.
> 
> And why is this a property of DT? Aren't you now describing driver?
> 
> 
> 
> Best regards,
> Krzysztof
> 
