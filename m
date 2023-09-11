Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F86A79B8A2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjIKUwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243836AbjIKR6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:58:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C70AE0;
        Mon, 11 Sep 2023 10:58:12 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BDgOto006536;
        Mon, 11 Sep 2023 17:57:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0TQHaYZr4yaKy9H6ZvKL+gKEicqG4S0R+N5+Acl4ZZg=;
 b=Bz1/kXFcBokSYDq0Dbx2o1WkSy+f+1dU6uBJcyO2E7whOFzCi4gTGECnwfk3RxoOgV6s
 F9jXt/T3hxD1zgb2enq9KQ4b7myTC8tvou1JIoS1T1z7FBAWiYVsxyGe/KzDNpK3V8BA
 bjifzRHncdk7MiRy4OCzcJC7BKugv9nCMEbrNhmQGiLcKeojLYbGdvF5jFZV34dQgDLD
 Mx0j1nu3+/MjM6NItNQUvT7M/nBCGNi2Al77FFdYdbLjSM8SsQcT7F5yvEB2qyAYrTTg
 kw5DlsFkwAm3BV9F/qyclXv4sZ3xTPQRoDxeIQexlNpIYea7MiSDHrjjqvY4pF8TFiS+ eQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t1xjmscnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 17:57:45 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38BHvhFc012981
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 17:57:43 GMT
Received: from [10.110.109.129] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 11 Sep
 2023 10:57:42 -0700
Message-ID: <c32e6983-4641-1849-cb25-d29da27bff15@quicinc.com>
Date:   Mon, 11 Sep 2023 10:57:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Wesley Cheng <quic_wcheng@quicinc.com>
Subject: Re: [PATCH v5 11/32] sound: usb: card: Introduce USB SND platform op
 callbacks
To:     Takashi Iwai <tiwai@suse.de>
CC:     <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <agross@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>, <quic_plai@quicinc.com>
References: <20230829210657.9904-1-quic_wcheng@quicinc.com>
 <20230829210657.9904-12-quic_wcheng@quicinc.com>
 <875y4matbc.wl-tiwai@suse.de>
Content-Language: en-US
In-Reply-To: <875y4matbc.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 834pxEf4zEHVF-QZwWGA1QQnukw4rdPa
X-Proofpoint-GUID: 834pxEf4zEHVF-QZwWGA1QQnukw4rdPa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110164
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

On 9/7/2023 8:36 AM, Takashi Iwai wrote:
> On Tue, 29 Aug 2023 23:06:36 +0200,
> Wesley Cheng wrote:
>>
>> Allow for different platforms to be notified on USB SND connect/disconnect
>> seqeunces.  This allows for platform USB SND modules to properly initialize
>> and populate internal structures with references to the USB SND chip
>> device.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>   sound/usb/card.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>   sound/usb/card.h |  9 +++++++++
>>   2 files changed, 54 insertions(+)
>>
>> diff --git a/sound/usb/card.c b/sound/usb/card.c
>> index 1b2edc0fd2e9..067a1e82f4bf 100644
>> --- a/sound/usb/card.c
>> +++ b/sound/usb/card.c
>> @@ -118,6 +118,34 @@ MODULE_PARM_DESC(skip_validation, "Skip unit descriptor validation (default: no)
>>   static DEFINE_MUTEX(register_mutex);
>>   static struct snd_usb_audio *usb_chip[SNDRV_CARDS];
>>   static struct usb_driver usb_audio_driver;
>> +static struct snd_usb_platform_ops *platform_ops;
>> +
>> +int snd_usb_register_platform_ops(struct snd_usb_platform_ops *ops)
>> +{
>> +	int ret;
>> +
>> +	mutex_lock(&register_mutex);
>> +	if (platform_ops) {
>> +		ret = -EEXIST;
>> +		goto out;
>> +	}
>> +
>> +	platform_ops = ops;
>> +out:
>> +	mutex_unlock(&register_mutex);
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(snd_usb_register_platform_ops);
> 
> For adding this kind of API, please give the proper comment.
> Especially this API is special and need a caution, to mention that it
> can be used only for a single instance.
> 
> Also, it should be mentioned that all callbacks are exclusive under
> the global register_mutex.
> 

Thanks for taking the time to review.  Sure, I'll add some comments in 
these new APIs to document what they are used for and how they are 
protected and limited.

>> @@ -910,7 +938,11 @@ static int usb_audio_probe(struct usb_interface *intf,
>>   	chip->num_interfaces++;
>>   	usb_set_intfdata(intf, chip);
>>   	atomic_dec(&chip->active);
>> +
>> +	if (platform_ops && platform_ops->connect_cb)
>> +		platform_ops->connect_cb(chip);
>>   	mutex_unlock(&register_mutex);
> 
> One uncertain thing is the argument for connect_cb and disconnect_cb.
> Those take snd_usb_audio object, but the callback gets called per
> interface at each probe and disconnect.  How does the callee handle
> multiple calls?

I guess it should depend on how the platform driver wants to handle it? 
  I haven't run into a device with multiple UAC interfaces before, so 
I'll need to mimic this configuration on a device, so I can see how it 
exposes itself.

Will investigate this a bit more on my end and come back with my findings.

> 
> Last but not least, the patch subject should be with "ALSA:" prefix,
> and in this case, at best "ALSA: usb-audio: xxx".
> 
> 

Got it, thanks!

Thanks
Wesley Cheng
