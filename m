Return-Path: <linux-kernel+bounces-21371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD208828E49
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAF4B1C20EE3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FF03D55A;
	Tue,  9 Jan 2024 19:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d1hQqC63"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C705A3D54B;
	Tue,  9 Jan 2024 19:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409HKIk8012564;
	Tue, 9 Jan 2024 19:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ptR/5uJ6ZKrEFnki2pjaHnuFOBzGZaw1Z0DkhxTdaps=; b=d1
	hQqC63mQE0Zlhlan5KklnhE7voYxrVsZCIR/2XCH/tJPimvQBQy6m5asvgNNWcKu
	Du9lgYjDKSYu2YupRiAeVcQtPs4ve+SupQGho9qDoUIwS/3OsYpMuyccTtE9cP62
	v8f5jjAz0mBZwPvzBvoZJfGujDu0lqaOTiKhbXOXrhjJ4WSHDr/oVYm73PebAYeR
	U50R+s/f0fQi6k7lFxsreN84CVuE8EWIKUaETiABaOADrJYo+OsjopqUxFTKrDTg
	lvsOqhZOl76B7fpnnKFCZQxVbk2HNTuNd2Dno5f6WuB9Mdk2kOJysUyFLwL5EaYZ
	GBSzpYa//BsY7RxTBzjg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh9q70fv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 19:56:27 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409JuQtf022989
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 19:56:26 GMT
Received: from [10.110.97.125] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 9 Jan
 2024 11:56:26 -0800
Message-ID: <6730b24c-cb80-76c1-dcff-908a1ecd0600@quicinc.com>
Date: Tue, 9 Jan 2024 11:56:26 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v12 19/41] ALSA: usb-audio: qcom: Introduce QC USB SND
 offloading support
Content-Language: en-US
To: Hillf Danton <hdanton@sina.com>
CC: <mathias.nyman@intel.com>, <tiwai@suse.com>,
        <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>
References: <20240102214549.22498-1-quic_wcheng@quicinc.com>
 <20240107093243.3225-1-hdanton@sina.com>
From: Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <20240107093243.3225-1-hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CLxFvF2QxZdd09hRt32-A41V_ejN4L-k
X-Proofpoint-GUID: CLxFvF2QxZdd09hRt32-A41V_ejN4L-k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 mlxlogscore=699
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090159

Hi Hillf,

On 1/7/2024 1:32 AM, Hillf Danton wrote:
> On Tue, 2 Jan 2024 13:45:27 -0800 Wesley Cheng <quic_wcheng@quicinc.com>
>> +/**
>> + * qc_usb_audio_offload_probe() - platform op connect handler
>> + * @chip: USB SND device
>> + *
>> + * Platform connect handler when a USB SND device is detected. Will
>> + * notify SOC USB about the connection to enable the USB ASoC backend
>> + * and populate internal USB chip array.
>> + *
>> + */
>> +static void qc_usb_audio_offload_probe(struct snd_usb_audio *chip)
>> +{
>> +	struct usb_device *udev = chip->dev;
>> +	struct snd_soc_usb_device *sdev;
>> +	struct xhci_sideband *sb;
>> +
>> +	/*
>> +	 * If there is no priv_data, the connected device is on a USB bus
>> +	 * that doesn't support offloading.  Avoid populating entries for
>> +	 * this device.
>> +	 */
>> +	if (!snd_soc_usb_find_priv_data(usb_get_usb_backend(udev)))
>> +		return;
>> +
>> +	mutex_lock(&chip->mutex);
>> +	if (!uadev[chip->card->number].chip) {
>> +		sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
>> +		if (!sdev)
>> +			goto exit;
>> +
>> +		sb = xhci_sideband_register(udev);
>> +		if (!sb)
>> +			goto free_sdev;
>> +	} else {
>> +		sb = uadev[chip->card->number].sb;
>> +		sdev = uadev[chip->card->number].sdev;
>> +	}
>> +
>> +	mutex_lock(&qdev_mutex);
>> +	if (!uaudio_qdev)
>> +		qc_usb_audio_offload_init_qmi_dev(udev);
>> +
>> +	atomic_inc(&uaudio_qdev->qdev_in_use);
>> +	mutex_unlock(&qdev_mutex);
>> +
>> +	uadev[chip->card->number].sb = sb;
>> +	uadev[chip->card->number].chip = chip;
> 
> Protecting uadev[] with a non global lock makes no sense.
>> +
>> +	sdev->card_idx = chip->card->number;
>> +	sdev->chip_idx = chip->index;
>> +	uadev[chip->card->number].sdev = sdev;
>> +
>> +	uaudio_qdev->last_card_num = chip->card->number;
>> +	snd_soc_usb_connect(usb_get_usb_backend(udev), sdev);
>> +
>> +	mutex_unlock(&chip->mutex);
>> +
>> +	return;
>> +
>> +free_sdev:
>> +	kfree(sdev);
>> +exit:
>> +	mutex_unlock(&chip->mutex);
>> +}
>> +
>> +/**
>> + * qc_usb_audio_offload_disconnect() - platform op disconnect handler
>> + * @chip: USB SND device
>> + *
>> + * Platform disconnect handler.  Will ensure that any pending stream is
>> + * halted by issuing a QMI disconnect indication packet to the adsp.
>> + *
>> + */
>> +static void qc_usb_audio_offload_disconnect(struct snd_usb_audio *chip)
>> +{
>> +	struct qmi_uaudio_stream_ind_msg_v01 disconnect_ind = {0};
>> +	struct uaudio_qmi_svc *svc = uaudio_svc;
>> +	struct uaudio_dev *dev;
>> +	int card_num;
>> +	int ret;
>> +
>> +	if (!chip)
>> +		return;
>> +
>> +	card_num = chip->card->number;
>> +	if (card_num >= SNDRV_CARDS)
>> +		return;
>> +
>> +	mutex_lock(&qdev_mutex);
>> +	mutex_lock(&chip->mutex);
> 
> Lock order looks correct here.
> 

Thanks for the review, will fix the order in probe.

Thanks
Wesley Cheng


