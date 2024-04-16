Return-Path: <linux-kernel+bounces-147445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 566F18A744F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BE321F2196B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C207137931;
	Tue, 16 Apr 2024 19:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ve6W9IoG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B823137748;
	Tue, 16 Apr 2024 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713294354; cv=none; b=q+HHhLLeUr2huQs7FLdQUNVzqOF5cOAb1y65IvI5wWkvOEQSoQoOZskfsKdLRpfenKbdXAb6m6pyPiWrZqdaR2LDqyir59CHtk9kIvjWWpmD6XphZV0T1vehQ8uMypueV1BsiyOynM/Lz0urvsmj8hZx5ljhVA3TUorurNLjBSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713294354; c=relaxed/simple;
	bh=//2khB4PkoPCVtJ4LDJlzBGxfIX4c4GcIdP1vLzEsvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ic9cQUOErcY/3oAlu/ZUbqfW96LlLLu37FfGJv1cV48YCUeDedRTC8BB/tE7RdcYrq9DJnIXHs1dMiHDGurFbQQrJxq/LeiB0ei/l+R7g+AOl4a5xxKXaJLH8QLd9trBYo3h/Zb6lSYTN7KZTjNJLQ0eJgL5R2+keb7duGqoXgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ve6W9IoG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9B7C32786;
	Tue, 16 Apr 2024 19:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713294353;
	bh=//2khB4PkoPCVtJ4LDJlzBGxfIX4c4GcIdP1vLzEsvE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ve6W9IoGJERReaqSKZfSKN9xPhMy2uek5Ds2ow6tlgLNGJL5ZUD/morWwk477RqpZ
	 BYJzh734DTM2rYEr3d7pMAg/hHJfUYeX/+LW8bAKE9+jGUwWc/LpaJmm8HGunM2nLR
	 IUV3ZY/2zww1DL4clTYTX7x/ZchAOaSVB2AUFyOEyT48LcbGRY9tZBdydkM2BmWOA7
	 rLSpw/oVvU/C8iIBejDiBvlarTcSnga0gdxjHDGBRPAHDfpm5ELrvngAQETf4ThuYv
	 Kvhe8wV7x9uDx3x9m3BqF+2sUfisi48PmcSIw9zx1s9OOLYpiwIvhGHcxwiu8ppfTz
	 4/gJMXCYKD+Hg==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a9ef9ba998so1260875eaf.1;
        Tue, 16 Apr 2024 12:05:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXVRtOrOKpfFs7Zh/6jU7+VqW1Vmg01s4SIHmaFvZmWd8fT8JcvOMJfIQOWsyzgCewmfaOLxGBiz+hREaSS1zHV6jE8AnEvQJ62XokxZFbNYlpw7UGXsRWlYpXr10e6redXXfSn0xFpStecinYTVKrxyrCbskmCAzCUD6AHYBXMTj2ZcWb7lw==
X-Gm-Message-State: AOJu0YwOK2nPQKK+uhsOV+rodJkIeBrtbjQTUWSNtgTpTHGILXSIVAXl
	ssxeHAo23UcoRxW33gvU02Y5rit1wUS4MC6cT8MnTG0SpMnjfSLeg0votr/mgdPGkklLb7jgZ1r
	Dh4iML2CmMfrGfbAlmuMn6b6+PhQ=
X-Google-Smtp-Source: AGHT+IG53TJDymK56MS7YszkNyUNXpVZZ4HqFtIOnyEF8FvjKYHxjNHMhP+lklujEI0wH0jJXkfV00gzQS5Ip4GpPfs=
X-Received: by 2002:a05:6820:4187:b0:5ac:6fc1:c2cb with SMTP id
 fk7-20020a056820418700b005ac6fc1c2cbmr13625856oob.0.1713294353171; Tue, 16
 Apr 2024 12:05:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713234515.git.albanhuang@tencent.com> <4e68f5557ad53b671ca8103e572163eca52a8f29.1713234515.git.albanhuang@tencent.com>
In-Reply-To: <4e68f5557ad53b671ca8103e572163eca52a8f29.1713234515.git.albanhuang@tencent.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 16 Apr 2024 21:05:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ikW4o4g-yt5SnUFvKfLS6q1tGQ+3NTOfVPvwp7hZ3t2g@mail.gmail.com>
Message-ID: <CAJZ5v0ikW4o4g-yt5SnUFvKfLS6q1tGQ+3NTOfVPvwp7hZ3t2g@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] PNP: Add dev_is_pnp() macro
To: Guanbing Huang <albanhuang0@gmail.com>
Cc: gregkh@linuxfoundation.org, andriy.shevchenko@intel.com, 
	rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org, tony@atomide.com, 
	john.ogness@linutronix.de, yangyicong@hisilicon.com, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	lvjianmin@loongson.cn, albanhuang@tencent.com, tombinfan@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 5:16=E2=80=AFAM Guanbing Huang <albanhuang0@gmail.c=
om> wrote:
>
> From: Guanbing Huang <albanhuang@tencent.com>
>
> Add dev_is_pnp() macro to determine whether the device is a PNP device.
>
> Signed-off-by: Guanbing Huang <albanhuang@tencent.com>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Reviewed-by: Bing Fan <tombinfan@tencent.com>
> Tested-by: Linheng Du <dylanlhdu@tencent.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and please feel free to route it along with the rest of the series.

Thanks!

> ---
> v7 -> v8: delete a "Reviewed-by" tag, delete a "Reported-by" tag
> v6 -> v7: add a "Reviewed-by" tag and a "Reported-by" tag, fix build erro=
rs when CONFIG_PNP is not enabled
> v5 -> v6: fix the issue that the cover letter is not chained with the pat=
ch series
> v4 -> v5: change "pnp" in the commit message to uppercase
>
>  include/linux/pnp.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/linux/pnp.h b/include/linux/pnp.h
> index ddbe7c3ca4ce..82561242cda4 100644
> --- a/include/linux/pnp.h
> +++ b/include/linux/pnp.h
> @@ -469,6 +469,8 @@ int compare_pnp_id(struct pnp_id *pos, const char *id=
);
>  int pnp_register_driver(struct pnp_driver *drv);
>  void pnp_unregister_driver(struct pnp_driver *drv);
>
> +#define dev_is_pnp(d) ((d)->bus =3D=3D &pnp_bus_type)
> +
>  #else
>
>  /* device management */
> @@ -500,6 +502,8 @@ static inline int compare_pnp_id(struct pnp_id *pos, =
const char *id) { return -E
>  static inline int pnp_register_driver(struct pnp_driver *drv) { return -=
ENODEV; }
>  static inline void pnp_unregister_driver(struct pnp_driver *drv) { }
>
> +#define dev_is_pnp(d) false
> +
>  #endif /* CONFIG_PNP */
>
>  /**
> --

