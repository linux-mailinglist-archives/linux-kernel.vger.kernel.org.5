Return-Path: <linux-kernel+bounces-102415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FFC87B1BD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C6F11F2247F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499D15788E;
	Wed, 13 Mar 2024 19:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IkQLFkI1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F695677A;
	Wed, 13 Mar 2024 19:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710357558; cv=none; b=RfULVWSPeIC2OWhtWxTWjYw3GVfJ6cI50sLdM+MZyRC/6xwqWLAEMbTu6LSyLdmljhsHERI5H7JIbj6Ye85c/h+HP2ddhgtGP9XQrqs8RFeu8s0IzkpUhMCoxukiNCxc6NZFBvYUSJrJ6f1gjJk3PbsU9zvh+iJ7X7nf80q6aHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710357558; c=relaxed/simple;
	bh=U5Ctd0fHGAqPrMjfc2snlTP8ttHo2mRJD6/wag+K4jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bX9HodTGGYAb54ZcNSggC47eiyRPmeaHbeQQf5xNbPI5S29Hx0PNXjyYh1E44vPGfCh0l0ItU2TrZI2aC+k9CYWJB3a72dFIsvyq1buMeJZ4nsxUx2f2XpQyc3N4SE08ByCLWFELzAhRcgA6MnuzY5O7dt20qGx9cCn2UnSgCRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IkQLFkI1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42DGF66r015454;
	Wed, 13 Mar 2024 19:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=KTKmv5ZSX3PW4T2dtjcDox5Wlq9+CL4HUpMzr1+x5ME=; b=Ik
	QLFkI13R2Ict+AQcLYytUzb2Dmj1SzsySsl4TpRIsNquh24sQq9k4KBFYlbfxIeu
	RG8a2Ci7HFyj2FrIfklrwgoMfhNJxfAu4M4i2CjudUFE8awp8ZXz6UX3GQ3qgB8n
	mTExL7pw1k19UAuf6oMehPmOSJwi89+nLsJVkFjunzkiXNyrK6pkrh/cDUAoQ55V
	GIVvGRwvae3Jk9Pm6xr38EBX8aRr7bY9p27F5kDQtAQZG6P+AsZmp6wqtdtvsSEl
	viiMlkQi31sX1iR87/RBiiYU469moLZEPDHAFem8IhGaOOBWuQkeAk0nOOQi4iAr
	chzATwRiRz1E5RGQslcg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wu81m1k70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 19:18:51 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42DJIoLp008331
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 19:18:50 GMT
Received: from [10.110.68.255] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Mar
 2024 12:18:49 -0700
Message-ID: <d97f635f-053b-70a7-5ffe-a1ae273091d1@quicinc.com>
Date: Wed, 13 Mar 2024 12:18:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v18 20/41] ALSA: usb-audio: qcom: Introduce QC USB SND
 offloading support
Content-Language: en-US
To: Albert Wang <albertccwang@google.com>
CC: <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <alsa-devel@alsa-project.org>
References: <20240228013619.29758-1-quic_wcheng@quicinc.com>
 <20240228013619.29758-21-quic_wcheng@quicinc.com>
 <CANqn-rjTgHgzssxZiuwvTKzOS31wzjS4Y9G-XacZN4a7c82MaA@mail.gmail.com>
From: Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <CANqn-rjTgHgzssxZiuwvTKzOS31wzjS4Y9G-XacZN4a7c82MaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: c1ey3JD6Fr1K_B5-zrMxzjn4x6MkJIlO
X-Proofpoint-GUID: c1ey3JD6Fr1K_B5-zrMxzjn4x6MkJIlO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1011 phishscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 suspectscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403130148

Hi Albert,

On 3/13/2024 1:03 AM, Albert Wang wrote:
> +/**
> + * qc_usb_audio_offload_suspend() - USB offload PM suspend handler
> + * @intf: USB interface
> + * @message: suspend type
> + *
> + * PM suspend handler to ensure that the USB offloading driver is able to stop
> + * any pending traffic, so that the bus can be suspended.
> + *
> + */
> +static void qc_usb_audio_offload_suspend(struct usb_interface *intf,
> +                                               pm_message_t message)
> +{
> +       struct qmi_uaudio_stream_ind_msg_v01 disconnect_ind = {0};
> +       struct snd_usb_audio *chip = usb_get_intfdata(intf);
> +       struct uaudio_qmi_svc *svc = uaudio_svc;
> +       struct uaudio_dev *dev;
> +       int card_num;
> +       int ret;
> +
> +       if (!chip)
> +               return;
> +
> +       card_num = chip->card->number;
> +       if (card_num >= SNDRV_CARDS)
> +               return;
> +
> +
> +       mutex_lock(&chip->mutex);
> +       dev = &uadev[card_num];
> +
> +       if (atomic_read(&dev->in_use)) {
> +               mutex_unlock(&chip->mutex);
> +               dev_dbg(uaudio_qdev->data->dev, "sending qmi
> indication suspend\n");
> +               disconnect_ind.dev_event = USB_QMI_DEV_DISCONNECT_V01;
> +               disconnect_ind.slot_id = dev->udev->slot_id;
> +               disconnect_ind.controller_num = dev->usb_core_id;
> +               disconnect_ind.controller_num_valid = 1;
> +               ret = qmi_send_indication(svc->uaudio_svc_hdl, &svc->client_sq,
> +                               QMI_UAUDIO_STREAM_IND_V01,
> +                               QMI_UAUDIO_STREAM_IND_MSG_V01_MAX_MSG_LEN,
> +                               qmi_uaudio_stream_ind_msg_v01_ei,
> +                               &disconnect_ind);
> +               if (ret < 0)
> +                       dev_err(uaudio_qdev->data->dev,
> +                               "qmi send failed with err: %d\n", ret);
> +
> +               ret = wait_event_interruptible_timeout(dev->disconnect_wq,
> +                               !atomic_read(&dev->in_use),
> +                               msecs_to_jiffies(DEV_RELEASE_WAIT_TIMEOUT));
> +               if (!ret) {
> +                       dev_err(uaudio_qdev->data->dev,
> +                               "timeout while waiting for dev_release\n");
> +                       atomic_set(&dev->in_use, 0);
> +               } else if (ret < 0) {
> +                       dev_err(uaudio_qdev->data->dev,
> +                               "failed with ret %d\n", ret);
> +                               atomic_set(&dev->in_use, 0);
> +               }
> +               mutex_lock(&chip->mutex);
> +       }
> +       mutex_unlock(&chip->mutex);
> +}
> +
> 
> Hi Wesley,
> 
> The suspend function `qc_usb_audio_offload_suspend()` looks to stop
> the traffic on the bus, so that the bus can be suspended. That allows
> the application processor(AP) to enter suspend. There is a subtle
> difference with our feature, which is to allow AP suspend with the
> Host and USB controller active to continue the audio offloading. We
> call this feature `allow AP suspend in playback`. So, I have some
> points to clarify with you:

Yes, I'm aware of that feature also.

> 1. Will the suspend flow `usb_audio_suspend() -->
> platform_ops->suspend_cb() --> qc_usb_audio_offload_suspend()` be
> called when offloading is active?

It can be.  This is why in our case, we are going to issue the 
disconnect event to the audio DSP to stop the session if it is currently 
in one.

> 2. As my understanding, the suspend function is to allow AP suspend
> when the offloading is IDLE, but it won't allow AP suspend when in
> playback or capture. Please correct me if anything is wrong.

As mentioned above, it will let apps go into PM suspend after forcing 
the audio stream to be idle.  We won't block PM suspend entry.

> 3. We would like to integrate the `allow AP suspend in playback`
> feature with your framework to become one upstream offload solution.
> Here is the patch:
> https://patchwork.kernel.org/project/linux-pm/patch/20240223143833.1509961-1-guanyulin@google.com/
> .

Yes, I saw that patch as well.  I'll take a look once this series lands 
upstream.

Thanks
Wesley Cheng

