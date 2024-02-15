Return-Path: <linux-kernel+bounces-66739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA138560E4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75853287E80
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ADF12AAF4;
	Thu, 15 Feb 2024 11:05:52 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024D576C8C;
	Thu, 15 Feb 2024 11:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995152; cv=none; b=U+Hu+30jBRg5EIi3Z++lAct5UTtcdT1Zq7iw3sn/BFUMK280UVdOEb1MaqnwSGfO/JdkPwhFA9h+/5nKcdm5hzc6O94sTg/H00MsUlHNbCU6XWFtuPUjX2TN1VCwMkpHg7w1RSOhYSB5TReosyBby/f/UJ9U/0rezddgvU5lHcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995152; c=relaxed/simple;
	bh=5ekBSyvELx3BO6/6jIyAyalwkqThpZC74REXt7qyDQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1p00L6/9xrWzJgVJFM2Q3e4KClc0/h5OWWmr4x0ZUXFYlMdZrQqsnX5l81fhvp+hKyMKpYGZkYB3ayNlqFxp5COSSbvJB052DhIGHyzKtxmg1+YtIqo8yzDCje1B0LNzbswxrNV9KFfjuIuKttPvY/7gbzuhSbLO+gfK2Y8+9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-60782336a3aso5774597b3.2;
        Thu, 15 Feb 2024 03:05:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707995149; x=1708599949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+7wkmLkp5lZjNrOOOOBAQUeYNVQkdS7K3E0ywuDQwI=;
        b=JoeQjp2gqFlCAaEU/6eLbE+6GQHocU2y8UXozneuLvMZUFMykLT6RXiPZuDwVm1kjn
         XQEJpnMEJE2sxoqvYqD1jWB3RD1zGMtatG2ti5XojmcniIKUWgIlR21tI8iCwwBTtOoj
         iMuCKVAIIdG3+GpdjBe9b3CP9xC4fwsKE7fu9SEJ7WBdVD+ljSAApP5hmiL/E4zUTTI8
         vT+fQLPWLYvpS6AVpOX045OCghlBR9xQWdoVk5lIh/xjtj/rrKcxgUlI4S/onsRhycll
         vPOpbrsRu4xMOCybVRATNnSyO9PJZV91PgCGdeT4fJoFc2Is2323Kf9ueDCi3yygeRFQ
         8kuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMQTNAko87HpMlxJwClC+8xP66xswamMoADeRTRiuXkwuoxf6wLAutRdQWyNW92YCXSk4zLWFWSbulk92+d8ep8gprRSh4oAedeo8p
X-Gm-Message-State: AOJu0YwFlJAsgyAm7k67rZiWHqAxxYecM4Vt0Q9wlhG0Noo3tSQSJkQH
	BnMfyKj63X1WKb+nfgn3dKFEnyM31kpcsDXYqOK8wg2I6vGR6DYvnNe2C0FN8FIq6A==
X-Google-Smtp-Source: AGHT+IGnNdqJLfjzbChqNyYA/zoE6OGIrLSpzK0xWny88j2canhxM5lnVldxioslJFvadEA0w3y+3A==
X-Received: by 2002:a81:5293:0:b0:607:923a:d2bb with SMTP id g141-20020a815293000000b00607923ad2bbmr1306180ywb.20.1707995149489;
        Thu, 15 Feb 2024 03:05:49 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id x200-20020a81a0d1000000b00607cd5e6dbcsm195012ywg.137.2024.02.15.03.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 03:05:49 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcbc00f6c04so634791276.3;
        Thu, 15 Feb 2024 03:05:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0IFFoovwCLhIqlcfXE1SkHf5kLq4fCWL7/BfOHjCatwJ6UtczBs+3wss8ElLkrvelr4glIPjwPmzCXCmt6jyTC+15s2qvO51aG8FE
X-Received: by 2002:a25:ad4b:0:b0:dcc:6112:f90d with SMTP id
 l11-20020a25ad4b000000b00dcc6112f90dmr1063026ybe.62.1707995149001; Thu, 15
 Feb 2024 03:05:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
 <Zcz--YJmWLm0ikUT@smile.fi.intel.com> <CAMuHMdW5nwtuZpTyf+_41bcHeR+MA6Ko2++JiC8Xz6u1tDNQ_Q@mail.gmail.com>
In-Reply-To: <CAMuHMdW5nwtuZpTyf+_41bcHeR+MA6Ko2++JiC8Xz6u1tDNQ_Q@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Feb 2024 12:05:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWKAf_Yi59RWoA5=K=ajS0-+Vn8tgwzy5tAzLmqizZLtg@mail.gmail.com>
Message-ID: <CAMuHMdWKAf_Yi59RWoA5=K=ajS0-+Vn8tgwzy5tAzLmqizZLtg@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] auxdisplay: linedisp: Clean up and add new driver
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Wed, Feb 14, 2024 at 7:45=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Wed, Feb 14, 2024 at 6:57=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Feb 12, 2024 at 07:01:33PM +0200, Andy Shevchenko wrote:
> > > Add a new initial driver for Maxim MAX6958/6959 chips.
> > > While developing that driver I realised that there is a lot
> > > of duplication between ht16k33 and a new one. Hence set of
> > > cleanups and refactorings.
> > >
> > > Note, the new driver has minimum support of the hardware and
> > > I have plans to cover more features in the future.
> > >
> > > In v2:
> > > - updated DT bindings to follow specifications and requirements (Krzy=
sztof)
> > > - unified return code variable (err everywhere)
> > > - left patches 10 and 13 untouched, we may amend later on (Robin)
> >
> > Geert, I would like to apply at least the first 13 patches.
> > Do you have any comments or even possibility to perform a regression te=
st?
>
> I'll try to give it a try on my Adafruit Quad 14-segment display tomorrow=
..

With the missing return-statement added, the ht16k33 driver builds
and works fine: the kernel version is happily scrolling by.
I didn't test userspace line display control, as there is an issue
with the uSD interface on my OrangeCrab, preventing it from booting
into userspace.

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

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

