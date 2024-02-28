Return-Path: <linux-kernel+bounces-85828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A56A86BBE4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8CC1284DFF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997DC13D306;
	Wed, 28 Feb 2024 23:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UX+Nty8i"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1ED13D2EC;
	Wed, 28 Feb 2024 23:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709161393; cv=none; b=Yvfb2eNwT+OQBMKBthtFAiJGShbO8OSpTdWabzd4IdMi9JBxkeJyfdWmySIICybCs1fYFeTPt4vEu2tFDpSXG/dTwoBuCfw1xj27qHDU1crAlm9a5pM/KWFlAmpEf4AQvLEa/SOKmC9D6RsrpEm+/vTHF4v/5lIaZcrEzdCWj1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709161393; c=relaxed/simple;
	bh=po5FvhdrjHlOz2JRmBTxwzgRG233kHblzB3DOAhWYmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nYl8Q0bCNvBOaWiSvsXE3fwddTKlZ3rZc4L/5AhXEkxaaFbqV53JgKJXuKfaAJEwX5+hVfRtwmZJxG/Ot6RA6Nz5BMKiHkh1TE2UlFbXBkFVXqOVLmRvgTfZnY8wqU7VZAGPnESNfhDXzq/NNu3kW9/6IwuJq43NV9vu00CRlxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UX+Nty8i; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=exl8mldDgfMmNdvFA8534z1ZX7bw2tXMon2gQ9u2Kc0=; b=UX+Nty8i10/+0ZGaNcSgbYFxUk
	AO5ZurXOhP9FZzoxqWRQO0GU/RUDUFHxGqwb2FOA+Sl61CatxoT+LKm39IC5KitnyGuagPpu5Ruid
	nnvoz7pyl2Ae6d/ZlL2KelFwbu/Zmf0XgNDU4OFHa743DSKPlFiUCbaCErD0Bi36BoUfTPvy8wNY7
	XDe/lv4aeFh4EsSNqdkH6mNbRhP169iFSbBmeAGpZZLdLJD18wmbHVPTbENlNJMZZiOukfxxNvjb/
	2+cN44S66anzAxL8bJtCm31tWXih94rXyD8/wNXSorOWFkYZKBIJe6mCkjjfqlp8NJHq4p46zc6oZ
	KyGmk/QQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfSxC-0000000BE5a-2kXP;
	Wed, 28 Feb 2024 23:03:10 +0000
Message-ID: <4bec9a50-e846-4507-9332-22bd7a05e7f2@infradead.org>
Date: Wed, 28 Feb 2024 15:03:08 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: submit-checklist: structure by category
Content-Language: en-US
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, workflows@vger.kernel.org, linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240226104653.54877-1-lukas.bulwahn@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240226104653.54877-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Lukas,

Sorry about the (my) delay.


On 2/26/24 02:46, Lukas Bulwahn wrote:

> 
>  Documentation/process/submit-checklist.rst | 157 +++++++++++----------
>  1 file changed, 84 insertions(+), 73 deletions(-)
> 
> diff --git a/Documentation/process/submit-checklist.rst b/Documentation/process/submit-checklist.rst
> index b1bc2d37bd0a..7d8dba942fe8 100644
> --- a/Documentation/process/submit-checklist.rst
> +++ b/Documentation/process/submit-checklist.rst
> @@ -11,110 +11,121 @@ These are all above and beyond the documentation that is provided in
>  and elsewhere regarding submitting Linux kernel patches.
>  
>  
> +*Review your code:*

These "headings" (?) shouldn't have ending ':'s IMO.
Maybe they should be real headings?

Otherwise the patch is a very good & welcome improvement, although as
Jon said, the file needs some TLC. (after this patch is applied)


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>


Thanks.
-- 
#Randy

