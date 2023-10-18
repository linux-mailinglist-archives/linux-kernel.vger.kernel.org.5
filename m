Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC27D7CD1F2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 03:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjJRBqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 21:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJRBqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 21:46:05 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C89FC;
        Tue, 17 Oct 2023 18:46:00 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39I1TXF5025070;
        Wed, 18 Oct 2023 01:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7yjyvokzCfgl7R/uV8V92m+jYndtQZxbuN5PfVfkT6M=;
 b=gJy343HptdFrCM4CZUuVgRbneK6t2XPV8jqRnP3WZ8HDD7WZSJp/RHsH/BcF/cN1TP26
 dWW3JZ4Ijwf9gO6DtSvhffit73gDBjIJgWwD+V8YFeJOJdmc6NZig+lcV+F9urKXy9O3
 zoFc4Sv1+KzzYDeHbt5FdxMbrv+KlGFi4EWLUtgAmnVuYc4yoeBRp+vOYOpg5lClSRCt
 YJRpp1GYU3cYQFTyqPZisSasM6qeIU7m7xnmiskTE9MpRweeCuiAbaSn4XeX3Zjg4u2b
 Wy2w1ZQ+plPIFREK5A2oTAdDIalKWzoR1F7BBYFbP4WO/3eFi/Pg9++hcY2PrVOlCniO OQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsaky3m7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 01:45:39 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39I1jcQj003733
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 01:45:38 GMT
Received: from [10.71.115.127] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 17 Oct
 2023 18:45:37 -0700
Message-ID: <c72bcf47-af0b-8819-1c30-06b51358381e@quicinc.com>
Date:   Tue, 17 Oct 2023 18:45:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v9 09/34] ASoC: qcom: qdsp6: Introduce USB AFE port to
 q6dsp
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
 <20231017200109.11407-10-quic_wcheng@quicinc.com>
 <7aa4ea87-9d1f-400a-bcc5-b56e5b4500c6@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <7aa4ea87-9d1f-400a-bcc5-b56e5b4500c6@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V99T9WNETYh1v8qA15HgxbgxEtwoiO1y
X-Proofpoint-ORIG-GUID: V99T9WNETYh1v8qA15HgxbgxEtwoiO1y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_08,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310180013
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 10/17/2023 2:32 PM, Pierre-Louis Bossart wrote:
> 
> 
> On 10/17/23 15:00, Wesley Cheng wrote:
>> The QC ADSP is able to support USB playback endpoints, so that the main
> 
> playback only?
> 

Correct, playback only at this time.

>> application processor can be placed into lower CPU power modes.  This adds
>> the required AFE port configurations and port start command to start an
>> audio session.
>>
>> Specifically, the QC ADSP can support all potential endpoints that are
>> exposed by the audio data interface.  This includes, feedback endpoints
>> (both implicit and explicit) as well as the isochronous (data) endpoints.
> 
> implicit feedback means support for capture. This is confusing...
> 

I mean, a USB device can expose a capture path, but as of now, we won't 
enable the offloading to the audio DSP for it.  However, if we're 
executing playback, and device does support implicit feedback, we will 
pass that along to the audio DSP to utilize.

>> +static int q6usb_hw_params(struct snd_pcm_substream *substream,
>> +			   struct snd_pcm_hw_params *params,
>> +			   struct snd_soc_dai *dai)
>> +{
>> +	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
>> +	int channels = params_channels(params);
>> +	int rate = params_rate(params);
>> +	struct q6afe_usb_cfg *usb = &dai_data->port_config[dai->id].usb_audio;
>> +
>> +	usb->sample_rate = rate;
>> +	usb->num_channels = channels;
>> +
>> +	switch (params_format(params)) {
>> +	case SNDRV_PCM_FORMAT_U16_LE:
>> +	case SNDRV_PCM_FORMAT_S16_LE:
>> +	case SNDRV_PCM_FORMAT_SPECIAL:
> 
> what does FORMAT_SPECIAL mean? the only other reference I see to this is
> related to SLIMbus, not sure how this is related?
> 

Thanks for catching this.  It shouldn't be included in this path.

>> +		usb->bit_width = 16;
>> +		break;
>> +	case SNDRV_PCM_FORMAT_S24_LE:
>> +	case SNDRV_PCM_FORMAT_S24_3LE:
>> +		usb->bit_width = 24;
>> +		break;
>> +	case SNDRV_PCM_FORMAT_S32_LE:
>> +		usb->bit_width = 32;
>> +		break;
>> +	default:
>> +		dev_err(dai->dev, "%s: invalid format %d\n",
>> +			__func__, params_format(params));
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
> 
>> @@ -617,6 +655,9 @@ static const struct snd_soc_dapm_route q6afe_dapm_routes[] = {
>>   	{"TX_CODEC_DMA_TX_5", NULL, "TX_CODEC_DMA_TX_5 Capture"},
>>   	{"RX_CODEC_DMA_RX_6 Playback", NULL, "RX_CODEC_DMA_RX_6"},
>>   	{"RX_CODEC_DMA_RX_7 Playback", NULL, "RX_CODEC_DMA_RX_7"},
>> +
>> +	/* USB playback AFE port receives data for playback, hence use the RX port */
>> +	{"USB Playback", NULL, "USB_RX"},
> 
> Capture for implicit feedback?
> 

Please refer to the above comment.

>>   };
>>   
>>   static int msm_dai_q6_dai_probe(struct snd_soc_dai *dai)
>> @@ -644,6 +685,18 @@ static int msm_dai_q6_dai_remove(struct snd_soc_dai *dai)
>>   	return 0;
>>   }
>>   
>> +static const struct snd_soc_dai_ops q6usb_ops = {
>> +	.probe		= msm_dai_q6_dai_probe,
>> +	.prepare	= q6afe_dai_prepare,
>> +	.hw_params	= q6usb_hw_params,
> 
> this is rather confusing with two different layers used for hw_params
> and prepare? Additional comments or explanations wouldn't hurt.
> 

I thought this was how the ASoC design was.  Each DAI defined for a 
particular path has it own set of callbacks implemented to bring up any 
required resources for that entity.  So in this case, it initializes the 
"cpu" DAI, which is the main component that handles communication with 
the audio DSP.

>> +	.shutdown	= q6afe_dai_shutdown,
>> +	/*
>> +	 * Startup callback not needed, as AFE port start command passes the PCM
>> +	 * parameters within the AFE command, which is provided by the PCM core
>> +	 * during the prepare() stage.
> 
> This doesn't really explain why you need a shutdown?
> 
> 

Sure, I'll add a comment.  shutdown() is needed to actually issue a AFE 
port stop command to stop pumping audio data on a particular AFE port. 
This occurs when userspace closes the PCM device for the platform sound 
card, and is triggered for all linked DAIs.

>> + * struct afe_param_id_usb_audio_dev_latency_mode
>> + * @cfg_minor_version: Minor version used for tracking USB audio device
>> + * configuration.
>> + * Supported values:
>> + *     AFE_API_MINOR_VERSION_USB_AUDIO_LATENCY_MODE
>> + * @mode: latency mode for the USB audio device
> 
> what are the different latency modes? and is this related to the latency
> reporting that was added in the USB2 audio class IIRC?
> 

Must've missed removing this part during one of the earlier revision 
cleanups I had done.  We aren't setting this parameter currently on the 
AFE side, and it isn't utilized either in the audio DSP, so I will 
remove this definition.

>> +static int afe_port_send_usb_dev_param(struct q6afe_port *port, struct q6afe_usb_cfg *cfg)
>> +{
>> +	union afe_port_config *pcfg = &port->port_cfg;
>> +	struct afe_param_id_usb_audio_dev_params usb_dev;
>> +	struct afe_param_id_usb_audio_dev_lpcm_fmt lpcm_fmt;
>> +	struct afe_param_id_usb_audio_svc_interval svc_int;
>> +	int ret = 0;
> 
> useless init overridden...

Will fix this.

>> +
>> +	if (!pcfg) {
>> +		dev_err(port->afe->dev, "%s: Error, no configuration data\n", __func__);
>> +		ret = -EINVAL;
>> +		goto exit;
>> +	}
>> +
>> +	memset(&usb_dev, 0, sizeof(usb_dev));
>> +	memset(&lpcm_fmt, 0, sizeof(lpcm_fmt));
>> +	memset(&svc_int, 0, sizeof(svc_int));
>> +
>> +	usb_dev.cfg_minor_version = AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG;
>> +	ret = q6afe_port_set_param_v2(port, &usb_dev,
> 
> .... here
> 
>> +				      AFE_PARAM_ID_USB_AUDIO_DEV_PARAMS,
>> +				      AFE_MODULE_AUDIO_DEV_INTERFACE, sizeof(usb_dev));
>> +	if (ret) {
>> +		dev_err(port->afe->dev, "%s: AFE device param cmd failed %d\n",
>> +			__func__, ret);
>> +		goto exit;
>> +	}
>> +
>> +	lpcm_fmt.cfg_minor_version = AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG;
>> +	lpcm_fmt.endian = pcfg->usb_cfg.endian;
>> +	ret = q6afe_port_set_param_v2(port, &lpcm_fmt,
>> +				      AFE_PARAM_ID_USB_AUDIO_DEV_LPCM_FMT,
>> +				      AFE_MODULE_AUDIO_DEV_INTERFACE, sizeof(lpcm_fmt));
>> +	if (ret) {
>> +		dev_err(port->afe->dev, "%s: AFE device param cmd LPCM_FMT failed %d\n",
>> +			__func__, ret);
>> +		goto exit;
>> +	}
>> +
>> +	svc_int.cfg_minor_version = AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG;
>> +	svc_int.svc_interval = pcfg->usb_cfg.service_interval;
>> +	ret = q6afe_port_set_param_v2(port, &svc_int,
>> +				      AFE_PARAM_ID_USB_AUDIO_SVC_INTERVAL,
>> +				      AFE_MODULE_AUDIO_DEV_INTERFACE, sizeof(svc_int));
>> +	if (ret)
>> +		dev_err(port->afe->dev, "%s: AFE device param cmd svc_interval failed %d\n",
>> +			__func__, ret);
>> +
>> +exit:
>> +	return ret;
>> +}
> 
>> -#define AFE_PORT_MAX		129
>> +#define AFE_PORT_MAX		137
> 
> does this mean 8 ports are reserved for USB?
> 
> Or is this 137 just a random index coming from the AFE design?
> 
> 

Its the latter.  Each port has a defined number/ID on the audio DSP AFE end.

Thanks
Wesley Cheng
