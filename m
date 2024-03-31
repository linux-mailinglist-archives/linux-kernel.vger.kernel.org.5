Return-Path: <linux-kernel+bounces-126135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5F78932A3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E149B20D99
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464E61E885;
	Sun, 31 Mar 2024 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNblNQC2"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4C4145339;
	Sun, 31 Mar 2024 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711901819; cv=none; b=P6iXIuSodjSrrGZRpUuPAt41Dq2I1omq2j/kMXl3FJEzjwTPzNuecghECGYHKWZuDUB5/dJzA1XHVs0ATPi6nMh57u2c3KGMBHgevPiiNYejc1pdqKX7NjGrR5RjlSq64xJzNkNGGHe+wkYNJrkP5shxfppWRbeKsEbIQnqgzxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711901819; c=relaxed/simple;
	bh=WsP/+lzMZQ2zP7XRmT3cZD7Gha/b4oecQDkkHYBNemw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m70Bw7gxZYq45YFGkQjdyS+WPqi3Yk7NweR/M52PhZX4USLL9nuRxwmeZw630IbOaVlteUF9HH1kBwkz7/HmT5c5ERZXyeRi6CsjsJ5oZbSiIXFCKULuqV94JX4ebyG2kfvj/JpurufjkDRKW3f9/hQLgfQWl8PDGKWVjHVcVOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNblNQC2; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2a07b092c4fso2502126a91.0;
        Sun, 31 Mar 2024 09:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711901814; x=1712506614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WsP/+lzMZQ2zP7XRmT3cZD7Gha/b4oecQDkkHYBNemw=;
        b=kNblNQC2FYag6sQZc2aX37t+OzAYceglx/u5HxjkYUW5PbrfLcugVX2ljNrLGEYrZV
         Ta/8tVDhpXF3cTkwZtCj5PI0+mjXIjAHftk25efDqQsvGj3QNxDyveDvYNhtlZcCXkzQ
         uXwYRgzB2WO9T52xNvOK79+8gBCdOt+f0JlPla5eBiW3b3oHdB74O9dIwoXwrgsQj+PP
         Vkkcep1wAjK9PO/rxQ6S1ph6fgAT1kRix8rL+A4J81f2Y/EL6c/oxV42Zc2AeMEBA6Nz
         bKfv/g+3mkuPDwS112wspO8/sQFDb3cc0vy3+yi7YicdafQu0adj3M1nG+CxY3GcboXA
         xaPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711901814; x=1712506614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WsP/+lzMZQ2zP7XRmT3cZD7Gha/b4oecQDkkHYBNemw=;
        b=NKn1F9igG6/qgRqww0gfeonbAxx9mX7l4SQfVq8v/j6wZM5TKDUml2TxNMGHKaOF/A
         jrvFJxueuFtUmn/ZlztZjcCZ1CAvDCNIxfgjfBC8eJ64ScHZU8tUEbolsapl9AQZ4+cN
         Klcw3Z6Ncz7OXHvc4pIM/cn8xjmR8LlnB/ZumCDHDxQWSGnueNdyhAhN+13oZ01F8oo7
         ZN7ZPoCCTt9BXs5mBaNPP+vDQNUxwNm2wEcPw3ASu9JcBL/q7K5duMbaYXQ/PbVi1fmT
         iulMlq6fiRjuCFEPakrO/oZMMElnzcDzfKrbVx3qb/fxOTHQEzVlVynh+nlnr58SG2xZ
         /rMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1uu8bqBZipFAu6M2Lf4Hui2D06TvuQL27hZHAc8HYqbGGNL5n4/eNLHKz6enHJC2ZGjmrGUUBl2yHlen99clnc83G
X-Gm-Message-State: AOJu0YycL+iZ6JZCDHvOWpk/+QsIRQpR9xWCd4iltylM7ytuKXeXM0a5
	qix+xFeDUSBLMObbJZW2CnKi+CqXXGn2ANAbpTYUgtROwHN/IskO00uh4ElW8IH1WwvFtS69Psf
	pwRAmQsGHUr2D419QfZTMsbeh6Pg=
X-Google-Smtp-Source: AGHT+IF8YeeWFeO166tF2rV+DUV3+gt0CiY/eH4IJRBv6Ie8qP/0QWOsTlQr/sa+tHAx5YIwmZrKiVZDZz0dwrwsg8g=
X-Received: by 2002:a17:903:987:b0:1e2:4093:5b28 with SMTP id
 mb7-20020a170903098700b001e240935b28mr5975393plb.3.1711901814191; Sun, 31 Mar
 2024 09:16:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328075318.83039-3-jiangshanlai@gmail.com> <769AEAAB-7DEA-4D94-8979-F01EDFD6EE46@joelfernandes.org>
In-Reply-To: <769AEAAB-7DEA-4D94-8979-F01EDFD6EE46@joelfernandes.org>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Mon, 1 Apr 2024 00:16:42 +0800
Message-ID: <CAJhGHyDjoQ3TrApksYJ5o1ooU4s8rzys2UnfF6EFzGwkaSVaKA@mail.gmail.com>
Subject: Re: [PATCH 02/10] rcu: Move rcu_preempt_depth_set() to rcupdate.h
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, x86@kernel.org, 
	Lai Jiangshan <jiangshan.ljs@antgroup.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <quic_neeraju@quicinc.com>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Zqiang <qiang.zhang1211@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 31, 2024 at 7:10=E2=80=AFPM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
>
>
> > On Mar 28, 2024, at 1:20=E2=80=AFPM, Lai Jiangshan <jiangshanlai@gmail.=
com> wrote:
> >
> > =EF=BB=BFFrom: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> >
> > Prepare for arch-specific-defined rcu_preempt_depth_set().
> >
> > No functionality change intended, but it has to be defined as a macro
> > as rcupdate.h is a very low level header included from areas that don't
> > even know about the task struct "current".
>
> Sorry I did not follow changelog. If some rcupdate.h includers do not kno=
w
> about task_struct, how does adding a macro that uses current help?
>

Hello

This is how macro works and it expands blindly based on tokens on the
usage-sites.

And rcu_preempt_depth() & rcu_preempt_depth_set() are not universally
used wrappers, the user can simply also include linux/sched.h to make
they work.

Thanks
Lai

