Return-Path: <linux-kernel+bounces-86151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D45F486C078
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11FA71C21441
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5AB3BBFA;
	Thu, 29 Feb 2024 06:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="svmXMS1Y"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1047A3BBF8
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 06:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709186485; cv=none; b=LKnA3qeiNM0X7+1d/7O05jMSkRjbCyuA8TQWCVot4ZKWAyXqj6cPPKjXBAM5N8OnFi8VhGZYgHskpn6ZQYeowOeftxO05WK1Zf245Qmqb3FlSA63QKc68muiBZanV9+wd+3f91ggrrGdlH9mGzVt3gSBqKMKtZByeT0H4Zg/F+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709186485; c=relaxed/simple;
	bh=v+/7/M/RuPdphWURBIjWGwRpw8jH8l+KVqLoWubjNR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nUKVpxCh5uHqSgemYYxaXahwIUK/on/t0oSAECApLXUJiS3hD459VFFEt0hJx+zbhh9yBUn4e14C+pzSlju8OWQaUQnKjcNwCBpRPyNnZcOtlL5rU4H1PGqgph8c0kvS1GeBYWr5I8DE0i6rz27QpyxEhtCrNL6T5j9nUGlp55M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=svmXMS1Y; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=QEuKH/6UaYJl1Hnh7XRGcIuXUwl+r1LjxXzwV62HuyM=; b=svmXMS1YKaYv59dF3qCqvwhRG9
	v3qFPGJiCkQSGqM++SlB/0zlyuxZjVu2ls+SWrfVEc+fRPHImPecO4JOC3otKpRAVxa+G8mC2yPG8
	2FfVfUHmRsj9Wab+rR5+Qoc55a4x0JWMDfm/JYyKKAO2T25DeWWz3dIBH12R6OjrC6yW0YqFmfWzu
	CDMSwPZbeJNWHOo8lLSEyZ0caZ7DEXpmcRLw9aNrH2enjFGv15mmkst2oEvk+7iz/kSGwPOvdigEp
	GVHOLyrIfqTNLIiHEm6YCEyDuUJ1IZ69n6J9sXCWCfgMwnoW+e/NKEFSZq0rZmgao6Pd8AyHry/VM
	HTJC3OIQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfZTo-0000000CE9N-28XB;
	Thu, 29 Feb 2024 06:01:16 +0000
Message-ID: <d47a817f-11c0-429c-8e9c-9ab0dfa17388@infradead.org>
Date: Wed, 28 Feb 2024 22:01:16 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mtd: ubi: fix NVMEM over UBI volumes on 32-bit systems
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>, Richard Weinberger
 <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <ff29447dcee834c17e4e1e99725b9454c90136ca.1709178325.git.daniel@makrotopia.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ff29447dcee834c17e4e1e99725b9454c90136ca.1709178325.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/28/24 19:47, Daniel Golle wrote:
> A compiler warning related to sizeof(int) != 8 when calling do_div()
> is triggered when building on 32-bit platforms.
> Address this by using integer types having a well-defined size.
> 
> Fixes: 3ce485803da1 ("mtd: ubi: provide NVMEM layer over UBI volumes")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v3: use size_t also for 'to_read' variable to avoid truncation
>     (no problem in practise beyond the compiler warning)
> v2: use size_t for 'bytes_left' variable to match parameter type
> 
>  drivers/mtd/ubi/nvmem.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Works for me. Thanks.

Tested-by: Randy Dunlap <rdunlap@infradead.org>

-- 
#Randy

