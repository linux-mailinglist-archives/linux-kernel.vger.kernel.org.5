Return-Path: <linux-kernel+bounces-89826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF86786F62A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BAC31C220B2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588616CDA5;
	Sun,  3 Mar 2024 16:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="byLmC7rM"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781B966B5F
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 16:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709483817; cv=none; b=B6NFAZQP2hWyVNnFsf6mXB/Z7aF7ElSHhc8dfmTFiALI/70hmEGai3+FtKjjDczB1Cwxrc/W/WCnN63MkZ7RT6X1zgY6c9vcgCvQYNk4LuJXTlkEbDIs9Vu8+f+raFjmERPFCjodpP+ullkTGujOk+luc2Y4pO6l2YO0s+ApkS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709483817; c=relaxed/simple;
	bh=iVEVVafPHLIsnU6JVQedkPVmE9o83ai58lzcRJQ1XLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bddNWe7vqj4mG2DzfcSL0rhnrTM34/Vwf9IAg9a2a2K01Hv4Tz79J6v9wF2I3yNJW+F8qZxETp4zFmYpOOWso59WzWW1VIkcjhj76JuQfgGY4wtlUHSN5QpCy7vqOQIQlzhU6IeirPX8t4/iGvkZOpsJ492rez0fYhq9cV6yrRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=byLmC7rM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=tSswBdIcszDJoDe9Vi8pnuS2WTvFPCmOZO051C3dxKM=; b=byLmC7rMmjeLz0US861q1IrR7R
	IQbPqrmvZLo+d9gIbCSHG1dzWeOCiwoo9J0+pQRIfrybvbIRarvyosXTpVwRiMGjlDnRI+vgQBrhW
	m6YlLLdXfwuqsNal5V2vZnPjOuG61Y29ges0vQu2a1Bxd9DXUR+HmWjGPwDNo5nrB4MvlBGu9vmMe
	aRTEyUVbR5lg7i8k0X05EpsQw03v6OyDcPwI8OB2QkhbJ4KfkQqKjNUDxPXm3auq2oUUmj871eJ2P
	1/P3MixwaR7KnoUPEZqL/cmwbjLFzXPKTKKM7YyTzFZr13pXSS4hAQ6B/sQ7EbYvrT37BAb0weNdM
	kjfkxXOw==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rgopZ-00000006IUw-1oWo;
	Sun, 03 Mar 2024 16:36:53 +0000
Message-ID: <aac03d82-1a07-457e-af5e-f125e05c66de@infradead.org>
Date: Sun, 3 Mar 2024 08:36:50 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Removed controller field description to prevent
 kernel-doc warnings
Content-Language: en-US
To: R SUNDAR <prosunofficial@gmail.com>, openbmc@lists.ozlabs.org,
 iwona.winiarska@intel.com
Cc: linux-kernel@vger.kernel.org
References: <20240303134453.5791-1-prosunofficial@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240303134453.5791-1-prosunofficial@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/3/24 05:44, R SUNDAR wrote:
> /include/linux/peci.h:84: warning: Excess struct member 'controller' description in 'peci_device'
> 
> Signed-off-by: R SUNDAR <prosunofficial@gmail.com>

Yes, or
https://lore.kernel.org/lkml/20231223050605.13961-1-rdunlap@infradead.org/

so
Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  include/linux/peci.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/peci.h b/include/linux/peci.h
> index 9b3d36aff431..90e241458ef6 100644
> --- a/include/linux/peci.h
> +++ b/include/linux/peci.h
> @@ -58,7 +58,6 @@ static inline struct peci_controller *to_peci_controller(void *d)
>  /**
>   * struct peci_device - PECI device
>   * @dev: device object to register PECI device to the device model
> - * @controller: manages the bus segment hosting this PECI device
>   * @info: PECI device characteristics
>   * @info.family: device family
>   * @info.model: device model

-- 
#Randy

