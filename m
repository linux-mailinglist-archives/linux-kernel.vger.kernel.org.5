Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2955B7A5BCA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjISH6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjISH6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:58:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC08114
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 00:58:32 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38J6SBqR025501;
        Tue, 19 Sep 2023 07:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=QOE5YurvJsknE+ouPLqzdWgzjo3CKbr3HdNmb4Jt2tA=;
 b=R+SZilUm6koSSfDeZU8mPszoHNn66SAb5Y+csSm8DhIsjHVlK0bCXduu7clHeZ12cr6M
 HvhM75DML0D9C/AL1XgyCl9RnbTVSWMtLbx1SLjTjZJJQEBQTuljzCamHJW17ig0sOI2
 jO1uwAHYORHXwLngETumweGCCN/8sFWCOM2Mc7Dc5bfGcAZGHp20d+EVCk53Lx5bSByM
 +ymtoEqBwd3MTDVkV2ryc807+N9Wv+/U2tdkiBU7PiQZna7mgy8vel5YA7do/Dnrte8t
 DS1mmiWipLWEYio1/7p0v9fjxorN5wYLGX9HhoMxsTcoP5OwGAm0YaBdB5nn7zESw0zQ kQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t6nh7a73x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 07:58:25 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38J7wOPQ006649
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 07:58:24 GMT
Received: from [10.216.24.136] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 19 Sep
 2023 00:58:19 -0700
Message-ID: <5f4255d1-51e9-8888-c32d-723a6a7afb5d@quicinc.com>
Date:   Tue, 19 Sep 2023 13:27:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] firmware_loader: Add reboot_in_progress for user helper
 path
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <mcgrof@kernel.org>, <russell.h.weight@intel.com>,
        <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
References: <1694773288-15755-1-git-send-email-quic_mojha@quicinc.com>
 <2023091727-clever-schilling-3814@gregkh>
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <2023091727-clever-schilling-3814@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: atdbQ2jCl3cO2QUahH68D2cX-LIQuXRL
X-Proofpoint-GUID: atdbQ2jCl3cO2QUahH68D2cX-LIQuXRL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_02,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190065
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/17/2023 3:42 PM, Greg KH wrote:
> On Fri, Sep 15, 2023 at 03:51:28PM +0530, Mukesh Ojha wrote:
>> There could be following scenario where there is a ongoing reboot
>> is going from processA which tries to call all the reboot notifier
>> callback and one of them is firmware reboot call which tries to
>> abort all the ongoing firmware userspace request under fw_lock
>> but there could be another processB which tries to do request
>> firmware, which came just after abort done from ProcessA and
>> ask for userspace to load the firmware and this can stop the
>> ongoing reboot ProcessA to stall for next 60s(default timeout)
>> which may be expected behaviour everyone like to see, instead
>> we should abort every request which came after once firmware
>> marks reboot notification.
>>
>>        ProcessA                             ProcessB
>>
>> kernel_restart_prepare
>>    blocking_notifier_call_chain
>>     fw_shutdown_notify
>>       kill_pending_fw_fallback_reqs
>>        __fw_load_abort
>>         fw_state_aborted	              request_firmware
>>           __fw_state_set                   firmware_fallback_sysfs
>> ...                                        fw_load_from_user_helper
>> ..                                         ...
>> .                                          ..
>>                                              usermodehelper_read_trylock
>>                                               fw_load_sysfs_fallback
>>                                                fw_sysfs_wait_timeout
>> usermodehelper_disable
>>   __usermodehelper_disable
>>    down_write()
>>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
>>   drivers/base/firmware_loader/fallback.c | 2 +-
>>   drivers/base/firmware_loader/firmware.h | 1 +
>>   drivers/base/firmware_loader/main.c     | 2 ++
>>   3 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
>> index bf68e3947814..a5546aeea91f 100644
>> --- a/drivers/base/firmware_loader/fallback.c
>> +++ b/drivers/base/firmware_loader/fallback.c
>> @@ -86,7 +86,7 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
>>   	}
>>   
>>   	mutex_lock(&fw_lock);
>> -	if (fw_state_is_aborted(fw_priv)) {
>> +	if (reboot_in_progress || fw_state_is_aborted(fw_priv)) {
>>   		mutex_unlock(&fw_lock);
>>   		retval = -EINTR;
>>   		goto out;
> 
> What prevents reboot_in_progress to change right after you check it
> here?

e.g, reboot_in_progress was false, it gets added to the pending list
under fw_lock

  list_add(&fw_priv->pending_list, &pending_fw_head);

reboot_in_progress = true, when all the outstanding fw request
are aborted during from reboot thread from below path. However,
I realize my mistake, reboot_in_progress should be modified
under fw_lock, will fix in v2.

 >>     fw_shutdown_notify
 >>       kill_pending_fw_fallback_reqs

So, idea is to revoke any fw request once firmware knows about ongoing
reboot and not delay the reboot process further for next default
60s .

> 
> And what kernel driver is trying to call the reboot notifier that gets
> mixed up in this?  Why not fix that driver to not need the reboot
> notifier at all (hint, I really doubt it needs it...)

'drivers/base/firmware_loader/main.c' has reboot notifier which aborts
the ongoing firmware requests and but can race with other parallel
ongoing request which are not yet added to pending list.

fw_load_sysfs_fallback-> stuck waiting for fw_lock which was held by

kill_pending_fw_fallback_reqs=>
mutex_lock(&fw_lock);
  __fw_load_abort


> 
>> --- a/drivers/base/firmware_loader/main.c
>> +++ b/drivers/base/firmware_loader/main.c
>> @@ -93,6 +93,7 @@ static inline struct fw_priv *to_fw_priv(struct kref *ref)
>>   DEFINE_MUTEX(fw_lock);
>>   
>>   struct firmware_cache fw_cache;
>> +bool reboot_in_progress;
> 
> Bad global name for a variable in the firmware_loader core.

bool abort_fw_load_req ??

-Mukesh
> 
> thanks,
> 
> greg k-h
