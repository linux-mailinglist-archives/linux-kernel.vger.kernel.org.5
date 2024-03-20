Return-Path: <linux-kernel+bounces-109257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88608816DF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79EFDB22E72
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7676A35A;
	Wed, 20 Mar 2024 17:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMs3btg+"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35CF69DE4;
	Wed, 20 Mar 2024 17:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957348; cv=none; b=Xq/MCR7Ww1MtR1upzNb7D4QDGzBylYw1bqkzGeKTWvLfO0pXjAgBQp/siyYQpmU1eRkh7mxAruCkuo79OcJ9Wghj9bLVAbnlqDVAGGvqJx8N9Sl+PpcZ/UjBKMNSdMhyEdo0j/AonrFGcmGNjiITzmjVG7gPJfbI7EFkD1rpo6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957348; c=relaxed/simple;
	bh=THk8a8rK445xrwum+0GkyKoR1i2kDSt6VlDhas4kNYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=urkT/8TrwcluhbXa6M0SeSA88AdSR3ROHgfiYnWf1Z5sHBogWTUi0UUtmOcj3z1T/EYw1oQUhIJpvytY/aRL13YLjThevq9EkZ3NXOhcK3DjXn425xsD2PFcPhEnqjEz++EshG/OD+K+5Hx1MQFTQmbpVSJzNdqf0YYLhRHKr8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMs3btg+; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4d436ab8a36so41263e0c.0;
        Wed, 20 Mar 2024 10:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710957346; x=1711562146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxwbgNndHR1MpV8bu3gf7jikTtDYFr6so3dvh0vQDrc=;
        b=WMs3btg+eiA4lR9ve0DY+cqh/BXN4sJWp2Ice1IhSGXNAl+pRP2KN/u5hKdgr7cQu6
         ErVBUlG3eEfMhUylO6A2qkU8ZcIEXb6/v9zK+Ox/m/FBQaycp5FyMP9fgK8UkSxhVCG0
         1H+ylqmUnNHL3W4rhOwcAHi9mR3Ht8Zwip7i8KViZ95Di+FeYU7EhdL1gWBRKp93ovKz
         2ahsSAZkUPId366bEnpGrB4cUor+jl1d/KsHH4Sc4PjdgiBh+56FPo5Aiey3s51Ro7KZ
         6ub7C+JEVN6Sk2Xl2tI14mdu+gBh+auk/dMuoBqHMBqG6QkX+xCEtjrVS4pjEuN1jLaZ
         WdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710957346; x=1711562146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QxwbgNndHR1MpV8bu3gf7jikTtDYFr6so3dvh0vQDrc=;
        b=s/tdxxbtT1u8fsaoXAXHLFuFBjqtN0boi6unRklGh27ZJLpmypVsJCq5KBPZ3w32gZ
         msJO1LsbQsueYLpudMO8KJ0GX7B2USh4b8vOJOjbNy6PMEhWhmjntnE1vHnT/r/rq/Bh
         W0XwPD18eBHmSGqMlbKk5ELSAMugta3SjvqVKZEUqegjgUzEtWj/IGag26rMG5Nq0Vrr
         ZR5w12Dd1t3A3xHy3kXNgvr9qXkNcD68XgOe6WTCr0N4fSAbrPlQWp3i6S0khwSagya/
         JvwaQyVMq5Rdr9R9tm/AfM0ADV8kXidsy36cmPlpH97+165rBn73lBZlgGkxvp5mJ3M5
         03Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUBargrhiWTpw3MZl1oTdp8GK5yHhGSvE0abjlSwY/lA9st/suGTGSQiXi2h0tjj6p9BB7dnEt0e9IeOFXoQyYldwW6mwrCJx6K+CGOUYJZELLfMKkI0zsHLm2xTaaGM+aIqGGMmQ+M6r7YJOqV1mU=
X-Gm-Message-State: AOJu0YxIWng3FnyqwwQAKbO6z8CKI536WPy7PfeHBOvgaqKbYkGbFAEa
	MrMIrmKAG3VJYMmSLNQsE+IPSum7PJukO0fmKq4sbSgTGdowbLMumRPgbN9DUvSzx7mldoqqkSr
	qlhcPhixnQVGGO6YPWCyN8XGFMamgYoNxadM=
X-Google-Smtp-Source: AGHT+IFPDmRqOqlLVgrmja7MsWB7SVrrAaDnIVxcW2L0oBscBYnEjTP7y406YUD/jMnsg/Nv/yGzRjDO/VdvqpsSJqc=
X-Received: by 2002:a05:6122:448b:b0:4d3:cff6:79f0 with SMTP id
 cz11-20020a056122448b00b004d3cff679f0mr2606811vkb.4.1710957345767; Wed, 20
 Mar 2024 10:55:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bd027379713cbaafa21ffe9e848ebb7f475ca0e7.1710930542.git.geert+renesas@glider.be>
In-Reply-To: <bd027379713cbaafa21ffe9e848ebb7f475ca0e7.1710930542.git.geert+renesas@glider.be>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 20 Mar 2024 17:54:19 +0000
Message-ID: <CA+V-a8vOZPYeZDSNU30JAo2i9WSiBKxqywyjEO_=dUMFhg8YrA@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/renesas-ostm: Avoid reprobe after
 successful early probe
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Saravana Kannan <saravanak@google.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	=?UTF-8?B?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>, 
	Paul Cercueil <paul@crapouillou.net>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 10:40=E2=80=AFAM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> The Renesas OS Timer (OSTM) driver contains two probe points, of which
> only one should complete:
>   1. Early probe, using TIMER_OF_DECLARE(), to provide the sole
>      clocksource on (arm32) RZ/A1 and RZ/A2 SoCs,
>   2. Normal probe, using a platform driver, to provide additional timers
>      on (arm64 + riscv) RZ/G2L and similar SoCs.
>
> The latter is needed because using OSTM on RZ/G2L requires manipulation
> of its reset signal, which is not yet available at the time of early
> probe, causing early probe to fail with -EPROBE_DEFER.  It is only
> enabled when building a kernel with support for the RZ/G2L family, so it
> does not impact RZ/A1 and RZ/A2.  Hence only one probe method can
> complete on all affected systems.
>
> As relying on the order of initialization of subsystems inside the
> kernel is fragile, set the DT node's OF_POPULATED flag after a succesful
> early probe.  This makes sure the platform driver's probe is never
> called after a successful early probe.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Tested on RZ/A2 (after force-enabling the platform driver probe).
> Regression-tested on RZ/Five (member of the RZ/G2L family).
>
> In between commit 4f41fe386a94639c ("clocksource/drivers/timer-probe:
> Avoid creating dead devices") and its revert 4479730e9263befb (both in
> v5.7), the clocksource core took care of this.  Other subsystems[1]
> still handle this, either minimally (by just setting OF_POPULATED), or
> fully (by also clearing OF_POPULATED again in case of probe failure).
>
> Note that despite the revert in the clocksource core, several
> clocksource drivers[2] still clear the OF_POPULATED flag manually, to
> force probing the same device using both TIMER_OF_DECLARE() and standard
> platform device probing (the latter may be done in a different driver).
>
> [1] See of_clk_init(), of_gpiochip_scan_gpios(), of_irq_init().
> [2] drivers/clocksource/ingenic-sysost.c
>     drivers/clocksource/ingenic-timer.c
>     drivers/clocksource/timer-versatile.c
> ---
>  drivers/clocksource/renesas-ostm.c | 1 +
>  1 file changed, 1 insertion(+)
>
Reviwed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/clocksource/renesas-ostm.c b/drivers/clocksource/ren=
esas-ostm.c
> index 8da972dc171365bc..37db7e23a4d29135 100644
> --- a/drivers/clocksource/renesas-ostm.c
> +++ b/drivers/clocksource/renesas-ostm.c
> @@ -210,6 +210,7 @@ static int __init ostm_init(struct device_node *np)
>                 pr_info("%pOF: used for clock events\n", np);
>         }
>
> +       of_node_set_flag(np, OF_POPULATED);
>         return 0;
>
>  err_cleanup:
> --
> 2.34.1
>
>

