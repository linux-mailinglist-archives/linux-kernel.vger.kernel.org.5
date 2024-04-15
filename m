Return-Path: <linux-kernel+bounces-146021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADBC8A5EE4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D3A228259B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A7C15957B;
	Mon, 15 Apr 2024 23:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nLxVQeqZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDCE158DB0;
	Mon, 15 Apr 2024 23:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713225207; cv=none; b=iJOOvX93Dz9eMV/6kA0E8Vc6jJlJH/SGz82bHXCVEzCOb/jpjQML1EN0QAFFbwl56ftUpccgZcR/bUIOoiGHjXJy5c3F3YvvG2KCL5I+jKSR4SjxKEU9j1BMMJUbDXzorpM5Qbh1Qi3wEd/VQIH6+8MLkle7nXXLPlzoPtZxqjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713225207; c=relaxed/simple;
	bh=WgD36PwR0sisAA5FgF066eQVYd4JFH0754tbz2XbG+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rpjvcIuefTsOpf7op2dNyQEeVIWxBOCVAk4sIq7sy/bAkBps6VsTHOPxEyr6i7DPULaBZFarRT1KIAxHt7MFt4c/YNal+pUleDsIr0M5TuJ8vG9v8Ommp8gNEtXHg5jEzAUCfJOFR1EOWvIFBwzYJ6R7t9W1aYO5EQS+DRcpPB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nLxVQeqZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43FNqewu014447;
	Mon, 15 Apr 2024 23:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=bwGaO3Rx6cfYFQS6En9h1Fa48km9Nz8uNkkTdYb1Q08=; b=nL
	xVQeqZq9v9GvIJdbgUw2dMXdKOdPb9lNc7D/63BtnbzA6rx4xHvQ6/C20Qaffa7H
	6oO9PiFQs9EvTf5QIhH/YDDYQ7jOXbkU89n2WyVZn/J0/aekc4M+BJKSwqA/wMrh
	Nwb5fHMQbt8lOw2QYTF5gUAr5Hy/FpJHOsrqII9VisrEXklKty+UNIJaXtGVDv5Y
	NYxq96deIgdYfh30tcdRztcRqsqF3t0XG5YQ1K2DAO7/6ta3e8Gaka+M9HdRHmtv
	lSqrvzwbeX461AWnNQMlF8qlRu0iS8GBl07nsyxewlTHLjTwUnrgmVXUZn0Cival
	6LJC8b14o+ncXw2iLIhg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xhbbur9vb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 23:53:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43FNrNbH014432
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 23:53:23 GMT
Received: from [10.110.122.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Apr
 2024 16:53:22 -0700
Message-ID: <17d94b91-137c-409c-8af3-f32f1af2eb71@quicinc.com>
Date: Mon, 15 Apr 2024 16:53:22 -0700
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
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <1713170945-44640-4-git-send-email-quic_qianyu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _D4g86e4Hg1XalZizanuCOglWrxjvc1q
X-Proofpoint-GUID: _D4g86e4Hg1XalZizanuCOglWrxjvc1q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_19,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404150160

Hi Qiang

On 4/15/2024 1:49 AM, Qiang Yu wrote:
> Add mhi_pci_generic_edl_trigger as edl_trigger for some devices (eg. SDX65)
> to enter EDL mode by writing the 0xEDEDEDED cookie to the channel 91
> doorbell register and forcing an SOC reset afterwards.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>   drivers/bus/mhi/host/pci_generic.c | 47 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 47 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 51639bf..cbf8a58 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -27,12 +27,19 @@
>   #define PCI_VENDOR_ID_THALES	0x1269
>   #define PCI_VENDOR_ID_QUECTEL	0x1eac
>   
> +#define MHI_EDL_DB			91
> +#define MHI_EDL_COOKIE			0xEDEDEDED
> +
> +/* Device can enter EDL by first setting edl cookie then issuing inband reset*/
> +#define MHI_PCI_GENERIC_EDL_TRIGGER	BIT(0)
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
> @@ -44,6 +51,7 @@ struct mhi_pci_dev_info {
>   	const char *name;
>   	const char *fw;
>   	const char *edl;
> +	unsigned int edl_trigger;
>   	unsigned int bar_num;
>   	unsigned int dma_data_width;
>   	unsigned int mru_default;
> @@ -292,6 +300,7 @@ static const struct mhi_pci_dev_info mhi_qcom_sdx75_info = {
>   	.name = "qcom-sdx75m",
>   	.fw = "qcom/sdx75m/xbl.elf",
>   	.edl = "qcom/sdx75m/edl.mbn",
> +	.edl_trigger = MHI_PCI_GENERIC_EDL_TRIGGER,
>   	.config = &modem_qcom_v2_mhiv_config,
>   	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>   	.dma_data_width = 32,
> @@ -302,6 +311,7 @@ static const struct mhi_pci_dev_info mhi_qcom_sdx65_info = {
>   	.name = "qcom-sdx65m",
>   	.fw = "qcom/sdx65m/xbl.elf",
>   	.edl = "qcom/sdx65m/edl.mbn",
> +	.edl_trigger = MHI_PCI_GENERIC_EDL_TRIGGER,
>   	.config = &modem_qcom_v1_mhiv_config,
>   	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>   	.dma_data_width = 32,
> @@ -312,6 +322,7 @@ static const struct mhi_pci_dev_info mhi_qcom_sdx55_info = {
>   	.name = "qcom-sdx55m",
>   	.fw = "qcom/sdx55m/sbl1.mbn",
>   	.edl = "qcom/sdx55m/edl.mbn",
> +	.edl_trigger = MHI_PCI_GENERIC_EDL_TRIGGER,
>   	.config = &modem_qcom_v1_mhiv_config,
>   	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>   	.dma_data_width = 32,
> @@ -928,6 +939,39 @@ static void health_check(struct timer_list *t)
>   	mod_timer(&mhi_pdev->health_check_timer, jiffies + HEALTH_CHECK_PERIOD);
>   }
>   
> +static int mhi_pci_generic_edl_trigger(struct mhi_controller *mhi_cntrl)
> +{
> +	void __iomem *base = mhi_cntrl->regs;
> +	void __iomem *edl_db;
> +	int ret;
> +	u32 val;
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
> +	ret = mhi_get_channel_doorbell(mhi_cntrl, &val);
> +	if (ret)
> +		return ret;
Don't we need error handling part here i.e. calling 
mhi_cntrl->runtime_put() as well mhi_device_put() ?
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
> @@ -962,6 +1006,9 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	mhi_cntrl->runtime_put = mhi_pci_runtime_put;
>   	mhi_cntrl->mru = info->mru_default;
>   
> +	if (info->edl_trigger & MHI_PCI_GENERIC_EDL_TRIGGER)
> +		mhi_cntrl->edl_trigger = mhi_pci_generic_edl_trigger;
> +
>   	if (info->sideband_wake) {
>   		mhi_cntrl->wake_get = mhi_pci_wake_get_nop;
>   		mhi_cntrl->wake_put = mhi_pci_wake_put_nop;
Regards,
Mayank

