Return-Path: <linux-kernel+bounces-13103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 350A281FFB9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 14:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9BC9B22352
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 13:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B3D11715;
	Fri, 29 Dec 2023 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJj+1esU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1CD11702;
	Fri, 29 Dec 2023 13:42:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E2BC433C7;
	Fri, 29 Dec 2023 13:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703857352;
	bh=UCDeRZ0409HKlYsThc9AhumuUp/zCGyhIYwYKwqHDqI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PJj+1esUzdVCZjnqPkNvukhFpfPRZWhKFHdglnYazV/jwbcHsZ5bD1GxlWtjGUCn8
	 5O05da+ev+HA4U8Y1kcu5uQ53muZYNFhgYAhKHhdyqASjRjHMUfP4jSTIWf+yvxd47
	 efMrJ/AnnchsK6HDcS8cG4LEL8oLI8XyxqihjLp6iLi5FSWg3Y/wYFAaoNzliBoJ6N
	 6A5Z/w9dDnjEIaQ8o8PC0HNCFyaaVVRqoqKn66H4nhnPbeiMm4lAagjzEFtmRgiQ68
	 gpSZIdRMUcLsGyvBdoMbRkSKvxEni3RDV2f5jw7uQcmpFRtWiRk9ixY22SKYf8l/Uy
	 7FgzXQlDQLeYA==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6dc07ce2a30so1174529a34.0;
        Fri, 29 Dec 2023 05:42:32 -0800 (PST)
X-Gm-Message-State: AOJu0YxbIVNigI8jpNKy/1/ESailsJRScsm2m0b1wYdAlUC10l8yeLfe
	Jy33iWSLublMSqA4YiSmcOUVqt3KatPkLAMUBSs=
X-Google-Smtp-Source: AGHT+IEfa/8c+zCJ2ieJAUQOX1Bw4b6TheF/gueMgv5HSqCz90kd/M4c0z1uRxzM5anOE68ebgU6UY8qDkEgsnJnQQE=
X-Received: by 2002:a05:6871:2306:b0:203:7035:8a83 with SMTP id
 sf6-20020a056871230600b0020370358a83mr10441046oab.85.1703857351471; Fri, 29
 Dec 2023 05:42:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122034753.1446513-1-senozhatsky@chromium.org>
 <20231128053443.GA6525@google.com> <CAK7LNAT_Z4TeNzngMskEoNdSTWUH5gGzYm5MfO6C_H8rFcF6ng@mail.gmail.com>
 <20231129041307.GB6525@google.com> <CAK7LNAS8q9eDerwVRbPbqd+AKjNVkEKLOW+NAKaD4duP-gViqw@mail.gmail.com>
 <20231222025701.GA3568309@google.com>
In-Reply-To: <20231222025701.GA3568309@google.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 29 Dec 2023 22:41:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNARa3WrRp5vmX5M3tTkS-jdno-vFe8WLPXjF8+hHxVUmFA@mail.gmail.com>
Message-ID: <CAK7LNARa3WrRp5vmX5M3tTkS-jdno-vFe8WLPXjF8+hHxVUmFA@mail.gmail.com>
Subject: Re: [PATCH] kconfig: WERROR unmet symbol dependency
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Patrick Georgi <pgeorgi@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stefan Reinauer <reinauer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 11:57=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (23/12/01 00:42), Masahiro Yamada wrote:
> > On Wed, Nov 29, 2023 at 1:13=E2=80=AFPM Sergey Senozhatsky
> > <senozhatsky@chromium.org> wrote:
> > >
> > > On (23/11/28 23:19), Masahiro Yamada wrote:
> > >
> > > [..]
> > >
> > > > KCONFIG_WERROR is meant to turn all warnings
> > > > to errors.
> > > > I do not see getenv("KCONFIG_WERROR")
> > > > sprinkled everywhere in Kconfig.
> > > > One more thing, you cannot directly exit(1)
> > > > from sym_calc_value().
> > >
> > > We do exit(1) for KCONFIG_WARN_UNKNOWN_SYMBOLS in conf_read().
> > >
> > > I can introduce two new helpers that will tell if confdata.c and symb=
ol.c
> > > triggered any warnings and if KCONFIG_WERROR is set. And then differe=
nt
> > > code paths can call them and handle exit gracefully, depending on the
> > > context (ncurses, menu, etc.).
> > >
> > > Something like this
> >
> >
> > I do not want to patch warnings one by one.
> >
> >
> > I will take some time to think about it.
>
> Gentle ping on this.
>
> We are not concerned with every possible warning at the moment, however,
> we do want the critical ones from CI and (semi)automated continuous uprev
> PoV to be covered by WERROR. We do experience real life problems with
> "missing direct dependency" not being a terminal condition under WERROR.


Applied to linux-kbuild.
Thanks.

--=20
Best Regards
Masahiro Yamada

