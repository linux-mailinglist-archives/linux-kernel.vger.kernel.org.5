Return-Path: <linux-kernel+bounces-19989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9BB8277E8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 585B9281D66
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEDB54F83;
	Mon,  8 Jan 2024 18:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="KMgtRs/j"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9CC54BF4
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 18:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4C1533F2C6
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 18:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704739607;
	bh=IJXkphy1XTMBJngf5Fcupraf2zYCAU0PJBCMt+P8VUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=KMgtRs/jx/XAfcMOm0TeC16vpyT0B6QttOzX0ISB4AobBiEBexImkEZmfE3cQTb7Q
	 ojXDCG8jKlNG/TaKjb/1JYCseLBGqwxjZWj2zfm+yP7KYmX6uaJdP6J9FTyLzt3c27
	 i6+MGC/EvnHVbWRQaB8S/h+YFgAO1iIRZBEWx2FB3LQs+2P3Pi4q4EYr+JvPXBn+tF
	 ZH4GDp5dBgSDrcd6rBO/awD8fcECKGrHSx84U6BQp7R24Jj21tbRcRi/+iupsZRnW4
	 NDlFatIZFwAVJ7HGlzxoxviNqweZIUSjWl21zmAv/S3AH1k7UXMaAQzHKTI59UO3xl
	 LGVVBxYQYD8mg==
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3368698efbdso1526533f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 10:46:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704739607; x=1705344407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IJXkphy1XTMBJngf5Fcupraf2zYCAU0PJBCMt+P8VUc=;
        b=Pp4uYnSOu8E5fqU9+pr69AVxXfhjw3cTZynddeLMtiHSpbNHiaogcAqdxhbm5/a3pf
         M3R3APkOFT7jc407A9pN+Tyr3vUzJfRsLBFHGacb6Z+QCqSheSeQ1/DmhRBz/NqefQG7
         s4hmkrAYhOnm6fyo0cPzeUiLkntU2JsAPnPtvagd5F4V2LkQJjg4KT8PK5TH14NqkB3c
         GOLK/zQ4Z0uCQlKNMRfu8jdR0SNXzIhQhnTiPSVOfYLqcsSBUpZ9WcXwfRmnBymRBnSO
         /R9HSlIAkWx2/mSmP1zc7KhDx/1zfe+7PZPsSqmDKgAtTUQPzXg8n+E8Ag99BSWNEFNB
         WKyw==
X-Gm-Message-State: AOJu0YzlehvChtuHM6h3wzNh6JfSCTGLfVsuEoUCFWp9q0gP+QVFgfG6
	qbtUq9FAlfRnmAT3sOMz9CYIBZ6+bwiAgUgcDCb6CCSDdwHhydBw98AhfogMYfcxsH0d2LqYXtl
	mWntbLZQXDTLtA3w4wibRECYVfWmw1qUgSFhjZ2RpG70CWUGyB7xoV8PwYcM7WFj2amaTVA2EJt
	Y=
X-Received: by 2002:a05:6000:4007:b0:336:5b14:525f with SMTP id cp7-20020a056000400700b003365b14525fmr2711514wrb.132.1704739606804;
        Mon, 08 Jan 2024 10:46:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFK3xRr+xQPVgtoM3vnFX3D+ji+1lCpJuw8lG8gwbcMlwHbE6pTLX2cmn6d9SvLE3s6kn42Pyw2IZYAgFuIknU=
X-Received: by 2002:a05:6000:4007:b0:336:5b14:525f with SMTP id
 cp7-20020a056000400700b003365b14525fmr2711509wrb.132.1704739606501; Mon, 08
 Jan 2024 10:46:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZwk8nFBTIMISLXp@shell.armlinux.org.uk> <CADWks+Y7JOsvzWc50syVwOB9LF2Lxc_YiLzLxCkhEv8sBxrNvw@mail.gmail.com>
 <ZZw/XK12CnSgPtaB@shell.armlinux.org.uk>
In-Reply-To: <ZZw/XK12CnSgPtaB@shell.armlinux.org.uk>
From: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Date: Mon, 8 Jan 2024 18:46:10 +0000
Message-ID: <CADWks+YdQ_1QkbhT5tzVA0c_5z0Yn39-nyfNMH201=Anu7DCJQ@mail.gmail.com>
Subject: Re: [BUG] SHA-3 causes kmod 28 to segfault
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jan 2024 at 18:30, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Mon, Jan 08, 2024 at 06:14:17PM +0000, Dimitri John Ledkov wrote:
> > Hi,
> >
> > On Mon, 8 Jan 2024 at 16:38, Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > Hi,
> > >
> > > When building 6.7 under Debian Oldstable with kmod 28, the installation
> > > of modules fails during depmod with a SEGV.
> > >
> >
> > What is your kernel configuration, and I hope you make config choices
> > compatible with your target host OS.
>
> "target host OS" - that's a total misnomer. "host" is generally what
> you're building under. "target" is generally what you're building _for_.
> So I don't fully understand your comment. Maybe you meant "target _and_
> host" ?

the kernel configuration you use, should target the operating system
you are planning to use the given kernel on.
using bleeding edge kernel features, with an obsolete userspace often
can have compatibility issues.

>
> > > Running under gdb:
> > >
> > > Program received signal SIGSEGV, Segmentation fault.
> > > __strlen_sse2 () at ../sysdeps/x86_64/multiarch/strlen-vec.S:133
> > >
> > > I have no further information as I can't remember how to get the debug
> > > info for packages under Debian - and even if I could, it's probably a
> > > bug in the kmod package that Debian will have absolutely no interest in
> > > fixing (based on previous experience reporting bugs to Debian.)
> >
> > For latest kernel and latest kernel features support in kmod, latest
> > kmod is required. I.e. patched with
> > https://github.com/kmod-project/kmod/commit/510c8b7f7455c6613dd1706e5e41ec7b09cf6703
>
> Would be nice if there was some documentation. Also, as kconfig provides
> a mechanism to detect e.g. the version of tooling used to build the
> kernel, it would've been nice to detect whether depmod was sufficiently
> recent to support SHA3 and make the module signing SHA3 options depend
> on that.
>
> Leaving this to a SEGV to indicate that something is wrong isn't user
> friendly.
>

There is no ability to detect runtime kmod at build time, given the
two are usually often not the same.

Can you please provide your config?
Can you please explain how you chose it?
As both oldconfig, and menuconfig should have offered you
MODULE_SIG_SHA256 as the default choice, if you chose to enable
automatic module signing with an ephemeral key.
Please note that SHA256 is recommended and sufficient through 2030 and
beyond, as of now.

If you want to use SHA3, SM3, or GOST you need to have appropriate
builds of openssl and kmod to support those.

-- 
Dimitri

Sent from Ubuntu Pro
https://ubuntu.com/pro

