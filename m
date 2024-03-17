Return-Path: <linux-kernel+bounces-105594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A64287E126
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 00:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22881C210D0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 23:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7B821A04;
	Sun, 17 Mar 2024 23:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sp4C0qsu"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240ED1D530
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 23:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710719268; cv=none; b=d23Q1JapIZcOah6iqhSCu4jWCKZWt71/phPIGmFqIPmlM9dpnolSLcg7s5iP1xhe4ys322N2e646+EHeZq4Yul0Flw6Cd9fDMO3dlSXTO+Eh/6S9vqEpQmzFWFpoRZN+szbYG7Z6Oz+ZdHXocN2FYpei/fdH6NPk6HCxVgelpqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710719268; c=relaxed/simple;
	bh=1t5THr41G20eGcgPBEBTTLvNWvw/QIvdXIoz3LkmfgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C88t8yYWTvffiu6AVLSGjBWVm2PmnWpKb+cRPruPWHdM5ScXF53e1VOIB7RIzJVmD8WGjPCQDLUcwEnuzjv9MiTPDothZL9tYWJIOWUZ62i6Jj/10RiE6Ex2CfzF/udluev47ybP/sYhKhW6ObmODaHPydiBD0i6+AqETjgzsco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sp4C0qsu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Cv73hQVexyl29yDPslEqVrExNAO6VzVtfMqzi6E38Gk=; b=sp4C0qsudZMIXrDjSMy0ENeZxP
	fMw5hfgtycU33pow6CVoBqQJvtTjhsyQTXBoyTmbF4srzfR5QOZQhsrfBQKpjsfebRnLwgFr0eTeN
	3gGzcDzmZZwEMLzi4rCxlEYsxJbCt8+svrpF0L78p0eOfjt6IHzWw9rJjrdFhoCmSkbQTOnrOVku0
	P3iMFvMleAEqxPm88qz7q5+hA0DAJdgKbOaa2HtXOLpnWrUZt7lnSUuxTLtQRLbe5ThqPc1DmPk8X
	XftydgA3Z1QD89HNcNu3A4a5Fzi0tv48lXUTkrjRON5VCq2H70u77SH79oOV0n3pFGpbloTY6eb7d
	YbSk8XMA==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm0EC-00000006m3N-44FA;
	Sun, 17 Mar 2024 23:47:45 +0000
Message-ID: <252d1ba7-0ae0-4616-9ee7-f7c204531eaa@infradead.org>
Date: Sun, 17 Mar 2024 16:47:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] init: open /initrd.image with O_LARGEFILE
Content-Language: en-US
To: John Sperbeck <jsperbeck@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "ndesaulniers@google.com" <ndesaulniers@google.com>
Cc: linux-kernel@vger.kernel.org, Nazerke Turtayeva <nturtayeva@ucsb.edu>
References: <20240317221522.896040-1-jsperbeck@google.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240317221522.896040-1-jsperbeck@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/17/24 15:15, John Sperbeck wrote:
> If initrd data is larger than 2Gb, we'll eventually fail to write to
> the /initrd.image file when we hit that limit, unless O_LARGEFILE is set.
> 

Could this be related to
https://lore.kernel.org/lkml/CAHY78BqCpMQptPN0SMaXuRqHOhYi+wnMEUSTYt7OHDZih4e7yQ@mail.gmail.com/
?

Thanks.

> Signed-off-by: John Sperbeck <jsperbeck@google.com>
> ---
>  init/initramfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/init/initramfs.c b/init/initramfs.c
> index 76deb48c38cb..b607d3463b47 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -683,7 +683,7 @@ static void __init populate_initrd_image(char *err)
>  
>  	printk(KERN_INFO "rootfs image is not initramfs (%s); looks like an initrd\n",
>  			err);
> -	file = filp_open("/initrd.image", O_WRONLY | O_CREAT, 0700);
> +	file = filp_open("/initrd.image", O_WRONLY|O_CREAT|O_LARGEFILE, 0700);
>  	if (IS_ERR(file))
>  		return;
>  

-- 
#Randy

