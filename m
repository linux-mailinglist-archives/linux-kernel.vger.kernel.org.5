Return-Path: <linux-kernel+bounces-18195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E08E8259E7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357E31C23742
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A37734CEC;
	Fri,  5 Jan 2024 18:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="rB3BJ+l/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE613588C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id LiVoraE5EoMN9Lol0rWYjO; Fri, 05 Jan 2024 18:17:22 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id Lol0rvHBaYjq0Lol0ryvIx; Fri, 05 Jan 2024 18:17:22 +0000
X-Authority-Analysis: v=2.4 cv=afxyIDkt c=1 sm=1 tr=0 ts=659847b2
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GfQleyYEO+cc22AUyTT7qQ==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=7YfXLusrAAAA:8 a=VwQbUJbxAAAA:8 a=_MUxwH_1hrhzMBYmUHsA:9 a=QEXdDO2ut3YA:10
 a=SLz71HocmBbuEhFRYD3r:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9I/V4bfaoYSOxFfnj8JFSrOi1wVdUSbRrkSkeRTBjnw=; b=rB3BJ+l/ZQSDA8Sk9VwkRFJRzb
	aL/dkDOCl3UtoelOYMsMkSTz99aqaeRy4nLtWrM967qj/lud31V+W0CNMQcpbqcxd3OjM4JCzGIMq
	fQnNAQrjqhqKYBclf9DkyzGkeY17MLkN2/9QpteCRMFmJ9OjyOY/tvO3VpVpz2XoAuYBdsjsgtUkm
	mSDw8GtnSYpKWV7ojECsJ/Th3BboRCRtjDJ5Q4S6UpuSHpd5L3ejHbCGE5XNMW2nihes1DfEatELx
	BufUr+kuV9tpeayqKRX9rqOkuQ5OZnWGhpB9lr7OIvmZnwjXhC4/Fwqb6yp1E5dWFE/XmGOhi+Yav
	ItP2PGzw==;
Received: from 187.184.157.186.cable.dyn.cableonline.com.mx ([187.184.157.186]:13689 helo=[192.168.0.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rLokz-003FGW-0q;
	Fri, 05 Jan 2024 12:17:21 -0600
Message-ID: <b12b56a9-2d20-4802-bbc8-43f4831b3113@embeddedor.com>
Date: Fri, 5 Jan 2024 12:17:18 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM / QOS: Use kcalloc() instead of kzalloc()
Content-Language: en-US
To: Erick Archer <erick.archer@gmx.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240105181118.116292-1-erick.archer@gmx.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240105181118.116292-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.157.186
X-Source-L: No
X-Exim-ID: 1rLokz-003FGW-0q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.157.186.cable.dyn.cableonline.com.mx ([192.168.0.10]) [187.184.157.186]:13689
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEiLZx33Rt1Syp6VmH803vmRGh+0k9vrpP7y+6a1S5cZpy+GIE6odviAyTwfFXQFsdmW/rhpK9oqlFUw5A/6YGae1A6Qf2moYMiTg1wOImSV6PKokKNv
 k/Ma1UkGKUloCwWkIqLEAO19yNvLmtjEpQH/B7lPpts33Gxo3Hg5bisf91UFa1JAPcrdKGoytfsCp643l+b7D/8U0QnUSf0tvFFIQyFLWLOVY6j32oelcJ/7



On 1/5/24 12:11, Erick Archer wrote:
> Use 2-factor multiplication argument form kcalloc() instead
> of kzalloc().
> 
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

> ---
>   drivers/base/power/qos.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
> index 8e93167f1783..bd77f6734f14 100644
> --- a/drivers/base/power/qos.c
> +++ b/drivers/base/power/qos.c
> @@ -201,7 +201,7 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
>   	if (!qos)
>   		return -ENOMEM;
> 
> -	n = kzalloc(3 * sizeof(*n), GFP_KERNEL);
> +	n = kcalloc(3, sizeof(*n), GFP_KERNEL);
>   	if (!n) {
>   		kfree(qos);
>   		return -ENOMEM;
> --
> 2.42.0
> 
> 

