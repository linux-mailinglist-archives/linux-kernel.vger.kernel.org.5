Return-Path: <linux-kernel+bounces-10928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E8781DECA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 08:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37FC91C216E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 07:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409D215C6;
	Mon, 25 Dec 2023 07:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="chvaUfzX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66A3139E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 07:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=G5XIw5feX+mPwv9R7LNhkJ3GhZANjLo59n5/z7JlzAo=; b=chvaUfzX4dWIFDo6I5khK+zOzH
	WvZnVGOsxP1XB4GPjLu8X8tPE2bFL9iuJDJgBQPbpiGgetIRvN0+PYDQY6+AGgUkCS7qO8KUv//H1
	CFuz+358w6XGUFQ7neFgSd0SwOp6RKEdjVDKyeo6cKb1YM4u1GWhQgDhOXjnvc8vhtjXZKRvBrCK0
	ZS9Fa4hrHhPRfV9QPvPJ9/d6N1HmrHz2FzUf1x0La/L1fL+aDSW0Up53n6B0w6H2jephkRNm8e4ve
	1d/U3aqA/e7s/TMD9zaAagUTCQCfInmEBmZxAmCMA1zXa4onQhrgcAp8ZJ/Z/rvbe2WROOOcJJz8x
	39KLbouw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rHfF0-00AKsg-0j;
	Mon, 25 Dec 2023 07:19:10 +0000
Message-ID: <3464b187-d280-4b7f-8187-123dc51ad0c3@infradead.org>
Date: Sun, 24 Dec 2023 23:19:06 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] ubi: Use the fault injection framework to enhance
 the fault injection capability
Content-Language: en-US
To: ZhaoLong Wang <wangzhaolong1@huawei.com>, richard@nod.at,
 miquel.raynal@bootlin.com, vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 chengzhihao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20231225071055.1721000-1-wangzhaolong1@huawei.com>
 <20231225071055.1721000-2-wangzhaolong1@huawei.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231225071055.1721000-2-wangzhaolong1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 12/24/23 23:10, ZhaoLong Wang wrote:
> diff --git a/drivers/mtd/ubi/Kconfig b/drivers/mtd/ubi/Kconfig
> index 2ed77b7b3fcb..138fae7e8f96 100644
> --- a/drivers/mtd/ubi/Kconfig
> +++ b/drivers/mtd/ubi/Kconfig
> @@ -104,4 +104,13 @@ config MTD_UBI_BLOCK
>  
>  	   If in doubt, say "N".
>  
> +config MTD_UBI_FAULT_INJECTION
> +	bool "Fault injection capability of UBI device"
> +	default n
> +	depends on FAULT_INJECTION_DEBUG_FS
> +	help
> +	   this option enable fault-injection support for UBI devices for

	   This option enables

> +	   testing purposes.
> +
> +	   If in doubt, say "N".

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

