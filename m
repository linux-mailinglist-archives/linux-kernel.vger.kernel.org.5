Return-Path: <linux-kernel+bounces-146320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C96558A637D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85BB72850B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776053CF5E;
	Tue, 16 Apr 2024 06:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdsM2K5q"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B7F33998;
	Tue, 16 Apr 2024 06:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248021; cv=none; b=EVLkE8NIpK414Y/UEpiYV8iHSL4lVoLBlScSBB8wm/+8MY0KE0DK6CUMfg1bVbp8X6z6vxGpZ7gQxLaWmObLF7QyHi9/fg20jJkBEAGigDaoXviM2KISP4xvlrSWazfYOqqXnkPhEk1XMXyT7skIb/y+p7HMSclMINqzZ8t4yXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248021; c=relaxed/simple;
	bh=bJKfCh4TOpH4ZqKQgc6vvRE6Ro7oRSWDp+zAGLT1a74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wf2Z26xt7kgGh6NTzoVDGlS9uH44BefoGbjYDNvdw2uRzZHzBXpZ1zeylLI31v3nc46UYCYONGGVJNmw+XAr8Y05hBFvZ8Ai2V/issew6yP5Xw7WZRaRBcX2B8jNEK+EYJn1opem7wR5fH9d/2yNGjHmFCHPjByQnPN5omYzNJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdsM2K5q; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e2b137d666so33056155ad.2;
        Mon, 15 Apr 2024 23:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713248020; x=1713852820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CZ6ecSrVtYcanZSvOFQ1ox/50yBmtYgCGB61sRcLhXo=;
        b=fdsM2K5q1d5NqmKfVSr5Zu++NnUS7igDswII5gacwpVP/19zrFeC8+/uC3ja++3smF
         W8awc2ZgzFtzFDLI6hoLBmi2+mlJPKIzSaqGcKNnMkeFDJPnUgCRJu/vVAjJV4MLJ4X8
         KA0ivhikQzyRbLgyY6vzWH47HLzHstNKWsM9bS8oVXjj7AdS32O1IQjnHZneywrLYPmP
         AmCcVYw5FfxxZ0dQLQAKxQKlfEIdJOTeIQ+e0MNDg2AMQi5zFdbt+QBwQdXLOB7cK4oO
         IV8DERD4+aZNRusi0VllyePy6A3em+tMnafq9XvV8IbNF5L4yrnZxE8+ua8Y58wsu6o6
         xFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713248020; x=1713852820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZ6ecSrVtYcanZSvOFQ1ox/50yBmtYgCGB61sRcLhXo=;
        b=gmwfgjQq8ZM4x6F/g5cBPbGafoTZrt7Cum4LGgNdI3l/7ziG9RmY//VNTEA5d6I0Ip
         W2HAWoZl9y65neEuMd32SGYQWJVx5UnF9b7R8ir9VaTp3KCpVsRDMBYyc3vhyU0N7sAu
         3F92Ip7nU2/L/O3xis1ur4kdobl0k5ygO00bvBVBPrJ6Y7xQN4vamKrUHqKGcullYU+h
         igm17SkDDQo2pxq3BovsdQ4+/3TUlBsCpPES60dAW7fWKvTUz3wmBgO5jb6+bsFYnf8K
         2HtcRYIVMQAdm+M2nQbSrbL/u4eU+WXo84UymSmJPhSvjCSNro3EjA+7DerXXHHMNSm/
         YTuw==
X-Forwarded-Encrypted: i=1; AJvYcCXux9UtvriFOgaFRp0wvOQqDWOEC18TEmhtsVZJjAUAUMIvoc/+lsY/bxCrPbd9FJAPe4pGGcPILQmMZgzOzxzCweJv+3E3afCSuHEsjtduafLsUlM5QNSmd+f4BD3zvhnzTnhjZjD/
X-Gm-Message-State: AOJu0YxxT6aEhRIdkhWCxqTJla5Vvf3TPs6si8mjbUbSJEcFmPdljSgJ
	dHn3DFfgruLURQFtXTzHMKTNX65ix9G71Wv2fI0k35/KpaGDMOq1
X-Google-Smtp-Source: AGHT+IHo1g0xIh9Zq4tQT6ZgqBpNNX8qlCCYceyGks9TWejitkCg/+/KVWFWO9PgevyWpGP9p2ZULg==
X-Received: by 2002:a17:903:24e:b0:1e2:7aba:6d0f with SMTP id j14-20020a170903024e00b001e27aba6d0fmr15871189plh.36.1713248019757;
        Mon, 15 Apr 2024 23:13:39 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902d2c900b001e1071cf0bbsm8940249plc.302.2024.04.15.23.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 23:13:39 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id A125A180F6DB9; Tue, 16 Apr 2024 13:13:36 +0700 (WIB)
Date: Tue, 16 Apr 2024 13:13:35 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexander Duyck <alexander.duyck@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v2 14/15] mm: page_frag: update documentation
 for page_frag
Message-ID: <Zh4XD6jP4dLoZN4Q@archie.me>
References: <20240415131941.51153-1-linyunsheng@huawei.com>
 <20240415131941.51153-15-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0I6/Ma35WnVqMhhN"
Content-Disposition: inline
In-Reply-To: <20240415131941.51153-15-linyunsheng@huawei.com>


--0I6/Ma35WnVqMhhN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 09:19:39PM +0800, Yunsheng Lin wrote:
> +API interface
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +As the design and implementation of page_frag API, the allocation side d=
oes not
                                        "... implies, the allocation side .=
=2E."
> +allow concurrent calling, it is assumed that the caller must ensure ther=
e is not
                      "... . Instead, it is assumed that ...:
> +concurrent alloc calling to the same page_frag_cache instance by using i=
t's own
                                                            "... by using i=
ts own ..."
> +lock or rely on some lockless guarantee like NAPI softirq.
> +
> +Depending on different use cases, callers expecting to deal with va, pag=
e or
> +both va and page for them may call page_frag_alloc_va*, page_frag_alloc_=
pg*,
> +or page_frag_alloc* API accordingly.
> +
> +There is also a use case that need minimum memory in order for forward
> +progressing, but can do better if there is more memory available. Introd=
uce
Did you mean "... but more performant if more memory is available"?
> +page_frag_alloc_prepare() and page_frag_alloc_commit() related API, the =
caller
s/Introduce/Using/
> +requests the minimum memory it need and the prepare API will return the =
maximum
> +size of the fragment returned, caller need to report back to the page_fr=
ag core
                                  "The caller needs to either call the comm=
it API ..."
> +how much memory it actually use by calling commit API, or not calling th=
e commit
"... to report how much memory it actually uses ..."
> +API if deciding to not use any memory.
"... or not do so if deciding to not use any memory."

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--0I6/Ma35WnVqMhhN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZh4XCwAKCRD2uYlJVVFO
o85iAP0UEZ96bTaKdZC0FmSard5z0dMjRBPD69wzKG6rmE9CagD+LpsBRsgW1frt
81TmfyhS9gzn/HY0KhWP63uiPguKkQY=
=zrUk
-----END PGP SIGNATURE-----

--0I6/Ma35WnVqMhhN--

