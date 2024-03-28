Return-Path: <linux-kernel+bounces-123261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE260890566
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C6AE1F2682E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888DC4174C;
	Thu, 28 Mar 2024 16:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AUa6c9Ye"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12047F487
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643735; cv=none; b=ljlLcx1044AXSJCgJqDpQl+4aEVmP5pxL6RDcIvd/NW5Tm87fTAvPlh1qep1dnZhnwXSE2BcwpHKstegt7wU8KQYbyphJhPLswa00MEn5FurF1usmZQoSV5ympT+FcflwHN+WGazNRUuu1tJGZyEI9xZzrXM2XzFYO1meagxGjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643735; c=relaxed/simple;
	bh=JWJtXJcUZY3AnWXjwt7iRcnwQ6zGkVqoL86keyxldpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tc+eNOGXzVlN7d7E1UQhdgswxvwWP7K7mAmmym24ZvSVy9hbWGVrZGYZu26HDm1j4VapOi5LIPCJvzyZgEJReUSoq4LdpfAn3OwnFmfPs4hgbFwxHGyfVXJ4YoFni25RS8bZHSLRHhue0cGRXSQMiFwJVcFhaDabKAG/YqXMH1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AUa6c9Ye; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a47385a4379so407981866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711643732; x=1712248532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RCUTxfQ4sQDe7I2H/wHmYFn/xpUZAljeyI/mp/W6HYg=;
        b=AUa6c9YekRcEfZcIg/J5sRVL0dpS4z2T8h9ICdWQjn9RBzvfW0B0sJG9ps/JOQ6R0C
         8KYKkX1ojKRV4ZaTUP6xDVrLb6AbzJIdkrhIDibz1lUbdAUI2tv54xCbw+L9oz+2GX9a
         R4CeC34mwXDTqZ+/hk/oFSXrwLl07j2qypSgdc1/eQyNmlNmR/xblWOo3AhZm4kruIOU
         S7vgp28nXa/+Vfzn3QnYftEzABn1CqD4QxYzdGP/yZrVLL+5t7m2EmqXJ8BgNbwTJ7pa
         86sF1JV443zIu1F1K1ceQa4pcl1TKtNRbIeA0oxXFls5mrfIpmZEVMAh39T+W4gzAUi9
         cqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711643732; x=1712248532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCUTxfQ4sQDe7I2H/wHmYFn/xpUZAljeyI/mp/W6HYg=;
        b=wV47lNyIzF2+w5oBi3jFApME2DnN7RL5YMHu02oUMxC8AH+BrmO1y1sBgTWVeHgmqv
         03wjtCzQNuIEFtrewRuPkp9aR6tx19VVNqNHOTLSw6J/C9LhQC9nSUmgPx4YJm0HmQTR
         IYDer+YB+jJpWw//10DHVEpCLRQXpAsxjyHJLJFPgYB6uUOlkWjjAwnO7lWqp3p0TjFE
         GN7nuOTL5cMfCKPVeDcokj0FxT/ExP2mJRg3EEUNgco2eNvlW5jc+8YL+yzKRXpUuXMz
         XQtlO7q/vnrhmP0+kwrCkXV93t0eEFm92yJisUWhQta4uWK13sMWEcJLaCQVd4wUADhf
         /vpg==
X-Gm-Message-State: AOJu0YyUiJYK4udFQAePqNh1FGb84MjpUYQXMEK85dSt1b46AiTSRzNU
	Y0tl5OPJIFQ6Pnq8gjohbVCoioS/EbH0L+9iuuGCj15K0zHnonzLDW7vNSRXwxQ=
X-Google-Smtp-Source: AGHT+IFTY80fk9XyBaSRDppe2um+6T7AR4MPRN+imdT7eIFfQ7qJN7VFb8w45tGYOcGd3+eFKHHHsA==
X-Received: by 2002:a17:906:228b:b0:a4e:4d9:7ce4 with SMTP id p11-20020a170906228b00b00a4e04d97ce4mr2492742eja.30.1711643731940;
        Thu, 28 Mar 2024 09:35:31 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id h9-20020a1709060f4900b00a472c4b9486sm937920ejj.84.2024.03.28.09.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 09:35:31 -0700 (PDT)
Date: Thu, 28 Mar 2024 19:35:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <keescook@chromium.org>,
	Daniel Micay <danielmicay@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH 03/11] staging: replace weird strncpy() with memcpy()
Message-ID: <695be581-548f-4e5e-a211-5f3b95568e77@moroto.mountain>
References: <20240328140512.4148825-1-arnd@kernel.org>
 <20240328140512.4148825-4-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328140512.4148825-4-arnd@kernel.org>

On Thu, Mar 28, 2024 at 03:04:47PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When -Wstringop-truncation is enabled, gcc finds a function that
> always does a short copy:
> 
> In function 'inquiry',
>     inlined from 'rtsx_scsi_handler' at drivers/staging/rts5208/rtsx_scsi.c:3210:12:
> drivers/staging/rts5208/rtsx_scsi.c:526:17: error: 'strncpy' output truncated copying between 1 and 28 bytes from a string of length 28 [-Werror=stringop-truncation]
>   526 |                 strncpy(buf + 8, inquiry_string, sendbytes - 8);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Since the actual size of the copy is already known at this point, just
> copy the bytes directly and skip the length check and zero-padding.
> 
> This partially reverts an earlier bugfix that replaced the original
> incorrect memcpy() with a less bad strncpy(), but it now also avoids
> the original overflow.
> 
> Fixes: 88a5b39b69ab ("staging/rts5208: Fix read overflow in memcpy")

I don't see a problem with this commit.  The "sendbytes - 8" prevents
a write overflow to buf, and the strncpy() prevents read overflow from
inquiry_string.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/staging/rts5208/rtsx_scsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rts5208/rtsx_scsi.c b/drivers/staging/rts5208/rtsx_scsi.c
> index 08bd768ad34d..a73b0959f5a9 100644
> --- a/drivers/staging/rts5208/rtsx_scsi.c
> +++ b/drivers/staging/rts5208/rtsx_scsi.c
> @@ -523,7 +523,7 @@ static int inquiry(struct scsi_cmnd *srb, struct rtsx_chip *chip)
>  
>  	if (sendbytes > 8) {
>  		memcpy(buf, inquiry_buf, 8);
> -		strncpy(buf + 8, inquiry_string, sendbytes - 8);
> +		memcpy(buf + 8, inquiry_string, min(sendbytes, 36) - 8);

I think your math is off.  The string is 29 characters + NUL.  So it
should be "min(sendbytes, 38) - 8".  You're chopping off the space and
the NUL terminator.

This only affects pro_formatter_flag code...

This code is such a mess.  I'm not sure your fix is the complete fix.
When I see code that's clearly buggy like this and it's not sure the fix
is complete then I generally prefer to leave the static checker warning
as is so that we are reminded of the bug occasionally.  How close are
you to removing all these -Wstringop-truncation warnings?  Maybe we just
add a comment or a TODO item in the drivers/staging/rts5208/TODO file.

regards,
dan carpenter


