Return-Path: <linux-kernel+bounces-147931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3FB8A7B7C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F056D1C20E88
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB78347C2;
	Wed, 17 Apr 2024 04:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Jng2FS+U"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E201170F;
	Wed, 17 Apr 2024 04:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713328894; cv=none; b=NbqPQwVYSedqMENK4vNwEH8hFjOgqdtog+/xIdQEziEF6MOq771+bZmUMqmL5rePlWjewj+rS7uxQ0r3omqIlkVhRUJEL/hogOkDrACGyF4ZES1OjNaMW9/JEEO5GemhBZa4yNa2HlgpavUHljR/3p/zXzTwPUX0fO8eqszo3Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713328894; c=relaxed/simple;
	bh=W6eiK073siLs3Dhkn6KCYqrHQLJ9GalouQB9X0qLonk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=QIHTIeyU/X+jTS54lZFjNfmP2boyYY0ImHb/wBKxzWozNiR6BS1Yx/hI2eb4xvk4x8BsWnJsW7lBz+s2/MfDuI6FfScMQsRC6ZZHDP3ylbCAbL0WQZ2drGXka2ZWte46UTVljUX1/TGd5KB6LM7F8A3KkKd19+BkrqVzNb5ZQPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Jng2FS+U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H4bdiq028011;
	Wed, 17 Apr 2024 04:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6A3onIqfMU8lt87SKZb/ALZNnvDW51YVsVZg4C+Ln4U=; b=Jn
	g2FS+UrQPNRXj41WCH9X5sQsGB8k/R6O6FBAVHmyoKMIM1GpuBBjfRzQ98Dqo9Zk
	zBQvO7NLMboqbgVt3JDebgaKMO8LADyJsIDmwBRmZLi1BIBjXt2MXNVwB9nuvnN6
	I8fxBfqLtz542txbx3Vq0fOYJgSkBfk4aSFY0gTcaMUWP4+e+AZTWB6C/uHd1PqN
	oFXkN8AyywKHKo5UHCd+PcaGz7rNa7HcuTwCcBwzjmRxx4UFUTo4Is6Q3VURnYLF
	Gg2t8QWTG6aKKalxfVtCh5CYCE4KKGLvJhxkVeNxKcqzk+WIi0BMX0lsHndvsGsB
	aX1aklsZob6ueDg89cSg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xj7j9009m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 04:41:30 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43H4fTjw026458
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 04:41:29 GMT
Received: from [10.239.29.179] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 16 Apr
 2024 21:41:27 -0700
Message-ID: <a5ea5263-8acb-48dd-a4e1-bc48a9bdf791@quicinc.com>
Date: Wed, 17 Apr 2024 12:41:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] bus: mhi: host: pci_generic: Add edl callback to
 enter EDL
From: Qiang Yu <quic_qianyu@quicinc.com>
To: Mayank Rana <quic_mrana@quicinc.com>, <mani@kernel.org>,
        <quic_jhugo@quicinc.com>
CC: <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>
References: <1713170945-44640-1-git-send-email-quic_qianyu@quicinc.com>
 <1713170945-44640-4-git-send-email-quic_qianyu@quicinc.com>
 <17d94b91-137c-409c-8af3-f32f1af2eb71@quicinc.com>
 <4b684db2-d384-404a-9c54-60d79ac7cf9f@quicinc.com>
 <adb9ab3d-0fd2-4afe-96d7-573b1822e0c3@quicinc.com>
 <ab27b383-dcbf-4337-b3ea-da91763e834a@quicinc.com>
Content-Language: en-US
In-Reply-To: <ab27b383-dcbf-4337-b3ea-da91763e834a@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 29iTKwriFGePSalv3J5LK2CSaUHtwiKT
X-Proofpoint-ORIG-GUID: 29iTKwriFGePSalv3J5LK2CSaUHtwiKT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_04,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404170029


On 4/17/2024 11:01 AM, Qiang Yu wrote:
>
> On 4/17/2024 2:12 AM, Mayank Rana wrote:
>>
>>
>> On 4/15/2024 8:50 PM, Qiang Yu wrote:
>>>
>>> On 4/16/2024 7:53 AM, Mayank Rana wrote:
>>>> Hi Qiang
>>>>
>>>> On 4/15/2024 1:49 AM, Qiang Yu wrote:
>>>>> Add mhi_pci_generic_edl_trigger as edl_trigger for some devices 
>>>>> (eg. SDX65)
>>>>> to enter EDL mode by writing the 0xEDEDEDED cookie to the channel 91
>>>>> doorbell register and forcing an SOC reset afterwards.
>>>>>
>>>>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>>>>> ---
>>>>>   drivers/bus/mhi/host/pci_generic.c | 47 
>>>>> ++++++++++++++++++++++++++++++++++++++
>>>>>   1 file changed, 47 insertions(+)
>>>>>
>>>>> diff --git a/drivers/bus/mhi/host/pci_generic.c 
>>>>> b/drivers/bus/mhi/host/pci_generic.c
>>>>> index 51639bf..cbf8a58 100644
>>>>> --- a/drivers/bus/mhi/host/pci_generic.c
>>>>> +++ b/drivers/bus/mhi/host/pci_generic.c
>>>>> @@ -27,12 +27,19 @@
>>>>>   #define PCI_VENDOR_ID_THALES    0x1269
>>>>>   #define PCI_VENDOR_ID_QUECTEL    0x1eac
>>>>>   +#define MHI_EDL_DB            91
>>>>> +#define MHI_EDL_COOKIE            0xEDEDEDED
>>>>> +
>>>>> +/* Device can enter EDL by first setting edl cookie then issuing 
>>>>> inband reset*/
>>>>> +#define MHI_PCI_GENERIC_EDL_TRIGGER    BIT(0)
>>>>> +
>>>>>   /**
>>>>>    * struct mhi_pci_dev_info - MHI PCI device specific information
>>>>>    * @config: MHI controller configuration
>>>>>    * @name: name of the PCI module
>>>>>    * @fw: firmware path (if any)
>>>>>    * @edl: emergency download mode firmware path (if any)
>>>>> + * @edl_trigger: each bit represents a different way to enter EDL
>>>>>    * @bar_num: PCI base address register to use for MHI MMIO 
>>>>> register space
>>>>>    * @dma_data_width: DMA transfer word size (32 or 64 bits)
>>>>>    * @mru_default: default MRU size for MBIM network packets
>>>>> @@ -44,6 +51,7 @@ struct mhi_pci_dev_info {
>>>>>       const char *name;
>>>>>       const char *fw;
>>>>>       const char *edl;
>>>>> +    unsigned int edl_trigger;
>>>>>       unsigned int bar_num;
>>>>>       unsigned int dma_data_width;
>>>>>       unsigned int mru_default;
>>>>> @@ -292,6 +300,7 @@ static const struct mhi_pci_dev_info 
>>>>> mhi_qcom_sdx75_info = {
>>>>>       .name = "qcom-sdx75m",
>>>>>       .fw = "qcom/sdx75m/xbl.elf",
>>>>>       .edl = "qcom/sdx75m/edl.mbn",
>>>>> +    .edl_trigger = MHI_PCI_GENERIC_EDL_TRIGGER,
>>>>>       .config = &modem_qcom_v2_mhiv_config,
>>>>>       .bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>>>>>       .dma_data_width = 32,
>>>>> @@ -302,6 +311,7 @@ static const struct mhi_pci_dev_info 
>>>>> mhi_qcom_sdx65_info = {
>>>>>       .name = "qcom-sdx65m",
>>>>>       .fw = "qcom/sdx65m/xbl.elf",
>>>>>       .edl = "qcom/sdx65m/edl.mbn",
>>>>> +    .edl_trigger = MHI_PCI_GENERIC_EDL_TRIGGER,
>>>>>       .config = &modem_qcom_v1_mhiv_config,
>>>>>       .bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>>>>>       .dma_data_width = 32,
>>>>> @@ -312,6 +322,7 @@ static const struct mhi_pci_dev_info 
>>>>> mhi_qcom_sdx55_info = {
>>>>>       .name = "qcom-sdx55m",
>>>>>       .fw = "qcom/sdx55m/sbl1.mbn",
>>>>>       .edl = "qcom/sdx55m/edl.mbn",
>>>>> +    .edl_trigger = MHI_PCI_GENERIC_EDL_TRIGGER,
>>>>>       .config = &modem_qcom_v1_mhiv_config,
>>>>>       .bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>>>>>       .dma_data_width = 32,
>>>>> @@ -928,6 +939,39 @@ static void health_check(struct timer_list *t)
>>>>>       mod_timer(&mhi_pdev->health_check_timer, jiffies + 
>>>>> HEALTH_CHECK_PERIOD);
>>>>>   }
>>>>>   +static int mhi_pci_generic_edl_trigger(struct mhi_controller 
>>>>> *mhi_cntrl)
>>>>> +{
>>>>> +    void __iomem *base = mhi_cntrl->regs;
>>>>> +    void __iomem *edl_db;
>>>>> +    int ret;
>>>>> +    u32 val;
>>>>> +
>>>>> +    ret = mhi_device_get_sync(mhi_cntrl->mhi_dev);
>>>>> +    if (ret) {
>>>>> +        dev_err(mhi_cntrl->cntrl_dev, "Wake up device fail before 
>>>>> trigger EDL\n");
>>>>> +        return ret;
>>>>> +    }
>>>>> +
>>>>> +    pm_wakeup_event(&mhi_cntrl->mhi_dev->dev, 0);
>>>>> +    mhi_cntrl->runtime_get(mhi_cntrl);
>>>>> +
>>>>> +    ret = mhi_get_channel_doorbell(mhi_cntrl, &val);
>>>>> +    if (ret)
>>>>> +        return ret;
>>>> Don't we need error handling part here i.e. calling 
>>>> mhi_cntrl->runtime_put() as well mhi_device_put() ?
>>>
>>> Hi Mayank
>>>
>>> After soc_reset, device will reboot to EDL mode and MHI state will 
>>> be SYSERR. So host will fail to suspend
>>> anyway. The "error handling" we need here is actually to enter EDL 
>>> mode, this will be done by SYSERR irq.
>>> Here, mhi_cntrl->runtime_put() and mhi_device_put() are only to 
>>> balance mhi_cntrl->runtime_get() and
>>> mhi_device_get_sync().
>>>
>>> Thanks,
>>> Qiang
>> I am saying is there possibility that mhi_get_channel_doorbell() 
>> returns error ?
>> If yes, then why don't we need error handling as part of it. you are 
>> exiting if this API return error without doing anything.
>
> I think here mhi_get_channel_doorbell will not return error. But I still
> add a error checking because it invoked mhi_read_reg, which is a must 
> check
> API. For modem mhi controller, this API eventually does a memory read.
> This memory read will return a normal value if link is up and all f's 
> if link
> is bad.
>
> Thanks,
> Qiang

Actually, mhi_get_channel_doorbell should also be used in mhi_init_mmio to
replace the getting chdb operation by invoking mhi_read_reg as Mani 
commented.
In mhi_init_mmio, we invoke mhi_read_reg many times, but there is also not
additionnal error handling.

I'm not very sure the reason but perhaps if mhi_read_reg returns error 
(I don't
know which controller will provide a memory read callback returning 
errors), most
probably something is wrong in PCIe, which is not predictable by MHI and 
we can
not add err handling every time invoking mhi_read_reg. But we have a 
timer to
do health_check in pci_generic.c. If link is down, we will do 
pci_function_reset
to try to reovery.

Hi Mani, sorry, may I know the purpose of adding must_check attribute to
mhi_read_reg? In which case will mhi controller provide a callback that
returns error?

Thanks,
Qiang
>>>>> +    edl_db = base + val + (8 * MHI_EDL_DB);
>>>>> +
>>>>> +    mhi_cntrl->write_reg(mhi_cntrl, edl_db + 4, 
>>>>> upper_32_bits(MHI_EDL_COOKIE));
>>>>> +    mhi_cntrl->write_reg(mhi_cntrl, edl_db, 
>>>>> lower_32_bits(MHI_EDL_COOKIE));
>>>>> +
>>>>> +    mhi_soc_reset(mhi_cntrl);
>>>>> +
>>>>> +    mhi_cntrl->runtime_put(mhi_cntrl);
>>>>> +    mhi_device_put(mhi_cntrl->mhi_dev);
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>>   static int mhi_pci_probe(struct pci_dev *pdev, const struct 
>>>>> pci_device_id *id)
>>>>>   {
>>>>>       const struct mhi_pci_dev_info *info = (struct 
>>>>> mhi_pci_dev_info *) id->driver_data;
>>>>> @@ -962,6 +1006,9 @@ static int mhi_pci_probe(struct pci_dev 
>>>>> *pdev, const struct pci_device_id *id)
>>>>>       mhi_cntrl->runtime_put = mhi_pci_runtime_put;
>>>>>       mhi_cntrl->mru = info->mru_default;
>>>>>   +    if (info->edl_trigger & MHI_PCI_GENERIC_EDL_TRIGGER)
>>>>> +        mhi_cntrl->edl_trigger = mhi_pci_generic_edl_trigger;
>>>>> +
>>>>>       if (info->sideband_wake) {
>>>>>           mhi_cntrl->wake_get = mhi_pci_wake_get_nop;
>>>>>           mhi_cntrl->wake_put = mhi_pci_wake_put_nop;
>>>> Regards,
>>>> Mayank
>

