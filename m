Return-Path: <linux-kernel+bounces-67831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7681857198
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E961F2160C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD44813B299;
	Thu, 15 Feb 2024 23:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M+OESzYP"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2727E145B00;
	Thu, 15 Feb 2024 23:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708039688; cv=none; b=kloVPUVNzYDrOPTmcBXPlyvAxN0bNnURURSPZiw4mkQYIRDRB64XvwG4sSnhpxr8hw2QC8C/7CnCH3qMOJdW7PJXagJREnfVr06Mi2BvmpWHcTA5Y8iNVcfHr9EgB9t4KJ8Q+SR84Z6/jC0JIxvZvtc5pP2RUtbuHk2sJgDWf5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708039688; c=relaxed/simple;
	bh=n4G9uH3FuaxtaDs7VOwu4MfOMqdQcRQMlzTGYWvdfQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ef2y4MEmJqVRzfihv3VyPzlngNOHSU7JEPbYqaHasMvT0zllXaHgvm4e/znc9qca5oH/BY4scEsU5bnRcUq7DOiBH1/4k1Z8mb3as9WJS0rk26HnEIymbHPaHPV0YiPfKfdn7N77DdKaSJCXtEoD7sRrcfBS3sbq68Ddwfhuimg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M+OESzYP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=iZftUgWZ8SaYplQOiYsHmVonfTNje6FlH1kX5tBg4q0=; b=M+OESzYPxVIuS6O1CdH67Duf+9
	kyjCRsoAhQJRvHmRrKo76p3rthULUdPAw1J38+cKiv7k4uBzgVmBp83wuLQB+qFDV+YY17Gnvh6ow
	n26onabl/V+XNMrl+i/25k0/NBlI9QYceFv3UMfg1i6lj6PCPbekfKuueeZCVagrwgSs17X4tTYDf
	wb8A50LLrRcmj9TKiq7xmQNXAh+kgRg3pfprDyycjhS7ETCxVqemt52Sl5OtFnMllfT1Y1bM/x+Wn
	WHCuB7oM4Ei4nSWgxbN4BQw7f3/ASRm2L1hCy+zzX8CSTB1o+3ml5fzUpgt65p/JE7phabjSFLyyC
	1hwKeeMw==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ral95-00000000TEr-1QJz;
	Thu, 15 Feb 2024 23:27:59 +0000
Message-ID: <b3f86324-afa2-49b7-9565-28f41aaf3334@infradead.org>
Date: Thu, 15 Feb 2024 15:27:57 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] alpha: merge two entries for CONFIG_ALPHA_GAMMA
Content-Language: en-US
To: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240215141120.1911369-1-masahiroy@kernel.org>
 <20240215141120.1911369-2-masahiroy@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240215141120.1911369-2-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/15/24 06:11, Masahiro Yamada wrote:
> There are two entries for CONFIG_ALPHA_GAMMA, with the second one
> 7 lines below. Merge them together.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/alpha/Kconfig | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
> index 70e8343d00ba..581ca8c73d67 100644
> --- a/arch/alpha/Kconfig
> +++ b/arch/alpha/Kconfig
> @@ -390,16 +390,12 @@ config ALPHA_PRIMO
>  	  Say Y if you have an AS 1000 5/xxx or an AS 1000A 5/xxx.
>  
>  config ALPHA_GAMMA
> -	bool "EV5 CPU(s) (model 5/xxx)?"
> -	depends on ALPHA_SABLE
> +	bool "EV5 CPU(s) (model 5/xxx)?" if ALPHA_SABLE
> +	depends on ALPHA_SABLE || ALPHA_GAMMA

	depends on ALPHA_SABLE || ALPHA_LYNX
??

> +	default ALPHA_LYNX
>  	help
>  	  Say Y if you have an AS 2000 5/xxx or an AS 2100 5/xxx.
>  
> -config ALPHA_GAMMA
> -	bool
> -	depends on ALPHA_LYNX
> -	default y
> -
>  config ALPHA_T2
>  	bool
>  	depends on ALPHA_SABLE || ALPHA_LYNX

-- 
#Randy

