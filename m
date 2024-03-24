Return-Path: <linux-kernel+bounces-112825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5178D887EB9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 20:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0608A1F21090
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 19:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B273ADF71;
	Sun, 24 Mar 2024 19:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kF4GX2qS"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C3417FE;
	Sun, 24 Mar 2024 19:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711308624; cv=none; b=irMa+0ZpLhyv0n1tqOjkCURphlrtgbSjUetSF3V7hxL1ivFckXNXwCMGs1QPXGV0uuQmCTZ42+lX6henJJLFq67U0FQPxqUbKWAx1iFs46F2E5r5+yH/L276t7K/IiCIBJKAiZl2hmAKZpM/GB0T/1JVXuX9FMjqLTJyL8FhdS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711308624; c=relaxed/simple;
	bh=9JVp+Rj+fbdr7YQZptepVTD5AWS2MAQ13njt1pYVYc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lkb0JvwVKlw7ICR+/M8UQMA5NUAdyKnnAyzGjPM/SQk3oQtexLAFV8i1z3SPbjywrMoDxgzRwhTxmCMTFpvoS052kuWrPbbx8lDvx5yQs8dUHYViPK5UYf835STjP5liqxu8S/4MA+p8WO7GpvYACve8bZOngKyObmZvesy/db0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kF4GX2qS; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56c01c2e124so1007081a12.0;
        Sun, 24 Mar 2024 12:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711308621; x=1711913421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rTChliJMZK8soNYxput2Hi8KO23ddICHEdCndF6BfU=;
        b=kF4GX2qSPm+JXwrK5muDe0iLVmAk2fctDHrL5wnpR3lL0Ptagk3cfkylosL+HNJIyL
         MsPVIs8q/l5GOmsn6A+5K0LU+/QZPiomcMXVM1baDJqpW3QIJGxm8hneTHwO7GWB90HD
         EdHc8nDQekuEaz/7MaFxYmQ7ZT2oZdXxy4tWiRkVAXtrkA2+FR2i0SrJ8CYG5LF9d3s9
         2YCuZbkaoVq6oCkr/nKYRn0RBYFmok+NvDuScgiXEhL7/fePJQlKiMsjaOuGhdLQJKm6
         EKD+s+OElVn5+Cox0WhqwsYA7wXtwFXiNdpAZQCK6SV58lu/rNmGA4yHP5MiiuUpmUpl
         2GwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711308621; x=1711913421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2rTChliJMZK8soNYxput2Hi8KO23ddICHEdCndF6BfU=;
        b=D8jCbQaWvkbyfaLj0WdynTLe5rDOvaQaXaZjSzCyMVtSEsnb68O7YfpCGx9Os7V13F
         wTnPk/W3SjDsOUwL0JccmnVGx3ILr0uvSiohO63r4fM+lrWtN857vkjJwnsq8dMrRac4
         XipbocX+fXg4sMN/hsFbVrhXQAKJNTNYa3xEcz0k2NRrPOkTAGIe22hosgbKTztz/nqZ
         +Eyvi/jR7+wlo0j+QyTVxul20qOxckzYUfIaJ9JCiuEVz/xkmmKkfOoj6ceoWwTsbWtI
         atwF2u92REmDR56AZQnzC16X6/zQ0dzWN7sdfiEiAqNf1xJP0S5P7o7MV43xa2Ia6sbQ
         d0Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXqDYVfk/4nZ8nSky9r6M90kNfFs8y5T/mucDp+5vbEZDKu93CzxWFWuR+E1cVF1KwAiKA/BT7ihhTNWfgFi5OrekDIps6E1QXKmZjjKOyWtQo3kfcIUcHOm9jnnQ/T7/baLMTbT0v5f5LY4+3R8hi3wkiGhVlsnB/os0OhSqKNOyBjhPvCUvqovotr8Fq1Sgkw+N+T+HK2DK1/0+dlSqPPDpBG6lPuhQ==
X-Gm-Message-State: AOJu0YzUjQ1J9QtUQP7v6ndfxu7CFtDC7jWIe+ZIYYnK6dcP08CISszD
	Ng1tXUPTjpdCOR64R2pmFR/Ie9lK6gw8lmQiyxJkUe4Kw7/vOxGkmazc3gSVt/9Zzb326CNv3OR
	9f5R+WA96xIyqa7ceYzJVn/ZGedM=
X-Google-Smtp-Source: AGHT+IHlvPHxHR/LChJhWp2xtw82rzCuvf5U6H2FoCrEMWhWpvhgGSK+T83OcsGp/6PAmbFrYP2Y5VCUu5FhTr+oDtQ=
X-Received: by 2002:a17:907:7d90:b0:a47:4fe1:cf99 with SMTP id
 oz16-20020a1709077d9000b00a474fe1cf99mr2112508ejc.21.1711308620634; Sun, 24
 Mar 2024 12:30:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324150107.976025-1-hpa@redhat.com> <20240324150107.976025-2-hpa@redhat.com>
In-Reply-To: <20240324150107.976025-2-hpa@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 24 Mar 2024 21:29:43 +0200
Message-ID: <CAHp75Ve5201KNdjvDZYq_unHTKp9wZXPWZXDgStP8y+XjtnWWg@mail.gmail.com>
Subject: Re: [PATCH v5 RESEND 1/6] platform: x86-android-tablets: other: Add
 swnode for Xiaomi pad2 indicator LED
To: Kate Hsuan <hpa@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	=?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 5:02=E2=80=AFPM Kate Hsuan <hpa@redhat.com> wrote:
>
> There is a KTD2026 LED controller to manage the indicator LED for Xiaomi
> pad2. The ACPI for it is not properly made so the kernel can't get
> a correct description of it.
>
> This work add a description for this RGB LED controller and also set a

adds
sets

> trigger to indicate the chaging event (bq27520-0-charging). When it is

charging

> charging, the indicator LED will be turn on.

turned

..

> +/* main fwnode for ktd2026 */
> +static const struct software_node ktd2026_node =3D {
> +       .name =3D "ktd2026"

Leave a comma, this is not a terminator.

> +};

When I asked about the name I relied on the fact that you have an idea
how it works. So, assuming my understanding is correct, this platform
may not have more than a single LED of this type. Dunno if we need a
comment about this.

..

> +static int __init xiaomi_mipad2_init(void)
> +{
> +       return software_node_register_node_group(ktd2026_node_group);
> +}
> +
> +static void xiaomi_mipad2_exit(void)

__exit ?

> +{
> +       software_node_unregister_node_group(ktd2026_node_group);
> +}

--=20
With Best Regards,
Andy Shevchenko

