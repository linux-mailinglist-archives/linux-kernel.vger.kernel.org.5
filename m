Return-Path: <linux-kernel+bounces-105538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C8787DFE1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 21:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B0D1C20AD4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9A01F93E;
	Sun, 17 Mar 2024 19:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XGkyVrtg"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371D51EB5F;
	Sun, 17 Mar 2024 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710705596; cv=none; b=Ilsp8SrQQbcGGOYcxca5Oak3M/uYSDdimCvk41FcT1kBqR195cT3Y7wwxzv6WCgT2q8s+s4GkR73eLzm3qpYPOxbbWnG/wDMaNoMsoFoxGGW/sO4Ujf6KqnwM/Io0giJpndHtg2Ufp3VD7kv5l6bqYtD4C3xWc+yBlxAU0Ap4go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710705596; c=relaxed/simple;
	bh=q7sugEXB8N+DSkAdHxRmEekSZVKXq0YF12jGmP5eYKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AGDbTOHte3yovHWtnWMabo0USyaoFg0oMNQHa6QR/wNfdd7vSVdMpa8Hqij3YN7fGv50bmAdw9MakP07vsfh4HlddytWLVxk6SGLEvHBehg0NYjN/ecASSlHNoTWv8PTEAd9HgosO9odAYhRJGsVulom+gunk2eHHca2KCVyCks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XGkyVrtg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=v3yOw+T1uuEbcMo2yPaFHZJlXDd5ycGdOfQCOz9d+ko=; b=XGkyVrtgxFLIzE+gIgu5LZwsj5
	WgcROnqjBygI93P0Fu3/R07Qz1FhdH5w+v9vYlFN1Wq82M9ImWQ5+Pmwe8er9ix2wDcSY1W92+ZYz
	OCYos3z3SBKRUgdAAmfO/XGQTpIkMN4LS6+TOaTZtizxOwFlL4umI9my21Rm3AZQwDGzazYZbqCs6
	JvCzR4J+5D5yMZSObV890RzgSVTmwjbwc2lAkGO4yIgfmMrm7YN/0mToSNdxamrbPb5kcvv7x5hCr
	qtD1svKkGUCUKJN9vEBgp8h3wN7AN7P8ZE6ZIN2MgfvCi1dbxlPj6M+EMimapSCXAFDDl9JLBRXHG
	raFD0BaQ==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rlwff-00000006Hld-3AJg;
	Sun, 17 Mar 2024 19:59:51 +0000
Message-ID: <98ae99ea-a6e8-4863-9a1d-1c31e2db1d6f@infradead.org>
Date: Sun, 17 Mar 2024 12:59:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] mikrobus: Add mikroBUS driver
Content-Language: en-US
To: Ayush Singh <ayushdevel1325@gmail.com>,
 open list <linux-kernel@vger.kernel.org>
Cc: jkridner@beagleboard.org, robertcnelson@beagleboard.org,
 lorforlinux@beagleboard.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vaishnav M A <vaishnav.a@ti.com>, Mark Brown <broonie@kernel.org>,
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/TEXAS INSTRUMENTS K3 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
 "moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
 Vaishnav M A <vaishnav@beagleboard.org>
References: <20240317193714.403132-1-ayushdevel1325@gmail.com>
 <20240317193714.403132-5-ayushdevel1325@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240317193714.403132-5-ayushdevel1325@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 3/17/24 12:37, Ayush Singh wrote:
> diff --git a/drivers/misc/mikrobus/Kconfig b/drivers/misc/mikrobus/Kconfig
> new file mode 100644
> index 000000000000..aa57b994dc66
> --- /dev/null
> +++ b/drivers/misc/mikrobus/Kconfig
> @@ -0,0 +1,15 @@
> +menuconfig MIKROBUS
> +	tristate "Module for instantiating devices on mikroBUS ports"
> +	depends on GPIOLIB
> +	help
> +	  This option enables the mikroBUS driver. mikroBUS is an add-on
> +	  board socket standard that offers maximum expandability with
> +	  the smallest number of pins. The mikroBUS driver instantiates
> +	  devices on a mikroBUS port described mikroBUS manifest which is

I can't quite parse that line ^^^. Is it like this?

	  devices on a mikroBUS port described by a mikroBUS manifest which is

> +	  passed using a sysfs interface.
> +
> +
> +	  Say Y here to enable support for this driver.
> +
> +	  To compile this code as a module, chose M here: the module
> +	  will be called mikrobus.ko

-- 
#Randy

