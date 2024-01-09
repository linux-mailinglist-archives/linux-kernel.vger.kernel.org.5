Return-Path: <linux-kernel+bounces-20984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CC182881D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62F7BB22900
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EAE39AF3;
	Tue,  9 Jan 2024 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W042skrn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF7F39AC8;
	Tue,  9 Jan 2024 14:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C428C433C7;
	Tue,  9 Jan 2024 14:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704810596;
	bh=U6fepFRRvL8pyajDsndR311mQAfn06XfFmE0bSqyzjM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W042skrnsyc1N0J25LZYL32M1jjsiKIE+6UPnnpjuwF0c+VtN6kniXTuMSYTOmt0+
	 l9lJptOWwdPoiZY+nztUszy86kdcOdaq9umFxPq3ODVUiISYIz5c5yPIq4IssWYqJi
	 M9txjVxqZrQXb4wr+1h2vzOCRsym7KUzXq65hvQJBevBoPWpdlye0auKzR6lcUdqIG
	 SgQFk9d/3X0K4HU8ZtW6/VDCiSYbzOJ4IUHJZ6syKz9qWm8LqfeW7NmpfLV6uoKYXZ
	 B3zXXx2BTN/gn8I9RKywwC2wOrznTkytoX5JY8cwkUkCPmQGmVNp1geUlTsC3NJ7t1
	 91KxPp138d0Dg==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-20451ecbb80so1576326fac.2;
        Tue, 09 Jan 2024 06:29:56 -0800 (PST)
X-Gm-Message-State: AOJu0Yw3RxRTgmHeaedDXVru2VBHuHUnzGXvSyviJ713mpBCGzPkLHof
	U5w5eaqB4lU1fhZ4bZWtuqgdLAwlU5FQPwB02Bc=
X-Google-Smtp-Source: AGHT+IE2kPKlkSmjvrdG5oVLVaO8mGM7P3rXsgoz85yX/ibVxAkTp5wT4aGl0DG86kFSz4Hf4YMgQsh3x3PGci9WZo4=
X-Received: by 2002:a05:6871:5226:b0:204:6141:746a with SMTP id
 ht38-20020a056871522600b002046141746amr5940663oac.2.1704810595664; Tue, 09
 Jan 2024 06:29:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231230135200.1058873-1-masahiroy@kernel.org>
 <CAK7LNATLZ2rt8fFZYu1KX4HW5s0EjNbDEXp8csCPGtA5a-6qPw@mail.gmail.com> <ZZ1I95oHTayfygue@reykjavik.ads.avm.de>
In-Reply-To: <ZZ1I95oHTayfygue@reykjavik.ads.avm.de>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 9 Jan 2024 23:29:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQZmk__Amj2OK3ZxYZirjnc4zHnA596TYCso95un3qM1w@mail.gmail.com>
Message-ID: <CAK7LNAQZmk__Amj2OK3ZxYZirjnc4zHnA596TYCso95un3qM1w@mail.gmail.com>
Subject: Re: [PATCH 1/5] kbuild: deb-pkg: move 'make headers' to build-arch
To: Nicolas Schier <n.schier@avm.de>
Cc: linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	linux-kernel@vger.kernel.org, Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 10:24=E2=80=AFPM Nicolas Schier <n.schier@avm.de> wr=
ote:
>
> On Tue, Jan 09, 2024 at 01:38:07PM +0900, Masahiro Yamada wrote:
> > On Sat, Dec 30, 2023 at 10:52=E2=80=AFPM Masahiro Yamada <masahiroy@ker=
nel.org> wrote:
> > >
> > > Strictly speaking, 'make headers' should be a part of build-arch
> > > instead of binary-arch.
> > >
> > > 'make headers' constructs read-to-copy UAPI headers in the kernel
>
> s/read/ready/ ?

Yes, thanks for catching it.




> I'm wondering if we might want to change the headers target in top-level
> Makefile to not bail-out for ARCH=3Dum but only show a warning that there
> is nothing to export.


Yes, this is another way of fixing it, but
I do not even want to show a warning.

Having 'make ARCH=3Dum headers' succeed silently
is another way.

I just stayed on a safer side.



--=20
Best Regards
Masahiro Yamada

