Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061C476A962
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjHAGmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjHAGmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:42:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01DD185;
        Mon, 31 Jul 2023 23:42:08 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3715Knxt002194;
        Tue, 1 Aug 2023 06:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JUCZYSbtRRVfIaBsQCXW/64JszzaD7qsRz/lNLaF4vo=;
 b=C4jldoOfPOu6RYUEpE26Lnuvh4+K4RWR83wYInsBrI2ZFExDFGxtEVELAXV1RQnU1BZz
 YfaBB4+H+T2i5NiKyOvBRNxWhdEyvWhUB3R3kEmiprj7A7sta/uRR9JrKDQqY6ARBSvL
 wVF/zdNrsqiDo+h+aLtwqUlcjJYUhvwyrutdcVm1aYMB0dx9PJ2hbMAyaDtgXK5HFgj7
 ESk6c/OPetzIDlrLZGPe7oDmnALe1QIc/mAGjjVsuiXt4gtvlNbf43FAxuGfhf1u8nuh
 QNqd7SxIwhgAu6/iCgdJLzwQ4Wbbt5tz+NNAXWvLcLag+pJ0oWfnspjDnsI1WK5YoTB7 0Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6ckfjfg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 06:42:06 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3716g5aJ032453
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Aug 2023 06:42:05 GMT
Received: from [10.201.3.91] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 31 Jul
 2023 23:42:02 -0700
Message-ID: <b1049e10-95ee-7342-56ec-f0dc683f4759@quicinc.com>
Date:   Tue, 1 Aug 2023 12:11:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] soc: qcom: qmi_encdec: Restrict string length in
 decode
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     <agross@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_varada@quicinc.com>, <quic_clew@quicinc.com>
References: <20230731100311.2506271-1-quic_ipkumar@quicinc.com>
 <educjx3enypc4r5pzjb7vopaf2df2s4kzkpqsyecoysxws5422@arrsgt6vjej2>
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <educjx3enypc4r5pzjb7vopaf2df2s4kzkpqsyecoysxws5422@arrsgt6vjej2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pNJ_uwEbKEgf667cgEavBfEqXoLrXwNT
X-Proofpoint-ORIG-GUID: pNJ_uwEbKEgf667cgEavBfEqXoLrXwNT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_03,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308010060
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/1/2023 4:54 AM, Bjorn Andersson wrote:
> On Mon, Jul 31, 2023 at 03:33:11PM +0530, Praveenkumar I wrote:
>> The QMI TLV value for strings in a lot of qmi element info structures
>> account for null terminated strings with MAX_LEN + 1. If a string is
>> actually MAX_LEN + 1 length, this will cause an out of bounds access
>> when the NULL character is appended in decoding.
>>
>> Fixes: 9b8a11e82615 ("soc: qcom: Introduce QMI encoder/decoder")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> The signed-off-by list says that Chris certified the patch's origin
> first, then you took it, certified the origin and submitted it to the
> mailing list.
>
> This matches reality, but you lost Chris' authorship in the process,
> please add that back.
Yes, you are right. Will add that, and post it.

- Praveenkumar
> Thanks,
> Bjorn
>
>> ---
>> [v2]:
>> 	Added Fixes and Cc: stable
>>
>>   drivers/soc/qcom/qmi_encdec.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/qmi_encdec.c b/drivers/soc/qcom/qmi_encdec.c
>> index b7158e3c3a0b..5c7161b18b72 100644
>> --- a/drivers/soc/qcom/qmi_encdec.c
>> +++ b/drivers/soc/qcom/qmi_encdec.c
>> @@ -534,8 +534,8 @@ static int qmi_decode_string_elem(const struct qmi_elem_info *ei_array,
>>   		decoded_bytes += rc;
>>   	}
>>   
>> -	if (string_len > temp_ei->elem_len) {
>> -		pr_err("%s: String len %d > Max Len %d\n",
>> +	if (string_len >= temp_ei->elem_len) {
>> +		pr_err("%s: String len %d >= Max Len %d\n",
>>   		       __func__, string_len, temp_ei->elem_len);
>>   		return -ETOOSMALL;
>>   	} else if (string_len > tlv_len) {
>> -- 
>> 2.34.1
>>
