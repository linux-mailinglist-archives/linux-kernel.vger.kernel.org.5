Return-Path: <linux-kernel+bounces-22047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B76C829865
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0E741F21EE5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4020B46450;
	Wed, 10 Jan 2024 11:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qra71X0N"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B694655D;
	Wed, 10 Jan 2024 11:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bb9d54575cso3395518b6e.2;
        Wed, 10 Jan 2024 03:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704885087; x=1705489887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omsWh5uQriFHqDpOaip7ABA2fSXEYznPIN/MC/otOtM=;
        b=Qra71X0NqjL0tomyMOjyq/OY7i5fyT6gyjAcoO0RTZjmJBzPlntswtXwOgGZefMA3c
         IcAGlAvrNCzCXj86YOFrPoYk+xqN4Eu15ot+fRa4f2DNcM2faHYrgj4Ahi4WBYPWrApe
         PiF3RBfWw3E3bn8xlmSJi2qT4gjijdsgI03CJ23uOGrJVLm1Fl9moPXAmw/j8wUGvVgv
         ONYwXAgIdhyZzcxYNOciyCwpgOOPfrHwY1yC9loKNGK0us7gYYzpSOJ3rD0epD/reO9M
         dl6YSfpmNgx+vmi4V0l/F6sPAnTEfwBlXa6GCpVgY0T6xyoKhhPj6f52Ac8neAYbY90g
         DpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704885087; x=1705489887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omsWh5uQriFHqDpOaip7ABA2fSXEYznPIN/MC/otOtM=;
        b=EGAbtQMDXsp3Oa50BjuK7Qj0a5xfjGk0NCT1BD1YfgvEOPDB34NsIjGFmRmUng0VB0
         JlIjMI8nJTVcfUaAFJnElfn7CCutTCm4EOLVzlJoHRQ+5juV+ckkhvkxkjgOrhtIZeNn
         JcasNenif12yJeeKpL7ELpxUqSeCzm0n3CI4Q7qdvsQEQ6JAv4ESpNJFQWZaFtjHbP3e
         b+R1iuHfYfttjApoqRnUcZjCVa/KAAOl1Chy2jo2sM7/ANX+VKJYtpv0xDasLDSOOSb2
         0Y9cO0b945tnPBEfPudTcEvWj60Nd0nHkV8k1oFjyV6tKqTPzWFmbdiq6sapsyt6W/Ne
         6NHg==
X-Gm-Message-State: AOJu0Yzss5KKs0rtq/RU1LD0MO6B+XVEBNi3dN+TTwmRWTV8cfa1ZztL
	fTjPqHHEcogL+bKfeegQqq3dsUYa8yOGmCVHWco=
X-Google-Smtp-Source: AGHT+IGvKV2nwCLqCBAalddYmFFIryTSRVfx6vhcnyr1cLuJVJ8AxgBHTnqa8yFEd9OVlV5VyRZ92ZZ97Yiq3wdxsug=
X-Received: by 2002:a05:6808:1b20:b0:3bd:4bb7:4213 with SMTP id
 bx32-20020a0568081b2000b003bd4bb74213mr435165oib.7.1704885087209; Wed, 10 Jan
 2024 03:11:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109135952.77458-1-warthog618@gmail.com> <CAHp75Ve05bAK-ehZZ7XSci5VqR18cCb=hgnbFKXwy2QPkxo=pw@mail.gmail.com>
 <20240109234518.GA7839@rigel> <9e33f7dc-deee-4165-bc10-ad77f38b270a@oracle.com>
In-Reply-To: <9e33f7dc-deee-4165-bc10-ad77f38b270a@oracle.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 10 Jan 2024 13:10:51 +0200
Message-ID: <CAHp75Vc8UN2kyxGtV0tCF+xcRLAxg0qijTvHWXXtdTA9nY-h3w@mail.gmail.com>
Subject: Re: [PATCH 0/7] Documentation: gpio: add character device userspace
 API documentation
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Kent Gibson <warthog618@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, brgl@bgdev.pl, 
	linus.walleij@linaro.org, andy@kernel.org, corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 10:16=E2=80=AFAM Vegard Nossum <vegard.nossum@oracl=
e.com> wrote:
> On 10/01/2024 00:45, Kent Gibson wrote:
> > On Tue, Jan 09, 2024 at 10:00:26PM +0200, Andy Shevchenko wrote:
> >> On Tue, Jan 9, 2024 at 4:00=E2=80=AFPM Kent Gibson <warthog618@gmail.c=
om> wrote:
> >>
> >> May we actually state in the documentation that sysfs is subject to
> >> remove at some point?
> >
> > So formally define what "deprecated" means?
> > Is that covered in the higher level documentation somewhere?
> > If so I'm more than happy to provide a reference.
>
> We have a few files that may be relevant here, that I'm aware of:
>
> 1) https://docs.kernel.org/admin-guide/sysfs-rules.html
>
> documents some general assumptions that userspace can make about the
> stability of sysfs and its files
>
> 2) https://docs.kernel.org/admin-guide/abi.html
>
> This is the public-facing, somewhat machine-readable repository of what
> is supposed to be the kernel's ABI/API, including "obsolete" and
> "removed" interfaces.
>
> 3) Documentation/ABI/README
>
> describes the process of deprecating an interface

Yes and GPIO currently is under obsolete section with also this:

"This ABI is deprecated and will be removed after 2020. It is replaced
with the GPIO character device."

https://docs.kernel.org/admin-guide/abi-obsolete.html#symbols-under-sys-cla=
ss

So, proposed cleanup series should probably rely on this documentation
among other existing descriptions of sysfs GPIO.

--=20
With Best Regards,
Andy Shevchenko

