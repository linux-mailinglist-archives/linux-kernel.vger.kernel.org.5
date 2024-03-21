Return-Path: <linux-kernel+bounces-110633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6505B886184
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D09531F22277
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15547134CF7;
	Thu, 21 Mar 2024 20:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HfwItxjk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50A256B98;
	Thu, 21 Mar 2024 20:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711052025; cv=none; b=XymJZzjfpoB69q/FGhQd18+P1rg0iqKLQB4P6EkvSp1Raaz5VhfxgVrxOdjPFnutQOEyoeWwpo0ZNCf/Qi6hegPG+fuSqwJBCBlt3+LmbtP+30u1iVv2A2+yEld7uQZLgUlrCjju0bSccJmwzXQtiZRi0G56HHZieefZ1mRfX44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711052025; c=relaxed/simple;
	bh=eqUKP9nKLYxZuiUOsalWiTxNBZj6HiNViNXk0RyRG4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WdfuHaJSHVuVvcJfZ4ZwGPUhey2VVI0axorzYLII8wRzag1YOtDFugr2HqNDYlOgIX/6OBR2sf4s4HmIcRDQODrh0RXdgSsV2gJRn0RZR6wdG6PMHmW4Lo/WpGR9FpitFAnXkiCmyTgz4oLM5oA44ZZJSMCxE86Oh1kgPFd+rwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HfwItxjk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42LGDJKA022820;
	Thu, 21 Mar 2024 20:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=qHQSYFW6naq35ObVo+HdD6KvGE9suXXRxl4fx/GumlI=; b=Hf
	wItxjkLaI7Y9fjqrxhpnhlb0wDq2k42DfRlzDrCdJwRXaW07wE5YLw5BKMDFGyWW
	Df26pDosoxzBRaJ4pnZsb+Idtnk/06RLhwQFgu/D93wciihfNl54b5uYzAxvzdTD
	nPwlN/DK+LahUzbkMMZz14pZZyz3B1UnF9Fj/QqCtZe6+Znh18pa5fPG6pwrwARd
	+0fJPGiXavNrUU2vBoCe7Zk0rue1tpL+fuLI9rW+rfj9yjhTaahcGQtmBdAqenN6
	Wg285NlvZdO/XfvL+XT9u0sKtrnt42gCjH+6fVPYckqDdNvIcSq+yVWwLYViQinS
	Eq0nXEi+N3hVATJv+0/w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0r7q8hd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 20:13:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42LKDZNK008234
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 20:13:35 GMT
Received: from [10.110.74.135] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Mar
 2024 13:13:32 -0700
Message-ID: <d32f59cd-653c-4bd8-90b7-f6907da6d158@quicinc.com>
Date: Thu, 21 Mar 2024 13:13:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: workaround to use VMs
Content-Language: en-US
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, <kvalo@kernel.org>,
        <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "kernel@quicinc.com" <kernel@quicinc.com>
CC: <quic_bqiang@quicinc.com>
References: <20240321172402.346191-1-jtornosm@redhat.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240321172402.346191-1-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6FzYdFHB5veJmsqZS37PPOj2X1Phl9OR
X-Proofpoint-GUID: 6FzYdFHB5veJmsqZS37PPOj2X1Phl9OR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 clxscore=1011 mlxlogscore=999 suspectscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403140001
 definitions=main-2403210150

On 3/21/2024 10:23 AM, Jose Ignacio Tornos Martinez wrote:
> Currently, this driver is not working when the device is handled in a
> Virtual Machine (PCI pass-through), as it was already reported here:
> https://lore.kernel.org/all/fc6bd06f-d52b-4dee-ab1b-4bb845cc0b95@quicinc.com/T/
> Baochen Qiang focused the problem and described how to have it working
> for a specific real MSI vector from host that needs to be used in VM too.
> And this value, as it was commented, can change.
> 
> The problem seems complex to me and I don't know if there is any easy way
> to solve it. Meanwhile and using the information from Baochen Qiang,
> since the use of VMs is very interesting for testing procedures,
> I would like to just add this workaround that consists on adding a
> parameter to pass the real MSI vector from host to the VM. In that way,
> checking the 'lscpi' command output from host, it could be handled manually
> or with some user tool in order to have the VM with the driver working.
> Of course, if this parameter is not configured (zero value and default),
> we will have the same behavior as always.
> 
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
>  drivers/net/wireless/ath/ath11k/pci.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
> index be9d2c69cc41..0e322956b10f 100644
> --- a/drivers/net/wireless/ath/ath11k/pci.c
> +++ b/drivers/net/wireless/ath/ath11k/pci.c
> @@ -31,6 +31,11 @@
>  
>  #define TCSR_SOC_HW_SUB_VER	0x1910010
>  
> +static ulong ath11k_host_msi_addr = 0;
> +module_param_named(host_msi_addr, ath11k_host_msi_addr, ulong, 0644);
> +MODULE_PARM_DESC(host_msi_addr,
> +		 "Workaround to configure the MSI address that is used from host in order to be used in VM");
> +
>  static const struct pci_device_id ath11k_pci_id_table[] = {
>  	{ PCI_VDEVICE(QCOM, QCA6390_DEVICE_ID) },
>  	{ PCI_VDEVICE(QCOM, WCN6855_DEVICE_ID) },
> @@ -443,6 +448,18 @@ static int ath11k_pci_alloc_msi(struct ath11k_pci *ab_pci)
>  
>  	ath11k_pci_msi_disable(ab_pci);
>  
> +	if (ath11k_host_msi_addr) {
> +		ab_pci->ab->pci.msi.ep_base_data = 0;
> +		ab->pci.msi.addr_hi = (u32)(ath11k_host_msi_addr >> 32);
> +		ab->pci.msi.addr_lo = (u32)(ath11k_host_msi_addr & 0xffffffff);
> +
> +		ath11k_dbg(ab, ATH11K_DBG_PCI, "msi addr hi 0x%x lo 0x%x base data is %d\n",
> +			   ab->pci.msi.addr_hi,
> +			   ab->pci.msi.addr_lo,
> +			   ab->pci.msi.ep_base_data);
> +		return 0;
> +	}
> +
>  	msi_desc = irq_get_msi_desc(ab_pci->pdev->irq);
>  	if (!msi_desc) {
>  		ath11k_err(ab, "msi_desc is NULL!\n");
> @@ -482,6 +499,9 @@ static int ath11k_pci_config_msi_data(struct ath11k_pci *ab_pci)
>  {
>  	struct msi_desc *msi_desc;
>  
> +	if (ath11k_host_msi_addr)
> +		return 0;
> +
>  	msi_desc = irq_get_msi_desc(ab_pci->pdev->irq);
>  	if (!msi_desc) {
>  		ath11k_err(ab_pci->ab, "msi_desc is NULL!\n");

+ kernel@quicinc.com to make sure the Qualcomm VM experts are aware of this
issue and to see if they have any additional suggestions.



