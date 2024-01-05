Return-Path: <linux-kernel+bounces-18376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEB2825C2F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85038B2399C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA1B360A0;
	Fri,  5 Jan 2024 21:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a8T5JbaE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C71636093
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 21:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-336dcebcdb9so27438f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 13:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704490917; x=1705095717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkR205sUpUsUJgjcHWSrrYckQvl1gsGMJ7ruJmNqaG0=;
        b=a8T5JbaEjgRD7TKdjJzSvXq5jkBvfU7ZUfAXia7wJzr539Uon0M0KlxHT0xl6O7pU3
         SW5NOJ33mMWW13t0mZ+HNp8/hbnfuRFD8gv2hG194IvRXGIRvLYpPSfA3ntpOFqhqB6R
         qePn98Wl6Nn7PRgXomgS0QugSLcXv9qMALA/Lh/FwxnP70PBU6EKY+iV+C+61wNJFbAz
         vGiQowU6v599muf068qb6l8F+R24KoWfgxJmpa6gCr6MyAOESp+UFEXb+xoinRLgXdDL
         FlmaHbkWA6V5XEgeU1f2EE9SRWqRWnTSiz3dheZhfb/xQq+kVnSBo/FDRZhY48Faml2G
         a9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704490917; x=1705095717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkR205sUpUsUJgjcHWSrrYckQvl1gsGMJ7ruJmNqaG0=;
        b=hW8DiRi6UTG3Hk/J1XGgARp1fnuoPvtoR9zbsN2waDaCCZLlqLJ4d23hnxVMIq+b6l
         Dh+FLmXSN0WuXJYicMTT96g1YXLsnGOsbVJE6XYYVWsq3iFbPdmUsUcQJVfwIAfPzB7z
         5nv+k4Nn90wdhLgB3s/TJtCo7iydXsJt6oo6EBdsOChYUhE33KW282ZtJMuV5qQsyyTx
         2pLalAHKk/PYrpq4Y9q1bpg4rN0IQsS+O4F11ZbbTmXUy6e1mXnzk36VX+g1sWg24Pv4
         boiir38JBoy9r3El7ZLi83LQcpZU/XpARen5ZwZRN/obXJGKjSizpxH6KLmh0cLy4Zx6
         OzWQ==
X-Gm-Message-State: AOJu0Yz1oKUNVmnbnGfXyH2ORCw4lnVn6dR0VPQ1r6zH9MNjlvYMQGfF
	zSM5bwjtYzAxiUX0JKo1A1mqdfAZgM83EDMZbaBguNR1VRda
X-Google-Smtp-Source: AGHT+IEVQuhZ57a0OHJRpfTSH+a/jt4JulueTBoHz9clH50NEWTtsOgVpTOZ6ZqnmmExu1S4z5hf6dJnLnBe9uA4+B4=
X-Received: by 2002:adf:f80e:0:b0:336:787d:af5 with SMTP id
 s14-20020adff80e000000b00336787d0af5mr21842wrp.284.1704490917500; Fri, 05 Jan
 2024 13:41:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105-newemail-v1-1-c4e0ba2c7c11@google.com>
 <CAKwvOdnbc0Z8poK400k8dhDNjNcpWC8LsbeOSdZ5XxLm=W6k6Q@mail.gmail.com>
 <CAE-cH4oTTfxfGvkGCFrpCiSUOSUyL2W=isbkE+jHcRshWKnb+g@mail.gmail.com> <CAKwvOdnYT2HM9XSRtFg6KkMEEDtq6muCpVGoqgPgE4sOe8H9iQ@mail.gmail.com>
In-Reply-To: <CAKwvOdnYT2HM9XSRtFg6KkMEEDtq6muCpVGoqgPgE4sOe8H9iQ@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 5 Jan 2024 13:41:46 -0800
Message-ID: <CAKwvOdnyMCQq5qSe4xWJN8kjS2movShtvYoprucxt4ydojQB5Q@mail.gmail.com>
Subject: Re: [PATCH] mailmap: Switch email for Tanzir Hasan
To: Tanzir Hasan <tanzirh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Nick Desaulniers <nnn@google.com>, Tanzir Hasan <tanzhasanwork@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 1:41=E2=80=AFPM Nick Desaulniers <ndesaulniers@googl=
e.com> wrote:
>
> On Fri, Jan 5, 2024 at 1:38=E2=80=AFPM Tanzir Hasan <tanzirh@google.com> =
wrote:
> >
> > On Fri, Jan 5, 2024 at 1:35=E2=80=AFPM Nick Desaulniers <ndesaulniers@g=
oogle.com> wrote:
> > >
> > > On Fri, Jan 5, 2024 at 1:31=E2=80=AFPM Tanzir Hasan <tanzirh@google.c=
om> wrote:
> > > >
> > > > From: Tanzir Hasan <tanzhasanwork@gmail.com>
> > >
> > > Hang on, ^ has a different From than the email From.  Did you change
> > > the authorship to the new email addr?  I don't care which you use but=
:
> > > 1. they should match (author and from)
> > > 2. verify your new email with me (mentioned below)
> >
> > I didn't use git commit --amend, I suspect that b4 might be picking
> > this up?
>
> Ah, perhaps.  Either way, I verified that Tanzir is the owner of
> tanzhasanwork@gmail.com.
>
> Acked-by: Nick Desaulniers <ndesaulniers@google.com>

Wait, I think .mailmap is sorted! Plz fix!

--=20
Thanks,
~Nick Desaulniers

