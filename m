Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1217D5E9C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 01:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344591AbjJXXTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 19:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344466AbjJXXTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 19:19:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80A110C6;
        Tue, 24 Oct 2023 16:19:45 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OMsdIW006452;
        Tue, 24 Oct 2023 23:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GEhGl3jIF7tnr2aO8luYKeblxM/VbrTylqhHINAwWI4=;
 b=bFAgwGaBICGObjV6aDwtMi+VHoV0YRQlHsy/sjEkziy0ZUJAvZVkQDFMBXhbVwGVp02o
 6tXwhQRN6lXQkfZc2n8fsvc3PJF7p7//97ZWya9ZtX0IeCGf/cN4VaARPJndd1QyXz+O
 OiTYF7xpq3Nf0PSSVsRO3KbU9sJx2uHBCQUXmSkZoPh6vxcChDDwmz7nmLd1reUsk3N/
 i9NGVtUfY/zQLBpgOOZ2Ie142AnK5p7hO2KI4m/DDgAhrRHAaB3SvjPqDhE3hbLBk4kF
 JI/xNlV7/2BJMAFV2mZrHQd+6VswtOAm6pzk/F3G6sPU71TkvEbBkEKT+y+swyqxm2XT Hw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tx43hanku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 23:19:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39ONJVI2002808
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 23:19:31 GMT
Received: from [10.48.243.236] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 24 Oct
 2023 16:19:30 -0700
Message-ID: <b85a4e54-61c7-45fe-b97d-46338b237a64@quicinc.com>
Date:   Tue, 24 Oct 2023 16:19:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath10k: replace deprecated strncpy with memcpy
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>
CC:     Kalle Valo <kvalo@kernel.org>, <ath10k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>
References: <20231024-strncpy-drivers-net-wireless-ath-ath10k-mac-c-v2-1-4c1f4cd4b4df@google.com>
 <202310241428.0AA7B80@keescook>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <202310241428.0AA7B80@keescook>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EQ8VpvQKgvrSn9MAgciz5iwhaJypNltA
X-Proofpoint-ORIG-GUID: EQ8VpvQKgvrSn9MAgciz5iwhaJypNltA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_22,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 adultscore=0 mlxlogscore=734
 lowpriorityscore=0 phishscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310240200
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/2023 2:34 PM, Kees Cook wrote:
> On Tue, Oct 24, 2023 at 05:42:16PM +0000, Justin Stitt wrote:
>> strncpy() is deprecated [1] and we should prefer less ambiguous
>> interfaces.
>>
>> In this case, arvif->u.ap.ssid has its length maintained by
>> arvif->u.ap.ssid_len which indicates it may not need to be
>> NUL-terminated. Make this explicit with __nonstring and use a plain old
>> memcpy.
>>
>> This is also consistent with future copies into arvif->u.ap.ssid:
>>
>> 	if (changed & BSS_CHANGED_SSID &&
>> 	    vif->type == NL80211_IFTYPE_AP) {
>> 		arvif->u.ap.ssid_len = vif->cfg.ssid_len;
>> 		if (vif->cfg.ssid_len)
>> 			memcpy(arvif->u.ap.ssid, vif->cfg.ssid,
>> 			       vif->cfg.ssid_len);
>> 		arvif->u.ap.hidden_ssid = info->hidden_ssid;
>> 	}
>>
>> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
>> Link: https://github.com/KSPP/linux/issues/90
>> Cc: linux-hardening@vger.kernel.org
>> Signed-off-by: Justin Stitt <justinstitt@google.com>
>> ---
>> Changes in v2:
>> - update subject to include wifi
>> - prefer memcpy() over strtomem() (thanks Kalle, Jeff)
>> - rebase onto 6.6-rc7 @d88520ad73b79e71
>> - Link to v1: https://lore.kernel.org/r/20231013-strncpy-drivers-net-wireless-ath-ath10k-mac-c-v1-1-24e40201afa3@google.com
>> ---
>> Note: build-tested only.
>>
>> Found with: $ rg "strncpy\("
>> ---
>>   drivers/net/wireless/ath/ath10k/core.h | 2 +-
>>   drivers/net/wireless/ath/ath10k/mac.c  | 3 +--
>>   2 files changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
>> index 4b5239de4018..ba9795a8378a 100644
>> --- a/drivers/net/wireless/ath/ath10k/core.h
>> +++ b/drivers/net/wireless/ath/ath10k/core.h
>> @@ -607,7 +607,7 @@ struct ath10k_vif {
>>   			u8 tim_bitmap[64];
>>   			u8 tim_len;
>>   			u32 ssid_len;
>> -			u8 ssid[IEEE80211_MAX_SSID_LEN];
>> +			u8 ssid[IEEE80211_MAX_SSID_LEN] __nonstring;
>>   			bool hidden_ssid;
>>   			/* P2P_IE with NoA attribute for P2P_GO case */
>>   			u32 noa_len;
>> diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
>> index 03e7bc5b6c0b..f3f6deb354c6 100644
>> --- a/drivers/net/wireless/ath/ath10k/mac.c
>> +++ b/drivers/net/wireless/ath/ath10k/mac.c
>> @@ -6125,9 +6125,8 @@ static void ath10k_bss_info_changed(struct ieee80211_hw *hw,
>>   
>>   		if (ieee80211_vif_is_mesh(vif)) {
>>   			/* mesh doesn't use SSID but firmware needs it */
>> -			strncpy(arvif->u.ap.ssid, "mesh",
>> -				sizeof(arvif->u.ap.ssid));
>>   			arvif->u.ap.ssid_len = 4;
>> +			memcpy(arvif->u.ap.ssid, "mesh", arvif->u.ap.ssid_len);
> 
> This is a behavior change, isn't it? i.e. arvif->u.ap.ssid is no longer
> zero-padded. Is this actually ok for the driver?

yes, it is safe, and consistent with other uses of this field as noted 
in the commit description.

