Return-Path: <linux-kernel+bounces-82006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E156867DA5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3BE41F25BED
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02FC132C2F;
	Mon, 26 Feb 2024 16:58:44 +0000 (UTC)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AA112CD83;
	Mon, 26 Feb 2024 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966724; cv=none; b=fJs7+T2xFFn+qa056jt36jOCZu3olH9mRLmQSqMmmZxFtXL1ZBMJR6XHICly1fq+8tvI9w7/4RX9aQud4yk9oO5L11kLw97S3uWNnjgdO1s/g8Z4MyGQNjW7Ikf2iGSrD3rcVHtwr0WPRpcTt5hh9my7BbzZ2joDlED5mOYaDu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966724; c=relaxed/simple;
	bh=LV1lgUElkVfzNOqis9pVzjpqJoYJQJQBjKfDVfkceJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCv95nA80od+2JykVwol5bMwGx8NyTblWaW1tawG/uQ0pzSag++vVwebMGLUAUCjMt9hzd4/ZckF9QSmRAUNs/lxBerY9XbaXW9rnhy85P+kH4eEHjerxU1oa5wLvpanjiQFjMhFHWNEVsWUnwd4BKGL7E2uu16j9d9w1oRbbJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcdb210cb6aso3682106276.2;
        Mon, 26 Feb 2024 08:58:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708966721; x=1709571521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4qKUYUF0RxYNDdA27YqJy76NZTg9yYGjFyTyqzOPJg=;
        b=VHg+wdDUYK+rayYVabacVZSfGQpiVtULTk5SKozRiYOD/eTkGkRsDIOh9eF/pGg/rZ
         5fBeU7Et6XR/zl12N5z6kLaCM8ncgct7OiKRNF/lSEzXkQ9MO5hXRduF3H5eI1h1TIF5
         WbhHLBQ5dXlWUtJwjAcuNFoSu3ekmoBd+T/1I59Ay/cqd15LgTQhhmRRGf7aZrapaSTS
         DkAqHypnXwNssJWTWkMFDtlj3iuoORPm5bqlfOz9+FXxZHsBUuRrh5rwfvzm4SLkp7QC
         n0j79Y/FXW5eeNf8lHIZXAWz6P8gu6rbVK8myliT/6pDp/sdyQH53lHypNtqLr9Id5jZ
         o6jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUVIul+eHs1EW5ryXyXXLa+Av8el2I2dwQYiUqjtDU0pI1wOl5TTweHOFMJe4F9vDuaUWWYo2PAoyUwXBn4LOiPH3AyVz8ItGCUamoOFdVLAgWklK7oZvcqxSdfOpHnAQE5yyiExAPEQ==
X-Gm-Message-State: AOJu0YwRQGoZgcNp+NQl1U5K6y1JpYEeF4dHIhAMQNFJlVr1gs1wJ9KG
	+oyuWdVSQwFI8Y43ZrG8gp/yaEprUDYp6MS/JICoMktuYtWtyxKVEhK2ra6c6Uo=
X-Google-Smtp-Source: AGHT+IFK8Zm7a4KvkSxxt6fsiofJN1Bn3s6+e5z5rAsUhJ+LRp0VHWLLnhkWeWr14Oq0BQBgcsAfRw==
X-Received: by 2002:a25:84c6:0:b0:dcc:f2a4:153e with SMTP id x6-20020a2584c6000000b00dccf2a4153emr4745621ybm.46.1708966721409;
        Mon, 26 Feb 2024 08:58:41 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id w18-20020a25c712000000b00dc6f4c19d93sm1026752ybe.7.2024.02.26.08.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 08:58:41 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcdb210cb6aso3682081276.2;
        Mon, 26 Feb 2024 08:58:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVW7cy1WRAGuMRpmG7Feo5z0YLimpUg5yRbMEpCJrN9Y0bZi4chGGQABa0RrkEP79GwAJAeXdCupP5zb2g00gYxj07G9cmWyeFELUxH43UItZZ9AgI2MP9OlV6/UkV0cP9NsRGmNirX0g==
X-Received: by 2002:a25:820e:0:b0:dcc:273e:1613 with SMTP id
 q14-20020a25820e000000b00dcc273e1613mr5147543ybk.40.1708966720897; Mon, 26
 Feb 2024 08:58:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com>
 <20240219170337.2161754-10-andriy.shevchenko@linux.intel.com>
 <CAMuHMdWpepH0P8g9dPfq1rsZRJsvOnoZ7VnjqTL9nkSGtKFpYQ@mail.gmail.com> <Zdy5lDOBrQ9XFCpm@smile.fi.intel.com>
In-Reply-To: <Zdy5lDOBrQ9XFCpm@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Feb 2024 17:58:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWoFQfMV90kwy8rxqVt+1eGvh=F7GqtJri5BSydWDiiMQ@mail.gmail.com>
Message-ID: <CAMuHMdWoFQfMV90kwy8rxqVt+1eGvh=F7GqtJri5BSydWDiiMQ@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] auxdisplay: Add driver for MAX695x 7-segment LED controllers
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Mon, Feb 26, 2024 at 5:17=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Feb 26, 2024 at 05:01:46PM +0100, Geert Uytterhoeven wrote:
> > On Mon, Feb 19, 2024 at 6:03=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > Add initial driver for the MAX6958 and MAX6959 7-segment LED
> > > controllers.
>
> > LGTM, so
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Thanks, but see below.
>
> ...
>
> > > +       u8 buf[4];
> > > +
> > > +       /* Map segments according to datasheet */
> > > +       buf[0] =3D bitrev8(map_to_seg7(&map->map.seg7, *s++)) >> 1;
> > > +       buf[1] =3D bitrev8(map_to_seg7(&map->map.seg7, *s++)) >> 1;
> > > +       buf[2] =3D bitrev8(map_to_seg7(&map->map.seg7, *s++)) >> 1;
> > > +       buf[3] =3D bitrev8(map_to_seg7(&map->map.seg7, *s++)) >> 1;
> >
> > for (unsigned int i =3D 0; i < linedisp->num_chars; i++) { ... }
> >
> > > +
> > > +       regmap_bulk_write(priv->regmap, REG_DIGIT(0), buf, ARRAY_SIZE=
(buf));
> >
> > linedisp->num_chars
>
> Maybe, but then we probably want to synchronize the 4 there and here as w=
e
> can't have VLA on stack.

You can still keep the maximum buf[4], so no VLA needed?

>
> > > +}
>
> ...
>
> > > +       ret =3D linedisp_register(&priv->linedisp, dev, 4, &max6959_l=
inedisp_ops);
> >
> > + device_property_read_u32(dev, "display-width-chars", ...) handling.
>
> Not sure it should be part of this series.

Fair enough, so please go ahead without.

Even "display-width-chars" might not cover all cases, as a board
may use any subset of the 4 DIGn signals, even in any order...

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

