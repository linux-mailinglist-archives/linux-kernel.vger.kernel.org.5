Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FF87FA675
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjK0QdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjK0QdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:33:02 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C9F99;
        Mon, 27 Nov 2023 08:33:08 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARD9P3X020717;
        Mon, 27 Nov 2023 16:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=QLA/171HhAOE/egCjy+Rmr5mzz8RCpW9xnlC5Re56ko=;
 b=czaiz0QHPHMLIgofj03Opd1tPrG07Wcb2I+E/cHXMgTeTrzraZ83raTFMaLcCRtTT0ZB
 SIUsik8Sf3yfSwK4D4/rA9Oceg5SgK33xsWV2vvwfc8qSrQ46JlQcfPb4nhF7j18GIb/
 FBxexQ5a0hCK/b+bNXNgqTCFOL1FnwY5tHaTPaqeqwIUkvujt9MKO7CacGJbSndGbkiH
 H4esM93yfW4FmxDrcOab5Tam9xXMsMwfrEyE35HqXuxJULVepnBg2JmYl0hD0tQ1+hih
 J/kqo+zn16jticgzddTjePhY0cRmJwnuR5WzFDRS+NTIM2m76SmrnvzMAZscmy+qch24 Vw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3umsvagvxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 16:32:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ARGWrSE026568
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 16:32:53 GMT
Received: from [10.110.63.243] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 27 Nov
 2023 08:32:52 -0800
Message-ID: <c5555ad6-6991-4fca-864f-355d2fae9ae1@quicinc.com>
Date:   Mon, 27 Nov 2023 08:32:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] wifi: ath11k: Use DECLARE_FLEX_ARRAY() for
 ath11k_htc_record
Content-Language: en-US
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kalle Valo <kvalo@kernel.org>
CC:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        <ath10k@lists.infradead.org>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231127-flexarray-htc_record-v1-0-6be1f36126fd@quicinc.com>
 <20231127-flexarray-htc_record-v1-4-6be1f36126fd@quicinc.com>
 <4f2a486c-c6de-43e4-8bb6-bdd3f819b0a9@embeddedor.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <4f2a486c-c6de-43e4-8bb6-bdd3f819b0a9@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NBTLP5sNQY8IOwWyfKdHtu993kgLMr8X
X-Proofpoint-GUID: NBTLP5sNQY8IOwWyfKdHtu993kgLMr8X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_15,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=571 phishscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311270113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/2023 8:23 AM, Gustavo A. R. Silva wrote:
> 
> 
> On 11/27/23 10:14, Jeff Johnson wrote:
>> Transform the zero-length array in ath11k_htc_record into a proper
>> flexible array via the DECLARE_FLEX_ARRAY() macro. This helps with
>> ongoing efforts to globally enable -Warray-bounds.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath11k/htc.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/htc.h b/drivers/net/wireless/ath/ath11k/htc.h
>> index 84971cc9251c..e0434b29df70 100644
>> --- a/drivers/net/wireless/ath/ath11k/htc.h
>> +++ b/drivers/net/wireless/ath/ath11k/htc.h
>> @@ -151,7 +151,7 @@ struct ath11k_htc_credit_report {
>>   struct ath11k_htc_record {
>>   	struct ath11k_htc_record_hdr hdr;
>>   	union {
>> -		struct ath11k_htc_credit_report credit_report[0];
>> +		DECLARE_FLEX_ARRAY(struct ath11k_htc_credit_report, credit_report);
>>   	};
> 
> Why not removing the `union` and just do a direct transformation [0] -> [ ] ?

No reason other than staying consistent with ath10k.
Will see if Kalle has an opinion on this.

/jeff
