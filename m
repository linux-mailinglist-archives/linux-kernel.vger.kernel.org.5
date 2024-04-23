Return-Path: <linux-kernel+bounces-155704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 592868AF5DD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F4261F23DD0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF2A13E040;
	Tue, 23 Apr 2024 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRfhfJ8L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A312513CA96;
	Tue, 23 Apr 2024 17:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713894902; cv=none; b=AdlJU8/JUM4qpPSY57NRZNfBmz/QBVCk8Hhs49jzizz/TbpmMZ0Ez1sbHWroR7eJCLkH46lmC3dYyNiOipnn0dltpZ872btNfxFzTGlwi7m3PBjZawaC2mn7dEKaZ0KDX+cKWCB2UvNBVT1iDhYmgqDDCYw4h/kF6iYEH29WeLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713894902; c=relaxed/simple;
	bh=PGQwdnS06bvdys+WxRJxUn/Bg9dr1D8tAvnY139mQcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tg/kLzzb9mFIkM8szjQn9GBA7ca7H2tAcOSzbdAK8nVjGXh1iFAU0HauPnh+B01vuiMNaTE0r6jsCLWzH/iBqJH2OtxFsXDVZKj91gbWvc3oljBcJ5+RJD858DMJoqWgaYc3+MzBfTiskhL3+Np0vfU5qkKnfJrFYnpsMs9SYrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRfhfJ8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE093C2BD11;
	Tue, 23 Apr 2024 17:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713894902;
	bh=PGQwdnS06bvdys+WxRJxUn/Bg9dr1D8tAvnY139mQcc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mRfhfJ8LRu8ZU0Q9yu8YHFx02Veix5EyONslm0St76zo3ykKtxI2iqvbrk/2yAq4K
	 56wFXk1Z6A/UjukfTAL33aIjQVbcSodwxb2VkkVuVSVYKglzNvRHYXM+ghcQSbHdDg
	 e5U+QJ5aulRB4Falrk8n7ozfpbDW9Z8Qa8lsT9Eb60yS2+ltB9Zzi+p+TssG9aj6XN
	 WvpKrfDguRkYZjFyEslJAoOgr4C2V2VwjZ6Hf7xnQ7+YdSwrk7nhzOaGTZBIkXhcGT
	 5jbUhezrMtaWkaNTg2TqvVkjvnf+JS8tRTnUVklbCTY0jL31kJePnBRPuklCDR2Tkh
	 W1iSPyXi1E8dA==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5a9ef9ba998so1316559eaf.1;
        Tue, 23 Apr 2024 10:55:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWmBGnMV7k4hbLOqU/69cMJFi2tNcZLiUwXMcDXk2HfvBhxKkrtVwmCQna5RZ+qnraqACMp3pepQOX1656pPkRxosoTHR021cfAjN1QZ9ZyVeHAIZzAeg+8u0WdTj3CoBG0LaywKKU=
X-Gm-Message-State: AOJu0YxzdzpOOla55u+ictlK/dfDE0IeKdkERRvOwFSlmNweZ1a1dst6
	1wxmp4dDAsRSUl5RKEI2aVKavmuB1RwdjXT4FSvGMdTtKHl5GaRUWsQTZGFm4JZX6ZC8/A+kwtd
	LDpLdwEtvQ0bCs1fIF7giPFyOuyQ=
X-Google-Smtp-Source: AGHT+IEQnVXWc2aNMSwsVGjapjUioOU3uOUD6dYJ0Y7yyxS3FzliJyvm6Y2uE9JWKAtUfjcfpewhB0sndpq5NUYExOI=
X-Received: by 2002:a4a:e6c7:0:b0:5ac:6fc1:c2cb with SMTP id
 v7-20020a4ae6c7000000b005ac6fc1c2cbmr95685oot.0.1713894901224; Tue, 23 Apr
 2024 10:55:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13515747.uLZWGnKmhe@kreacher> <1913649.CQOukoFCf9@kreacher> <8e26c3cb-1283-4561-95aa-30432f1d13ee@linaro.org>
In-Reply-To: <8e26c3cb-1283-4561-95aa-30432f1d13ee@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Apr 2024 19:54:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h=15LYhukPWmHPK5hvD=2u75rTEiC8oJMVBFziMkB5gQ@mail.gmail.com>
Message-ID: <CAJZ5v0h=15LYhukPWmHPK5hvD=2u75rTEiC8oJMVBFziMkB5gQ@mail.gmail.com>
Subject: Re: [PATCH v1 07/16] thermal: gov_power_allocator: Eliminate a
 redundant variable
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 7:35=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 10/04/2024 18:12, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Notice that the passive field in struct thermal_zone_device is not
> > used by the Power Allocator governor itself and so the ordering of
> > its updates with respect to allow_maximum_power() or allocate_power()
> > does not matter.
> >
> > Accordingly, make power_allocator_manage() update that field right
> > before returning, which allows the current value of it to be passed
> > directly to allow_maximum_power() without using the additional update
> > variable that can be dropped.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
>
> The step_wise and the power allocator are changing the tz->passive
> values, so telling the core to start and stop the passive mitigation time=
r.
>
> It looks strange that a plugin controls the core internal and not the
> opposite.
>
> I'm wondering if it would not make sense to have the following ops:
>
>         .start
>         .stop
>
> .start is called when the first trip point is crossed the way up
> .stop is called when the first trip point is crossed the way down
>
>   - The core is responsible to start and stop the passive mitigation time=
r.
>
>   - the governors do no longer us tz->passive
>
> The reset of the governor can happen at start or stop, as well as the
> device cooling states.

I have a patch that simply increments tz->passive when a passive trip
point is passed on the way up and decrements it when a passive trip
point is crossed on the way down.  It appears to work reasonably well.

