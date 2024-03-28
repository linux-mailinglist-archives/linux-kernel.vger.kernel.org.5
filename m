Return-Path: <linux-kernel+bounces-123127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E081890282
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03981B22AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1753612E1F9;
	Thu, 28 Mar 2024 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vd5GkGBm"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEF712DDAC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711638037; cv=none; b=QiAeV/SkktdoJBIDJ+uj7mTXWA30tWRR06NbreJWcPzjs6G3g72nrwPCAzDKcsyjY3lTsGJfH0npif6BND4iI3uDV7bE9LsGNPHCDfy59DpK/wXwaRNjZPirkp8IcJRTokSSSYjSX4CplzDszuuNp5TBmFWFiRz4cwTcDVSZE1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711638037; c=relaxed/simple;
	bh=cy9u3VtVrRuyTCsjJgnGYGt2u+Rm+jFJiYwOK88je84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDKB+5xtez5xmV+IK0nbl3kjGUgHNxjlxhWFnhdh4bvVrwHjSB2mILy7DFG+0APsjLiIFYnlwL6Of+sRsxyxFkn8gx0xLgOpiRfa4ArWK61gScEoULSjLjHlk9xzmnVKm7C59BH4Ed5jVAB73EHIpzI/AgLFFKT/mF1LqWTSsP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vd5GkGBm; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so12031061fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711638034; x=1712242834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1wJgbtA/vjDhwvz63u9VWEaiKAUmcJOl/pw5kAYmOlA=;
        b=vd5GkGBmgM977GONngRSJrr3B2C9m8FM2JxRWGz2qiCdafIEdKhBqGmH/7ToeiPCfQ
         0XiuAPVqGVLypPjDah4Yoio2b8Engse0C6B+tngEnjAuIXpoiDQXw1ZPznyJdcoeG1DX
         N6UP+VEhEeobTUNbS4CCX7EYl5gLn/1jgE4/qkO4Woh+fkUNiHwqC3XZn4KHvuMy1wNr
         TnKJGTLkxR2vI4QebQXsk9Cdcaa/N/yziaD9+IntOY7wlitecbm+vNT045EpychfsDiz
         YYaZLx4+SdPq8tS7Z9Gh/52FVt/DNtaciz0bF6G1h9OOM+lELXqc0lx5M7K/FJQrPBB7
         ZVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711638034; x=1712242834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wJgbtA/vjDhwvz63u9VWEaiKAUmcJOl/pw5kAYmOlA=;
        b=m8q6+W4ppbN8rULqUhJeWy5upfRsxqZ99UYZ0BKpMrTdF4H+YS50FZg1oY5EjI+MlJ
         JJEKx3UEAbqwqDdy/aiNM0TTfp7z3ojnAUs9ldoIzW5MWYWQnEEWQfRE3rO+No4TXAi/
         QYPG5XqfVhY32OIfEfNzNytINLk97qGp66r78enw0pKChspcCW/ToHFMLeDkHyufHFl0
         ioCGc1bobrh3kNYkFXr/detynxrEkRzR+EsUP9tZM82aIZq8RjOYRkUTMxb9LJ2+47xe
         z01HWsnHPzqhRz3MV8Zcfu/jix7TthtabHf3nXr8XW7OjGsH16Aw4Wuw273FNsz20COI
         Z+Ww==
X-Gm-Message-State: AOJu0YxbQSeqG6h++fqLYUqVB2kl8Cfio5nno6g10MNyTvFCrj/hCTnu
	uZKIjruoYdPwpHDyxRPnZZE6oU15Q/1NXndiNiBNZ1rqn/EaiMuJhXs82BS3kqg=
X-Google-Smtp-Source: AGHT+IGQ5CWKUqLKQ/deCqDvSGjzq/7ohPtTESkm+XyAfECW03YuhSnOZLJc5W2tTuXIQeRPB5tQuw==
X-Received: by 2002:a2e:9591:0:b0:2d4:2b05:a671 with SMTP id w17-20020a2e9591000000b002d42b05a671mr2299444ljh.32.1711638033575;
        Thu, 28 Mar 2024 08:00:33 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id d15-20020a056402400f00b0056c5395e581sm703497eda.70.2024.03.28.08.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 08:00:33 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:00:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 10/11] staging: greybus: change strncpy() to strscpy()
Message-ID: <76214105-94ae-4540-8511-e9e2ff6d257e@moroto.mountain>
References: <20240328140512.4148825-1-arnd@kernel.org>
 <20240328140512.4148825-11-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328140512.4148825-11-arnd@kernel.org>

On Thu, Mar 28, 2024 at 03:04:54PM +0100, Arnd Bergmann wrote:
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This is from randconfig testing with random gcc versions, a .config to
> reproduce is at https://pastebin.com/r13yezkU
> ---
>  drivers/staging/greybus/fw-management.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/greybus/fw-management.c b/drivers/staging/greybus/fw-management.c
> index 3054f084d777..35bfdd5f32d2 100644
> --- a/drivers/staging/greybus/fw-management.c
> +++ b/drivers/staging/greybus/fw-management.c
> @@ -303,13 +303,13 @@ static int fw_mgmt_backend_fw_update_operation(struct fw_mgmt *fw_mgmt,
>  	struct gb_fw_mgmt_backend_fw_update_request request;
>  	int ret;
>  
> -	strncpy(request.firmware_tag, tag, GB_FIRMWARE_TAG_MAX_SIZE);
> +	ret = strscpy(request.firmware_tag, tag, GB_FIRMWARE_TAG_MAX_SIZE);

This needs to be strscpy_pad() or it risks an information leak.

>  
>  	/*
>  	 * The firmware-tag should be NULL terminated, otherwise throw error and
                                      ^^^^^^^^^^^^^^^^
These comments are out of date.

>  	 * fail.
>  	 */
> -	if (request.firmware_tag[GB_FIRMWARE_TAG_MAX_SIZE - 1] != '\0') {
> +	if (ret == -E2BIG) {
>  		dev_err(fw_mgmt->parent, "backend-update: firmware-tag is not NULL terminated\n");
                                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
More out of date prints.

regards,
dan carpenter


