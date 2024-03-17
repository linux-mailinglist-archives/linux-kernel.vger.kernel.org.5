Return-Path: <linux-kernel+bounces-105434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D94C87DDD4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E021281461
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412691C69D;
	Sun, 17 Mar 2024 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="DQgoxYa5"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF051BDC3
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 15:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710688420; cv=none; b=G+KU6vpnunhQ55887YoIDLcSOrf+FZBK+GFervsBnchaf81aStrobOdXrxrVeOh9EJ9IiT+wZyF/XCsR5AdJuqNhsjN0YYZvRkxTU5gysZctqEAeIavmt58sIONcC3hn5ZZZ15g/sAG4AcAsirpc40EybEZTXGC1fFbVB7PbRS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710688420; c=relaxed/simple;
	bh=Gt+lY6pRptMm8ZA9CBoKi2ooYjBkp6ity5JEs+orlZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KIjO218A5Dho0POqhXGhRw+5Q1VeuVW2KEni3eqBp3ah9DXPGStwcLnE65wq8hZyMISPPqbDfhABM1yhYABL2N6QLwTqFreeb5QuqI+YbPED9YMFM35PT0aY2NrCljJljIYVlIeR6DVdrcIZRcmbYFezft+Y6xfl7eR6ohWQ/14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=DQgoxYa5; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c37e87756dso939583b6e.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 08:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710688418; x=1711293218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqyE8AYR7o1woUyJ2yyfRAKD+c3p9xsKcLbZwatY2CU=;
        b=DQgoxYa5LlQPfECAqyNJ40fsP7g4xkcm26j5u53Pt4JWKRx/nqZZs3iYfJMuw5JF39
         tAqBOBB08qBgOBMVQ2X8qiT/mVIE9lTdNNTH07EDrZsc/76aMeiAmPOORRy4wV99zfji
         tbjW4sIczcdIWyRK6vk40u7z1fmB3QYrYJ3WWEgJ+1Kdu59ayJFYalqqYszMvl6Gl7Wu
         CwpvmSudTLqvRXRS1EO5Smh67SZHjVJxM8iHLXhpQtV3UoYMELNEMgD0p+z0m+0mHGfx
         A/4mp1SigRCb6rTw0wtbgr1bazBfWa/ovsQN0aD/4d0G9avO45F24dleIrnLZonQmevs
         BivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710688418; x=1711293218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqyE8AYR7o1woUyJ2yyfRAKD+c3p9xsKcLbZwatY2CU=;
        b=bZhrbLNFYGMWWVF5N5kI6diNTwFnXLXCORxE+vk72r2ZXLtAoCNCiX73SE6HflPruZ
         AmMjNCP0SabWj/nwugYiUabW3/CWdCz31kyI8qrQ2rnv3x6vm2Jg7+aoEbtNIX9bEHHK
         PdLM68pPJk9GdzduL+yR6yjaZV12gNl5iloJ7LbfGUmlf3iE9tj1CNmiDVL45tHF+Rvn
         6Ddr4ITOZ50c5xLxI6LrqNP8wlbOuhN8EWhHn+PnU4Mde2ic/Ud65Q+3H+TuMpfC7tvR
         kVZzHDmH1pV0y3WreZUhMa+asd5l1XI0dURGlqqPbjRp/bHcTZKWGlLq8wQTlnEw9wYM
         eohQ==
X-Gm-Message-State: AOJu0YzpNp47qhXg2HQtf0jAmQjDQcTtGj/6yI6QzHUKR8FJtPuwBeZ7
	IecohVT97pn49klBgmjyBrSHav/7z9ICfTrmKiWcYGQhmvbwWHwBEyY+8jtYHwhZLp7uAmN0+dR
	pCzV3kg2fhv8YQUevFUfk9h6VO4e5SgX32+yBuw==
X-Google-Smtp-Source: AGHT+IGPHUCSTYlygmB6Ndfwdbw+GQseFpU34XAmr2qjd0eHmEGVN94ChCuTVyrHJIcNOVhJn8z7u3sCYCj42d23wgs=
X-Received: by 2002:a05:6808:e85:b0:3c2:590e:4635 with SMTP id
 k5-20020a0568080e8500b003c2590e4635mr12160371oil.34.1710688418020; Sun, 17
 Mar 2024 08:13:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-2-pasha.tatashin@soleen.com> <07e3705f-68be-40bc-80fb-ef81460f1674@wanadoo.fr>
In-Reply-To: <07e3705f-68be-40bc-80fb-ef81460f1674@wanadoo.fr>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 17 Mar 2024 11:13:01 -0400
Message-ID: <CA+CK2bDdF-V-uXkwwAuwRv7Yhd5Z5xK0nA7=HdpPwcBk+U_8JQ@mail.gmail.com>
Subject: Re: [RFC 01/14] task_stack.h: remove obsolete __HAVE_ARCH_KSTACK_END check
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, x86@kernel.org, bp@alien8.de, brauner@kernel.org, 
	bristot@redhat.com, bsegall@google.com, dave.hansen@linux.intel.com, 
	dianders@chromium.org, dietmar.eggemann@arm.com, eric.devolder@oracle.com, 
	hca@linux.ibm.com, hch@infradead.org, hpa@zytor.com, 
	jacob.jun.pan@linux.intel.com, jgg@ziepe.ca, jpoimboe@kernel.org, 
	jroedel@suse.de, juri.lelli@redhat.com, kent.overstreet@linux.dev, 
	kinseyho@google.com, kirill.shutemov@linux.intel.com, lstoakes@gmail.com, 
	luto@kernel.org, mgorman@suse.de, mic@digikod.net, 
	michael.christie@oracle.com, mingo@redhat.com, mjguzik@gmail.com, 
	mst@redhat.com, npiggin@gmail.com, peterz@infradead.org, pmladek@suse.com, 
	rick.p.edgecombe@intel.com, rostedt@goodmis.org, surenb@google.com, 
	tglx@linutronix.de, urezki@gmail.com, vincent.guittot@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2024 at 10:36=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 11/03/2024 =C3=A0 17:46, Pasha Tatashin a =C3=A9crit :
> > Remove __HAVE_ARCH_KSTACK_END as it has been osolete since removal of
> > metag architecture in v4.17.
>
> Nit: obsolete

Thank you, I will fix it.

Pasha

>
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >   include/linux/sched/task_stack.h | 2 --
> >   1 file changed, 2 deletions(-)
> >
> > diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/tas=
k_stack.h
> > index ccd72b978e1f..860faea06883 100644
> > --- a/include/linux/sched/task_stack.h
> > +++ b/include/linux/sched/task_stack.h
> > @@ -116,7 +116,6 @@ static inline unsigned long stack_not_used(struct t=
ask_struct *p)
> >   #endif
> >   extern void set_task_stack_end_magic(struct task_struct *tsk);
> >
> > -#ifndef __HAVE_ARCH_KSTACK_END
> >   static inline int kstack_end(void *addr)
> >   {
> >       /* Reliable end of stack detection:
> > @@ -124,6 +123,5 @@ static inline int kstack_end(void *addr)
> >        */
> >       return !(((unsigned long)addr+sizeof(void*)-1) & (THREAD_SIZE-siz=
eof(void*)));
> >   }
> > -#endif
> >
> >   #endif /* _LINUX_SCHED_TASK_STACK_H */
>

