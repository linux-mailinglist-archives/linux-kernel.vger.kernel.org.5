Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D697D29F8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjJWGLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJWGLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:11:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EB199;
        Sun, 22 Oct 2023 23:11:41 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39N5MD7p029867;
        Mon, 23 Oct 2023 06:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=W2R2ajT1fL6o3Lpqn6c7xHOBDZ/MJbwbTlK2BnDYaCQ=;
 b=M4jcuHLITpTe//hRAvgNIDC+HcpG8AMZq0+T/6i3yOyWn62oRBOf0eTPxDlwkt1dvqxI
 gC2wlYB33GD5lGJTdX4ncjNOs0IV8BDZtnXWWvFzPol0pfWWZO+MznIhVwIZGRYP6Xgj
 oqJuDveWu3ZnMknoWY6WBnj7jR8D7fyJso2Q3R5XJL0zqypoR5w2+JN5EPgm9o9q809h
 YVJhM6lRRWxTSUc8Bp4fo0OdFr3ZJqGAQHP92cUdUmqwAksLnX1o3Qi+cw8fZ9SS4n36
 ae8nILyvQzwO6HnIbVPPrQvu0J45RqJw8M/W3eWMp8h7bE9xPbCcLDbS5i1yNUqAikt2 Vg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv5ndu92v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 06:11:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39N6Ajn1007671
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 06:10:45 GMT
Received: from [10.216.48.174] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sun, 22 Oct
 2023 23:10:34 -0700
Message-ID: <9391365a-035c-4a51-aa41-e6878b6e034e@quicinc.com>
Date:   Mon, 23 Oct 2023 11:40:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 04/11] iio: adc: Update bindings to remove support for
 ADC7 name used on QCOM PMICs
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <sboyd@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_kamalw@quicinc.com>,
        <quic_jestar@quicinc.com>, <marijn.suijten@somainline.org>,
        <andriy.shevchenko@linux.intel.com>,
        <krzysztof.kozlowski@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang Rui" <rui.zhang@intel.com>, Luca Weiss <luca@z3ntu.xyz>,
        <linux-iio@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm-owner@vger.kernel.org>
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-5-quic_jprakash@quicinc.com>
 <20230708160239.63cb1e7f@jic23-huawei>
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <20230708160239.63cb1e7f@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PSiDGBNNUrZmNV9fVdctPjCnlgaF1r54
X-Proofpoint-ORIG-GUID: PSiDGBNNUrZmNV9fVdctPjCnlgaF1r54
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_03,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=784 bulkscore=0
 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310230054
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 7/8/2023 8:32 PM, Jonathan Cameron wrote:
> On Sat, 8 Jul 2023 12:58:28 +0530
> Jishnu Prakash <quic_jprakash@quicinc.com> wrote:
>
>> Now that usage of "ADC7" name has been replaced with usage of "ADC5
>> Gen2" name everywhere, remove all support for "ADC7" name.
>>
>> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>

>> @@ -26,7 +26,6 @@ properties:
>>             - qcom,spmi-vadc
>>             - qcom,spmi-adc5
>>             - qcom,spmi-adc-rev2
>> -          - qcom,spmi-adc7
>>             - qcom,spmi-adc5-gen2
>>   
>>     reg:
>> @@ -214,9 +213,7 @@ allOf:
>>         properties:
>>           compatible:
>>             contains:
>> -            enum :
>> -                - qcom,spmi-adc7
>> -                - qcom,spmi-adc5-gen2
>> +            const: qcom,spmi-adc5-gen2
>>   
>>       then:
>>         patternProperties:
> Hmm. Definitely can't drop support (as per comment on next patch).
> I think you should just mark it deprecated rather than remove it here but maybe
> you can drop it.  Let's see what DT binding maintainers say.
>
> Jonathan

Yes, I'll mark it deprecated without removing it.

Thanks,

Jishnu

