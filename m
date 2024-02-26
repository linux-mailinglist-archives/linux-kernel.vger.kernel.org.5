Return-Path: <linux-kernel+bounces-82102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1EB867F47
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E0131C2B912
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B65A12EBE7;
	Mon, 26 Feb 2024 17:50:35 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B3D12DD9B
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708969834; cv=none; b=SjNltKz3x7DHgpznzsYlFGcIZdtshD0d3s3B++L6/0nHoc41or9/qryKzYgPyOm/8s2By9S3GfZsFm8gghaAasHKnDZsxp6mAfdaurIPdVGhYDHZXlkEbVtGSP86isQdHPCinAOQ+4+dgYlLEKbcBc6P84SQma3+ouu5RfcPp0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708969834; c=relaxed/simple;
	bh=1iR3xJRjDb/FuKWA+tVOHZIwPamsfWYUgHUzg6XOKpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdjOFIhl0/s8nbBuYl2Qpkuads7IGDrshNmpauM7V3fEkVDcWfpnLPVf1hGm4hPARB9gfO/yMoNKYb0bLu1n9pV5OZq7TrZTc7g2ZtlSM1iQTT8G/480PWrNZP/eedXGhLhRTVEtEzwLd1p+/+JIzzQmRQiiz/L6BSeoUjhEzJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-68f9c01a148so17756376d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:50:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708969831; x=1709574631;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y860Dr8n+PXcs2qUmH6Kl+B8IuVXvd+eBOgZbUsNlMU=;
        b=tFYS9jFdHg9jsfuKU8gbDqGtfRuaFFjkiuBgwST4gVHc94J0hhExAOgNThtOspvlur
         /9xqh7sTpZmgLylVPUgA1139ostiWs0gNQGSeNH6Sm9ZHDRKcle3AfpikD/0MqQMHilm
         oKLQFkaMS4yZREF+hiwSQCDCdqfUPCLS3RXhZ93sB84V9CJi0OHZbThYQS6yEs7Kiwpd
         RovGsT1Zgr6MAMlFMJh2yS7X7NZGBD65b6tuB1J/B6NQg4MAajYJSwNumCupHIRm0wx2
         gItFyQ9rdZB4y6uD4ds/qUUEem16hsO1Kerd71RXHTe8CPT1dLd6/5UgM/sqneubbC94
         pxEw==
X-Forwarded-Encrypted: i=1; AJvYcCUjpt0slLKMGLp4l1YhBitAt46oMaMwdsRJkuzZk/0JYoXmLxKdks4DJnkqNqp2GYwvdHPubnw4TQLUYPpaw21LhOSZSY+Xx3ItVZsK
X-Gm-Message-State: AOJu0YwtpYgfGwzuaQzv7S2UamaUHWuIpZ/e0mVYpypM8tJuVjvbUBXo
	CucdSLT2wTwIL2aqVVnG06GxLI3BUtrWGtxbZwnUxU1Waoz/8rck
X-Google-Smtp-Source: AGHT+IF2iEMlAX155pwVh/rNgsMsIEoLJLHSBXSXFJSU743SPX9bWtIxSOIDT7zr2NMAa5Ad/73BVQ==
X-Received: by 2002:ad4:5dc2:0:b0:68f:de55:521a with SMTP id m2-20020ad45dc2000000b0068fde55521amr8805845qvh.16.1708969831527;
        Mon, 26 Feb 2024 09:50:31 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id s18-20020ad45252000000b0068efae7d0aesm3157731qvq.125.2024.02.26.09.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 09:50:31 -0800 (PST)
Date: Mon, 26 Feb 2024 11:50:28 -0600
From: David Vernet <void@manifault.com>
To: peterz@infradead.org
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com,
	kernel-team@meta.com
Subject: Re: [PATCH v3 0/3] sched/fair: Simplify and optimize
 update_sd_pick_busiest()
Message-ID: <20240226175028.GA1903@maniforge>
References: <20240206043921.850302-1-void@manifault.com>
 <20240216194440.GA1682@maniforge>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mg56jdseInclq6ef"
Content-Disposition: inline
In-Reply-To: <20240216194440.GA1682@maniforge>
User-Agent: Mutt/2.2.12 (2023-09-09)


--mg56jdseInclq6ef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 01:44:40PM -0600, David Vernet wrote:
> Hello Peter, hello Ingo,
>=20
> Friendly ping. Is there anything else required for this to land?

Hello,

Sending another ping.

Thanks,
David

>=20
> Thanks,
> David
>=20
> >=20
> > - In update_sd_lb_stats(), we're using a goto to skip a single if check.
> >   Let's remove the goto and just add another condition to the if.
> >=20
> > - In update_sd_pick_busiest(), only update a group_misfit_task group to
> >   be the busiest if it has strictly more load than the current busiest
> >   task, rather than >=3D the load.
> >=20
> > - When comparing the current struct sched_group with the yet-busiest
> >   domain in update_sd_pick_busiest(), if the two groups have the same
> >   group type, we're currently doing a bit of unnecessary work for any
> >   group >=3D group_misfit_task. We're comparing the two groups, and then
> >   returning only if false (the group in question is not the busiest).
> >   Othewise, we break, do an extra unnecessary conditional check that's
> >   vacuously false for any group type > group_fully_busy, and then always
> >   return true. This patch series has us instead simply return directly
> >   in the switch statement, saving some bytes in load_balance().
> >=20
> > ---
> >=20
> > v1: https://lore.kernel.org/lkml/20240202070216.2238392-1-void@manifaul=
t.com/
> > v2: https://lore.kernel.org/all/20240204044618.46100-1-void@manifault.c=
om/
> >=20
> > v2 -> v3:
> > - Add Vincent's Reviewed-by tags
> > - Fix stale commit summary sentence (Vincent)
> >=20
> > v1 -> v2 changes:
> >=20
> > - Split the patch series into separate patches (Valentin)
> > - Update the group_misfit_task busiest check to use strict inequality
> >=20
> > David Vernet (3):
> >   sched/fair: Remove unnecessary goto in update_sd_lb_stats()
> >   sched/fair: Do strict inequality check for busiest misfit task group
> >   sched/fair: Simplify some logic in update_sd_pick_busiest()
> >=20
> >  kernel/sched/fair.c | 19 ++++---------------
> >  1 file changed, 4 insertions(+), 15 deletions(-)
> >=20
> > --=20
> > 2.43.0
> >=20



--mg56jdseInclq6ef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZdzPZAAKCRBZ5LhpZcTz
ZNLIAQDT4f2WD1kjAIU1o2RGVd8W1WymVhO8TWz2J+WkU3QTrAD/UO9eSFBZARPn
lNCNqBk+RnThm4SvjVfhFV7OKSMA1gc=
=nOVC
-----END PGP SIGNATURE-----

--mg56jdseInclq6ef--

