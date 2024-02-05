Return-Path: <linux-kernel+bounces-52278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4F0849631
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74DB9281F92
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D39312B8B;
	Mon,  5 Feb 2024 09:17:22 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313FF12B7B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707124641; cv=none; b=nkadM4UeOyFh1i6sf6l7grilZbeJv1LrLyo1ILO6oe6PhS9V+xB4Ai6GJY4j9Vr2mrXtkT2FdisGcXQJKum8MKtoKe/se/3NQ4wqjdmCjVCt+FzuF8Rs1l7jWHiOS9MSvBreBCRBm9WslgB+xU99YA4nG3WCXUo6GH1e1A2Q52w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707124641; c=relaxed/simple;
	bh=96MPBiS40e0x9Vw86i9UrFnPx8o4zrAU2LTLF+KiPMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=saQKrueGipubS7cdQr1ulbWYVCiPJPaS+tl3/NdNnIkeCdkDnNd7/+OW1o8a4VtAOnWvuQ5bgcOR7A1QSxZvjvU4EtXByPFj39xPy1+y8AZ1N+J8K1UjPRc0jsw1J1Jjo1UVjv7KJCZjZAigbQvkLiyjMTCQHq53qFXpEVvYQM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-295f9a4a656so3440711a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:17:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707124639; x=1707729439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rU3n7CJ8LR2Ka0hr51hd9lp4PmyuHjFJfmGGeQpcndM=;
        b=t/Gftyds8xZOAyDMRf0SEEphs0QU81nbGmkmcm5VNiM83yX+b8xfW3BOR2wM1sZhYU
         rwUprd7KIHms1Jd7D06SZYTnmHvGHX2sgtorIgGAjiSUmsRNu6pImy7NpC4yDmh9kt3K
         xR/iLnhQ99/GQ6omPyNUwjfJSrF0JXubNDaoaD7Cdm0+b9Loe3HZUwpJzDSbhrwvWelA
         AvliP2/cQPs/DIE2XvwY5113b6V+Zrc2pgIN99jWx8qDB4oZDjBcNReusQiiRQVE6mPR
         IytkKqVcY+VdqGy1QIOgHMx/Fcp5QiPO5ChbElr7tRnRjgK0NueIJgFTHrnVb9kZJ7wh
         SPVQ==
X-Gm-Message-State: AOJu0YygnMRjUmIA7uALPjV5dGYZV4olB+XWvTDBDCgi88ZtG/az0XJ2
	0MbgPyhMXEMvBn5qCRLIA8XVRVK5qCHhDE9hOjzyYkG1HKtAIPL1hNWVN3XiPWWyfCNxcyYaFjh
	mlwO0JCxebE5E5f6ebwwoDgIjcqQ=
X-Google-Smtp-Source: AGHT+IFfZf+XD8BOSl7R7bC9f9eXgr73a5N6xcGPxMPSXsWh7hXatH3CaIIqjbH6bQN1DrRciODcjMzAjFn8nQ7Nry0=
X-Received: by 2002:a17:90a:3006:b0:296:2035:a3c2 with SMTP id
 g6-20020a17090a300600b002962035a3c2mr10729751pjb.36.1707124639396; Mon, 05
 Feb 2024 01:17:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20221111081316.30373-1-mailhol.vincent@wanadoo.fr>
 <20240128050449.1332798-1-mailhol.vincent@wanadoo.fr> <20240128050449.1332798-3-mailhol.vincent@wanadoo.fr>
 <c47fedaf-cdc9-f970-460f-d2ee7e806da4@linux-m68k.org> <CAMZ6RqKj207uv5AF_fvb65nhCM32V=VAQXsUGLNmbeXYKPvZJg@mail.gmail.com>
 <9d9be9dbe92f43d2a95d11d6b2f434c1@AcuMS.aculab.com> <CAMZ6Rq+RnY16sREhAZ6AFn3sz1SuPsKqhW-m0TrrDz1hd=vNOA@mail.gmail.com>
 <77831c6f-7fc9-c42d-b29b-c3b2f3f5e687@linux-m68k.org> <CAMZ6RqLyRxvUiLKZLkQF1cYFkdOqX73V2K=dGbNROMDj61OKLw@mail.gmail.com>
 <002675b0-6976-9efa-6bc5-b8bad287a1d2@linux-m68k.org>
In-Reply-To: <002675b0-6976-9efa-6bc5-b8bad287a1d2@linux-m68k.org>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Mon, 5 Feb 2024 18:17:07 +0900
Message-ID: <CAMZ6RqKx=EO9kcOmxRyBuhULdDyTCeAXz25j_uF7TSy72Jahpw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] m68k/bitops: use __builtin_{clz,ctzl,ffs} to
 evaluate constant expressions
To: Finn Thain <fthain@linux-m68k.org>
Cc: David Laight <David.Laight@aculab.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yury Norov <yury.norov@gmail.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Douglas Anderson <dianders@chromium.org>, 
	Kees Cook <keescook@chromium.org>, Petr Mladek <pmladek@suse.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Zhaoyang Huang <zhaoyang.huang@unisoc.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Marco Elver <elver@google.com>, 
	Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Matthew Wilcox <willy@infradead.org>, "Paul E . McKenney" <paulmck@kernel.org>, 
	"linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

On Mon. 5 Feb. 2024 at 08:13, Finn Thain <fthain@linux-m68k.org> wrote:
> On Sun, 4 Feb 2024, Vincent MAILHOL wrote:
(...)
> Let's see if I understand.
>
> You are proposing that the kernel source carry an unquantified
> optimization, with inherent complexity and maintenance costs, just for the
> benefit of users who choose a compiler that doesn't work as well as the
> standard compiler. Is that it?

My proposal is quantified, c.f. my commit message:

  On an allyesconfig, with GCC 13.2.1, it saves roughly 8 KB.

"Saving roughly 8kb" is a quantification.

And clang use in the kernel is standardized:

  https://www.kernel.org/doc/html/latest/process/changes.html#current-minimal-requirements

GCC may be predominant, but, although optional, clang v11+ is
officially supported, and thus my patches should not neglect it.

This is why I am asking whether or not clang support is important or
not for m68k. If you tell me it is not, then fine, I will remove all
the asm (by the way, the patch is already ready). But if there are
even a few users who care about clang for m68k, then I do not think we
should penalize them and I would not sign-off a change which
negatively impacts some users.

The linux-m68k mailing list should know better than me if people care
about clang support. So let me reiterate the question from my previous
message: is clang support important for you?

I would like a formal acknowledgement from the linux-m68k mailing list
before sending a patch that may negatively impact some users. Thank
you.

> At some point in the future when clang comes up to scrach with gcc and the
> builtin reaches parity with the asm, I wonder if you will then remove both
> your optimization and the asm, to eliminate the afore-mentioned complexity
> and maintenance costs. Is there an incentive for that work?

I will not follow up the evolution of clang support for m68k builtins.
The goal of this series is to add a test to assert that all
architectures correctly do the constant folding on the bit find
operations (fifth patch of this series). It happens that m68k and
hexagon architectures are failing that test, so I am fixing this as a
one shot. After this series, I have no plan to do further work on m68k
and hexagon architectures. Thank you for your understanding.


Yours sincerely,
Vincent Mailhol

