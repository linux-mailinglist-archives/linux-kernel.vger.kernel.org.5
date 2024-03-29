Return-Path: <linux-kernel+bounces-124374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 570F1891669
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECA3CB22936
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE8251C5B;
	Fri, 29 Mar 2024 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVSnU9XO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190AA3C082;
	Fri, 29 Mar 2024 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711706405; cv=none; b=th1D00qEyepyyfwU+J/SXraU17CrzIkf7dF06Voa6mTucIlrkJ23306HlPacLKKFJM0vlCguadYpS9s7aL5/qmaLUNI1rMRu7VhvAbec/PEUjFSSP0vTu038JnGzMHUJjDQMkmv1gRPaMPGHCCI3+vBimQyUwFFWyiNcx/uszic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711706405; c=relaxed/simple;
	bh=JeoL8tgYfRLmQeXbdQXINzajoj/M5gYJO3hcMiPqF2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=byoIMWbT3ydTvoP/8i0FXXMfEV1ynpDcvisb8I6/35p6ISOdNIuq6NEnOXPSmSBhc3sDJGaoMJpr6oRTPXDggRN9ixyeqrACJ1b9GLzIBM+fJhrPmt9t9QZ9qaVd24qpk/m7gwhmAx0D3ydFgDjzb1XQdYU9NrYSWzDKOBKwMa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVSnU9XO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8EDC43399;
	Fri, 29 Mar 2024 10:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711706404;
	bh=JeoL8tgYfRLmQeXbdQXINzajoj/M5gYJO3hcMiPqF2k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iVSnU9XObqaWBkUNHLJwjDFW8dNzRQvPprcHtt7FcCVRqDeLFstsVgTAX8qR+0zWL
	 1CGfLNG8jFhqK6Nr8iLUSLKYlF61P2Bg4veHSXK7LzQA217KXGNNQDXbEzFeK/rLwX
	 lqX9MvwjF+5NO8brOWTMJf8mNguD8Gy16OzJHRC2tCNw8Yf7z2Zshh6xu8iAevLMwJ
	 lg5gGRTCANjtuq95hgSoTSTT9cjrTuT8N3QMf7QBXWW6F9PdwbTNZc5SGm1uUO8zho
	 5JcWlI1Ih6SDlwQsCh+w7M1Wrv5jOv8DiVAiitQMXn77TXtMHYY0fQurGAOGbWEoVs
	 h3G9FNja6f0MQ==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d700beb6beso24319051fa.2;
        Fri, 29 Mar 2024 03:00:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUve0kLwBMTuJfTySySN8mA+SmLoWbwdPV/vRrlPPFmulW5F7sDa6LyMXyi4tcH4XbOXrZ4bZYHxSDEXTrbZWQR1vD7G1LyKPTQxXFpOrp4zdmCQueUpj9ALdhYPm0fJ6YpGmwQJJuKo0JF
X-Gm-Message-State: AOJu0YzEvz6U33jpWRErkY27rTlZGc4iXIrPDsQxehriu/pHNk7dLY2T
	NWdEWTuZcqvzS5dC7GKwth5DMGff+9RUnAwwe8Ayxv9C0BFZLA9DceS/QZnETgLRwFuzBp9Drw/
	PmFW8vFJAykeEKuoDtYx5a2DElTI=
X-Google-Smtp-Source: AGHT+IE8fNsC4npvIJj7JoDFdnhBn8HxRc1AN+ilrtwIM+o8gDLozyoOgRnQa/JJJWfL3LOIVytOpd1fNuorqihhMq4=
X-Received: by 2002:a05:6512:3b27:b0:515:bae0:1136 with SMTP id
 f39-20020a0565123b2700b00515bae01136mr1676897lfv.65.1711706403212; Fri, 29
 Mar 2024 03:00:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320180134.100863-1-arnd@kernel.org>
In-Reply-To: <20240320180134.100863-1-arnd@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 29 Mar 2024 18:59:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNATQJ6HXwsY2ziDPnQ5AdhFHL=M=qPW2idyPQrumsXmkrQ@mail.gmail.com>
Message-ID: <CAK7LNATQJ6HXwsY2ziDPnQ5AdhFHL=M=qPW2idyPQrumsXmkrQ@mail.gmail.com>
Subject: Re: [PATCH] scripts/unifdef: avoid constexpr keyword
To: Arnd Bergmann <arnd@kernel.org>
Cc: Tony Finch <dot@dotat.at>, Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	Michal Marek <mmarek@suse.cz>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 3:01=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Starting with c23, 'constexpr' is a keyword in C like in C++ and cannot
> be used as an identifier:
>
> scripts/unifdef.c:206:25: error: 'constexpr' can only be used in variable=
 declarations
>   206 | static bool             constexpr;              /* constant #if e=
xpression */
>       |                         ^
> scripts/unifdef.c:880:13: error: expected identifier or '('
>   880 |                 constexpr =3D false;
>       |                           ^
>
> Rename this instance to allow changing to C23 at some point in the future=
.
>
> Fixes: d8379ab1dde3 ("unifdef: update to upstream revision 1.190")

This can be a problem only for future kernels.
Is it worth adding Fixes?

Even if the kernel bumps to C23 at some point,
such a patch will not be backported.




--=20
Best Regards
Masahiro Yamada

