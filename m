Return-Path: <linux-kernel+bounces-18740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F2782626F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 01:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 902EDB21EC0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 00:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BB6101F1;
	Sun,  7 Jan 2024 00:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y6ozcBqw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC751078A;
	Sun,  7 Jan 2024 00:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=1SxmdIFSRjpJFxGtPnHV34ru+LdpMa81TZvqC7nDGIQ=; b=y6ozcBqwUBF/69wfUBFmleLuxH
	NGskmODUlwW/1rFsQaEYeLz76jdXb+8PUi/dyHhUQ5ztkeSDoELb2ak1wynttyPrqCjmUXF9h+PGb
	SZZgCUSnthQKeVJfk38Dwp0+yvlgZT5RG+6o8Hq28ZaW05X2bqCyR6+eka7oVAGqNa1sNmJerjRFc
	mYK1YwXiODMilzwuZzRQMq9+XuppmfOKor5LQPJyMUkZKQLDWeDDO4yiiA5HQc4if9vK7ha9O28r1
	t8SJ2//LIvpCf8oQmMhQW3epv1z7UHycSpLSNCSY5OE4iLVwOkkot1n4zzCz96icf8x2/gzQbVQQe
	GCRnlbnw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rMGaY-0024wo-2c;
	Sun, 07 Jan 2024 00:00:26 +0000
Message-ID: <cca3f0d2-8742-4985-8c9b-1d009dd0cba6@infradead.org>
Date: Sat, 6 Jan 2024 16:00:25 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: intel-wmi-sbl-fw-update: Fix function name
 in error message
Content-Language: en-US
To: Armin Wolf <W_Armin@gmx.de>, jithu.joseph@intel.com
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240106224126.13803-1-W_Armin@gmx.de>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240106224126.13803-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/6/24 14:41, Armin Wolf wrote:
> Since when the driver was converted to use the bus-based WMI
> interface, the old GUID-based WMI functions are not used anymore.
> Update the error message to avoid confusing users.
> 
> Compile-tested only.
> 
> Fixes: 75c487fcb69c ("platform/x86: intel-wmi-sbl-fw-update: Use bus-based WMI interface")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>


Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/platform/x86/intel/wmi/sbl-fw-update.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/wmi/sbl-fw-update.c b/drivers/platform/x86/intel/wmi/sbl-fw-update.c
> index 9cf5ed0f8dc2..040153ad67c1 100644
> --- a/drivers/platform/x86/intel/wmi/sbl-fw-update.c
> +++ b/drivers/platform/x86/intel/wmi/sbl-fw-update.c
> @@ -32,7 +32,7 @@ static int get_fwu_request(struct device *dev, u32 *out)
>  		return -ENODEV;
> 
>  	if (obj->type != ACPI_TYPE_INTEGER) {
> -		dev_warn(dev, "wmi_query_block returned invalid value\n");
> +		dev_warn(dev, "wmidev_block_query returned invalid value\n");
>  		kfree(obj);
>  		return -EINVAL;
>  	}
> @@ -55,7 +55,7 @@ static int set_fwu_request(struct device *dev, u32 in)
> 
>  	status = wmidev_block_set(to_wmi_device(dev), 0, &input);
>  	if (ACPI_FAILURE(status)) {
> -		dev_err(dev, "wmi_set_block failed\n");
> +		dev_err(dev, "wmidev_block_set failed\n");
>  		return -ENODEV;
>  	}
> 
> --
> 2.39.2
> 
> 

-- 
#Randy

