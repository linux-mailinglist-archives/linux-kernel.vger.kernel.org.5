Return-Path: <linux-kernel+bounces-50277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EBC8476D3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959681C21656
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1A414D44A;
	Fri,  2 Feb 2024 17:56:39 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFBA14D441
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 17:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706896598; cv=none; b=T2+2gi+ple5HluBpyOOSm9p1YZWMgEiML6r5HeV1eRgqO+FW/Tpkb201IkZrjSQ9ew2ySBvta42wsGwcawY4B/w9ncQW8tIXf2NjCF3zPWdCkMdiKn+qoTMTdCbQEGalGFj6YNZq3c2fOTts/ys6pgEC3bFTg8vHtWtk+QwleVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706896598; c=relaxed/simple;
	bh=phAFNZZPmGx2zc9IiAbA6LFu0ZPJSvkRiA8xiTVjjGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oowaRn3SHyTbyjW1mu/IrPuBNiFi/KgVld/ZAh0m9Nywca+n3IP/SeX/L/gz4N9Ltoxb0eJ8YbzYezWkngxO6jhBDGSK4d+niuaC6DEZoIehSMWx+yByLXzXSl5fT4t6OezeUSzOgcHykvoLNUANqT6h/y80xGCWnXgOzIRdn1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-604055e48a3so25236047b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 09:56:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706896595; x=1707501395;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHiI7n9L5x9QjFf5E4GuXfXTQr01U8/QzTEzZYXlvg8=;
        b=qJejPnd0Bm3Jzc9r5rjAQ9vBewyOEis11C63gzFdwLeCXo5kTYcV17tYfIUYLVlv1K
         oDDJZD8Ce8Gdn8VGCYUGyCXtHP5ZyZcASL8V8ldjjyqE8Nb/OaSdeZVNE1xWMou1pf3N
         sUOdjXidALbbyYH1f9jK2nyN7GQMITH+G3FhtovoU6Bi593wI7sQvwjBChPC0bzOUJWF
         ecCJJJ0HmImgwO7o6zxEX3EH7UzXxq2ileV1AtnU2+8o1NnC4QhUZ7ldZwJnC7OC0+fH
         pdWq80IJmilUlzhOIbfQJZRVx9Lqda9+MerA5SkyrN87jAROAFfkFl/K5liVHA2NXxVZ
         Hobw==
X-Gm-Message-State: AOJu0YyY/q0wCd5gy+AMMxi7UVwjrIuNpoP1r3ZPcUxl8Vsf6KrkPBZO
	MvgqjaaKXb5R/KSfiQBoGq1/BJy5srl59U9Z0CCz8te+q9QtWt13
X-Google-Smtp-Source: AGHT+IHHlY9COXjNwtkaR+MnBX56/yMvA+qWDaWr6bovTKyc6ItZw4JlYWTey8wXf9cA7lJllrN+hg==
X-Received: by 2002:a81:84c1:0:b0:604:1c2b:5634 with SMTP id u184-20020a8184c1000000b006041c2b5634mr3442747ywf.20.1706896595458;
        Fri, 02 Feb 2024 09:56:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUh0OxakYR2cm4ijcv2HsMvNho8Cd3MzOlTKJdpp75KOziTfZAyQvv99Y0Ab6qutecK2obYxq+yICSZIybf1gDDHw7dsuew64Yqv2Fb/AI0Uhlb/nyPQixjdoEFjrEWcJIjjfVBN0j/V+R2zb6Wm6JTGh9BJGJd/J29mGLofMhuXjhk/8D3dVBsZB1IHL72Grdv5zdu4/m7fVEdDRRO0gmFyl+8UL2G2PlyrDYG9hSy1ShOOVXS/AOKPxSDCg/9MbKrayD8jLSuNuEHUKZAJcU0SSMXMaVQjdXwE6sgHn6BEQf4582FqLl7FndmGoS4s9MrwqmT4Oslm4hSljyy9uWeW4rxnAJaIg==
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id d20-20020a05620a241400b00783dd00d0f0sm845631qkn.117.2024.02.02.09.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 09:56:34 -0800 (PST)
Date: Fri, 2 Feb 2024 11:56:31 -0600
From: David Vernet <void@manifault.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, kernel-team@meta.com
Subject: Re: [PATCH] sched/fair: Simplify some logic in
 update_sd_pick_busiest()
Message-ID: <20240202175631.GB2242043@maniforge>
References: <20240202070216.2238392-1-void@manifault.com>
 <xhsmhwmrmhkbh.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20240202170712.GC2238525@maniforge>
 <xhsmhplxehiii.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jOWiPU0TXI0BALpG"
Content-Disposition: inline
In-Reply-To: <xhsmhplxehiii.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
User-Agent: Mutt/2.2.12 (2023-09-09)


--jOWiPU0TXI0BALpG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 06:40:21PM +0100, Valentin Schneider wrote:
> On 02/02/24 11:07, David Vernet wrote:
> > On Fri, Feb 02, 2024 at 06:01:22PM +0100, Valentin Schneider wrote:
> >> On 02/02/24 01:02, David Vernet wrote:
> >> > When comparing the current struct sched_group with the yet-busiest
> >> > domain in update_sd_pick_busiest(), if the two groups have the same
> >> > group type, we're currently doing a bit of unnecessary work for any
> >> > group >=3D group_misfit_task. We're comparing the two groups, and th=
en
> >> > returning only if false (the group in question is not the busiest).
> >> > Othewise, we break, do an extra unnecessary conditional check that's
> >> > vacuously false for any group type > group_fully_busy, and then alwa=
ys
> >> > return true.
> >> >
> >> > Let's just return directly in the switch statement instead. This doe=
sn't
> >> > change the size of vmlinux with llvm 17 (not surprising given that a=
ll
> >> > of this is inlined in load_balance()), but it does shrink load_balan=
ce()
> >> > by 88 bytes on x86. Given that it also improves readability, this se=
ems
> >> > worth doing.
> >> >
> >> > As a bonus, remove an unnecessary goto in update_sd_lb_stats().
> >> >
> >>
> >> Given that's a different scope than what the rest of the patch touches=
, I'd
> >> rather see this as a separate patch.
> >>
> >> Other than that:
> >> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
> >
> > Thanks, would you like me to send a follow-on series split into two with
> > your tag on both? Or were you just letting me know for next time?
> >
>=20
> Well, I'm not picking up any patches, just reviewing them :) So yes I'd s=
ay
> re-send with the split and feel free to apply the tag on both.

Sounds good, I'll send a follow up at some point tomorrow or early next
week.

> > We could also update this check to only do a strict greater than to
> > avoid unnecessary writes, but I figured it was preferable to have no
> > logical changes for this iteration:
> >
> > return sgs->group_misfit_task_load >=3D busiest->group_misfit_task_load;
>=20
> That's a good point, I don't think there was a specific reason for going
> with a lower-than rather than a lower-or-equal back then:
>   cad68e552e77 ("sched/fair: Consider misfit tasks when load-balancing")

Yeah, the goal is to choose the group with the highest misfit task load,
so it seems pretty straightforward that we don't gain anything from
choosing a new group that has the same load as the previous busiest.

When I send out the follow-on patch set, I'll do it as 3 separate
patches (unless I hear otherwise from someone else).

Thanks,
David

--jOWiPU0TXI0BALpG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZb0szwAKCRBZ5LhpZcTz
ZLTeAQDp8vOHWhXmypFIC6jR53ETfpojXRURZIZ7GzJQKDEjRQD9E8/5EgRW9nUv
gDYlB2VRA+JVJ7QHqRKXuMJxdM+GRAk=
=owuw
-----END PGP SIGNATURE-----

--jOWiPU0TXI0BALpG--

