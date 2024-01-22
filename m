Return-Path: <linux-kernel+bounces-32280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F43C83595F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831A31C21951
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED3B15CB;
	Mon, 22 Jan 2024 02:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="V76PB5Xw"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE10139B;
	Mon, 22 Jan 2024 02:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705890733; cv=none; b=lcdF0r15pF0qdojgMw6QpMZEh4ItG3pxCB2eZ2UkMN1fN0kDcPc1J9celAuZChh00ggKx9WxOjePsf0yBxjhdeccIx7FDIQMhnwSKuJsdI+jgsjtsdA78vaLheDI3lnfEkM4mo9Q5GMwYiRjHaPtl3hm1BHkJDmtMwl9pfmXi08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705890733; c=relaxed/simple;
	bh=r5T0H/VDG7E9xWa7Rli5BKYxTAuI171fVVn2vf9aQGE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=lmwBY3r16iN0oiv4yEQugRsu+YmHcgqsosCv7WAcbaAPQQWyNTj9LIeSB/Q6WbprzMbgmW/xBeWPNTE7XY6QNn2/ZdVFthnqT3xUz1ogMdlifCrwSoJD8sZFqd4BqEz3qe2GlY3MqkdIQj6/Oq5nIOr2tkH9ropCk+rKnv8fbWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=V76PB5Xw; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 40M2VsD62299404
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 21 Jan 2024 18:31:55 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 40M2VsD62299404
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1705890716;
	bh=f8Zaj8tL7OEgAEIVqJrsVZClrUxxhxG2gydEDFwI7ak=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=V76PB5XwN59fAz2ZtpQTXi/QuNUdwRujkutoENJlnhR9x+TZnoKUyGmPUDt6QDr0p
	 EePdkmggbbM36pKur5WJyvv+sZ9SE4XvhTlj/qDCzakDM/DRTyunX6wAEsWgGwFskU
	 VZaulZ9jd3FaTEgyCSEiPnFew2m8ssN4C+QQnGUdTZWpjLVFlpj+lRV6lu0pdpU653
	 RbQC9UEXaTwueJHKJ3NBQZAOE1hBoLv6w9hOPuBLqxn7zsL4ye69P+4nAyWOPFX6Qz
	 V2wdeEGpiwYl5Zn7dw8Q5OZ/1hUTvQdKvCB04jwBDdyPMgXlaIxruWfbKUNyCw54Fm
	 FMZ/w20fnYuqQ==
Date: Sun, 21 Jan 2024 18:31:53 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: Thorsten Glaser <tg@debian.org>, Peter Zijlstra <peterz@infradead.org>,
        x86@kernel.org, torvalds@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        jpoimboe@redhat.com, alexei.starovoitov@gmail.com, mhiramat@kernel.org
Subject: Re: [PATCH 1/2] x86: Remove dynamic NOP selection
User-Agent: K-9 Mail for Android
In-Reply-To: <20240121212236.02331f4c@rorschach.local.home>
References: <20210312113253.305040674@infradead.org> <20210312115749.065275711@infradead.org> <Pine.BSM.4.64L.2401200654480.19429@herc.mirbsd.org> <CE53F232-3D2D-4910-94B4-A4304F5990C7@zytor.com> <Pine.BSM.4.64L.2401201652490.29203@herc.mirbsd.org> <d23e1b70-7ac3-49cd-8d5f-1dedc0108603@zytor.com> <Pine.BSM.4.64L.2401212356390.999@herc.mirbsd.org> <20B57BDC-9A3F-4B02-9BA9-41477088A6CE@zytor.com> <20240121195649.7355e1d5@rorschach.local.home> <020a1803-25c4-4365-8c53-291becd94632@zytor.com> <20240121212236.02331f4c@rorschach.local.home>
Message-ID: <50F640B7-AB54-4571-9988-EAD5FD5933A4@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 21, 2024 6:22:36 PM PST, Steven Rostedt <rostedt@goodmis=2Eorg> =
wrote:
>On Sun, 21 Jan 2024 18:15:39 -0800
>"H=2E Peter Anvin" <hpa@zytor=2Ecom> wrote:
>
>> On 1/21/24 16:56, Steven Rostedt wrote:
>> >>
>> >> Yes, but it is a matter of where we optimize for performance as oppo=
sed to correctness=2E =20
>> >=20
>> > There is no such thing as "optimize for correctness", it is either
>> > correct or it is not=2E Correctness should always come before perform=
ance
>> > (at least that is what Thomas has pounded into me ;-)
>> >=20
>> > If a kernel use to work on a machine but a newer version no longer
>> > works, I call that a regression=2E
>> >  =20
>>=20
>> There absolutely is such a thing as "optimize for correctness=2E" It me=
ans=20
>> to keep the code clean, easily testable, and with a minimal number of=
=20
>> distinct code paths so that regressions and *especially* uncaught=20
>> regressions get caught quickly=2E
>
>I call that maintainability, not correctness=2E It is either correct and
>works, or is incorrect and does not work=2E
>
>You can change code to be more maintainable and still make it incorrect=
=2E
>
>-- Steve

Yes, of course=2E That's called failure :)

