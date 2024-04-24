Return-Path: <linux-kernel+bounces-156866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB3F8B0970
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503D41C2405C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637A615B124;
	Wed, 24 Apr 2024 12:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqV6jfm6"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163DE15ADAE;
	Wed, 24 Apr 2024 12:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961589; cv=none; b=Qegq5WcolITvwor9UkO0hxO5tdS+U2I8fJd/PLegc0uCqaW9gKtFgwAPdrNH7TUm2mCIRm7NEjYKBHrrjaAvce201EgmaMj/yHXU+DmYpsDgyodoIxTaWsD8Yzh/XPCKUPdgO9HdpFft2pgPf41Nj7/BdEgX6G7Z9X3qZ6utFqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961589; c=relaxed/simple;
	bh=pENaq1F7irNnXDi2tqew8U6t/paLMwTAdvNSKq0Z4zM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KbiYL4QJ1iEQ5GN4pAtUEaDoh8+TBijE63FZTYLOj1Rv0eBPDnYuoUOsqdSa1Z3hyFe9dx5nsGJBnAO1B7VNNPrM5MsINju8ghm7iDHd1p8hbrxFbXcZ4o9sQxqcS7qIJpea0/Lnmzbw+KNgmpkNW/r3zX+rDHZUBX9OZBWoJeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqV6jfm6; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-572040691c9so1608885a12.1;
        Wed, 24 Apr 2024 05:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713961586; x=1714566386; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+rdUuC6v/k+XVeWN6GsjQ32OKOeNoWrrRy+0NsEkvrY=;
        b=OqV6jfm6FiqSb1JS2mULvh03zYC11KgLFeucABNpQolicHowgO+r/b0WY46hdFSjsf
         TGMGzrtqOX7lnK0UuJqyxLcyVE1xZh33gNIocmW+3QeL3xl0jVLv3xbrigWb8IIpynxB
         g1E/+xTwGvJC/abW5R6dLJ1bSSv8hrSgjS7XYupBoxod6aSR7MN9sWv7C/MB5Xu0CjiW
         BF94EH1nDwUVcZRcs9mMz4LVIY5qawqBKAQnECHLlSlve8i413OQQlZakamGKzx09xi4
         65lXtAnh9VXLy+OVa4JzpzMXKEtuyjQiYvoBxCqTeBX/DYUCTjyd2MI/IBIIk5VhFMkd
         rLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713961586; x=1714566386;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+rdUuC6v/k+XVeWN6GsjQ32OKOeNoWrrRy+0NsEkvrY=;
        b=evtICmYPkWWrH1ss0bPX30HsY8EMM+P1kBmICyWZDlYNv2XV9GZE9MARjbRU3Q+XNA
         3b1P9gdGSKXGwuVAOzqTRilx22hcmpwKK+1ImvoVkatACAEnDFmyHZWlcDnKOQEBIKW8
         K5m4e5v5S/WhinheM4H1BP62WNfQZFUdDVlvk4hc9SjjcKuuTG0zUANYMC/J80mNxYoL
         W2N2n+F4OXN0Jy5F2fvNoySUUZpmcevWM0q6rUXfspZUMM7KE/YuTvrG0Pjqk7ffbqkH
         4P6OpUU4z3nFSJVyOeihfuM66xX77JY5gqClEmy3IIYBAAtlyyahhtGNMA5k5Y+TVOqw
         e2UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo+oMjoiy9Z6lnhOs8ztNdPwe8Isv5bE0L5IqrQC2UdBzScy01NbSraAnhZl7eTmjjh+Izvi49Y9yikFUXFiLa3AB8oowcmIkZdHd6KOGRMaemeMN+v6cEsE8pBGU9kSKL5sigFpEZ0EOGwXfNaIT0aKs9bF27sfW1WHrvVTyJDkzV4yAf7eat
X-Gm-Message-State: AOJu0YzRz/R2yH48HMhdJCWF60C8bdiNTzsIEzOV2aISieMd1cEOcvzq
	qkrZ6D86r4Ds6pNEkhD00Df2agPEm61MRy5cfhhJCl9xFV8ztoOt
X-Google-Smtp-Source: AGHT+IEhYR/0oIc/UbYhCWFPOMnJ7hBf7xrAGXFnwFIUU3o/7hThyqIDCatGp2KdXpmqCDltGTfWgA==
X-Received: by 2002:a05:6402:22a5:b0:571:da40:22d9 with SMTP id cx5-20020a05640222a500b00571da4022d9mr5090846edb.10.1713961586077;
        Wed, 24 Apr 2024 05:26:26 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id ef9-20020a05640228c900b00571bde3b0a4sm7497051edb.34.2024.04.24.05.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 05:26:25 -0700 (PDT)
Message-ID: <87c6e65dadbb3ed0c9b4506e809eb3976b12f204.camel@gmail.com>
Subject: Re: [PATCH] iio: dac: adi-axi: fix a mistake in
 axi_dac_ext_info_set()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Nuno Sa <nuno.sa@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Date: Wed, 24 Apr 2024 14:30:02 +0200
In-Reply-To: <df7c6e1b-b619-40c3-9881-838587ed15d4@moroto.mountain>
References: <df7c6e1b-b619-40c3-9881-838587ed15d4@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Dan,

On Wed, 2024-04-24 at 14:45 +0300, Dan Carpenter wrote:
> The last parameter of these axi_dac_(frequency|scale|phase)_set()
> functions is supposed to be true for TONE_2 and false for TONE_1. The
> bug is the last call where it passes "private - TONE_2".=C2=A0 That
> subtraction is going to be zero/false for TONE_2 and and -1/true for
> TONE_1.=C2=A0 Fix the bug, and re-write it as "private =3D=3D TONE_2" so =
it's
> more obvious what is happening.
>=20
> Fixes: 4e3949a192e4 ("iio: dac: add support for AXI DAC IP core")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> This is from code review.=C2=A0 Untested.
> ---

Auch, good catch! Agreed that private =3D=3D AXI_DAC_*_TONE_2 makes it more
readable.

I guess Jonathan may just squash this in the driver (was pushed this weeken=
d).
Anyways, FWIW:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/dac/adi-axi-dac.c | 6 +++---
> =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.=
c
> index 9047c5aec0ff..880d83a014a1 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c
> @@ -383,15 +383,15 @@ static int axi_dac_ext_info_set(struct iio_backend
> *back, uintptr_t private,
> =C2=A0	case AXI_DAC_FREQ_TONE_1:
> =C2=A0	case AXI_DAC_FREQ_TONE_2:
> =C2=A0		return axi_dac_frequency_set(st, chan, buf, len,
> -					=C2=A0=C2=A0=C2=A0=C2=A0 private - AXI_DAC_FREQ_TONE_1);
> +					=C2=A0=C2=A0=C2=A0=C2=A0 private =3D=3D AXI_DAC_FREQ_TONE_2);
> =C2=A0	case AXI_DAC_SCALE_TONE_1:
> =C2=A0	case AXI_DAC_SCALE_TONE_2:
> =C2=A0		return axi_dac_scale_set(st, chan, buf, len,
> -					 private - AXI_DAC_SCALE_TONE_1);
> +					 private =3D=3D AXI_DAC_SCALE_TONE_2);
> =C2=A0	case AXI_DAC_PHASE_TONE_1:
> =C2=A0	case AXI_DAC_PHASE_TONE_2:
> =C2=A0		return axi_dac_phase_set(st, chan, buf, len,
> -					 private - AXI_DAC_PHASE_TONE_2);
> +					 private =3D=3D AXI_DAC_PHASE_TONE_2);
> =C2=A0	default:
> =C2=A0		return -EOPNOTSUPP;
> =C2=A0	}


