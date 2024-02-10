Return-Path: <linux-kernel+bounces-60432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEA48504DE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 506F1B20D6B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 15:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C892D5BAE7;
	Sat, 10 Feb 2024 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drY9zONF"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1845BAD7;
	Sat, 10 Feb 2024 15:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707577975; cv=none; b=ccpkSIIzLkPEeqcrQqb+T2K4WaB96FCnZ6EU3BpZe6507Y89Yz5dXpW4HS4jVkDNVhpivsjiGbfTdrQAjHq3r5I5qRtmAbjqujktXWOd9yK4AQMhbmPUtlu3nO96lCLUgzvB6QlNPd/7xSvnFu57BxtZ0VmZovMxbeh8yb4ynMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707577975; c=relaxed/simple;
	bh=pFaaGu8xoLVFZ/xkilJYNOhe4SID+w1X5c35gQ2D4N8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G73qZmUY7Ufbl6HjMQ4lfXBzwOsZIWJp24fP/R6Wea42ZKkUxru5Ia59NbeL0UUqB8JZTddUykHB7UXDxUGMQZMxv9AdiYGcbsUTNIeKGafTLusZNZfB6JmvkppF+2a/mbsfn2U55aJnhGzSrHadoCOSDS3RBm3SwrLdex+ekPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drY9zONF; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a30f7c9574eso224008866b.0;
        Sat, 10 Feb 2024 07:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707577972; x=1708182772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3TVv5k2kyAT9B3mGBJu/+NC8ZeTvIm0YHEVTPnOgPI=;
        b=drY9zONFSzORINl6XCIFvo79ZajUSnDMTIi5Z2pkeUtriMoLploPMitogmDxXR0zK8
         YThSUTO+ctSnAIrs0FKI/cwj/tNqgdwuE1Aw+R061FazqgKi8y/q3h1un53ulI9FdT7v
         GYLmECx80L0+K99dYT5K0Pzd+6nn9wpcTGGJze4OcLOpJShVaczkdNXUHg3GtLHMVw5g
         BfPQ7kwGLVslMb7rJJOlvOjcMmsQrzY8/CNrMn5gH3q8hhaupT93r9jH8TdZLYC0WD6y
         9g5saM/lOql1se0qoTFqZa/4Ipj70SIxDH/i07L4Hmd6VIHtYiNbBZiM1fqeuy4/urtP
         2Gnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707577972; x=1708182772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3TVv5k2kyAT9B3mGBJu/+NC8ZeTvIm0YHEVTPnOgPI=;
        b=q6h08W/QnacZCsopr+PqOmC1TDVw7LMJCZYymWUKjWHWCQm+ubacDDZo+xbLh48GqF
         mo0A8lLfpO0NiEz1Lq09bwD/CaydkVPmhTacx/oGH/lH5heuS9kk6+MB5os4Ai9DDUsW
         tL0TwUwLPoAVqhLiXyPJ1Rv8cgLK6VXp79kMOPwwH0RdcF/9XbGHl8uYO/eg4o5Q36xj
         4MQAf+e8RMRe3vV8lF63BWjux1NTL3DiE1GJ94KJIzllgrm+75jasf5LUPmgnxGu2+IT
         m4RBCGE8CPDESCtSCGW6Ts/pPx1lbUW9SFptlz/n0+PbksNhfcNclBFN5fkrOYB8Etzr
         cKeA==
X-Forwarded-Encrypted: i=1; AJvYcCX6V4t1etB46k6cd4E2FbX8n1Se6kVBrH/BJUSconReh/MG9NtgF7Oow2YUL/Tqx6XkDxZ+r4FKXO4UDoaKZgoSxwjaGoZ2hW0jhOPdTK4oV0KMWLpFgV//RbWBrKUzly+8Meuyh4qS
X-Gm-Message-State: AOJu0YzNKFjASpPG08DQEyHBB/e7eOZ5OjBP/Inr9rS5FFdqRI/e84DN
	3OnoXbY1QmddxwKqL98XgXoIfE93ighTXOEsyfM/IShpiHpH09dGQRpUfBl8LesDbNlATdmhEbO
	e96GJ+SrDTDiT0n4Xp5iQIRXucng=
X-Google-Smtp-Source: AGHT+IGrQdkdIMgpyD9sqQT2AF00GLSHFoBGi3D70fBhru/UsrbXJoqat2RR+OX8G8KBofOMgXqhVE/2piBMmUDdDLI=
X-Received: by 2002:a17:906:f190:b0:a38:4ff3:773 with SMTP id
 gs16-20020a170906f19000b00a384ff30773mr1435431ejb.47.1707577971557; Sat, 10
 Feb 2024 07:12:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127160405.19696-1-petre.rodan@subdimension.ro>
 <20240127160405.19696-5-petre.rodan@subdimension.ro> <Zb-1UGJt27OV-vjc@surfacebook.localdomain>
 <ZcEPJh1i7cc0xyBW@sunspire> <20240210150907.40e27f53@jic23-huawei>
In-Reply-To: <20240210150907.40e27f53@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 10 Feb 2024 17:12:15 +0200
Message-ID: <CAHp75VerichvwEOHvYYsHdYYAVJUajYk=LaO0VRpS51DgAr29A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] iio: pressure: hsc030pa add triggered buffer
To: Jonathan Cameron <jic23@kernel.org>
Cc: Petre Rodan <petre.rodan@subdimension.ro>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 5:09=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
> On Mon, 5 Feb 2024 18:39:02 +0200
> Petre Rodan <petre.rodan@subdimension.ro> wrote:
> > On Sun, Feb 04, 2024 at 06:03:28PM +0200, andy.shevchenko@gmail.com wro=
te:

> > > > + memcpy(&data->scan.chan[1], &data->buffer[2], 2);
> > >
> > > Hmm... We don't have fixed-size memcpy() :-(
> >
> >       __be16 *ptr;
> >
> >       ptr =3D (__be16 *) data->buffer;
> >       data->scan.chan[0] =3D *ptr;
> >       data->scan.chan[1] =3D *++ptr;
> >
> > is this an acceptable replacement? I do not understand that your concer=
n was, my
> > intent was to copy exactly 2 bytes over.
>
> Andy?
>
> I'm not sure what you meant here either.

It was just a rhetorical remark, no AR implied. I.o.w. the current code is =
okay.

> There is an existing oddity that the read_raw deals with this as a be32 a=
nd
> masking out the right sections for each channel rather than perhaps more =
logical
> be16 pair here.


--=20
With Best Regards,
Andy Shevchenko

