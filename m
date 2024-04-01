Return-Path: <linux-kernel+bounces-126774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF28893C92
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9A9EB21EF6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E806D45BFF;
	Mon,  1 Apr 2024 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNIV7VkH"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCE2446A1;
	Mon,  1 Apr 2024 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711984195; cv=none; b=PpAymFNh1fE2WKKrLFw9YB5PkXD0u34FbcxsYeDpY6lQXYv9t9Y5Fk7Z1cjVSt7Uz5kBKxap0Sp8rjq1Q7Qe1JEc4Zqdma1pcHQ9Y1z866bZe9lFB0u994J6QZWo81tg1EH0j+w15ntYub6iirUK7UEqZVA5/Nro/q/sIdzQ2YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711984195; c=relaxed/simple;
	bh=L/8gZAolucuwwkQmFM70oji/BIRrViO0fJYD11aqWo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HObulN6eKw/2Y40vvXFheYD2YBY4XN2otFw7WCjdu93NOA8TFx0wTsPyCVenUU4KdipPQB276PEz6kAT3YA8t5ymonLG/WMIILFwCdp80chCEgMAAC/FmTeMmpfFvg883q5+yCvHPppBYsA86RApq3kM0N2vjs3uhQqkhymSfI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNIV7VkH; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34175878e30so3248032f8f.3;
        Mon, 01 Apr 2024 08:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711984192; x=1712588992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rD0kt0FvGy6RrN2V5n3OM/nHuzCqFzbTG5LJZtlBfSQ=;
        b=aNIV7VkHVszs1fsTiYW9ISxfs31okDMo2ObfU6c6jO0wZUPss8YfwCV2m1WJreibM0
         mRRFwUdldwYTfWyV/6Sl+eDnyOK+Ce4hOM29eQC4ZwsDEN629WbykJs4L1lvE7dX2xs6
         Ju/IoRlXOHUWWKpTXiazk/u46T0QVfr6kADC3jpS5MrP2hqh4lk3TTp6FCFg6wR3cyTC
         DCEDREMlO+5XX27GLG6TmFdGIpAORr1AKjFahHMGm6PoHEy3Ptv1kUcYLFzIekKFs6Uw
         VGmsJcj7dqJteNsGPKZxe+pdxi10HvgHPpleigRocpyEduNA0ioSQvC4Yf6yN/LoldoZ
         QawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711984192; x=1712588992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rD0kt0FvGy6RrN2V5n3OM/nHuzCqFzbTG5LJZtlBfSQ=;
        b=eXwg5npHGbzqZaOLOnWCHYSq58N6mYamdfTkI4xfF1Qu28gVKcMk6Pk/QM0D1GUlO9
         Akuhf7zJ43yPoPbexrKfd5HZt9BFsSSy9olkPrcDhQITW37FLhQk3kuUMpkH3w27MnFw
         6EW3WFw/y5FzRqEBdjTPpIzeCT7PWLrG2XRGT1gC6p9zbjcr6I3uSSe+X+Sji/2CtvLx
         ONQm0IBCk6TAjzHqVZLirtVn+cy34jgfwScx3zaHh6sNAenRqfXyG/HZ49NYLNqau1bN
         20yAqS5AQ+5zpZiLIeRjG1XCR6wl37j/+FXXsf4EMi8u2NNGYoQD4yLpsEGOl0r95Ds2
         zMuA==
X-Forwarded-Encrypted: i=1; AJvYcCVXUIZY9LVKGhNZSfIZ0KAHhOUKm1RwghBfhjs9n1HZsfP+eUqKZHex2tgAC8KIWSfg6q2MjjZykl1fexqPkWMwtn9ZKTdtTOPiGSrmFAeZaIfMDddK5mWefWCpqkCevu0nfPBg
X-Gm-Message-State: AOJu0Yy+3N7I1hzVNCyabJ06pQxDENb2G4ESim8zBGNIAJB9jZxKMjtA
	KOmg1u/T7mhmYgbuCl2uMm7Cb3Z4ItD+YTobuJNhqV7cfxUQXRyea1Xtl4KPG53qV88u50fRl3h
	zAdinpggauewRdvbTc4Pdj3KwFBs=
X-Google-Smtp-Source: AGHT+IEcCbfFXr199EiYnJw5HlOBHWx9BjzqxHRRFkUu/0fAKDBUv9lM2OvcK/+c4eD5ryX6cPZTpJiLniN6MRKODT4=
X-Received: by 2002:a5d:4523:0:b0:33e:4810:a052 with SMTP id
 j3-20020a5d4523000000b0033e4810a052mr7375023wra.70.1711984191568; Mon, 01 Apr
 2024 08:09:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZgrAM4NjZQWZ2Jq6@archie.me> <2024040143-shrimp-congress-8263@gregkh>
 <ZgrD-XtaG9D8jFnA@archie.me>
In-Reply-To: <ZgrD-XtaG9D8jFnA@archie.me>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 1 Apr 2024 08:09:40 -0700
Message-ID: <CAADnVQ+3bGQL9tpAR-up0_bPeF-+zW9xPp=Li1xUYf-2SaRuCw@mail.gmail.com>
Subject: Re: Fwd: stable kernels 6.6.23 and 6.1.83 fails to build: error:
 unknown type name 'u32'
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Greg KH <greg@kroah.com>, Viktor Malik <vmalik@redhat.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov <ast@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Natanael Copa <ncopa@alpinelinux.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Regressions <regressions@lists.linux.dev>, Linux Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 7:26=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com>=
 wrote:
>
> On Mon, Apr 01, 2024 at 04:15:25PM +0200, Greg KH wrote:
> > On Mon, Apr 01, 2024 at 09:09:55PM +0700, Bagas Sanjaya wrote:
> > > Hi,
> > >
> > > On Bugzilla, ncopa@alpinelinux.org reported resolve_btfids FTBFS regr=
ession
> > > on musl system [1]:
> > >
> > > > The latest releases fails to build with musl libc (Alpine Linux edg=
e and v3.19):
> > > >
> > > > ```
> > > > rm -f -f /home/ncopa/aports/main/linux-lts/src/build-lts.x86_64/too=
ls/bpf/resolve_btfids/libbpf/libbpf.a; ar rcs /home/ncopa/aports/main/linux=
-lts/src/build-lts.x86_64/tool
> > > > s/bpf/resolve_btfids/libbpf/libbpf.a /home/ncopa/aports/main/linux-=
lts/src/build-lts.x86_64/tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf-=
in.o
> > > > In file included from main.c:73:
> > > > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux=
/btf_ids.h:7:9: error: unknown type name 'u32'
> > > >     7 |         u32 cnt;
> > > >       |         ^~~
> > > > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux=
/btf_ids.h:8:9: error: unknown type name 'u32'
> > > >     8 |         u32 ids[];
> > > >       |         ^~~
> > > > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux=
/btf_ids.h:12:9: error: unknown type name 'u32'
> > > >    12 |         u32 cnt;
> > > >       |         ^~~
> > > > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux=
/btf_ids.h:13:9: error: unknown type name 'u32'
> > > >    13 |         u32 flags;
> > > >       |         ^~~
> > > > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux=
/btf_ids.h:15:17: error: unknown type name 'u32'
> > > >    15 |                 u32 id;
> > > >       |                 ^~~
> > > > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux=
/btf_ids.h:16:17: error: unknown type name 'u32'
> > > >    16 |                 u32 flags;
> > > >       |                 ^~~
> > > > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux=
/btf_ids.h:215:8: error: unknown type name 'u32'
> > > >   215 | extern u32 btf_tracing_ids[];
> > > >       |        ^~~
> > > > make[4]: *** [/home/ncopa/aports/main/linux-lts/src/linux-6.6/tools=
/build/Makefile.build:98: /home/ncopa/aports/main/linux-lts/src/build-lts.x=
86_64/tools/bpf/resolve_btfids
> > > > /main.o] Error 1
> > > > make[4]: *** Waiting for unfinished jobs....

> > > > make[3]: *** [Makefile:83: /home/ncopa/aports/main/linux-lts/src/bu=
ild-lts.x86_64/tools/bpf/resolve_btfids//resolve_btfids-in.o] Error 2
> > > > make[2]: *** [Makefile:76: bpf/resolve_btfids] Error 2
> > > > make[1]: *** [/home/ncopa/aports/main/linux-lts/src/linux-6.6/Makef=
ile:1354: tools/bpf/resolve_btfids] Error 2
> > > > make: *** [/home/ncopa/aports/main/linux-lts/src/linux-6.6/Makefile=
:234: __sub-make] Error 2
> > > > ```
> > >
> > > Bisection led to upstream commit 9707ac4fe2f5ba ("tools/resolve_btfid=
s:
> > > Refactor set sorting with types from btf_ids.h") as the culprit.
> > >
> > > See the report on Bugzilla for the full thread and proposed fix.
> >
> > Is the proposed fix a commit to backport?
>
> Nope (see below).

The fix is in bpf tree.
commit 62248b22d01e ("tools/resolve_btfids: fix build with musl libc")

