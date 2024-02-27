Return-Path: <linux-kernel+bounces-82772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4736868974
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593911F2480C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F65A54F95;
	Tue, 27 Feb 2024 06:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKwsRWY+"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524D054F82
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 06:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709017186; cv=none; b=I6AilpG7do9kx4nMLQ4oeORGA7NurlGMaYo6VkvqjLPDIP9MGBbffQFsvmfPND4pcvhXFBgxiyjdXWkoAq4Cc0LkQmSVOOh+7AyCNA/BdOwHHfho6Wb6HEYjNVugrgvgbJt6xH5Hxn61N4ekIx/o0MfEqaxueeE64Fcozq7kj7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709017186; c=relaxed/simple;
	bh=Uqm4Pm384ZoKXXtyJ2XDz4dT3HeXTX6f/cFD/hJuuIA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krKz/BHkJEZeY9Y/aFFkGHehjRB1VFfDdSCtRWLCfqkCrHHzkbvjSVVIjt8tpQeQzDnOU3fo+p/eqwVROx9OtQkVwG9ghLLo04Vx6AXNAqT0C3zVF0cTjDuKqGxSWXm+JAoyT2f+6aGQFdt8fqCzUBoJyT4/T/um/E4+OET8C7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKwsRWY+; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-512fd840142so2202575e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 22:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709017182; x=1709621982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5KuvnlvyeWUsxTJLj9Epkltv1p/LxPChBV0kONyim4w=;
        b=nKwsRWY+quYvXWh7HqbFAXQK4Z0rUN38mK7tCaLSBK0240HrAdJsv2hpgITf7z+1up
         hPnGNNl6hPboYplfXOfTxy3r+671FUZpYhBoWW/JJ2TapMtrz1XYpYBR+ngJky5YP6N2
         lc20GIs2lADgPn9m2H+KG2Vvcj5WSQr7gy0n1aXHlPfrTqmg50N1Y2ygMfFIASSWFWNh
         mqGVqq9QtWp8eIvy/paoRXwz24IJcvEzw6OEkZOWQBqcWoDzmnk4m4k8M3aoPEm2XRnS
         S9uFf0+9/xD/6L+9TgAdbnE7XO+Zkf7hs6lKVpCJAGr76zflZG6Zofnc0peIJC6kltIa
         i5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709017182; x=1709621982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KuvnlvyeWUsxTJLj9Epkltv1p/LxPChBV0kONyim4w=;
        b=ugnvcVhRNnu+bXWko27hLFl6o7s3BSTLgwty9mXyYjmncBC3zxVmnLzGyqeMw8o29t
         q//5F3wPsllObeltdYJ6kbrWuo4kbatCZTkFgMTDcOqd4t1q1swe8CZatBpn+dPXRwyd
         7z+pan6Kb4AD2+1l1FqTV0a0otshhhAxYvuqJPZFw+OddGU5aiViuAsgcXOh5N7qHD0z
         ZwlrvBbpuGoTnwzVG+nEcOGT+tAT9WJMxhFuhThSQqu1czXT71qExTNGsZgcNNvN++Ja
         9Ymhbp37hezTTFX9Hmh+YY0GtknxzqarpK7NkbmFbL5Q72/U7IZ/opWPr+2wAEyr+Lmq
         TfWw==
X-Forwarded-Encrypted: i=1; AJvYcCUmPnF4uARgzj/etropdqJjB1GYlWQa2cSYzUodKyUXY8nB4PiSW7nqCjm02093FCqZhMhc/NK6eTZnuOOTQ4TX1jYmqJKQNmSIOOP9
X-Gm-Message-State: AOJu0YwTr5Hb7KlOgunHX7FZ65AReabkk3e0Q/Izz0DZSVjMK/KSiuuJ
	xwA1/DEDudpoVryEz7gK4urrC3ZsXmUq4rOFIdwVhb3K7kDJb1ygcRslmOGC
X-Google-Smtp-Source: AGHT+IFsm9QVvAfnOYcRcmtEEJ5gOG+zFJFH4Qs70/yFPwdFeur8g596XWRXSQWnnpBSI6erxEUSUw==
X-Received: by 2002:a05:6512:310f:b0:512:f71b:c4d0 with SMTP id n15-20020a056512310f00b00512f71bc4d0mr3885868lfb.48.1709017182325;
        Mon, 26 Feb 2024 22:59:42 -0800 (PST)
Received: from pc636 (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id s4-20020a056512202400b00512ecfec2d8sm1090333lfs.126.2024.02.26.22.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 22:59:41 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 27 Feb 2024 07:59:40 +0100
To: Martin Kaiser <martin@kaiser.cx>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] lib/test_vmalloc.c: use unsigned long constant
Message-ID: <Zd2IXEsx2YAOaALt@pc636>
References: <20240226191159.39509-1-martin@kaiser.cx>
 <20240226191159.39509-4-martin@kaiser.cx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226191159.39509-4-martin@kaiser.cx>

On Mon, Feb 26, 2024 at 08:11:59PM +0100, Martin Kaiser wrote:
> Use an unsigned long constant instead of an int constant and a cast. This
> fixes the checkpatch warning
> 
> WARNING: Unnecessary typecast of c90 int constant - '(unsigned long) 1' could be '1UL'
> +     align = ((unsigned long) 1) << i;
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  lib/test_vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
> index d0c0cbe1913d..4ddf769861ff 100644
> --- a/lib/test_vmalloc.c
> +++ b/lib/test_vmalloc.c
> @@ -117,7 +117,7 @@ static int align_shift_alloc_test(void)
>  	int i;
>  
>  	for (i = 0; i < BITS_PER_LONG; i++) {
> -		align = ((unsigned long) 1) << i;
> +		align = 1UL << i;
>  
>  		ptr = __vmalloc_node(PAGE_SIZE, align, GFP_KERNEL|__GFP_ZERO, 0,
>  				__builtin_return_address(0));
> -- 
> 2.39.2
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

