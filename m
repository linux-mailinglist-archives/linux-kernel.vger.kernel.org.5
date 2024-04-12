Return-Path: <linux-kernel+bounces-142119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B4F8A27C2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1E81B23777
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EAD487B3;
	Fri, 12 Apr 2024 07:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iZ+mA8yv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ECB2C6BC;
	Fri, 12 Apr 2024 07:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712906025; cv=none; b=JEc3pj13bUbtrqh/goOjpteqzrgqv5nqdE5Edm95z+/Z8WLxlVE3WJxmhnoIMzGRKfGLD1I7zdvRC+cqoyI8OpcNcMB3ZB+iEQGPXpzmhlHxWENtEfczYI8hAIx7iyqS4A9Nwk9mAuhk30/PcmYILpc7RN7/FZ8y7+ZA+3kyGcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712906025; c=relaxed/simple;
	bh=joE+HXj7GJBgfzPopottSq6MzrS+VcO4ZwUOIJZe7x0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rLqt5GUmaLnsHQx3LOEJb0JD9Jk0SW2GUVWTEmChmJVsDDN6Llk31e8JvxUMjwZvhmVHWbjaLsuusoRsgEIEevq0aoEWRqjhj2McRzXeRoB5N4MYRicptLN6vDouXbBsSSRGgAdXB+eWscLWogLE46LBWEBKPT96+53CMz8B3qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iZ+mA8yv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43C3YsZl024490;
	Fri, 12 Apr 2024 07:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=d3c6/Etk7SE4ID4yKoUiKoDIkgCKTUnXsmF93wbHNvY=; b=iZ
	+mA8yvTt3wvOdO4QBJLmKKNxRBgYKCcu5fcLPF+JnT0sCuixC1oneUkTui5DuLIf
	zVJhtfQr0it30R8RlYnEiocHtdmZOYHUppxV8xlpJWn2DwZaUGYbB+/mfrUPhVD+
	DLU2ldv1MSxqJwVjCHAobmo2biCrKiNQRvhKmcaZ5Nb8rHNd2FHggBYlqIipQSa5
	7kOWIkJYiClNVjdYpDZl9M7YocNG1L332J6bYEt3ViPsnpdpkbsvaQeV9Qv+XDcK
	9tYxH14sOU0SHo1405lAG33znfcatNn42qvQFeLddQn9z4EZeKVUIdqr5GrZgc9p
	9teux7m5o+Q/kZL8JaLA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xer1trx5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 07:13:40 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43C7Dd3k003372
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 07:13:39 GMT
Received: from [10.239.29.179] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 12 Apr
 2024 00:13:35 -0700
Message-ID: <a901549e-c3ec-47b5-9523-a6342eca455f@quicinc.com>
Date: Fri, 12 Apr 2024 15:13:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] bus: mhi: host: pci_generic: Add edl callback to
 enter EDL
Content-Language: en-US
To: Jeffrey Hugo <quic_jhugo@quicinc.com>, <mani@kernel.org>
CC: <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <quic_mrana@quicinc.com>
References: <1712805329-46158-1-git-send-email-quic_qianyu@quicinc.com>
 <1712805329-46158-3-git-send-email-quic_qianyu@quicinc.com>
 <78de32be-7e3b-e7e9-61f3-9679993dbe71@quicinc.com>
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <78de32be-7e3b-e7e9-61f3-9679993dbe71@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4N69krg3lXuCURunoe73GIKYxrmrJe4S
X-Proofpoint-GUID: 4N69krg3lXuCURunoe73GIKYxrmrJe4S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_03,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120050


On 4/11/2024 10:46 PM, Jeffrey Hugo wrote:
> On 4/10/2024 9:15 PM, Qiang Yu wrote:
>> Add mhi_pci_generic_edl_trigger as edl_trigger for some devices (eg. 
>> SDX65)
>> to enter EDL mode by writing the 0xEDEDEDED cookie to the channel 91
>> doorbell register and forcing an SOC reset afterwards.
>>
>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>> ---
>>   drivers/bus/mhi/host/pci_generic.c | 50 
>> ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 50 insertions(+)
>>
>> diff --git a/drivers/bus/mhi/host/pci_generic.c 
>> b/drivers/bus/mhi/host/pci_generic.c
>> index 51639bf..a529815 100644
>> --- a/drivers/bus/mhi/host/pci_generic.c
>> +++ b/drivers/bus/mhi/host/pci_generic.c
>> @@ -27,12 +27,23 @@
>>   #define PCI_VENDOR_ID_THALES    0x1269
>>   #define PCI_VENDOR_ID_QUECTEL    0x1eac
>>   +#define MHI_EDL_DB            91
>> +#define MHI_EDL_COOKIE            0xEDEDEDED
>> +
>> +/* Device can enter EDL by first setting edl cookie then issuing 
>> inband reset*/
>> +#define MHI_PCI_GENERIC_EDL_TRIGGER    BIT(0)
>> +
>> +#define CHDBOFF            0x18
>
> This is already in drivers/bus/mhi/common.h why duplicate it here?

I only see common.h be included in ep/internal.h host/internal.h and
host/trace.h. So I thought it can only be used by MHI stack. Can we
include common.h in pci_generic.c?
>
>> +#define CHDBOFF_CHDBOFF_MASK 0xFFFFFFFF
>> +#define CHDBOFF_CHDBOFF_SHIFT    0
>> +
>>   /**
>>    * struct mhi_pci_dev_info - MHI PCI device specific information
>>    * @config: MHI controller configuration
>>    * @name: name of the PCI module
>>    * @fw: firmware path (if any)
>>    * @edl: emergency download mode firmware path (if any)
>> + * @edl_trigger: each bit represents a different way to enter EDL
>>    * @bar_num: PCI base address register to use for MHI MMIO register 
>> space
>>    * @dma_data_width: DMA transfer word size (32 or 64 bits)
>>    * @mru_default: default MRU size for MBIM network packets
>> @@ -44,6 +55,7 @@ struct mhi_pci_dev_info {
>>       const char *name;
>>       const char *fw;
>>       const char *edl;
>> +    unsigned int edl_trigger;
>>       unsigned int bar_num;
>>       unsigned int dma_data_width;
>>       unsigned int mru_default;
>> @@ -292,6 +304,7 @@ static const struct mhi_pci_dev_info 
>> mhi_qcom_sdx75_info = {
>>       .name = "qcom-sdx75m",
>>       .fw = "qcom/sdx75m/xbl.elf",
>>       .edl = "qcom/sdx75m/edl.mbn",
>> +    .edl_trigger = MHI_PCI_GENERIC_EDL_TRIGGER,
>>       .config = &modem_qcom_v2_mhiv_config,
>>       .bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>>       .dma_data_width = 32,
>> @@ -302,6 +315,7 @@ static const struct mhi_pci_dev_info 
>> mhi_qcom_sdx65_info = {
>>       .name = "qcom-sdx65m",
>>       .fw = "qcom/sdx65m/xbl.elf",
>>       .edl = "qcom/sdx65m/edl.mbn",
>> +    .edl_trigger = MHI_PCI_GENERIC_EDL_TRIGGER,
>>       .config = &modem_qcom_v1_mhiv_config,
>>       .bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>>       .dma_data_width = 32,
>> @@ -312,6 +326,7 @@ static const struct mhi_pci_dev_info 
>> mhi_qcom_sdx55_info = {
>>       .name = "qcom-sdx55m",
>>       .fw = "qcom/sdx55m/sbl1.mbn",
>>       .edl = "qcom/sdx55m/edl.mbn",
>> +    .edl_trigger = MHI_PCI_GENERIC_EDL_TRIGGER,
>>       .config = &modem_qcom_v1_mhiv_config,
>>       .bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>>       .dma_data_width = 32,
>> @@ -928,6 +943,38 @@ static void health_check(struct timer_list *t)
>>       mod_timer(&mhi_pdev->health_check_timer, jiffies + 
>> HEALTH_CHECK_PERIOD);
>>   }
>>   +static int mhi_pci_generic_edl_trigger(struct mhi_controller 
>> *mhi_cntrl)
>> +{
>> +    int ret;
>> +    u32 val;
>> +    void __iomem *edl_db;
>> +    void __iomem *base = mhi_cntrl->regs;
>
> It looks like this file follows reverse christmas tree, but this 
> function does not. you should fix it.

Will fix it in next version patch.
>
>> +
>> +    ret = mhi_device_get_sync(mhi_cntrl->mhi_dev);
>> +    if (ret) {
>> +        dev_err(mhi_cntrl->cntrl_dev, "Wake up device fail before 
>> trigger EDL\n");
>> +        return ret;
>> +    }
>> +
>> +    pm_wakeup_event(&mhi_cntrl->mhi_dev->dev, 0);
>> +    mhi_cntrl->runtime_get(mhi_cntrl);
>> +
>> +    mhi_cntrl->read_reg(mhi_cntrl, base + CHDBOFF, &val);
>> +    val = (val & CHDBOFF_CHDBOFF_MASK) >> CHDBOFF_CHDBOFF_SHIFT;
>> +
>> +    edl_db = base + val + (8 * MHI_EDL_DB);
>> +
>> +    mhi_cntrl->write_reg(mhi_cntrl, edl_db + 4, 
>> upper_32_bits(MHI_EDL_COOKIE));
>> +    mhi_cntrl->write_reg(mhi_cntrl, edl_db, 
>> lower_32_bits(MHI_EDL_COOKIE));
>> +
>> +    mhi_soc_reset(mhi_cntrl);
>> +
>> +    mhi_cntrl->runtime_put(mhi_cntrl);
>> +    mhi_device_put(mhi_cntrl->mhi_dev);
>> +
>> +    return 0;
>> +}
>> +
>>   static int mhi_pci_probe(struct pci_dev *pdev, const struct 
>> pci_device_id *id)
>>   {
>>       const struct mhi_pci_dev_info *info = (struct mhi_pci_dev_info 
>> *) id->driver_data;
>> @@ -962,6 +1009,9 @@ static int mhi_pci_probe(struct pci_dev *pdev, 
>> const struct pci_device_id *id)
>>       mhi_cntrl->runtime_put = mhi_pci_runtime_put;
>>       mhi_cntrl->mru = info->mru_default;
>>   +    if (info->edl_trigger & MHI_PCI_GENERIC_EDL_TRIGGER)
>> +        mhi_cntrl->edl_trigger = mhi_pci_generic_edl_trigger;
>> +
>>       if (info->sideband_wake) {
>>           mhi_cntrl->wake_get = mhi_pci_wake_get_nop;
>>           mhi_cntrl->wake_put = mhi_pci_wake_put_nop;
>

