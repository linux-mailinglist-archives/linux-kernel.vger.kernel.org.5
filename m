Return-Path: <linux-kernel+bounces-61087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234AD850D19
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 05:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4CFB285CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 04:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD5953AC;
	Mon, 12 Feb 2024 04:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rZsmJ4al"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CBC538D;
	Mon, 12 Feb 2024 04:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707710771; cv=none; b=VZobya5cnPeZseXk2IzP33qNi2A7skhJPu4I+JxJxouHwheEUOcxYXeK2b1p7YpoTIXYgRXmfSNB0MCfnanICR0c+zJJSdiNmiE/aohgKz2huEJPEJvXJjWRhHKanWonGoyqp2kvKdzMByzztd8I0nzfnZPlUTttkn3TLxJZ8Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707710771; c=relaxed/simple;
	bh=xBwF96nJOksgK86pKMMz3s/InLBpVQHlNd5e8eTlCaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DUAC7GAd8BbcuLJprwLzXE1NwRfVh5X2h59qKb1aP/4RSwZ5df3UWufoNfUvJXNdP9oKOM2ZlXpnE6uTd4K44hy+0jxTeH5X1XfFW/h8nCyOCUcVKoNPL4mGH7WbXcJtQLXZlM0S+9qnQb5S/20mWkP/z2ZQkXNugMzUspoM2Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rZsmJ4al; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=N3tkQyZWehu+nsbocXZlYk5thoNPJPA3J/ybSm8Lq1A=; b=rZsmJ4al9ChG8rNpyHqQUOkMee
	48uLcbXU9mV+sQOejL2xUhRjKDBCFRxAyg4W23l0QBWVNoDh27tmlojG1DEeX8VGTGYyJ7qvBoAzw
	+pTv23MPNTceru84P4QHMYB28OxvcuZeR3GGOYCiRuzZ+9uWLljnARKQhIblDp5fh8d5LOSqoTBaM
	nUYHsNq5+/qdHr256wzPqXMX1BoWZ+tepkIPhCIbSEtUNuKCmzDRJEf0GiHCh7EnSEbJguJCSh/Rk
	ikYWBBUR9S+7OmwovUtGifu9hcDnJrTH7HGPVhpHhTdq7Ik41xbevzEFwMjDB9A+WKr7qWoi1+kR5
	+shC3b9Q==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZNa1-00000004HWx-1UWn;
	Mon, 12 Feb 2024 04:06:05 +0000
Message-ID: <43a8357b-ba05-4cd7-87ba-236c5bb73fd6@infradead.org>
Date: Sun, 11 Feb 2024 20:06:04 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Documentation/admin-guide/pm/amd-pstate.rst: fix the
 warning: Title underline too short.
Content-Language: en-US
To: MarileneGarcia <marilene.agarcia@gmail.com>, ray.huang@amd.com,
 corbet@lwn.net
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240212034015.120697-1-marilene.agarcia@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240212034015.120697-1-marilene.agarcia@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/24 19:40, MarileneGarcia wrote:
> There was the following warning when the documentation was generated:
> 
> Documentation/admin-guide/pm/amd-pstate.rst:384: WARNING: Title underline too short.
> 
> ``amd-pstate`` Preferred Core Switch
> =================================
> 
> Signed-off-by: MarileneGarcia <marilene.agarcia@gmail.com>
> ---
> Change:
> Increasing title underline to solve the warning
> Thank you.
> 
>  Documentation/admin-guide/pm/amd-pstate.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 0a3aa6b8ffd5..322488a0b2c9 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -381,7 +381,7 @@ driver receives a message with the highest performance change, it will
>  update the core ranking and set the cpu's priority.
>  
>  ``amd-pstate`` Preferred Core Switch
> -=================================
> +====================================
>  Kernel Parameters
>  -----------------
>  

Hi,
This patch:
https://lore.kernel.org/all/20240205060305.3594942-1-li.meng@amd.com/

has been applied to the docs git tree but apparently has not found its
way to linux-next yet.

Thanks.
-- 
#Randy

