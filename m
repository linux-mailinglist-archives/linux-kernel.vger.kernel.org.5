Return-Path: <linux-kernel+bounces-31868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6A38335AD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 19:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D2F283809
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 18:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86E0125CB;
	Sat, 20 Jan 2024 18:22:54 +0000 (UTC)
Received: from herc.mirbsd.org (bonn.mirbsd.org [217.91.129.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702DC11C85;
	Sat, 20 Jan 2024 18:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.91.129.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705774974; cv=none; b=Y350K0/a+cym9Ax11qbkijb9QiPnZFz2YRL/v6D/jbC0N5XR6NMp0XQMtdHmlb9maW35eoCrwgvexjd5ZS0HdQ0075PimIM182+QBw4MuSOl6MZ3u36sK5Rhzhxre7CFzK/hXNVB5UhqgsnfzuC7lBvDbrwoXjUijScuHZLERNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705774974; c=relaxed/simple;
	bh=BvXvGUMu493sjcMKrhy1G9t1wFaTLlo4v1EURwmupMg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tHWVUW3ruduqynsG55JITb0qqbX58J6Osg8CaDiYIDJZJT62bYbYf9o1uVx007wQXgYMJpZp8+GHgDoy+WcpL5mY11YhxIl8zwz6qKiOBGm2nAN7V+iQRuRK2FN1N8wTfXEuLzwf6q7Irw0bxQ2qcd+yzmJbbT+vNK5iipC/QQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; arc=none smtp.client-ip=217.91.129.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Received: from herc.mirbsd.org (tg@herc.mirbsd.org [192.168.0.82])
	by herc.mirbsd.org (8.14.9/8.14.5) with ESMTP id 40KILiPg004999
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 20 Jan 2024 18:21:51 GMT
Date: Sat, 20 Jan 2024 18:21:43 +0000 (UTC)
From: Thorsten Glaser <tg@debian.org>
X-X-Sender: tg@herc.mirbsd.org
To: Linus Torvalds <torvalds@linuxfoundation.org>
cc: "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
        x86@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        linux-toolchains@vger.kernel.org, jpoimboe@redhat.com,
        alexei.starovoitov@gmail.com, mhiramat@kernel.org
Subject: disassemblers (was Re: [PATCH 1/2] x86: Remove dynamic NOP selection)
In-Reply-To: <Pine.BSM.4.64L.2401201711130.29203@herc.mirbsd.org>
Message-ID: <Pine.BSM.4.64L.2401201816560.29203@herc.mirbsd.org>
References: <20210312113253.305040674@infradead.org> <20210312115749.065275711@infradead.org>
 <Pine.BSM.4.64L.2401200654480.19429@herc.mirbsd.org>
 <CE53F232-3D2D-4910-94B4-A4304F5990C7@zytor.com>
 <CAHk-=whtFk2DoO8WhtmsbU9nGXUd8sKShV1Dk71krFLBjPUSeg@mail.gmail.com>
 <Pine.BSM.4.64L.2401201711130.29203@herc.mirbsd.org>
Content-Language: de-Zsym-DE-1901-u-em-text-rg-denw-tz-utc, en-Zsym-GB-u-cu-eur-em-text-fw-mon-hc-h23-ms-metric-mu-celsius-rg-denw-tz-utc-va-posix
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Dixi quod=E2=80=A6

>>Is there some sane tool that just does the sane thing and shows this as
>
>The only other disassemblers I know don=E2=80=99t know about ELF objects
>at all, I=E2=80=99m sorry to say.

I have searched through my bookmarks and found =E2=80=9CAgner Fog=E2=80=99s=
 objconv=E2=80=9D
https://www.agner.org/optimize/#objconv which I had not yet tried as
it comes with a .exe but apparently, the included GPL source builds
on GNU/Linux (and BSD and MacOSX) as well.

Usage is: ./objconv -fgasm filename.o

This will write filename.asm =E2=9A=A0 into the same directory as the .o fi=
le,
surprisingly.

It works for i386 and amd64 but not x32 (aka amd64ilp32) which is
mis-disassembled as if it were i386. Sample output fragment:

tsv_header:
        sub     rsp, 8                                  # 00E3 _ 48: 83. EC=
, 08
        lea     rdi, [.LC7+rip]                         # 00E7 _ 48: 8D. 3D=
, 00000000(rel)
        call    puts@PLT                                # 00EE _ E8, 000000=
00(PLT r)
        add     rsp, 8                                  # 00F3 _ 48: 83. C4=
, 08
        ret                                             # 00F7 _ C3

Bit irritating is it uses decimal numbers=E2=80=A6

        sub     rsp, 232                                # 0102 _ 48: 81. EC=
, 000000E8

=E2=80=A6 and the way the input is separated with colon, period and comma,
but it=E2=80=99s legible enough.

Credits to Peter Cordes for the discovery.

bye,
//mirabilos
--=20
When he found out that the m68k port was in a pretty bad shape, he did
not, like many before him, shrug and move on; instead, he took it upon
himself to start compiling things, just so he could compile his shell.
How's that for dedication. -- Wouter, about my Debian/m68k revival

