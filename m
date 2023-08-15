Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49D377C56E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbjHOBuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbjHOBtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:49:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17F910E3;
        Mon, 14 Aug 2023 18:49:50 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37F1QkBp006630;
        Tue, 15 Aug 2023 01:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wsT4IGjIrb4bGQfHVxzop4vfTx2C3A6VKvHw1ZH9cFc=;
 b=btB8awc213SQfoivvaVHWr+k/JrvF0mTFcMvos36hMct5+w3gOypamqCEXlCh1VsbAJE
 UYQGnDCTFTwKbonhWzKunPFeJnVcSUfkn7KVjj/eyZYL85p6FTITHh5RFrHB9QUuE3eN
 TV9FJEvkWNXSi329NB9P6mJIUAEE6g4CrTsUhXtNNJjLndRDz/65xBY0JFBh8Qx5C1WQ
 ONTOjEv/dv0vvdTM31+IE2wx58rv+d8ojE/gLuGVFlivI997lPRsNCs+8EVt5VG4VhHn
 xZfxJdxLSQJifie7b4bXSUjLzG+Jb5advknFrD6KljY3dVH23LCvOLDDRAzvil+bg5nz Yw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sfn4c9abf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 01:48:49 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37F1mmRc002454
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 01:48:48 GMT
Received: from [10.110.95.218] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 14 Aug
 2023 18:48:47 -0700
Message-ID: <08643bc7-0152-a381-6b01-e504968c26de@quicinc.com>
Date:   Mon, 14 Aug 2023 18:48:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 26/32] sound: Pass USB SND card and PCM information to
 SOC USB
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <bgoswami@quicinc.com>, <Thinh.Nguyen@synopsys.com>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <quic_jackp@quicinc.com>, <oneukum@suse.com>,
        <albertccwang@google.com>, <o-takashi@sakamocchi.jp>
References: <20230725023416.11205-1-quic_wcheng@quicinc.com>
 <20230725023416.11205-27-quic_wcheng@quicinc.com>
 <2ac68f83-6300-fa61-e1ca-80df07fc1494@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <2ac68f83-6300-fa61-e1ca-80df07fc1494@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: B_zY0RlKju3nGyOy-kAspHA80FoZFuAh
X-Proofpoint-GUID: B_zY0RlKju3nGyOy-kAspHA80FoZFuAh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_01,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxlogscore=920 lowpriorityscore=0 suspectscore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308150014
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 7/25/2023 1:59 AM, Pierre-Louis Bossart wrote:
> 
> 
> On 7/25/23 04:34, Wesley Cheng wrote:
>> Currently, only the index to the USB SND card array is passed to the USB
>> backend.  Pass through more information, specifically the USB SND card
>> number and the number of PCM devices available.  The USB backend should
>> know about which sound resources are being shared between the ASoC and USB
>> SND paths.  This can be utilized to properly select and maintain the
>> offloading devices.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>   include/sound/soc-usb.h           |  9 +++++----
>>   sound/soc/qcom/qdsp6/q6usb.c      | 20 ++++++++++++++++++--
>>   sound/soc/soc-usb.c               | 12 +++++++-----
>>   sound/usb/qcom/qc_audio_offload.c |  9 +++++----
>>   4 files changed, 35 insertions(+), 15 deletions(-)
>>
>> diff --git a/include/sound/soc-usb.h b/include/sound/soc-usb.h
>> index 71e6e75e600a..606128332044 100644
>> --- a/include/sound/soc-usb.h
>> +++ b/include/sound/soc-usb.h
>> @@ -19,20 +19,21 @@ struct snd_soc_usb {
>>   	struct device *dev;
>>   	struct snd_soc_component *component;
>>   	int (*connection_status_cb)(struct snd_soc_usb *usb, int card_idx,
>> -				int connected);
>> +				int chip_idx, int num_pcm, int connected);
> 
> I don't know what 'chip_idx' is.
> 

chip_idx is the index to the USB SND chip array which carries 
information about each udev (USB device) connected to USB SND)

> The 'num_pcm' sounds problematic if there are different devices for
> playback and capture. I would guess this is for playback only, but this
> doesn't scale.
> 

I agree.  My plan is to address this by having another SND SOC USB 
structure that is created by the USB class driver, ie qc_usb_offload, 
which would populate the required parameters.

Main thing I wanted to avoid is to have to expose the main USB SND 
structure if we're only going to only have a few variables to check for.

>>   	void *priv_data;
>>   };
> 
>> +struct q6usb_status {
>> +	unsigned int num_pcm;
>> +	unsigned int chip_index;
>> +	unsigned int pcm_index;
>> +};
>> +
>>   struct q6usb_port_data {
>>   	struct q6afe_usb_cfg usb_cfg;
>>   	struct snd_soc_usb *usb;
>>   	struct q6usb_offload priv;
>> +	unsigned long available_card_slot;
> 
> what is a card slot?
> 

Idea was just to have a bitmapped value of all offload capable audio 
devices that are currently connected.  Then we can take the necessary 
actions when everything has been disconnected.

>> +	struct q6usb_status status[SNDRV_CARDS];
>>   	int active_idx;
>>   };
>>   
>> @@ -97,7 +105,7 @@ static int q6usb_audio_ports_of_xlate_dai_name(struct snd_soc_component *compone
>>   }
>>   
>>   static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb, int card_idx,
>> -			int connected)
>> +			int chip_idx, int num_pcm, int connected)
>>   {
>>   	struct snd_soc_dapm_context *dapm;
>>   	struct q6usb_port_data *data;
>> @@ -109,8 +117,16 @@ static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb, int card_idx,
>>   		snd_soc_dapm_enable_pin(dapm, "USB_RX_BE");
>>   		/* We only track the latest USB headset plugged in */
>>   		data->active_idx = card_idx;
>> +
>> +		set_bit(card_idx, &data->available_card_slot);
>> +		data->status[card_idx].num_pcm = num_pcm;
>> +		data->status[card_idx].chip_index = chip_idx;
>>   	} else {
>> -		snd_soc_dapm_disable_pin(dapm, "USB_RX_BE");
>> +		clear_bit(card_idx, &data->available_card_slot);
>> +		data->status[card_idx].num_pcm = 0;
>> +		data->status[card_idx].chip_index = 0;
>> +		if (!data->available_card_slot)
>> +			snd_soc_dapm_disable_pin(dapm, "USB_RX_BE");
> 
> not able to follow what this does, this patch is rather unclear and
> lacks comments.
> 

I will add comments, but it basically will populate some of the limits 
that we'll end up using for controlling the ksndcontrols.

Thanks
Wesley Cheng
