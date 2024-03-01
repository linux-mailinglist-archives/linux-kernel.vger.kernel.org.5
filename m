Return-Path: <linux-kernel+bounces-88306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7556A86DFE1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F59283332
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8906F07E;
	Fri,  1 Mar 2024 11:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQDnH84x"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB946F071;
	Fri,  1 Mar 2024 11:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709291414; cv=none; b=c/ua6bhFbsDn3veIeDTdYYM60yGySaqp4B4PsEQ4W/1kM0vDBiygPyv4iTbLsz+r3ayR+Yv1yC8w8ALoLNNjFBT8FKLmSZdnPKCTuQlO5eA4B7TvC9NRHZXIs+gPm3MSy+wjsTlKJa2lNiSjB13t/a7y2VfJeWP7Lfau+frbeKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709291414; c=relaxed/simple;
	bh=ZPuYGNDtU2C61JrD8awnzL2eNGY9J7zqh51rLsBoCO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYTTPZFPIaJkBjmg412wlp+FChAgnwuxdT77BAjbdNi6uShIp5WbEgUpCEvir707ybTaTCQGGjeu6i5+uLJbadqxYIB0W6VZxU3Ynk3rVaHNkGybE3H7EX1siW//XprndPgs0Hizvs56CSaIewT2GBlygnOGz1b0uvFCCbSHgX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQDnH84x; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3e552eff09so273814666b.3;
        Fri, 01 Mar 2024 03:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709291412; x=1709896212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9f1cuB9REaK+HmuUhlOguaJHGRgFgUSmSu3BLd/is7Q=;
        b=SQDnH84x/ZNsySWFhpU5nHUcErnFjQ2nfUJusVWCdLIJQFPyZ2qgQ9SECHJ4RxwZZu
         vX5dZLV7Pvp9FM3t5gZcVY+2n6HzENGAuR66FoxFScxXM5YigxHanpEh/zWdAJxf9b3G
         2wwPNnTctj6kVG1rrQpJhWx6uuUjrTliAhEvXrkufPOKScF3vTDVLa8U6XKH7+ILt0fP
         XP9W1I9oZISp49xZryuWAJOjA2Z7VA7rtbrgOdseFOdgicvBWGuA2rNO6veDOax7LHOu
         FTEaM0Ntcnm/aildzEFlKwsi1Ih3LQuj6JA9pSwwEl3RmX3dokza41lmBCawfr7XiPkL
         lTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709291412; x=1709896212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9f1cuB9REaK+HmuUhlOguaJHGRgFgUSmSu3BLd/is7Q=;
        b=iETZYQxN+m2t+vX94fzBEOt0xrm/e8a7Kp8LHFSYWt3Ks/NjjxYknzhj/OOqhXBLI8
         gwMdfCaeXkEZzBTb14tLn+lvjDO/1MveaNqMATNd3dGfn9+y5p4dvgbCXtLT42Ve46SP
         1JhFyibyBC4YBvO+2PUzjVQsbdaOtq8SN6ZlCA3Gm8wgkJbCnZnC4meWkGFpwYcI7Mjv
         Y/ZDHKSVFjUgT27b7d472B8J9IO0rz1fSV64ai8fdCkP7YYedJyyNhj8U/qm92NjwwkM
         Eq/cRgVyG7yrmzvgdL75ZydrPSzV7iUv20P9AfRoOOblZ5A4mw4zgNXXdzWzb8lhNMTO
         +h3w==
X-Forwarded-Encrypted: i=1; AJvYcCVDIULqGBrhYKpqbkTtutYDkCyDuyimTE5NNRM+i7yH0Shk2nSZS8vJVHO5+wZ/OMU44HcgGhkh96M+NsQ9izRdYwma49tDexU0qVARSLUrKGJ3ZXY8y3M4JKsUZ00ur17z3NOFGfvOm6jv8Ykr
X-Gm-Message-State: AOJu0YyfUN6mOc+tE8p3asrnNhBSLTN7dpabtPJINnfd6P1Et+5r5rXO
	qNUrq5QAGNBoDYv+ltiN/RTDmZVO7FXpkuEcxTdlOAVD+JQGH43qKIrckB7KXRLGrngYMBFlfUg
	pJRy8hvsFyyADgQpdyzM8d/Oeoso=
X-Google-Smtp-Source: AGHT+IG4ULdoDoSbkfrP+miccWHuw/7d6R6I5AAI3byeWcQqNIfoQWB5rAdNyRBtfs5i55sB6OBzHA6Tf/ZWQ1w7uhI=
X-Received: by 2002:a17:906:4951:b0:a3f:2259:da62 with SMTP id
 f17-20020a170906495100b00a3f2259da62mr1035572ejt.52.1709291404238; Fri, 01
 Mar 2024 03:10:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301002416.it.092-kees@kernel.org> <20240301002650.1544829-1-keescook@chromium.org>
In-Reply-To: <20240301002650.1544829-1-keescook@chromium.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 Mar 2024 13:09:27 +0200
Message-ID: <CAHp75VdhY6-OmNYtbpnb+dv1Du=LTnignsTRSU9+8yqpbFqPsQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] string: Convert selftest to KUnit
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 2:26=E2=80=AFAM Kees Cook <keescook@chromium.org> wr=
ote:
>
> Convert test_string.c to KUnit so it can be easily run with everything
> else.

Have you run it?

..

>         if (i < 256)
> -               return (i << 24) | (j << 16) | k | 0x8000;
> -       return 0;
> +               KUNIT_EXPECT_EQ(test, 0, (i << 24) | (j << 16) | k | 0x80=
00);

First of all, this special value encodes the problematic patterns, so
you missed proper messaging.
Second, the returned value has a constant, how do you expect 0 to be
equal to something (guaranteed not to be 0)?

This needs a good rethink of what you should do in the KUnit approach.

..

> +               KUNIT_EXPECT_EQ(test, 0, (i << 24) | (j << 16) | k | 0x80=
00);

Ditto.

..

> +               KUNIT_EXPECT_EQ(test, 0, (i << 24) | (j << 16) | k | 0x80=
00);

Ditto.

..

>         for (i =3D 0; i < strlen(test_string) + 1; i++) {
>                 result =3D strchr(test_string, test_string[i]);
> -               if (result - test_string !=3D i)
> -                       return i + 'a';
> +               KUNIT_ASSERT_EQ(test, result - test_string, i);

In a similar way, all returned values are *special*, you really need
to think about them before converting to a simple (and sometimes
wrong) checks)

..

I dunno if KUnit has a fault ejection simulation. It should, in order
to be sure that test cases are fine when they fail.

--=20
With Best Regards,
Andy Shevchenko

