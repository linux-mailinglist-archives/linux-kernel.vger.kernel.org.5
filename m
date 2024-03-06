Return-Path: <linux-kernel+bounces-94317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8053873D09
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 841B9B2456B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C180013BAC6;
	Wed,  6 Mar 2024 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q63NrNsX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065CE1339BD;
	Wed,  6 Mar 2024 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709745216; cv=none; b=QhziW/nlAHb+qmB6EpMeOggOTG99tHDXCQF8wcs0gpPPYGxf0FMb/kwKHD9Sb2evXh0vx9/h7BedSojyQOps9WW0fHzvEYdLyvILgmrXISYiZSvd50PCVKxPiPLR6MySHb4GjrmMK8cfy7zhQOQDxbDz0IyHgEeILVc1vobB+W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709745216; c=relaxed/simple;
	bh=i8O4cidZUJE+wd+JfV1lnCzYwc7HF+gqMw+qaCzi2WQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zta4sUA4Gm8SVn6pfPwk9f4TmFr9xFLfKNMCi6U52u3X9RVMVHvmm3NDk1ADRQRShrjCKTTxDGB6ygPX+Ktwjl6XBBMMVUT23SkFXaD7UYeLFpRtnkMfDrWmb/embS6U1TfZsZG8eNWkXU26CkmqulImxaW5y9vzEs8GNFyXKcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q63NrNsX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E54C433C7;
	Wed,  6 Mar 2024 17:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709745215;
	bh=i8O4cidZUJE+wd+JfV1lnCzYwc7HF+gqMw+qaCzi2WQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=q63NrNsXvD6tGEaLxz6b4pcxnx5y3+dJDdxEjj2bXNO4M0WbhPdPUI6KGvcsZika4
	 lpVD9gSaAnxVsUjV64dzmh5GpNOaiBFpfyBpt9wzY+KmlFNeycPSRXdxZflyjerpJJ
	 oWrBirTULi+GPEce2rZj/N5vESKTzQlq2sQTE8CqRmek4ztT7AqE23eX6Y9Q2sBgE2
	 5olG4vALzIRJqzQ8ij45yCIAK4rUC0rPvrxQPsgG/3ojpIjfC8FTxRm7y4Cu5YMsy8
	 tSfbT97zXRyqnaPEJmO6OLdijmyFX6aoRS0MVinB8hGruSszILilkSxWEpNXesAZGn
	 u60XXN24T31Cw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5132010e5d1so2961724e87.0;
        Wed, 06 Mar 2024 09:13:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV5itsfMgWT4B7HImv345jfCbunMPWcGJcI4K/uoJROAp3aHOht/Rdyndr0moLUdirLnB5AcujLZB/Cjo0WIh1ubauaPFwe0bM7zG0aUhM61yh1K9dPFYZtAX1eHGx0Jmm7vCLinLATkxZhK8vFEutYKn3+cfvYVtVrehIqPndPUA==
X-Gm-Message-State: AOJu0YzLLkRVlHTvLoTXnal6210FGwtJbH0Z1UIyoQcDZt23U0hiPGWb
	u2NJKgRSjlbrxdQdejErSnsblpco7wJjlpQCub4anFTup4AG2n8eopceBiQFw1nCmERbBXd3bR/
	GC8DcpykltXqKG4ZM8XfhnvoJgns=
X-Google-Smtp-Source: AGHT+IEl8SMdQaqSsPVKRhZkiVnx0eV7x/opmy0GG7cynT/haqS02qSyJFBJHINL+DSfiJUTQ9R3BL08ycyYuAdYkQg=
X-Received: by 2002:a05:6512:2208:b0:513:5f2d:3d83 with SMTP id
 h8-20020a056512220800b005135f2d3d83mr1909349lfu.23.1709745213645; Wed, 06 Mar
 2024 09:13:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <739634c3-3e21-44dd-abb1-356cf54e54fd@oracle.com>
 <20240301231222.20120-1-dan@danm.net> <CAPhsuW73WZRekVSEFPgL7R-KNtd2DuhDo7oUNmjZN4Hr7w0dhg@mail.gmail.com>
 <1d3ed2b9-a44e-45f9-a523-d219c141ea5a@leemhuis.info>
In-Reply-To: <1d3ed2b9-a44e-45f9-a523-d219c141ea5a@leemhuis.info>
From: Song Liu <song@kernel.org>
Date: Wed, 6 Mar 2024 09:13:21 -0800
X-Gmail-Original-Message-ID: <CAPhsuW51ND4qH4My8Uz1XaZSdvAjDR7eL7O-RLr5wKmFJA0XMQ@mail.gmail.com>
Message-ID: <CAPhsuW51ND4qH4My8Uz1XaZSdvAjDR7eL7O-RLr5wKmFJA0XMQ@mail.gmail.com>
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Dan Moulding <dan@danm.net>, junxiao.bi@oracle.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thorsten,

On Wed, Mar 6, 2024 at 12:38=E2=80=AFAM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 02.03.24 01:05, Song Liu wrote:
> > On Fri, Mar 1, 2024 at 3:12=E2=80=AFPM Dan Moulding <dan@danm.net> wrot=
e:
> >>
> >>> 5. Looks like the block layer or underlying(scsi/virtio-scsi) may hav=
e
> >>> some issue which leading to the io request from md layer stayed in a
> >>> partial complete statue. I can't see how this can be related with the
> >>> commit bed9e27baf52 ("Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING=
 in
> >>> raid5d"")
> >>
> >> There is no question that the above mentioned commit makes this
> >> problem appear. While it may be that ultimately the root cause lies
> >> outside the md/raid5 code (I'm not able to make such an assessment), I
> >> can tell you that change is what turned it into a runtime
> >> regression. Prior to that change, I cannot reproduce the problem. One
> >> of my RAID-5 arrays has been running on every kernel version since
> >> 4.8, without issue. Then kernel 6.7.1 the problem appeared within
> >> hours of running the new code and affected not just one but two
> >> different machines with RAID-5 arrays. With that change reverted, the
> >> problem is not reproducible. Then when I recently upgraded to 6.8-rc5
> >> I immediately hit the problem again (because it hadn't been reverted
> >> in the mainline yet). I'm now running 6.8.0-rc5 on one of my affected
> >> machines without issue after reverting that commit on top of it.
> > [...]
> > I also tried again to reproduce the issue, but haven't got luck. While
> > I will continue try to repro the issue, I will also send the revert to =
6.8
> > kernel.
>
> Is that revert on the way meanwhile? I'm asking because Linus might
> release 6.8 on Sunday.

The patch is on its way to 6.9 kernel via a PR yesterday [1]. It will land =
in
stable 6.8 kernel via stable backports.

Since this is not a new regression in 6.8 kernel and Dan is the only one
experiencing this, we would rather not rush last minute change to the 6.8
release.

Thanks,
Song

[1] https://lore.kernel.org/linux-raid/1C22EE73-62D9-43B0-B1A2-2D3B95F774AC=
@fb.com/

