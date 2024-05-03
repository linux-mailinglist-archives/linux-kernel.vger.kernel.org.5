Return-Path: <linux-kernel+bounces-167289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9438BA743
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051361C21682
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 06:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D111465AB;
	Fri,  3 May 2024 06:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="eprVmb7G"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032B057CA8;
	Fri,  3 May 2024 06:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714719307; cv=none; b=s1MP19t+Cog20fzvDFLTQ5z/ECiN9RXdEYTOOuLx1t1ZuO7dpptkFmu5b9ymXEcd+dK5CW0KZvTqQ6N/JOXGHFFwRFdJqnwtcjMeIcScEXrl7D6o5qssYn6fj+N9dLBPfglW9zdhD/j8sNuDlAtjSr47tdyK1gQBDkLyq5xfwAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714719307; c=relaxed/simple;
	bh=aeR6d7QNpNGKgjioiG0+Wi/T3DUmWoGfYOl6RO/Rd8o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MiEbue7WJZ9u8qSTAmUQfOPbj28AvPe5mb5fYlFAupRxClM7AptoDEDyzWR4lQ88HExsrkvYFUgtg1GsWXqLXwKzNdtxbFurgGVPe+KHFk+1MjGgEbATnR35XfwF8r5s9DxHAqMoL7M/rIj5V98FTr2utiErkP/HnHZSnY/y7uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=eprVmb7G; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pAEE6F/lHC0qjSxFbOHdQMXput3X1kOxyC2NSyVYBlg=;
  b=eprVmb7Gv+jGy029uLyHQLJIW3qkFZGOd5emIquo3oByYR9gRPfZWw0o
   0nsW4ZHbSPUrwxDe3CCQMiGhDVS5wHi8Uy7Q5XV6KrkKG5fk4jMn1xaTX
   EZZ5+C+HSUcI29As3FffHJTd8J1TOWSZ0QcI1MJ9dDq8eAQ/YNnQ2m3h+
   o=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; 
   d="scan'208";a="86281735"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 08:54:56 +0200
Date: Fri, 3 May 2024 08:54:55 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Ashok Kumar <ashokemailat@yahoo.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
    linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
    outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: fb_tinylcd Alignment to open parenthesis
In-Reply-To: <ZjRDUO6/M+RDCcQJ@c>
Message-ID: <c8d24241-1763-f7b7-4491-2e5aa3ea3be@inria.fr>
References: <ZjRDUO6/M+RDCcQJ.ref@c> <ZjRDUO6/M+RDCcQJ@c>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 2 May 2024, Ashok Kumar wrote:

> Corrected coding style CHECK: Alignment should match open parenthesis

Ashok, I think the code is nicer as is, because it has all the constant
numbers lined up.

julia

>
> Signed-off-by: Ashok Kumar <ashokemailat@yahoo.com>
> ---
>  drivers/staging/fbtft/fb_tinylcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
> index 9469248f2c50..60cda57bcb33 100644
> --- a/drivers/staging/fbtft/fb_tinylcd.c
> +++ b/drivers/staging/fbtft/fb_tinylcd.c
> @@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
>  	write_reg(par, 0xE5, 0x00);
>  	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
>  	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
> -		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
> +		  0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
>  	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
>  	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
>  	udelay(250);
> --
> 2.34.1
>
>
>

