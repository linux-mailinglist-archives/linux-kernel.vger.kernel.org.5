Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A749F7EC389
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343931AbjKONZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343875AbjKONZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:25:19 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4213E11D;
        Wed, 15 Nov 2023 05:25:15 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFCxRIs027137;
        Wed, 15 Nov 2023 13:25:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Ep17p8qH6F6KkffFv9Z3mN3YA+GK8sGjihGtKNLJ36Y=;
 b=ofqHiSMxoB4SA4sLtFl3qFo8XG0vGvQFJWx0ncHgYsow6Vs4I40FOeggkCv5zJ+ENZSj
 K0pO3bvHpm6x7TehFxBkkHCQCP+R8qzbnBXtxccofxOYBm/lceg/tEB8BjC5DMuD0R7e
 lGR1WQ/RLL/M6HGc5B2XKNuYvm72eu8Vu2v5x6TNFJnU7ucuORfGGzcu7ZTWyonQmI6q
 ZKFdfXB3QQk9KPtq8KPbtt4Jv7GD5fEYV8yhhfNZjKjxjtBHs7gair58yNG3oTXchh94
 pa9rR49fq005rNH/qTFDzmDJPDWc7z9yY7uWlCwz1vJpEtmOPhjM43BAbokkpQ7PFmk1 6A== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucanq2u5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 13:25:05 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AFDP4te030156
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 13:25:04 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 15 Nov
 2023 05:25:02 -0800
Message-ID: <fc71856a-4d67-1893-9f30-54f9e62aadeb@quicinc.com>
Date:   Wed, 15 Nov 2023 18:54:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBQZXJmb3JtYW5jZTogZGV2ZnJlcTog?=
 =?UTF-8?Q?avoid_devfreq_delay_work_re-init_before?=
Content-Language: en-US
To:     =?UTF-8?B?6buE5YaN5ry+KEpveXlvdW5nIEh1YW5nKQ==?= 
        <huangzaiyang@oppo.com>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        huangzaiyang <joyyoung.wang@gmail.com>
References: <20231110093457.458-1-huangzaiyang@oppo.com>
 <fe8f6f37-2534-6481-cc34-e561b3b7a510@quicinc.com>
 <SEYPR02MB5653E9452D4BC57B10384D54A3B2A@SEYPR02MB5653.apcprd02.prod.outlook.com>
 <SEYPR02MB5653EC6FA16817D2DF7022EAA3B1A@SEYPR02MB5653.apcprd02.prod.outlook.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <SEYPR02MB5653EC6FA16817D2DF7022EAA3B1A@SEYPR02MB5653.apcprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XZYymHyF_jSRIZPL2ENfXpvL5QDETHV1
X-Proofpoint-ORIG-GUID: XZYymHyF_jSRIZPL2ENfXpvL5QDETHV1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_12,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150103
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/2023 5:25 PM, 黄再漾(Joyyoung Huang) wrote:
> Hi Mukesh
> I try the below patch on my side，issue still happened ；but I am working on kernel 5.10.
> https://lore.kernel.org/all/1699957648-31299-1-git-send-email-quic_mojha@quicinc.com/
> 
> I will try to debug the patch on my side , I will update you when there is new progress.

There still seems to be problem with the patch [1], work is queued to 
some cpu but not executing where there can be parallel call can come for 
devfreq_monitor_start() and that is not being checked and same can come
during cancel_delayed_work_sync() call. We can protect the same with 
below patch applied on top of the patch given on [1].

[1]
https://lore.kernel.org/all/1699957648-31299-1-git-send-email-quic_mojha@quicinc.com/

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 09b93104521b..a25c74fc31d7 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -488,6 +488,9 @@ void devfreq_monitor_start(struct devfreq *devfreq)
                 return;

         mutex_lock(&devfreq->lock);
+       if (delayed_work_pending(&devfreq->work))
+               goto out;
+
         switch (devfreq->profile->timer) {
         case DEVFREQ_TIMER_DEFERRABLE:
                 INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
@@ -503,8 +506,8 @@ void devfreq_monitor_start(struct devfreq *devfreq)
                 queue_delayed_work(devfreq_wq, &devfreq->work,
                         msecs_to_jiffies(devfreq->profile->polling_ms));

-       devfreq->stop_polling = false;
  out:
+       devfreq->stop_polling = false;
         mutex_unlock(&devfreq->lock);
  }
  EXPORT_SYMBOL(devfreq_monitor_start);
@@ -529,8 +532,8 @@ void devfreq_monitor_stop(struct devfreq *devfreq)
         }

         devfreq->stop_polling = true;
-       mutex_unlock(&devfreq->lock);
         cancel_delayed_work_sync(&devfreq->work);
+       mutex_unlock(&devfreq->lock);

-Mukesh
> 
> 
> -----邮件原件-----
> 发件人: 黄再漾(Joyyoung Huang)
> 发送时间: 2023年11月14日 21:37
> 收件人: Mukesh Ojha <quic_mojha@quicinc.com>; myungjoo.ham@samsung.com; kyungmin.park@samsung.com; cw00.choi@samsung.com
> 抄送: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; huangzaiyang <joyyoung.wang@gmail.com>
> 主题: 回复: [PATCH] Performance: devfreq: avoid devfreq delay work re-init before
> 
> 
> On 11/10/2023 3:04 PM, huangzaiyang wrote:
>> From: huangzaiyang <joyyoung.wang@gmail.com>
>>
>> There is a timer_list race condition when executing the following test shell script:
>> '''
>> while true
>> do
>>           echo "simple_ondemand" > /sys/class/devfreq/1d84000.ufshc/governor
>>           echo "performance" >
>> /sys/class/devfreq/1d84000.ufshc/governor
>> done
>> '''
>>
>> [13511.214366][    C3] Unable to handle kernel paging request at virtual address dead00000000012a
>> [13511.214393][    C3] Mem abort info:
>> [13511.214398][    C3]   ESR = 0x96000044
>> [13511.214404][    C3]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [13511.214409][    C3]   SET = 0, FnV = 0
>> [13511.214414][    C3]   EA = 0, S1PTW = 0
>> [13511.214417][    C3] Data abort info:
>> [13511.214422][    C3]   ISV = 0, ISS = 0x00000044
>> [13511.214427][    C3]   CM = 0, WnR = 1
>> [13511.214432][    C3] [dead00000000012a] address between user and kernel address ranges
>> [13511.214439][    C3] Internal error: Oops: 96000044 [#1] PREEMPT SMP
>> [13511.215449][    C3] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G S      W  O      5.10.168-android12-9-o-g63cc297a7b34 #1
>> [13511.215454][    C3] Hardware name: Qualcomm Technologies, Inc. Cape MTP, Whiteswan (DT)
>> [13511.215460][    C3] pstate: 82400085 (Nzcv daIf +PAN -UAO +TCO BTYPE=--)
>> [13511.215472][    C3] pc : expire_timers+0x9c/0x428
>> [13511.215478][    C3] lr : __run_timers+0x1f0/0x328
>> [13511.215483][    C3] sp : ffffffc00801bdd0
>> [13511.215487][    C3] x29: ffffffc00801bdf0 x28: ffffffdb87b31698
>> [13511.215493][    C3] x27: ffffffdb87999e58 x26: ffffffdb87966008
>> [13511.215499][    C3] x25: 0000000000000001 x24: ffffff8001734a00
>> [13511.215506][    C3] x23: 00000000000000e0 x22: dead000000000122
>> [13511.215512][    C3] x21: 000000010032658e x20: ffffff89f7a9ae80
>> [13511.215518][    C3] x19: ffffffc00801be50 x18: ffffffc00801d038
>> [13511.215525][    C3] x17: 0000000000000240 x16: 0000000000000201
>> [13511.215532][    C3] x15: ffffffffffffffff x14: ffffff89f7a9aef8
>> [13511.215538][    C3] x13: 0000000000000240 x12: ffffff89f7a9aea8
>> [13511.215544][    C3] x11: 0000000000000021 x10: 000000014032658e
>> [13511.215550][    C3] x9 : ffffffc00801be50 x8 : dead000000000122
>> [13511.215556][    C3] x7 : ffff71646c68735e x6 : ffffff89f7aaae58
>> [13511.215563][    C3] x5 : 0000000000000000 x4 : 0000000000000101
>> [13511.215569][    C3] x3 : ffffff89f7a9aef0 x2 : ffffff89f7a9aef0
>> [13511.215575][    C3] x1 : ffffffc00801be50 x0 : ffffff8045804428
>> [13511.215581][    C3] Call trace:
>> [13511.215586][    C3]  expire_timers+0x9c/0x428
>> [13511.215591][    C3]  __run_timers+0x1f0/0x328
>> [13511.215596][    C3]  run_timer_softirq+0x28/0x58
>> [13511.215602][    C3]  efi_header_end+0x168/0x5ec
>> [13511.215610][    C3]  __irq_exit_rcu+0x108/0x124
>> [13511.215617][    C3]  __handle_domain_irq+0x118/0x1e4
>> [13511.215625][    C3]  gic_handle_irq.31230+0x6c/0x250
>> [13511.215630][    C3]  el1_irq+0xe4/0x1c0
>> [13511.215638][    C3]  cpuidle_enter_state+0x3a4/0xa04
>> [13511.215644][    C3]  do_idle+0x308/0x574
>> [13511.215649][    C3]  cpu_startup_entry+0x84/0x90
>> [13511.215656][    C3]  secondary_start_kernel+0x204/0x274
>> [13511.215664][    C3] Code: d503201f a9402408 f9000128 b4000048 (f9000509)
>> [13511.215670][    C3] ---[ end trace 5100bad72a35d566 ]---
>> [13511.215676][    C3] Kernel panic - not syncing: Oops: Fatal exception in interrupt
>>
>> This is because when switching the governor through the sys node, the
>> devfreq_monitor_start function will re-initialize the delayed work
>> task, which will cause the delay work pending flag to become invalid,
>> and the timer pending judgment contained in the delayed work will also become invalid, and then the pending interception will be executed when the queue is executed.
>>
>> So we remove the delay work'initialization work to the
>> devfreq_add_device and timer_store functions, and the delay work pending judgment is performed before the devfreq_monitor_start function performs the queue operation.
>>
>> Signed-off-by: ZaiYang Huang <huangzaiyang@oppo.com>
>> ---
>>    drivers/devfreq/devfreq.c | 36 ++++++++++++++++++++++++------------
>>    1 file changed, 24 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index b3a68d5833bd..8ae6f853a21e 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -483,18 +483,7 @@ void devfreq_monitor_start(struct devfreq *devfreq)
>>           if (IS_SUPPORTED_FLAG(devfreq->governor->flags, IRQ_DRIVEN))
>>                   return;
>>
>> -       switch (devfreq->profile->timer) {
>> -       case DEVFREQ_TIMER_DEFERRABLE:
>> -               INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
>> -               break;
>> -       case DEVFREQ_TIMER_DELAYED:
>> -               INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
>> -               break;
>> -       default:
>> -               return;
>> -       }
>> -
>> -       if (devfreq->profile->polling_ms)
>> +       if (devfreq->profile->polling_ms &&
>> + !delayed_work_pending(&devfreq->work))
>>                   queue_delayed_work(devfreq_wq, &devfreq->work,
>>                           msecs_to_jiffies(devfreq->profile->polling_ms));
>>    }
>> @@ -830,6 +819,17 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>                   goto err_dev;
>>           }
>>
>> +       switch (devfreq->profile->timer) {
>> +       case DEVFREQ_TIMER_DEFERRABLE:
>> +               INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
>> +               break;
>> +       case DEVFREQ_TIMER_DELAYED:
>> +               INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
>> +               break;
>> +       default:
>> +               dev_err(dev, "%s: Target devfreq(%s)'s profile timer has no settings \n", devfreq->governor_name,
>> +                       __func__);
>> +       }
> 
> [..]
> 
>>           if (!devfreq->profile->max_state || !devfreq->profile->freq_table) {
>>                   mutex_unlock(&devfreq->lock);
>>                   err = set_freq_table(devfreq); @@ -1860,6 +1860,18 @@
>> static ssize_t timer_store(struct device *dev, struct device_attribute *attr,
>>           df->profile->timer = timer;
>>           mutex_unlock(&df->lock);
>>
>> +       switch (df->profile->timer) {
>> +       case DEVFREQ_TIMER_DEFERRABLE:
>> +               INIT_DEFERRABLE_WORK(&df->work, devfreq_monitor);
>> +               break;
>> +       case DEVFREQ_TIMER_DELAYED:
>> +               INIT_DELAYED_WORK(&df->work, devfreq_monitor);
>> +               break;
>> +       default:
>> +               dev_err(dev, "%s: Target devfreq(%s)'s profile timer has no settings \n", df->governor_name,
>> +                       __func__);
>> +       }
>> +
> Here, this can cause issue right, as it is modifying the delayed work data even before stopping the current running instances..
> 
> Should the above thing be done after DEVFREQ_GOV_STOP ?
> But again it will boil down to the same thing as it is currently now .
>>           ret = df->governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
>>           if (ret) {
>>                   dev_warn(dev, "%s: Governor %s not stopped(%d)\n",
> -->agree, seems better to put these codes after after DEVFREQ_GOV_STOP, as follow?
> @@ -1856,10 +1856,6 @@ static ssize_t timer_store(struct device *dev, struct device_attribute *attr,
>   		goto out;
>   	}
>   
> -	mutex_lock(&df->lock);
> -	df->profile->timer = timer;
> -	mutex_unlock(&df->lock);
> -
>   	ret = df->governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
>   	if (ret) {
>   		dev_warn(dev, "%s: Governor %s not stopped(%d)\n", @@ -1867,6 +1863,21 @@ static ssize_t timer_store(struct device *dev, struct device_attribute *attr,
>   		goto out;
>   	}
>   
> +	mutex_lock(&df->lock);
> +	df->profile->timer = timer;
> +	switch (df->profile->timer) {
> +	case DEVFREQ_TIMER_DEFERRABLE:
> +		INIT_DEFERRABLE_WORK(&df->work, devfreq_monitor);
> +		break;
> +	case DEVFREQ_TIMER_DELAYED:
> +		INIT_DELAYED_WORK(&df->work, devfreq_monitor);
> +		break;
> +	default:
> +		dev_err(dev, "%s: Target devfreq(%s)'s profile timer has no settings \n", df->governor_name,
> +			__func__);
> +       mutex_unlock(&df->lock);
> +       goto out;
> +	}
> +	mutex_unlock(&df->lock);
> +
>   	ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
>   	if (ret)
>   		dev_warn(dev, "%s: Governor %s not started(%d)\n",
