Return-Path: <linux-kernel+bounces-104311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0830C87CC0E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C413B220AB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBAF1B960;
	Fri, 15 Mar 2024 11:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ub2SsU6J"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6814E1B963;
	Fri, 15 Mar 2024 11:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710501188; cv=none; b=P3qAEBSwTCvhYRC/E6RxsoaT1bTpxNSyBo1OCnI+pVVQJE37LUXQ+fSWVYxdlfLUS0KEIanz9F9aJFoUvTQ+31ai4YT+vqE+9bKLusY/RnpdmA80U9ahfyMBnnGxN/MSTwWAKNcyRIhcGUkGONqSSzoEv0bLL0xVNkCuD1v9ef0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710501188; c=relaxed/simple;
	bh=aoiaaCldCkQe6ArkUBuQAWpVY4+9OSHIk9fRAPZ2LvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D7ld8a/xIdTrpoIlMi4wCgAzBxofIJEvp+NvDsJnAqjxjQMwru6y8/pDi2Mrv9GvOYcAHCp9Y6yx/hv2t+cS7QAoPn8/6mdNekseisD/l4gnf2zMzprxZ8L5sKPa0NdalCU7FBwFxC9IofJO5l12bk8r2bPLkCLCh33DthZaq/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ub2SsU6J; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a44ad785a44so224656366b.3;
        Fri, 15 Mar 2024 04:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710501185; x=1711105985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoiaaCldCkQe6ArkUBuQAWpVY4+9OSHIk9fRAPZ2LvE=;
        b=Ub2SsU6JGYpRiSVtWiGJp+MYbPhYovxas3maQU0qse3txcr6TIQrhhB83+sSRjePmy
         DwePwLQV6ISLHyrNsy4h747IWu/oD+AVk9K97DFOB5qMvaH0V8j5XJPv9YMm1mmqn0WU
         do5hxyQFY3cFxe2cWpgXPHIidjnSx2WGvlXvTXQF2bIhshIBcjvYv7wzna3GaJ8E5lFG
         y0SklAle36VfA0Y0ShVqZb/+9SPiYQOVs6HO9++x0ERZ8G51OJbZNU15t0fdGUESYhZy
         La6eSYXSACM8Ukn6qytFQeuk/TOwevBBH0ZxLzpQF/MvNkhYs4D0Aqda2BA4aTZdG6sG
         tcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710501185; x=1711105985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aoiaaCldCkQe6ArkUBuQAWpVY4+9OSHIk9fRAPZ2LvE=;
        b=b9NPWNFHVobnXLWesiVsb37WWTIwhqKM9s2MYm8QZM+/Dr8U+WV4w5JANA0+/AiTK5
         lawlJCCEDMfF2u9wyiCgXY4x960Iyh7RwnMkgVqQNWwIb8X2d+yL4VgEQthzW+fJ/ukn
         /Q7sWjgn8EOktFHULrD/ZWjFceD3fue8YJaPGJOVEZao9u+REMzyaEdU0xDOZ4RmmkOs
         H0QuezZFfwqw2QIuV9/C785ySZ1bt9Y2fmo46O2TMs7/b4Q/TTdJ4fflYJZfGI2AqMGC
         f9DHI34sjYKFsme1/XSlrPBbl6NWVfhmWiidX6391wbbn6g0CVZYiY6HImDVv1xHNisb
         M8NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrGDKvDu7ARm1vow3lQhkXBtg0dPtoLZ3UTF50v8ONJ0Gi+qxEcoRhIKBQuKdecavNgjjuinzGEFIf7B17HGwp8HHGuoMpnBS33+lIn2FuHCxg88t8trcTYWV+OUikSiI53vv0zhwfcQ==
X-Gm-Message-State: AOJu0YyAGx37MBWZF+GTc4aB4MXBopGgZD9swV/vY0Zy9oRvMyr7UAxA
	wElHCP0xqrfh4JVhq3y3zAQeXa/aFvw4kAZTmzz+NXztfjw2QO04b9vAg3TowN1Gg4p97mbrOQQ
	ed/Di3FasG/rJFRor/KAvHI/fCI8=
X-Google-Smtp-Source: AGHT+IE7S3OGcyT662Ghnj80+ksEfbUvqCQI8MWmyUPuSlp67PH14ltaV/piA26GIWVAjOmR3Vky0+8pELW23z/ZUbI=
X-Received: by 2002:a17:906:6947:b0:a46:1e16:317c with SMTP id
 c7-20020a170906694700b00a461e16317cmr2119247ejs.55.1710501184551; Fri, 15 Mar
 2024 04:13:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315011015.3106272-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240315011015.3106272-1-peng.fan@oss.nxp.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 15 Mar 2024 13:12:27 +0200
Message-ID: <CAHp75Vf42b8uo+7c+WEQj5Kj8LRf3PxXeEpwEJScyw-PMeYn9A@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: use dev_err when gpiod_configure_flags failed
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 3:02=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Using dev_err to show error message will make life easier.

dev_err()

an error

..

It's unclear what the use case is and how this does make life easier.
We need to know more!

--=20
With Best Regards,
Andy Shevchenko

