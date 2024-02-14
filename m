Return-Path: <linux-kernel+bounces-65828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0210D85528B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B269C2833C6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4271139572;
	Wed, 14 Feb 2024 18:45:18 +0000 (UTC)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C96212F37B;
	Wed, 14 Feb 2024 18:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707936318; cv=none; b=eT+cL2rIK0I81q4NRw/2pQrHCL6H9KtlApJe5EQLYxwnjT4qR4ReL1tR+6/D+9Lr9hfeULZZAV9b6dkmTkjX2AV0ysKG2jquLuncOIklXzuimPjP9dwLlJrDOG1DOUlqWMTxZ4Kat8bFF7PH7e3u/LGHwFpYNrsxrwJRmAYNGGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707936318; c=relaxed/simple;
	bh=72TJF+26+fq4Cy7W5PwGo5iflp019HlrHyv4DywiD1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzC2uJfem8wR8rqvGqEj0aW0+lxOCn89wP9uJiThNh63IgPLV2ktGSUm9UuNgV4hJTQ7Lfj3KR1rBZ9jiTjj4zBsR9HEV4QoMSdykmlCGKMsv6iarIYMLmLuA/ShdR2ixivPg2Uw6scKHfNm55z5ext7kLkvwmXJmdaQ6ISLu4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso2093833276.1;
        Wed, 14 Feb 2024 10:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707936315; x=1708541115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+f5n/cHsYg/dWsN7rUTzZMxuPCFn8WGXbxLXF+ZxZY=;
        b=I9dyuIg3/2TBmc5Q2ChFz0AuY8eHOvsWfn8ncLd8aPL4RTNfwj0FfkAcZLUwQiBssA
         o4VmgxuTfhAbl6wuLx2c6BmIGW3SlypdiRUMbDOCx8UBb/O8lNxCxyvhetSe91cZX87f
         cxxTJcX6UuanlLlS5jERFirwehKGqDhIGX34VIYK4TrfEiAhvpmVFbMxG865rTZYJYcV
         UuvQlMfr5sJ5nXlO1fIoEyTU6H51Vlwv/ybaaKsUH/3EM3d3x8DSt6hxeFUf62zfFhKU
         7zai0PmHrk6jvi8H55AwbXSZgtziAUGC1WtMb7tyFSm6ttZoJKhFFt5LHmXbBtJq94rY
         34yw==
X-Forwarded-Encrypted: i=1; AJvYcCXONdOUABuPXit8OuyhIr6hWhLLi8QQGHNrzQsRLMfyJj7znB9fuY2PC+yqY92mk7AShKTujnWDtrEKO+YxX9RP3gBfhe20KIHVgnaJ
X-Gm-Message-State: AOJu0YxsxvkDHsNBN0hdmb9FaAu5UEoDfuTMS6uPnsldQP4h+SIVD16j
	92CjEAGoe8cug3SavxOA31MdI+CB+LJfmN0We7TMU1ogIuUaLFUaej8acynFw2w=
X-Google-Smtp-Source: AGHT+IEcFCGaoxjNmlFfZDbNl+tXD7kgsivDXL+O5LPV3WLykTBz6OwLPoQxlSDPAXOxH9gFMQWmTw==
X-Received: by 2002:a25:b206:0:b0:dbe:a688:8ab8 with SMTP id i6-20020a25b206000000b00dbea6888ab8mr3386480ybj.0.1707936314849;
        Wed, 14 Feb 2024 10:45:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWw+LzLNn5tZtDYVTBOE2FEioJOV4/ZoElxTuva+VsjopzXVRNUH2XUo2EdvbkLM854GIl/Mho71X2nCHbUK02RW/zqQHIVSylBbQi6
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id 132-20020a25008a000000b00dc7496891f1sm2274926yba.54.2024.02.14.10.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 10:45:14 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso2093809276.1;
        Wed, 14 Feb 2024 10:45:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUmScRVLXi2XTraxVjasA0LTbTJvbGcnxyxshed9zsIzZbcVEQdvAlWp1KdRwDLywZVCnICN8Ab51+EyHGquv7mLQdW4PccL2+L+lSD
X-Received: by 2002:a25:2902:0:b0:dcd:5187:a032 with SMTP id
 p2-20020a252902000000b00dcd5187a032mr2984857ybp.43.1707936313923; Wed, 14 Feb
 2024 10:45:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com> <Zcz--YJmWLm0ikUT@smile.fi.intel.com>
In-Reply-To: <Zcz--YJmWLm0ikUT@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Feb 2024 19:45:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW5nwtuZpTyf+_41bcHeR+MA6Ko2++JiC8Xz6u1tDNQ_Q@mail.gmail.com>
Message-ID: <CAMuHMdW5nwtuZpTyf+_41bcHeR+MA6Ko2++JiC8Xz6u1tDNQ_Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] auxdisplay: linedisp: Clean up and add new driver
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Wed, Feb 14, 2024 at 6:57=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Feb 12, 2024 at 07:01:33PM +0200, Andy Shevchenko wrote:
> > Add a new initial driver for Maxim MAX6958/6959 chips.
> > While developing that driver I realised that there is a lot
> > of duplication between ht16k33 and a new one. Hence set of
> > cleanups and refactorings.
> >
> > Note, the new driver has minimum support of the hardware and
> > I have plans to cover more features in the future.
> >
> > In v2:
> > - updated DT bindings to follow specifications and requirements (Krzysz=
tof)
> > - unified return code variable (err everywhere)
> > - left patches 10 and 13 untouched, we may amend later on (Robin)
>
> Geert, I would like to apply at least the first 13 patches.
> Do you have any comments or even possibility to perform a regression test=
?

I'll try to give it a try on my Adafruit Quad 14-segment display tomorrow..=
.

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

