Return-Path: <linux-kernel+bounces-32231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0048358E2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 01:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D5A7B214F5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 00:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE80536C;
	Mon, 22 Jan 2024 00:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="F1Q01wyx"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2686360;
	Mon, 22 Jan 2024 00:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705882601; cv=none; b=sB974ZVv8DWA2lmjG6/olf7kBvawOBKn/YogUa7fly02byJj6IOTFVWWK+5TGeRWxV0uZD1oiiooemIT0uxhUybrd3GqaNxRcP2GzQUrhdwx1ymDPr0oKqXV2nvocjcyWzmML07pXAPhLtGbJYN/DqQ+zix6Wg6WSoZDmxyJ0NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705882601; c=relaxed/simple;
	bh=TdIhc3Udceb38wI9THCR6IdLlWdrOaBwsuVbGu+VNjw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=GQ0bYzfwiAxp+GpG1KsMxWEDQ2L6jZ2CMXwBB1a/yJQFA5MMwXqSCmfgYSBWhjQVddpMqDIj1ECOW0K8NtEn2bulPgDDjck3zLc0BQ7cxyEcQS45xu4fico+AziLEvFEfV9uEC2py/CTGEqaAKTNE+LG7tuOYthngFRgCqVT6b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=F1Q01wyx; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPv6:::1] ([172.59.160.46])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 40M0G7Gt2251320
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 21 Jan 2024 16:16:10 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 40M0G7Gt2251320
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1705882571;
	bh=TdIhc3Udceb38wI9THCR6IdLlWdrOaBwsuVbGu+VNjw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=F1Q01wyxJe1GAeuSbw/qbXOt4C/TGQ1daCC8OU8t0SktRft7MpHW3Hcq5XlfHIXeH
	 xtAiNwMsFF8fzoLQOMKqyxNKNiFk0yUaO59m8qYlB29OuksaIRPuCneGhduDVQdO48
	 BKhQYxifzpoJtwYQK3eHXKTKcjiIjgjDMSJOuGtDRY/KgjQeurXQEnYZxDjM6eYsRX
	 W+MxPl5MfAuv0MEkctdwvI7dgHV7zUu8F9oNj9/2S8lpWZuTduq0Eth/VgCZovEVdR
	 vO+r6SZheacAwxFHoeOqDZs2JNBjb78MqA0D/tYQ2+D6jma3aVmZj+gayzJUa5o4sQ
	 5EQ/M6caxQe4g==
Date: Sun, 21 Jan 2024 16:15:57 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Thorsten Glaser <tg@debian.org>
CC: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, rostedt@goodmis.org,
        torvalds@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-toolchains@vger.kernel.org, jpoimboe@redhat.com,
        alexei.starovoitov@gmail.com, mhiramat@kernel.org
Subject: Re: [PATCH 1/2] x86: Remove dynamic NOP selection
User-Agent: K-9 Mail for Android
In-Reply-To: <Pine.BSM.4.64L.2401212356390.999@herc.mirbsd.org>
References: <20210312113253.305040674@infradead.org> <20210312115749.065275711@infradead.org> <Pine.BSM.4.64L.2401200654480.19429@herc.mirbsd.org> <CE53F232-3D2D-4910-94B4-A4304F5990C7@zytor.com> <Pine.BSM.4.64L.2401201652490.29203@herc.mirbsd.org> <d23e1b70-7ac3-49cd-8d5f-1dedc0108603@zytor.com> <Pine.BSM.4.64L.2401212356390.999@herc.mirbsd.org>
Message-ID: <20B57BDC-9A3F-4B02-9BA9-41477088A6CE@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 21, 2024 3:58:11 PM PST, Thorsten Glaser <tg@debian=2Eorg> wrote=
:
>H=2E Peter Anvin dixit:
>
>> But yes, with all even remotely recent CPUs all actually handling nopl
>> properly, this isn't relevant anymore=2E
>
>This was, incidentally, triggered by looking into a problem report that
>something did *not* work on a Geode LX system=2E
>
>People don=E2=80=99t just run Linux on =E2=80=9Crecent CPUs=E2=80=9D (tho=
ugh I at least got me
>an Atom and a Core2Duo for it and run BSD on my Pentium-M and VIA C7
>systems)=2E
>
>bye,
>//mirabilos

Yes, but it is a matter of where we optimize for performance as opposed to=
 correctness=2E

