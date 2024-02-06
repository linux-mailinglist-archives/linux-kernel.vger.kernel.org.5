Return-Path: <linux-kernel+bounces-54946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E0884B542
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79780B20F2B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4A15677B;
	Tue,  6 Feb 2024 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="O5h5sb4k"
Received: from smtp92.iad3a.emailsrvr.com (smtp92.iad3a.emailsrvr.com [173.203.187.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6CF133439
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 12:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707222412; cv=none; b=mMIH0JxbtggE1upfvF4gTc6VeEVPOAaZL2Y51lPvToR6mEWF33Zu/RdraYrCXrJPmO3kB1fTZna1c7eQ4WrhjjlbXcrj8Lm1hdnEvqOfm3/rR1s3MazRVHbdAPasH5YKCSf4ALunmN0+Wnhj8yZMXUOhwKhrLtEHRMI+0yrIFFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707222412; c=relaxed/simple;
	bh=mCXHlMsrALtmUvBNu+kuM9UWAh6UhPaYeNVpy42lO80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iU/iwxhVSYkA4ba0fXhic5Az//yPEkOb8pIKiTvT8asQxU1dcH7lua4lD6XsXPaJJivnwwmdxkLEbDrrd5XneCiLqXgoK8qhsheQNdfF0agmkyXF/g3fJf2zCWKwojuz14hzylYo1U9ezaHJurUtjVpRItJb7WWCPQlNakKlJgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=O5h5sb4k; arc=none smtp.client-ip=173.203.187.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1707221983;
	bh=mCXHlMsrALtmUvBNu+kuM9UWAh6UhPaYeNVpy42lO80=;
	h=Date:Subject:To:From:From;
	b=O5h5sb4kot0BzOpfh8MMvbiJwPf2rUYy28Pr/uYnHylFZxsyAy3EQP0kwmaup50bF
	 ZB+6zmkcUd1a5H4KbnhVsmv8n0vDBQx67IoZlIXqk1HxSP1JNGovZ+cdVGpK2MuI4b
	 IIeYBHJdbWQhxJ2nLGQIlaRluO1TP6s2EMnvQyBA=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp28.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 625823885;
	Tue,  6 Feb 2024 07:19:42 -0500 (EST)
Message-ID: <f61a1401-bc7f-4b8c-90d3-8327b9692422@mev.co.uk>
Date: Tue, 6 Feb 2024 12:19:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] comedi: remove redundant assignment to variable
 range
To: Colin Ian King <colin.i.king@gmail.com>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240205180436.1841706-1-colin.i.king@gmail.com>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20240205180436.1841706-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 8fa3b390-ade1-48a3-85c8-0a992efc5f2c-1-1

On 05/02/2024 18:04, Colin Ian King wrote:
> The variable range is being initialized with a value that is never
> read, it is being re-assigned later on. The initialization is
> redundant and can be removed.
> 
> Cleans up clang scan build warning:
> drivers/comedi/drivers/das08.c:180:2: warning: Value stored
> to 'range' is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   drivers/comedi/drivers/das08.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/comedi/drivers/das08.c b/drivers/comedi/drivers/das08.c
> index 5d5b9174f88a..49944ce1f813 100644
> --- a/drivers/comedi/drivers/das08.c
> +++ b/drivers/comedi/drivers/das08.c
> @@ -177,7 +177,6 @@ static int das08_ai_insn_read(struct comedi_device *dev,
>   	int ret;
>   
>   	chan = CR_CHAN(insn->chanspec);
> -	range = CR_RANGE(insn->chanspec);
>   
>   	/* clear crap */
>   	inb(dev->iobase + DAS08_AI_LSB_REG);

Thanks.  It looks like it gets reassigned to the same value further 
down, closer to the point where the value is used (within an `if` 
block), and so it doesn't matter which of the assignments is removed.

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-


