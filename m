Return-Path: <linux-kernel+bounces-153707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF528AD1EC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41A101F216F9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7B915381B;
	Mon, 22 Apr 2024 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpIEAHle"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE63622097;
	Mon, 22 Apr 2024 16:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713803529; cv=none; b=UV/gIgV9mjbAqRebKW2jFOXEdaEvbEz7B4+WpIyW81rpX3EfzqmwfvKiPqOnylh9RD62rQKL4bKYOR3CewLnwafRlaiFjtlar5lMCM+JIQi+52Y/w1uvITO29y6oit684Uf7N7yN8NWUkIeRiflx3NVoqgLYvM2mRvqmm9Ue9mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713803529; c=relaxed/simple;
	bh=eeYEKDRroUBe131HinwlgtV7hkw/MPp/EnqfckZInk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JlL2ZdO9DfqsfBoFSrM7/1plhgsX0w05UaU5IdzNA+MtCpJtQmKKivQxPq4ZufCq/KvkE6OhxLphcUTUvZMUaJ67V1PbMDTZlPa5FJsCYvBg4KDjYbz3Fxl6gjbjQktNqRATesFbioj5dD9WZgv7WwJzmt3styJ/S0QYBTh8PR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpIEAHle; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3567AC116B1;
	Mon, 22 Apr 2024 16:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713803529;
	bh=eeYEKDRroUBe131HinwlgtV7hkw/MPp/EnqfckZInk0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WpIEAHlekX5jt3WtAK6Tkgvk/Lq7sQO66JgFoKNdC0RCKmHCHisXYtE//bDTtkpFK
	 u452IcXWur3vQT5M1QFbJ5ZxTNfASoOhLov7fD2R5kO4/PtMa8hBjcOcntvThVeV5a
	 8RWe5wvJnUwZg4e/4fjMo/2Sc6uzM4GJDMm6twE9O0b9h4SauzZ1f5Z153Y3mipbgE
	 zZ2RtfoL5FVsHLZDAVsZsQXJfbT9UrkpSHfAWu4DGWTHpUOEDU0f959Kg6Z5/qc18x
	 RAjm/cE4TGcLaXfPDW55VBULL/pe/gWZechO+SPBpnfz0BmoUflX5lguT3Q/INkMP7
	 tOvyZez57DE+g==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5aa17bf8cf0so55411eaf.1;
        Mon, 22 Apr 2024 09:32:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUuwC/dNrq+GSbs8qUuph+C5E7nDj+URQt38p9AteJi2qEOHHpluD2pk7Eq1H3ae0No0En3RD9+XIVnXBQqtGlnMy12s0SNcRUMCH0aCl3pec9p43DnJIHMfmU6FJ6CWgJHTYeoUJMv+A==
X-Gm-Message-State: AOJu0YxKaPr9845DX1e0SgXfONZ/pdryG6CCl0qIDi5e/wCM+vX1sRSl
	LVBkRN3ahMf0l5nxMPTw6L2eDA1x9u1KlheiZ3uVGGRGCtG1nUgTLid7Y8AB7Rn6Fdwe7+QiYXn
	npmyM7n3/WJ4sFdIWjpgloS4GJj4=
X-Google-Smtp-Source: AGHT+IH/7jSbwHBSkipIDB+r20nsXh7Vq2Gb/KuCoPn579L5cGCwhjp170j53dKG7KpSFvPAEnvyfXXNkcbux/RE2Y4=
X-Received: by 2002:a05:6820:ecb:b0:5a4:7790:61b4 with SMTP id
 en11-20020a0568200ecb00b005a4779061b4mr11421017oob.0.1713803528588; Mon, 22
 Apr 2024 09:32:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405142226.144216-1-schnelle@linux.ibm.com> <20240405142226.144216-2-schnelle@linux.ibm.com>
In-Reply-To: <20240405142226.144216-2-schnelle@linux.ibm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Apr 2024 18:31:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iiU9Fm7z3h2nr==YiE=CuSCpDg0ncUvvjt3z+LEn3SmQ@mail.gmail.com>
Message-ID: <CAJZ5v0iiU9Fm7z3h2nr==YiE=CuSCpDg0ncUvvjt3z+LEn3SmQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] pnp: add HAS_IOPORT dependencies
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Jaroslav Kysela <perex@perex.cz>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 4:26=E2=80=AFPM Niklas Schnelle <schnelle@linux.ibm.=
com> wrote:
>
> In a future patch HAS_IOPORT=3Dn will disable inb()/outb() and friends at
> compile time. We thus need to depend on HAS_IOPORT even when compile
> testing only.
>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> Note: This patch does not depend any not-yet-mainline HAS_IOPORT changes
> and may be merged via subsystem specific trees at your earliest
> convenience.
>
>  drivers/pnp/isapnp/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pnp/isapnp/Kconfig b/drivers/pnp/isapnp/Kconfig
> index 8b5f2e461a80..8e5dec59e342 100644
> --- a/drivers/pnp/isapnp/Kconfig
> +++ b/drivers/pnp/isapnp/Kconfig
> @@ -4,7 +4,7 @@
>  #
>  config ISAPNP
>         bool "ISA Plug and Play support"
> -       depends on ISA || COMPILE_TEST
> +       depends on ISA || (HAS_IOPORT && COMPILE_TEST)
>         help
>           Say Y here if you would like support for ISA Plug and Play devi=
ces.
>           Some information is in <file:Documentation/userspace-api/isapnp=
rst>.
> --

Applied as 6.10 material, thanks!

