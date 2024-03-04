Return-Path: <linux-kernel+bounces-91143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0704C870A05
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61F4281E29
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9B178B67;
	Mon,  4 Mar 2024 19:02:11 +0000 (UTC)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8591B48CC7;
	Mon,  4 Mar 2024 19:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709578931; cv=none; b=GpaL1iWpUxj11eCMdjpM6HdcqxwNyy5KIeXIyoSkkVhmCgmm8iqhlYqpWgHhzpPh+TJkXH0/CArykiofmtIIxWzbgLbBdvFSfKf1IayslKBIJvUVmB87vRbZzQpH/cG0mdvKU8krhdRBDZ9sj8jdLWB1lFMvLaG1ZX8iJLqeTPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709578931; c=relaxed/simple;
	bh=jz+YaBY6pOhcQeRXB2G4cm+3RZ3GXD8LU3XyAlsEUug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KaYTCdkYe8G+sJqgxMPQLPTyvUJ2HgISgrwkbQlvODe3rpDRqoe0fGOb7c7wFfwPyHw4naoDIkET/mvmsObbtykBc615SuAW7g+QUsEgZjZmtxc3aSosC3qGtoFTo+cJTRl/aViw5tHLkaLcUHcxl8iiXSTLNfFpjapGXLRP9GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc74435c428so5312289276.2;
        Mon, 04 Mar 2024 11:02:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709578928; x=1710183728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYl1mIRYbr8vmVU4jA2oiSVVNLp+IoIPd1/D/iVf0OQ=;
        b=mA21OxOmYlV1KRDI06BXJ01zNFPGfQ6O9hL+lWVx0o8bTvc7ixGQWn4euJuCTlHG44
         tbRr2wsG0XNx/5QoW8bQLYcsrwptZB4qXsPaA9RfYAcWiwZotsTSLhfsH+ffHy84dwKR
         xvJsS70P4hJeY26gG2ceUTnVtShU5t0DVfsD9h04FigcjhVl5BrBxLcXu0E1AGcr2dFx
         Z9NbwCa2JWOTIpRiv4soVVbfPmEBlYbo9DIQt3PgxhRJ3k6PqtjPYCvBlHMBuDq6tAjn
         J+1v6geIQdtjZ8VbhDyYrdX/CwbaF+3aiP6zLHRDFJ/9knbc0UMjLea/QAz3I+H1vHeL
         GVww==
X-Forwarded-Encrypted: i=1; AJvYcCVxI6GfRbDYIRHuiJLgWCPne7e7Q6iZgXLJUOWSl3Ms5zhAnuzye4n4ZrcWYscEPe7h0HCKw/PClpbKkIKjpQXM2nM+GE/6Dqn608z0Q2vpOYsedUMML7N/Kkt4YdYC38b+ENA9BdLQkegg372XbsExdmipJwNOUHRgAceO2RIkG8rYUfk=
X-Gm-Message-State: AOJu0YxnMbX9xKF3tYUpPJcEc/plutMvZEpUpaXEh8yM8ywilrAyEMc9
	DfuuFGiF0sVdHpH70A75bBaUNpxkrI+NqSEasFIMco0BpReJMkKLYPZ8HB9AHus=
X-Google-Smtp-Source: AGHT+IHcGnKBnMT8d7rh2gKo/LhCbodyr0HL6t21lbnSOzsIBsDg9Jhv8uRbsuCx21k7kmdGmJTR+Q==
X-Received: by 2002:a25:c546:0:b0:dc6:ff66:87a8 with SMTP id v67-20020a25c546000000b00dc6ff6687a8mr6990780ybe.51.1709578928022;
        Mon, 04 Mar 2024 11:02:08 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id x3-20020a258583000000b00dcc234241c4sm2269850ybk.55.2024.03.04.11.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 11:02:07 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-60925d20af0so48776787b3.2;
        Mon, 04 Mar 2024 11:02:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXjRVp8g/Ijxu1BPEJDwJQ3cbUB3aYLsyV9MxLOI9BmmctTfDKF9ZmqKoiE0OMh6aeQ3a6huXZzdnfyO/rHXyM8U+oWPSi99eP733TcFHVv9Q3TJM119cgSXqOeq90csZWMyOCCeFlCNkja+/mQc8FfZbiLr20FRYuwescsv8gbO7k0+Ps=
X-Received: by 2002:a0d:d4c6:0:b0:609:3250:865 with SMTP id
 w189-20020a0dd4c6000000b0060932500865mr10236091ywd.7.1709578927167; Mon, 04
 Mar 2024 11:02:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301014203.2033844-1-chris.packham@alliedtelesis.co.nz>
 <20240301014203.2033844-5-chris.packham@alliedtelesis.co.nz>
 <ZeIdXIx5zYjKQiSO@smile.fi.intel.com> <CAMuHMdVJiWtB4MSGHXXz=OAEvu-+b9Xp-jQ_NXWck+hwKGK4TQ@mail.gmail.com>
 <CAHp75VesLCo72ftQ2BNEKSXwF9A2pe0Vbnuves2-L3ist_twNQ@mail.gmail.com>
 <CAMuHMdXjqVQeQF6TFr1nQmUCLrEbY1gq5OdCcz6T60W33QO2-Q@mail.gmail.com> <CAHp75Vfh_pv50Pk84JGz6qT=K9m3w=0_HDGX2WvqEN4Nm8fFDw@mail.gmail.com>
In-Reply-To: <CAHp75Vfh_pv50Pk84JGz6qT=K9m3w=0_HDGX2WvqEN4Nm8fFDw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 4 Mar 2024 20:01:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVuiYdjV46aS2fqPsFdW-vGK7zm_sY-LbWGYg4U0Ar5yQ@mail.gmail.com>
Message-ID: <CAMuHMdVuiYdjV46aS2fqPsFdW-vGK7zm_sY-LbWGYg4U0Ar5yQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] ARM: dts: marvell: Indicate USB activity on x530
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Chris Packham <chris.packham@alliedtelesis.co.nz>, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, 
	pavel@ucw.cz, lee@kernel.org, linux-leds@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Mon, Mar 4, 2024 at 7:17=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Mar 4, 2024 at 11:57=E2=80=AFAM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> > On Sun, Mar 3, 2024 at 9:43=E2=80=AFPM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
>
> ...
>
> > So IMHO it would be a bad idea to make the DP mandatory.
>
> But I'm not talking about making it mandatory, I'm talking about the

OK.

> DP to be used as DP when it _is_ present and wired. If current
> platform wants to use DP for something else, I'm pretty much worried
> that this is the right thing to do.

There is not much we can do about that. People can already model
such displays as individual LEDs, too.
And in some sense, the auxdisplay/linedisp driver for
"generic-gpio-7seg" imposes a policy, too.
What if people want to e.g. use 4 7-seg displays to show a continuously
running snake?

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

