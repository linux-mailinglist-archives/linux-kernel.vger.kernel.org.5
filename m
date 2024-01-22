Return-Path: <linux-kernel+bounces-33869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7970B836FC3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4CB1F31FE3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F55B4D12A;
	Mon, 22 Jan 2024 17:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="RBTRfLlV"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0FC4D12D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945841; cv=none; b=to8JdD/ueVKCcXHGWs/GckqoCz0k8otWnCgZpQaBfjdFVD9TPXNzDgZI2Wn+ROAVqnMgA7mgob048RqR43Gou5/ToWJI64FNOCYiUSwI6HI7haUREt9IyrPb+sXCq/WH3ydm6mukAapD7GTpbyzGYdnUeJhYlM/fwCfPawvDv4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945841; c=relaxed/simple;
	bh=YxrQ8GVGh14WVWu2iVdnBrx1qzBPHiKAvXevqbj+oyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ThPIanQgjEtaLP9UJRsep6UKGxgJ9x8jEHJdvceEUiaCaMzAPJASKDXKz4dNo0fHxhVHGWCiBPoeK/7oZQTN7tG80BWwIEcWL5Z8LnWIO2WAhVdIEpBGrOxjNvfezrSRQ102FsrsDQ7h5AeYYFZoJn+g+u6RZLZa6X++Hl0KQHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=RBTRfLlV; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id RuqLrgOJUMVQiRyRTriBNl; Mon, 22 Jan 2024 17:50:39 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id RyRSrMvQyBnVCRyRSrzZvy; Mon, 22 Jan 2024 17:50:38 +0000
X-Authority-Analysis: v=2.4 cv=H+TIfsUi c=1 sm=1 tr=0 ts=65aeaaee
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=7YfXLusrAAAA:8 a=ciz651twq8eCfWHvLXUA:9 a=QEXdDO2ut3YA:10
 a=9cHFzqQdt-sA:10 a=PUnBvhIW4WwA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=SLz71HocmBbuEhFRYD3r:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3jl5Rvy1dz3jbfkhQsaWmnIHJyLyzrbXC5qPXJXKIM0=; b=RBTRfLlVX+HBtohsXzyv/w7ZIT
	6ql3qmCv/NVCF1lIo8QHAC/ilRPCdi4mfKRQ0qX3DABKk+/5tHtIGxTe32885qo1jaAKF2rmBWAjK
	iy+UmweXOWjMLHmv3kHwwxCUpzLsb7XbfkJs+mHFA1H0lIIoF7zyZGV5HmSimQwg5j9xTl59M5E6d
	bmfXYJDBIpbKKgZJ5Bj1L6dg4F/LDHa+S8vyivvd3Z00ALRLUZdTx8rkP6/TnrjrYx9MrISv3N/xe
	pZEgiwdsFcAiL3Q2mGDg0I3hwS04xuy/32Ky06aHXX67o/x1AfntSRrxJ/Pfc9R0L/cquSGoirfUa
	NYuab93A==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:40442 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rRyRR-001JMH-1I;
	Mon, 22 Jan 2024 11:50:37 -0600
Message-ID: <bd8965ec-f2fe-44ae-9b0a-e6aad7a6b7bb@embeddedor.com>
Date: Mon, 22 Jan 2024 11:50:35 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bus: mhi: ep: Use kcalloc() instead of kzalloc()
Content-Language: en-US
To: Erick Archer <erick.archer@gmx.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jeffrey Hugo <quic_jhugo@quicinc.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Dan Carpenter <error27@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240120152518.13006-1-erick.archer@gmx.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240120152518.13006-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1rRyRR-001JMH-1I
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:40442
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 16
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfE3GDzVfYO6qOXmMR/qnxj0KOQWMhG7CPKjeQW4oeS0GPHLgluMm+ZpVqhQLGLCj/N3Q+m/DjTTlELt7nK7StYpYSi18kiDlywlNDoVogq4NDQwdhnc/
 ERlbiEycdZ09j6L/SEDp8NIekrVqrmh0BQZtb7HXM/KyxV2jAc6hxAEirv9c0V16bSYmGUnTbg02KOSsYO83FPcTgqkDmuW0cKTOYtWJ6Zm1pKwTWJkv2Jy0



On 1/20/24 09:25, Erick Archer wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the purpose specific kcalloc() function instead of the argument
> count * size in the kzalloc() function.
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

> ---
>   drivers/bus/mhi/ep/main.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index 65fc1d738bec..8d7a4102bdb7 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -1149,8 +1149,9 @@ int mhi_ep_power_up(struct mhi_ep_cntrl *mhi_cntrl)
>   	mhi_ep_mmio_mask_interrupts(mhi_cntrl);
>   	mhi_ep_mmio_init(mhi_cntrl);
> 
> -	mhi_cntrl->mhi_event = kzalloc(mhi_cntrl->event_rings * (sizeof(*mhi_cntrl->mhi_event)),
> -					GFP_KERNEL);
> +	mhi_cntrl->mhi_event = kcalloc(mhi_cntrl->event_rings,
> +				       sizeof(*mhi_cntrl->mhi_event),
> +				       GFP_KERNEL);
>   	if (!mhi_cntrl->mhi_event)
>   		return -ENOMEM;
> 
> --
> 2.25.1
> 
> 

