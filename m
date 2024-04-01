Return-Path: <linux-kernel+bounces-126801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4288D893CDA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5151B223C4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325C946551;
	Mon,  1 Apr 2024 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alpinelinux.org header.i=@alpinelinux.org header.b="sPJRUoCt"
Received: from gbr-app-1.alpinelinux.org (gbr-app-1.alpinelinux.org [213.219.36.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734104596E;
	Mon,  1 Apr 2024 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.219.36.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711985260; cv=none; b=TEvnIDiqPCo900HS2wgTMmPfyRorLVIOxdG7xoCiEVuD7XTluQIRutddKzcgTkJlmfHSpN2gr5s6YG/B4yrxBpLDBTZhXRhImfM+5PMblBUYoEhsTWqk39P80nVpyDudALylqwxno5Gb0WdKxTJNo7oFEoepaok6V27a65Ef/Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711985260; c=relaxed/simple;
	bh=IXumSUCWEcxOebRu6c1bG6LiQip87HwwnASHg6ZJEjs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rr16GrepieDZWKFbqK8bRlizvw05W3icoTXOp10RXJpNgre0Z1f6bovmhzp/pqj/eZpJJWFE69MWW71gixlSqh3ehYlLhcKMbYTP88xNDhbeBrfXEqKt8eHgqBcw7xaEo9qCv0lkEAypmxF/pi3Ykrb88gwrkQ5MAV3+u0AciY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpinelinux.org; spf=pass smtp.mailfrom=alpinelinux.org; dkim=pass (1024-bit key) header.d=alpinelinux.org header.i=@alpinelinux.org header.b=sPJRUoCt; arc=none smtp.client-ip=213.219.36.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpinelinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpinelinux.org
Received: from ncopa-desktop.lan (ti0056a400-4037.bb.online.no [85.167.238.210])
	(Authenticated sender: ncopa@alpinelinux.org)
	by gbr-app-1.alpinelinux.org (Postfix) with ESMTPSA id 9A4EA2258D6;
	Mon,  1 Apr 2024 15:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alpinelinux.org;
	s=smtp; t=1711985251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EbZD58z1sAwDWkRRamsCF5H1xsswpcXAj/U5NCBJMJk=;
	b=sPJRUoCtJxBkzo1TMAIXuyD7WhrFnxik4mBvsq7xHxnEIiHz81kZ2yh3t/HyQh8SQXeBMg
	3zOZY8RIaaye90ogxhfcvrwUDMrZABv2/v9fTzSly/NC2/8yLSMqaHJwWns3/Rb27Ms7IO
	rEoiYark49mI6qtPcbqilt1VFKXYQD0=
Date: Mon, 1 Apr 2024 17:27:27 +0200
From: Natanael Copa <ncopa@alpinelinux.org>
To: Greg Thelen <gthelen@google.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Greg KH <greg@kroah.com>, Viktor
 Malik <vmalik@redhat.com>, Andrii Nakryiko <andrii@kernel.org>, Daniel Xu
 <dxu@dxuuu.xyz>, Alexei Starovoitov <ast@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Regressions
 <regressions@lists.linux.dev>, Linux Stable <stable@vger.kernel.org>
Subject: Re: stable kernels 6.6.23 and 6.1.83 fails to build: error: unknown
 type name 'u32'
Message-ID: <20240401172727.08b65053@ncopa-desktop.lan>
In-Reply-To: <CAHH2K0apZttqAhMZ9H_fygUC_Oa9G5-4XYmmqZu-EWNOuqc4Xg@mail.gmail.com>
References: <ZgrAM4NjZQWZ2Jq6@archie.me>
	<2024040143-shrimp-congress-8263@gregkh>
	<ZgrD-XtaG9D8jFnA@archie.me>
	<CAHH2K0apZttqAhMZ9H_fygUC_Oa9G5-4XYmmqZu-EWNOuqc4Xg@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-alpine-linux-musl)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Apr 2024 07:36:08 -0700
Greg Thelen <gthelen@google.com> wrote:

> On Mon, Apr 1, 2024 at 7:26*AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> >
> > On Mon, Apr 01, 2024 at 04:15:25PM +0200, Greg KH wrote: =20
> > > On Mon, Apr 01, 2024 at 09:09:55PM +0700, Bagas Sanjaya wrote: =20
> > > > Hi,
> > > >
> > > > On Bugzilla, ncopa@alpinelinux.org reported resolve_btfids FTBFS re=
gression
> > > > on musl system [1]:
> > > > =20
> > > > > The latest releases fails to build with musl libc (Alpine Linux e=
dge and v3.19):
> > > > >
> > > > > ```
> > > > > rm -f -f /home/ncopa/aports/main/linux-lts/src/build-lts.x86_64/t=
ools/bpf/resolve_btfids/libbpf/libbpf.a; ar rcs /home/ncopa/aports/main/lin=
ux-lts/src/build-lts.x86_64/tool
> > > > > s/bpf/resolve_btfids/libbpf/libbpf.a /home/ncopa/aports/main/linu=
x-lts/src/build-lts.x86_64/tools/bpf/resolve_btfids/libbpf/staticobjs/libbp=
f-in.o
> > > > > In file included from main.c:73:
> > > > > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/lin=
ux/btf_ids.h:7:9: error: unknown type name 'u32'
> > > > >     7 |         u32 cnt;
> > > > >       |         ^~~
> > > > > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/lin=
ux/btf_ids.h:8:9: error: unknown type name 'u32'
> > > > >     8 |         u32 ids[];
> > > > >       |         ^~~
> > > > > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/lin=
ux/btf_ids.h:12:9: error: unknown type name 'u32'
> > > > >    12 |         u32 cnt;
> > > > >       |         ^~~
> > > > > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/lin=
ux/btf_ids.h:13:9: error: unknown type name 'u32'
> > > > >    13 |         u32 flags;
> > > > >       |         ^~~
> > > > > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/lin=
ux/btf_ids.h:15:17: error: unknown type name 'u32'
> > > > >    15 |                 u32 id;
> > > > >       |                 ^~~
> > > > > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/lin=
ux/btf_ids.h:16:17: error: unknown type name 'u32'
> > > > >    16 |                 u32 flags;
> > > > >       |                 ^~~
> > > > > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/lin=
ux/btf_ids.h:215:8: error: unknown type name 'u32'
> > > > >   215 | extern u32 btf_tracing_ids[];
> > > > >       |        ^~~
> > > > > make[4]: *** [/home/ncopa/aports/main/linux-lts/src/linux-6.6/too=
ls/build/Makefile.build:98: /home/ncopa/aports/main/linux-lts/src/build-lts=
x86_64/tools/bpf/resolve_btfids
> > > > > /main.o] Error 1
> > > > > make[4]: *** Waiting for unfinished jobs....
> > > > > make[3]: *** [Makefile:83: /home/ncopa/aports/main/linux-lts/src/=
build-lts.x86_64/tools/bpf/resolve_btfids//resolve_btfids-in.o] Error 2
> > > > > make[2]: *** [Makefile:76: bpf/resolve_btfids] Error 2
> > > > > make[1]: *** [/home/ncopa/aports/main/linux-lts/src/linux-6.6/Mak=
efile:1354: tools/bpf/resolve_btfids] Error 2
> > > > > make: *** [/home/ncopa/aports/main/linux-lts/src/linux-6.6/Makefi=
le:234: __sub-make] Error 2
> > > > > ``` =20
> > > >
> > > > Bisection led to upstream commit 9707ac4fe2f5ba ("tools/resolve_btf=
ids:
> > > > Refactor set sorting with types from btf_ids.h") as the culprit.
> > > >
> > > > See the report on Bugzilla for the full thread and proposed fix. =20
> > >
> > > Is the proposed fix a commit to backport? =20
> >
> > Nope (see below).
> > =20
> > >
> > > Digging through entries is not the easiest way to get things resolved=
..
> > > =20
> >
> > The reporter posted the fix as bug comment [1] instead (hint: include
> > linux/types.h) but not submitted it to mailing lists first.
> >
> > Thanks.
> >
> > [1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D218647#c2
> >
> > --
> > An old man doll... just what I always wanted! - Clara =20
>=20
> Does https://lore.kernel.org/all/20240328110103.28734-1-ncopa@alpinelinux=
org/
> resolve this? It's staged in the bpf tree. Though I'm not sure when
> it'll be merged upstream.

Yes. this is the fix

-nc

