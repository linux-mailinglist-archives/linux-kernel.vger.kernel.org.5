Return-Path: <linux-kernel+bounces-99179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B4E87848A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9FD71C217A3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E67482E6;
	Mon, 11 Mar 2024 16:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfFXnhU/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E6A481C0;
	Mon, 11 Mar 2024 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710172951; cv=none; b=OmJLD/MhoenD62d9oe6XZ6Ef5HC+gR39nomGOO42h+g/+69G/mQhWyit2tQEp2KIcL1UpzZsc+2CpzmZ1Tap1NuAcCtSYXWXu88REmanX1xHZRaikxVZh1NUCDejhPDDKU06kY5ybhM1CHS+/MXAxi5w+jlZYNj8yTFDqinly64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710172951; c=relaxed/simple;
	bh=WqZwvepuRPNX/qc+RN/1Vh/xaT+NTkTKJ1/VLmjuf04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=at+jHiOfvw7LRKMgFs/7IfgB1U/aYrdvJNSvoks0PqRF8ID+ad6puPSMIl9f5z09AsM+NvZPaD8c6sLyxdSiWsJGqvoi46XslRZj5AiKQux5sJRyY+v+SUIme3M7wPpjpVDEdtRLYukJ1nLrj7a3ALaM2q8dNBzD7FIygHCYVe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfFXnhU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDAB9C433B1;
	Mon, 11 Mar 2024 16:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710172951;
	bh=WqZwvepuRPNX/qc+RN/1Vh/xaT+NTkTKJ1/VLmjuf04=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JfFXnhU/K2V8R25IUApCITJoK6vIL2GTPC3kpp9UdqxHGbm2/0o4d8lEnJVD7cbvQ
	 9lq3bPu8dCA+f+5+0o0e/mk68uHGyPokPEfuGHYEIr1Zm75cvsPQkSnHfrclsWunf1
	 WgOItnGSAZlP6TM5kf5tABDiqd07CYLpL/UOWVRnhoLR3S2ryNGZ0upwbkEM4/U6th
	 VqbwGtkq5zuEBid0Qh7wbCeX2iHjPhkseN9jb1LhESPHIL1GGOCAcgkjD399WcbGZ4
	 fbG++zylbDwQTtx8ggXPQDV3q931fZHAeglAbg2f/1LxNfTdF2+d3OwAUgizFA3Bgn
	 uzlJNNahdD+Bg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d094bc2244so70325381fa.1;
        Mon, 11 Mar 2024 09:02:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWqHah3zfd8SrYGeRFsnI6FpMxz87DotQ3Z5gmnU3YU+ZP8wbwT3CqxwhnMbxVAfvpR33Pnnj3DpBCUsouOQAxLTeRcLV8TKp0wSJa5TT/x8hh0uP+GQUsfqfhn5roequVRGobCf8A0H8kPGwwfuo17zGwTpozX1E5ranIQzEs5iegL+67+LcdpjyBXy5mCnVuItypgSa/0b75m/RLkiLFzgEs=
X-Gm-Message-State: AOJu0Yx8zykQoHW1zUiH4UuuV/OTiOTyQ2pcr0DKdlN7tUGpEnG2l6WO
	4guKdXG3lqSmUSbvkfhEa3HsCer+Ja8RZGgz6rwcMAasy9IfEGLFkhxO5/gldlC2V/i+R3u1U67
	5ZoVb3VuNPM2gMLCBtGDBFfKeIQ==
X-Google-Smtp-Source: AGHT+IEb6SEAMF3zzezPotYKfNIak/i3S4Vzoji45ZROrvd7L+SgsEjFTdt4YntJt/Wfe159sB9omSGuSQq5QbBk2rw=
X-Received: by 2002:a2e:3c03:0:b0:2d4:d78:b05a with SMTP id
 j3-20020a2e3c03000000b002d40d78b05amr4021021lja.19.1710172949142; Mon, 11 Mar
 2024 09:02:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1707524971-146908-1-git-send-email-quic_obabatun@quicinc.com> <1707524971-146908-4-git-send-email-quic_obabatun@quicinc.com>
In-Reply-To: <1707524971-146908-4-git-send-email-quic_obabatun@quicinc.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 11 Mar 2024 10:02:16 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+LUVZF40vrf-3p77DLk5XLOgA0RF9duUHUthyUk5r7OQ@mail.gmail.com>
Message-ID: <CAL_Jsq+LUVZF40vrf-3p77DLk5XLOgA0RF9duUHUthyUk5r7OQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] sh: Call paging_init() earlier in the init sequence
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: chenhuacai@kernel.org, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	frowand.list@gmail.com, linux-openrisc@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 5:29=E2=80=AFPM Oreoluwa Babatunde
<quic_obabatun@quicinc.com> wrote:
>
> The unflatten_device_tree() function contains a call to
> memblock_alloc(). This is a problem because this allocation is done
> before any of the reserved memory is set aside in paging_init().
> This means that there is a possibility for memblock to allocate from
> any of the memory regions that are supposed to be set aside as reserved.
>
> Hence, move the call to paging_init() to be earlier in the init
> sequence so that the reserved memory regions are set aside before any
> allocations are done using memblock.
>
> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> ---
>  arch/sh/kernel/setup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

