Return-Path: <linux-kernel+bounces-58517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D17884E76F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB961F25FF7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BEB85299;
	Thu,  8 Feb 2024 18:11:00 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F48182D6A;
	Thu,  8 Feb 2024 18:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707415860; cv=none; b=k+LAicHO6oNtL+8CnI1jrAUg1TfC8OgBIsMXd7UQ/CKt79nfokGboMOEybf5UWF+OW8o4y4oVVk/Z/j2TviFuhwUf3qShR5Ri8w9YDGIx2np31gaYBBw6vmX6Nn1F8Y0eiCSJuCybW6YPPOIXvRUXUIQwQoecg4wKvGEAFR5Lk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707415860; c=relaxed/simple;
	bh=qdQGrkyG00CdRQsmlmIAsh4C3EmiSMmlMAnAKqZBcHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZxQnkwluSyxHDVDNeOTaeMG8tGpHAnecbgYAu9tOcnB9YqG40gE8DDLNbVvZ8ImIOFzZK8TpGlZVZ6fl1rWIHNkuL5NiI9b6fuKn4Z9Qfky5WHxXMATQh24hY6IJzzmNVhoTEbz7NDeeZ2PaquoL7P0Gx6M4SqqZHNM/mJ9wnXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-604ac794c01so1453087b3.2;
        Thu, 08 Feb 2024 10:10:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707415855; x=1708020655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNi0JU1w1S3j627lW71M/tpho72s+VxwyeKQBKOV30M=;
        b=wjVZ6yYLF63fQTYXJACWPrHQiA2Vsu2g6H2JpgbXgGmw5n67LzkwDOjGvbUWzLdTzS
         N0cBiRpXt+ndaCjBpW+3nkXg0r+3nABx1ymxa0y5coPKaqKrlgRdvOMza/gbzXScj+Jz
         H+gMC3rir8mzE5FoYAfVqb/8dQP5IhO8evTJwdc5BGyN7n2cmobGaT/dB3sgslCO4Fri
         kcftLd+lUQYvV0S7/uZ8/d7yxFbDZ54HUz8svDXTBaTHWnUhpsPAbr6i5fder9S/v//x
         XzhvNTBfjRXqoFYR+GXXnDyss43i2/XDvhiFUWEi0ccElybpw3F7gUFeSWgIySU7VWl5
         2djQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgId6SIGLQd3UQQz6ekHSzkjMZPsZgElt1/kGzAuSm5S1dn9XT+PoGb6AOXXG4ia0hghni5q5oIIyFq4mAv7mn8W/BuI5nZmg3A7sCVIR9OhQw5so1vb8mK4Y+mYYk6X1+v3aEAvc00w==
X-Gm-Message-State: AOJu0YzpTeWSJY6SAPvXHMYzbKKN1RRBQiKDXmj8UoJg+LkJasfNjGAl
	nPLmCod4qggBLiHglB+Xdl5i6uU4u7CX86tSzNJIBS+tDI9f6jlYzJchoTSbR2o=
X-Google-Smtp-Source: AGHT+IGdUU3TTDbk/MynXhJi34rhfmEesWmfLyRMtnxb9vqXiEfyhbNeFgV0lcANnJZNnh4MMiw6Rg==
X-Received: by 2002:a81:5c88:0:b0:5ff:4959:1da8 with SMTP id q130-20020a815c88000000b005ff49591da8mr97836ywb.50.1707415854667;
        Thu, 08 Feb 2024 10:10:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWEIy6Tp/R4hHRyLSG1CBYlO1dP+OonyN3ke/gjo43OX92p+RKAgfOg4Mi2BhkVqhhMXe/UHKzjdO5UFGwFihGSLrebsFZXwg2ecoKclGjv8Z61ttBT5hb1FR5FaW/gsI4k5bQBVYHyUw==
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id bh12-20020a05690c038c00b006047e932385sm784068ywb.95.2024.02.08.10.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 10:10:54 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-604ac794c01so1452627b3.2;
        Thu, 08 Feb 2024 10:10:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW6aXjGABMC+3tqkDb7k+xqMGAGlKmtjFNpcz36N4BuFoSAW+46JZFnKQLMp4FzlaibjZluHxp7J5/sBWs8dYCL7CSenTUal3sH8ngknMuJ+dw7rYeDF5Os88bCYYBrP9iRxKbmIgkzAQ==
X-Received: by 2002:a0d:c604:0:b0:5ff:91d8:42b0 with SMTP id
 i4-20020a0dc604000000b005ff91d842b0mr127588ywd.46.1707415853936; Thu, 08 Feb
 2024 10:10:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208165937.2221193-1-andriy.shevchenko@linux.intel.com> <20240208-drearily-carwash-60e4ba70a559@spud>
In-Reply-To: <20240208-drearily-carwash-60e4ba70a559@spud>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 8 Feb 2024 19:10:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWBbjHe8D+sn94wMqXy3Rv-VU2CDWca=fJKyH+=G_ngmw@mail.gmail.com>
Message-ID: <CAMuHMdWBbjHe8D+sn94wMqXy3Rv-VU2CDWca=fJKyH+=G_ngmw@mail.gmail.com>
Subject: Re: [PATCH v1 00/15] auxdisplay: linedisp: Clean up and add new driver
To: Conor Dooley <conor@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Robin van der Gracht <robin@protonic.nl>, 
	Paul Burton <paulburton@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 6:52=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
> On Thu, Feb 08, 2024 at 06:58:43PM +0200, Andy Shevchenko wrote:
> > Add a new initial driver for Maxim MAX6958/6959 chips.
> > While developing that driver I realised that there is a lot
> > of duplication between ht16k33 and a new one. Hence set of
> > cleanups and refactorings.
> >
> > Note, the new driver has minimum support of the hardware and
> > I have plans to cover more features in the future.
> >
> > Andy Shevchenko (15):
> >   auxdisplay: img-ascii-lcd: Make container_of() no-op for struct
> >     linedisp
> >   auxdisplay: linedisp: Free allocated resources in ->release()
> >   auxdisplay: linedisp: Use unique number for id
> >   auxdisplay: linedisp: Unshadow error codes in ->store()
> >   auxdisplay: linedisp: Add missing header(s)
> >   auxdisplay: linedisp: Move exported symbols to a namespace
> >   auxdisplay: linedisp: Group line display drivers together
> >   auxdisplay: linedisp: Provide struct linedisp_ops for future extensio=
n
> >   auxdisplay: linedisp: Add support for overriding character mapping
> >   auxdisplay: linedisp: Provide a small buffer in the struct linedisp
> >   auxdisplay: ht16k33: Move ht16k33_linedisp_ops down
> >   auxdisplay: ht16k33: Switch to use line display character mapping
> >   auxdisplay: ht16k33: Use buffer from struct linedisp
> >   dt-bindings: auxdisplay: Add Maxim MAX6958/6959
> >   auxdisplay: Add driver for MAX695x 7-segment LED controllers
>
> Not all of these patches have made their way to the lists FYI:
> 2024-02-08 16:58 Andy Shevchenko [this message]
> 2024-02-08 16:58 ` [PATCH v1 01/15] auxdisplay: img-ascii-lcd: Make conta=
iner_of() no-op for struct linedisp Andy Shevchenko
> 2024-02-08 16:58 ` [PATCH v1 02/15] auxdisplay: linedisp: Free allocated =
resources in ->release() Andy Shevchenko
> 2024-02-08 16:58 ` [PATCH v1 03/15] auxdisplay: linedisp: Use unique numb=
er for id Andy Shevchenko
> 2024-02-08 16:58 ` [PATCH v1 06/15] auxdisplay: linedisp: Move exported s=
ymbols to a namespace Andy Shevchenko
> 2024-02-08 16:58 ` [PATCH v1 07/15] auxdisplay: linedisp: Group line disp=
lay drivers together Andy Shevchenko
> 2024-02-08 16:58 ` [PATCH v1 08/15] auxdisplay: linedisp: Provide struct =
linedisp_ops for future extension Andy Shevchenko
> 2024-02-08 16:58 ` [PATCH v1 09/15] auxdisplay: linedisp: Add support for=
 overriding character mapping Andy Shevchenko
> 2024-02-08 16:58 ` [PATCH v1 10/15] auxdisplay: linedisp: Provide a small=
 buffer in the struct linedisp Andy Shevchenko
> 2024-02-08 16:58 ` [PATCH v1 14/15] dt-bindings: auxdisplay: Add Maxim MA=
X6958/6959 Andy Shevchenko
> 2024-02-08 16:58 ` [PATCH v1 15/15] auxdisplay: Add driver for MAX695x 7-=
segment LED controllers Andy Shevchenko
> https://lore.kernel.org/all/20240208165937.2221193-1-andriy.shevchenko@li=
nux.intel.com/

Same for my mailbox.

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

