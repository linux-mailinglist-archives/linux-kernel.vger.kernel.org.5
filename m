Return-Path: <linux-kernel+bounces-66590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24411855EBD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D556CB25E0B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E50969D1B;
	Thu, 15 Feb 2024 10:03:44 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6756D66B2D;
	Thu, 15 Feb 2024 10:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707991424; cv=none; b=rVz6Q4fXdIXkm1OcwgZ/Ai3UuNDetsBBkq8zxETz5foAhJP8yigYRHLiMcBBuT7rG/Ki0C0c0aCP1oN/yS70MubUe6XVQPJIMPWBfLU7/RvJyYs+DKifp5sqoG01wg9k2Nd+Y4Fl3k+MRU2yG+9ayUmTUECLVD4e82V/StlhH4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707991424; c=relaxed/simple;
	bh=EaqVCQTytUUnp0cY5Lae71OQGVm7hfmOJ+WTa4BEup4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5BPiLRUxp6bO+c/HNoh7Qr7xF/hMuBySY3/qJKAI36pLJt35xywLYOtEt1khPIGaUXMdcH5tK9/efmRgYCxcITzyqN6NTPJpmaRCEL/auAuLUmZlQxb5FwHxW8kWAsqtfvbxngSQzuftKuW9dQnFsFQHiGLmVFPaTd3Nb8sXoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-607cd210962so4639757b3.2;
        Thu, 15 Feb 2024 02:03:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707991421; x=1708596221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMdJoBMNZBFd8pg+WpG4O/WU/1nr/QAfHuLAcF5JuKQ=;
        b=Ej/afgobqgybIPoGUVRX1YEvrK2YiPxY5naq/mHo5Yb+TA+cf+5miYFz23TxCGZFwX
         gMh9gUshT33IxsZXe1wc/fiNDcTTGIg3JXAKEd6wh0ysP8qMcc3YABTwyak/C5Z8UUbA
         ffcl2Aft7+dZP6Mc86FxLjyKlAq8FGBNalOODrjai9bfWhHtWs/WxTEPaS5WW5t7FkXc
         XIbRBjXj+cd7rlIa2aVvSUERL5MgoN7PRc5zDkLauu2XfxCAexfsSwGsQ+b5coiPzA59
         69ZgjehSxQVFUxI80aklKrdvtLjmukl8ix0rRoR68SLPWaaSWLBV6jtBG6sgmTgv/D3z
         zfig==
X-Forwarded-Encrypted: i=1; AJvYcCVkWVLaCZRuoMNqXK1QhilPhy+3LqjFUcqt0tCvgrQuSMm7hEfzIUE8hQlMQhw5rlABqyv4DTMBrDyGCFe8+sYz7CluZvX7RvC1ZHh6
X-Gm-Message-State: AOJu0YzBqj6revFnFy3+xJ3MWWLShX9tyUTJVWhsUB88veTsxP2Fr74t
	lHsRRX4xxnBC9bEpsYOxZ8nXfhymqxi/uDCLKLvDW5He6vtzFA6ArWkDQmK/WLw=
X-Google-Smtp-Source: AGHT+IHlU6K1oxf6+nWMaFPYWn5ZVVvOKHnkYtt5tuCU0iidaiWHaDxueyhBE0TmItH/3rih9iDxXg==
X-Received: by 2002:a81:b3c4:0:b0:602:c1e2:c6ee with SMTP id r187-20020a81b3c4000000b00602c1e2c6eemr1069803ywh.44.1707991420721;
        Thu, 15 Feb 2024 02:03:40 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id j13-20020a81920d000000b00607ac837eb5sm182741ywg.13.2024.02.15.02.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 02:03:40 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc236729a2bso582168276.0;
        Thu, 15 Feb 2024 02:03:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXgCtEuniFnqwpXA/y3ledEVHCdQzt+n2lE878aEQQ/kP6bz82cC5dNAQ+1/ln7tMHTOBAPgMa8dVdUKc4xhuFqBrJ76qoEPH3PovGj
X-Received: by 2002:a25:d3c7:0:b0:dc6:d2b0:95cb with SMTP id
 e190-20020a25d3c7000000b00dc6d2b095cbmr1187929ybf.57.1707991420348; Thu, 15
 Feb 2024 02:03:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com> <20240212170423.2860895-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240212170423.2860895-4-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Feb 2024 11:03:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUWw-_dECEXrTt--AX400YZOhP7b+tBOD0bHYQmS0z=1g@mail.gmail.com>
Message-ID: <CAMuHMdUWw-_dECEXrTt--AX400YZOhP7b+tBOD0bHYQmS0z=1g@mail.gmail.com>
Subject: Re: [PATCH v2 03/15] auxdisplay: linedisp: Use unique number for id
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 6:04=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> The absence of decrementation of linedisp_id is incorrect in two ways,
> i.e. it may cause:
> - an ID exhaustion
> - (and if the above is addressed) a duplicate id number may be allocated
>   next time a device is added
>
> Replace above mentioned approach by using IDA framework.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/drivers/auxdisplay/line-display.h
> +++ b/drivers/auxdisplay/line-display.h
> @@ -14,6 +14,7 @@
>  /**
>   * struct linedisp - character line display private data structure
>   * @dev: the line display device
> + * @id: instance id of this display
>   * @timer: timer used to implement scrolling
>   * @update: function called to update the display
>   * @buf: pointer to the buffer for the string currently displayed
> @@ -25,6 +26,7 @@
>   */
>  struct linedisp {
>         struct device dev;
> +       unsigned int id;

Note that there is a hole on 64-bit platforms.
Hence I'd move id below, so the hole is at the end of the
structure, and might be filled by future changes.

>         struct timer_list timer;
>         void (*update)(struct linedisp *linedisp);
>         char *buf;

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

