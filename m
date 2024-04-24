Return-Path: <linux-kernel+bounces-156940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6ED8B0AA2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7F31F2228A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CA015B562;
	Wed, 24 Apr 2024 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="nDxQOumJ"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6D315B130;
	Wed, 24 Apr 2024 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713964517; cv=none; b=vBE/HVSY6PpHvy0k/NDKJBqb1iRJTkTFAkuBrbI37pBb7Iw2rn/hSfjO8wCrNIcBy8UIyiCL0jjW7D2s6+uk+jrRvK4gvBGruYLrZ//NU5/JeuTOef4MtFxN5+6WBpFz4kOLWQIV+NUauy4KC3KganKUBG78P/YLlab3wXsCtwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713964517; c=relaxed/simple;
	bh=ZpzSAiaL59N9XSN9rDcS3ezl9pXtDYQNg7pgIwvTRtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DaXhET9i5vgvn315SIwDwZWbGIPfKHPcgWRT9vFm8y/2VQTb5gDj52470XLSukfnWu2UmmjYUDYt7+r8RPoHfYgqAEbGFRGVdQ3zp8CE/U8NZSrYi5/ewsJP3kZYgIvKk9CSOErAlcTvML5EfLKW16uM0FrrJqRscsOwQvN99yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=nDxQOumJ; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OBsNvJ019281;
	Wed, 24 Apr 2024 15:15:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=3KiGlLEEMBqAQpnigw8VFdSst9zFsrKpxO0S8JeWSSY=; b=nD
	xQOumJpyT0pxzog09VN71zHwYTX7Wp/UNR7PPUKJKlYpZn663KYtY0bjStUo8j2y
	YkKYiWzT8TZJA41J5Z8nhvSHqOe/mIYzjDU4hMPsgVE/QmU//1WeYEYEkDLvjLpZ
	CLsSJqrPotWo5tHgJFYoet/OwS5eK9rpG8MLb7Gis4r8gwwlFX4LG6i02hna8s+G
	0Q+Ql4eJrUB4JcBIpp3tJ67xAhIe6y6hFz284dpGSBylysbfR3inOPBuRi0cNmKX
	vB7SMQ7ayuajBuWZuFrJCfn6JnIFCbxw79/Zza2jr5qfxraWB62veDm62yYXZbV/
	VY3zBi6MXiPQXUVk/yvA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm4cngpmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 15:15:08 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7B2994002D;
	Wed, 24 Apr 2024 15:15:04 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A76DC21ED4A;
	Wed, 24 Apr 2024 15:14:38 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 15:14:38 +0200
Message-ID: <53a82587-2f1b-45df-b507-11810ad1b533@foss.st.com>
Date: Wed, 24 Apr 2024 15:14:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bus: stm32_firewall: fix off by one in
 stm32_firewall_get_firewall()
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Gatien Chevallier
	<gatien.chevallier@foss.st.com>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <17dce071-21ef-49f5-be45-f93bbf3642ec@moroto.mountain>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <17dce071-21ef-49f5-be45-f93bbf3642ec@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_10,2024-04-24_01,2023-05-22_02

Hi Dan

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

Applied on stm32-next.

Regards
Alex

