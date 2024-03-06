Return-Path: <linux-kernel+bounces-94278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9CE873C69
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 083891C217AB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03FA137914;
	Wed,  6 Mar 2024 16:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2//RLvO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DA360882;
	Wed,  6 Mar 2024 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709743200; cv=none; b=A9j8yj4IvexJYZTJv+pAJ4TV4cRDjEaFqVlI5fc9d+8cqmyOKa6uDiOAlH7jHnxdq4XTn1uIYGOuNKd5kPXhGaXM4IkgXBE2V4sEjUAr2UiltlyEgzhBqtRRxvJDt/hSUzz6aapQQFDPLXTu4KF55TxJ3947XUf6xEmpdEgISd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709743200; c=relaxed/simple;
	bh=f2HncGmBSaycsoO1hVr4ckiuD3QmlN8sKiSzANUFi4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LquKz55gSZrHXG7RppXZzpQHY/RHTc3mNM/7Y2OF/PMPjOwXGIzEAcT7dQ5GhgAADPZr/X4o0XJ+wHEgMq//vWl9leG8nifjfBASkvFGHZG9xXPb3vleNcJBKxt439Y+SZ6I83PBNB+46E6Kg3XFswn/TreNWJU2OAfy+ke94do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2//RLvO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31B7C433B1;
	Wed,  6 Mar 2024 16:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709743199;
	bh=f2HncGmBSaycsoO1hVr4ckiuD3QmlN8sKiSzANUFi4s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l2//RLvO+FP5yOMMBdksci8jS3e1c3vrbsnRNekaD60yrh9AO1oKZUk8wryDw8ibS
	 +GHbDMPAXZu3PtuD3PzTQrDjE4SLTsVbHie5UPNKjHQ9k0vMM/vhONh9+YeeJsMSRw
	 IV5tVZn502X++dVY0R2em9HNPNBnUBp/xr1sJi1/pATeikwsb+fQ83GiAOXNZyMaJp
	 9UbW9lJVyfmmDhSiZKmtdKve7OPpraCEdgQZEcubdBw/VABDBuv7gT4SD3H2FaTUcU
	 D4U/LFOYiX4BGjhbfGoxeeRR6aEIQFTNHpYIRYkcNi3f/fKHcs/gypxHCLRQ5H/5tk
	 NKZKhPIKrGRvg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51320ca689aso8618156e87.2;
        Wed, 06 Mar 2024 08:39:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV6/PceRJe/Gf+QIQaw9b52yvEjBex1nwybh+BbvQ2D1Wc/0CygDnQfx/id/fyZ3xwv8gtzhG9BS9hqGTW9Xo6Y5ASW15rLwOStUcch7Gi+CRd+qMqGjIGLsIWDsEqKKQ9SaPOJ++HUqQ==
X-Gm-Message-State: AOJu0Ywg330imPKoiJezqqUs1Gm4QTaqHaLmnVwLNEOvQl6+CmpCZi7a
	I3w+0w63b1TpSeNzx0C+0CQ9SQKiJyDludZPZ3HizNwGjNBHYrZmw2ZCY5HzcVQi9etGPA3Vkj6
	rTKY7zcIV+R1cw6GMoNufmC0zcB8=
X-Google-Smtp-Source: AGHT+IGwwONob6k6UH3ndcbEHIe+4OP8oSPbZ3RrDc/odjWz6ggdxosj2uvVJehSNDacTwM3tomgiciaJXqEBTtXc1Y=
X-Received: by 2002:a05:6512:48c3:b0:512:a9b7:c637 with SMTP id
 er3-20020a05651248c300b00512a9b7c637mr3568369lfb.29.1709743197678; Wed, 06
 Mar 2024 08:39:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305072306.2562024-1-yukuai1@huaweicloud.com>
 <20240305072306.2562024-3-yukuai1@huaweicloud.com> <c0e648ea-d73e-4805-a2bb-b02ddd3ca4e2@molgen.mpg.de>
 <9950cb96-ac8b-d7dd-56a0-133709f51b5f@huaweicloud.com> <f9d3cad9-6d7d-4aa1-9592-79300812dce4@molgen.mpg.de>
In-Reply-To: <f9d3cad9-6d7d-4aa1-9592-79300812dce4@molgen.mpg.de>
From: Song Liu <song@kernel.org>
Date: Wed, 6 Mar 2024 08:39:45 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5KC1Xnz1xkN8A+beu_j+Qumf3f+d9eA2pFzd4WAsMdyw@mail.gmail.com>
Message-ID: <CAPhsuW5KC1Xnz1xkN8A+beu_j+Qumf3f+d9eA2pFzd4WAsMdyw@mail.gmail.com>
Subject: Re: [PATCH md-6.8 v2 2/9] md: export helpers to stop sync_thread
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, xni@redhat.com, zkabelac@redhat.com, 
	agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, 
	dm-devel@lists.linux.dev, heinzm@redhat.com, jbrassow@redhat.com, 
	neilb@suse.de, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

Thanks for reviewing the patch!

On Wed, Mar 6, 2024 at 7:10=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de> =
wrote:
>
> Dear Kuai,
>
>
> Am 05.03.24 um 09:13 schrieb Yu Kuai:
>
> > =E5=9C=A8 2024/03/05 16:08, Paul Menzel =E5=86=99=E9=81=93:
>
> >> Am 05.03.24 um 08:22 schrieb Yu Kuai:
> >>> From: Yu Kuai <yukuai3@huawei.com>
> >>>
> >>> The new heleprs will be used in dm-raid in later patches to fix
> >>
> >> hel*pe*rs
> >>
> >>> regressions and prevent calling md_reap_sync_thread() directly.
> >>
> >> Please list the new functions.
> >>
> >> 1.  md_idle_sync_thread(struct mddev *mddev);
> >> 2.  md_frozen_sync_thread(struct mddev *mddev);
> >> 3.  md_unfrozen_sync_thread(struct mddev *mddev);
> >>
> >> I do not like the naming so much. `md_reap_sync_thread()` has the verb
> >> in imperative mood. At least myself, I would not know what the
> >> functions do exactly without looking at the implementation.
> >
> > Thanks for the suggestions, I'm not that good at naming :(
> >
> > Usually I'll send a new version with updated naming, however, we must
> > merge this set ASAP now, perhaps can we live with this for now?
>
> Fine by me. Maybe when applying the typo can be fixed, and the naming
> than later.

Yes, I did exactly this when applying the patches, but forgot to mention it
here.

Song

