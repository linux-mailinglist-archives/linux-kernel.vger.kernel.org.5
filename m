Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE13F7CB034
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 18:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbjJPQtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 12:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbjJPQtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 12:49:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157A42128;
        Mon, 16 Oct 2023 09:41:33 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GGX4xj002792;
        Mon, 16 Oct 2023 16:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=iUkNAEhmQcRALEI8TK0LzZjyN4+TVeYxiZy0KPk2Wh0=;
 b=H8xjBa8gHPauBSHWpWfvEIU01ujnLO3WL4xP5uAL6ijCyPDbcv2YOz4I/uC5q7b5uNEW
 /6Y7mWkblfrIDEolYQZWspyysgirYHx2kAncWwE/o41NcfLtCUhu0mxzdl9YbUMHPr4+
 ak9kOEdxyNKXyITjJPtLjvPFK5Kf5d0rNLu7d8zpRlPUsENIKyjgXT9LOYYOfxBh6JPq
 aLBjkuyfK3oCjUaKFhfTw72NHmlAtbN5CWV3GeTY2f1kMaEGz8021AFEAqycc/HVJ2tm
 oWPs5myX5ocj9VkpNJg+wlClOmrAa70KoWSTY1XwXNQP963bwoRTp7Y+gK2wW9fB9kZF uQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tqm9f4mmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Oct 2023 16:41:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39GGfJP2030527
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Oct 2023 16:41:19 GMT
Received: from [10.48.240.22] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 16 Oct
 2023 09:41:18 -0700
Message-ID: <cabb874c-7518-4565-a007-f466f1b69165@quicinc.com>
Date:   Mon, 16 Oct 2023 09:41:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ath10k: mac: enable
 WIPHY_FLAG_CHANNEL_CHANGE_ON_BEACON on ath10k
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, Abhishek Kumar <kuabhs@chromium.org>
CC:     <johannes.berg@intel.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <ath10k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <20230629035254.2.I23c5e51afcc6173299bb2806c8c38364ad15dd63@changeid>
 <169634426707.121370.9448850980134728319.kvalo@kernel.org>
 <87il793hmi.fsf@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <87il793hmi.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: j9hu2thAUudPAJfKw7Dq_SsN7Z2POx0C
X-Proofpoint-ORIG-GUID: j9hu2thAUudPAJfKw7Dq_SsN7Z2POx0C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_10,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 bulkscore=0 mlxlogscore=738
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310160145
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/2023 10:20 PM, Kalle Valo wrote:
> Kalle Valo <kvalo@kernel.org> writes:
> 
>> Abhishek Kumar <kuabhs@chromium.org> wrote:
>>
>>> Enabling this flag, ensures that reg_call_notifier is called
>>> on beacon hints from handle_reg_beacon in cfg80211. This call
>>> propagates the channel property changes to ath10k driver, thus
>>> changing the channel property from passive scan to active scan
>>> based on beacon hints.
>>> Once the channels are rightly changed from passive to active,the
>>> connection to hidden SSID does not fail.
>>>
>>> Signed-off-by: Abhishek Kumar <kuabhs@chromium.org>
>>
>> There's no Tested-on tag, on which hardware/firmware did you test this?
>>
>> This flag is now enabled on ALL ath10k supported hardware: SNOC, PCI, SDIO and
>> maybe soon USB. I'm just wondering can we trust that this doesn't break
>> anything.
> 
> Jeff, what are your thoughts on this? I'm worried how different ath10k
> firmwares can be and if this breaks something.
> 

Since the 1/2 patch is already in pull-request: wireless-next-2023-10-06 
I went through the logic of that again. It would have been nice if that 
actually described how it fixes the problem. What actually causes a 
channel to change from passive to active?

Note the existing logic prior to the 1/2 patch already updates the wiphy 
and userspace with the updated channel flags, so it seems reasonable to 
also update the driver

However, this led me down the rabbit hole of trying to figure out what 
happens if a beacon hint causes us to change a channel from passive to 
active, but then that AP goes away. What, if anything, causes the 
channel to revert back to passive? I'm not immediately seeing that logic 
anywhere.

My concern is that we have an AP with a hidden SSID on a DFS channel, 
and as a result of a beacon hint we switch that channel to active scan. 
But then later that AP detects radar and vacates the channel. Then we 
potentially have stations doing active scan on a DFS channel with an 
active radar.

Hopefully this is all handled, and it just isn't obvious in my 
admittedly very quick 10 minute scan of the code.

And as far as the 2/2 patch, note this logic is all dependent upon 
reg_is_world_roaming(wiphy) returning true, so ath10k impact would 
really depend upon the board regulatory settings, whether configured for 
a fixed regulatory domain/country code or configured for world roaming.

/jeff


