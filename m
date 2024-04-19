Return-Path: <linux-kernel+bounces-151388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0861D8AADF1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B732824A2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405CE83A0E;
	Fri, 19 Apr 2024 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPvC1V92"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613FE7C0AA;
	Fri, 19 Apr 2024 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713527782; cv=none; b=q/7vAre+Rr1dr2j1P+bGnt8EQaFZYQZ9umLkBdM1T2c7/XCwp+3Ehe1AhBFvgIHfog1ronaDx9N8LLKOxWjNt6ATeG3KgbuZHXvg9cbhfUw4E/9W8rPNdUM5oygSGJT6ktRy3yO7DyhG1+CgCoGiKBClA3/El0fRJrG6Vhn8qsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713527782; c=relaxed/simple;
	bh=GWzERsvmNUP7g8Ed1WxrJOHVmgznjsP7t87e9XqcluA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7vO4c1lboS0JVA5GOZbyg7HV3+Bq7au8bf7dAxHUE7mgOluJGG/HoaGk+S+zSz2A2U/78r9WrKyxF7yuKBjfWLdaweGcBBI86xyc1t1WaggLica+QUZAXleAnxw9xFoqteXxXj6AHGYYIlCsnOTCtK17ohSRwtKqPnOYs5qZxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPvC1V92; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso1419525a12.2;
        Fri, 19 Apr 2024 04:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713527780; x=1714132580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QJ+jXRgJowxRVoSW+EcTqN6n8P9B1qwo/nyUTMpJ3AM=;
        b=KPvC1V92FjPV2JT4n+Tf6T0d2zYyl9mFMpDJL5Bi6soji8Dv+J0p7HHkGTFrgppce+
         CkZonR4OdXNEgzk0Fn+eWP8Q8ih2xXTewTANVtP0nYfPqgOMHHfMdaYofturojOsVyjK
         ULzHmeGJfhHreeSsFgCa3wFrMvViUsvx7DADMg4xPZXslAyczFBAdpyNrQNmO6TOFS9L
         l7wN1REw7VjIlJOJ2F2oYtUfqyM2IsEQZ4Z0LWNWrx/GGbXLKl24zXzs6fc9fSqTPdzB
         cLO5N1WA23ne9VvDDDuj0YdN1ST/69JyoeFQSAKaPxuDJVJXTgs5Z3ZKCz4hJm6Q4rid
         OA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713527780; x=1714132580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJ+jXRgJowxRVoSW+EcTqN6n8P9B1qwo/nyUTMpJ3AM=;
        b=nTHb38O7mmFh9rKMGpPMn9F8zeUU8NIF7E6uRgohnDp6VD+3OAW4LEbwzX0aK6EpW1
         r1Y6IUrR9WPjjBz8SWhO6VhiMspHNBy8E0T3nEGNE5y5YXy+xhqkL/CTqyUQ1UwIJffB
         nCxoUw4dNMGB7XtrW/gRmjLHFW+1L6wgaLBl4E7vJPlAd+rQzgx4Vok0GgJXhXLeqyJg
         TKRLCNQZl7S41gnvppqnJW3gWUPf3cODS0QLTM+jxOeQVU/zYpmJdeXWgtd6N88ZUjFu
         fej56rCtPKJFz4gLXT250F9Jr5uq3MnRJ8hJQIK6hEtDEGeoU5DAp8UpgQZA2VMTpJ/q
         Kc1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDkt6JO2oL7a3OIQrQHOJLDHWagmBFhfu48TD+7gSehR/cKs7Kv14Ikm0rxfXJ/6Ia1Dl4sWevSHT+CpNYx+d+8ts/VlBlHGj5A7JP
X-Gm-Message-State: AOJu0YxcTbxIrmlUMTqk2QJ5X1lQ3h6Wb5vhyaK51TI5dDvkJdinjW6k
	1AYqtgj8V8RhFy6VwBgk05ideumUTBVy/Ky+0BHsFA0SEpdHe/BI
X-Google-Smtp-Source: AGHT+IFlj6guL+Ti0g0i+N+RWQt7ElBv5omKznsJFNQdj+aAd44IxXKiC8TZGMZyNEzOS06yeA9Vxg==
X-Received: by 2002:a17:90b:703:b0:2aa:5c79:853c with SMTP id s3-20020a17090b070300b002aa5c79853cmr2168994pjz.21.1713527780554;
        Fri, 19 Apr 2024 04:56:20 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id b24-20020a17090aa59800b002a67b6f4417sm4702327pjq.24.2024.04.19.04.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:56:19 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id ECB521847977D; Fri, 19 Apr 2024 18:56:15 +0700 (WIB)
Date: Fri, 19 Apr 2024 18:56:15 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Zhang Qiao <zhangqiao22@huawei.com>, mingo@kernel.org, chrubis@suse.cz,
	rostedt@goodmis.org, corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/Documentation: Add RT_RUNTIME_SHARE
 documentation
Message-ID: <ZiJb319kKznLk6se@archie.me>
References: <20240419090432.1935211-1-zhangqiao22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BW2pnCmDs4P4T8CF"
Content-Disposition: inline
In-Reply-To: <20240419090432.1935211-1-zhangqiao22@huawei.com>


--BW2pnCmDs4P4T8CF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 05:04:32PM +0800, Zhang Qiao wrote:
> +2.4 RT_RUNTIME_SHARE sched feature
> +----------------------------------
> +
> +RT_RUNTIME_SHARE allows a cpu to borrow rt-runtime from other cpus if it=
 runs
> +out of its own rt-runtime.
> +
> +With this feature enabled, a rt-task may hit 100% cpu usage and can stal=
l other
> +per-cpu tasks like kworkers, as a result, which leads into system hang.
> +
> +Thus, it is advised to disable this feature by default to avoid aforemen=
tioned
> +issue unless you know what you're doing.
> =20
>  3. Future plans
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--BW2pnCmDs4P4T8CF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZiJb2AAKCRD2uYlJVVFO
o4yLAQDX4mb0vApP9yRDdV5vfR2KjncNUqiUWwak8AaeDTGbpgEArzT60QuANCRI
12Q0HoV1wjmQT/Rzu+B4wqeDsvV+GAI=
=vRFp
-----END PGP SIGNATURE-----

--BW2pnCmDs4P4T8CF--

