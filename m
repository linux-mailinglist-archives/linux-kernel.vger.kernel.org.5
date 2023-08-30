Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3360A78E134
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240776AbjH3VLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240686AbjH3VLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:11:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD67CC;
        Wed, 30 Aug 2023 14:10:35 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UKIfLf016672;
        Wed, 30 Aug 2023 20:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/ccv1mYRsDGc54g1JHIaLOdjf2JwL4EK5wa6WQFkEAI=;
 b=QgUvjSkkSxc0xL7BYc16d+YRhqxKeJ8fnWnfinPMfuP+EWyzAtrPFMB2rP4g30JydCac
 oSd+RAJxPSdHK/L2PY6ChX0WJS/tqQMYTk6t+RdvFP8k6awWD/XDmCJigJe1j7Pgemre
 +LrF/yGZMHYw9ZuGfD3U3lGL5MyGv5UYa9mAk4yfFYnk/1J8kofGJnwzD/biV+u1EFRV
 r60oQeG863FpgWxezMsq0rMoj5UsRrUpFtNXSxjxP9mHXNs1JzItqhD7ju8g+8gjEEPi
 U9/gZREfIqis6J4F+2LdHCkGLB8r2rqzJHbR7QpcTzB7Hbr4SLwdDUGNbXg1ZbtDQBK0 VA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ssy5q1kr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 20:24:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37UKOQDm007314
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 20:24:26 GMT
Received: from [10.111.178.80] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 30 Aug
 2023 13:22:46 -0700
Message-ID: <9da7f41e-6d4a-452a-8042-0b09cad71bb8@quicinc.com>
Date:   Wed, 30 Aug 2023 13:22:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mac80211: Use flexible array in struct
 ieee80211_tim_ie
Content-Language: en-US
To:     Christian Lamparter <chunkeey@gmail.com>, <kernel@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>,
        =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Christian Lamparter <chunkeey@googlemail.com>,
        "Stanislaw Gruszka" <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        "Ping-Ke Shih" <pkshih@realtek.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kees Cook <keescook@chromium.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
References: <20230829-ieee80211_tim_ie-v2-0-fdaf19fb1c0e@quicinc.com>
 <20230829-ieee80211_tim_ie-v2-2-fdaf19fb1c0e@quicinc.com>
 <1774098a-5062-4f12-a760-f16036d095e3@gmail.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <1774098a-5062-4f12-a760-f16036d095e3@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1G_R_wCDKZ633AYsiVqaqHxd1GurX91f
X-Proofpoint-GUID: 1G_R_wCDKZ633AYsiVqaqHxd1GurX91f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 clxscore=1011 adultscore=0 lowpriorityscore=0 mlxlogscore=955 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300184
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/2023 12:51 PM, Christian Lamparter wrote:
> Hi,
> 
> On 8/29/23 15:29, Jeff Johnson wrote:
>> Currently struct ieee80211_tim_ie defines:
>>     u8 virtual_map[1];
>>
>> Per the guidance in [1] change this to be a flexible array.
>>
>> As a result of this change, adjust all related struct size tests to
>> account for the fact that the sizeof(struct ieee80211_tim_ie) now
>> accounts for the minimum size of the virtual_map.
>>
>> [1] 
>> https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> ---
>> diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
>> index bd2f6e19c357..4cdc2eb98f16 100644
>> --- a/include/linux/ieee80211.h
>> +++ b/include/linux/ieee80211.h
>> @@ -961,7 +961,7 @@ struct ieee80211_tim_ie {
>>       u8 dtim_period;
>>       u8 bitmap_ctrl;
>>       /* variable size: 1 - 251 bytes */
>> -    u8 virtual_map[1];
>> +    u8 virtual_map[];
>>   } __packed;
> 
> 
> Uhh, the 802.11 (my 2012 Version has this in) spec in
> 8.4.2.7 TIM Element demands this to be 1 - 251 bytes.
> And this is why there's a comment above... With your
> change this could be confusing. Would it be possible
> to fix that somehow? Like in a anonymous union/group
> with a flexible array and a u8?

Adding Kees to the discussion for any advice. Yes, the virtual_map must 
contain at least one octet but may contain more than one. And to 
complicate matters, the information that tells us how many octets are 
actually present is found outside the struct; the TLV header that 
precedes the struct will contain the length of the struct, and hence the 
length of the bitmap is that size - 2 (the size of the dtim_period and 
bitmap_ctrl fields).

I don't think it is unique to this struct that an 802.11 element will 
have optional octets for which one or more octets must always be 
present. For that reason I've been updating ieee80211.h kdoc to point to 
the latest specification since that ultimately provides the necessary 
guidance.

/jeff

