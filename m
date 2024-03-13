Return-Path: <linux-kernel+bounces-102114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2566587AE86
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20C728450F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D31F69DE4;
	Wed, 13 Mar 2024 16:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="LWCm+FQ5"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F5B69D0E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 16:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349010; cv=none; b=fHelfgK6rE0xNLnVW96A11gOj689wdqsp0d13B6EaU3ohsAVrTN542Z/WZVHIspw4fvMnxEQ4CzvYbxjyPoLE2SWonVjSuszMvWs8iTbPn7VQTIC71GtU4k/iMXXMAH1x0UZdCPno7kHYm8Mc34xEj5Dxk9W6jvDJ+Z7rqqKt3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349010; c=relaxed/simple;
	bh=SCfQxrsUZIhLcwW+avzsl826YgC0trhjqUf7BM9DzM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ji6oPsn+mfN9GMCZoC1pNV0c+CYSaXsmQxWUBVFC3kMbTmocQzkfdoNjZUkS7OWvGmCa/MmQLzsns5aswqDfoktVwdKtft5IvpxLC/dP2HILjQ/ZMN+UkcUp1IXPm68iqjpPsOks1fJBPhZpEGjV/+hgsWPRoeOCsF1kAkK2p3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=LWCm+FQ5; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a466a256726so26625866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1710349007; x=1710953807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnASLn79U4WGz9JzJ9spFueWfH+H8v408Rks+XnoEx0=;
        b=LWCm+FQ57DoufCEngHFU/lhWrqeJe5utV6YVfOvIIcHAFtP4W0b27dJ7wyR5PuXIYY
         4bxfEpn6NiwqIcpNbH3kzDeK7hbThAY+364YaafaivkiWRTNP+CPKHVIlcFAHLpYTj5O
         s28UjWORyl2L3olUFyzE+3jRoB22i1IMJphA9ZMSTbI+53NXJUh9Od0oUZOjFvf86yvd
         ZeRrkjr2oYh6ZAo4nlYJuYTusYeCPe3lqprhk5JZVjFXaWvpm2onKF4VhO9tz4COGavO
         md9nN9V11b88Ls+e8EWbq4VwBhKIUaDlr84KUkdvNp5TmFKcXVBxQJ8MsowEkvSBY+OV
         9KNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710349007; x=1710953807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TnASLn79U4WGz9JzJ9spFueWfH+H8v408Rks+XnoEx0=;
        b=ITfZHoKxH4dgDymyYLTeMnvgop7VGjM1JKqIlN3kH26jvUEtH5jE2XoQ3s7M/6b+nj
         +srh8jfyfT10iLzuPQ4krhGUiBpaCV5GpnlwUlABVTEXhr+NPsoSItSMmVGjdPb25omF
         iBl97kPNgEFkR0F6ECpzpesEiqMaBp4uCSJXKs7Xh/Pq/35GsiZZN1WZ63l7fR2/7uQ0
         UjJMM8y3ZUf0zQc3iA3XGKxkxN4nVkapxkois4NMQQExbJ4UrStB1MN0ZhU8cI1owgJm
         2zPmbdkpORE09OmyF2YN5xDqTnwA72PSAX6JElRmWqfSZxTOM62a5e9C0/RgYZJdXe8J
         UY6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3UtaL/dDN7AzRYlzKR52/Ugt442mtgLpununYLNDlb28amSKgn+ViKbz58r4dh+wDNJHp3t9ozYQ7W1IH0t9NH2fRCcNH73CEetki
X-Gm-Message-State: AOJu0YybEreUiluK4rwKe2p07/RWNns9reSV359oSpCKuBj7+J+7GSlT
	5hhyzplVZZekqx8dZrETG9nlJKyN/rj0ZdI4iePZmxPxeR9YSd9VCEzGRt3uToTpIlqQ2xzEs4S
	PxK/u5KUUJBQbLwFmj261eHwaeSken+TFLG1vEA==
X-Google-Smtp-Source: AGHT+IGAWCdriqwQt4fquJ5lVPudGaCw84ttjE5f4cmiXdhI+Vq9G5yeSx/uppOW3n2GUCQumVwuspfbuTrqt1TjipA=
X-Received: by 2002:a17:906:5945:b0:a45:7936:d09e with SMTP id
 g5-20020a170906594500b00a457936d09emr2761316ejr.19.1710349007188; Wed, 13 Mar
 2024 09:56:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312193306.1814593-1-samuel.holland@sifive.com>
In-Reply-To: <20240312193306.1814593-1-samuel.holland@sifive.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Wed, 13 Mar 2024 22:26:34 +0530
Message-ID: <CAK9=C2Vsq0iN5FW=zC7+2GHe115TPJOEEPcDCLs_40yBGpbVdw@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/timer-riscv: Drop extra CSR write
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 1:03=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> On riscv32, the time comparator value is split across two CSRs. We write
> both when stopping the timer, but realistically the time is just as
> unlikely to reach 0xffffffff00000000 as 0xffffffffffffffff, so there is
> no need to write the low CSR.

Even though unlikely, there is still a theoretical possibility of
counter reaching value 0xffffffff00000000.

The good thing about value 0xffffffffffffffff is that the counter will
immediately wrap around after reaching it.

Regards,
Anup


>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>  drivers/clocksource/timer-riscv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/time=
r-riscv.c
> index e66dcbd66566..eaaf01f3c34b 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -35,9 +35,10 @@ static bool riscv_timer_cannot_wake_cpu;
>  static void riscv_clock_event_stop(void)
>  {
>         if (static_branch_likely(&riscv_sstc_available)) {
> -               csr_write(CSR_STIMECMP, ULONG_MAX);
>                 if (IS_ENABLED(CONFIG_32BIT))
>                         csr_write(CSR_STIMECMPH, ULONG_MAX);
> +               else
> +                       csr_write(CSR_STIMECMP, ULONG_MAX);
>         } else {
>                 sbi_set_timer(U64_MAX);
>         }
> --
> 2.43.1
>
>

