Return-Path: <linux-kernel+bounces-155756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AC68AF6AE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDD3AB24D54
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674DD824B1;
	Tue, 23 Apr 2024 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=holoscopio.com header.i=@holoscopio.com header.b="TSr511ud"
Received: from grilo.cascardo.info (trem.minaslivre.org [195.201.110.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C86923775;
	Tue, 23 Apr 2024 18:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.110.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713897277; cv=none; b=gY4xzHfb7ZlxKNu8wBIPYbzAYucGica4ttLWWQJbbZVQXBdA6fyy0MIbQK2TBYy7piTbdxb0lkq/3dcQ6Fi/5bTJ6A9qXR8Wymfs6f37er4ifw2mTPG/s+7tSG6F2i17XLMCjGrGgoKWG64FS8+2RfVK4fscedFHimZI7nquxkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713897277; c=relaxed/simple;
	bh=pfxw2gtdpgMhC/s+VT5Ue18fZiuVhtvZxEf0WdwsVho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdpAERB7vQSKOdWij+mcsIzWCwVFU/FYe4TDoUuQgsjy414g9SY1olbNnNXkgKRXL8dg+c6tiW+l9CZRDILFTyHXKozqd8oIhn8gPYhJF3DBPKwqDyKxFSO5RuUwyBzt7aiGLRSL9QyB+CENxGvWjWhX4klE9sXqS4N42X8ajkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holoscopio.com; spf=pass smtp.mailfrom=holoscopio.com; dkim=pass (2048-bit key) header.d=holoscopio.com header.i=@holoscopio.com header.b=TSr511ud; arc=none smtp.client-ip=195.201.110.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holoscopio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holoscopio.com
Received: from siri.cascardo.eti.br (179-125-71-233-dinamico.pombonet.net.br [179.125.71.233])
	by grilo.cascardo.info (Postfix) with ESMTPSA id 95570206F1F;
	Tue, 23 Apr 2024 15:34:21 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=holoscopio.com;
	s=mail; t=1713897263;
	bh=pfxw2gtdpgMhC/s+VT5Ue18fZiuVhtvZxEf0WdwsVho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TSr511udQzXT8wlW4Z1sRMNo+y3XjQUA31cR7gnkang4OICJLQeLYd0Qom2xXHB5O
	 ChN8xe2r7lfM+s8tGd0n4R7InKGMs3T3SdJKftPcKLYYFIhG1rO9+S4ocMAe/yj/1S
	 fn3pwYN/GMPIoLb6MinSkeeYJ5tQf0l6NIpwuT/FIzVncsyocaQCJQLKO0WFszge2R
	 hz42oCtQjIQhhrd/RCOP5hhygEgFnqQobWifPo0DrBEweO8Qtyn1tKa3axuVuHk+Zg
	 jX92i8dob4WIIHGVwD6Ppe0AbZwp2HwsKTHjUua2v/Ej4EdFoyBkpEVDWjRvxuz86f
	 NNg4Kqp33evaQ==
Date: Tue, 23 Apr 2024 15:34:18 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v2 1/1] platform/x86: classmate-laptop: Add missing
 MODULE_DESCRIPTION()
Message-ID: <Zif_KuuBLEkGI34u@siri.cascardo.eti.br>
References: <20240423161108.2636958-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423161108.2636958-1-andriy.shevchenko@linux.intel.com>

On Tue, Apr 23, 2024 at 07:09:51PM +0300, Andy Shevchenko wrote:
> The modpost script is not happy
> 
>   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/classmate-laptop.o
> 
> because there is a missing module description.
> 
> Add it to the module.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: alinged text with Kconfig entry (Thadeu Lima)
>  drivers/platform/x86/classmate-laptop.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
> index 87462e7c6219..cb6fce655e35 100644
> --- a/drivers/platform/x86/classmate-laptop.c
> +++ b/drivers/platform/x86/classmate-laptop.c
> @@ -13,8 +13,6 @@
>  #include <linux/input.h>
>  #include <linux/rfkill.h>
>  
> -MODULE_LICENSE("GPL");
> -
>  struct cmpc_accel {
>  	int sensitivity;
>  	int g_select;
> @@ -1139,3 +1137,5 @@ static const struct acpi_device_id cmpc_device_ids[] __maybe_unused = {
>  };
>  
>  MODULE_DEVICE_TABLE(acpi, cmpc_device_ids);
> +MODULE_DESCRIPTION("Support for Intel Classmate PC ACPI devices");
> +MODULE_LICENSE("GPL");
> -- 
> 2.43.0.rc1.1336.g36b5255a03ac
> 

Acked-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>

