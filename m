Return-Path: <linux-kernel+bounces-136334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC1E89D2CB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496F428450A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFABE77F1B;
	Tue,  9 Apr 2024 07:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AT0q6Lpu"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CC9537E6
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 07:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712646266; cv=none; b=m7TiuVEPs1dJ+jrnBCL63KD5m8+GnOmfSapeOO3RJmVyJuZLc2SgoeWgAro35/Bz7bZElB/RZM0KetjlgbE67GsUG5sbpI8Fh3IC/rOFMhm6sP/hJvBztYDtfA00vjMS3Dg2fKGhA1EckTiFwbqewFNALJU1zZnwRMrecLxd35Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712646266; c=relaxed/simple;
	bh=hJiFGv5DW9utMvcHTnFoXsNOZQQnudImv4pfNaDBxQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIEcMXjyX3YCJ7inqFOzQVI/7z+TUVE/mRzFsixZt+BgCWA0SzFvmZ2KiTcOqdfXGqPf9xqSO9TLD3rP9greJUFmdTbGWIquU343l09WLdHsC5PsW4KRTpLsu+PdYGzp+12CH7iRUvaUhSWSmJmbkbTffwQ7eKTZnkX5zcHCd3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AT0q6Lpu; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a4702457ccbso677048966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 00:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712646263; x=1713251063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZO+G8vYwqEif2MQQep31dNkOjqakaMIvdbgiCkuB6BI=;
        b=AT0q6LpusHaURZ+zrrEYiFbHmG5/mjJRN1nnPQpDeRIFZ2lVDQqlMERFRSYNqrvrXG
         rZewPt2Kv4Rll+OSnUWvPlIHZ1BLVObbyGiuqzletRJtwUpTSffziXM1ehSB3OKZ1Go0
         sRWDIJNaKyoQf2v7xmho96T+vBmox2fs+Ek67phe65BH3bdF54026lBT1qQ6c5uiKjCx
         NgddXSrqKWs9VDp0l3ILS73ihWbZETV72QbEJi7O6uWN9yZ5ENyuNkPNB3WeDAXzwNBR
         P3uiXuRpxrYpZ8cg0AwwnQV46giGDXv5/Bw7gr1uuCGp4rMhZXCdI3mbEA1ZpmZLEfBS
         vuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712646263; x=1713251063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZO+G8vYwqEif2MQQep31dNkOjqakaMIvdbgiCkuB6BI=;
        b=s0ooV+SrAxyddZzQ0oIkTCfDYtWdaTQLxhyouAosyGj4hzdWDIKfo6at71bLES+FOO
         cNYmu4tghaRx4dtxRObGh3V4CpmiyZEi7TQyC6R4IjoQleISRYP5gI1KJ9wj+HGeS5Y0
         pGiQ23dMgJcci2kOuZ5n6wCf9dlrrfR+MpLI06lc7mRydcbstGa9IFcLeU4Xk5vDlmQ/
         NDKWBwpT8nS4wqTVDSN/lCnTz4Wyj8WjMZ9GmdOtHqlNP2h2Nl4nKgVPyjVWK+pdXBdj
         ZXXo/8pQfbIZV1AOD0k6tDAfeASVFG3EItPd6UV9qmPrr8PjblynOT4ONHpKyGQZunpu
         LdUg==
X-Forwarded-Encrypted: i=1; AJvYcCXVo6Jw1VO9cT06DgWLWn2NtLba0hj4BVJ6uXEKMVH9rk+4h6aQKEvNPVlZm235hD7t4wA7JPgh/1QdCxM/WYnjcnkZzIIuDuCUrqHh
X-Gm-Message-State: AOJu0Yzs5F/bmBMNJ908JgxBlZaq+0BC8gTtrO/N7ANV8vwhBGI4KQ7w
	IaFMAoZXQORb9G9ktQ/SEItmqdaNLrm0gw6eQeTI4fYhVYMV404okOlydlYQYXE=
X-Google-Smtp-Source: AGHT+IEJR0mpYHfVzK+X/mS3qDum9gkPCn+raThHT7VInTnvN2rmMEEmTyHQC1FpsccQ9/zUzab77g==
X-Received: by 2002:a17:907:948d:b0:a4d:f5d4:fb02 with SMTP id dm13-20020a170907948d00b00a4df5d4fb02mr8230339ejc.51.1712646262666;
        Tue, 09 Apr 2024 00:04:22 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ak2-20020a170906888200b00a51dccd16d9sm1716392ejc.99.2024.04.09.00.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 00:04:21 -0700 (PDT)
Date: Tue, 9 Apr 2024 10:04:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] [v2] staging: greybus: change strncpy() to
 strscpy_pad()
Message-ID: <514e5aa2-851b-4846-93f1-51f972d782b3@moroto.mountain>
References: <20240408194821.3183462-1-arnd@kernel.org>
 <20240408194821.3183462-3-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408194821.3183462-3-arnd@kernel.org>

On Mon, Apr 08, 2024 at 09:48:11PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc-10 warns about a strncpy() that does not enforce zero-termination:
> 
> In file included from include/linux/string.h:369,
>                  from drivers/staging/greybus/fw-management.c:9:
> In function 'strncpy',
>     inlined from 'fw_mgmt_backend_fw_update_operation' at drivers/staging/greybus/fw-management.c:306:2:
> include/linux/fortify-string.h:108:30: error: '__builtin_strncpy' specified bound 10 equals destination size [-Werror=stringop-truncation]
>   108 | #define __underlying_strncpy __builtin_strncpy
>       |                              ^
> include/linux/fortify-string.h:187:9: note: in expansion of macro '__underlying_strncpy'
>   187 |  return __underlying_strncpy(p, q, size);
>       |         ^~~~~~~~~~~~~~~~~~~~
> 
> For some reason, I cannot reproduce this with gcc-9 or gcc-11, and I only
> get a warning for one of the four related strncpy()s, so I'm not
> sure what's going on.
> 
> Change all four to strscpy_pad(), which is the safest replacement here,
> as it avoids ending up with uninitialized stack data in the tag name.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2
>  - use strscpy_pad()
>  - use two-argument form
>  - change all four instances, not just the one that produced the warning

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


