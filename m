Return-Path: <linux-kernel+bounces-167255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D70278BA680
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C782824A7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 05:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FF9139596;
	Fri,  3 May 2024 05:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mE9wK429"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF7DEEDD
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 05:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714713044; cv=none; b=RyU0JVgsH2ypKmQM4l/HOJfkkbY1Ikm2zKHeBq0Q/IvDDdYy6muUfHPoX79YL72x+EGw3saYXBc7QHmHw+0b2rwY+iSVFIbrNhlK/UxMSC02MB7t8u8jwo4ZtosTiKbtGwxEvDpux9r4To6Lh3/YgdfpuRQ69Xdct6esjpSh37M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714713044; c=relaxed/simple;
	bh=i6xVZ2OTZFg+doyB55myf+prJAIhcqeLstOYtxEC4xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiuKKiBsYm6ut06yfj6PBxMtsGgmwexgswCLFGsup/6+7eg65lfxjm3z3wYJlgdRVZxHncuXXgv4SZcwf/W08N8gkvwFfsTuvT2jSFfS96USqatglfZbJUKN5nPw3+BzlhUjVKkQC6KYedV8uJzpHBqMYvo+R0I9ftqiSlDwYW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mE9wK429; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34de61b7ca4so1365135f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 22:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714713040; x=1715317840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oiqsy4w/6pSqBHe80gOjS5HO5nOoXfBcie0JvHJoK1Q=;
        b=mE9wK429YuJ9KD1CSefE7yiZVAsKGPmy9V4u5rUAN01WJwS6kfMK05+dxhqdsY/uwo
         R8A3EQLDkba/MBpAd3Eg2cYMHwqQuzYnI5cmHx2b2Zs79zpD5w1yblIdkiSk20EAU5uv
         eDp5tarvigm/KwL39KUwAD9m5EiBMc7y+IawUQpdX+PE2xbNkmhj2dyqPL0qIVodCV0r
         DaUjZCB2r1NGHkSKo6+oyz3jBbILplUZAZsw2Vke6KnAciq4BxONX7IZIotcYcVnXKNe
         vPhoyBnlA8QDbbfsf/EabMSQVKq8B9++/wPmAHqEg+AoF32ZZClKBmh4EGXIb6CqXO2x
         lBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714713040; x=1715317840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiqsy4w/6pSqBHe80gOjS5HO5nOoXfBcie0JvHJoK1Q=;
        b=oc/z/7r6hK7cmz6Lb1u6ZavzML0P8k7UbMu1rbtmwCAnAS4SDLBoUo15MlvuuBuMU8
         iIUSEwjB/FNpcwLEuTfGsEbW4eLJEKUAqtvJLRn4jMoVEkZXLGH1puxfnC8U4Ag328F6
         gIoFZY6CduoV77UPvOgwPNn1JCkYUDiwlCGc7z2LVQXOB0cKlNIAnCLI8NiM3CWvkX4X
         1JQ6zpeI92Jg/6VQHiLP7Ru2UqSMbSag7iQFaF6L14/eQzIMhNn0mLA/0ckdFS74Y80V
         dL2jIGeaHJaQ7ecf44CfnmwE2YZRrGZ9qBuYr0QM6RrLnML3dYwR9ecCUrOkDBcOekMV
         bbrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTnM4ivMC9FsKSFsVvtTvWttG72iBc0UXotWnvMu7CbwQNiJEL7YuHuEy7PzgyXAFdTBk3t97ecJ5zW+fu1U0o6OHlRQYmDBKB5HpI
X-Gm-Message-State: AOJu0Yww0Tum89Cd/kbhtOBYfT03gvsCKY5CdcCEFqX/I5cpoL/YQw9U
	CmgRatWN310hs9RCl51V+QRLeEPNIMni10pK2bKcFCzBAu1IhTEeWkWe+O93PmQ=
X-Google-Smtp-Source: AGHT+IEFI6t09BZdnrbU73Nv4BNQA6nBUHiWnYitJDrCNHhRK4suZbi2QUzyoiOqgOh+sXpCQpyszQ==
X-Received: by 2002:adf:cf0c:0:b0:34a:e73a:67a1 with SMTP id o12-20020adfcf0c000000b0034ae73a67a1mr1381329wrj.56.1714713039839;
        Thu, 02 May 2024 22:10:39 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a7-20020adfed07000000b0034d839bed92sm2783119wro.64.2024.05.02.22.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 22:10:39 -0700 (PDT)
Date: Fri, 3 May 2024 08:10:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hams@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, jreuter@yaina.de,
	horms@kernel.org, Markus.Elfring@web.de, lars@oddbit.com
Subject: Re: [PATCH net v2 0/2] ax25: fix reference counting issue of ax25_dev
Message-ID: <af86eeb7-d07a-4b7e-b582-90be162e782a@moroto.mountain>
References: <cover.1714690906.git.duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1714690906.git.duoming@zju.edu.cn>

On Fri, May 03, 2024 at 07:36:14AM +0800, Duoming Zhou wrote:
> The first patch changes kfree in ax25_dev_free to ax25_dev_put,
> because the ax25_dev is managed by reference counting.
> 
> The second patch fixes potential reference counting leak issue
> in ax25_addr_ax25dev.
> 
> You can see the former discussion in the following link:
> https://lore.kernel.org/netdev/20240501060218.32898-1-duoming@zju.edu.cn/
> 

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


