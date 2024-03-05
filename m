Return-Path: <linux-kernel+bounces-92708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2179E8724B5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B42B91F21CFF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF20715E8C;
	Tue,  5 Mar 2024 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTdGIwMi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62701758E;
	Tue,  5 Mar 2024 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709657234; cv=none; b=pnjLyKA79WwXLC9w9hvGCzORMLEjRml0IuM0Bgo1dKPfmSF7Y4BziyFIs0xhY0SW1FJBUsSAjiRR0j72cxXd7ryrND0pNNZsXQfbA904xzYUZAlFfmeJo/yu7DP/GNhZ2+347naVMgvoY6tDNOAQ9d+VEdUOnuqnsM2/oZx0aJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709657234; c=relaxed/simple;
	bh=EXVwxpPl+Z63Fl/T1KcBY7+ZfPzBuKR1uyOOockcU/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ok9lsb1P0ALePYEeb3fXcHeYJuO/SwChg31sXQw9RHpNY8zJApIYEtzj8iAVLnOhpFcLJpcSpph39T5BmvQPotvv/TsQlS6TeaVHopdI7Ac79FUr5fRs2q75xRUNg0zLg64EtUAHdjHAj9XwXqcIadDN/wf0b0sKrJkb1XpddQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTdGIwMi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEC8C433F1;
	Tue,  5 Mar 2024 16:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709657234;
	bh=EXVwxpPl+Z63Fl/T1KcBY7+ZfPzBuKR1uyOOockcU/0=;
	h=References:In-Reply-To:From:Date:Subject:To:From;
	b=sTdGIwMigGzH+82mOPA1TXcfWMquQqrk6EdssyUgbKLtkzSUAB1wwh3wIIE7y0QWr
	 hAUWtWBNlB0zeI7YeBh1oQSPGyOKz9prgJ+IM4S2WcUIlElRVTrNaR8h6qxDHvxTUn
	 Eotx+4eROjBU7BlBK//m6f/EQ5C1MYu95fpWsxIVkjPVct82lc+wOaF4vjRHsA5es+
	 iMWakKnQnEMEjE0fKsiV7/TI8nxFFOxMZmqFcsqC168asT7/KDdg8pTB8PLpgzQh/0
	 836Yf/mzpN3p4C1gTc/dUuYNMyU5j599Z7uvAQTI3V2SKUm2rfN4aOHYAn4BmZ1qYJ
	 nolS17QpZ9tZQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5133d26632fso3938248e87.2;
        Tue, 05 Mar 2024 08:47:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUagzMoapbUAyrsm6sTMya4FCxQAodM3PiGwd26YEj4I7lXRr87pTq7+EHKOp5fRx7w7qXsdyWTNQtXLM721CcIzIA/2yPKESu15UJNkvDA1zWEpXvAcDEjdwmyGbssU8yZOq1nefzmSR0D
X-Gm-Message-State: AOJu0Yz+NMAJkLcMdwpsaYb8J7HhI8qS22P/rUW+HxIGrMCKyGdreqY3
	S9iX7h6mmQpgJhXE8QA8XFytoA9blxbd82NwXMRwubhRz5BKafMLRXqQ/PK5eoHDb0CudKEDx44
	ZfSN7+HH5z8hZba5Cez+X5rYGQhI=
X-Google-Smtp-Source: AGHT+IHdxwn1uTZi1LjVmF4V08elygKJS/Q47kVQmagG9JHZzFbWU5HNYH6nKbYqwGUOLyx8Br04FaEm8EPONy0dz0U=
X-Received: by 2002:ac2:57c2:0:b0:512:c985:4890 with SMTP id
 k2-20020ac257c2000000b00512c9854890mr1477560lfo.67.1709657232745; Tue, 05 Mar
 2024 08:47:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222051621.GH11472@google.com> <20240228045652.GH11972@google.com>
 <CAK7LNAQ8OyNMeGzVoTRg-sHDZ4YK0EKY_eEWNepekaibO_ZKwg@mail.gmail.com>
 <20240229021010.GM11972@google.com> <CAK7LNASujf8m4PpMyoCC1cTN_YGeG1HVaOR+3pZx5=3OJp=85A@mail.gmail.com>
 <20240229034739.GN11972@google.com> <CAK7LNAS-mOxY884pLEMwWaX+wgzXdc6+=vqN=wfHBekuKL5ryA@mail.gmail.com>
 <20240301043316.GO11972@google.com> <ZeG2PRYmdO0r44kS@buildd.core.avm.de>
 <20240301142844.GP11972@google.com> <ZeVtIwua9T5prwUl@buildd.core.avm.de>
In-Reply-To: <ZeVtIwua9T5prwUl@buildd.core.avm.de>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 6 Mar 2024 01:46:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT7+GbXaF6MW18YvEeF4ZZLrn6sOutHPNxcoL_RD1Utyw@mail.gmail.com>
Message-ID: <CAK7LNAT7+GbXaF6MW18YvEeF4ZZLrn6sOutHPNxcoL_RD1Utyw@mail.gmail.com>
Subject: Re: [PATCHv2] kconfig: add some Kconfig env variables to make help
To: Sergey Senozhatsky <senozhatsky@chromium.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 3:41=E2=80=AFPM Nicolas Schier <n.schier@avm.de> wro=
te:
>
> On Fri, Mar 01, 2024 at 11:28:44PM +0900, Sergey Senozhatsky wrote:
> > On (24/03/01 12:04), Nicolas Schier wrote:
> > > Perhaps it might be a compromise to let 'make help' point to the
> > > kbuild/kconfig documentation?
> >
> > Yes, I was thinking the same. A one-liner description per-env var
> > and point to documentation if one-liner is not enough
> >
> >       KCONFIG_BARREL_ROLL     - kconfig does a barrel roll
> >       KCONFIG_FOO_BAR         - kconfig does foo and then bar (see
> >       documentation for details)
>
> No, I thought about leaving out any concrete examples but just adding a
> sentence like:
>
>   kconfig and kbuild allow tuning and checks by settings various
>   environment variables, cp. Documentation/kbuild/ for details.
>
> Then there is no need to re-document each variable in 'make help' but
> those who are new are explicitly pointed to the maintained
> documentation.


That can be a compromised way, but it sounds silly...

Is it helpful at least for people who know 'make help'
but do not know Documentation/kbuild/?



--=20
Best Regards
Masahiro Yamada

