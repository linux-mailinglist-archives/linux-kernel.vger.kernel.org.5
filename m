Return-Path: <linux-kernel+bounces-85716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577E786B9CC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 897C71C23398
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E815E077;
	Wed, 28 Feb 2024 21:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nkfs63fa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B92B8624E;
	Wed, 28 Feb 2024 21:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709155421; cv=none; b=SbFEpAMTUENd1HzEWDDiekjW2kLRJGOnlNXGzWVSZIrNR6KAgFJ3oasnW0g7mVevWPXuz1s7J6u8WY2fLG0Blcokl72sAkrfZlC+5iB3cW3ebpztg6tEPR7EySTdty68QqLL6Zh2UPC3lYJ7A7sVs/0g2PtSpt0xA8M0uuLr8CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709155421; c=relaxed/simple;
	bh=YOjpMyBdWo8QnmG8hSlpvLbwzvPQcpy3F1jrAMz/Dw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKvhKyAyCXKUn7cSPwwKWte3ZGODKL/U5aCBsQUyDPDw4gjA8iWJtH5F6sU7601/iJqF5VbwAaS5oFGDW59Dym2vRm64TlVEA80N/b1cULu+9dKUO9h9RoavJbIuKQPtrtRS6zsM/5S3SaPKIeUvuogaOUltINiHD0tMkp/XV+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nkfs63fa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC89CC433B1;
	Wed, 28 Feb 2024 21:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709155420;
	bh=YOjpMyBdWo8QnmG8hSlpvLbwzvPQcpy3F1jrAMz/Dw0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Nkfs63fa1baxhs8P85ix9qf4KRSXjZ+4LxE7fPcCMRlNhe5wGImelPVEqVyhIGV8c
	 xjqY4NLLVtXpKrILsJu5Uvo4IDBoP31qmm+T4J6eveLFGWYPs5HHUb0ztM2fWTCGp/
	 9ZEkeTAKp0nt+ynCMtLYxho+QqqBKjnm1EsZqqHIDyhOB33YGLYLFKl/t8NPJ+2toA
	 +BzM9kAEJRkvYXw9ddJe1PEmz51lETI81nMTx3lLH3KNaLXEqCh/GnaL1vf/Oy/CRd
	 Cr7jfFe+/n/9MGWk5EIMqwJ6xUkl4Y4eE6mYnaa71tgru6LNDXgR156m8DD0dmfPyv
	 PWinIyfCBE0AA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-512e39226efso130435e87.0;
        Wed, 28 Feb 2024 13:23:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUQseoTV8rsDhdUbTg7sPt5IEnIPmTWFgIu8vCFSj1htesQ0YgGVAvH8L6p+AMw8HGpUlBP328ZhvZAshD3LrPqQWqvm47TGO0bPOG6c5ok7H2PyAmhCfFIqOw6Leks2mqDL3te9uyO4w==
X-Gm-Message-State: AOJu0YwKSnihNq6DN696aAfq5IdtzvfvAi1bvlqT3QnIGa3BkIgkTP0Z
	Ke6Oq2RhmmYyxXtczF/iLixDcKYGUcrd5hq/++OXUvzbB1KQddbbPWgkDNeADbKYcjjh9sPK4di
	FDtHcmjD8xNukg30jSexJDKRRPfM=
X-Google-Smtp-Source: AGHT+IFTrI650rKeg6wTLDO59QGxnZvfheioaOf95OlseQvrakiipgiXNIIkKcLsQ4ljP8fPjyTDu0ud3YPkl+JzwI8=
X-Received: by 2002:a05:6512:3247:b0:512:e9b1:3e6a with SMTP id
 c7-20020a056512324700b00512e9b13e6amr77138lfr.63.1709155419028; Wed, 28 Feb
 2024 13:23:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228114333.527222-1-yukuai1@huaweicloud.com>
In-Reply-To: <20240228114333.527222-1-yukuai1@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Wed, 28 Feb 2024 13:23:27 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5cJZdvia0HSDcn7v+62E04AP5P=UaqUW4LKDMqm33PAQ@mail.gmail.com>
Message-ID: <CAPhsuW5cJZdvia0HSDcn7v+62E04AP5P=UaqUW4LKDMqm33PAQ@mail.gmail.com>
Subject: Re: [PATCH md-6.9 v3 00/11] md/raid1: refactor read_balance() and
 some minor fix
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: xni@redhat.com, paul.e.luse@linux.intel.com, shli@fb.com, neilb@suse.com, 
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 3:49=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Changes in v3:
>  - add patch 2, and fix that setup_conf() is missing in patch3;
>  - add some review tag from Xiao Ni(other than patch 2,3);

It appears that v3 causes mdadm test "01replace" to run forever.
I haven't figured out why, but v2 doesn't seem to have this issue.

Thanks,
Song

> Changes in v2:
>  - add new conter in conf for patch 2;
>  - fix the case choose next idle while there is no other idle disk in
>  patch 3;
>  - add some review tag from Xiao Ni for patch 1, 4-8
>
> The original idea is that Paul want to optimize raid1 read
> performance([1]), however, we think that the original code for
> read_balance() is quite complex, and we don't want to add more
> complexity. Hence we decide to refactor read_balance() first, to make
> code cleaner and easier for follow up.

