Return-Path: <linux-kernel+bounces-167213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 598DF8BA5C2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 05:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740CB1C224EE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 03:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8CB1F5E4;
	Fri,  3 May 2024 03:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIbx/Heq"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABA757C97;
	Fri,  3 May 2024 03:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714707483; cv=none; b=NjUYjHgU+qde3jIaJ8SRiZU6PvVpfN4tuXAWpS5pQJcEX4HyYsIMyQPUqiAxKQTdAs6XdgeiMUpcip5hE4n+d5d3YXvA0mQkOZ3DhpJw0jAjqs2Uo1B1/QslYmzlrj8hxcYV1RYZuQlpqrfaSlBJubEZGppz/WjJKb5p5mPxKhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714707483; c=relaxed/simple;
	bh=qx09Xw6lAj/yy0Yo18iddcFGzuADm9dJZALEXyGVlc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDCuMBTB63679anTrK9znIlQUSKOUV64qVz1qULaZXKyYfGgQ5mvJ8PSr4erTD9AA76V+S2+6xLLOMyzLt33yMbFz6NbE+ALnDJB0AczDjXUoq2+Tdd8Nk4IDuajngcgftqSDsBzAyf1MZCK3feoo1ztcRV3gbFhOkn4mEjpdXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIbx/Heq; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51f036e9f4dso1900417e87.3;
        Thu, 02 May 2024 20:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714707480; x=1715312280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dmk//KTYeIM79p+Jrab69pCmxQN5kiKJMYJHLJ+sJXw=;
        b=nIbx/Heql9oBa5Ox+kfzTqEO5SqE5HoLog1TkC4b2Ha9apFt6FJ0REdf7UQ7tc0s3O
         sSKAIJ2UNuFPL3BGken9kN5i1yS1pMvmAlwlzGEzgzFDUiEp5ndiKR/Mbwm7+0X5y5VZ
         1r1zWxiH6+EbCMyG5wA32k8J32a4/oSXm2n0UoV2JwipcGWrOi5kzgMXsYhMi2W2a5i6
         hj+rAw92aVZOMNrzuFtAW0uDbpnQBx7Pe2bYVTSfq3cTxWmHxoBlBXOAX2iI0sl2QhmR
         BrlD/sPElZva1P/W7aKa+03SaYt6BFiRBY34mNzo3I4q86tEAtHYMO+V+5O+gPDsxqYQ
         ebXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714707480; x=1715312280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dmk//KTYeIM79p+Jrab69pCmxQN5kiKJMYJHLJ+sJXw=;
        b=mYKXYoC98DG2mHP7DqEPULAQ4Cbspy/ewOu/Q8obU3ycyghGVPYXrdjKuZU8wQ/D+k
         iajpwGOL2mHnMStfxk+j8AZ0rGvPJGaL6hwl8RfM8zru33PWrgvDb/xdRwt2BOqvqqCR
         w1Bo/PvGuUJaDeOSZAYTFatOh8xjyoLpdCtkG/eYVPZa0pSwZpjjKl4gP+Ou39oyN8Cj
         UUCSEf/Obauzh+viO+wtHN6bKjYTnrrzSRVbYwj0uJ1pf30IWivgCneL4eG/K3GU9a8C
         n7Cg5QRPfFOkGzT6pfyRV5iDZKI+es/Na9PftEYMUoDCbI1AsUje/0EBeBtZBGLd2xlE
         iXIg==
X-Forwarded-Encrypted: i=1; AJvYcCXW+bnYh0El4gyKV1ZNk0YejIL1z729YDuKR1lhcIKDdbMkXgh3BjVYqDhoxBS9tPFbVnkl9mSENeToa7PEcITiauFARW2AmJlAtEJW/ygiXvZ+nNsxKXuk0X8je02v3jO/7mYfYGu5BxmJ01rQBVCzFu8pUXO4OQS5KCpJUJPEL0RGad59
X-Gm-Message-State: AOJu0YxGh3BFInUglzIzMZ2aFV6rjEan/FlBOtMG+QsWUbGXxrMWzdk8
	ZtsFDuaQrnA0g85tzKCm0P9iPLfzlgCfGI3yxvJ/u6YpyR8cJxAgbzXEuC87K3e3VSAFEnGy1UM
	U64EVc4zR0ZdQd5NQGlmxonN6NQU=
X-Google-Smtp-Source: AGHT+IGqZzbUf0HyeB3TulezACFzF8VurHyR0y5UIr/AEq43qER2RS/oluVxAFzJOcBQRdq5t7IFk6h5IPX+1Ce2PUc=
X-Received: by 2002:ac2:51b3:0:b0:51c:1e98:30c1 with SMTP id
 f19-20020ac251b3000000b0051c1e9830c1mr921731lfk.8.1714707479376; Thu, 02 May
 2024 20:37:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502185819.788716-1-andreas@kemnade.info> <20240502185819.788716-3-andreas@kemnade.info>
 <CAHp75Vd1A8sy2Oky9TENUTAj0SCCyVQ8Zh49AN3X7t9cK2F+iw@mail.gmail.com> <ZjQdWdpmqoXhJeek@google.com>
In-Reply-To: <ZjQdWdpmqoXhJeek@google.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 3 May 2024 06:37:22 +0300
Message-ID: <CAHp75VcyRiE3+CnZo4VbXWYFQ8f_N9zhp7gmEqBHEMQ9rEn2Fw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Input: ektf2127 - add ektf2232 support
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, hdegoede@redhat.com, u.kleine-koenig@pengutronix.de, 
	siebren.vroegindeweij@hotmail.com, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 2:10=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, May 02, 2024 at 10:16:01PM +0300, Andy Shevchenko wrote:
> > On Thu, May 2, 2024 at 9:58=E2=80=AFPM Andreas Kemnade <andreas@kemnade=
info> wrote:

..

> > > +       if (ts->shifted_status) {
>
> Instead of the flag I think it would be better if you had
> ts->status_shift and did
>
>                 status =3D buf[7] >> ts->status_shift;
>                 ektf2127_report2_contact(ts, 0, &buf[1], status & BIT(0))=
;
>                 ektf2127_report2_contact(ts, 1, &buf[4], status & BIT(1))=
;
>
> > > +               ektf2127_report2_contact(ts, 0, &buf[1], !!(buf[7] & =
1));
> > > +               ektf2127_report2_contact(ts, 1, &buf[4], !!(buf[7] & =
2));
> >
> > BIT(0)
> > BIT(1)
> >
> > > +       } else {
> > > +               ektf2127_report2_contact(ts, 0, &buf[1], !!(buf[7] & =
2));
> > > +               ektf2127_report2_contact(ts, 1, &buf[4], !!(buf[7] & =
4));
> >
> > BIT(1)
> > BIT(2)
> >
> > > +       }

..

> > > +       if (dev->of_node &&
> > > +           of_device_is_compatible(dev->of_node, "elan,ektf2232"))
> >
> > if (device_is_compatible(...))
>
> Actually I think this better come from data obtained via
> device_get_match_data().
>
> > > +               ts->shifted_status =3D true;

I agree with your comments. Hopefully the author as well.

--=20
With Best Regards,
Andy Shevchenko

