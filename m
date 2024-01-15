Return-Path: <linux-kernel+bounces-26385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C492782DFDB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB051F259F0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D51F1A58C;
	Mon, 15 Jan 2024 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="SVwkmh3u"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFD71A293
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
	by cmsmtp with ESMTPS
	id PRWHr57weMVQiPRfKrgGpm; Mon, 15 Jan 2024 18:26:30 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id PRfJrx7skbhW6PRfJrrcIl; Mon, 15 Jan 2024 18:26:30 +0000
X-Authority-Analysis: v=2.4 cv=aLPjFJxm c=1 sm=1 tr=0 ts=65a578d6
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=7YfXLusrAAAA:8 a=VwQbUJbxAAAA:8 a=FXBTkNl2ggHGzUV_zbMA:9 a=QEXdDO2ut3YA:10
 a=SLz71HocmBbuEhFRYD3r:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WTUFVnlzT6GAPsFMxebpFESclah/dS2GM3YPYolGM+Y=; b=SVwkmh3u9th/SZ2lajgNWnqdaD
	j+4GYFozQXuB4AiMLbMsUIVqGouSsjJJNO4ovXsh9pZHJbGtQFBTuE6Rv+zqLdQe9yXQH62KvCJCk
	Vtsa0+knIP42lKLJONngyeyU8ZFOETJqtnxW3GvmU7uoCZxM9kzhBuqqw3m5aoNtS9rsVvpp82w2c
	mO32tg6M6WJ9qA/+avEbtXpUQ1CS3Cc65wSvgWMjo1VUlLGew/A/6AsrFJV4G3V0L71mU6h1UYpX2
	DGyCLN4I5Hmp8hBvzYHnE+Z0ENkPKoB82VIbbkomZPETOlps+aDl5N7rz0LzMYEPzmBjyCLKoF0yq
	mcFKnWow==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:43136 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rPRfI-003vCX-2Y;
	Mon, 15 Jan 2024 12:26:28 -0600
Message-ID: <5b2bda6f-d8e7-488d-ab0c-62dfc60de9a1@embeddedor.com>
Date: Mon, 15 Jan 2024 12:26:27 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scsi: csiostor: Use kcalloc() instead of kzalloc()
Content-Language: en-US
To: Erick Archer <erick.archer@gmx.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Justin Stitt <justinstitt@google.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240114102400.3816-1-erick.archer@gmx.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240114102400.3816-1-erick.archer@gmx.com>
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
X-Exim-ID: 1rPRfI-003vCX-2Y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:43136
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMeqFD1q6oSK2Zym7ZWGdmCDw1g4zqPf9GYQ6BSWe29ijfwwzXk62BvVwremeAlbDtd5QhnovJU4iB8qnHxFcf+wGv3shksagwp6WDXpsHDiEBZi0GY/
 PB4Ft6TIp1sPhXKFPbEf/LjxV8U8oUchi/2yZW2BBQHjBrFc7BqnYjwYMPZl1LNavI17h/gyEgnWlBjZfFfI9e9FX6K7PchFMgYcdA+/1yA/dZ7Eq91nczTH



On 1/14/24 04:24, Erick Archer wrote:
> Use 2-factor multiplication argument form kcalloc() instead
> of kzalloc().
> 
> Also, it is preferred to use sizeof(*pointer) instead of
> sizeof(type) due to the type of the variable can change and
> one needs not change the former (unlike the latter).
> 
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

> ---
> Changes in v2:
> - Update the changelog text describing the sizeof()
>    changes (Gustavo A. R. Silva)
> 
> Version 1:
> Link: https://lore.kernel.org/linux-hardening/20240112182603.11048-1-erick.archer@gmx.com/
> ---
>   drivers/scsi/csiostor/csio_init.c | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/scsi/csiostor/csio_init.c b/drivers/scsi/csiostor/csio_init.c
> index d649b7a2a879..d72892e44fd1 100644
> --- a/drivers/scsi/csiostor/csio_init.c
> +++ b/drivers/scsi/csiostor/csio_init.c
> @@ -698,8 +698,7 @@ csio_lnodes_block_request(struct csio_hw *hw)
>   	struct csio_lnode **lnode_list;
>   	int cur_cnt = 0, ii;
> 
> -	lnode_list = kzalloc((sizeof(struct csio_lnode *) * hw->num_lns),
> -			GFP_KERNEL);
> +	lnode_list = kcalloc(hw->num_lns, sizeof(*lnode_list), GFP_KERNEL);
>   	if (!lnode_list) {
>   		csio_err(hw, "Failed to allocate lnodes_list");
>   		return;
> @@ -737,8 +736,7 @@ csio_lnodes_unblock_request(struct csio_hw *hw)
>   	struct csio_lnode **lnode_list;
>   	int cur_cnt = 0, ii;
> 
> -	lnode_list = kzalloc((sizeof(struct csio_lnode *) * hw->num_lns),
> -			GFP_KERNEL);
> +	lnode_list = kcalloc(hw->num_lns, sizeof(*lnode_list), GFP_KERNEL);
>   	if (!lnode_list) {
>   		csio_err(hw, "Failed to allocate lnodes_list");
>   		return;
> @@ -775,8 +773,7 @@ csio_lnodes_block_by_port(struct csio_hw *hw, uint8_t portid)
>   	struct csio_lnode **lnode_list;
>   	int cur_cnt = 0, ii;
> 
> -	lnode_list = kzalloc((sizeof(struct csio_lnode *) * hw->num_lns),
> -			GFP_KERNEL);
> +	lnode_list = kcalloc(hw->num_lns, sizeof(*lnode_list), GFP_KERNEL);
>   	if (!lnode_list) {
>   		csio_err(hw, "Failed to allocate lnodes_list");
>   		return;
> @@ -816,8 +813,7 @@ csio_lnodes_unblock_by_port(struct csio_hw *hw, uint8_t portid)
>   	struct csio_lnode **lnode_list;
>   	int cur_cnt = 0, ii;
> 
> -	lnode_list = kzalloc((sizeof(struct csio_lnode *) * hw->num_lns),
> -			GFP_KERNEL);
> +	lnode_list = kcalloc(hw->num_lns, sizeof(*lnode_list), GFP_KERNEL);
>   	if (!lnode_list) {
>   		csio_err(hw, "Failed to allocate lnodes_list");
>   		return;
> @@ -855,8 +851,7 @@ csio_lnodes_exit(struct csio_hw *hw, bool npiv)
>   	struct csio_lnode **lnode_list;
>   	int cur_cnt = 0, ii;
> 
> -	lnode_list = kzalloc((sizeof(struct csio_lnode *) * hw->num_lns),
> -			GFP_KERNEL);
> +	lnode_list = kcalloc(hw->num_lns, sizeof(*lnode_list), GFP_KERNEL);
>   	if (!lnode_list) {
>   		csio_err(hw, "lnodes_exit: Failed to allocate lnodes_list.\n");
>   		return;
> --
> 2.25.1
> 
> 

