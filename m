Return-Path: <linux-kernel+bounces-74890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7CB85DF5E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CABEC28484E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B61E7C0BA;
	Wed, 21 Feb 2024 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlKRO4/t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0354C62;
	Wed, 21 Feb 2024 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525638; cv=none; b=Lh+M+k2hNUjA5RU2FhwSbdk8y5KQDwtiM3g6kf4waiInTEXH/9NcfMJ4oQOBHykQsly6K4cRi2oPUFWI2VonLI7Dn5Ud5Dhtr+lV9fpiN5gY8HTTBHrOu30kgfmd7vYaPeQcEyKIGp0WNqqlz5OSt2PNWWES8l9HbY34tYNPYhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525638; c=relaxed/simple;
	bh=jqfY/bXjQ6+7/Pv/b/zONWyvdkAuIKWkIxD2H+3zPwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sG4WBjSMCSWD6QjrIyVw72ttbFeAKj1Ns4noUchs4blr194ATlMYaMFA9Tb+aAD3+EVosZGmfrGV+daHejRf1Il8IdIlbLNCkWOROZD5ffhb9GiVykgbU3zFHBtM3VQOysdSyXFXiymO3KyZxOYDnCl+bdMGfJl47f5uhnNq7Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlKRO4/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391BFC433F1;
	Wed, 21 Feb 2024 14:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708525638;
	bh=jqfY/bXjQ6+7/Pv/b/zONWyvdkAuIKWkIxD2H+3zPwk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IlKRO4/tz2DIUo9D/Ve0z0iwzyPYRMxVE/2mqFqJtKFbFjk+w9U7pn8uYmBXEnrMT
	 zuPw8w8rqvd3DykvhfemioBQESVJFGtGJ5msabci4ZMAtaOM+eOBst4kGE926EmWl7
	 12TrmCfTQThg2Tfqiqa2q1znl5hJecb4mOOmha9qIhh2SkRB2mnD5PK+HmXH9ddIh9
	 qJHelqxecgUAqpEq8/eBw6Asy9J5cX/erUQn/DCOyHM1WbQfCD233MTWZFq4dGbf0/
	 CIBO1eV0sjcOqbch86ZHzvKhdCJprB1WP3auOw1VpBnEloFcZYqCQbymxYJEu0DEoq
	 frWsUpnbN4z9Q==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d180d6bd32so76296521fa.1;
        Wed, 21 Feb 2024 06:27:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV6gl8bqKPJS86HB7Mxs0IAEiMhCi2lCG1vxRyrJwUhL9BUrODamkqVd88YXanZU6pkbaa+9pTQZ0NhLh5y5IJnTrJ+rieBMexwMA+cF4oJJt+3z37d68iOHY1qHTCRz6MfM9TzkDHCTA==
X-Gm-Message-State: AOJu0YxduhNWcR8W+TBYfus5MYWTs8zIMpgDuoZsujysno1jkaaBm9I6
	JDs8RMfaxqI5LKrtHrTZaV1SGEwPFlHaWiuWiiAf6aXhU46VJ/SiKW1mRNCShp18m6zR8JgYRK2
	m+D49XGRXd5mXeu7jyWTkuON5oA==
X-Google-Smtp-Source: AGHT+IEkkBZ+CJ4wHV1j1+uMZjnmhfwLLMpaC2D4+NoL2Pue13rh+y7OEdfITs5OjTiQCWgg5vBr6ZsQVriymYYNmdI=
X-Received: by 2002:a2e:3a10:0:b0:2d2:384e:4918 with SMTP id
 h16-20020a2e3a10000000b002d2384e4918mr6543075lja.53.1708525636437; Wed, 21
 Feb 2024 06:27:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221092826.748e70c4@canb.auug.org.au> <CAL_JsqKw9OXb=aOMni1qprzeWDBgmjdJef-6VAjwx0R--D+URw@mail.gmail.com>
 <ac9ddf79-6bc9-4daf-a271-82f8b3bca988@app.fastmail.com>
In-Reply-To: <ac9ddf79-6bc9-4daf-a271-82f8b3bca988@app.fastmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 21 Feb 2024 07:27:04 -0700
X-Gmail-Original-Message-ID: <CAL_Jsq+L7uPimQfATs14EWCbqRO1vxDUmPie7=cChTLCf2od2g@mail.gmail.com>
Message-ID: <CAL_Jsq+L7uPimQfATs14EWCbqRO1vxDUmPie7=cChTLCf2od2g@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the arm-soc-fixes tree
To: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Olof Johansson <olof@lixom.net>, ARM <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-next <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 7:00=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Wed, Feb 21, 2024, at 14:53, Rob Herring wrote:
> > On Tue, Feb 20, 2024 at 3:28=E2=80=AFPM Stephen Rothwell <sfr@canb.auug=
org.au> wrote:
> >> arch/arm/boot/dts/renesas/r8a7793-gose.dtb: Warning (interrupt_map): F=
ailed prerequisite 'interrupt_provider'
> >>
> >> Introduced/exposed by commit
> >>
> >>   78b6f8e7379b ("dtc: Enable dtc interrupt_provider check")
> >>
> >> I guess you missed some :-(
> >
> > No, Geert separately posted fixes for already.
>
> I did make the mistake of applying the final patch "dtc:
> Enable dtc interrupt_provider check" to the arm/fixes branch
> for 6.8 along with the other fixes.
>
> Clearly that should be separate and only go into mainline
> after there are no more regressions, but now I'm unsure
> about the other patches -- did you intend the dts fixes
> for 6.8 or for the coming merge window?

Either is fine with me. My intent was the whole series plus the
Renesas fix to be applied together. Anything new that crops up we can
fix on top.

Yes, there are lots of powerpc warnings, but those are on top of lots
of existing powerpc warnings no one seems to care about. I suppose we
can turn them off for powerpc if desired.

Rob

