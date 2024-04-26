Return-Path: <linux-kernel+bounces-159474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5C38B2F0A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEABFB22A2F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D21978C7D;
	Fri, 26 Apr 2024 03:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+ZC0yNi"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B46878C62;
	Fri, 26 Apr 2024 03:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714102586; cv=none; b=ZJMuj0b9htHTZqMxGCGirKVdUTsMjbTlz3u+Yk+npIcIAC4sSqZq4xjwNm2Yf7VBQm6fzjxENyBpII53Sh2qRzbuxC20jKcb268Y+ux8SzOtRYo+SppgAsl087oj9aV1EgAT3CaJQatkL9abenkI0pQH//jecU99stdy+LzwH4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714102586; c=relaxed/simple;
	bh=Ocikva22THq9PBTO61gJ+rASfUWRbAU8cbS5LgaAepQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPnBcTnxO7m8gKmGVEOqsJJAUL1a93U8PUMGyE9GKERfANYge/+G7LpL7rikQu/QmvEw5l7CWnCOZpUxZez52aCEVXNlQUmcEvgDqyP3q8dcEvysZATPiii7O0vQ7mB6gTDlA3Y3F37yYTFsMtJ+6EXvr9k4fm8AIqRi42YrceA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+ZC0yNi; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bbbc6b4ed1so1081082b6e.2;
        Thu, 25 Apr 2024 20:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714102584; x=1714707384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8cFtVpbfNqJH56tTzxhsPWmtdud93WLdQtJ36KpwUE=;
        b=L+ZC0yNiKVIiMtoAZi6J6JWbCVNPs2+QAWPeCKjPrN+Yht92sj1pTUVAmNF/TTpjhd
         qVOQR9aq8LZHtxxUPQD0xVyesuoeQ6wpDNqZuAQ0A8AodhyewnQbKceTLv6+Vc4pOrKi
         rV3hxnvGdEaNB3GyIV7BzR8NKnVw7bfV8zRTlYPQ2C3l57DEmjTBgavPT6SjT95h0N5s
         lS/vWe0gJy3QdPpoOxvU1zKW/2RtSSjxg+A5dLDhb1cFNbbkRLyU6Cj6lK+Tr96LXSOf
         qc4Sjf6LNp6f1ikg3RpW9RbVelPEQ9W8ZpSi5M1/5i52gmXoMziKwrv4cZhBZ9SAkt4/
         MhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714102584; x=1714707384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8cFtVpbfNqJH56tTzxhsPWmtdud93WLdQtJ36KpwUE=;
        b=G2KZHJaBWs5/lGQXagHZapFp1hcz/Lh8g+mIoi8SHMb//9hsLt7xnskBIXPF9aMzHU
         8SeD9ZxC9EFCi5yzfGSf9CH3Gwu8Be4aKATslqre+yROlzs/VjO2i9fcHvUdAxtKBFrf
         DIlLjl+zzvaLGUFcn2Z+yS+Nb0kMpvbyd+Drz+YoyGXG2v9RDY6/+zM0vVpRL1XvGYUD
         cWv1Ucu8OYm+npIHpfGAorxXEdOfSJbG0i0LJV0HVrc70tNZeADGZ0pOaw3CjEKyATNp
         6lYDI6DnY0eda+NQyh4UB9NBK28KHi5awgxXvNkMO+VAi3a8Elnkw9JKWwJj9KdP89bD
         +WFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeXITXE0UZcFPw6oNoVR8WJDpLMbYVWYePb3DGFs3ch0NxZ0Q4I6PUTaOKT0A9/qViGIxs5CFu23sKhu3pxG8G/47axnqWVA5a3xkxAvSQiAaQ1rUz9WzQdlsJZyqCFxs56HSDFM+CynbT+l45cXc7WRhny2S/M3/VPowthhTW6sKgZZJ4GUKanNKf7ZYc/a8HEoO4A1S71SE1whoH0P5EL4WbgYUgHid/1D+tO1JNH3q1f/M+wuEmPRIHRA==
X-Gm-Message-State: AOJu0YzLmRtGNLL2aSSl1JJccUgAD56zd4nJj27r1orHs47LkqPbuDkj
	mqr9p6EzmQWjrs9crxhuXO2iw1kBA7lcSNnUH90NmkQtAurjhlG3
X-Google-Smtp-Source: AGHT+IHBLFRWKXEYGxFCF54F3pVkYNxRnt0ZLU+mSTWXVXW5HHsRpGcBmTNLh/DFqy2C7n5xKmynJg==
X-Received: by 2002:a05:6808:13cd:b0:3c8:4dcb:3d8e with SMTP id d13-20020a05680813cd00b003c84dcb3d8emr2189161oiw.37.1714102584292;
        Thu, 25 Apr 2024 20:36:24 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id t3-20020a635343000000b005f077dce0f6sm13740028pgl.31.2024.04.25.20.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 20:36:22 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 05F3C18462BCF; Fri, 26 Apr 2024 10:36:19 +0700 (WIB)
Date: Fri, 26 Apr 2024 10:36:19 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Wesley Cheng <quic_wcheng@quicinc.com>, srinivas.kandagatla@linaro.org,
	mathias.nyman@intel.com, perex@perex.cz, conor+dt@kernel.org,
	corbet@lwn.net, lgirdwood@gmail.com, andersson@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
	Thinh.Nguyen@synopsys.com, broonie@kernel.org, bgoswami@quicinc.com,
	tiwai@suse.com, robh@kernel.org, konrad.dybcio@linaro.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
	alsa-devel@alsa-project.org, Mao Zhu <zhumao001@208suo.com>,
	Ran Sun <sunran001@208suo.com>, Xiang wangx <wangxiang@cdjrlc.com>,
	Shaomin Deng <dengshaomin@cdjrlc.com>,
	Charles Han <hanchunchao@inspur.com>,
	Attreyee M <tintinm2017@gmail.com>
Subject: Re: [PATCH v20 41/41] ASoC: doc: Add documentation for SOC USB
Message-ID: <ZishMx1mSpnbWq0P@archie.me>
References: <20240425215125.29761-1-quic_wcheng@quicinc.com>
 <20240425215125.29761-42-quic_wcheng@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P89L7XsIZU/s9H0u"
Content-Disposition: inline
In-Reply-To: <20240425215125.29761-42-quic_wcheng@quicinc.com>


--P89L7XsIZU/s9H0u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 02:51:25PM -0700, Wesley Cheng wrote:
> With the introduction of the soc-usb driver, add documentation highlighti=
ng
> details on how to utilize the new driver and how it interacts with
> different components in USB SND and ASoC.  It provides examples on how to
> implement the drivers that will need to be introduced in order to enable
> USB audio offloading.
>=20

The doc LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--P89L7XsIZU/s9H0u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZishLwAKCRD2uYlJVVFO
o5DJAQD+rkyBnIMvpNNaVk9L86LrDuJEbiHqinPevfblrJEMzwEAq9C11BX6KHIX
RW6EYUrw/Ayfy0D/ZGZo/aorFkUhrQM=
=d3kj
-----END PGP SIGNATURE-----

--P89L7XsIZU/s9H0u--

