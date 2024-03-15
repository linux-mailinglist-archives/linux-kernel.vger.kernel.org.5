Return-Path: <linux-kernel+bounces-104931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9F587D607
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B9E1B217C7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6010854911;
	Fri, 15 Mar 2024 21:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WASBOIO/"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB00C548F0;
	Fri, 15 Mar 2024 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710537432; cv=none; b=oSnymNfDzb020l9NOeeXZT/FrhOrWXtzr5hQTU9Lxy+e1dLFV7HRCHno/Kz+mPbymGXc/6Juli3ovfod5FthB69OUQlIuSPuJ7Kst0xEIRlp2MF6+g+XxoNv3lI58Eu7ZL89OY/bTa+JRkuYmojczb0GWHRlq2dX1yerRgtXi0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710537432; c=relaxed/simple;
	bh=hwD/lGz/VzatlOJGLNO2bM+DjLMZEkNqMUkR6QXjBvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EmKZ/0zBU5JIcy+mcbEoRyI53l+J2EZXBMeF7QvaEl212I6eO6XaXzzTzD1M7vbyJI/x3GWnp9sGfPmNeWCeifu46rHWOYi5sKqAFxV7UFXclb3xtAJFcJJ4yZ8NsZaFnPgeCDrkl0cJwadGATnk3jjJk/H0YerOqv6SExCltAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WASBOIO/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dd9b6098aeso19215645ad.0;
        Fri, 15 Mar 2024 14:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710537429; x=1711142229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbw37BmJsQeVdqK1E7BHtnCUQp5XmW43FRTZzRfLqog=;
        b=WASBOIO/mk8BOl/FGa78H6u+IUALpPqN0Qt30t5ECct3HdZ2wqtwhtbXDrna/n3cGk
         pjkV2cgD+E4iIS7AWk0dZK4cbRBKGCew5xYlHuZBhU5TDuQGpQxJmbjjgTaRuSiWJcO8
         1W52bLKcN7cutPxLcPNiE3iaZqCqfdncGMBjnvRPS4uGwcsGvldPD2uhiMUbwgz922cv
         +kftX/2jr4wZVspG8EM6NeiYBnjCF36rooC3Uv9BIMjcmwYoPSlE2TpqMen9Ea4Us+2j
         nXnAo7ZLQjBRfdDiFjEEfs/yw0wJ5hUlEipiKTa13lOSUMgpPIQ2L9F01DIfBdVEizyE
         wQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710537429; x=1711142229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbw37BmJsQeVdqK1E7BHtnCUQp5XmW43FRTZzRfLqog=;
        b=PGDhIhJV4YAlspWfXXC/d5bmOLA7U1z5aOHgzFqMa7UPaQg12iQNGsMHTau5Fg43zY
         tJFwVfeH8tmEO1j9uhK78PqCACITHBWAEJYY0GFxEYOumkVgH4lv/xR4oX+qvctmXxF/
         zvBu80oL6k5QngESVgi/IX8PH4u06e5YUEsSxKjnvYjZKdPn8nlsLf32wyTyzKn5EjNS
         5mnitQd/spRNEZugvyo//rJhG3TdYVcLAXkfMUTbhMozblLG8o9b+BIrNdRjEhGNs8m8
         y7Bho6R5r0daRuRqL28/5ZlKXzO/AkJ633CTLtCNeGGO/A3zuGomJ+6FddmnuKelmt92
         KnUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt5opfCpfN8eT27H5L4ewgTcJdG9ZfmtqSKhC+W6KrBvqntatXtqmdbv0idSB7/CQZadO2Z+LtFlrCJ1tbGP+jslygs74lgwHQWxsxj/Jxs+DgJDRYldMwstjK/m/XdUszVqqE92yT1dyDstEYtE4yuXS68OX3ISHOoRjhTp290Zwt6z8nU0XGbcJxT5TgNYQjpRLbrvtDZi4vfdzVlKUDVETK1Mo=
X-Gm-Message-State: AOJu0YxkEMw31ZKbxzXmWGOQt2SgtTNAaXZie8deiejH08uOYTdoDbmA
	2m0JLl78RDINLPjjHNG+Ctc9vMgHgrxO8H/iwZ/s0SndIQs5csEl0IaLLnAZ/oSbvAlnRUL7A5p
	fuCXdUF2iPoOdZSAdNL3V2SrS+FEAxM+n
X-Google-Smtp-Source: AGHT+IGbDe8TDqWhW7fOhXA2CHqs3losvmxFx7BFSa9/+mgxC9s6/F3YiXoF2pn+xPEHeBz0lVW6B8iNIstOBbhkgns=
X-Received: by 2002:a17:902:6e16:b0:1dc:ca1b:279b with SMTP id
 u22-20020a1709026e1600b001dcca1b279bmr5438447plk.1.1710537428873; Fri, 15 Mar
 2024 14:17:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315113828.258005-1-cgzones@googlemail.com>
 <20240315113828.258005-2-cgzones@googlemail.com> <CAEf4BzZF0A9qEzmRigHFLQ4vBQshGUQWZVG5L0q2_--kx4=AXA@mail.gmail.com>
 <0f8291f7-48b1-4be1-8a57-dbad5d0ab28c@kernel.dk>
In-Reply-To: <0f8291f7-48b1-4be1-8a57-dbad5d0ab28c@kernel.dk>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 Mar 2024 14:16:56 -0700
Message-ID: <CAEf4BzbgQrYDMma=NbW6A-qikA693eSnz9-RwjkF3xPLRE8qqg@mail.gmail.com>
Subject: Re: [PATCH 02/10] capability: add any wrappers to test for multiple
 caps with exactly one audit message
To: Jens Axboe <axboe@kernel.dk>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	linux-security-module@vger.kernel.org, linux-block@vger.kernel.org, 
	Serge Hallyn <serge@hallyn.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 11:41=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> On 3/15/24 10:45 AM, Andrii Nakryiko wrote:
> >> +/**
> >> + * ns_capable_any - Determine if the current task has one of two supe=
rior capabilities in effect
> >> + * @ns:  The usernamespace we want the capability in
> >> + * @cap1: The capabilities to be tested for first
> >> + * @cap2: The capabilities to be tested for secondly
> >> + *
> >> + * Return true if the current task has at least one of the two given =
superior
> >> + * capabilities currently available for use, false if not.
> >> + *
> >> + * In contrast to or'ing capable() this call will create exactly one =
audit
> >> + * message, either for @cap1, if it is granted or both are not permit=
ted,
> >> + * or @cap2, if it is granted while the other one is not.
> >> + *
> >> + * The capabilities should be ordered from least to most invasive, i.=
e. CAP_SYS_ADMIN last.
> >> + *
> >> + * This sets PF_SUPERPRIV on the task if the capability is available =
on the
> >> + * assumption that it's about to be used.
> >> + */
> >> +bool ns_capable_any(struct user_namespace *ns, int cap1, int cap2)
> >> +{
> >> +       if (cap1 =3D=3D cap2)
> >> +               return ns_capable(ns, cap1);
> >> +
> >> +       if (ns_capable_noauditondeny(ns, cap1))
> >> +               return true;
> >> +
> >> +       if (ns_capable_noauditondeny(ns, cap2))
> >> +               return true;
> >> +
> >> +       return ns_capable(ns, cap1);
> >
> > this will incur an extra capable() check (with all the LSMs involved,
> > etc), and so for some cases where capability is expected to not be
> > present, this will be a regression. Is there some way to not redo the
> > check, but just audit the failure? At this point we do know that cap1
> > failed before, so might as well just log that.
>
> Not sure why that's important - if it's a failure case, and any audit
> failure should be, then why would we care if that's now doing a bit of
> extra work?

Lack of capability doesn't necessarily mean "failure". E.g., in FUSE
there are at least few places where the code checks
capable(CAP_SYS_ADMIN), and based on that decides on some limit values
or extra checks. So if !capable(CAP_SYS_ADMIN), operation doesn't
necessarily fail outright, it just has some more restricted resources
or something.

Luckily in FUSE's case it's singular capable() check, so capable_any()
won't incur extra overhead. But I was just wondering if it would be
possible to avoid this with capable_any() as well, so that no one has
to do these trade-offs.

We also had cases in production of some BPF applications tracing
cap_capable() calls, so each extra triggering of it would be a bit of
added overhead, as a general rule.

Having said the above, I do like capable_any() changes (which is why I
acked BPF side of things).

>
> I say this not knowing the full picture, as I unhelpfully was only CC'ed
> on two of the patches... Please don't do that when sending patchsets.
>
> --
> Jens Axboe
>

