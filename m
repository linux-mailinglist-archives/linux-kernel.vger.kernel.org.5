Return-Path: <linux-kernel+bounces-45111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D50842BD4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA96B1F2434B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86A669974;
	Tue, 30 Jan 2024 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="uJ8MSHSC"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169B669E0E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639619; cv=none; b=g83lUqsik45xw/LeCHuEsvcIGchENMi9C6dHh6Cq2oznZ2myXT2p1aZdl3/kpWdZ00Y+trU7LkvpuWqx2Bb8Wa95a5CMOEWF9Jsb4pr2cbWKD3xvyv9kS3cfhE+nnYH19qvynI9OxArtRY0D3pyb70w2UoN054tvVfV4c/6n1zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639619; c=relaxed/simple;
	bh=e6Em/YoU24DzfrgG1I3MeTPrdt0H0Tda436ZQlrVs44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q8hqabd+mbpYMudOp3gbnP8BLjrFhChJZbn4VZBMlysO5ulKy3PESg4kf2IvjNu7pCexxThovQB+x33/evbtSLQk4hrL5N8TBJNGUd79np8N/HRwuNuKZKS2vIYfEjcKi/YUf4Lj/c2JWk6ICgGBx7L9VB+vOAqt0b+YfPrXcwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=uJ8MSHSC; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id UqblrV7cRTHHuUsvNrtWDe; Tue, 30 Jan 2024 18:33:33 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id UsvMrAvw5L3AmUsvMrKkDm; Tue, 30 Jan 2024 18:33:33 +0000
X-Authority-Analysis: v=2.4 cv=Sdrky9du c=1 sm=1 tr=0 ts=65b940fd
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=7YfXLusrAAAA:8 a=WIj-IPmD8QUj2RxniLMA:9 a=QEXdDO2ut3YA:10
 a=9cHFzqQdt-sA:10 a=PUnBvhIW4WwA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=SLz71HocmBbuEhFRYD3r:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dwMBQhKAPrdpeG07deWR0oT84VH23ARprvDaD8J62YM=; b=uJ8MSHSCsIUsxGqykVEA55n+V3
	6mCCY8tYHJbdm9YTHC5fNd6sP8dvh31H/NILFDuLOJDnI6jvXxq0hP2VfSPmv7AADYm5pRpZxyMFw
	UeypA0zLbJi9UxTXSBlnQDSnFTJWyYpcaD8pet80lVr3/rPueJiR1fnFMxFqkbWl+PWSG40xQ3aPf
	ZEl2sVXOoVASg6qC5bdaRKlUdszbFa/f+6whfGbz+vNOgDNqufYKBMa6Uj+ApsZUxZ2oRHYT5GNk3
	ws2lKbFPLtp7vH2jk/9sc7VytpiZPLO7jfCrdTOH1F0I99eHhasGDG1tXk2ne97Brn4366suqAszH
	DBbmewqQ==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:52948 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rUsvL-0030Gq-2d;
	Tue, 30 Jan 2024 12:33:31 -0600
Message-ID: <114074ef-7021-4ca0-a5f7-b0ea37948f5d@embeddedor.com>
Date: Tue, 30 Jan 2024 12:33:30 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: pl08x: Use kcalloc() instead of kzalloc()
Content-Language: en-US
To: Erick Archer <erick.archer@gmx.com>, Vinod Koul <vkoul@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240128115236.4791-1-erick.archer@gmx.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240128115236.4791-1-erick.archer@gmx.com>
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
X-Exim-ID: 1rUsvL-0030Gq-2d
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:52948
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfD60vF061QhTTMEdLo1m+I0nldcoi2uR93Q2rTFCwtROWLlaY3HrtP3qEPjmGNnyvS0rHUoDUDbaYSKShnaOuc8qSvRCMmoGFHoZwqJN0Tn4WO00e4Rv
 WP+3BcD7o4YAYYzIANFl9h/th/eNkBRrOgjiADrzvdHkHFVpnrDTD1ZKZ/uNLsPxYePKv9p1B6/ASIW3cXvQPfRlFjCY5rczwcb64HKgk5MO5x5MfOHVCHKs



On 1/28/24 05:52, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1].
> 
> Here the multiplication is obviously safe because the "channels"
> member can only be 8 or 2. This value is set when the "vendor_data"
> structs are initialized.
> 
> static struct vendor_data vendor_pl080 = {
> 	[...]
> 	.channels = 8,
> 	[...]
> };
> 
> static struct vendor_data vendor_nomadik = {
> 	[...]
> 	.channels = 8,
> 	[...]
> };
> 
> static struct vendor_data vendor_pl080s = {
> 	[...]
> 	.channels = 8,
> 	[...]
> };
> 
> static struct vendor_data vendor_pl081 = {
> 	[...]
> 	.channels = 2,
> 	[...]
> };
> 
> However, using kcalloc() is more appropriate [1] and improves
> readability. This patch has no effect on runtime behavior.
> 
> Link: https://github.com/KSPP/linux/issues/162 [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

> ---
>   drivers/dma/amba-pl08x.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
> index eea8bd33b4b7..e40766108787 100644
> --- a/drivers/dma/amba-pl08x.c
> +++ b/drivers/dma/amba-pl08x.c
> @@ -2855,8 +2855,8 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
>   	}
> 
>   	/* Initialize physical channels */
> -	pl08x->phy_chans = kzalloc((vd->channels * sizeof(*pl08x->phy_chans)),
> -			GFP_KERNEL);
> +	pl08x->phy_chans = kcalloc(vd->channels, sizeof(*pl08x->phy_chans),
> +				   GFP_KERNEL);
>   	if (!pl08x->phy_chans) {
>   		ret = -ENOMEM;
>   		goto out_no_phychans;
> --
> 2.25.1
> 

