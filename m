Return-Path: <linux-kernel+bounces-88332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C5686E01B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C562861B0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6436CDC0;
	Fri,  1 Mar 2024 11:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXvj9ZeX"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481E06CBF4;
	Fri,  1 Mar 2024 11:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292189; cv=none; b=OmudQHShy93SwCnbldL8/lkOr3YpaypxBtkNKrakgLV2bbmHBV/UhdCCNld/8GRloUfvFyGPl9cntrH+xiwiqIb0s3HjoOVlpapQFbfWALpdx7v29+z3gNE2kIbYaNJDln6u4+qTN8+1TG1/v10TL+ujc3APqm8PINOVk4HqFrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292189; c=relaxed/simple;
	bh=CM1j7RiwxFC3f87IGZ/peUzNKT4rdyXdMHdVJ4c4EqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=prVDkVK/QEdUEds0eD4R5B2I03D2GvSgEhRk3criH+Og2vCjf/iYk8H9t3aFKcMXo/kKIM/zXktagu+yMae0zVoPVJEacKif++XFDyMAk1JiWNov6CZK0k0/VpOK7yDVCN48kDneexcXbpgcvqY7l0FCpv+HHaYHCRHEmOoa2wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXvj9ZeX; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a44360a8b9dso254163166b.2;
        Fri, 01 Mar 2024 03:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709292186; x=1709896986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CM1j7RiwxFC3f87IGZ/peUzNKT4rdyXdMHdVJ4c4EqQ=;
        b=EXvj9ZeXmxONiLoi5vTeztsn6QtzgnW983Zicx6Qk/89rmi1JgeU3klT2prgUCjR+u
         Glse155UYIfVjWp+WT9C6jcc3XQadmegjPJweCtD0brT/1l4FlqGTFyYIB7MILd4RfTP
         vaObWMLPPnot+m+O1NqWMecrRSQSWzFfXz73TKgO3lTO+JDz5WEgDcXfBCKUBHq3eqjd
         bNo8DnXA0eN1nCAdBbjgj6RtLt4JJU4pj4ShRnQFvR8gvsTfde19xQjqhSCs14VSfaGv
         2EBLiFXISlbR8bBv0vNHHCegEvY2uXofQCFJSdwXZaEkLCG8l0T/0PJFgRTJnZhWlLEn
         tznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709292186; x=1709896986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CM1j7RiwxFC3f87IGZ/peUzNKT4rdyXdMHdVJ4c4EqQ=;
        b=XmjyuMhnyN41llYMjVcbHI5AiNQn+4uUTw9/1wFt73n2GfDTpdzYPgHXcQ+XrGZS5X
         aNstEvHKaS08wAHYc+itzaBXhjwk4QMjHGQ6JUkVUT4lkWC+gWL5fm3aPdq4RcTlWAtQ
         ln6Xh4ruc+/2KX8lL+beyOdXClDAwFVlQ197xWQExTRUDReCD25UdEvPbJVuu4SsNaFO
         IREYJiqG69tgPP1aYDYH6tyMd+wWDQ69nQwUpmO4+OyNAz0X+iYSH4XyCS88/aOkagpi
         4RUVgHI7ricGlSjJHwMED4qBBQUpe9afPlwOdVUjt6QCqCUwOjfwSdootz9VWbAxAZaM
         1R5g==
X-Forwarded-Encrypted: i=1; AJvYcCXn8h6v4lszIa+pgHWA4sAIyn7g7KqhFSXlA7dDfKtEppGwa9uO7fbLO5sc47w62XAUyrlHFh1opAhOW9S13hBwypXoSXKfkPqhMTKAE32vObhFypf5jmCZpB/2HghuQyHuBLFiI3M71+TlQ9rA
X-Gm-Message-State: AOJu0YwXIlVOPhU2eGeT59C8T79Dv7GKk5nUynhLOU9ZCuqlmKmI7g5T
	LtASekuEEAGLaRjfIQErxmNss47y++5SVwXkHrrlXN2+qRJSlg8qIX2jA334Gy8gL1wyoCxbkog
	OKy/giOkAXXRWH1m5Jt9ShgR31gtNKWk2dMg=
X-Google-Smtp-Source: AGHT+IFuA+DaJP4MQvCwubLwc62rDx8QNLcgMsICd+FR+DoziZ891AtuCtrm/F1Wc7gorwmO+5GsNRlqiHEpo9YByK4=
X-Received: by 2002:a17:907:7677:b0:a3e:b439:6c8d with SMTP id
 kk23-20020a170907767700b00a3eb4396c8dmr1016059ejc.25.1709292186380; Fri, 01
 Mar 2024 03:23:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301002416.it.092-kees@kernel.org>
In-Reply-To: <20240301002416.it.092-kees@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 Mar 2024 13:22:30 +0200
Message-ID: <CAHp75VcyAxs4L74pyL_qEvsyaN+vQVL44SOaHGJ4RihnqT8dGA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] string: Convert selftests to KUnit
To: Kees Cook <keescook@chromium.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 2:26=E2=80=AFAM Kees Cook <keescook@chromium.org> wr=
ote:
>
> Hi,
>
> I realized the string selftests hadn't been converted to KUnit yet. Do th=
at.

IIRC last time somebody wanted to do that KUnit was completely sucking
in supporting the cases we need in these files. (I mean proper
messaging when we need to dump the expected and resulting data). And
please Cc Rasmus as well.

--=20
With Best Regards,
Andy Shevchenko

