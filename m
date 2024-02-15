Return-Path: <linux-kernel+bounces-66587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 208CC855EAE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2E51F2145A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0A4664C1;
	Thu, 15 Feb 2024 10:03:26 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A043265E05;
	Thu, 15 Feb 2024 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707991405; cv=none; b=W85i9lXNSiMJ7wElI6aJyOjhd0cwjlXHTp+9xkyTqLZ/7mvLcfBhuIkCdSlMxWZTkXF6m1fyiVqFkHiZGEVppDhCETr+Az3MgbDK1R4QUt4Cc4YhqK1+DYW+wKE7YWvUebmMguk5BThPOeCB3R+kFN9PD42axSnguUdNdgsQQCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707991405; c=relaxed/simple;
	bh=HDkHFmuyAIbY1g1cu9TL5SLYxGYEIyAyUbVQUE8TkXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DkmMXFcPkfuQ4KDAzcMcpeGhCv2IYXkXvjsMhm03kJ+HzcQmoxevTIERUlWmf/0KIBqI0ENB+e5KOk59wrtrO2frsWWeMXAAqOma7go5fVQYAgOaKqjHv19kiBxTLT1nH3OIayQuTO/mQDHOH3BvgLz5KHRGYdYHzRsdy612KgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6078350e130so6591597b3.0;
        Thu, 15 Feb 2024 02:03:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707991402; x=1708596202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUNQa6tI/+0+nqwNVC8tBBTyjfXUFwBtTDQfBepwcIw=;
        b=rKKMvo9dl/fCVtyEBFKsD4PIePu/2HezE7mkcumwpwWgrbflf0SRm78/NqcMHlCYSE
         2gqECuEQFNGaWzeINt7Tz+zDgynujx+Tsgwj8vHtCDjZ1GNU9Hn2vksVWlNfjrdRRrzG
         759tqx5Lpo08r5jtBKZX6Aj1N3vaGlze+ybNKMmDqLndJJNOe1a7qaOhVwe+JR4+7h/Y
         AfM/ryvL/ZRHha8CB9HuFhHl1YLvoci9wPQFQfkafUGLiUKUPCZnjAioM0u+vONbMdSr
         vXkXz8FFSUXRLj1TD1iQml4w3CJbvpfypQ38w6oiev/x6WIV6sqsYKNOP7ci1O/bk7Yd
         2nKA==
X-Forwarded-Encrypted: i=1; AJvYcCUwjsmxV+ETGxSyzWGNT802iSPvwEBoXd+CtsteqSHzNQTQhW582kKwpneNbMDTqxzyH13N5LJ/sd9Ea/AhHSR2JzNu55SJTdiT2RVz
X-Gm-Message-State: AOJu0YxWcLcwcBAK1xCxt3dSEDWTQqZ7BEJFZPzVr44V3bfPvStQZNxt
	SI1T7lfOEjfirnaaBS3buGDtReawB1O9qrIhUFeB4C2SukRUo2bRjo+E1e0jUnY=
X-Google-Smtp-Source: AGHT+IFO24RCBrIuN9Fi7DftVU3ks0f8GOuNzYq4/YAAq2NQJ1YEPZUjHvqHwOA97G1DCI0JWL/jUg==
X-Received: by 2002:a81:9f0d:0:b0:607:8edd:b5f7 with SMTP id s13-20020a819f0d000000b006078eddb5f7mr895682ywn.49.1707991401755;
        Thu, 15 Feb 2024 02:03:21 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id j5-20020a0df905000000b0060493d50392sm177245ywf.103.2024.02.15.02.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 02:03:21 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcd94fb9e4dso559202276.2;
        Thu, 15 Feb 2024 02:03:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWTSmGorQAEdutzZ7SHDt/9udqADusNmNsidf/d+CRtZ879WvKpA+fR6TXYrguVdgPTXvLhiBsXu1Df/ZRNdhsS6NYljFpQoBShH4Oy
X-Received: by 2002:a05:6902:250a:b0:dbe:9f4a:6bb0 with SMTP id
 dt10-20020a056902250a00b00dbe9f4a6bb0mr1180489ybb.56.1707991401026; Thu, 15
 Feb 2024 02:03:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com> <20240212170423.2860895-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240212170423.2860895-2-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Feb 2024 11:03:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWM5ainsMZdooUFygccWL6nK9tEXGxuYQ3kTc2MLT3TBA@mail.gmail.com>
Message-ID: <CAMuHMdWM5ainsMZdooUFygccWL6nK9tEXGxuYQ3kTc2MLT3TBA@mail.gmail.com>
Subject: Re: [PATCH v2 01/15] auxdisplay: img-ascii-lcd: Make container_of()
 no-op for struct linedisp
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 6:04=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Move embedded struct linedisp member to make container_of() no-op.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

