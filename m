Return-Path: <linux-kernel+bounces-49732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8E1846EB2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C0328C250
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E3B13D4ED;
	Fri,  2 Feb 2024 11:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QUOlqvZQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609ED7995B;
	Fri,  2 Feb 2024 11:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706872194; cv=none; b=eECn4chf4oMu37ZUkav2hppLc/qHzvdPnA7Hah0ICwYkemEZT5PiWDejOTTmvpIsKuRJ31mB3dFUIp+GGB1JBz6NtKW3YnVu13gQzf9kVJyFEykO/RsxaHNdXmGohbRSMu+2OP/+Y33ZDACAEufS1Un5j04kDJLjhzmaLXM2jgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706872194; c=relaxed/simple;
	bh=7RSfjVJnAk8+WEXi3R3d+FgrzOABbK5C0ntKdtIcJy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rIXq/znovk1fNxgD5afZ5k9CAAg44Z+rMcjqgG5H+LvBm7CY+oEXW8JPgPWV7kzi0G7PDxANv+fTFo/c7bBVeHxMuVj1mGdkhySjgqt6Cr/EROhaSavTQHVqRNEYIDDLt7utwZeRquufarP75yjfMeDq5Xi9yt6h9VqzI60kHKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QUOlqvZQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4129sJxQ017314;
	Fri, 2 Feb 2024 11:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=MWydaXpVR/aMqgvOr5qu+uOGLmEkcs3+0SnXK2+q8hc=; b=QU
	OlqvZQVy8wLKq11uiIzbgYlIv8iCKzt0IIZpE3HjFNHz08Mhx+LqBZzU3+Ks/sNX
	/C8H38Mru7AB4EPzV7bNRzQk134K3YBtheLVKfIyzf0ECQkxd3UktBlpNmSMhnCV
	AudIWkmyeN4pJprP+HxUqmm0u//TqhdJ4sYPYVm0LfxyG6uWG1slRuSrmqXIquPP
	g7wUgknncLSL/PHDQEcTAQaBujYr0E8NkwvXDxVe6am/DGuKZPkafkfezX785JL+
	Q7qclST2wc3Vmkrc5FD554b0F4G/NIUeW4fiCzR8ByJjkRp+IF2zELmoT303Uy3R
	Bc8N+Ss6m4lQ/hW+6xnw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pwm1679-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 11:09:47 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 412B9krt019050
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 11:09:46 GMT
Received: from [10.239.132.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 2 Feb
 2024 03:09:41 -0800
Message-ID: <dcf7f712-18e0-4983-9a5a-f851f1c921d7@quicinc.com>
Date: Fri, 2 Feb 2024 19:09:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] pinctrl: Add lock to ensure the state atomization
Content-Language: en-US
To: <andersson@kernel.org>, <linus.walleij@linaro.org>
CC: <kernel@quicinc.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20240202105854.26446-1-quic_aiquny@quicinc.com>
From: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
In-Reply-To: <20240202105854.26446-1-quic_aiquny@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sd1lTtdMlcYlMsxLjtyXfQq-wPBP_YUG
X-Proofpoint-ORIG-GUID: sd1lTtdMlcYlMsxLjtyXfQq-wPBP_YUG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_05,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 bulkscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402020081



On 2/2/2024 6:58 PM, Maria Yu wrote:
> Currently pinctrl_select_state is an export symbol and don't have
> effective re-entrance protect design. During async probing of devices
> it's possible to end up in pinctrl_select_state() from multiple
> contexts simultaneously, so make it thread safe.
> More over, when the real racy happened, the system frequently have
> printk message like:
>    "not freeing pin xx (xxx) as part of deactivating group xxx - it is
> already used for some other setting".
> Finally the system crashed after the flood log.
> Add per pinctrl lock to ensure the old state and new state transition
> atomization.
> Also move dev error print message outside the region with interrupts
> disabled.
> Use scoped guard to simplify the lock protection needed code.
> 
> Fixes: 4198a9b57106 ("pinctrl: avoid reload of p state in list iteration")
> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
> ---
forget to add change log here:
v4-v3 changed:
#include <linux/cleanup.h> is removed because of rebase.
others is same to v3.
>   drivers/pinctrl/core.c | 143 +++++++++++++++++++++--------------------
>   drivers/pinctrl/core.h |   2 +
>   2 files changed, 75 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
> index ee56856cb80c..1f7d001d4c1e 100644
> --- a/drivers/pinctrl/core.c
> +++ b/drivers/pinctrl/core.c
> @@ -1061,6 +1061,7 @@ static struct pinctrl *create_pinctrl(struct device *dev,
>   	p->dev = dev;
>   	INIT_LIST_HEAD(&p->states);
>   	INIT_LIST_HEAD(&p->dt_maps);
> +	spin_lock_init(&p->lock);
>   
>   	ret = pinctrl_dt_to_map(p, pctldev);
>   	if (ret < 0) {
> @@ -1257,93 +1258,95 @@ static void pinctrl_link_add(struct pinctrl_dev *pctldev,
>   static int pinctrl_commit_state(struct pinctrl *p, struct pinctrl_state *state)
>   {
>   	struct pinctrl_setting *setting, *setting2;
> -	struct pinctrl_state *old_state = READ_ONCE(p->state);
> +	struct pinctrl_state *old_state;
>   	int ret;
>   
> -	if (old_state) {
> -		/*
> -		 * For each pinmux setting in the old state, forget SW's record
> -		 * of mux owner for that pingroup. Any pingroups which are
> -		 * still owned by the new state will be re-acquired by the call
> -		 * to pinmux_enable_setting() in the loop below.
> -		 */
> -		list_for_each_entry(setting, &old_state->settings, node) {
> -			if (setting->type != PIN_MAP_TYPE_MUX_GROUP)
> -				continue;
> -			pinmux_disable_setting(setting);
> +	scoped_guard(spinlock_irqsave, &p->lock) {
> +		old_state = p->state;
> +		if (old_state) {
> +			/*
> +			 * For each pinmux setting in the old state, forget SW's record
> +			 * of mux owner for that pingroup. Any pingroups which are
> +			 * still owned by the new state will be re-acquired by the call
> +			 * to pinmux_enable_setting() in the loop below.
> +			 */
> +			list_for_each_entry(setting, &old_state->settings, node) {
> +				if (setting->type != PIN_MAP_TYPE_MUX_GROUP)
> +					continue;
> +				pinmux_disable_setting(setting);
> +			}
>   		}
> -	}
> -
> -	p->state = NULL;
>   
> -	/* Apply all the settings for the new state - pinmux first */
> -	list_for_each_entry(setting, &state->settings, node) {
> -		switch (setting->type) {
> -		case PIN_MAP_TYPE_MUX_GROUP:
> -			ret = pinmux_enable_setting(setting);
> -			break;
> -		case PIN_MAP_TYPE_CONFIGS_PIN:
> -		case PIN_MAP_TYPE_CONFIGS_GROUP:
> -			ret = 0;
> -			break;
> -		default:
> -			ret = -EINVAL;
> -			break;
> -		}
> +		p->state = NULL;
>   
> -		if (ret < 0)
> -			goto unapply_new_state;
> +		/* Apply all the settings for the new state - pinmux first */
> +		list_for_each_entry(setting, &state->settings, node) {
> +			switch (setting->type) {
> +			case PIN_MAP_TYPE_MUX_GROUP:
> +				ret = pinmux_enable_setting(setting);
> +				break;
> +			case PIN_MAP_TYPE_CONFIGS_PIN:
> +			case PIN_MAP_TYPE_CONFIGS_GROUP:
> +				ret = 0;
> +				break;
> +			default:
> +				ret = -EINVAL;
> +				break;
> +			}
>   
> -		/* Do not link hogs (circular dependency) */
> -		if (p != setting->pctldev->p)
> -			pinctrl_link_add(setting->pctldev, p->dev);
> -	}
> +			if (ret < 0)
> +				goto unapply_new_state;
>   
> -	/* Apply all the settings for the new state - pinconf after */
> -	list_for_each_entry(setting, &state->settings, node) {
> -		switch (setting->type) {
> -		case PIN_MAP_TYPE_MUX_GROUP:
> -			ret = 0;
> -			break;
> -		case PIN_MAP_TYPE_CONFIGS_PIN:
> -		case PIN_MAP_TYPE_CONFIGS_GROUP:
> -			ret = pinconf_apply_setting(setting);
> -			break;
> -		default:
> -			ret = -EINVAL;
> -			break;
> +			/* Do not link hogs (circular dependency) */
> +			if (p != setting->pctldev->p)
> +				pinctrl_link_add(setting->pctldev, p->dev);
>   		}
>   
> -		if (ret < 0) {
> -			goto unapply_new_state;
> -		}
> +		/* Apply all the settings for the new state - pinconf after */
> +		list_for_each_entry(setting, &state->settings, node) {
> +			switch (setting->type) {
> +			case PIN_MAP_TYPE_MUX_GROUP:
> +				ret = 0;
> +				break;
> +			case PIN_MAP_TYPE_CONFIGS_PIN:
> +			case PIN_MAP_TYPE_CONFIGS_GROUP:
> +				ret = pinconf_apply_setting(setting);
> +				break;
> +			default:
> +				ret = -EINVAL;
> +				break;
> +			}
>   
> -		/* Do not link hogs (circular dependency) */
> -		if (p != setting->pctldev->p)
> -			pinctrl_link_add(setting->pctldev, p->dev);
> -	}
> +			if (ret < 0)
> +				goto unapply_new_state;
>   
> -	p->state = state;
> +			/* Do not link hogs (circular dependency) */
> +			if (p != setting->pctldev->p)
> +				pinctrl_link_add(setting->pctldev, p->dev);
> +		}
>   
> -	return 0;
> +		p->state = state;
> +
> +		return 0;
>   
>   unapply_new_state:
> -	dev_err(p->dev, "Error applying setting, reverse things back\n");
>   
> -	list_for_each_entry(setting2, &state->settings, node) {
> -		if (&setting2->node == &setting->node)
> -			break;
> -		/*
> -		 * All we can do here is pinmux_disable_setting.
> -		 * That means that some pins are muxed differently now
> -		 * than they were before applying the setting (We can't
> -		 * "unmux a pin"!), but it's not a big deal since the pins
> -		 * are free to be muxed by another apply_setting.
> -		 */
> -		if (setting2->type == PIN_MAP_TYPE_MUX_GROUP)
> -			pinmux_disable_setting(setting2);
> +		list_for_each_entry(setting2, &state->settings, node) {
> +			if (&setting2->node == &setting->node)
> +				break;
> +			/*
> +			 * All we can do here is pinmux_disable_setting.
> +			 * That means that some pins are muxed differently now
> +			 * than they were before applying the setting (We can't
> +			 * "unmux a pin"!), but it's not a big deal since the pins
> +			 * are free to be muxed by another apply_setting.
> +			 */
> +			if (setting2->type == PIN_MAP_TYPE_MUX_GROUP)
> +				pinmux_disable_setting(setting2);
> +		}
>   	}
>   
> +	dev_err(p->dev, "Error applying setting, reverse things back\n");
>   	/* There's no infinite recursive loop here because p->state is NULL */
>   	if (old_state)
>   		pinctrl_select_state(p, old_state);
> diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
> index 837fd5bd903d..6844edd38b4a 100644
> --- a/drivers/pinctrl/core.h
> +++ b/drivers/pinctrl/core.h
> @@ -12,6 +12,7 @@
>   #include <linux/list.h>
>   #include <linux/mutex.h>
>   #include <linux/radix-tree.h>
> +#include <linux/spinlock.h>
>   #include <linux/types.h>
>   
>   #include <linux/pinctrl/machine.h>
> @@ -91,6 +92,7 @@ struct pinctrl {
>   	struct pinctrl_state *state;
>   	struct list_head dt_maps;
>   	struct kref users;
> +	spinlock_t lock;
>   };
>   
>   /**
> 
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d

-- 
Thx and BRs,
Aiqun(Maria) Yu

