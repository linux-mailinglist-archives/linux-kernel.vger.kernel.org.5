Return-Path: <linux-kernel+bounces-62235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A50F851D64
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3632B25D62
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E654596F;
	Mon, 12 Feb 2024 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hNPlL6zg"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C5C45954;
	Mon, 12 Feb 2024 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707764066; cv=none; b=jOjTrv7LwxRX5atuT+mC/3EGzP+VaIx0LbowaPfhj8DdTbBRTr7YN0I9CXUrB0N+8RiLKmLucW2+ngtLUZYl1H7vjy8gtfLG93fTCtzpzVisKBNJBhC59QXaQ6a8wMKOx+2f0vxqKIaQNzk8rWuY0Y/81trzOLWGSqPvIfzpdmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707764066; c=relaxed/simple;
	bh=qmRp03WZb8lOLjVPoXnFu+Ir0msxCpbGH7H9I7A71As=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i56yOaOFd/JedwqtbitPYk10X94U08xHdpLj1Xqz2JFPfuNLyNw9M4vWASVXxCvAXpO7214UEKozTDFe4XCWy8udbaLuUwJUwkF0B25KLINw1y4Upf3tgfNRoVaNLvQFf+j8CVkG+PMa/t0eYNxwLyn+z6/ppkkHg54VxdZV7R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hNPlL6zg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=JfVFUY2jxXKEyGIce+qaR/PTZVUtr7SBgbrlEw95Xtw=; b=hNPlL6zg2NqlAIJzHEHKeIhgWw
	fEb6n/Nlp+z/bMWK1NpeC6egVKyiUJ4y6BusyvQDmG0hRzPfjvZ6Su+p2j/eKrZJ+RWfjR29jRB0B
	ow29us7r4UYCI+wSlG1EkxLu2wcggJ19TDmExPoW12pIPFKR4maZjkLqskSDCW7uplQp9UHuXRvOQ
	N3gKSE6vdD7cfZYqxdfjeMaF3MAAkPV4qsLQ1oiNjag5SWWleICJFyZyfzJ4jqVzQpJg4aYoPcaJG
	kIiRXKjxAwEg5o7GeIRfFWEczQo5VkWClMBTxkRUjlOGrL4zFbSwL4JmFSkAXevWyzz6IjdGxD8jO
	liCrJa9g==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZbRf-00000006hIN-1jOK;
	Mon, 12 Feb 2024 18:54:23 +0000
Message-ID: <eee7652f-939c-4ab7-a400-4591e7de6fc2@infradead.org>
Date: Mon, 12 Feb 2024 10:54:22 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Powerpc: ps3av.c:(.text+0x19e8): undefined reference to
 `video_get_options'
Content-Language: en-US
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Linux Regressions <regressions@lists.linux.dev>,
 clang-built-linux <llvm@lists.linux.dev>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Geoff Levand <geoff@infradead.org>, Dan Carpenter <dan.carpenter@linaro.org>
References: <CA+G9fYuRwO6FLZ4do1wR0RdiZh9NGpRLKckQcKN2aAkqBH7k0g@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CA+G9fYuRwO6FLZ4do1wR0RdiZh9NGpRLKckQcKN2aAkqBH7k0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/12/24 10:36, Naresh Kamboju wrote:
> I encountered the following build warnings/errors while compiling the powerpc
> kernel on Linux next-20240208 .. next-20240212 tag with clang toolchain.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> powerpc64le-linux-gnu-ld: drivers/ps3/ps3av.o: in function `ps3av_probe':
> ps3av.c:(.text+0x19e8): undefined reference to `video_get_options'
> make[3]: *** [/builds/linux/scripts/Makefile.vmlinux:37: vmlinux] Error 1
> make[3]: Target '__default' not remade because of errors.
> 
> Links:
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2cFkli5H02fikrpga6PluAWLAMa/
> 
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
> 

Hi,
I posted a patch for this and Thomas Zimmermanm says:
  The patch is now in drm-misc-next. 

https://lore.kernel.org/lkml/20240207161322.8073-1-rdunlap@infradead.org/

thanks.
-- 
#Randy

