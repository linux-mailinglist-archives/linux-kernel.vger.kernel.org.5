Return-Path: <linux-kernel+bounces-36801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 989BC83A6F1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292471F2AAD6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E9312E56;
	Wed, 24 Jan 2024 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gZ0vPpPz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EB0F9FD;
	Wed, 24 Jan 2024 10:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706092704; cv=none; b=MlMlCWF6QK9cMAbq1FFydWq1A3x5JI2I9yc++NJL1kClyrkfcsVfjRNIMq9q5Jbd7b5fuetMlIQfE2j3f8ZGDI7liaWQDVzIn6iJX+xGeRE8o5OMiK7heJWQqXwOjhkIQqic+x5DqAInmQo9EUNtSyp3P2kuuMqzmgOsSsfI8pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706092704; c=relaxed/simple;
	bh=ZHISb6uCgY79uBgE4NlpiQIOofqLNTENFS7kx+w6U24=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tf73Lnt450C9KMUCSVfpEvQCeVr0HP6ukcNkNV0Bc676p+L1ubUh9a82zuOxBIedobWrZHYrijJiDtUfbKMaMyafq/cx6T27QlJVa3fOb+RWhD66ZJILVuGdoPH8nWEfX1CHkpsrD/c+UGkFKaSGzJG/UnXvlMifseQEkFfzLBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gZ0vPpPz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O8tCJi025646;
	Wed, 24 Jan 2024 10:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=nvMFbtq6vNNVcrMIdmnR9fHYjFGjKBO+ZFQhcH+yxc4=; b=gZ
	0vPpPzYsabWcBSLzbe9DMAGctTNc98vM2y9VH4BF+0Zo4gn8wjv5JzCYkI0ZPsr/
	eT88kOSxsnQ7l7+Q9J2cvL8G7fefqQHXYuEYJQAzq6pVG72AXO6QRENQRXCgs4E7
	0HQskND2I/mmhnHAPGrIjN+xfna9o47JVT2KNzomOvIhYYPWdCoealUX3/NyLpGJ
	dVRFNC6KPwiMZfX/KD/HCu+jvyabfXhYyKBRpV2ljmLgQWKq6wSV4cTzKRTcm66F
	BLBSPcles7FFPnFqWyjG2J9//r8v0W6cXHBzfIUEOaNxMemO/g1is8ZJB6SGKqME
	PAUEX7rFYEkTt/8Mv+Og==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtyf786fc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 10:37:59 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40OAbJXT019331
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 10:37:19 GMT
Received: from [10.218.47.125] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 02:37:15 -0800
Message-ID: <836632f2-6384-1585-abf2-e4fd368318d4@quicinc.com>
Date: Wed, 24 Jan 2024 16:07:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] thermal/drivers/tsens: Add suspend to RAM support for
 tsens
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath
	<thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad
 Dybcio" <konrad.dybcio@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_manafm@quicinc.com>
References: <20240122100726.16993-1-quic_priyjain@quicinc.com>
 <CAA8EJprUmw-Q1aXUrP-T1dtJE-UUmqgb3RY7_+J4fetJKk11+Q@mail.gmail.com>
From: Priyansh Jain <quic_priyjain@quicinc.com>
In-Reply-To: <CAA8EJprUmw-Q1aXUrP-T1dtJE-UUmqgb3RY7_+J4fetJKk11+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: INNzGzZwjPtBYKtEtvYNGBHUxDMfe89p
X-Proofpoint-ORIG-GUID: INNzGzZwjPtBYKtEtvYNGBHUxDMfe89p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_04,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1011 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401240076



On 1/22/2024 7:24 PM, Dmitry Baryshkov wrote:
> On Mon, 22 Jan 2024 at 12:11, Priyansh Jain <quic_priyjain@quicinc.com> wrote:
>>
>> Add suspend callback support for tsens which disables tsens interrupts
>> in suspend to RAM callback.
>> Add resume callback support for tsens which reinitializes tsens hardware
>> and enables back tsens interrupts in resume callback.
> 
> This describes what the patch does. This is more or less obvious from
> the patch itself. Instead it should describe why this is necessary.
> 
sure will update in next version.
Regards,
Priyansh
>>
>> Signed-off-by: Priyansh Jain <quic_priyjain@quicinc.com>
>> ---
>>   drivers/thermal/qcom/tsens-v2.c |  2 +
>>   drivers/thermal/qcom/tsens.c    | 93 +++++++++++++++++++++++++++++++--
>>   drivers/thermal/qcom/tsens.h    |  7 +++
>>   3 files changed, 98 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
>> index 29a61d2d6ca3..1b74db6299c4 100644
>> --- a/drivers/thermal/qcom/tsens-v2.c
>> +++ b/drivers/thermal/qcom/tsens-v2.c
>> @@ -107,6 +107,8 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>>   static const struct tsens_ops ops_generic_v2 = {
>>          .init           = init_common,
>>          .get_temp       = get_temp_tsens_valid,
>> +       .suspend        = tsens_suspend_common,
>> +       .resume         = tsens_resume_common,
>>   };
>>
>>   struct tsens_plat_data data_tsens_v2 = {
>> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
>> index 6d7c16ccb44d..603ccb91009d 100644
>> --- a/drivers/thermal/qcom/tsens.c
>> +++ b/drivers/thermal/qcom/tsens.c
>> @@ -17,6 +17,7 @@
>>   #include <linux/pm.h>
>>   #include <linux/regmap.h>
>>   #include <linux/slab.h>
>> +#include <linux/suspend.h>
>>   #include <linux/thermal.h>
>>   #include "../thermal_hwmon.h"
>>   #include "tsens.h"
>> @@ -1153,7 +1154,7 @@ static const struct thermal_zone_device_ops tsens_of_ops = {
>>   };
>>
>>   static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
>> -                             irq_handler_t thread_fn)
>> +                             irq_handler_t thread_fn, int *irq_num)
>>   {
>>          struct platform_device *pdev;
>>          int ret, irq;
>> @@ -1169,6 +1170,7 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
>>                  if (irq == -ENXIO)
>>                          ret = 0;
>>          } else {
>> +               *irq_num = irq;
>>                  /* VER_0 interrupt is TRIGGER_RISING, VER_0_1 and up is ONESHOT */
>>                  if (tsens_version(priv) == VER_0)
>>                          ret = devm_request_threaded_irq(&pdev->dev, irq,
>> @@ -1193,6 +1195,85 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
>>          return ret;
>>   }
>>
>> +static int tsens_reinit(struct tsens_priv *priv)
>> +{
>> +       unsigned long flags;
>> +
>> +       spin_lock_irqsave(&priv->ul_lock, flags);
>> +
>> +       /* in VER_0 TSENS need to be explicitly enabled */
>> +       if (tsens_version(priv) == VER_0)
>> +               regmap_field_write(priv->rf[TSENS_EN], 1);
>> +
>> +       /*
>> +        * Re-enable the watchdog, unmask the bark.
>> +        * Disable cycle completion monitoring
>> +        */
>> +       if (priv->feat->has_watchdog) {
>> +               regmap_field_write(priv->rf[WDOG_BARK_MASK], 0);
>> +               regmap_field_write(priv->rf[CC_MON_MASK], 1);
>> +       }
>> +
>> +       /* Re-enable interrupts */
>> +       if (tsens_version(priv) >= VER_0_1)
>> +               tsens_enable_irq(priv);
>> +
>> +       spin_unlock_irqrestore(&priv->ul_lock, flags);
>> +
>> +       return 0;
>> +}
>> +
>> +int tsens_suspend_common(struct tsens_priv *priv)
>> +{
>> +       switch (pm_suspend_target_state) {
>> +       case PM_SUSPEND_MEM:
>> +               if (priv->combo_irq > 0) {
>> +                       disable_irq_nosync(priv->combo_irq);
>> +                       disable_irq_wake(priv->combo_irq);
>> +               }
>> +
>> +               if (priv->uplow_irq > 0) {
>> +                       disable_irq_nosync(priv->uplow_irq);
>> +                       disable_irq_wake(priv->uplow_irq);
>> +               }
>> +
>> +               if (priv->crit_irq > 0) {
>> +                       disable_irq_nosync(priv->crit_irq);
>> +                       disable_irq_wake(priv->crit_irq);
>> +               }
>> +               break;
>> +       default:
>> +               break;
>> +       }
>> +       return 0;
>> +}
>> +
>> +int tsens_resume_common(struct tsens_priv *priv)
>> +{
>> +       switch (pm_suspend_target_state) {
>> +       case PM_SUSPEND_MEM:
>> +               tsens_reinit(priv);
>> +               if (priv->combo_irq > 0) {
>> +                       enable_irq(priv->combo_irq);
>> +                       enable_irq_wake(priv->combo_irq);
>> +               }
>> +
>> +               if (priv->uplow_irq > 0) {
>> +                       enable_irq(priv->uplow_irq);
>> +                       enable_irq_wake(priv->uplow_irq);
>> +               }
>> +
>> +               if (priv->crit_irq > 0) {
>> +                       enable_irq(priv->crit_irq);
>> +                       enable_irq_wake(priv->crit_irq);
>> +               }
>> +               break;
>> +       default:
>> +               break;
>> +       }
>> +       return 0;
>> +}
>> +
>>   static int tsens_register(struct tsens_priv *priv)
>>   {
>>          int i, ret;
>> @@ -1227,15 +1308,19 @@ static int tsens_register(struct tsens_priv *priv)
>>
>>          if (priv->feat->combo_int) {
>>                  ret = tsens_register_irq(priv, "combined",
>> -                                        tsens_combined_irq_thread);
>> +                                        tsens_combined_irq_thread,
>> +                                        &priv->combo_irq);
>>          } else {
>> -               ret = tsens_register_irq(priv, "uplow", tsens_irq_thread);
>> +               ret = tsens_register_irq(priv, "uplow",
>> +                                        tsens_irq_thread,
>> +                                        &priv->uplow_irq);
>>                  if (ret < 0)
>>                          return ret;
>>
>>                  if (priv->feat->crit_int)
>>                          ret = tsens_register_irq(priv, "critical",
>> -                                                tsens_critical_irq_thread);
>> +                                                tsens_critical_irq_thread,
>> +                                                &priv->crit_irq);
>>          }
>>
>>          return ret;
>> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
>> index cb637fa289ca..268bf56105be 100644
>> --- a/drivers/thermal/qcom/tsens.h
>> +++ b/drivers/thermal/qcom/tsens.h
>> @@ -582,6 +582,11 @@ struct tsens_priv {
>>          const struct reg_field          *fields;
>>          const struct tsens_ops          *ops;
>>
>> +       /* For saving irq number to re-use later */
>> +       int                             uplow_irq;
>> +       int                             crit_irq;
>> +       int                             combo_irq;
>> +
>>          struct dentry                   *debug_root;
>>          struct dentry                   *debug;
>>
>> @@ -634,6 +639,8 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mo
>>   int init_common(struct tsens_priv *priv);
>>   int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp);
>>   int get_temp_common(const struct tsens_sensor *s, int *temp);
>> +int tsens_suspend_common(struct tsens_priv *priv);
>> +int tsens_resume_common(struct tsens_priv *priv);
>>
>>   /* TSENS target */
>>   extern struct tsens_plat_data data_8960;
>> --
>> 2.17.1
>>
>>
> 
> 

