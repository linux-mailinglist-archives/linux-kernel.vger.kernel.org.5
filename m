Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA849768F35
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjGaHwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjGaHwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:52:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6859411A;
        Mon, 31 Jul 2023 00:52:05 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36V682CX023871;
        Mon, 31 Jul 2023 07:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LZwBj5VViWDEht+OAYzGm4i+CQ5yEXbnaOkA+0A4fmU=;
 b=aq6M32SlhZva0BcxU5pUY5vR5R5+BpggB/Xst4zy1xpznSoj0JkQ0/Zy2ahJ8bilsgf6
 Laj5HAgxIFKzW1H9QCzrsBI2roAl45HkAWGNlbbA1mZQqEpiCXoQ90kMZ35eTR1MSyz/
 SZ6c/psfla5oY+WxKCy6x0/yPT+w1ypQOdlCDY5D5aqbqW2SnI27kKn4KQGMHNuO8zf5
 nkW2XhANg6lBHMcnTxFbFRL7qV48z3HabG6FcMDDn9DjYwY8HBycZqPgO+abr+Qm/tu6
 OnNFBFyW72gXBtu0oc9P+nfAotPzMTl2Ejpg/M4S76CzLTGRGfrGUiW0ZSVfOuIVZzY8 NQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4usrjuc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 07:22:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36V7MY8N006243
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 07:22:34 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 31 Jul
 2023 00:22:30 -0700
Message-ID: <b20862ba-bfa5-69b8-08e6-08ce76cf36a5@quicinc.com>
Date:   Mon, 31 Jul 2023 15:22:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] soc: qcom: socinfo: adjust the position of QDU1010
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <quic_tsoni@quicinc.com>, <quic_shashim@quicinc.com>,
        <quic_kaushalk@quicinc.com>, <quic_tdas@quicinc.com>,
        <quic_tingweiz@quicinc.com>, <quic_aiquny@quicinc.com>,
        <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230731061325.26431-1-quic_tengfan@quicinc.com>
 <20230731061325.26431-7-quic_tengfan@quicinc.com>
 <a037a8d3-9ba4-80ee-b34e-9a795ebb6e5b@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <a037a8d3-9ba4-80ee-b34e-9a795ebb6e5b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: x1gYAeIriykoy4PmBAG_wchne7Oz8FMt
X-Proofpoint-ORIG-GUID: x1gYAeIriykoy4PmBAG_wchne7Oz8FMt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 mlxlogscore=858 malwarescore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310065
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 7/31/2023 3:00 PM, Krzysztof Kozlowski 写道:
> On 31/07/2023 08:13, Tengfei Fan wrote:
>> Adjust the position of QDU1010, so that QDU1010 have
>> same sequence with QCOM_ID_QDU1010 in bindings file.
>>
>> Change-Id: I86d46eca55e877aaa1fd948db99b41ae138a3129
> 
> Please run scripts/checkpatch.pl and fix reported warnings. Some
> warnings can be ignored, but the code here looks like it needs a fix.
> Feel free to get in touch if the warning is not clear.
> 
will check if still need this patch.
>> ---
>>   drivers/soc/qcom/socinfo.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
>> index 4d49945b3a35..ad7699b401a8 100644
>> --- a/drivers/soc/qcom/socinfo.c
>> +++ b/drivers/soc/qcom/socinfo.c
>> @@ -405,8 +405,8 @@ static const struct soc_id soc_id[] = {
>>   	{ qcom_board_id(SA8775P) },
>>   	{ qcom_board_id(QRU1000) },
>>   	{ qcom_board_id(QDU1000) },
>> -	{ qcom_board_id(QDU1010) },
>>   	{ qcom_board_id(IPQ5019) },
> 
> Same comment as on previous patch.
> 
Will remove this patch, another is handling this: 
https://lore.kernel.org/lkml/20230724083745.1015321-1-quic_kathirav@quicinc.com/T/
>> +	{ qcom_board_id(QDU1010) },
> 
> Best regards,
> Krzysztof
> 

-- 
Thx and BRs,
Tengfei Fan
