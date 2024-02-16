Return-Path: <linux-kernel+bounces-68093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D70158575EA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4F7283358
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AF914003;
	Fri, 16 Feb 2024 06:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAmT4VjZ"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D9510979;
	Fri, 16 Feb 2024 06:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708064378; cv=none; b=p/vasPIkjGcCvTkm/zRc4iXynM3vywwTZTVTEuTakp8CZIjcmp8VNZ2mi6DjDbgsYSF5juWz3g6WIlH1zNQvFT9W25MqA99CuoMuIA7CtjOxKsyPEg8PqnEmfEjUMiVx1zpDqoPE3D+5ps1aH5gJ95T2eF4UoY9PLMZIsviqNkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708064378; c=relaxed/simple;
	bh=twDT7pQukCriu5b7GZvI8MsCbZs40QK0iZ/i8KWlgCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQHEnhiX8jhGLCpbXRs/n49Fzq7pxiPnJKYXmf5cI3+L8cqmVfgIFs+m0JH/YcHdOCcOrccGXl+Ad/KbilEBPu3Q/lpBoBEzRvTYEX63V2kbrfuuqvamGRLmohjclMIuGyTs82DmjyXvnJpryS1XmUpNJtA3EICmGkwBImLtcU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAmT4VjZ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3dbc8426f3so39189066b.1;
        Thu, 15 Feb 2024 22:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708064375; x=1708669175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twDT7pQukCriu5b7GZvI8MsCbZs40QK0iZ/i8KWlgCI=;
        b=HAmT4VjZAlyDbs6F6VN2odRNpKU47eGnCfYH1gPP74wj0HZo7LcEKe+fpE31AHSrPk
         q02BjmfoR/ro8cERH+W+yndE+xTFnoT0VHEIVmAM944vbS4YW28Zyq3yewEdvVcCqPwA
         4TFCL5hlHv8bP7s6KPGl+cy+1J07dslQxD4jTfN1IZFvCyU7SYH2GbJqtcxetLECPFHT
         NK15BBRX/CB+M/LJTO3gqoyXtrejC2TpHwb5Dw4A1BFWRnmFWbaLREqz591RrxXxHkza
         xRMO9ulNi0b0hRFZJLi/lqVSUfg2D1kbE8ar4pNN1g7mMI12klAb2pvlWE19Fh2trzbi
         kiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708064375; x=1708669175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twDT7pQukCriu5b7GZvI8MsCbZs40QK0iZ/i8KWlgCI=;
        b=SzqR4zfOhBiMvZB1ZbE+mmXVmq7ATUztlHM+vZ3uyATgm4dPZ39IHTaLdWhrC0U5jK
         NKAZsxGx6dfhWHYV7QDeanI8NLnnUdiNkz3G/vNaAguB8x5R7OAL/90wxuGqdXFvhTCd
         LVjfqQt+kg3JcwzHWJWvqLkcngXvGziDZsvyugY7XGxMZVU9CQBNxETiG6BTKeMxLUEg
         +ZQMOirdoJo0DU3FlDhAkYcjqRX9wW1DwjXG+buDV8gSJ+fl+7XGB69s608vYloTTO93
         43PvMBKXfrcxF6WnbEpFrinVUU3LDr2KhB792Dc1F0poTAysmIpo1sr4ZSkAtS63E1Gd
         qIDA==
X-Forwarded-Encrypted: i=1; AJvYcCX0XW8KxH2N5HfgaDfn4TT13rsYW89ga945d6ELW+jCDabcK8rU6hOGe8kPlTPU1KI4gt3nu8p6JFlCFlPQaPq5SG/Dc/wi2OVNaJ+1DIyS9tbpOltSzFVd4id8vpNSuGEB3gSmZLfr
X-Gm-Message-State: AOJu0YzxQCzTFpDbNfE8fdHcbIb+MfUxLFtG0MfRPUoL/FA7e4sBY1uy
	SYNmNCgQ15dFlZZXScEIXQWyHdoptdWAC0iMghIJ+e5p1jUy/GTdFn6MG9h1EqQeTjvHIMo0/MB
	pDyR9OzoUu69qUwByTON+Dqj3D/E=
X-Google-Smtp-Source: AGHT+IG3UH321Wj+62YjK+x82KH4WpkZBya/9VqrCbb8iOi2xWuIQnhYdvT8EKc9ZPnqf6YyWJaQstUaRwJ/OfHfStI=
X-Received: by 2002:a17:906:8404:b0:a3c:f7c9:5ba with SMTP id
 n4-20020a170906840400b00a3cf7c905bamr2441015ejx.10.1708064375165; Thu, 15 Feb
 2024 22:19:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <piosq44nxwlfeutperrk6d23bx564qlbfirc5xlbouyrunf24r@u6qsgqp47fz6> <tencent_B08771190400813E0CC41E36A3F540AACA07@qq.com>
In-Reply-To: <tencent_B08771190400813E0CC41E36A3F540AACA07@qq.com>
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Fri, 16 Feb 2024 07:19:23 +0100
Message-ID: <CAKXUXMy8WZwAqrARe-6nNhtvjSiosDD3X5aPZPfn7GXtkG8B8w@mail.gmail.com>
Subject: Re: [PATCH] Fixed case issue with 'fault-injection' in documentation
To: "Ran.Park" <ranpark@foxmail.com>
Cc: ricardo@marliere.net, akinobu.mita@gmail.com, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 6:29=E2=80=AFAM Ran.Park <ranpark@foxmail.com> wrot=
e:
>
> Thank you for your reply. I'm sorry that I noticed this problem
> while browsing the document. I have not seen any report about this proble=
m
> on lore.kernel.org or other places. Should I mention the situation elsewh=
ere
> and then resend the patch to mention and fix the problem.
>

Ran, in the future: please do not remove the context when you reply to
somebody's email.

In this case, I wanted to help you to understand what Ricardo was
asking, but his original response was not in your email. So, I copy
and pasted it now---but that is not how it is supposed to be for
someone replying to your email.

On Wed, Feb 14, 2024 at 2:21=E2=80=AFPM Ricardo B. Marliere
<ricardo@marliere.net> wrote:
>
> Hi Ran,
>
> On 14 Feb 19:40, Ran.Park wrote:
> > In the 'fault-injection' subdirectory, the first letter F
> > is capitalized, whereas in index.rst f is lowercase, but in
> > index.rst all other elements in the same column are capitalized.
>
> Does this fix any error or build warning? If so, it should be mentioned.
>

Ricardo suggests that:

- you run 'make htmldocs' before applying the patch and check for the
existing warnings.

- you run 'make cleandocs' and 'make htmldocs' after applying the
patch and check for the existing warnings.

Did any warning disappear or appear due to your patch? Were you
motivated by a specific warning you observed during the build and you
addressing that?

So, for starters: did you already try 'make htmldocs' with your patch
applied? What did you observe?


Lukas

