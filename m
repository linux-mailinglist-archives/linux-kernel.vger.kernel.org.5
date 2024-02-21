Return-Path: <linux-kernel+bounces-74664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A6C85D770
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D92282EED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CF9481A8;
	Wed, 21 Feb 2024 11:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZb+Yv0b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DD947F48;
	Wed, 21 Feb 2024 11:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708516280; cv=none; b=hRN9nGOgZOyBbfH5LzTnc7LdVugLDyOpedLImZt6eqUpN0bFrtMbru2C8zYzwaCQFKdii3Tekv17I5FZAuLXsvp6toVIpOwGKyMM5TwP/0gssY1Jy/LMfpjAsrYN8PR/ADMuu+Z3MCi1x756PzqnxacMyhfpuASgHkG4ifaBbxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708516280; c=relaxed/simple;
	bh=PcS6hrHc4zM3aNBPZPl5peXB3J4AeyjwDc6kvcBzBVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ExMV64Y5LaOd/3aSYkGN6INzXlOrfS6MoRsAuUbm7QvCzwtTbntlLTFXWqITnQqb5y7oK4BBDniICighP7WLDvFtxglpUapAyK+fzedJybiRSLhewCd+T9aMdG2oZoh4W8TdDxMmEqIgHLIzFlGlTYOwygPDICP3/atmekp9yQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZb+Yv0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187B7C433C7;
	Wed, 21 Feb 2024 11:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708516280;
	bh=PcS6hrHc4zM3aNBPZPl5peXB3J4AeyjwDc6kvcBzBVo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uZb+Yv0bze9K9b2m2pBnmcCDMN3xiz2UfuqObd0Up/Gdbx5IMdRUoNWz1Lm8OuPez
	 1K+2ShszHJAUT5gCfZj/KWuin1wCNA/NWbFE4oemNykMg6/DKJXX9HKiKKCW8l/dv7
	 AHYkmHA2Nz/dzbD6byic6sjOhORt3wyzPJQsfgNO+VswUpcWc412gSeytiRlOAnjBI
	 TaotDw4XLV9dSk/HdTb/FrOCaqCayokCknrp+KeUtr8pr/hhE9HrH/opvuxlJUWq7X
	 lHaFy/wnHzjyWFDVhqxsWEsgFfRkclhIHbPDf+UXA2HFnhOfLB6bCryLkDNjPO+qx7
	 /L2AYRXW7nuNA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d0bc402c8eso61756111fa.1;
        Wed, 21 Feb 2024 03:51:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXKBdXj+yGfamHNRdXA0hVc/vqFwbQyTXxKJxtv/01x4sbGNe4j6+1/rzXwTlrGnK/043T9S5i6xb2L0nsq0yfUMvLgY7FiyPpaX3fQleKRF47bklI87kK78K4SJrIoCnnun3KxN81WP017DjqvlzePR3HiWUemqV8XcxyCNVI7dSrdn2PacIX+cw/GRmto/ltNViwc63PaZ8gObz6xpp/xaJxRcp/0
X-Gm-Message-State: AOJu0Yy4/Bl8cPgbWv34zyk6X5LBPVlopNCs2hndnX524CQ9Dp15GhwN
	Mbi+pcGusfJOoSbnSs7ws854Mlq1/Oy1wZPV3yRlAU9pdaIeCClfvxZRmKq/G7DB21yO5Ro87OA
	SOnbYyJiNHedIFdplD6eLyvAtg7Y=
X-Google-Smtp-Source: AGHT+IHKfswrSkZE04vm5563ZxASZgoT8zgTtXA+jAEWbIfCeJAq2Y75jiBuERvfVz9U4iCwNVgOA46fnzcgwpMpBwM=
X-Received: by 2002:a2e:b747:0:b0:2d2:3a32:259a with SMTP id
 k7-20020a2eb747000000b002d23a32259amr2976534ljo.13.1708516278633; Wed, 21 Feb
 2024 03:51:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131104851.2311358-1-john.g.garry@oracle.com>
 <CAK7LNATDMjzmgpBHZFTOJCkTCqpLPq8jEjdrwzEZ3uu7WMG7jg@mail.gmail.com>
 <23c67ffc-64a5-4e19-8fbd-ecb9bfe9d3ff@oracle.com> <CAK7LNASfTW+OMk1cJJWb4E6P+=k0FEsm_=6FDfDF_mTrxJCSMQ@mail.gmail.com>
 <3e2c2def-e7d6-458f-81b3-ab666b41ad21@oracle.com> <fb8d24cb-b5c4-41be-abf4-33bda08a1059@oracle.com>
In-Reply-To: <fb8d24cb-b5c4-41be-abf4-33bda08a1059@oracle.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 21 Feb 2024 20:50:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ_r5yUjNpOppLkDBQ12sDxBYQTvRZGn1ng8D1POfZr_A@mail.gmail.com>
Message-ID: <CAK7LNAQ_r5yUjNpOppLkDBQ12sDxBYQTvRZGn1ng8D1POfZr_A@mail.gmail.com>
Subject: Re: [PATCH RFC 0/4] Introduce uts_release
To: John Garry <john.g.garry@oracle.com>
Cc: mcgrof@kernel.org, russ.weight@linux.dev, gregkh@linuxfoundation.org, 
	rafael@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, keescook@chromium.org, nathan@kernel.org, 
	nicolas@fjasle.eu, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 6:01=E2=80=AFPM John Garry <john.g.garry@oracle.com=
> wrote:
>
> On 08/02/2024 10:08, John Garry wrote:
> > On 05/02/2024 23:10, Masahiro Yamada wrote:
> >>>> I think what you can contribute are:
> >>>>
> >>>>    - Explore the UTS_RELEASE users, and check if you can get rid of =
it.
> >>> Unfortunately I expect resistance for this. I also expect places like=
 FW
> >>> loader it is necessary. And when this is used in sysfs, people will s=
ay
> >>> that it is part of the ABI now.
> >>>
> >>> How about I send the patch to update to use init_uts_ns and mention a=
lso
> >>> that it would be better to not use at all, if possible? I can cc you.
> >>
> >> OK.
> >>
> >>
> >> As I mentioned in the previous reply, the replacement is safe
> >> for builtin code.
> >>
> >> When you touch modular code, please pay a little more care,
> >> because UTS_RELEASE and init_utsname()->release
> >> may differ when CONFIG_MODVERSIONS=3Dy.
> >>
> >
> > Are you saying that we may have a different release version kernel and
> > module built with CONFIG_MODVERSIONS=3Dy, and the module was using
> > UTS_RELEASE for something? That something may be like setting some info
> > in a sysfs file, like in this example:
> >
> > static ssize_t target_core_item_version_show(struct config_item *item,
> >          char *page)
> > {
> >      return sprintf(page, "Target Engine Core ConfigFS Infrastructure %=
s"
> >          " on %s/%s on "UTS_RELEASE"\n", TARGET_CORE_VERSION,
> >          utsname()->sysname, utsname()->machine);
> > }
> >
> > And the intention is to use the module codebase release version and not
> > the kernel codebase release version. Hence utsname() is used for
> > .sysname and .machine, but not .release .
>
> Hi Masahiro,
>
> Can you comment on whether I am right about CONFIG_MODVERSIONS, above?
>
> Thanks,
> John



Your understanding about CONFIG_MODVERSIONS is correct.




--=20
Best Regards
Masahiro Yamada

