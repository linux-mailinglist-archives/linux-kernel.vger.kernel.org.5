Return-Path: <linux-kernel+bounces-9174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593C881C1D9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17476289D22
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA78E7D896;
	Thu, 21 Dec 2023 23:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qCvbwfJr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EB97E77A;
	Thu, 21 Dec 2023 23:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=+wOARTyaP7BC0rwifBTMwepFO+pzfmSxi/wdh59kYgA=; b=qCvbwfJrYaCuitNlvBitPhSwMx
	0HI8bE0xCwdrbW1itCKrCbcd4hZEI8oO7+7spljr6Wcvr5LIZJWrnkhP/6+WHxCUBS4n6EXhFY8Dk
	9NUKapsJX01K8UjcmPio+1Sq+buQSKPQJNVMZtvdsmWREiTigeAnqDi5SZbQZvTYOCpVgnOeb6EmM
	YYlUG0ULWFQsBRRS11ZFH0WBPjNPzU9/2EjF03BLGgqf1bfNf/VCsRjh5nuqWd8bxBN5OahKOm8eE
	1j06y4VDBarl3XXzXi36ZhF6iFOw0RE6QY5lzlCY0MIXS3ja8BdTVTRYaFsmvXxMf/r85PHgV3B/v
	8ITikemQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGSJh-004PP0-2E;
	Thu, 21 Dec 2023 23:19:01 +0000
Message-ID: <40285311-8adc-4ca9-86ce-27c8b723a102@infradead.org>
Date: Thu, 21 Dec 2023 15:19:01 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] hwmon: clarify intent of fan min/max
Content-Language: en-US
To: Ivor Wanders <ivor@iwanders.net>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maximilian Luz <luzmaximilian@gmail.com>
References: <20231221225149.11295-1-ivor@iwanders.net>
 <20231221225149.11295-2-ivor@iwanders.net>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231221225149.11295-2-ivor@iwanders.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/21/23 14:51, Ivor Wanders wrote:
> This adds a link to the hwmon sysfs attributes in the hwmon patch
> submission bullet points. It also adds an explanation denoting the
> intent of the fan min and max attributes.
> 
> Signed-off-by: Ivor Wanders <ivor@iwanders.net>
> ---
>  Documentation/hwmon/submitting-patches.rst |  4 +++-
>  Documentation/hwmon/sysfs-interface.rst    | 12 +++++++++---
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 


> diff --git a/Documentation/hwmon/sysfs-interface.rst b/Documentation/hwmon/sysfs-interface.rst
> index f76e9f8cc..72dd5e02d 100644
> --- a/Documentation/hwmon/sysfs-interface.rst
> +++ b/Documentation/hwmon/sysfs-interface.rst
> @@ -167,13 +167,19 @@ Fans
>  ****
>  
>  `fan[1-*]_min`
> -		Fan minimum value
> +		Fan minimum value, this is intended as a way to specify

Please change the comma here to either (a) semi-colon (';') or
(b) a period ('.') followed by a sentence beginning with a capital letter.

Same for the other 2 below also.

> +		the desired minimum speed to the device if the device
> +		supports that. It is not intended for communicating
> +		a constant that denotes the lowest possible fan speed.
>  
>  `fan[1-*]_max`
> -		Fan maximum value
> +		Fan maximum value, this is intended as a way to specify
> +		the desired maximum speed to the device if the device
> +		supports that. It is not intended for communicating
> +		a constant that denotes the highest possible fan speed.
>  
>  `fan[1-*]_input`
> -		Fan input value.
> +		Fan input value, this is the fan's current speed.
>  
>  `fan[1-*]_div`
>  		Fan divisor.

thanks.
-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

