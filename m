Return-Path: <linux-kernel+bounces-42110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 500EC83FC69
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E69BFB225A6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7068101E6;
	Mon, 29 Jan 2024 02:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kC1Y7HR+"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FDC101CF;
	Mon, 29 Jan 2024 02:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706497162; cv=none; b=cl8NgUdxjdsiU1rQ6kS8K6iwdE56cxUgNb5/If4RljAdAsO+VqQL2nzmh2qITz9v/9M8e8Zy7rCFKm0aJCkvYVpljAvjjxeLrRXO3JBvXQ0tNoyC67YBpvelEKYxyDALaMWSWuSUzA1xDIUB1S4ZkSZBZNsr7HgQgQaTJLV2XUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706497162; c=relaxed/simple;
	bh=AkL5XMHJxqpGdKkQ02KZlPaEAtTmtXYjDpIdOGl2vpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WSwIky2g4vsW6YQ0iApAoswO6No20TQkTAN1EYt4XYAPJvX3ClMACHdmBVh36rfzLjzkMWHJcnN5gOiDTPaZj8xZPpuZoAof3wcWV6JHBmJY5tKtopFiohYliZ8g51kQOf9i2hWBn3bumdZVy8OiwIhkqS7kJM+cxex24rZDqFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kC1Y7HR+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=mXt373LIr+R+kMq9PxELhBz9gRcfeFLyy87k0vEnszM=; b=kC1Y7HR+j3sEae2B4rPzzklhuX
	L/gqcVtT9yPhY46B89SDcUYmeqfUWaL8dsxHFQjhwEPFiqkJ6R9ZKeBGeB8gf3l/N3dEBtPIYEOvF
	XuAPwECCjkQ4lcxbmo/z0sKCOK7wCyHPsBROz81821zpOg3CeRCIJmHDRFCnO/wNio5jfu/Hmf+kW
	laAmgpj1ZGgHBPik+IyiAey3CFv4tWP0cZ5JsTr+KGnVtBfgp/SMPTQS822GPtOeqelTNsDfLMCxY
	njLLD9W6RwQIXW6/1fASmdx4vd50dfhHNiDiHZjRMmOVh5dsCOqPFGJAKV+kx+pTmnfagKX8ljTnZ
	q/h7NGZQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUHrg-0000000B4Rl-2r2u;
	Mon, 29 Jan 2024 02:59:16 +0000
Message-ID: <d3bc8995-b0bc-4d9e-b811-fccdbaf426c5@infradead.org>
Date: Sun, 28 Jan 2024 18:59:16 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: Fix malformed table in gadget-testing.rst
Content-Language: en-US
To: Kohshi Yamaguchi <kohshi54.yam@gmail.com>, gregkh@linuxfoundation.org,
 corbet@lwn.net
Cc: linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
References: <20240128195731.40003-1-kohshi54.yam@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240128195731.40003-1-kohshi54.yam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/28/24 11:57, Kohshi Yamaguchi wrote:
> The table describing the NCM function attributes in gadget-testing.rst
> was malformed, causing Sphinx build warnings. This patch fixes the table
> format to align with the reStructuredText specifications.
> 
> The border lines of the table were not properly aligned with the column
> headers, which was corrected by adjusting the border line lengths to
> match the headers.
> 
> Signed-off-by: Kohshi Yamaguchi <kohshi54.yam@gmail.com>
> ---
>  Documentation/usb/gadget-testing.rst | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
> index 8cd62c466d20..1d1737f246df 100644
> --- a/Documentation/usb/gadget-testing.rst
> +++ b/Documentation/usb/gadget-testing.rst
> @@ -448,17 +448,17 @@ Function-specific configfs interface
>  The function name to use when creating the function directory is "ncm".
>  The NCM function provides these attributes in its function directory:
>  
> -	===============   ==================================================
> -	ifname		  network device interface name associated with this
> -			  function instance
> -	qmult		  queue length multiplier for high and super speed
> -	host_addr	  MAC address of host's end of this
> -			  Ethernet over USB link
> -	dev_addr	  MAC address of device's end of this
> -			  Ethernet over USB link
> -	max_segment_size  Segment size required for P2P connections. This
> -			  will set MTU to (max_segment_size - 14 bytes)
> -	===============   ==================================================
> +	================   ==================================================
> +	ifname		   network device interface name associated with this
> +			   function instance
> +	qmult		   queue length multiplier for high and super speed
> +	host_addr	   MAC address of host's end of this
> +			   Ethernet over USB link
> +	dev_addr	   MAC address of device's end of this
> +			   Ethernet over USB link
> +	max_segment_size   Segment size required for P2P connections. This
> +			   will set MTU to (max_segment_size - 14 bytes)
> +	================   ==================================================
>  
>  and after creating the functions/ncm.<instance name> they contain default
>  values: qmult is 5, dev_addr and host_addr are randomly selected.

or like this:

https://lore.kernel.org/lkml/20240128045347.25909-1-rdunlap@infradead.org/

Thanks.
-- 
#Randy

