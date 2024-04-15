Return-Path: <linux-kernel+bounces-145042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579E78A4EA1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE55FB21FAF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7658D6BFB1;
	Mon, 15 Apr 2024 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUNojBss"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75AC3D969;
	Mon, 15 Apr 2024 12:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713183095; cv=none; b=BndDy+p1rUF1GnKIcDxpKaS1a7DRRa0jZHzDC6ZEnpA1wOjEnOW/1Jzf8C0vI8kEBq6XPtwAqOppMkplsNQZA62kmazSxwlLoC99fADzSgMLL7dpcTdk19hFcW8t5IyU8tUDVKiLaaeUUxhX9ScFAgRR1KT5wd3dSNcKfVasufE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713183095; c=relaxed/simple;
	bh=JlRNinMB14Vi+qx6e4+SgMYXpemq/XmnH4WkpmLmBEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CyQEGYDV2fcXmbHkssVemv7VuEUMyND90JgJRpwzQY8/+5ucZ8NIPfE3VWs/ckBsGd5785fs6U+1/iBqC+I53Ivd57SEDkJbDLZ1LFg9YLOkOnCzPqxg6tOtYDsO/HhP79ZFfePx5Z9pdTo9cxSeGfANNNHBO8eo3SExMftEj6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUNojBss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F62CC2BD10;
	Mon, 15 Apr 2024 12:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713183095;
	bh=JlRNinMB14Vi+qx6e4+SgMYXpemq/XmnH4WkpmLmBEU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fUNojBssabeBLqxSBYi5a9hdIhByAtarfpbVQnx7FnPjwkhtr5pilM5KZrIFCcGTh
	 7mtNfyj4aat9rjeOlMMIvxfpLk4285NvVuoUAhoShED7OodeZIB6etLLpncsCM0CVX
	 z55b7DXLcJwP8mxL55kpM3X/Bcxk4b5MMdH5hvVXWCnLvL5jgGw08F5HqcRrVr74Sr
	 Splog/EU5PpSnLOVO0UHsa/tc5jbrkF60NZJHQbv36950MDPs5VIrJQ9rvyMY5gkJo
	 0xixjVY9PKIc+kHBST52RkcKWsNx6S0dCZ4Ry406PgdXdq2chYFouDVH0t4MmQUWJa
	 uatJuwrz9fJxw==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d094bc2244so35378151fa.1;
        Mon, 15 Apr 2024 05:11:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9N+yI9FI2iSp8bAFN23D3BeTIr80rqBK5abuII9vja9Is48kKMOYHnw5aJ3vvlDekj5JhyEsoMWBSliEiQs4Lkc+1ctI+5oRaiSmr
X-Gm-Message-State: AOJu0YwS+83cXNGcPXol8Sj7s0+klUE9YsMx9E0piujy6QrNgg+kBMM2
	Epm4ZsT11PkSQ5CFdQTblPxH/++pMG2vrCpzHkTt5Bit5GsffiWDlmlmhoCMs2vTQ8LofsRhWWh
	1dXf3MJBp6wsJMO1PLw19i8qfOx4=
X-Google-Smtp-Source: AGHT+IEPmK8JYfOx13AyMuzWcoxz7eLOZSu8X6fCK91Ko2aU6sVo5bF82stSohdIYz85/nvNojuEgM/Uupk/0F0ctVA=
X-Received: by 2002:a2e:804a:0:b0:2d4:6f14:53d5 with SMTP id
 p10-20020a2e804a000000b002d46f1453d5mr5533039ljg.26.1713183093647; Mon, 15
 Apr 2024 05:11:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240413031728.159495-1-ebiggers@kernel.org>
In-Reply-To: <20240413031728.159495-1-ebiggers@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 15 Apr 2024 14:11:22 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE4QZX7N1Dmv930raPdK+5E9RRwk-weaArE293Uivx7EQ@mail.gmail.com>
Message-ID: <CAMj1kXE4QZX7N1Dmv930raPdK+5E9RRwk-weaArE293Uivx7EQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] crypto: x86/aes-xts - additional tuning
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	"Chang S . Bae" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 13 Apr 2024 at 05:21, Eric Biggers <ebiggers@kernel.org> wrote:
>
> This series does some more fine-tuning of the new AES-XTS code.
>
> It applies to cryptodev commit 751fb2528c12 plus the two pending patches
> https://lore.kernel.org/linux-crypto/20240409000154.29799-1-ebiggers@kernel.org/
> and
> https://lore.kernel.org/linux-crypto/20240412154559.91807-1-ebiggers@kernel.org/
>
> Eric Biggers (3):
>   crypto: x86/aes-xts - handle AES-128 and AES-192 more efficiently
>   crypto: x86/aes-xts - eliminate a few more instructions
>   crypto: x86/aes-xts - optimize size of instructions operating on
>     lengths
>

For the series,

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

>  arch/x86/crypto/aes-xts-avx-x86_64.S | 249 +++++++++++++--------------
>  arch/x86/crypto/aesni-intel_glue.c   |  18 +-
>  2 files changed, 131 insertions(+), 136 deletions(-)
>
>
> base-commit: 751fb2528c12ef64d1e863efb196cdc968b384f6
> prerequisite-patch-id: 5c1ca8ffe87136eb7bfe74d996f5e6cac01e2768
> prerequisite-patch-id: a72a872736c8e0876c4b44a9e5792dcaa02d4e0e
> --
> 2.44.0
>
>

