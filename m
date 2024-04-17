Return-Path: <linux-kernel+bounces-148127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFC28A7E13
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98EEA284ABE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CF881748;
	Wed, 17 Apr 2024 08:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQ/TrdyD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B497F7F4;
	Wed, 17 Apr 2024 08:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342096; cv=none; b=IDBKbpMtwCxAZ6iPhJE/xIKZf4ENXhbAQeOb/EfVtcEupogyHjDngbLTgtm/M3og/dDiqTr4LaB7X3MlFdu42DInz30WTypIZ/618V7RvsY1vEflXTMVzih2aSyOwMA93/TIsPbgnya8/9An3j6wQAvb8D4TJlwn2UjAYN+YxHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342096; c=relaxed/simple;
	bh=eu2GOPzGwad/3/lfGEROqvHCUBUr+7CG1NuOmCQ8RQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VRz+ekYlWicMcaDqVX1Dx8rFBC5gftiyml2BphnVFt+2CpDvcLjPQ4IxmrvX7v1R7zK69TsjJUG9ImVLAxAeJm/N0FrzVe8tFJwE3stFTXhLDFAfrqWuI8mz4jKMUJcsR9El/cIFn2k7KTh7hKDPGUlYzuMz2AYHCfhks51hXgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQ/TrdyD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C85C072AA;
	Wed, 17 Apr 2024 08:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713342096;
	bh=eu2GOPzGwad/3/lfGEROqvHCUBUr+7CG1NuOmCQ8RQg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GQ/TrdyD5qrydYrHbdpQYxJTDm7X+MozQyvwUMs04QORnA1KMTPovvdD1RyitGiCS
	 L7s+LQ2BQt2v8D/dquUkozkh/dd+ogq5S27r+6V3sUOBMhGBLLj/VOUArhJ++yei0P
	 M+Py3QISDfx1ZCQD745SZHoo2+KLPk0gIYjPO4OPTeGGaZsbHaxbVPs4JM2mXYwS5B
	 OH/rANfiWCC3oKR/6IyDtaK0ea4/OMpOgPCMuZUMx+yPvoC8OWYg/IDBA0CYedakZS
	 /lMfBhftFgkRpRMyduEKWgp8GPtCzAQ6+8iH+pzxDQd0koBjIin+M3HXgkUQfkrhhn
	 YP7sNHkcHVisg==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5aa17bf8cf0so865825eaf.1;
        Wed, 17 Apr 2024 01:21:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXVSnD/0JKlPAhOU441W7rMHtdmkA7gemuSbsEIBWP+xDlWD9knavgKI4eQ1W/yxxVSd74hLwq2SLX5BGcYzSHboQHgVxXxciG6fP4aDCEDj1eVxFwL3WDuP6C3cdJ1M9n0w3L1cCE=
X-Gm-Message-State: AOJu0YxVgVSPSIGyDht5mYuMWUTOljbmXpjzzq+H6lJRm6OhoO9MuHIc
	IjNHljdDlf7Gvqhad/6bqypp4y5bjdeZUq7seTxlIY/kfLncbtdHq3QtVCcjTqP9+aHdY1yTw/O
	KlZ+pRw+ruKf2ojpOirXw1Gq3+Qw=
X-Google-Smtp-Source: AGHT+IGoRTQ/V437LwNCrGiF0jtVKX86Oy53+gMmVH8pyrBe4lpDVCLLmCiyHNQiGlmHI2OMp4NTfOU9rqXtWum1qkw=
X-Received: by 2002:a05:6820:f44:b0:5aa:241a:7f4b with SMTP id
 ep4-20020a0568200f4400b005aa241a7f4bmr14975713oob.1.1713342095681; Wed, 17
 Apr 2024 01:21:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416211941.9369-1-tony.luck@intel.com> <20240416212206.9490-1-tony.luck@intel.com>
In-Reply-To: <20240416212206.9490-1-tony.luck@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 17 Apr 2024 10:21:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gsU1suTkk1P16QiKqg-dj4Wna1r7h1L816BXQHVbZ7tg@mail.gmail.com>
Message-ID: <CAJZ5v0gsU1suTkk1P16QiKqg-dj4Wna1r7h1L816BXQHVbZ7tg@mail.gmail.com>
Subject: Re: [PATCH v3 44/74] x86/cpu/vfm: Update drivers/cpufreq/speedstep-centrino.c
To: Tony Luck <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 11:22=E2=80=AFPM Tony Luck <tony.luck@intel.com> wr=
ote:
>
> New CPU #defines encode vendor and family as well as model.
>
> Signed-off-by: Tony Luck <tony.luck@intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/cpufreq/speedstep-centrino.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/speedstep-centrino.c b/drivers/cpufreq/speed=
step-centrino.c
> index 75b10ecdb60f..ddd6f53bfd2a 100644
> --- a/drivers/cpufreq/speedstep-centrino.c
> +++ b/drivers/cpufreq/speedstep-centrino.c
> @@ -520,10 +520,10 @@ static struct cpufreq_driver centrino_driver =3D {
>   * or ASCII model IDs.
>   */
>  static const struct x86_cpu_id centrino_ids[] =3D {
> -       X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL,  6,  9, X86_FEATURE_EST=
, NULL),
> -       X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL,  6, 13, X86_FEATURE_EST=
, NULL),
> -       X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 15,  3, X86_FEATURE_EST=
, NULL),
> -       X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 15,  4, X86_FEATURE_EST=
, NULL),
> +       X86_MATCH_VFM_FEATURE(IFM( 6,  9), X86_FEATURE_EST, NULL),
> +       X86_MATCH_VFM_FEATURE(IFM( 6, 13), X86_FEATURE_EST, NULL),
> +       X86_MATCH_VFM_FEATURE(IFM(15,  3), X86_FEATURE_EST, NULL),
> +       X86_MATCH_VFM_FEATURE(IFM(15,  4), X86_FEATURE_EST, NULL),
>         {}
>  };
>
> --
> 2.44.0
>

