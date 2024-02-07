Return-Path: <linux-kernel+bounces-56724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3638384CE19
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4351F21E15
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400447D3E6;
	Wed,  7 Feb 2024 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g77QhICE"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36B97F7D9;
	Wed,  7 Feb 2024 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707319954; cv=none; b=azQPo9pT2yDemMN+OYUgr/eW9TMR8PQNU/PHUyHHH9GQc9eICO4pUkns2YawJL+nN2OCw+FKEWY4SUgN/hORlkC6jhgsYz+K8uBXMRdrk0YQHAjyqDQiBVGBQHqkS2kGrKoD8vzLCPcdru3gboiefqddRo7EylWdaMwPXP/+vJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707319954; c=relaxed/simple;
	bh=/ApcE6XEwaWfmGJrrnfNX8OxegVZFovON3wNgR1SCis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jin71yFCg/s5KpvnStI9nSJWoDpdCAaToA/TTB9v5fpquQJn/Gep5ybKrjCWBZhJRN5uUinnZiqKmuDCHY2NYbLM628p2iBwvFZVCv+cIJvGkA9pCYcAHDz9+DaBRuTG+YUmYy1Btu9JqPOe4eGofJdL8kLz+fXlZtLofGHNZL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g77QhICE; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5600c43caddso819826a12.2;
        Wed, 07 Feb 2024 07:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707319951; x=1707924751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ApcE6XEwaWfmGJrrnfNX8OxegVZFovON3wNgR1SCis=;
        b=g77QhICE1Tf5OUcCaJtNG0zVScu+uWvW6Z4UbWADcmd6RoV6ZPaFgHV2BjqqtkI99U
         zG3l2nqrwZSk3pv2vqTeVsAa3Lk/r4bjTBjAy9yjNg1CuXvjWu7/HJw5Jt5BzAyBnA0r
         usA8a1Dd9H9PyvbYjYO7XjSyZdcWWh198UUnlC8FhgRNtlX9Ou0VdAlNrP8jPw+pYUwV
         9RlcTo/JNyCU6KyTjcPBtfRH4C0yVVhbujQQoYcLTibOIlhjyy1Ldq8cpxsVlGn2Hqe9
         VvG+CRt1DgQmbSVaYnoNkSvrlIpw4jp+qVZpE8pRnyDwlMfI4XAHpOEMs83GkRATpFkb
         fRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707319951; x=1707924751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ApcE6XEwaWfmGJrrnfNX8OxegVZFovON3wNgR1SCis=;
        b=HsVsd+5JFJ3yTItdJjQQScbVKE686Og59/6cS6NgtbeNz5bMnj8nLrzEZlooPG/hOH
         5n88ThJIJWjNT825HHeCJzRkYkFCfEJ4Or6bg8oNsngoYPPQcbnAXpFefWKcUd7Nz5Y/
         qhBJPfV2tuT8Xywyvyb7ah7GtwCGtVBvRE+ukhEVYNN1AhwG69VDwl4vQ+rWFTxb+WYm
         DOLw2VHhaAHHYVfmeXuCS94KYQDKyreLJs/XSuPZdlkFbAM1AMvleeGDUUfoicX5uXDX
         gW3x6b+qPWYdGfmaK8V2d5Pdkxq8ywZ9MM2RggKLnN5g6yZW79YLwKRLkUnRy0g5BGja
         0qjQ==
X-Gm-Message-State: AOJu0YxkLgMomLUc2vkSV2WNek1uajiE5AZrWAHsIEMf7rrNEybyN5vN
	mgmHmQWR2iiqcgtLdZRkZ4XWb2kZi/OJbrtvb/DRUMtJ5RHoQsbrMDQ78fC3J7hFpuUuBAo9nPT
	NZkM40qhFljm1vIBDhftjq6Q6U/8=
X-Google-Smtp-Source: AGHT+IEnxSWbM0I3wXaFaz73jW3Nr4GKkTgNZ6XWT8YQ0wZ4A6oE2SclCaUHv4oGP2+Cj5JRQobObXKryUZoXuv/UQ0=
X-Received: by 2002:a17:906:f192:b0:a38:41ab:651c with SMTP id
 gs18-20020a170906f19200b00a3841ab651cmr3228401ejb.17.1707319950996; Wed, 07
 Feb 2024 07:32:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207152317.do.560-kees@kernel.org> <20240207152422.3855315-3-keescook@chromium.org>
In-Reply-To: <20240207152422.3855315-3-keescook@chromium.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 7 Feb 2024 17:31:54 +0200
Message-ID: <CAHp75Vf3emnw-=it-Smb_NG+xYjWhB+U0+i1hcNPWA=BByN6nw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] overflow: Introduce wrapping_inc() and wrapping_dec()
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
	Marco Elver <elver@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	linux-hardening@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 5:24=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
>
> This allows replacements of the idioms "var +=3D offset" and "var -=3D of=
fset"
> with the wrapping_inc() and wrapping_dec() helpers respectively. They
> will avoid wrap-around sanitizer instrumentation.
>
> Add to the selftests to validate behavior and lack of side-effects.

I would expect inc/dec to add/subtract 1. So, to me the terminology is
confusing. The list of the C/C++ operators on Wikipedia describes
above as

+=3D Assignment by sum
-=3D Assignment by difference


Hence the proposal is to have

wrapping_sum()
wrapping_diff()

--=20
With Best Regards,
Andy Shevchenko

