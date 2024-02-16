Return-Path: <linux-kernel+bounces-69259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31346858651
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70561F24710
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE971369B0;
	Fri, 16 Feb 2024 19:44:46 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957A4133439
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 19:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708112686; cv=none; b=gWEP+mrPJpb7paHRBvHMutQS+UlqBAvtJY7mXKVZHPYXoqR+Ue9TKwJ/aiNBAeggOtpMK7+PFYcv8P0KsENVzYzKRiOQBRhv+LFj7FBiY7WXeLmmf/p8nmaDjZIyLw8Mi0eN6g9kFeSOS0Mbq/oVxZJyBstC3fZM8RWh64j03hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708112686; c=relaxed/simple;
	bh=eR+3kCfvfZgbRZuV/OFCPctWATJWKmCIkivthZQ2kqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDUaKW0kIDxXRZ+R19Q7H66DjPuj/x6bftrsSt/ta1SC320iVLKDg4882Sy7T5VCuPAuHBDLJtZ6XYXDfC0g+oEbMkpzuUGwc1KuHLdodqcd6G4boLIGSyuVUW0ui/rJoUM1cClX1AyBrAcNsG9WOU7BpP9t8o+baIPd4FwwFBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-68f41af71ebso2196776d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 11:44:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708112683; x=1708717483;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJSnARwUtS7rN3dj4rLBWq8lUzqfSUuTe1dQ5cX/wTc=;
        b=M7Ej9iEq8za6wgZew35kwyohbqbYyi9s1Ug7AMIJs8CVlHgiL2a2DSiGX5B/W/QPJJ
         INnQwdMk+oh7FuEuT81b4ecIfXW1tXwQlGc7adMgTF0TOSYp7rIpKfchHbKs9rjiksUz
         rnUCQYP53iTx61c8Pakj/bOdDlmPb7sbA56opCEbuw7IMxQRQZk3NWWT9oblkeqtipdL
         49Dy6lEy13qaM6c2yQuZULa5ahCo2T13qteqlz4GVs1zPQ6m81HDm/2KCsxHsU2AzMWV
         VO+7kYprLSOyxxJzNHiJoBNHEf04Q4i6cYSKzIAnJPEAXWXGVzNCFWe6L/mI5JdPi5sC
         MKfg==
X-Forwarded-Encrypted: i=1; AJvYcCWnRx+8Wu7ON7Qr0rbYLjGQzyAnsV9I6ANBdKZbEmPEPbCFArmtJjeiPPIXrHY/5zfOoZz2lsw24FGfTO+JgoxJ1lZpVz8L1kmpKI31
X-Gm-Message-State: AOJu0YyUnKbycwZWap2FRQNKFj8U4bIwLwAv8fgm7cRgYPu4+dMUddsb
	lIaKQEtQd46pyb28Mm7zDGu0FvVaMYc9F6t+NB8q3Ht7PfUmLmZVPzLHa1JvOIc=
X-Google-Smtp-Source: AGHT+IHsiWywxMosiPvKZJqt37VDlQxRzZD6c1/vxsme/jlvolRWLfk2ZvhDvUV0nyMu5JjIh5U+Kg==
X-Received: by 2002:a0c:cc87:0:b0:68f:3b2e:3c14 with SMTP id f7-20020a0ccc87000000b0068f3b2e3c14mr1764919qvl.3.1708112683371;
        Fri, 16 Feb 2024 11:44:43 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id er19-20020a056214191300b0068f304336f5sm218594qvb.36.2024.02.16.11.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 11:44:42 -0800 (PST)
Date: Fri, 16 Feb 2024 13:44:40 -0600
From: David Vernet <void@manifault.com>
To: peterz@infradead.org
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com,
	kernel-team@meta.com
Subject: Re: [PATCH v3 0/3] sched/fair: Simplify and optimize
 update_sd_pick_busiest()
Message-ID: <20240216194440.GA1682@maniforge>
References: <20240206043921.850302-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7AqvWcatbl91sTR2"
Content-Disposition: inline
In-Reply-To: <20240206043921.850302-1-void@manifault.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--7AqvWcatbl91sTR2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 10:39:18PM -0600, David Vernet wrote:
> update_sd_pick_busiest() (and its caller) has some room for small
> optimizations, and some improvements in readability.

Hello Peter, hello Ingo,

Friendly ping. Is there anything else required for this to land?

Thanks,
David

>=20
> - In update_sd_lb_stats(), we're using a goto to skip a single if check.
>   Let's remove the goto and just add another condition to the if.
>=20
> - In update_sd_pick_busiest(), only update a group_misfit_task group to
>   be the busiest if it has strictly more load than the current busiest
>   task, rather than >=3D the load.
>=20
> - When comparing the current struct sched_group with the yet-busiest
>   domain in update_sd_pick_busiest(), if the two groups have the same
>   group type, we're currently doing a bit of unnecessary work for any
>   group >=3D group_misfit_task. We're comparing the two groups, and then
>   returning only if false (the group in question is not the busiest).
>   Othewise, we break, do an extra unnecessary conditional check that's
>   vacuously false for any group type > group_fully_busy, and then always
>   return true. This patch series has us instead simply return directly
>   in the switch statement, saving some bytes in load_balance().
>=20
> ---
>=20
> v1: https://lore.kernel.org/lkml/20240202070216.2238392-1-void@manifault.=
com/
> v2: https://lore.kernel.org/all/20240204044618.46100-1-void@manifault.com/
>=20
> v2 -> v3:
> - Add Vincent's Reviewed-by tags
> - Fix stale commit summary sentence (Vincent)
>=20
> v1 -> v2 changes:
>=20
> - Split the patch series into separate patches (Valentin)
> - Update the group_misfit_task busiest check to use strict inequality
>=20
> David Vernet (3):
>   sched/fair: Remove unnecessary goto in update_sd_lb_stats()
>   sched/fair: Do strict inequality check for busiest misfit task group
>   sched/fair: Simplify some logic in update_sd_pick_busiest()
>=20
>  kernel/sched/fair.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
>=20
> --=20
> 2.43.0
>=20

--7AqvWcatbl91sTR2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZc+7KAAKCRBZ5LhpZcTz
ZCswAQD/TPyQ1RCxEAi6CiJf6doJrL7cgg+pRq1u1kUhHr2NZAEAyzfgAeHbVCpl
SI61fJRXdrf9C8AK62SzYdfVuL+W6wk=
=3n3j
-----END PGP SIGNATURE-----

--7AqvWcatbl91sTR2--

