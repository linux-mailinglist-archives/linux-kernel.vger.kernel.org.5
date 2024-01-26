Return-Path: <linux-kernel+bounces-39739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8148C83D593
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35C441F26BEB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B760C66B40;
	Fri, 26 Jan 2024 08:07:23 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC111CD2F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706256443; cv=none; b=oKVO5ODxmXblgBBD47oPKBjiRH7H1ZPJ3U+qqV7Zdk70VRSLdNpF70WZfRFbyeQLz3hVN961Chy5CGaMYbTa3ACXdPPnIPr+Ntwd/jyhlMTHzPmctix1202Lfog1ieeUQwjl8nIbJ0IA1t2yzD5reADzsS7ftAA9ktTnaGSWiaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706256443; c=relaxed/simple;
	bh=oJ/isUxts4Rxsvj6HSfeCB9SXqt4ZhhtwwaRZWrOCzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQ7di0qYkZmhYNh9hOcqKM+no+rdC9r1JAdhQnX3b46zukIu3hvSGTEbwZXcby/kbTWqrH1n6nNKCJrdY5OW8YdSYpsjFHf1JQgmklMlTZc8U6sszdHRtjxKwEOlhex8lN1I4sv8PSK4skRdMUPej7eH3oohjCjyNxO3i4nhqA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-602c91a76b1so1508357b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:07:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706256440; x=1706861240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kuv86emBVFVMHP3rH5Dj+FCsl+8/ydOrLj7alourBg=;
        b=kdbmsELnCNaa0Os/JZRBuWCwAwJWkBP892c6v8CJtVH23dHSvYpTtbIjVqnyJxuOj6
         rSLPUGCbs9bBAGkhjGCwT4iv27/OQRxG/9SddhRTUlbSXF5NKWZGmH7/caf+6FgzMRhT
         z9r34U/ALpCYrDNA06p+lsfMuF/D/cmPKGVvucpivF48WnKPm01mE2N/BGUmmzWCFHth
         dvqnJPfu2tctbFv/ViXSGHW8p3hkTgiWvXMWoGA6spGwaw3KQDdJguW+h03L4p3Ms0Vt
         FFQRhb4pPGPzdQHn79Lvbgp7RFvBmn5l5xF8qXaD+JmEVWrb0eB3v+k9NW1dGFXLhnO8
         Yarg==
X-Gm-Message-State: AOJu0YyP+iEODNqXupDLgJmyxFXX/v/UuD5I1XOCsnlNnhS1VC0reHl5
	NwGJtxmwFXJlFTrXeUPsGlWihM31/QEoeFcYj8IUd3JXlhJ769GjE8/4RKpFaPA=
X-Google-Smtp-Source: AGHT+IE3IkZdAuSpsSn71hl4c0kliO4SAh86uIBUW8Q9V6tWzwkG141O6nB633e+UaRJ68RrD5f5gQ==
X-Received: by 2002:a81:4e81:0:b0:602:c963:b54c with SMTP id c123-20020a814e81000000b00602c963b54cmr523892ywb.72.1706256440143;
        Fri, 26 Jan 2024 00:07:20 -0800 (PST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id gq4-20020a05690c444400b005ff864709aesm227385ywb.42.2024.01.26.00.07.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 00:07:18 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-602b7cef983so1225227b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:07:18 -0800 (PST)
X-Received: by 2002:a81:7e4e:0:b0:5ff:a36b:55fb with SMTP id
 p14-20020a817e4e000000b005ffa36b55fbmr1044979ywn.97.1706256438560; Fri, 26
 Jan 2024 00:07:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117143548.595884070@goodmis.org> <20240117143810.531966508@goodmis.org>
 <CAMuHMdXKiorg-jiuKoZpfZyDJ3Ynrfb8=X+c7x0Eewxn-YRdCA@mail.gmail.com>
 <20240122100630.6a400dd3@gandalf.local.home> <CAMuHMdXD0weO4oku8g2du6fj-EzxGaF+0i=zrPScSXwphFAZgg@mail.gmail.com>
 <20240122114743.7e46b7cb@gandalf.local.home> <CAHk-=wiq5mr+wSb6pmtt7QqBhQo_xr7ip=yMwQ5ryWVwCyMhfg@mail.gmail.com>
 <CAHk-=wjGxVVKvxVf=NDnMhB3=eQ_NMiEY3onG1wRAjJepig=aw@mail.gmail.com>
 <CAHk-=wiLqJYT2GGSBhKuJS-Uq1DVq3S32oP0SwqQiATuBivxcg@mail.gmail.com>
 <20240122144443.0f9cf5b9@gandalf.local.home> <20240125-deportation-sogenannten-2d57a7ce8f81@brauner>
 <20240125130731.3b0e2a42@gandalf.local.home> <20240125130821.0a1cd3a7@gandalf.local.home>
In-Reply-To: <20240125130821.0a1cd3a7@gandalf.local.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 26 Jan 2024 09:07:06 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU-+RmngWJwpHYPjVcaOe3NO37Cu8msLvqePdbyk8qmZA@mail.gmail.com>
Message-ID: <CAMuHMdU-+RmngWJwpHYPjVcaOe3NO37Cu8msLvqePdbyk8qmZA@mail.gmail.com>
Subject: Re: [for-linus][PATCH 1/3] eventfs: Have the inodes all for files and
 directories all be the same
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Ajay Kaher <ajay.kaher@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steven.

On Thu, Jan 25, 2024 at 7:08=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
> On Thu, 25 Jan 2024 13:07:31 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> > Actually, inodes isn't the biggest issue of tar, as tar *is* a common
> > operation on tracefs.
>
> Correction. tar would be a common operation if it worked ;-)

What would be needed to fix that?  I regularly use tar on other virtual
file systems (e.g. /sys/firmware/devicetree/), which works fine.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

