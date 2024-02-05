Return-Path: <linux-kernel+bounces-52876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013E0849DB3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53558B257EA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617DF2C6AC;
	Mon,  5 Feb 2024 15:10:49 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC682C69F
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707145849; cv=none; b=qXE+yQ4V58MKjfZcjLpHGjX3gvL8JD9QBfBpJozarsh1LmUqCbpColn3n/cOq/tQWZ82XY2c/VP1PI6IGu57DK4hTcVF+kKdRWvQClhBRM1/8FpnDuRBIHfyWz/b3/KNvlXfcNAQe+CfjIoDw7sXitRNLv0K7KKPGw26Afyt4AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707145849; c=relaxed/simple;
	bh=fpyKWVvtKNgZoyG8a4zS1CHYGjQnu2fxk6TPe0Uc5d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZpCX4uN4Ir3m4KhRHfZ743PUmwXLg/PPGWeGggJzqXMvZeR4HohgDcVe6yxPgbSOYgnQyXIQmBi762MdD1UJzQJ9IoOz2tIjt3JYwY5TLF4gIaSGvV7uZIA+GGNc5dKbMXPeGUTU4BMRdPcb2JowVnbAxIM3zP4V4Oap4X/I5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6818f3cf00aso25423836d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 07:10:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707145845; x=1707750645;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpyKWVvtKNgZoyG8a4zS1CHYGjQnu2fxk6TPe0Uc5d8=;
        b=CjVyfNrJm9acdBSu6d6mj94AmSCAGqP8n8S9PRG+/WxKEvz7HKr/DYhgZmRima1z1U
         lliVT8HkpfrG0GjogfSnLA3BT166WCKsuAt0NUxy7oV9xt9mCDOdq0RyKG82vZxB049u
         arhR+dQ+xbYAEkqO2Ox0LJXOdnbJba/X1UIsG6T0LFP4JJ1vxa33Ht8dpwsZhWzkgGpR
         bf8o3znntIn8UYVxPf1jSuhp/VQ1s+WR7ciAFw3EP9Es1gTy0HqpbHrDd7+ikCqsQWod
         XT535JMhIwm2TrDXcCe/M0s6jp3CzzQleiM1HjCgKswCUfkoctd9Jxi5K5Q9TWGwauhV
         aplw==
X-Gm-Message-State: AOJu0YzOvn+x0AGTbXKloaYlOvaQsr880XJdaaeuijkZvfyDNuttzqtY
	u0ILVMIWsDi1b1kYaFLC6MZX/hs3rf4PsIFE4gGxesoF2ouaI3x6
X-Google-Smtp-Source: AGHT+IHEUnttdNw8gm6+5Fxxg+hSsfAiYrZDL+QZ1tV92GXUhpat5XPLDhpF91+EJCVlQ4olqMvksw==
X-Received: by 2002:a05:6214:ca9:b0:68c:9cb7:b190 with SMTP id s9-20020a0562140ca900b0068c9cb7b190mr5680557qvs.54.1707145845081;
        Mon, 05 Feb 2024 07:10:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWY0ZAENfsIiaV7CYl3KiRJVon+YfZVwBUdYGwP6HhlZLAtQo5j64T1GWnhIxVgWoZLwznki3vEjEw+r4ytMY0DWS4zrQ2jsJWGAd6KJfC4HyHo1iLZ4eUW8aVPLXD4FBk/YnVqzFa67xkRzwtsMTK08nAb3y6PzviUeZO9ecGjozR2jllR1s4m8YqbJGPa0egRhKMin/xtNT2vmJqdfzdYeY13gg0JSbC39KaGN/k17/6q6QIJ2R1eSo/biGxMpKDQj9KIf6Oi5qtP5wCtkLJiUS5ioO09MuD3NGOHgIq5YmKPerWBXwUDQoVtHGgL6uE0bEbil13PsAMDOvItkN1v
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id bp14-20020a05621407ee00b0068cabe94ea2sm47937qvb.69.2024.02.05.07.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 07:10:44 -0800 (PST)
Date: Mon, 5 Feb 2024 09:10:41 -0600
From: David Vernet <void@manifault.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, kernel-team@meta.com
Subject: Re: [PATCH v2 3/3] sched/fair: Simplify some logic in
 update_sd_pick_busiest()
Message-ID: <20240205151041.GD120243@maniforge>
References: <20240204044618.46100-1-void@manifault.com>
 <20240204044618.46100-4-void@manifault.com>
 <CAKfTPtB5NbvJt58zpi9aM-8kOxchgzYccY03wUEQLypaWjUXew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UEH2QWNLig8kLnOw"
Content-Disposition: inline
In-Reply-To: <CAKfTPtB5NbvJt58zpi9aM-8kOxchgzYccY03wUEQLypaWjUXew@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--UEH2QWNLig8kLnOw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 04, 2024 at 12:48:11PM +0100, Vincent Guittot wrote:
> On Sun, 4 Feb 2024 at 05:46, David Vernet <void@manifault.com> wrote:
> >
> > When comparing the current struct sched_group with the yet-busiest
> > domain in update_sd_pick_busiest(), if the two groups have the same
> > group type, we're currently doing a bit of unnecessary work for any
> > group >=3D group_misfit_task. We're comparing the two groups, and then
> > returning only if false (the group in question is not the busiest).
> > Othewise, we break, do an extra unnecessary conditional check that's
> > vacuously false for any group type > group_fully_busy, and then always
> > return true.
> >
> > Let's just return directly in the switch statement instead. This doesn't
> > change the size of vmlinux with llvm 17 (not surprising given that all
> > of this is inlined in load_balance()), but it does shrink load_balance()
> > by 88 bytes on x86. Given that it also improves readability, this seems
> > worth doing.
> >
> > As a bonus, remove an unnecessary goto in update_sd_lb_stats().
>=20
> The line above is not relevant to the content of the patch.

Ah, thanks for catching that.

Should I send a v3 of the patch set? Or should I just let whomever
applies remove that line?

> Other than that
>=20
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks,
David

--UEH2QWNLig8kLnOw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZcD6cQAKCRBZ5LhpZcTz
ZPMwAP0SnSO7/DMjdqfi6y8VLiWP7NqgRp5M8t7ljMgXl2Dz6wD/fIq8Rk7xK/2f
A/4uSvbmiWD+YTbJSjC2O6ry/+8csw4=
=alps
-----END PGP SIGNATURE-----

--UEH2QWNLig8kLnOw--

