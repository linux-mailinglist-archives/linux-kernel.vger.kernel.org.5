Return-Path: <linux-kernel+bounces-142326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 770668A2A3D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A817F1C210E6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7161F5A0E5;
	Fri, 12 Apr 2024 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="3q2TCxFt"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D24E53E14;
	Fri, 12 Apr 2024 08:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712912043; cv=none; b=rq+OHWrKHGBeCWtCCOU5P9IeVj/S2kO8o9DiET3gag2TtP2fkyuqLaU/ygrWmtSf++PTXPTqCCz2KGL+NjaaJ9AfNMNYYVWHyCSx7FJmPI0PXd5l/3kSGuRSppT6THO2g5ErpxiSoZUQ7Q0Ub5VAfybnLbnlQYsTwU138UcuhNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712912043; c=relaxed/simple;
	bh=3yjq8O1fvmVYBmCXtR/a8+GHrCslKZnP5yvQRyN6AnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TXZuyKyFV4YL1cNItJ02RSuf9dQ2PpoRXaVGSd7YEyvPYTfgrWxHmjMarabgma3i/J3gK1RBFwy2Wvvyl8FT8aefrzjoWLLmSIlUPS1TZBWlMzFc18W7O/XhGbtn6jMjGO1z2hra0tLY2p9xmIvD/hEMtIBQXAhH87LXCIPCjsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=3q2TCxFt; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43C8RL2t009700;
	Fri, 12 Apr 2024 10:53:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=WjFgtosidiIyq2Zmcjtu8dtER2lY9hSTMSWSMhZ3Xas=; b=3q
	2TCxFt8NbxX6zobRUXOLJRewuDgTt1BN3myoUYyhH9sDhS0f5EqUIsnxCc4vyRK1
	e5RnWZgq0T6Qxn4IHCk9Q+MqpzuHzkcy35F+6OhcfwpcL9GBACuzt3fXeVlruiya
	tuNV3dtKagQfB4J5uFWJmBEMxZmVMHmK3SFRcwpNoZmEsMVsboWDPnwQLIR5eCNZ
	LQJzJ6n0C9qg+jqZPOV6icC49jOXQbtm0Irqq8+tUGQ7Kn01yuReBSGF7KmJOuZY
	vSdcaNjGoHN4VcAZ1atP4hoJMmPn8NKIk2totehDNSByEPo4zuhwCgl/Vquf2eUx
	gUvLjF+/e0bMCUhSRSTQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xaw9d86vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 10:53:34 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 70A6D40044;
	Fri, 12 Apr 2024 10:53:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 80195210729;
	Fri, 12 Apr 2024 10:53:07 +0200 (CEST)
Received: from [10.48.86.69] (10.48.86.69) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 12 Apr
 2024 10:53:07 +0200
Message-ID: <abf316f7-f0c6-4eb3-aee2-fc5413d7c18b@foss.st.com>
Date: Fri, 12 Apr 2024 10:52:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bus: stm32_firewall: fix off by one in
 stm32_firewall_get_firewall()
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <17dce071-21ef-49f5-be45-f93bbf3642ec@moroto.mountain>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <17dce071-21ef-49f5-be45-f93bbf3642ec@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_05,2024-04-09_01,2023-05-22_02

Hi Dan,

On 4/12/24 10:25, Dan Carpenter wrote:
> The "nb_firewall" variable is the number of elements in the firewall[]
> array, which is allocated in stm32_firewall_populate_bus().  So change
> this > comparison to >= to prevent an out of bound access.
> 
> Fixes: 5c9668cfc6d7 ("firewall: introduce stm32_firewall framework")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/bus/stm32_firewall.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/stm32_firewall.c b/drivers/bus/stm32_firewall.c
> index decb79449047..2fc9761dadec 100644
> --- a/drivers/bus/stm32_firewall.c
> +++ b/drivers/bus/stm32_firewall.c
> @@ -53,7 +53,7 @@ int stm32_firewall_get_firewall(struct device_node *np, struct stm32_firewall *f
>   			return err;
>   		}
>   
> -		if (j > nb_firewall) {
> +		if (j >= nb_firewall) {
>   			pr_err("Too many firewall controllers");
>   			of_node_put(provider);
>   			return -EINVAL;
Thank you.

Reviewed-by: Gatien Chevallier <gatien.chevallier@foss.st.com>

