Return-Path: <linux-kernel+bounces-34794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA0D838787
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76C2E28A12D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27C950A6F;
	Tue, 23 Jan 2024 06:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O08CoUY2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3E950250;
	Tue, 23 Jan 2024 06:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705991760; cv=none; b=l7sfNtBspBdkw67JLvmbcebmcSdi/ORgM3riuj6AQeY8w2DHvVJWrYJMkT9nlEf3HCKj+AMGcAA6G+84x4hGNHYGAo8DEUHY83M92R2BGsDRNyWKbyBUs27Dybmz8LGZPjIaXQ0Wp2ijz0rFD68DOR0ZWbrPUk1E0h0yq7JkXyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705991760; c=relaxed/simple;
	bh=Cp9ShYD3/g1NkziTguOY/YTVXL1V4HipzP3G0kiKiJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFvT0Sr4yUvUA+vuJB8IZ7PusQNbEQS2qHsfxcWWSA7mFhhaw5gNdUfGv/ZKwfM8vcin1xfHZWDjYdaD7KtWwgpK7eoWU5/Y7HofELvZWUv4D+3cGhqnACmLVH+v1WJijck2J7c/iOsv+Zj9C572cX3kP6PpXJsJWo5YMCpK+pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O08CoUY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FACDC43394;
	Tue, 23 Jan 2024 06:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705991759;
	bh=Cp9ShYD3/g1NkziTguOY/YTVXL1V4HipzP3G0kiKiJo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O08CoUY2JqTphDaXUkfRc9cIKdBT3Lzmt42DnKubKB23ZpTed7ovpNgbEs4qpPjE4
	 30skrBvNa7ljXBiXhCXAp2fao1/TrtZSdr7UYffHnze8K1U93DpTs72XCvQTzZ+Y7j
	 Bo00T5/YPVW3hmXIJhfP5blTPaGmteThFMDaIKzY+j7ZZ/FF0OAAPf8VQmBCIm+ypI
	 LOQdLCY3R3RawdqM5PJ7Z/d9MnSIZ7Ec4x3EZT0ig2pQesur/iaEDidtMC/JuidwC5
	 yUcbYm1+MewXBwWdaESDrl8iy/xwso4kK4NWrqz4h5ZwXnqM4ib+SZW2/PKkmW7YS6
	 mGsSzW+84a5Tw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cf108d8dbeso3060441fa.3;
        Mon, 22 Jan 2024 22:35:59 -0800 (PST)
X-Gm-Message-State: AOJu0YzAfyPITLeGJMuD4qKU3ZiG6sI8n0rs972QXUIZwCDVL3XCfOnZ
	55EQ1Tg+wmc147sMxrXGKOwECSUjmg6Pq9iusUVE7dm9br5KRHNkC+cApzl2fuxNoYV5YrlcFto
	yNNtMM/RveqFV42Fz9JpEukq4xjY=
X-Google-Smtp-Source: AGHT+IEFMyJYGoD/zw1ra4iPupSfes2/6WWvBigxgQK3ozT24qyaAc2/3AKYbZ/kQ1eX47RFfrU4NzDzNn1hhpx+Vgo=
X-Received: by 2002:a2e:7d13:0:b0:2cd:2acc:e9ff with SMTP id
 y19-20020a2e7d13000000b002cd2acce9ffmr2106757ljc.26.1705991757758; Mon, 22
 Jan 2024 22:35:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123005700.9302-1-dan@danm.net> <20240123013514.7366-1-dan@danm.net>
In-Reply-To: <20240123013514.7366-1-dan@danm.net>
From: Song Liu <song@kernel.org>
Date: Mon, 22 Jan 2024 22:35:46 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7-r=UAO8f7Ok08vCx2kdVx6mZADyZ-LknNE8csnX+L8g@mail.gmail.com>
Message-ID: <CAPhsuW7-r=UAO8f7Ok08vCx2kdVx6mZADyZ-LknNE8csnX+L8g@mail.gmail.com>
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
To: Dan Moulding <dan@danm.net>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: gregkh@linuxfoundation.org, junxiao.bi@oracle.com, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Mon, Jan 22, 2024 at 5:35=E2=80=AFPM Dan Moulding <dan@danm.net> wrote:
>
> Some additional new information: I realized after filing this report
> that on the mainline there is a second commit, part of a pair, that
> was supposed to go with commit 0de40f76d567. That second commit
> upstream is d6e035aad6c0 ("md: bypass block throttle for superblock
> update"). That commit probably also was supposed to have been
> backported to stable along with the first, but was not, since it
> provides what is supposed to be a replacement for the fix that has
> been reverted.
>
> So I rebuilt my kernel with the missed commit also backported instead
> of just reverting the first commit (i.e. I have now built 6.7.1 with
> just commit d6e035aad6c0 on top). Unfortunately, I can still reproduce
> the hang after applying this second commit. So it looks
> like even with that fix applied the regression is still present.
>
> Coincidentally, I see it seems this second commit was picked up for
> inclusion in 6.7.2 just today. I think that needs to NOT be
> done. Instead the stable series should probably revert 0de40f76d567
> until the regression is successfully dealt with on master. Probably no
> further changes related to this patch series should be backported
> until then.

I think we still want d6e035aad6c0 in 6.7.2. We may need to revert
0de40f76d567 on top of that. Could you please test it out? (6.7.1 +
d6e035aad6c0 + revert 0de40f76d567.

OTOH, I am not able to reproduce the issue. Could you please help
get more information:
  cat /proc/mdstat
  profile (perf, etc.) of the md thread

Thanks,
Song

