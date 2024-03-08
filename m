Return-Path: <linux-kernel+bounces-96939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA17876366
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B97281DB9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD39456444;
	Fri,  8 Mar 2024 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6P/M8HP"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B138219FC;
	Fri,  8 Mar 2024 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709897832; cv=none; b=De9NcZqd2jBKswcwyscgiNa8rVQDhI1lxApz754ka9EXmj64Jrc45klM8qUuncvdF4opwEbcvO8yIS0mdqBdC9hbTCoAD9qx9WgQXqMJZezkud02SnxqpSeCWIAKQXBkNdo0cH1oPLJnowHj+TePvByL5N8IPpSZqsy672oHKLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709897832; c=relaxed/simple;
	bh=r3tglKe59vIyvT8ZyDzVlphGXnogsROYsYbXIF2U/lA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odBIEeC2HhuKy5Bi+Q1fcqK6ExOk4JFw4Hi3NGxS5xXnzqY/zMeVriV5FbcEjkrUlnB9rxkcpll+JGlCz2xBOiiRJoDitQuu82+h9et3LVK6Bwpjm1xGvCXDJCRahDykqcvjuL4KBonIIL1w7zcQVDJIzlpHWvm9HYWl3145YEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6P/M8HP; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d26227d508so24384351fa.2;
        Fri, 08 Mar 2024 03:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709897828; x=1710502628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zs62TPjSNd+kIv+reGSsUWDqoWMkgwQ7Wh+0LVnbj0=;
        b=W6P/M8HPH5gomcM8e6gzJZ3Op0ES4z70iVmKWCZmEiRjdSdXYgcCE4ssa66+lhw0LZ
         UqT5oBqVuVBxGzKR3uaaUwrvEE+SC1YhHpKqXA5gZqVtOBiIBwIwwYL2Ns9k12CJ+abf
         kaziyBkGnMDBYkE3Lex4JRSu7VWSlNjaZwPy3h82AR0jSI75WRqBQAXK+oUg9XI77fpA
         jhRHP2UN/PzbhtHxSqA6Xa+fSum80aq219HIH3zFEpTP61/3S7LTHsXGfY/UrMj3LCDj
         csACAh/nTSUiTzNxqLIOjQexa6l8J2XEIeOPl/UXHiuwNa0m4sWSCuOh5WgKLsMLIS3t
         YH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709897828; x=1710502628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1zs62TPjSNd+kIv+reGSsUWDqoWMkgwQ7Wh+0LVnbj0=;
        b=EWAV9KQrXaa6126vzK/SWVGz5esDHZhzvAORm6dj5v4DNfrGCqAGWh9ki89t1ZciQu
         YlHM5zQHr/Kv8a4NQ72bAfP6wZ4EWbQ+aOoH79Yb1ayw11qGSLq0iNBkZBGGvUmKyj/O
         OKfapeZ+evyemVPFINKcUdLDXGL/RI/478j48e1K3Kjug50vrZEdQZ21z6qgPtnZPwd3
         5oPS/neUykmm27ory9oLotiuPJQ0hsIXInlSeh2BC75PvyZ2SPfMCCJuryekTredANmh
         5fIgCjUEzWNjV4BVbWG0zS7q0plXsXq+3ZC741KV0WtqlsGtbrd829PPvQtTly70VL75
         Io5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVU86BpXhHxfGmvLDiYcvt0F6AHI+BdmLHW98NJc3xs2xNx1pAjzd1XhdElJfqXCgrF1LUqvUduHMCcQVqWlwXJVFqwJU7wEUNc1GZDQdSGU6d5KVDvZmPnFJja8lTULnloS4XwelUFUPoZhSw=
X-Gm-Message-State: AOJu0YwTyf66v0VVCb3ONw0ZIxfelFJKDVurT10Hgm1H9h/WJCPnVi2i
	JJMU0cX2Pk/eAJ3Wx72MKD2L5oIJpTrb7So8GJjs+EwVKZQsoxstci6B6jUbVB3q14OGK3aip0y
	68FUDp66lOWaWw5ZHy1jMzzJ8hSM=
X-Google-Smtp-Source: AGHT+IFzVYyHRpoSiZ8DyfDoy9aXmmsxZKChagv90jBF0wl/SOHe/5QpuXp7grfKpr6h5EBztybPYeQ4PO0z+AWcJK4=
X-Received: by 2002:a2e:2d01:0:b0:2d2:a56c:84ca with SMTP id
 t1-20020a2e2d01000000b002d2a56c84camr3376023ljt.9.1709897828245; Fri, 08 Mar
 2024 03:37:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307223849.13d5b58b@barney> <20240307232927.171197-1-rand.sec96@gmail.com>
 <20240308060943.2410ef2e@barney>
In-Reply-To: <20240308060943.2410ef2e@barney>
From: Rand Deeb <rand.sec96@gmail.com>
Date: Fri, 8 Mar 2024 14:36:56 +0300
Message-ID: <CAN8dotkp7tQ6znKM5=1iM08hLvjLK-VbQm9LuqcGBf0e3ok=kg@mail.gmail.com>
Subject: Re: [PATCH v3] ssb: Fix potential NULL pointer dereference in ssb_device_uevent
To: =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>
Cc: deeb.rand@confident.ru, jonas.gorski@gmail.com, khoroshilov@ispras.ru, 
	kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org, 
	voskresenski.stanislav@confident.ru, james.dutton@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 8:11=E2=80=AFAM Michael B=C3=BCsch <m@bues.ch> wrote=
:
>
> On Fri,  8 Mar 2024 02:29:27 +0300
> Rand Deeb <rand.sec96@gmail.com> wrote:
>
> > On Fri, Mar 8, 2024 at 12:39=E2=80=AFAM Michael B=C3=BCsch <m@bues.ch> =
wrote:
> >
> > > The point is that leaving them in is defensive programming against fu=
ture changes
> > > or against possible misunderstandings of the situation.
> >
> > Dear Michael, I understand your point. It's essential to consider defen=
sive
> > programming principles to anticipate and mitigate potential issues in t=
he
> > future. However, it's also crucial to strike a balance and not overburd=
en
> > every function with excessive checks. It's about adopting a mindset of
> > anticipating potential problems while also maintaining code clarity and
> > efficiency.
>
> Removing NULL checks is the opposite of maintainability and code clarity.
> Efficiency doesn't matter here. (And besides that, NULL checks do not alw=
ays mean less efficiency.)

I respect your opinion, but it seems we are stuck in a while(1) loop
without a break. Again, I don't agree with this. Adding a redundant null
check goes against code clarity instead of enhancing it. Just because the
condition checks for null does not justify its presence if it's redundant.
I could insert this check every two lines.
You advocate for this approach based on the potential occurrence in the
future. However, this is one of the reasons why there are reviewers like
yourself are responsible and authorized to approve or reject patches and
verify their integrity before acceptance.

> > > A NULL pointer dereference is Undefined Behavior.
> > > It can't get much worse in C.
> >
> > Again, If we adopt this approach, we'll find ourselves adding a null ch=
eck
> > to every function we write, assuming that such changes may occur in the
> > future.
>
> This would be a good thing.
> Let the compiler remove redundant checks or let them stay there in the re=
sulting
> program, if the compiler can't fiure it out.
> Checks are a good thing.

Our discussion isn't about what the compiler will do; I know that. The
discussion revolves around the code itself. Alright, let's add a null
check for the 'env' parameter as well. Perhaps we could even automate this
process and add null checks for each function in the file.

> > > Your suggestion was about REMOVING a null pointer check.
> > > Not about adding one.
> > > I NAK-ed the REMOVAL of a null pointer check. Not the addition.
> >
> > My suggestion was to remove a (REDUNDANT) null pointer check, and not a
> > null pointer check, there is a big difference.
>
> No. There is no difference.

Yes there is !
The check is literally redundant. Whether we keep it or remove it, the
outcome remains the same. In this case maybe it's not a big deal, but
adopting this approach could lead to an accumulation of redundant
statements throughout the codebase

> > However, if the reviewer encounters this check, they
> > might mistakenly assume that 'dev' could indeed be NULL before the func=
tion
> > call.
>
> So? Nothing would happen.

add completely unnecessary confusion?

> I will not ack a patch that reduces code quality.
> Removing NULL checks almost always reduces the quality of the code.
Even at this point there is a misunderstanding. The whole discussion is not
about the ack because you've already given it to the first version.
The discussion is because i'm interested in knowing different points of
views.
I think this discussion took more than its time.
This represents your personal point of view, with which I disagree.
Thank you again, and you can do whatever you want, continue with the first
or third version of the patch.

