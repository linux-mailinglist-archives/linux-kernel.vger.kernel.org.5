Return-Path: <linux-kernel+bounces-51218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C0F8487F2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 18:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22C228137D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A086024E;
	Sat,  3 Feb 2024 17:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VUPXLoTJ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599965FEE7
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 17:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706981529; cv=none; b=ioo3yih1EvogVf7cg/VulVjMAvjCw7Q53U9wpWjjvd35VqO59JLy8FRabRG0eJaimxvUWnJ7zL5KcLNmbQL+DlSIa1t4xQeHRWoZOm1rjXbzc64lM+6L4FQwXJS7RgllVJPNzuMPjON23QFb7yUByFJy6L8XReA82cje2PJGatk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706981529; c=relaxed/simple;
	bh=VwR3zutVS0uEKwi4VgzaB++PSbnmSrsNGy1s/umlIrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iOWQZ4gKWzgKVw6omDDCyP/NT1jY1tL9qrEJrfburo7o2EQ0vsMlyC9PJXsJ/jGr6GJbs7sdt/BGIoE6BpsyZ27AouwWWphZvJ3KwShL9Pm8sRqY0gyx9ZASDug3WX0OQaqyfR98rif14GhbKRnrXyU2kcnKUf7cNI/TXIzXgtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VUPXLoTJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=MhL9OboriDWOQ/IcSl1XLlPTkzE8DwF7KcaXw2ZY+1A=; b=VUPXLoTJy8RGTCDnFjhGL6zvge
	BAK4KgFptG56vRYxqSA4KS5UwHWchuF28gVik/e2WnvKRelmiiFs8IdJXl3U/qPUA2Kgy5AcaZ4Lh
	SzvWmP0tbsA333Yz4bnSsskfDfYpJyo9Ftv/v4OfWEzfPBEFdgPtSvxBllP6KEFln8sjE2VJxykCl
	Omql/gyf6lGjvx6PuzWHzo2M7kYNJI0n0xLYLtVouzhlSsWh6rdTmVrc56xL5k+nAnqVc6u/BPcLs
	O8vuEj5QMFGjqPMb4xsjbvPk2S0qQ+2fIQeZEZMucl4ePpUuFM+c92546dYIa74x2KaLgoiQviUXA
	x3xg9iZA==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWJs4-0000000Gvrs-479K;
	Sat, 03 Feb 2024 17:32:05 +0000
Message-ID: <bbe127fc-11b3-4c0d-829f-c33654441401@infradead.org>
Date: Sat, 3 Feb 2024 09:31:59 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Task: Extra credit : LKMP Bug Fixing 2024 Spring :
 Documentation
Content-Language: en-US
To: Abhinav Jain <jain.abhinav177@gmail.com>, skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org
References: <20240203130725.14802-1-jain.abhinav177@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240203130725.14802-1-jain.abhinav177@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 2/3/24 05:07, Abhinav Jain wrote:
> Added a prototype for dget() to fix the warning
> 
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
> ---
>  include/linux/dcache.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 3da2f0545d5d..b082b48e7eb5 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -301,7 +301,7 @@ extern char *dentry_path(const struct dentry *, char *, int);
>  /* Allocation counts.. */
>  
>  /**
> - *	dget, dget_dlock -	get a reference to a dentry
> + *	dget_dlock -	get a reference to a dentry
>   *	@dentry: dentry to get a reference to
>   *
>   *	Given a dentry or %NULL pointer increment the reference count
> @@ -315,6 +315,13 @@ static inline struct dentry *dget_dlock(struct dentry *dentry)
>  	return dentry;
>  }
>  
> +/**
> + *	dget -	get a reference to a dentry
> + *	@dentry: dentry to get a reference to
> + *
> + *	Given a dentry or %NULL pointer increment the reference count
> + *	unconditionally and return it.
> + */
>  static inline struct dentry *dget(struct dentry *dentry)
>  {
>  	if (dentry)

The function documentation now makes it look like these functions do the
same thing, so why have both of them -- or am I misreading it?

Anyway, this problem is already fixed in the linux-next tree (more specifically
in the vfs tree).

Thanks.
-- 
#Randy

