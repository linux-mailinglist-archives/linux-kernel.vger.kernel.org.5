Return-Path: <linux-kernel+bounces-82770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CAF868971
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9FC28376A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C155466E;
	Tue, 27 Feb 2024 06:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpLJaY/+"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794B95465C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 06:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709017146; cv=none; b=Hpo/MWjIqdgYmLEhRg8iFpLyscvQFhvd8UuyOIUG035cxobQy1JCRX5fzH3kuv/VEIpMZ1zEs3Nj7XCz6fdarVGKjQcXfhxgX3sGp37bi7PW9zGWP6pf2W34uDs/1mLoAJFfmY/da67ENCdfSPQCA/a0dIc000ipmWVjM5wvXa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709017146; c=relaxed/simple;
	bh=JfK1XAhcwbPxNedVEnABbzL4tkG+qn/E9KZZXYYoutU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSei78Dzb6Aa3mluJzgOnc3x0fmPHoEWrXYjQ6ScXyEL72DFmSDUzh40CP819OhsiRdJrtcSvzb4jXps4Q1ymxQQSYvWtKNoI2zFGpBzGHwwPRuwEayHG7Bd00Nd1MUlVtBc4h49wuJyLzbTCGnld4nhLx5h2WuARyqCWFYSa3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpLJaY/+; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d28464c554so30785261fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 22:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709017142; x=1709621942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5mLhU6LHNfuxoHr8uqKJCJfhS6LMnQqcqESbVoFGjSA=;
        b=fpLJaY/+GLnCuGEWO79edy0+b2mdtLWe7uafE5JxqcM6B3uXOaPfDhe4mZNZqa0AF/
         VbZrlmykw3AEyBPjlRaSw8XrAgP5vCdVi3SR8ru1HkjVsPRLFRIiJvJDS61ijdaDlzFZ
         NpHeyOOsJGKrBsXYQpYGEzYQ7jSo3SSKQc3WwEON1PamQ2GeuE3AfLLrDhqyjD59B9QP
         if7PJWJZevXw9/j7drKwQRftA/E8BQNTyERIS9to1+FWbUpKON5hdPd0jxMLc6bHjZEC
         QUe/HEGVw52QhWFtR9ILHA7ewmHAKBVxolHc0QDC3vDwV0yCkTokXpeKZnvbAB/fus0E
         UCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709017142; x=1709621942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mLhU6LHNfuxoHr8uqKJCJfhS6LMnQqcqESbVoFGjSA=;
        b=V2FAqCy/LsqNRTAQdlAgjraxcpNTTiF/uhMOnTt2wKDU2n0D3Skkg4hbbBfkoQQHIZ
         0GrRFpXI+13631/eVURU40rjJx7qnNBQrGTyzPnlkttCSKc8dy7WPzNBUomgbWgoJXiR
         8+eMLP+5oh1k4wszni8YORgCjww7yfl1O2xlAfaPUWqwCH2dETA1nfllYGkmMwyRHxJI
         LNbUL6xCgATk3HYhKsMbKhG/JBPFEWTcuAo9O2jNJbFimHBU0VYMKLJWW0uVauWuwrFe
         i+jyE/GbgcdcJCOA9ggrrXcgAaKGm2NowuK9b1YhwLqFDmz3VN7bxTqjQDu7Lmwbpkbg
         heEA==
X-Forwarded-Encrypted: i=1; AJvYcCXXEPdDpuQsOFYHtefZBjCsB72AEAWaeipWWFMXfpWR9x0eoMiu/+iu8EwdeJwIKy0my57tH/kM273JxKLLmxaBPpwJn4z1AOiC5yfH
X-Gm-Message-State: AOJu0Yzj8bNTp0AkiFq3XbXlofA38a3KhP+pFtLWF//vuFJMt/wCUq8b
	EUPhdwYlOJGz4nfr4kOBXQcaXqVXwZViDP/K6bc4AqtdNrT72NU9
X-Google-Smtp-Source: AGHT+IGu6pQSWqHY7tfc/LleS7RP9ttLQxxvGbAA1HjgJHg4YYGdQsCq2CjQ0aIvG+kHAaknXt6+aQ==
X-Received: by 2002:a2e:be86:0:b0:2d2:5668:3a40 with SMTP id a6-20020a2ebe86000000b002d256683a40mr7124404ljr.4.1709017142356;
        Mon, 26 Feb 2024 22:59:02 -0800 (PST)
Received: from pc636 (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id o20-20020a2e7314000000b002d2a3d0af87sm25676ljc.103.2024.02.26.22.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 22:59:01 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 27 Feb 2024 07:59:00 +0100
To: Martin Kaiser <martin@kaiser.cx>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] lib/test_vmalloc.c: fix typo in function name
Message-ID: <Zd2INEH7ZwJn9nhh@pc636>
References: <20240226191159.39509-1-martin@kaiser.cx>
 <20240226191159.39509-2-martin@kaiser.cx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226191159.39509-2-martin@kaiser.cx>

On Mon, Feb 26, 2024 at 08:11:57PM +0100, Martin Kaiser wrote:
> Fix a typo and change the function name to init_test_configuration. Both
> caller and definition have the same typo, so the current code already
> works.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  lib/test_vmalloc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
> index 3718d9886407..191b6bd5dff9 100644
> --- a/lib/test_vmalloc.c
> +++ b/lib/test_vmalloc.c
> @@ -501,7 +501,7 @@ static int test_func(void *private)
>  }
>  
>  static int
> -init_test_configurtion(void)
> +init_test_configuration(void)
>  {
>  	/*
>  	 * A maximum number of workers is defined as hard-coded
> @@ -531,7 +531,7 @@ static void do_concurrent_test(void)
>  	/*
>  	 * Set some basic configurations plus sanity check.
>  	 */
> -	ret = init_test_configurtion();
> +	ret = init_test_configuration();
>  	if (ret < 0)
>  		return;
>  
> -- 
> 2.39.2
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

