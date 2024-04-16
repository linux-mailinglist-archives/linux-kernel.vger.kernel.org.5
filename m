Return-Path: <linux-kernel+bounces-147356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E21BA8A72DD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B6E1F223EE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBDE136664;
	Tue, 16 Apr 2024 18:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IeTXk+Z7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8504134435;
	Tue, 16 Apr 2024 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713291137; cv=none; b=C+mHonjv7AsklBFDDWiY9aHSshF/vJ3cNeJ3SGp+WLgh/KiNxdgyvKg7SS52QrGiQo7+wJ7StgNWg4EZtovx6sFT0kTjpfF7gqznsEDR6u3eEyMHwDw2G3dQBybF8Iv3i7HlJ5KaUgLYFj2A4lL2i9VVM5h6Sg9ESXQnB1BXpSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713291137; c=relaxed/simple;
	bh=Vmw4aEQZNgF1MZK5diVS7D95NUEyNcPU6RgyKHjzLoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WcT2MGyW8keDhxcjNQoRg+8KP1YnXcsFVZVU5MlUrqsyBFFVOYX+5ztASkSH0Dd0izfmS0xiWY9w1RjjOe93HVpF2ES7TRNcL7H71kZZsoRqfuxy3pASf49dNEQunY9x6DMPoRjI4fx1uTawc5FhdhdnBBOd7KpSQtROZiwxgy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IeTXk+Z7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43GD66PV000532;
	Tue, 16 Apr 2024 18:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=qivhKUQzvzA991+4YJXxICyKrQ8l43Yn9blU0XnTCiU=; b=Ie
	TXk+Z7UlzjaeSzA5Qq8iwCDFopCT9i8dfixS7lOYRU2kfoCm3ad100Ty+W14hBjf
	LTCi4QRv54DqTnJld6bGuja0zPWhkeBgaM17Pnb8F23bDsofDA8WKW4wmp4LwxI6
	ZyyOAP6wdGBJ8nLF8H6wN/VG6Yr0QqjS91ZUiq7IIo9HXIVwsxh1z/nNXft7/YC+
	6FJiedF6quFVQKFp3TIdo1oLXBVVQtX0156o+oJaUPnuMZH+cozzslBQHmK6IK1Z
	sUAGyqrEicb6EgqO6R/05e4trOeFI0wOw+ZJP03g2QDaLZtT37WyGQO0IjkRrRc/
	phErLKK71TUXcGXNzqeA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xhswvrxqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 18:12:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43GIC4xx016500
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 18:12:04 GMT
Received: from [10.110.122.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 16 Apr
 2024 11:12:04 -0700
Message-ID: <adb9ab3d-0fd2-4afe-96d7-573b1822e0c3@quicinc.com>
Date: Tue, 16 Apr 2024 11:12:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] bus: mhi: host: pci_generic: Add edl callback to
 enter EDL
Content-Language: en-US
To: Qiang Yu <quic_qianyu@quicinc.com>, <mani@kernel.org>,
        <quic_jhugo@quicinc.com>
CC: <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>
References: <1713170945-44640-1-git-send-email-quic_qianyu@quicinc.com>
 <1713170945-44640-4-git-send-email-quic_qianyu@quicinc.com>
 <17d94b91-137c-409c-8af3-f32f1af2eb71@quicinc.com>
 <4b684db2-d384-404a-9c54-60d79ac7cf9f@quicinc.com>
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <4b684db2-d384-404a-9c54-60d79ac7cf9f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NqJhOr7DK6bGdMRmD-1rvF-YCgtBLaeB
X-Proofpoint-ORIG-GUID: NqJhOr7DK6bGdMRmD-1rvF-YCgtBLaeB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_16,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404160113



On 4/15/2024 8:50 PM, Qiang Yu wrote:
> 
> On 4/16/2024 7:53 AM, Mayank Rana wrote:
>> Hi Qiang
>>
>> On 4/15/2024 1:49 AM, Qiang Yu wrote:
>>> Add mhi_pci_generic_edl_trigger as edl_trigger for some devices (eg. 
>>> SDX65)
>>> to enter EDL mode by writing the 0xEDEDEDED cookie to the channel 91
>>> doorbell register and forcing an SOC reset afterwards.
>>>
>>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>>> ---
>>>   drivers/bus/mhi/host/pci_generic.c | 47 
>>> ++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 47 insertions(+)
>>>
>>> diff --git a/drivers/bus/mhi/host/pci_generic.c 
>>> b/drivers/bus/mhi/host/pci_generic.c
>>> index 51639bf..cbf8a58 100644
>>> --- a/drivers/bus/mhi/host/pci_generic.c
>>> +++ b/drivers/bus/mhi/host/pci_generic.c
>>> @@ -27,12 +27,19 @@
>>>   #define PCI_VENDOR_ID_THALES    0x1269
>>>   #define PCI_VENDOR_ID_QUECTEL    0x1eac
>>>   +#define MHI_EDL_DB            91
>>> +#define MHI_EDL_COOKIE            0xEDEDEDED
>>> +
>>> +/* Device can enter EDL by first setting edl cookie then issuing 
>>> inband reset*/
>>> +#define MHI_PCI_GENERIC_EDL_TRIGGER    BIT(0)
>>> +
>>>   /**
>>>    * struct mhi_pci_dev_info - MHI PCI device specific information
>>>    * @config: MHI controller configuration
>>>    * @name: name of the PCI module
>>>    * @fw: firmware path (if any)
>>>    * @edl: emergency download mode firmware path (if any)
>>> + * @edl_trigger: each bit represents a different way to enter EDL
>>>    * @bar_num: PCI base address register to use for MHI MMIO register 
>>> space
>>>    * @dma_data_width: DMA transfer word size (32 or 64 bits)
>>>    * @mru_default: default MRU size for MBIM network packets
>>> @@ -44,6 +51,7 @@ struct mhi_pci_dev_info {
>>>       const char *name;
>>>       const char *fw;
>>>       const char *edl;
>>> +    unsigned int edl_trigger;
>>>       unsigned int bar_num;
>>>       unsigned int dma_data_width;
>>>       unsigned int mru_default;
>>> @@ -292,6 +300,7 @@ static const struct mhi_pci_dev_info 
>>> mhi_qcom_sdx75_info = {
>>>       .name = "qcom-sdx75m",
>>>       .fw = "qcom/sdx75m/xbl.elf",
>>>       .edl = "qcom/sdx75m/edl.mbn",
>>> +    .edl_trigger = MHI_PCI_GENERIC_EDL_TRIGGER,
>>>       .config = &modem_qcom_v2_mhiv_config,
>>>       .bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>>>       .dma_data_width = 32,
>>> @@ -302,6 +311,7 @@ static const struct mhi_pci_dev_info 
>>> mhi_qcom_sdx65_info = {
>>>       .name = "qcom-sdx65m",
>>>       .fw = "qcom/sdx65m/xbl.elf",
>>>       .edl = "qcom/sdx65m/edl.mbn",
>>> +    .edl_trigger = MHI_PCI_GENERIC_EDL_TRIGGER,
>>>       .config = &modem_qcom_v1_mhiv_config,
>>>       .bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>>>       .dma_data_width = 32,
>>> @@ -312,6 +322,7 @@ static const struct mhi_pci_dev_info 
>>> mhi_qcom_sdx55_info = {
>>>       .name = "qcom-sdx55m",
>>>       .fw = "qcom/sdx55m/sbl1.mbn",
>>>       .edl = "qcom/sdx55m/edl.mbn",
>>> +    .edl_trigger = MHI_PCI_GENERIC_EDL_TRIGGER,
>>>       .config = &modem_qcom_v1_mhiv_config,
>>>       .bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>>>       .dma_data_width = 32,
>>> @@ -928,6 +939,39 @@ static void health_check(struct timer_list *t)
>>>       mod_timer(&mhi_pdev->health_check_timer, jiffies + 
>>> HEALTH_CHECK_PERIOD);
>>>   }
>>>   +static int mhi_pci_generic_edl_trigger(struct mhi_controller 
>>> *mhi_cntrl)
>>> +{
>>> +    void __iomem *base = mhi_cntrl->regs;
>>> +    void __iomem *edl_db;
>>> +    int ret;
>>> +    u32 val;
>>> +
>>> +    ret = mhi_device_get_sync(mhi_cntrl->mhi_dev);
>>> +    if (ret) {
>>> +        dev_err(mhi_cntrl->cntrl_dev, "Wake up device fail before 
>>> trigger EDL\n");
>>> +        return ret;
>>> +    }
>>> +
>>> +    pm_wakeup_event(&mhi_cntrl->mhi_dev->dev, 0);
>>> +    mhi_cntrl->runtime_get(mhi_cntrl);
>>> +
>>> +    ret = mhi_get_channel_doorbell(mhi_cntrl, &val);
>>> +    if (ret)
>>> +        return ret;
>> Don't we need error handling part here i.e. calling 
>> mhi_cntrl->runtime_put() as well mhi_device_put() ?
> 
> Hi Mayank
> 
> After soc_reset, device will reboot to EDL mode and MHI state will be 
> SYSERR. So host will fail to suspend
> anyway. The "error handling" we need here is actually to enter EDL mode, 
> this will be done by SYSERR irq.
> Here, mhi_cntrl->runtime_put() and mhi_device_put() are only to balance 
> mhi_cntrl->runtime_get() and
> mhi_device_get_sync().
> 
> Thanks,
> Qiang
I am saying is there possibility that mhi_get_channel_doorbell() returns 
error ?
If yes, then why don't we need error handling as part of it. you are 
exiting if this API return error without doing anything.
>>> +    edl_db = base + val + (8 * MHI_EDL_DB);
>>> +
>>> +    mhi_cntrl->write_reg(mhi_cntrl, edl_db + 4, 
>>> upper_32_bits(MHI_EDL_COOKIE));
>>> +    mhi_cntrl->write_reg(mhi_cntrl, edl_db, 
>>> lower_32_bits(MHI_EDL_COOKIE));
>>> +
>>> +    mhi_soc_reset(mhi_cntrl);
>>> +
>>> +    mhi_cntrl->runtime_put(mhi_cntrl);
>>> +    mhi_device_put(mhi_cntrl->mhi_dev);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   static int mhi_pci_probe(struct pci_dev *pdev, const struct 
>>> pci_device_id *id)
>>>   {
>>>       const struct mhi_pci_dev_info *info = (struct mhi_pci_dev_info 
>>> *) id->driver_data;
>>> @@ -962,6 +1006,9 @@ static int mhi_pci_probe(struct pci_dev *pdev, 
>>> const struct pci_device_id *id)
>>>       mhi_cntrl->runtime_put = mhi_pci_runtime_put;
>>>       mhi_cntrl->mru = info->mru_default;
>>>   +    if (info->edl_trigger & MHI_PCI_GENERIC_EDL_TRIGGER)
>>> +        mhi_cntrl->edl_trigger = mhi_pci_generic_edl_trigger;
>>> +
>>>       if (info->sideband_wake) {
>>>           mhi_cntrl->wake_get = mhi_pci_wake_get_nop;
>>>           mhi_cntrl->wake_put = mhi_pci_wake_put_nop;
>> Regards,
>> Mayank

