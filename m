Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205E47CD222
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 04:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjJRCIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 22:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJRCH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 22:07:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DE6C6;
        Tue, 17 Oct 2023 19:07:56 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39I1oOeB025756;
        Wed, 18 Oct 2023 02:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ZtNt64VNU1SsvqasCFCcRFAS3qPKkxZ+7k2bN0abCgI=;
 b=k8FRfebcaPuNyPts1pnk+4330OH22W0o81uwh7O8JPv0N6qVAU8woGpFWIjtoWf5aWpH
 pT5ivcFN/F/5xXVNCB1oA2to6rBuKRQDT49KFrzSDf5t0cyUjeZKtJH2j4ZqArHmauEp
 Wc0Ts0f24JupV2S8K3gmu5d14JF3/msXj/CwmOeM+atQlMzHMAEVOao94e/1k8hdIgOa
 VlHhj7Mnj9SuOnBO1apP8sYNn5Z3myKjZb5KN5sY5mU3pwxYRzxhIk+ODP6Nzl4RyhQO
 P+l2jIWVLHv2nyTGq0x1ix5xQaPuuhoHlqNn7skEVfI8erVeBflAsk6lfeyd3f56GeSu NA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsvxws9tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 02:07:20 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39I27JD4032754
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 02:07:19 GMT
Received: from [10.71.115.127] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 17 Oct
 2023 19:07:18 -0700
Message-ID: <fb9c9c18-7383-da2f-86e3-348999b065bd@quicinc.com>
Date:   Tue, 17 Oct 2023 19:07:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v9 07/34] ASoC: Add SOC USB APIs for adding an USB backend
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
 <20231017200109.11407-8-quic_wcheng@quicinc.com>
 <8eb90a7a-8649-4a31-9997-d970915510bf@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <8eb90a7a-8649-4a31-9997-d970915510bf@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9YDWsrNqH69mHL5udDVXDdGz8Xg6XRHO
X-Proofpoint-ORIG-GUID: 9YDWsrNqH69mHL5udDVXDdGz8Xg6XRHO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_08,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180016
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

On 10/17/2023 2:48 PM, Pierre-Louis Bossart wrote:
> 
> 
> On 10/17/23 15:00, Wesley Cheng wrote:
>> Some platforms may have support for offloading USB audio devices to a
>> dedicated audio DSP.  Introduce a set of APIs that allow for management of
>> USB sound card and PCM devices enumerated by the USB SND class driver.
>> This allows for the ASoC components to be aware of what USB devices are
> 
> USB devices or USB endpoints? or both?
> 

USB devices.  At least in our case, which endpoints being used will be 
part of handling of the stream start QMI request coming from the audio 
DSP at a later stage.

>> available for offloading.
> 
>> +/**
>> + * struct snd_soc_usb_device
>> + * @card_idx - sound card index associated with USB device
>> + * @chip_idx - USB sound chip array index
>> + * @num_playback - number of playback streams
>> + * @num_capture - number of capture streams
> 
> presumably excluding explicit feedback streams?
> 

That's correct.  This doesn't include explicit streams.  This is going 
to be done during the stage mentioned above.  We find the alternate USB 
interface that supports the requested audio profile.  From there the USB 
SND already checks for if any feedback mechanism is used.

>> + **/
>> +struct snd_soc_usb_device {
>> +	int card_idx;
>> +	int chip_idx;
>> +	int num_playback;
>> +	int num_capture;
>> +};
>> +
>> +/**
>> + * struct snd_soc_usb
>> + * @list - list head for SND SOC struct list
>> + * @dev - USB backend device reference
>> + * @component - reference to ASoC component
>> + * @connection_status_cb - callback to notify connection events
>> + * @priv_data - driver data
>> + **/
>> +struct snd_soc_usb {
>> +	struct list_head list;
>> +	struct device *dev;
> 
> usbdev for consistency with the API below?
> 

This is not the usbdev, but the device reference to the DPCM backend DAI 
(q6usb)

>> +	struct snd_soc_component *component;
> 
> could you use component only and infer the device from component->dev?
> 

True, will look into that.

>> +	int (*connection_status_cb)(struct snd_soc_usb *usb,
>> +			struct snd_soc_usb_device *sdev, bool connected);
>> +	void *priv_data;
>> +};
>> +
>> +int snd_soc_usb_connect(struct device *usbdev, struct snd_soc_usb_device *sdev);
>> +int snd_soc_usb_disconnect(struct device *usbdev, struct snd_soc_usb_device *sdev);
>> +void *snd_soc_usb_get_priv_data(struct device *usbdev);
>> +
>> +struct snd_soc_usb *snd_soc_usb_add_port(struct device *dev, void *priv,
> 
> struct device *usbdev for consistency ?
> 
>> +			int (*connection_cb)(struct snd_soc_usb *usb,
>> +			struct snd_soc_usb_device *sdev, bool connected));
>> +int snd_soc_usb_remove_port(struct device *dev);
> 
> struct device *usbdev for consistency ?
> 
> 
>> +struct snd_soc_usb *snd_soc_usb_add_port(struct device *dev, void *priv,
>> +			int (*connection_cb)(struct snd_soc_usb *usb,
>> +			struct snd_soc_usb_device *sdev, bool connected))> +{
>> +	struct snd_soc_usb *usb;
>> +
>> +	usb = devm_kzalloc(dev, sizeof(*usb), GFP_KERNEL);
>> +	if (!usb)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	usb->connection_status_cb = connection_cb;
>> +	usb->dev = dev;
>> +	usb->priv_data = priv;
>> +
>> +	mutex_lock(&ctx_mutex);
>> +	list_add_tail(&usb->list, &usb_ctx_list);
>> +	mutex_unlock(&ctx_mutex);
>> +
>> +	return usb;
>> +}
>> +EXPORT_SYMBOL_GPL(snd_soc_usb_add_port);
>> +
>> +/**
>> + * snd_soc_usb_remove_port() - Remove a USB backend port
>> + * @dev: USB backend device
>> + *
>> + * Remove a USB backend device from USB SND SOC.  Memory is freed when USB
>> + * backend is removed.
> 
> when the USB backend driver is unbound?
> 

Will rename.

>> + *
>> + */
>> +int snd_soc_usb_remove_port(struct device *dev)
>> +{
>> +	struct snd_soc_usb *ctx, *tmp;
>> +
>> +	mutex_lock(&ctx_mutex);
>> +	list_for_each_entry_safe(ctx, tmp, &usb_ctx_list, list) {
>> +		if (ctx->dev == dev) {
>> +			list_del(&ctx->list);
>> +			break;
>> +		}
>> +	}
>> +	mutex_unlock(&ctx_mutex);
>> +
>> +	return 0;
> 
> can this return void to align with the current trend?
> 

Sure.

>> +}
>> +EXPORT_SYMBOL_GPL(snd_soc_usb_remove_port);
>> +
>> +/**
>> + * snd_soc_usb_connect() - Notification of USB device connection
>> + * @usbdev: USB bus device
>> + * @card_idx: USB SND card instance
>> + *
>> + * Notify of a new USB SND device connection.  The card_idx can be used to
>> + * handle how the DPCM backend selects, which device to enable USB offloading
>> + * on.
> 
> card_idx is not used below, and I don't see how this relates to a
> notification?
> 

Will fix this comment.

Thanks
Wesley Cheng
