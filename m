Return-Path: <linux-kernel+bounces-156167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645498AFEB9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E53528A1D9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319B8C138;
	Wed, 24 Apr 2024 02:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJ1jgSca"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BDADDD7;
	Wed, 24 Apr 2024 02:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713926837; cv=none; b=HCEwtVxplBjC0hJj+Dje0Wsh9Rr49Eq4TR5UQBbqaLyCC/oi28qkQ8kxTxIBVX+SrlPycjt9uID20uVgp+iMTKGMWw9TkgUIwLJc/qY8hhgDkNwW5aPzsSQPUmV2meiaXr7Q65IljqOlWgDBE1S6g8w/8m3Mf5rl52sFskYsUj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713926837; c=relaxed/simple;
	bh=aW9QjOZxUq1CXz5OPtMFqXBshrzsl24lbOThqhik7eQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgyjfXERmFlMsprTrw7R2B+LDNVpBDelMia/pNz07eBUL2nLGK6iCXM7oDAE/ZOgy8WmC5hzMjU59BDUeGBWg61dxY6zy4mEF2yP5cjEerxMHxh91SW5XaVUpLsSRhMznXf6h2v/7XKRHNNHGuyV9T4hL2eVqaN5JhWGmhvzaF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJ1jgSca; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2a78c2e253aso5039396a91.3;
        Tue, 23 Apr 2024 19:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713926835; x=1714531635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXkLM1FkKW7lL5+iv6VksWN76QjCOZFWNl9wI9RaxME=;
        b=EJ1jgScaAnIkBVR62GS3kZTnt8HgB0f6WTmKb+IX7eZ83AzhHKcSq1srwTDHvgSMxY
         VBMRWcwxAJg0+HqJIxA+Fk4x6gLLSzoiv6cnnHInKnOcC2aBf6D0B8BavJCyC6B3namv
         PAIUF3Cw4VC8olX9eaF8fdIdPJOtSEvYK5nKBKkMCjdo9x2XduI40dYT5nPW6DlaLYbQ
         0xArKkhN3xMoNWLQIOoCpvjcGrhEsSXqanZqp8LhglO1WVjbNzmkoPg2Rjrc1UIdkiVo
         +KrHIuqcTotvxyvxCNlhU0YWrjQj71EOU2aA5fnFOXVxHeQhywDEFHs29bJ/3oLaqTCj
         Ki0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713926835; x=1714531635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXkLM1FkKW7lL5+iv6VksWN76QjCOZFWNl9wI9RaxME=;
        b=o8ApYNe93QZoWqizpaNKWLWovmb+ddLtMpYRWszlCEkIik5h8PFHq9Tgz2SYmkzcrw
         yeqylh5/SuPS5P0IkaPnpFJF2bvwacK3+YlITVh9jScbRqvzj9GrW7cWFga6C6sIPPq8
         Mk8xsPhVcKQrVuOwMxuozKGQ5GMD6oNzhqvHbmAxgHaSXXEdaUq/gxSr7dynvNC92hUl
         I/P94v89Iyt5zx6kMpiEoh156XwRcDIL1Ytx74HMU/OfctFi83OK5J9E3iVYzlTfBL4j
         u1Ia8p6tmcPwCV6RjC91qjUEC2CBK/35NN/ZatgcM11I39m445Ag8XJ4jS+5ylvD/QkG
         deHA==
X-Forwarded-Encrypted: i=1; AJvYcCVwgOoXQPMfg0rNMacz6yFizIZyjNwzSsqRej35KmE5XfVEcRYaWbvCLv7WbMlk3FEGOeR/3ax0FmUne5TXSvJdK9IU
X-Gm-Message-State: AOJu0YyCnV4uQ5Km0DjaEOYR9LNUFWtKN52vBsu0guExUH0j90pfTWi8
	7jj2AuKe3PnjkhR3Xf3aViqoQqcCpzzhAZ7naYKxFu57UUoHP6vaKPySQiYgvtQj3tNQ88aaeWN
	Fu7ymcrIgvLRUIj/WnaAbc3N1snc=
X-Google-Smtp-Source: AGHT+IF7B6IXhe6a4ebfZwzaKW3gv0klAJb12GGo4Nk4A7NGsGQwWr4sW20qyiqsST9CEu+82Inmukj+01hI6yO5mVU=
X-Received: by 2002:a17:90b:3448:b0:2a4:ca45:ded1 with SMTP id
 lj8-20020a17090b344800b002a4ca45ded1mr999701pjb.28.1713926835270; Tue, 23 Apr
 2024 19:47:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407090558.3395-1-jiangshanlai@gmail.com> <20240407090558.3395-4-jiangshanlai@gmail.com>
 <CAEXW_YRjuWMLvmZ_oVHEe837gPAyjBs5OMvZc=T1PXYB0apNmQ@mail.gmail.com>
In-Reply-To: <CAEXW_YRjuWMLvmZ_oVHEe837gPAyjBs5OMvZc=T1PXYB0apNmQ@mail.gmail.com>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Wed, 24 Apr 2024 10:47:03 +0800
Message-ID: <CAJhGHyDrUu6g1J=ebVCUZDZBbL0FX0RZ-D6sPufs+Ek8_fkcSA@mail.gmail.com>
Subject: Re: [PATCH V2 03/11] rcu: Reorder tree_exp.h after tree_plugin.h
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, x86@kernel.org, 
	Lai Jiangshan <jiangshan.ljs@antgroup.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <quic_neeraju@quicinc.com>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Zqiang <qiang.zhang1211@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 1:58=E2=80=AFAM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> On Sun, Apr 7, 2024 at 5:03=E2=80=AFAM Lai Jiangshan <jiangshanlai@gmail.=
com> wrote:
> >
> > From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> >
> > Enable tree_exp.h using some rcu preempt macros introduced in
> > the next patch. The new macros touch core rcu-preempt fields
> > and are better to be implemented in tree_plugin.h.
> >
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> > ---
> >  kernel/rcu/tree.c        | 2 +-
> >  kernel/rcu/tree_plugin.h | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index d9642dd06c25..57d1ae26861f 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -5245,6 +5245,6 @@ void __init rcu_init(void)
> >  }
> >
> >  #include "tree_stall.h"
> > -#include "tree_exp.h"
> >  #include "tree_nocb.h"
> >  #include "tree_plugin.h"
> > +#include "tree_exp.h"
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index b1264096d03a..d899b4afc21c 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -103,6 +103,7 @@ static void __init rcu_bootup_announce_oddness(void=
)
> >  #ifdef CONFIG_PREEMPT_RCU
> >
> >  static void rcu_report_exp_rnp(struct rcu_node *rnp, bool wake);
> > +static bool sync_rcu_exp_done(struct rcu_node *rnp);
> >  static void rcu_read_unlock_special(struct task_struct *t);
>
> OK with me, but not sure if the reordering of header inclusion is
> needed? You could get the same results by just adding declarations of
> the new helpers to tree_exp.h.

The new macros (in later patch) touch core rcu-preempt fields
and are better to be implemented in tree_plugin.h.

>
> Not sure if tree_plugin.h needs to be included last, I for some reason
> thought it needed to be - but looks like not. I found a thread that
> shed some light into the header file including C code thing as well,
> which may or may not help:
> https://lore.kernel.org/all/8ab3ca72-e20c-4b18-803f-bf6937c2cd70@paulmck-=
laptop/#t
>
> Thanks.

