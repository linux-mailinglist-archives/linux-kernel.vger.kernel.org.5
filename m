Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E5B77D771
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 03:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240967AbjHPBMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 21:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240950AbjHPBLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 21:11:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AD81FFC;
        Tue, 15 Aug 2023 18:11:44 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37G0NZZl007291;
        Wed, 16 Aug 2023 01:11:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MNG5KkkR3jovt42cqzoeDXo5inoaPLVdB2gOOiaXm6Q=;
 b=pWzgBvVIFLaEELVVj237G8B8hLT/RB8drAPQXMqu/GOh1N3opxGg2zdT+0lkc87+MWOG
 p/MSbDKVg1x/2t3rJppdmgWL7kgqEfedB2XW6pV5Jy9P+ebQLdMMTWJYF+CWaMKPBjzI
 AzkLd7PZGgDBsx5he481eQUTe3kN+DW/QHUWgYMkILYAJPmv+DUs8jf5gUnLY6cNkf28
 v/QE+aV/hfqzotgnBBGcZH/yvUI1ICzH7GFfyuLEaV7hJzEvx+EMnS3g6zXO1qI8Efus
 myyLdCfgqUKGJBsg1rEYhCBDMKp4QdN64szaKpq2hlru2Q5SE6IHmi61NgB0rz9KTaXn KA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sfuj8jjyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 01:11:02 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37G1B1Er010255
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 01:11:01 GMT
Received: from [10.110.95.218] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 15 Aug
 2023 18:11:00 -0700
Message-ID: <6ad025c1-e3f3-52cd-570b-309081604646@quicinc.com>
Date:   Tue, 15 Aug 2023 18:11:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 29/32] sound: soc: qcom: q6usb: Add headphone jack for
 offload connection status
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
 <20230725023416.11205-30-quic_wcheng@quicinc.com>
 <987394fd-9724-aa42-37fe-be9707565405@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <987394fd-9724-aa42-37fe-be9707565405@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _-ik-IFztGgXyv3fxcKE9byQnGZGGBLW
X-Proofpoint-GUID: _-ik-IFztGgXyv3fxcKE9byQnGZGGBLW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_22,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160009
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 7/25/2023 2:10 AM, Pierre-Louis Bossart wrote:
> 
> 
> On 7/25/23 04:34, Wesley Cheng wrote:
>> The headphone jack framework has a well defined intrastructure for
> 
> infrastructure
> 
>> notifying userspace entities through input devices.  Expose a jack device
>> that carries information about if an offload capable device is connected.
>> Applications can further identify specific offloading information through
>> other SND kcontrols.
> 
> What if you connect a set of USB speakers? Would they show as a
> headphone/headset?
> 

For now, let me modify the patch to send a HEADPHONE event.  We don't 
support the capture/record path as of now, so it doesn't make sense to 
generate a HEADSET event (which exposes both MIC and HEADPHONE).

When you plug in any USB audio device we'd generate this snd jack event. 
  Main purpose was to notify that the offload path is potentially available.

Thanks
Wesley Cheng

>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>   sound/soc/qcom/qdsp6/q6usb.c | 17 +++++++++++++++--
>>   1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/qcom/qdsp6/q6usb.c b/sound/soc/qcom/qdsp6/q6usb.c
>> index e4ccb9d912b0..860dff8c1438 100644
>> --- a/sound/soc/qcom/qdsp6/q6usb.c
>> +++ b/sound/soc/qcom/qdsp6/q6usb.c
>> @@ -20,6 +20,7 @@
>>   #include <sound/pcm_params.h>
>>   #include <sound/asound.h>
>>   #include <sound/q6usboffload.h>
>> +#include <sound/jack.h>
>>   
>>   #include "q6dsp-lpass-ports.h"
>>   #include "q6afe.h"
>> @@ -37,6 +38,7 @@ struct q6usb_status {
>>   struct q6usb_port_data {
>>   	struct q6afe_usb_cfg usb_cfg;
>>   	struct snd_soc_usb *usb;
>> +	struct snd_soc_jack hs_jack;
>>   	struct q6usb_offload priv;
>>   	struct mutex mutex;
>>   	unsigned long available_card_slot;
>> @@ -279,6 +281,7 @@ static const struct snd_kcontrol_new q6usb_offload_control = {
>>   /* Build a mixer control for a UAC connector control (jack-detect) */
>>   static void q6usb_connector_control_init(struct snd_soc_component *component)
>>   {
>> +	struct q6usb_port_data *data = dev_get_drvdata(component->dev);
>>   	int ret;
>>   
>>   	ret = snd_ctl_add(component->card->snd_card,
>> @@ -290,6 +293,11 @@ static void q6usb_connector_control_init(struct snd_soc_component *component)
>>   				snd_ctl_new1(&q6usb_offload_dev_ctrl, component));
>>   	if (ret < 0)
>>   		return;
>> +
>> +	ret = snd_soc_card_jack_new(component->card, "USB offload",
>> +					SND_JACK_HEADSET, &data->hs_jack);
> 
> not all USB devices are headsets...
> 
>> +	if (ret)
>> +		return;
>>   }
>>   
>>   static int q6usb_audio_ports_of_xlate_dai_name(struct snd_soc_component *component,
>> @@ -322,7 +330,10 @@ static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb, int card_idx,
>>   
>>   	mutex_lock(&data->mutex);
>>   	if (connected) {
>> -		snd_soc_dapm_enable_pin(dapm, "USB_RX_BE");
>> +		if (!data->available_card_slot) {
>> +			snd_soc_dapm_enable_pin(dapm, "USB_RX_BE");
>> +			snd_jack_report(data->hs_jack.jack, 1);
>> +		}
>>   		/*
>>   		 * Update the latest USB headset plugged in, if session is
>>   		 * idle.
>> @@ -338,8 +349,10 @@ static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb, int card_idx,
>>   		clear_bit(card_idx, &data->available_card_slot);
>>   		data->status[card_idx].num_pcm = 0;
>>   		data->status[card_idx].chip_index = 0;
>> -		if (!data->available_card_slot)
>> +		if (!data->available_card_slot) {
>>   			snd_soc_dapm_disable_pin(dapm, "USB_RX_BE");
>> +			snd_jack_report(data->hs_jack.jack, 0);
>> +		}
>>   	}
>>   	snd_soc_dapm_sync(dapm);
>>   	mutex_unlock(&data->mutex);
