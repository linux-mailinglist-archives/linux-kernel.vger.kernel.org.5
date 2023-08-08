Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BC777358E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 02:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjHHAvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 20:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjHHAu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 20:50:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11202170B;
        Mon,  7 Aug 2023 17:50:57 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3780ccxa011108;
        Tue, 8 Aug 2023 00:50:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dq+Ac7H1VO2uWs6wuXTd+gQ6CJsKUJs85h+IpW2YRbI=;
 b=hUn3or2/X2hqdPPg4Rop39d223H9UL+ZBo8eFVCge0EkKrUOGssbAfywM0MBsuO+03yM
 9aQmVLAjSX4p0f/YAL2b+dFtzEswM2DVGOZYqMnuwhNULaKD7DCq2jRcuHgo3WZ4G9H2
 w8f5nxtiAzUIasbPLXLSE/sOxkafZbHa+hQhcSds2l4c70++brO2BEV1im8KOUik0ETz
 IaxlX2SoMQOwTFn9DPxLjlwhfyqdaJnCi2MGf5FcapGWUZCrG9nt2qFD1dTfKpl9UKOV
 ypLCWJJrt7wbiS1XtRZqU7bBxmJT1W7JsRbJKt4U+5wJ06ujab4g4Kld9undFrSUPUcV Bw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sb6jbrf1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 00:50:25 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3780oO2H013279
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Aug 2023 00:50:24 GMT
Received: from [10.110.124.178] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 7 Aug
 2023 17:50:23 -0700
Message-ID: <be6ef3e4-a3d6-3af8-0a47-506e2275b40b@quicinc.com>
Date:   Mon, 7 Aug 2023 17:50:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 10/32] ASoC: qcom: Add USB backend ASoC driver for Q6
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
 <20230725023416.11205-11-quic_wcheng@quicinc.com>
 <37018459-ee43-d853-1d73-3c6234a265b2@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <37018459-ee43-d853-1d73-3c6234a265b2@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: U7G8aZINZ3sI_IoYSnETSuLdn7RXEAEz
X-Proofpoint-GUID: U7G8aZINZ3sI_IoYSnETSuLdn7RXEAEz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_27,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=923 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080005
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 7/25/2023 1:45 AM, Pierre-Louis Bossart wrote:
> 
>> +struct q6usb_port_data {
>> +	struct q6afe_usb_cfg usb_cfg;
>> +	struct snd_soc_usb *usb;
>> +	struct q6usb_offload priv;
>> +	int active_idx;
> 
> what is an 'active_idx' ?
> 
> 

active_idx carries the USB sound card we're going to be offloading.

>> +static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb, int card_idx,
>> +			int connected)
>> +{
>> +	struct snd_soc_dapm_context *dapm;
>> +	struct q6usb_port_data *data;
>> +
>> +	dapm = snd_soc_component_get_dapm(usb->component);
>> +	data = dev_get_drvdata(usb->component->dev);
> 
> shouldn't you test that 'dapm' and 'data' are not NULL ?
> 

q6usb_component_probe() would be the one that registers to SOC USB to 
add this callback.  At that time, the component's dev and dapm 
references should be populated, so that should ensure that those are 
valid.  However, we could see that usb->component to be NULL, as that 
assignment happens after adding the port.  Instead I will add a check 
for usb->component before attempting to access the dapm/data params.

Another thing I will modify is to add a component removal callback, 
which will remove the SOC USB port.  That will ensure that no 
connection_cb() events are issued, so we don't run into any NULL pointer 
issues during the remove path.

>> +
>> +	if (connected) {
> 
> this goes back to my earlier comment that you treat 'connected' as a
> boolean.
> 

Done, changed to boolean.

>> +		snd_soc_dapm_enable_pin(dapm, "USB_RX_BE");
>> +		/* We only track the latest USB headset plugged in */
>> +		data->active_idx = card_idx;
>> +	} else {
>> +		snd_soc_dapm_disable_pin(dapm, "USB_RX_BE");
>> +	}
>> +	snd_soc_dapm_sync(dapm);
>> +
>> +	return 0;
>> +}
>> +
>> +static int q6usb_component_probe(struct snd_soc_component *component)
>> +{
>> +	struct q6usb_port_data *data = dev_get_drvdata(component->dev);
>> +	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
>> +
>> +	snd_soc_dapm_disable_pin(dapm, "USB_RX_BE");
>> +	snd_soc_dapm_sync(dapm);
>> +
>> +	data->usb = snd_soc_usb_add_port(component->dev, &data->priv, q6usb_alsa_connection_cb);
>> +	if (IS_ERR(data->usb)) {
>> +		dev_err(component->dev, "failed to add usb port\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	data->usb->component = component;
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct snd_soc_component_driver q6usb_dai_component = {
>> +	.probe = q6usb_component_probe,
> 
> erm, if you have a .probe that adds a port, don't you need a remove that
> removes the same port, and sets the pin state as well?
> 

Will add this as mentioned above.

>> +	.name = "q6usb-dai-component",
>> +	.dapm_widgets = q6usb_dai_widgets,
>> +	.num_dapm_widgets = ARRAY_SIZE(q6usb_dai_widgets),
>> +	.dapm_routes = q6usb_dapm_routes,
>> +	.num_dapm_routes = ARRAY_SIZE(q6usb_dapm_routes),
>> +	.of_xlate_dai_name = q6usb_audio_ports_of_xlate_dai_name,
>> +};
>> +
>> +static int q6usb_dai_dev_probe(struct platform_device *pdev)
>> +{
>> +	struct device_node *node = pdev->dev.of_node;
>> +	struct q6usb_port_data *data;
>> +	struct device *dev = &pdev->dev;
>> +	struct of_phandle_args args;
>> +	int ret;
>> +
>> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	ret = of_property_read_u32(node, "qcom,usb-audio-intr-num",
>> +				&data->priv.intr_num);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "failed to read intr num.\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = of_parse_phandle_with_fixed_args(node, "iommus", 1, 0, &args);
>> +	if (ret < 0)
>> +		data->priv.sid = -1;
>> +	else
>> +		data->priv.sid = args.args[0] & SID_MASK;
>> +
>> +	data->priv.domain = iommu_get_domain_for_dev(&pdev->dev);
>> +
>> +	data->priv.dev = dev;
>> +	dev_set_drvdata(dev, data);
>> +
>> +	ret = devm_snd_soc_register_component(dev, &q6usb_dai_component,
>> +					q6usb_be_dais, ARRAY_SIZE(q6usb_be_dais));
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return 0;
> 
> return devm_snd_soc_register_component
> 
>> +}
>> +
>> +static int q6usb_dai_dev_remove(struct platform_device *pdev)
>> +{
>> +	snd_soc_usb_remove_port(&pdev->dev);
> 
> that seems wrong, the port is added in the component probe, not the
> platform device probe.
> 

Will fix this.

Thanks
Wesley Cheng
