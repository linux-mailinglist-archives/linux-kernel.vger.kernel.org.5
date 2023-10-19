Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2547CEDA2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 03:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjJSBjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 21:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJSBjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 21:39:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C979F;
        Wed, 18 Oct 2023 18:39:43 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39J0fwvC016015;
        Thu, 19 Oct 2023 01:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RFlXQZL0GJrOfdJ6F4mLGhNhvWTNn3ZBCbC8IEXKLm8=;
 b=iq2kN6e6SPT4AxACP3T0IWzWC2felSJrrJw76Id655m6Uk6vTZK1788SLphMznZKrj+V
 ToaISwRzDTFk4h9QC8qzhmk26lDiL/a4bbDJcS3jpO49nv+s3BXa0Afkokzf02g4n4IJ
 JvTO/DFnRtDw06bT0w3THm+SR+xdgbTLI9iKX7GR9p8l20pFadPsfctFfwEcEkia04Y/
 T0KJQRxcJe08+Qn3XrZ8x/YNEmAA9F1VZA2T3YMA/W/G26uqmJGtHL0fepF6zku3vfql
 GX4ZRM4NN4Jgk9n/Hr150bgauCcpeUSTVD+1LshOZ38sY+vD87cT7ZCSAmQ5LwMPKmUb Sg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ttnnagjgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 01:39:18 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39J1dH7m025544
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 01:39:17 GMT
Received: from [10.110.123.255] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 18 Oct
 2023 18:39:16 -0700
Message-ID: <8e08fd5e-91b8-c73e-1d97-7cf4d98573d4@quicinc.com>
Date:   Wed, 18 Oct 2023 18:39:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v9 29/34] ASoC: qcom: qdsp6: Add SND kcontrol to select
 offload device
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <bgoswami@quicinc.com>,
        <Thinh.Nguyen@synopsys.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20231017200109.11407-1-quic_wcheng@quicinc.com>
 <20231017200109.11407-30-quic_wcheng@quicinc.com>
 <d218b8e2-d7b9-40a3-bfb3-da6a90404a8c@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <d218b8e2-d7b9-40a3-bfb3-da6a90404a8c@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ScvzUo-ubiID8YuRcoK0RmZmXn3qUkAw
X-Proofpoint-ORIG-GUID: ScvzUo-ubiID8YuRcoK0RmZmXn3qUkAw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_02,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190011
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 10/17/2023 3:50 PM, Pierre-Louis Bossart wrote:
> 
> 
> On 10/17/23 15:01, Wesley Cheng wrote:
>> Expose a kcontrol on the platform sound card, which will allow for
>> userspace to determine which USB card number and PCM device to offload.
>> This allows for userspace to potentially tag an alternate path for a
>> specific USB SND card and PCM device.  Previously, control was absent, and
>> the offload path would be enabled on the last USB SND device which was
>> connected.  This logic will continue to be applicable if no mixer input is
>> received for specific device selection.
>>
>> An example to configure the offload device using tinymix:
>> tinymix -D 0 set 'Q6USB offload SND device select' 1 0
>>
>> The above will set the Q6AFE device token to choose offload on card#1 and
>> pcm#0.  Device selection is made possible by setting the Q6AFE device
>> token.  The audio DSP utilizes this parameter, and will pass this field
>> back to the USB offload driver within the QMI stream requests.
> 
> This still begs the question on how userspace would figure what the
> card1 is and which endpoint is used when PCM0 is opened?
> 

Assuming we have something maybe in the component string for card1, then 
maybe that will help in this case as you mentioned earlier.  Again, I 
think my understanding of "endpoint" here is referring to the USB 
endpoint.  However, that isn't normally how we should think about it. 
 From the USB sound perspective, it would be the USB interface that is 
selected, and the USB endpoints that that interface descriptor includes 
(up to 2 usb eps).

> Ideally userpace would not have to know anything about "Q6USB".
> Presumably when other vendors expose their USB offload solution, we
> would want a generic control name, no?
> 

Hmm...initially I was keeping the sound kcontrol implementation based on 
a vendor specific approach.  Although, it might be good to standardize 
it a bit.  I could see if we can add this to within soc-usb so whenever 
we just create a soc usb device, it would also create and initialize the 
kcontrols as well?

> Jaroslav should chime in on this one :-)
> 
> 
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>   sound/soc/qcom/qdsp6/q6usb.c | 125 ++++++++++++++++++++++++++++++++++-
>>   1 file changed, 122 insertions(+), 3 deletions(-)
>>
>> diff --git a/sound/soc/qcom/qdsp6/q6usb.c b/sound/soc/qcom/qdsp6/q6usb.c
>> index d697cbe7f184..a95276b7d91d 100644
>> --- a/sound/soc/qcom/qdsp6/q6usb.c
>> +++ b/sound/soc/qcom/qdsp6/q6usb.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/dma-map-ops.h>
>>   
>>   #include <sound/pcm.h>
>> +#include <sound/control.h>
>>   #include <sound/soc.h>
>>   #include <sound/soc-usb.h>
>>   #include <sound/pcm_params.h>
>> @@ -35,9 +36,12 @@ struct q6usb_port_data {
>>   	struct q6afe_usb_cfg usb_cfg;
>>   	struct snd_soc_usb *usb;
>>   	struct q6usb_offload priv;
>> +	struct mutex mutex;
> 
> missing comment on what this protects. "mutex" is really a poor
> choice/name if I am honest.
> 
>>   	unsigned long available_card_slot;
>>   	struct q6usb_status status[SNDRV_CARDS];
>> -	int active_idx;
>> +	bool idx_valid;
>> +	int sel_card_idx;
>> +	int sel_pcm_idx;
>>   };
> 
>> +/* Build a mixer control for a UAC connector control (jack-detect) */
>> +static void q6usb_connector_control_init(struct snd_soc_component *component)
>> +{
>> +	int ret;
>> +
>> +	ret = snd_ctl_add(component->card->snd_card,
>> +				snd_ctl_new1(&q6usb_offload_dev_ctrl, component));
>> +	if (ret < 0)
>> +		return;
> 
> that error handling does not seem terribly useful...
> 

Based on your earlier comment, this might change :)

Thanks
Wesley Cheng

