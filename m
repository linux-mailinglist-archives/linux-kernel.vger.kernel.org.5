Return-Path: <linux-kernel+bounces-51326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A338C8489D3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 01:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F451F2379F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 00:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EDF13FEA;
	Sun,  4 Feb 2024 00:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLpjouOr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5E612E68;
	Sun,  4 Feb 2024 00:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707004806; cv=none; b=qrF2GEOt2jH/CHWJhLh3+8p2fEnx8PPOCLfggh+Ul/784+ByoNa+Avt4zAsVDLAHYcP2DaOpMCiMdcWLzix86KUr4fX8R8C+EnIxcxpGXPwoJ0Op5hhoabJZToYat/6fqhyGW/GWE6LpzGXM4dG0w6MB1XXNmYOc5YYoO0EyFXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707004806; c=relaxed/simple;
	bh=tXr9ky8UtsOuDWckvd7CoxzFLX0vkSg6Y4sSD3JcVrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FyFWeLWuYJf5f7g7snLv68CjMv2DXStgpF8AgfQREqk9Y+CCQS1Tj/b805Haqc3NqmqDYW/iQCIA+uZYQ2ReTvabNIAKa3M2h6m+P4QoZay5HW97jCaprKBrbceKTsEzZs4VDiQKWqRqKBD+/30LfHx2/tiCAHV5Kp91i2fYeX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLpjouOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC054C433F1;
	Sun,  4 Feb 2024 00:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707004805;
	bh=tXr9ky8UtsOuDWckvd7CoxzFLX0vkSg6Y4sSD3JcVrU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KLpjouOrXumGOeC4QTLx7U1xOrLI6W3gNZ3NaeLsMfJuNDqjqoGMMUeJH0UgHqtoV
	 8BSiDQ9gJOsaEcom/m8AJi0RAbVrS74b2UX10gr4KGo0tqfT9393tNqej7PNEo66iD
	 BiT+I9JeR1iB6YH8yp+9SgIDUoT3CuRLfZy3xHjl2SjroKU1Hm4u5fS58By29tf6kQ
	 b7U610n0mriM2JJAbWdTXj/TxLtiqyKZbJkQVIkOeyEyUOcMKA1X6sd9w4Ok/VDEqN
	 EJUMNkhr7qa6ERzfWKwrS7EsosRhawQlIfADPXEhd/p+9/hU5M2wWSWXUh0JgvG189
	 VlyjDib2+FhWw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5114c05806eso118931e87.1;
        Sat, 03 Feb 2024 16:00:05 -0800 (PST)
X-Gm-Message-State: AOJu0YwUv6Eb7yz5GCwcczpRnbbCeeWeYQ8G6vYeRQA/H4Ea/QEx4edR
	4DTgvXSI/VqSkMeWCOE995xO02wNOACfotB8RlEwDhIuHmh6QKjiCWTz8ZJqkdDEBdfkaC8Hwp1
	fOa1+4JZFwTvHy1GzCKDicWTmIvU=
X-Google-Smtp-Source: AGHT+IHqiVN5Q4DhSFt8rmH6sT7k815HshkRQDhdl0bRdYRjEUXqkuORs07V3ctdN6n0kgvYbR0OT4sMi0OGvB7mJcA=
X-Received: by 2002:a05:6512:2384:b0:511:3489:507b with SMTP id
 c4-20020a056512238400b005113489507bmr5454053lfv.19.1707004804364; Sat, 03 Feb
 2024 16:00:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK7LNASGqfMkTuzP28qydpYCC0ct3cAgMpbPpmgHuQHZbtLhbA@mail.gmail.com>
 <CAHk-=whJKZNZWsa-VNDKafS_VfY4a5dAjG-r8BZgWk_a-xSepw@mail.gmail.com>
 <CAK7LNARzZ07TX2obHSpCgsC=FPTbLx5J+kPBFUECT+N7V42i5g@mail.gmail.com>
 <CAHk-=wg+3J8L4C7dcsZZNPEr3CJ49wKtJC0taVDBwGo9ZGot+Q@mail.gmail.com> <CAK7LNAQwcm9XfYAgcxOmGp9tvzj8kNbq8VUX09ZKscG1KEgE0g@mail.gmail.com>
In-Reply-To: <CAK7LNAQwcm9XfYAgcxOmGp9tvzj8kNbq8VUX09ZKscG1KEgE0g@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 4 Feb 2024 08:59:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQTbNv1C6sU2Z-gAofKZS=vPiGdV=V3Kd0iYFpR2qF4QA@mail.gmail.com>
Message-ID: <CAK7LNAQTbNv1C6sU2Z-gAofKZS=vPiGdV=V3Kd0iYFpR2qF4QA@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild fixes for v6.8-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Linus,

On Fri, Feb 2, 2024 at 11:15=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> Hello Linus,
>
>
> On Fri, Feb 2, 2024 at 9:43=E2=80=AFAM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, 1 Feb 2024 at 15:57, Masahiro Yamada <masahiroy@kernel.org> wro=
te:
> > >
> > > Is this your expectation?
> >
> > Commit 82175d1f9430 touched *only* the nested 'if' indentations.
> >
> > Your attached changed other indentations too, which I am not sure
> > makes any sense.
> >
> > But honestly, that whole make rule wrt whitespace makes no sense to
> > begin with, and I don't know why the conditional statement is so
> > special to begin with, and why GNU make would then suddenly start
> > messing with an insane rule with bad historical reasons.
>
>
> In my understanding, the GNU Make parser is confused with
> shell's 'else' keyword.
>
> So, GNU Make determined that 'else' indented with a tab
> is not the Make's conditional directive.
>
>
> >
> > End result: all of this just reinforces how bad the Make rules for
> > whitespace is, but I would suggest doing the *minimal* changes to make
> > it work.
> >
> > Which commit 82175d1f9430 did, but your attached patch then does not.
> >
> > IOW, if the whole crazy makefile whitespace change was only about
> > conditionals, let's keep all the stupid whitespace fixups as purely
> > about conditionals too.
> >
> >              Linus
> >
>
>
> I attached a new patch.
> I only changed the lines touch by 82175d1f9430


Is the second patch fine with you?

If so, will you pick it up, or do you want me
to include it in the next pull request?





--=20
Best Regards
Masahiro Yamada

