Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7707378F363
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 21:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347179AbjHaTfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 15:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241678AbjHaTfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 15:35:30 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5731BF;
        Thu, 31 Aug 2023 12:35:27 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37VENKrW015709;
        Thu, 31 Aug 2023 19:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=f/TcS1u/2zxWALIx7/2raXt2YATq/rLjXTXCf5ghMpk=;
 b=ZrCApEYXbFHLN/5Ss/6nYCqWa5EDBqaO759DIclflZErwzE5q2dE20d8Gu9FZ9cyIFQq
 C+C/DNrj22Rm+2BjlgPO1K2dSIvljnFvMz6lKY8Bvyl0ErDAnJoxeQlVtB96n0OzbQMp
 F/tR7scNbajgqBtbalgxOCVFTofWwHi/XpaEEzh5JSNwovFGOMAVkz4+aLJqAAb0ej2J
 51l+rqmCiAcg0GRZrGOfOWcIqHAq5JdOT/CoLzg/gE35gJ4YG3OejT9fYo5Ze5Xfd5bb
 h+eMoVffy46nLRPNtVg1QqxtwepI2MH/I852AbXgOO3vuc02aFQtF9eZMPZMgUg7VN+O nw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3stj37ae55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 19:34:46 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37VJYdCA009176
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 19:34:39 GMT
Received: from [10.71.114.68] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 31 Aug
 2023 12:34:38 -0700
Message-ID: <ee16db64-661f-c28c-59ed-d895041f7ea5@quicinc.com>
Date:   Thu, 31 Aug 2023 12:34:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 10/32] ASoC: qcom: Add USB backend ASoC driver for Q6
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
 <20230829210657.9904-11-quic_wcheng@quicinc.com>
 <cd39ced8-fa89-a666-383f-8fd1c7a14d23@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <cd39ced8-fa89-a666-383f-8fd1c7a14d23@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZIFRqQLp0rL5Ws0X1HuMn9w9FbBMpRdY
X-Proofpoint-ORIG-GUID: ZIFRqQLp0rL5Ws0X1HuMn9w9FbBMpRdY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_17,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310175
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/30/2023 5:50 AM, Amadeusz Sławiński wrote:
> On 8/29/2023 11:06 PM, Wesley Cheng wrote:
>> Create a USB BE component that will register a new USB port to the 
>> ASoC USB
>> framework.  This will handle determination on if the requested audio
>> profile is supported by the USB device currently selected.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>   include/sound/q6usboffload.h  |  20 ++++
>>   sound/soc/qcom/Kconfig        |   4 +
>>   sound/soc/qcom/qdsp6/Makefile |   1 +
>>   sound/soc/qcom/qdsp6/q6usb.c  | 200 ++++++++++++++++++++++++++++++++++
>>   4 files changed, 225 insertions(+)
>>   create mode 100644 include/sound/q6usboffload.h
>>   create mode 100644 sound/soc/qcom/qdsp6/q6usb.c
>>
>> diff --git a/include/sound/q6usboffload.h b/include/sound/q6usboffload.h
>> new file mode 100644
>> index 000000000000..4fb1912d9f55
>> --- /dev/null
>> +++ b/include/sound/q6usboffload.h
>> @@ -0,0 +1,20 @@
>> +/* SPDX-License-Identifier: GPL-2.0
>> + *
>> + * linux/sound/q6usboffload.h -- QDSP6 USB offload
>> + *
>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All 
>> rights reserved.
>> + */
>> +
>> +/**
>> + * struct q6usb_offload
>> + * @dev - dev handle to usb be
>> + * @sid - streamID for iommu
>> + * @intr_num - usb interrupter number
>> + * @domain - allocated iommu domain
>> + **/
>> +struct q6usb_offload {
>> +    struct device *dev;
>> +    long long sid;
>> +    u32 intr_num;
>> +    struct iommu_domain *domain;
>> +};
>> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
>> index e7b00d1d9e99..bb285af6bb04 100644
>> --- a/sound/soc/qcom/Kconfig
>> +++ b/sound/soc/qcom/Kconfig
>> @@ -114,6 +114,9 @@ config SND_SOC_QDSP6_APM
>>   config SND_SOC_QDSP6_PRM_LPASS_CLOCKS
>>       tristate
>> +config SND_SOC_QDSP6_USB
>> +    tristate
>> +
>>   config SND_SOC_QDSP6_PRM
>>       tristate
>>       select SND_SOC_QDSP6_PRM_LPASS_CLOCKS
>> @@ -134,6 +137,7 @@ config SND_SOC_QDSP6
>>       select SND_SOC_TOPOLOGY
>>       select SND_SOC_QDSP6_APM
>>       select SND_SOC_QDSP6_PRM
>> +    select SND_SOC_QDSP6_USB
>>       help
>>        To add support for MSM QDSP6 Soc Audio.
>>        This will enable sound soc platform specific
>> diff --git a/sound/soc/qcom/qdsp6/Makefile 
>> b/sound/soc/qcom/qdsp6/Makefile
>> index 3963bf234664..c9457ee898d0 100644
>> --- a/sound/soc/qcom/qdsp6/Makefile
>> +++ b/sound/soc/qcom/qdsp6/Makefile
>> @@ -17,3 +17,4 @@ obj-$(CONFIG_SND_SOC_QDSP6_APM_DAI) += q6apm-dai.o
>>   obj-$(CONFIG_SND_SOC_QDSP6_APM_LPASS_DAI) += q6apm-lpass-dais.o
>>   obj-$(CONFIG_SND_SOC_QDSP6_PRM) += q6prm.o
>>   obj-$(CONFIG_SND_SOC_QDSP6_PRM_LPASS_CLOCKS) += q6prm-clocks.o
>> +obj-$(CONFIG_SND_SOC_QDSP6_USB) += q6usb.o
>> diff --git a/sound/soc/qcom/qdsp6/q6usb.c b/sound/soc/qcom/qdsp6/q6usb.c
>> new file mode 100644
>> index 000000000000..88aa0a64201a
>> --- /dev/null
>> +++ b/sound/soc/qcom/qdsp6/q6usb.c
>> @@ -0,0 +1,200 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All 
>> rights reserved.
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/init.h>
>> +#include <linux/module.h>
>> +#include <linux/device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/iommu.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/dma-map-ops.h>
>> +
>> +#include <sound/pcm.h>
>> +#include <sound/soc.h>
>> +#include <sound/soc-usb.h>
>> +#include <sound/pcm_params.h>
>> +#include <sound/asound.h>
>> +#include <sound/q6usboffload.h>
>> +
>> +#include "q6dsp-lpass-ports.h"
>> +#include "q6afe.h"
>> +
>> +#define SID_MASK    0xF
>> +
>> +struct q6usb_port_data {
>> +    struct q6afe_usb_cfg usb_cfg;
>> +    struct snd_soc_usb *usb;
>> +    struct q6usb_offload priv;
>> +    int active_idx;
>> +};
>> +
>> +static const struct snd_soc_dapm_widget q6usb_dai_widgets[] = {
>> +    SND_SOC_DAPM_HP("USB_RX_BE", NULL),
>> +};
>> +
>> +static const struct snd_soc_dapm_route q6usb_dapm_routes[] = {
>> +    {"USB Playback", NULL, "USB_RX_BE"},
>> +};
>> +
>> +static int q6usb_hw_params(struct snd_pcm_substream *substream,
>> +               struct snd_pcm_hw_params *params,
>> +               struct snd_soc_dai *dai)
>> +{
>> +    return 0;
>> +}
> 
> Missing new line after closing bracket between function and following 
> struct.
> 

Thanks for the review, will fix this.

>> +static const struct snd_soc_dai_ops q6usb_ops = {
>> +    .hw_params = q6usb_hw_params,
>> +};
>> +
>> +static struct snd_soc_dai_driver q6usb_be_dais[] = {
>> +    {
>> +        .playback = {
>> +            .stream_name = "USB BE RX",
>> +            .rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |
>> +                SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |
>> +                SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |
>> +                SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
>> +                SNDRV_PCM_RATE_192000,
>> +            .formats = SNDRV_PCM_FMTBIT_S16_LE | 
>> SNDRV_PCM_FMTBIT_S16_BE |
>> +                SNDRV_PCM_FMTBIT_U16_LE | SNDRV_PCM_FMTBIT_U16_BE |
>> +                SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S24_BE |
>> +                SNDRV_PCM_FMTBIT_U24_LE | SNDRV_PCM_FMTBIT_U24_BE,
>> +            .channels_min = 1,
>> +            .channels_max = 2,
>> +            .rate_max =     192000,
>> +            .rate_min =    8000,
>> +        },
>> +        .id = USB_RX,
>> +        .name = "USB_RX_BE",
>> +        .ops = &q6usb_ops,
>> +    },
>> +};
>> +
>> +static int q6usb_audio_ports_of_xlate_dai_name(struct 
>> snd_soc_component *component,
>> +                    const struct of_phandle_args *args,
>> +                    const char **dai_name)
>> +{
>> +    int id = args->args[0];
>> +    int ret = -EINVAL;
>> +    int i;
>> +
>> +    for (i = 0; i  < ARRAY_SIZE(q6usb_be_dais); i++) {
> 
> Double space after second i.
> 

Will change.

>> +        if (q6usb_be_dais[i].id == id) {
>> +            *dai_name = q6usb_be_dais[i].name;
>> +            ret = 0;
>> +            break;
>> +        }
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb,
>> +            struct snd_soc_usb_device *sdev, bool connected)
>> +{
>> +    struct q6usb_port_data *data;
>> +
>> +    if (!usb->component)
>> +        return -ENODEV;
>> +
>> +    data = dev_get_drvdata(usb->component->dev);
>> +
>> +    if (connected)
>> +        /* We only track the latest USB headset plugged in */
>> +        data->active_idx = sdev->card_idx;
> 
> Maybe add brackets around both comment and code? Not sure what guidance 
> there is in such cases, but above code looks weird to me.
> 

Sure.

>> +
>> +    return 0;
>> +}
>> +
>> +static int q6usb_component_probe(struct snd_soc_component *component)
>> +{
>> +    struct q6usb_port_data *data = dev_get_drvdata(component->dev);
>> +
>> +    data->usb = snd_soc_usb_add_port(component->dev, &data->priv, 
>> q6usb_alsa_connection_cb);
>> +    if (IS_ERR(data->usb)) {
>> +        dev_err(component->dev, "failed to add usb port\n");
>> +        return -ENODEV;
>> +    }
>> +
>> +    data->usb->component = component;
>> +
>> +    return 0;
>> +}
>> +
>> +static void q6usb_component_remove(struct snd_soc_component *component)
>> +{
>> +    snd_soc_usb_remove_port(component->dev);
>> +}
>> +
>> +static const struct snd_soc_component_driver q6usb_dai_component = {
>> +    .probe = q6usb_component_probe,
>> +    .remove = q6usb_component_remove,
>> +    .name = "q6usb-dai-component",
>> +    .dapm_widgets = q6usb_dai_widgets,
>> +    .num_dapm_widgets = ARRAY_SIZE(q6usb_dai_widgets),
>> +    .dapm_routes = q6usb_dapm_routes,
>> +    .num_dapm_routes = ARRAY_SIZE(q6usb_dapm_routes),
>> +    .of_xlate_dai_name = q6usb_audio_ports_of_xlate_dai_name,
>> +};
>> +
>> +static int q6usb_dai_dev_probe(struct platform_device *pdev)
>> +{
>> +    struct device_node *node = pdev->dev.of_node;
>> +    struct q6usb_port_data *data;
>> +    struct device *dev = &pdev->dev;
>> +    struct of_phandle_args args;
>> +    int ret;
>> +
>> +    data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>> +    if (!data)
>> +        return -ENOMEM;
>> +
>> +    ret = of_property_read_u32(node, "qcom,usb-audio-intr-num",
>> +                &data->priv.intr_num);
>> +    if (ret) {
>> +        dev_err(&pdev->dev, "failed to read intr num.\n");
>> +        return ret;
>> +    }
>> +
>> +    ret = of_parse_phandle_with_fixed_args(node, "iommus", 1, 0, &args);
>> +    if (ret < 0)
>> +        data->priv.sid = -1;
>> +    else
>> +        data->priv.sid = args.args[0] & SID_MASK;
>> +
>> +    data->priv.domain = iommu_get_domain_for_dev(&pdev->dev);
>> +
>> +    data->priv.dev = dev;
>> +    dev_set_drvdata(dev, data);
>> +
>> +    return devm_snd_soc_register_component(dev, &q6usb_dai_component,
>> +                    q6usb_be_dais, ARRAY_SIZE(q6usb_be_dais));
>> +}
>> +
>> +static int q6usb_dai_dev_remove(struct platform_device *pdev)
>> +{
>> +    return 0;
>> +}
> 
> Does platform driver really need empty remove function? Remove it.
> 

Wasn't too sure about this either, so I included it to be consistent. 
Will remove this and add a small comment on why it isn't required..

Thanks
Wesley Cheng
