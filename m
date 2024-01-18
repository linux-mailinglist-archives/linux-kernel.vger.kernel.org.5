Return-Path: <linux-kernel+bounces-30363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82848831DC2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D7A28856F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5092C1BD;
	Thu, 18 Jan 2024 16:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xYLw7RDs"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DCF2C19B;
	Thu, 18 Jan 2024 16:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705596476; cv=none; b=cg9lwsrPRidLCc/r/M6bfqmUEXaN86ODm1ACE3VxeTFrG0h5K4VMTOU1Pm6oJGcaH7i3yfD80sB/Mg3H5KZPTjfeH9x6ey3fOBAYeVuq3XfTRQRMXTWadFoRUCCCfd8g9ofly/ZHAgGAuN2Rl435HRD7JLiaMsRUlS0YL0bRasI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705596476; c=relaxed/simple;
	bh=M7i2Rc9apemJcv/q53G9iNteQgSoOIvcR1Ufff1CYJU=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding; b=ANnY1tVug0nv4GdWvTw6JD27vyo1+PV5WWJGJDM5L8iphn+caop6s6i9qYMxgYsdV4cL2C3dFK3Sp6Lk25+ZQHTti5tILV060mgURCdUd+NnGWRlM1cEo/+AN3OjaXEQ0NMfSzYRpOdCRIDM71WZMiAANiv2Bi9GB3eKeGDr+t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xYLw7RDs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=BIq7FgK5SqmKL3eA/CsdEaaNOAK16iay6zIkhG2TArc=; b=xYLw7RDsEFQrPizgWloa/2Owkw
	KjsFYfUhftkyIiolMnqIROO1dCJI+7EnkoY1JbLfrnD731a0kTdl8NOpZMjXcS5NhtE95PxMHZsiP
	zniBK4gLoWBIY3i9ohdG413+TnrH9iqhVcaHGfagIeezof1Z+fldOs8PNMG2Npn7pMZ9zIwtYNHca
	794FDag0ODQ9vgcXoWdlL1St7W1oaaTPCXnkLSgOfyQ+0J0bXUJBX1a9/s9baRGkPchBPwR6gCBBN
	LTgNVky1AMzFwamII6syMCBSFIe+owjGXVt2Qa+IzUiUhkyrXqeth5gP6JR//3mXZ2UsV/8t8mr9p
	YBeINhXQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rQVYX-003IRY-1m;
	Thu, 18 Jan 2024 16:47:53 +0000
Message-ID: <3f4582ac-8180-417b-a83a-0b9f362cc5a0@infradead.org>
Date: Thu, 18 Jan 2024 08:47:53 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] staging: rts5208: Add more details to Kconfig help
To: Jacob Lott <jklott.git@gmail.com>, gregkh@linuxfoundation.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240118160901.71756-1-jklott.git@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240118160901.71756-1-jklott.git@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Hi--

On 1/18/24 08:09, Jacob Lott wrote:
> The current help text is short and triggers a
> warning from checkpatch.pl. This patch adds more
> details to the help text which should provide better
> information for whether or not to enable the driver.
> 
> Signed-off-by: Jacob Lott <jklott.git@gmail.com>
> ---
>  drivers/staging/rts5208/Kconfig | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/Kconfig b/drivers/staging/rts5208/Kconfig
> index b864023d3ccb..4f9cc3f00e1a 100644
> --- a/drivers/staging/rts5208/Kconfig
> +++ b/drivers/staging/rts5208/Kconfig
> @@ -3,7 +3,11 @@ config RTS5208
>  	tristate "Realtek PCI-E Card Reader RTS5208/5288 support"
>  	depends on PCI && SCSI
>  	help
> -	  Say Y here to include driver code to support the Realtek
> -	  PCI-E card reader rts5208/rts5288.
> +      Choose Y here to enable support for the Realtek PCI-E card reader

Above line is indented with spaces. It should be on tab + 2 spaces.

> +	  RTS5208/5288. This driver facilitates communication between the Linux
> +	  kernel and the Realtek PCI-E card reader.
>  
> -	  If this driver is compiled as a module, it will be named rts5208.
> +	  If you opt to compile this driver as a module, it will be named rts5208.
> +	  Selecting N will exclude this driver from the kernel build. Choose option
> +	  Y if your system includes the Realtek PCI-E card reader rts5208/rts5288.
> +	  When in doubt, it is generally safe to select N.

That's not incorrect, but it is verbose IMO.
More than we usually say.

> \ No newline at end of file

Please add a newline at the end of the file.

thanks.
-- 
#Randy

