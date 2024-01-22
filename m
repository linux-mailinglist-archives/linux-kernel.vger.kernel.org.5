Return-Path: <linux-kernel+bounces-32268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEE383593C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD7621F21C73
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39037EBB;
	Mon, 22 Jan 2024 02:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Qe+iX8JU"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0C7A2A;
	Mon, 22 Jan 2024 02:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705889108; cv=none; b=RoNT+tLeuW6MZa8ZhIEuvPByJ1PxN8KTeZWN6OM36LZAer6S9cazay49vVO4/ciZsNMvRCp9ZaTa9fYUGrsEtYKeg2TJz854UMIosqSwDcScfdtN6WAgP/eUvB3lOwHoznXeGJ70eXdHNPql5RSvhq0lkgfdyy3oFwacVaUxuc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705889108; c=relaxed/simple;
	bh=MBeI8qR+plUgYcOOi7evJyai63+yRXkp1o/8PBJugnE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=kuf5qWqpsSXacL9ywrYwbN8LGSyCIsRGgeN2ThUYXedlIR0yGFXGrcoebg6GWiJWL5rhArRH838CYFGlSQsFSk3r0M+llK5/Vtt+3Guu39nrw2M7En364WTb6P7DVYP+b/Y5Yb3q30DyORDedC/rXCtz+UcuUDeMqnj1uESY4AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Qe+iX8JU; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 40M24iJx2289796
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 21 Jan 2024 18:04:44 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 40M24iJx2289796
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1705889085;
	bh=MBeI8qR+plUgYcOOi7evJyai63+yRXkp1o/8PBJugnE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Qe+iX8JUPN8aKdw+N6qIhojZMwylgtzACi5j2EQLmeu1d6WmqQ/354Rkrq6orwdNt
	 t6E6mqqrjcYblA1wrrGxORhQgpvzdXTI/dQa+t6I6VqXUNsU/qvaav7OFD8cs0+mpP
	 bWqjLLZufwJfl31en+tqIIQ2kDWjXl7UTpSSEXXF5xc/fmjFdM5MmCAaOYmDQnlJl8
	 6Xt7sd94Wm9kPWlKGZEdlp5MWphWV8iNBt+8p5PF19vPNeIv7ZfC24I70zmFAf9WF0
	 AZOx+DFGgJeSFDrU2k8xYpikcCrXvfMZUzS9eqx9DUGB7qsLnm05zOEAiu9apwFd2s
	 dF8cEddBKFrUA==
Date: Sun, 21 Jan 2024 18:04:42 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Thorsten Glaser <tg@debian.org>, Steven Rostedt <rostedt@goodmis.org>
CC: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        torvalds@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-toolchains@vger.kernel.org, jpoimboe@redhat.com,
        alexei.starovoitov@gmail.com, mhiramat@kernel.org
Subject: Re: [PATCH 1/2] x86: Remove dynamic NOP selection
User-Agent: K-9 Mail for Android
In-Reply-To: <Pine.BSM.4.64L.2401220106590.999@herc.mirbsd.org>
References: <20210312113253.305040674@infradead.org> <20210312115749.065275711@infradead.org> <Pine.BSM.4.64L.2401200654480.19429@herc.mirbsd.org> <CE53F232-3D2D-4910-94B4-A4304F5990C7@zytor.com> <Pine.BSM.4.64L.2401201652490.29203@herc.mirbsd.org> <d23e1b70-7ac3-49cd-8d5f-1dedc0108603@zytor.com> <Pine.BSM.4.64L.2401212356390.999@herc.mirbsd.org> <20B57BDC-9A3F-4B02-9BA9-41477088A6CE@zytor.com> <20240121195649.7355e1d5@rorschach.local.home> <Pine.BSM.4.64L.2401220106590.999@herc.mirbsd.org>
Message-ID: <4F17FAD6-9183-4F29-850D-8DE88FAB3658@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 21, 2024 5:17:36 PM PST, Thorsten Glaser <tg@debian=2Eorg> wrote=
:
>Steven Rostedt dixit:
>
>>> >This was, incidentally, triggered by looking into a problem report th=
at
>>> >something did *not* work on a Geode LX system=2E
>>
>>What problem happened?
>
>It turned out to be a compiler issue (GCC thinks i686 means PPro,
>not 686-class CPUs, and -fcf-protection causes long NOPs, which
>not all 686-class CPUs support, to be inserted)=2E This turned out
>to break a large part of Debian stable on OLPCs and other systems,
>and the kernel=E2=80=99s changes in nopl handling were tabled as argument=
s=2E
>
>https://www=2Ejookia=2Eorg/wiki/Nopl has a longer writeup on the nopl
>history=2E
>
>bye,
>//mirabilos

i686 *is* Pentium Pro=2E=2E=2E

