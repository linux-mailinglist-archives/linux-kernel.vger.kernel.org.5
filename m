Return-Path: <linux-kernel+bounces-72391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1795485B2BF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ACA11F24B64
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39A85820D;
	Tue, 20 Feb 2024 06:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TMAm/7KN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BCA57877;
	Tue, 20 Feb 2024 06:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708409604; cv=none; b=STTU9j48lUXSJHtI9mv2TwWLU6hYMkcvjBmd2i/E3rMMCFbY3AemgqVLqOfWniBcnrwq5Y7exTRmcz76Clvk9xzsQxexNngDPDjZHfnqeHLqYLrN/yijkBKFRn5CPoxjdLZkrlE5rZD6GsC+cp70CEA4hFEBhMMHbJFpiD1bdpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708409604; c=relaxed/simple;
	bh=bVvP4nUoFxGKAU87ioUGH9WYX+2u+K4yKOSpAZp4stI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QYS2APxz9u7aCErY+IzCouaj6cwgk2B/JHoMlJVwTBlqVsz+ozJuAWfzHp8sYWjrby59wSPjeTXAIAaG+qiigHOb5npALukDL8W7FyxciokVDEJ3VON1Qmx7xua4ZH6SqIDCPAnUuNIuVH5siuqZKuPFtBrt8RIjAgM/PFrouuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TMAm/7KN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41K3bEkH007697;
	Tue, 20 Feb 2024 06:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+K8wihPyJh/1HH1qwBrcS0bEcm0ngNnzBWoX2h74ycQ=; b=TM
	Am/7KNO6WtphHBH+kf8HfS4f3eQhxcB3s+160806Ofba4EGhC1CwVXtI3PDCNLYR
	CJS785HIpjs00n5qOvyL5E7E5RpNwEZbWUEsEKXdI9iYqzmE9D7jaenRzeN3TyGZ
	utfUOaKkN/or7ltIMog0+hM8Iz3Yfqn3t5AzpAho56pPLWj9HRqVW9ChxQWn58MG
	LjAVwfTS9mmL9J0BziBEQyQSr9lWlk6bU5hDn5IT40ooPS/2NVCfcACgzJXKd/ic
	9mL9gbyMmWs1aqF14rwxLy9vUj5TC8T93QMMPxGg+BenUpvVoG3S2dczeks1Rb9l
	2TOBj7hVeOUGorXPcdgA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wc54b2053-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 06:13:16 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41K6DEh7002541
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 06:13:14 GMT
Received: from [10.239.132.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 19 Feb
 2024 22:13:09 -0800
Message-ID: <400fa03c-bc08-4c32-a1ef-57f227493061@quicinc.com>
Date: Tue, 20 Feb 2024 14:13:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] pinctrl: Add lock to ensure the state atomization
Content-Language: en-US
To: Alexander Stein <alexander.stein@ew.tq-group.com>, <andersson@kernel.org>,
        <linus.walleij@linaro.org>
CC: <kernel@quicinc.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20240202105854.26446-1-quic_aiquny@quicinc.com>
 <8376074.NyiUUSuA9g@steina-w>
From: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
In-Reply-To: <8376074.NyiUUSuA9g@steina-w>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pPL-wpZ0FI_3irS_3sF_oQkGeUAuyUWO
X-Proofpoint-ORIG-GUID: pPL-wpZ0FI_3irS_3sF_oQkGeUAuyUWO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_05,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1011 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402200043



On 2/9/2024 4:37 PM, Alexander Stein wrote:
> Am Freitag, 2. Februar 2024, 11:58:54 CET schrieb Maria Yu:
>> Currently pinctrl_select_state is an export symbol and don't have
>> effective re-entrance protect design. During async probing of devices
>> it's possible to end up in pinctrl_select_state() from multiple
>> contexts simultaneously, so make it thread safe.
>> More over, when the real racy happened, the system frequently have
>> printk message like:
>>    "not freeing pin xx (xxx) as part of deactivating group xxx - it is
>> already used for some other setting".
>> Finally the system crashed after the flood log.
>> Add per pinctrl lock to ensure the old state and new state transition
>> atomization.
>> Also move dev error print message outside the region with interrupts
>> disabled.
>> Use scoped guard to simplify the lock protection needed code.
>>
>> Fixes: 4198a9b57106 ("pinctrl: avoid reload of p state in list iteration")
>> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
>> ---
>>   drivers/pinctrl/core.c | 143 +++++++++++++++++++++--------------------
>>   drivers/pinctrl/core.h |   2 +
>>   2 files changed, 75 insertions(+), 70 deletions(-)
>>
>> diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
>> index ee56856cb80c..1f7d001d4c1e 100644
>> --- a/drivers/pinctrl/core.c
>> +++ b/drivers/pinctrl/core.c
>> @@ -1061,6 +1061,7 @@ static struct pinctrl *create_pinctrl(struct device
>> *dev, p->dev = dev;
>>   	INIT_LIST_HEAD(&p->states);
>>   	INIT_LIST_HEAD(&p->dt_maps);
>> +	spin_lock_init(&p->lock);
>>
>>   	ret = pinctrl_dt_to_map(p, pctldev);
>>   	if (ret < 0) {
>> @@ -1257,93 +1258,95 @@ static void pinctrl_link_add(struct pinctrl_dev
>> *pctldev, static int pinctrl_commit_state(struct pinctrl *p, struct
>> pinctrl_state *state) {
>>   	struct pinctrl_setting *setting, *setting2;
>> -	struct pinctrl_state *old_state = READ_ONCE(p->state);
>> +	struct pinctrl_state *old_state;
>>   	int ret;
>>
>> -	if (old_state) {
>> -		/*
>> -		 * For each pinmux setting in the old state, forget SW's
> record
>> -		 * of mux owner for that pingroup. Any pingroups which are
>> -		 * still owned by the new state will be re-acquired by the
> call
>> -		 * to pinmux_enable_setting() in the loop below.
>> -		 */
>> -		list_for_each_entry(setting, &old_state->settings, node) {
>> -			if (setting->type != PIN_MAP_TYPE_MUX_GROUP)
>> -				continue;
>> -			pinmux_disable_setting(setting);
>> +	scoped_guard(spinlock_irqsave, &p->lock) {
>> +		old_state = p->state;
>> +		if (old_state) {
>> +			/*
>> +			 * For each pinmux setting in the old state,
> forget SW's record
>> +			 * of mux owner for that pingroup. Any pingroups
> which are
>> +			 * still owned by the new state will be re-
> acquired by the call
>> +			 * to pinmux_enable_setting() in the loop below.
>> +			 */
>> +			list_for_each_entry(setting, &old_state-
>> settings, node) {
>> +				if (setting->type !=
> PIN_MAP_TYPE_MUX_GROUP)

>> +					continue;
>> +				pinmux_disable_setting(setting);
>> +			}
>>   		}
>> -	}
>> -
>> -	p->state = NULL;
>>
>> -	/* Apply all the settings for the new state - pinmux first */
>> -	list_for_each_entry(setting, &state->settings, node) {
>> -		switch (setting->type) {
>> -		case PIN_MAP_TYPE_MUX_GROUP:
>> -			ret = pinmux_enable_setting(setting);
>> -			break;
>> -		case PIN_MAP_TYPE_CONFIGS_PIN:
>> -		case PIN_MAP_TYPE_CONFIGS_GROUP:
>> -			ret = 0;
>> -			break;
>> -		default:
>> -			ret = -EINVAL;
>> -			break;
>> -		}
>> +		p->state = NULL;
>>
>> -		if (ret < 0)
>> -			goto unapply_new_state;
>> +		/* Apply all the settings for the new state - pinmux first
> */
>> +		list_for_each_entry(setting, &state->settings, node) {
>> +			switch (setting->type) {
>> +			case PIN_MAP_TYPE_MUX_GROUP:
>> +				ret = pinmux_enable_setting(setting);
>> +				break;
>> +			case PIN_MAP_TYPE_CONFIGS_PIN:
>> +			case PIN_MAP_TYPE_CONFIGS_GROUP:
>> +				ret = 0;
>> +				break;
>> +			default:
>> +				ret = -EINVAL;
>> +				break;
>> +			}
>>
>> -		/* Do not link hogs (circular dependency) */
>> -		if (p != setting->pctldev->p)
>> -			pinctrl_link_add(setting->pctldev, p->dev);
>> -	}
>> +			if (ret < 0)
>> +				goto unapply_new_state;
>>
>> -	/* Apply all the settings for the new state - pinconf after */
>> -	list_for_each_entry(setting, &state->settings, node) {
>> -		switch (setting->type) {
>> -		case PIN_MAP_TYPE_MUX_GROUP:
>> -			ret = 0;
>> -			break;
>> -		case PIN_MAP_TYPE_CONFIGS_PIN:
>> -		case PIN_MAP_TYPE_CONFIGS_GROUP:
>> -			ret = pinconf_apply_setting(setting);
>> -			break;
>> -		default:
>> -			ret = -EINVAL;
>> -			break;
>> +			/* Do not link hogs (circular dependency) */
>> +			if (p != setting->pctldev->p)
>> +				pinctrl_link_add(setting->pctldev, p-
>> dev);
>>   		}
>>
>> -		if (ret < 0) {
>> -			goto unapply_new_state;
>> -		}
>> +		/* Apply all the settings for the new state - pinconf
> after */
>> +		list_for_each_entry(setting, &state->settings, node) {
>> +			switch (setting->type) {
>> +			case PIN_MAP_TYPE_MUX_GROUP:
>> +				ret = 0;
>> +				break;
>> +			case PIN_MAP_TYPE_CONFIGS_PIN:
>> +			case PIN_MAP_TYPE_CONFIGS_GROUP:
>> +				ret = pinconf_apply_setting(setting);
>> +				break;
>> +			default:
>> +				ret = -EINVAL;
>> +				break;
>> +			}
>>
>> -		/* Do not link hogs (circular dependency) */
>> -		if (p != setting->pctldev->p)
>> -			pinctrl_link_add(setting->pctldev, p->dev);
>> -	}
>> +			if (ret < 0)
>> +				goto unapply_new_state;
>>
>> -	p->state = state;
>> +			/* Do not link hogs (circular dependency) */
>> +			if (p != setting->pctldev->p)
>> +				pinctrl_link_add(setting->pctldev, p-
>> dev);
>> +		}
>>
>> -	return 0;
>> +		p->state = state;
>> +
>> +		return 0;
>>
>>   unapply_new_state:
>> -	dev_err(p->dev, "Error applying setting, reverse things back\n");
>>
>> -	list_for_each_entry(setting2, &state->settings, node) {
>> -		if (&setting2->node == &setting->node)
>> -			break;
>> -		/*
>> -		 * All we can do here is pinmux_disable_setting.
>> -		 * That means that some pins are muxed differently now
>> -		 * than they were before applying the setting (We can't
>> -		 * "unmux a pin"!), but it's not a big deal since the pins
>> -		 * are free to be muxed by another apply_setting.
>> -		 */
>> -		if (setting2->type == PIN_MAP_TYPE_MUX_GROUP)
>> -			pinmux_disable_setting(setting2);
>> +		list_for_each_entry(setting2, &state->settings, node) {
>> +			if (&setting2->node == &setting->node)
>> +				break;
>> +			/*
>> +			 * All we can do here is pinmux_disable_setting.
>> +			 * That means that some pins are muxed
> differently now
>> +			 * than they were before applying the setting
> (We can't
>> +			 * "unmux a pin"!), but it's not a big deal
> since the pins
>> +			 * are free to be muxed by another
> apply_setting.
>> +			 */
>> +			if (setting2->type == PIN_MAP_TYPE_MUX_GROUP)
>> +				pinmux_disable_setting(setting2);
>> +		}
>>   	}
>>
>> +	dev_err(p->dev, "Error applying setting, reverse things back\n");
>>   	/* There's no infinite recursive loop here because p->state is NULL
> */
>>   	if (old_state)
>>   		pinctrl_select_state(p, old_state);
>> diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
>> index 837fd5bd903d..6844edd38b4a 100644
>> --- a/drivers/pinctrl/core.h
>> +++ b/drivers/pinctrl/core.h
>> @@ -12,6 +12,7 @@
>>   #include <linux/list.h>
>>   #include <linux/mutex.h>
>>   #include <linux/radix-tree.h>
>> +#include <linux/spinlock.h>
>>   #include <linux/types.h>
>>
>>   #include <linux/pinctrl/machine.h>
>> @@ -91,6 +92,7 @@ struct pinctrl {
>>   	struct pinctrl_state *state;
>>   	struct list_head dt_maps;
>>   	struct kref users;
>> +	spinlock_t lock;
>>   };
>>
>>   /**
>>
>> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> 
> This breaks pinctrl-imx on imx8qxp:
> 
> [    1.170727] imx8qxp-pinctrl system-controller:pinctrl: initialized IMX
> pinctrl driver
> [    1.283968] BUG: sleeping function called from invalid context at kernel/
> locking/mutex.c:283
> [    1.292089] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 70,
> name: kworker/u16:4
> [    1.300341] preempt_count: 1, expected: 0
> [    1.304337] RCU nest depth: 0, expected: 0
> [    1.308423] CPU: 2 PID: 70 Comm: kworker/u16:4 Not tainted 6.8.0-rc3-
> next-20240209+ #2267 0b2aeebc4d64f1aef3abdd5fede2a9b5162eb867
> [    1.320148] Hardware name: TQ-Systems i.MX8QXP TQMa8XQP on MBa8Xx (DT)
> [    1.326667] Workqueue: events_unbound deferred_probe_work_func
> [    1.332486] Call trace:
> [    1.334918]  dump_backtrace+0x90/0x10c
> [    1.338653]  show_stack+0x14/0x1c
> [    1.341954]  dump_stack_lvl+0x6c/0x80
> [    1.345603]  dump_stack+0x14/0x1c
> [    1.348904]  __might_resched+0x108/0x160
> [    1.352813]  __might_sleep+0x58/0xb0
> [    1.356375]  mutex_lock+0x20/0x74
> [    1.359676]  imx_scu_call_rpc+0x44/0x2e8
> [    1.363586]  imx_pinconf_set_scu+0x84/0x150
> [    1.367756]  imx_pinconf_set+0x48/0x7c
> [    1.371491]  pinconf_apply_setting+0x90/0x110
> [    1.375835]  pinctrl_commit_state+0xcc/0x28c
> [    1.380092]  pinctrl_select_state+0x18/0x28
> [    1.384262]  pinctrl_bind_pins+0x1e4/0x26c
> [    1.388345]  really_probe+0x60/0x3e0
> [    1.391907]  __driver_probe_device+0x84/0x198
> [    1.396251]  driver_probe_device+0x38/0x150
> [    1.400421]  __device_attach_driver+0xcc/0x194
> [    1.404851]  bus_for_each_drv+0x80/0xdc
> [    1.408674]  __device_attach+0x9c/0x1d0
> [    1.412496]  device_initial_probe+0x10/0x18
> [    1.416666]  bus_probe_device+0xa4/0xa8
> [    1.420489]  deferred_probe_work_func+0x9c/0xe8
> [    1.425006]  process_one_work+0x14c/0x40c
> [    1.429002]  worker_thread+0x304/0x414
> [    1.432738]  kthread+0xf4/0x100
> [    1.435866]  ret_from_fork+0x10/0x20
> 
> With this commit pin_config_set callbacks need to be atomic suddenly which is
> a no-go for any device attached to i2c or spi and in this case IPC RPC.
> Once reverted systems start normally again.
Thanks for the info. It is a valid scenario of your report. I will also 
re-visit this.
> 
> Best regards,
> Alexander
> 

-- 
Thx and BRs,
Aiqun(Maria) Yu

