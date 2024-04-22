Return-Path: <linux-kernel+bounces-153319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB7D8ACC72
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9054CB21466
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE76146D79;
	Mon, 22 Apr 2024 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Po5YNxFO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FAB1465A6;
	Mon, 22 Apr 2024 12:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713787580; cv=none; b=omKz4XGAnPXC79JH9EoDeUFaozHQ6KVR//YLXsq/fZGtTl2clt2Rnfhu3Gac1JqQulmyw1/JVPuc5qaTj81PrzFAiUeByZedS78xqs7x6DXcxWzpBEBl65T3uG1RdEuFC0nq26Lc55IFUUZwyalO2m7+YT/gW54/jxDkKHfuJI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713787580; c=relaxed/simple;
	bh=c+ec/JzT6ZChnI8VNR+kjXpMJ5qQ8sRKNMGsYEOD6ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BCLmtG6d69Nsd6Ltjnk4E3jVsdcz5ZId/puOYrBbVXb/c3PMmvh3oUvt5e+it0SoSDfFIjroFZ/L64SkAFtUqBJ+pCmJmWCdrjXJ1hVioLVpob2RJgUdp/nO11Uzd2KBjICmJ1ka2MUAM4pHET+TT8u3qUqy34cj5DP4ggvCMxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Po5YNxFO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M9OoWK026512;
	Mon, 22 Apr 2024 12:06:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=c+ec/JzT6ZChnI8VNR+kjXpMJ5qQ8sRKNMGsYEOD6ps=; b=Po
	5YNxFOwSo/3k54iwijC0BRwiz5CeukeGjKGQh2WPyCwUeDfzIOQ8BAZN4QwT1Gy7
	x1BGj1gRpZJ6c7D06BVBNqziqc9qk2LtU7REOzc/5qA/oMjAaIL4AHWgYewVydrv
	YuMV8p7wsvnsAzGlUVKvYy4f84HllT6Tb/UKDy/imIHI0qM33GlnHu+X7d7AckJ1
	pn0QcRXwkgjckDEiXcSc07m4gP0xGgq8+VnEyq5S6vCKWLtmR0zOdKQKxopBc87f
	nN/KTjZAqoJ4NCDA5AS/SGyNz8TKUcA67bwxpcHgBl5pxtae+oQ0DUehpvzGMp65
	nWMu/9b+ygmkZODSEvBQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnn82gdt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 12:06:11 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MC6AuM024085
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 12:06:10 GMT
Received: from [10.253.39.160] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 05:06:08 -0700
Message-ID: <d9908e10-66d6-4737-b366-80cbc9df1801@quicinc.com>
Date: Mon, 22 Apr 2024 20:06:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] bus: mhi: host: pci_generic: Add edl callback to
 enter EDL
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Mayank Rana <quic_mrana@quicinc.com>, <quic_jhugo@quicinc.com>,
        <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>
References: <1713170945-44640-1-git-send-email-quic_qianyu@quicinc.com>
 <1713170945-44640-4-git-send-email-quic_qianyu@quicinc.com>
 <17d94b91-137c-409c-8af3-f32f1af2eb71@quicinc.com>
 <4b684db2-d384-404a-9c54-60d79ac7cf9f@quicinc.com>
 <adb9ab3d-0fd2-4afe-96d7-573b1822e0c3@quicinc.com>
 <ab27b383-dcbf-4337-b3ea-da91763e834a@quicinc.com>
 <a5ea5263-8acb-48dd-a4e1-bc48a9bdf791@quicinc.com>
 <20240422080837.GC9775@thinkpad>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <20240422080837.GC9775@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GTsngNAd7myf_oDO4773FwzjWvB_ZHt3
X-Proofpoint-ORIG-GUID: GTsngNAd7myf_oDO4773FwzjWvB_ZHt3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220054


On 4/22/2024 4:08 PM, Manivannan Sadhasivam wrote:
> On Wed, Apr 17, 2024 at 12:41:25PM +0800, Qiang Yu wrote:
>
> [...]
>
>>>>>>> +    ret = mhi_get_channel_doorbell(mhi_cntrl, &val);
>>>>>>> +    if (ret)
>>>>>>> +        return ret;
>>>>>> Don't we need error handling part here i.e. calling
>>>>>> mhi_cntrl->runtime_put() as well mhi_device_put() ?
>>>>> Hi Mayank
>>>>>
>>>>> After soc_reset, device will reboot to EDL mode and MHI state
>>>>> will be SYSERR. So host will fail to suspend
>>>>> anyway. The "error handling" we need here is actually to enter
>>>>> EDL mode, this will be done by SYSERR irq.
>>>>> Here, mhi_cntrl->runtime_put() and mhi_device_put() are only to
>>>>> balance mhi_cntrl->runtime_get() and
>>>>> mhi_device_get_sync().
>>>>>
>>>>> Thanks,
>>>>> Qiang
>>>> I am saying is there possibility that mhi_get_channel_doorbell()
>>>> returns error ?
>>>> If yes, then why don't we need error handling as part of it. you are
>>>> exiting if this API return error without doing anything.
>>> I think here mhi_get_channel_doorbell will not return error. But I still
>>> add a error checking because it invoked mhi_read_reg, which is a must
>>> check
>>> API. For modem mhi controller, this API eventually does a memory read.
>>> This memory read will return a normal value if link is up and all f's if
>>> link
>>> is bad.
>>>
>>> Thanks,
>>> Qiang
>> Actually, mhi_get_channel_doorbell should also be used in mhi_init_mmio to
>> replace the getting chdb operation by invoking mhi_read_reg as Mani
>> commented.
>> In mhi_init_mmio, we invoke mhi_read_reg many times, but there is also not
>> additionnal error handling.
>>
>> I'm not very sure the reason but perhaps if mhi_read_reg returns error (I
>> don't
>> know which controller will provide a memory read callback returning errors),
> Take a look at AIC100 driver: drivers/accel/qaic/mhi_controller.c
>
>> most
>> probably something is wrong in PCIe, which is not predictable by MHI and we
>> can
>> not add err handling every time invoking mhi_read_reg. But we have a timer
>> to
>> do health_check in pci_generic.c. If link is down, we will do
>> pci_function_reset
>> to try to reovery.
>>
> Right, but the MHI stack is designed to be bus agnostic. So if we happen to use
> it with other busses like USB, I2C etc... then read APIs may fail.
>
> Even with PCIe, read transaction may return all 1 response and MHI needs to
> treat it as an error condition. But sadly, both pci_generic and ath controllers
> are not checking for invalid read value. But those need to be fixed.
>
> Regarding Mayank's query, you should do error cleanups if
> mhi_get_channel_doorbell() API fails.
>
> - Mani
Hi Mani, Mayank

Checked drivers/accel/qaic/mhi_controller.c, the mhi_read_reg
callback of AIC100 does return -EIO if it reads out all'f.

Considering that pci_generic controller also needs to check for
invalid read value which is not fixed though. It's better to invoke
mhi_cntrl->runtime_put() and mhi_device_put() as error cleanups if
mhi_get_channel_doorbell returns error here.

Let me address all your comments and prepare next version patch.

Thanks,
Qiang
>

