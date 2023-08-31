Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC23178F36C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 21:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347187AbjHaThi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 15:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjHaThh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 15:37:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4221BF;
        Thu, 31 Aug 2023 12:37:33 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37VJH3Bj030249;
        Thu, 31 Aug 2023 19:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TWm7fyYZUKB+S9NSXhdzXoe/yY0UHPRqCdreT/60cDQ=;
 b=J49v0OJw9hKJpDLpoRE0b+oVJtoCeFzjBNFidr2h0w8K5syhhDecGrKKhNS+kIoF1iUq
 OiUKaMegGs+q34oJm+FsE6wJkeKIb1ywPWC/qj/pcjBZcrV3YgJDXQiYSyjeTZioE9pH
 LaLQuyXtpH8Y8MX4k7EVIibGUiOrQMSlgkX6JSHr/sC2GUQZRh9pooTJB37BAND/L2Xs
 +i0jjPP9ZjBtQ4i+iOx4Cwtb/g5d5JynMDfIk3/aiPsU8UcfoVhQrxj19Fe80fduevWC
 SoCc2zxRVxiS7cpVPDgGogmgUhGOOIKD/egLT5IMjdik1KqPALT23yl9o7vD7d6jfydE 7g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3str1nhne5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 19:36:56 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37VJateB001029
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 19:36:55 GMT
Received: from [10.71.114.68] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 31 Aug
 2023 12:36:54 -0700
Message-ID: <538bcc8c-9fab-f568-ad97-112734163ab6@quicinc.com>
Date:   Thu, 31 Aug 2023 12:36:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 12/32] sound: usb: Export USB SND APIs for modules
Content-Language: en-US
To:     =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <agross@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>
References: <20230829210657.9904-1-quic_wcheng@quicinc.com>
 <20230829210657.9904-13-quic_wcheng@quicinc.com>
 <5a5eb3a8-1379-116b-ca17-eac573207c57@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <5a5eb3a8-1379-116b-ca17-eac573207c57@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jGSRsbCxrGUfF0e8oyCBPySBlhhUmW5Z
X-Proofpoint-ORIG-GUID: jGSRsbCxrGUfF0e8oyCBPySBlhhUmW5Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_17,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310175
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amadeusz,

On 8/30/2023 5:50 AM, Amadeusz Sławiński wrote:
> On 8/29/2023 11:06 PM, Wesley Cheng wrote:
>> Some vendor modules will utilize useful parsing and endpoint management
>> APIs to start audio playback/capture.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>   sound/usb/card.c     |  4 +++
>>   sound/usb/endpoint.c |  1 +
>>   sound/usb/helper.c   |  1 +
>>   sound/usb/pcm.c      | 67 +++++++++++++++++++++++++++++++++-----------
>>   sound/usb/pcm.h      | 11 ++++++++
>>   5 files changed, 67 insertions(+), 17 deletions(-)
>>
>> diff --git a/sound/usb/card.c b/sound/usb/card.c
>> index 067a1e82f4bf..b45b6daee7b7 100644
>> --- a/sound/usb/card.c
>> +++ b/sound/usb/card.c
>> @@ -1053,6 +1053,7 @@ int snd_usb_lock_shutdown(struct snd_usb_audio 
>> *chip)
>>           wake_up(&chip->shutdown_wait);
>>       return err;
>>   }
>> +EXPORT_SYMBOL_GPL(snd_usb_lock_shutdown);
>>   /* autosuspend and unlock the shutdown */
>>   void snd_usb_unlock_shutdown(struct snd_usb_audio *chip)
>> @@ -1061,6 +1062,7 @@ void snd_usb_unlock_shutdown(struct 
>> snd_usb_audio *chip)
>>       if (atomic_dec_and_test(&chip->usage_count))
>>           wake_up(&chip->shutdown_wait);
>>   }
>> +EXPORT_SYMBOL_GPL(snd_usb_unlock_shutdown);
>>   int snd_usb_autoresume(struct snd_usb_audio *chip)
>>   {
>> @@ -1083,6 +1085,7 @@ int snd_usb_autoresume(struct snd_usb_audio *chip)
>>       }
>>       return 0;
>>   }
>> +EXPORT_SYMBOL_GPL(snd_usb_autoresume);
>>   void snd_usb_autosuspend(struct snd_usb_audio *chip)
>>   {
>> @@ -1096,6 +1099,7 @@ void snd_usb_autosuspend(struct snd_usb_audio 
>> *chip)
>>       for (i = 0; i < chip->num_interfaces; i++)
>>           usb_autopm_put_interface(chip->intf[i]);
>>   }
>> +EXPORT_SYMBOL_GPL(snd_usb_autosuspend);
>>   static int usb_audio_suspend(struct usb_interface *intf, 
>> pm_message_t message)
>>   {
>> diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
>> index a385e85c4650..aac92e0b8aa2 100644
>> --- a/sound/usb/endpoint.c
>> +++ b/sound/usb/endpoint.c
>> @@ -1503,6 +1503,7 @@ int snd_usb_endpoint_prepare(struct 
>> snd_usb_audio *chip,
>>       mutex_unlock(&chip->mutex);
>>       return err;
>>   }
>> +EXPORT_SYMBOL_GPL(snd_usb_endpoint_prepare);
>>   /* get the current rate set to the given clock by any endpoint */
>>   int snd_usb_endpoint_get_clock_rate(struct snd_usb_audio *chip, int 
>> clock)
>> diff --git a/sound/usb/helper.c b/sound/usb/helper.c
>> index bf80e55d013a..4322ae3738e6 100644
>> --- a/sound/usb/helper.c
>> +++ b/sound/usb/helper.c
>> @@ -62,6 +62,7 @@ void *snd_usb_find_csint_desc(void *buffer, int 
>> buflen, void *after, u8 dsubtype
>>       }
>>       return NULL;
>>   }
>> +EXPORT_SYMBOL_GPL(snd_usb_find_csint_desc);
>>   /*
>>    * Wrapper for usb_control_msg().
>> diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
>> index 08bf535ed163..999f66080649 100644
>> --- a/sound/usb/pcm.c
>> +++ b/sound/usb/pcm.c
>> @@ -148,6 +148,16 @@ find_format(struct list_head *fmt_list_head, 
>> snd_pcm_format_t format,
>>       return found;
>>   }
>> +const struct audioformat *
>> +snd_usb_find_format(struct list_head *fmt_list_head, snd_pcm_format_t 
>> format,
>> +        unsigned int rate, unsigned int channels, bool strict_match,
>> +        struct snd_usb_substream *subs)
>> +{
>> +    return find_format(fmt_list_head, format, rate, channels, 
>> strict_match,
>> +            subs);
>> +}
>> +EXPORT_SYMBOL_GPL(snd_usb_find_format);
>> +
>>   static const struct audioformat *
>>   find_substream_format(struct snd_usb_substream *subs,
>>                 const struct snd_pcm_hw_params *params)
>> @@ -157,6 +167,14 @@ find_substream_format(struct snd_usb_substream 
>> *subs,
>>                  true, subs);
>>   }
>> +const struct audioformat *
>> +snd_usb_find_substream_format(struct snd_usb_substream *subs,
>> +              const struct snd_pcm_hw_params *params)
>> +{
>> +    return find_substream_format(subs, params);
>> +}
>> +EXPORT_SYMBOL_GPL(snd_usb_find_substream_format);
>> +
>>   bool snd_usb_pcm_has_fixed_rate(struct snd_usb_substream *subs)
>>   {
>>       const struct audioformat *fp;
>> @@ -461,20 +479,9 @@ static void close_endpoints(struct snd_usb_audio 
>> *chip,
>>       }
>>   }
>> -/*
>> - * hw_params callback
>> - *
>> - * allocate a buffer and set the given audio format.
>> - *
>> - * so far we use a physically linear buffer although packetize transfer
>> - * doesn't need a continuous area.
>> - * if sg buffer is supported on the later version of alsa, we'll follow
>> - * that.
>> - */
>> -static int snd_usb_hw_params(struct snd_pcm_substream *substream,
>> -                 struct snd_pcm_hw_params *hw_params)
>> +int snd_usb_attach_endpoints(struct snd_usb_substream *subs,
>> +                struct snd_pcm_hw_params *hw_params)
>>   {
>> -    struct snd_usb_substream *subs = substream->runtime->private_data;
>>       struct snd_usb_audio *chip = subs->stream->chip;
>>       const struct audioformat *fmt;
>>       const struct audioformat *sync_fmt;
>> @@ -499,7 +506,7 @@ static int snd_usb_hw_params(struct 
>> snd_pcm_substream *substream,
>>       if (fmt->implicit_fb) {
>>           sync_fmt = snd_usb_find_implicit_fb_sync_format(chip, fmt,
>>                                   hw_params,
>> -                                !substream->stream,
>> +                                !subs->direction,
>>                                   &sync_fixed_rate);
>>           if (!sync_fmt) {
>>               usb_audio_dbg(chip,
>> @@ -579,15 +586,28 @@ static int snd_usb_hw_params(struct 
>> snd_pcm_substream *substream,
>>       return ret;
>>   }
>> +EXPORT_SYMBOL_GPL(snd_usb_attach_endpoints);
>>   /*
>> - * hw_free callback
>> + * hw_params callback
>>    *
>> - * reset the audio format and release the buffer
>> + * allocate a buffer and set the given audio format.
>> + *
>> + * so far we use a physically linear buffer although packetize transfer
>> + * doesn't need a continuous area.
>> + * if sg buffer is supported on the later version of alsa, we'll follow
>> + * that.
>>    */
>> -static int snd_usb_hw_free(struct snd_pcm_substream *substream)
>> +static int snd_usb_hw_params(struct snd_pcm_substream *substream,
>> +                 struct snd_pcm_hw_params *hw_params)
>>   {
>>       struct snd_usb_substream *subs = substream->runtime->private_data;
>> +
>> +    return snd_usb_attach_endpoints(subs, hw_params);
>> +}
>> +
>> +int snd_usb_detach_endpoint(struct snd_usb_substream *subs)
>> +{
>>       struct snd_usb_audio *chip = subs->stream->chip;
>>       snd_media_stop_pipeline(subs);
>> @@ -603,6 +623,19 @@ static int snd_usb_hw_free(struct 
>> snd_pcm_substream *substream)
>>       return 0;
>>   }
>> +EXPORT_SYMBOL_GPL(snd_usb_detach_endpoint);
>> +
>> +/*
>> + * hw_free callback
>> + *
>> + * reset the audio format and release the buffer
>> + */
>> +static int snd_usb_hw_free(struct snd_pcm_substream *substream)
>> +{
>> +    struct snd_usb_substream *subs = substream->runtime->private_data;
>> +
>> +    return snd_usb_detach_endpoint(subs);
>> +}
>>   /* free-wheeling mode? (e.g. dmix) */
>>   static int in_free_wheeling_mode(struct snd_pcm_runtime *runtime)
>> diff --git a/sound/usb/pcm.h b/sound/usb/pcm.h
>> index 388fe2ba346d..e36df3611a05 100644
>> --- a/sound/usb/pcm.h
>> +++ b/sound/usb/pcm.h
>> @@ -15,4 +15,15 @@ void snd_usb_preallocate_buffer(struct 
>> snd_usb_substream *subs);
>>   int snd_usb_audioformat_set_sync_ep(struct snd_usb_audio *chip,
>>                       struct audioformat *fmt);
>> +const struct audioformat *
>> +snd_usb_find_format(struct list_head *fmt_list_head, snd_pcm_format_t 
>> format,
>> +        unsigned int rate, unsigned int channels, bool strict_match,
>> +        struct snd_usb_substream *subs);
>> +const struct audioformat *
>> +snd_usb_find_substream_format(struct snd_usb_substream *subs,
>> +              const struct snd_pcm_hw_params *params);
>> +
>> +int snd_usb_attach_endpoints(struct snd_usb_substream *subs,
>> +                struct snd_pcm_hw_params *hw_params);
>> +int snd_usb_detach_endpoint(struct snd_usb_substream *subs);
>>   #endif /* __USBAUDIO_PCM_H */
> 
> Why is it multiple "endpoints" when attaching, but only one "endpoint" 
> when detaching? Both seem to be getting similar arguments.

This should be detach endpoints, since it closes both the data ep as 
well as the sync ep if present.  Will fix this.

Thanks
Wesley Cheng
