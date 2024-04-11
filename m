Return-Path: <linux-kernel+bounces-140688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0C08A17C1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED2321C22727
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37788DDDC;
	Thu, 11 Apr 2024 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LQDtuVrj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D267D529;
	Thu, 11 Apr 2024 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846784; cv=none; b=m0BnyszCvudG6CK1qRC/IUTP/8WvL8cDr1+GjVvhYGZWHLsFKj/ML0B9vsFGigkuEekPUFj8MYacmEF4/ZqFnEcTYQl4Zax3mKmtJwdBtkt6fAUSdov8Xdtx1JMmDnGOSPnGWwmP8eVaiwk3VDlyoQmVyGzXpwCSor9j/lG3lhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846784; c=relaxed/simple;
	bh=WOsfYlx/Hwa8Lsmj956+sM4HTD3hGnqHfcAoqJR9+zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N1W8nJhdgGWpcqniSY8MCuiYbxcavu6k47UHIxjiwPcJdTEdj7LRMg6jfoBj2fsXVrHAXbYHRaFpFvVvafInl2zbPBrJmJzQyAoHJHDKC3/3oDc8SEJATcDzjpf6PIMkoy2C68Ir6qhpvDlVgmlANVXO2L8L43+uDsaEXu1IxBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LQDtuVrj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43BDw8xi018489;
	Thu, 11 Apr 2024 14:46:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=A/oAT/wNDEmcZmpWTKzBi87UUHvcOVZ5gW5oGv6Ix1k=; b=LQ
	DtuVrjhHO3o51L80DrYPItcEfvXePoFjknySqL9FSmvWRG3RoLNCoxtyFuANTCKI
	q6/kJLdzx/bX9lWjiNApmTl7VlTkWqM84rp5EBOj/8sSpsdTKQMts6TOpwsgtd6N
	DrAtlWJoRlb09Q7zxcRuk0g+t1DgJhVo8Uj7RkX5Cm+OgBP4G7RdSVrTrayy5Cni
	xm1msJcScBqvWtGhRsH/1O6WHOalCoeuzx2URDPYWDJ6ABvY6XM+s5aj3anKvdZf
	R3w5jVf2WwQZVy2jph37tbRAVGxDZf0VM/XcdcinTG8wEjylyJ/pzvSLwQx4MCki
	+6bB9FLPfnjRZcXsBr5A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xe5ehu2e9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 14:46:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43BEkGs4024437
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 14:46:16 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 11 Apr
 2024 07:46:15 -0700
Message-ID: <78de32be-7e3b-e7e9-61f3-9679993dbe71@quicinc.com>
Date: Thu, 11 Apr 2024 08:46:15 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 2/2] bus: mhi: host: pci_generic: Add edl callback to
 enter EDL
Content-Language: en-US
To: Qiang Yu <quic_qianyu@quicinc.com>, <mani@kernel.org>
CC: <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <quic_mrana@quicinc.com>
References: <1712805329-46158-1-git-send-email-quic_qianyu@quicinc.com>
 <1712805329-46158-3-git-send-email-quic_qianyu@quicinc.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <1712805329-46158-3-git-send-email-quic_qianyu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Zb4i8FTTj8nf5loz6u61n6neptFjabZT
X-Proofpoint-ORIG-GUID: Zb4i8FTTj8nf5loz6u61n6neptFjabZT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404110108

On 4/10/2024 9:15 PM, Qiang Yu wrote:
> Add mhi_pci_generic_edl_trigger as edl_trigger for some devices (eg. SDX65)
> to enter EDL mode by writing the 0xEDEDEDED cookie to the channel 91
> doorbell register and forcing an SOC reset afterwards.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>   drivers/bus/mhi/host/pci_generic.c | 50 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 50 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 51639bf..a529815 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -27,12 +27,23 @@
>   #define PCI_VENDOR_ID_THALES	0x1269
>   #define PCI_VENDOR_ID_QUECTEL	0x1eac
>   
> +#define MHI_EDL_DB			91
> +#define MHI_EDL_COOKIE			0xEDEDEDED
> +
> +/* Device can enter EDL by first setting edl cookie then issuing inband reset*/
> +#define MHI_PCI_GENERIC_EDL_TRIGGER	BIT(0)
> +
> +#define CHDBOFF			0x18

This is already in drivers/bus/mhi/common.h why duplicate it here?

> +#define CHDBOFF_CHDBOFF_MASK	0xFFFFFFFF
> +#define CHDBOFF_CHDBOFF_SHIFT	0
> +
>   /**
>    * struct mhi_pci_dev_info - MHI PCI device specific information
>    * @config: MHI controller configuration
>    * @name: name of the PCI module
>    * @fw: firmware path (if any)
>    * @edl: emergency download mode firmware path (if any)
> + * @edl_trigger: each bit represents a different way to enter EDL
>    * @bar_num: PCI base address register to use for MHI MMIO register space
>    * @dma_data_width: DMA transfer word size (32 or 64 bits)
>    * @mru_default: default MRU size for MBIM network packets
> @@ -44,6 +55,7 @@ struct mhi_pci_dev_info {
>   	const char *name;
>   	const char *fw;
>   	const char *edl;
> +	unsigned int edl_trigger;
>   	unsigned int bar_num;
>   	unsigned int dma_data_width;
>   	unsigned int mru_default;
> @@ -292,6 +304,7 @@ static const struct mhi_pci_dev_info mhi_qcom_sdx75_info = {
>   	.name = "qcom-sdx75m",
>   	.fw = "qcom/sdx75m/xbl.elf",
>   	.edl = "qcom/sdx75m/edl.mbn",
> +	.edl_trigger = MHI_PCI_GENERIC_EDL_TRIGGER,
>   	.config = &modem_qcom_v2_mhiv_config,
>   	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>   	.dma_data_width = 32,
> @@ -302,6 +315,7 @@ static const struct mhi_pci_dev_info mhi_qcom_sdx65_info = {
>   	.name = "qcom-sdx65m",
>   	.fw = "qcom/sdx65m/xbl.elf",
>   	.edl = "qcom/sdx65m/edl.mbn",
> +	.edl_trigger = MHI_PCI_GENERIC_EDL_TRIGGER,
>   	.config = &modem_qcom_v1_mhiv_config,
>   	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>   	.dma_data_width = 32,
> @@ -312,6 +326,7 @@ static const struct mhi_pci_dev_info mhi_qcom_sdx55_info = {
>   	.name = "qcom-sdx55m",
>   	.fw = "qcom/sdx55m/sbl1.mbn",
>   	.edl = "qcom/sdx55m/edl.mbn",
> +	.edl_trigger = MHI_PCI_GENERIC_EDL_TRIGGER,
>   	.config = &modem_qcom_v1_mhiv_config,
>   	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>   	.dma_data_width = 32,
> @@ -928,6 +943,38 @@ static void health_check(struct timer_list *t)
>   	mod_timer(&mhi_pdev->health_check_timer, jiffies + HEALTH_CHECK_PERIOD);
>   }
>   
> +static int mhi_pci_generic_edl_trigger(struct mhi_controller *mhi_cntrl)
> +{
> +	int ret;
> +	u32 val;
> +	void __iomem *edl_db;
> +	void __iomem *base = mhi_cntrl->regs;

It looks like this file follows reverse christmas tree, but this 
function does not. you should fix it.

> +
> +	ret = mhi_device_get_sync(mhi_cntrl->mhi_dev);
> +	if (ret) {
> +		dev_err(mhi_cntrl->cntrl_dev, "Wake up device fail before trigger EDL\n");
> +		return ret;
> +	}
> +
> +	pm_wakeup_event(&mhi_cntrl->mhi_dev->dev, 0);
> +	mhi_cntrl->runtime_get(mhi_cntrl);
> +
> +	mhi_cntrl->read_reg(mhi_cntrl, base + CHDBOFF, &val);
> +	val = (val & CHDBOFF_CHDBOFF_MASK) >> CHDBOFF_CHDBOFF_SHIFT;
> +
> +	edl_db = base + val + (8 * MHI_EDL_DB);
> +
> +	mhi_cntrl->write_reg(mhi_cntrl, edl_db + 4, upper_32_bits(MHI_EDL_COOKIE));
> +	mhi_cntrl->write_reg(mhi_cntrl, edl_db, lower_32_bits(MHI_EDL_COOKIE));
> +
> +	mhi_soc_reset(mhi_cntrl);
> +
> +	mhi_cntrl->runtime_put(mhi_cntrl);
> +	mhi_device_put(mhi_cntrl->mhi_dev);
> +
> +	return 0;
> +}
> +
>   static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   {
>   	const struct mhi_pci_dev_info *info = (struct mhi_pci_dev_info *) id->driver_data;
> @@ -962,6 +1009,9 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	mhi_cntrl->runtime_put = mhi_pci_runtime_put;
>   	mhi_cntrl->mru = info->mru_default;
>   
> +	if (info->edl_trigger & MHI_PCI_GENERIC_EDL_TRIGGER)
> +		mhi_cntrl->edl_trigger = mhi_pci_generic_edl_trigger;
> +
>   	if (info->sideband_wake) {
>   		mhi_cntrl->wake_get = mhi_pci_wake_get_nop;
>   		mhi_cntrl->wake_put = mhi_pci_wake_put_nop;


