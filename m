Return-Path: <linux-kernel+bounces-65961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F7685546D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF5B4B235E6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E63E13DBB1;
	Wed, 14 Feb 2024 20:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5VKDkhT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBA554649;
	Wed, 14 Feb 2024 20:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707944242; cv=none; b=k96WdNnbcOQe0iJFJ1QTvLoCR8AM00WAJKOdIrlnVT/JXqkoiGvIVA7H7ap4c8ieCJfobWGes06uqoeO/MuBd2O3cAcDI1J0JbNn4kk0Q2JAutae+nruWh16FKseJajI2OJM5hmjGASA2pUjFhuZcEzocyIX9sFBIuUdqWEDtGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707944242; c=relaxed/simple;
	bh=rm1z52ob2SJKl6r4iXzBcEK3+ThapcTgMWVurGvl9pM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGSVDKmMHNL2HSYys+uWV0GeiYMG5vWTi6D8rZUcnJwgSXZVsUx2tfW63asZwruKdlgZxWX/0vf0eY9ry2y2G5QOD8PBSohRIah5pIUIWQ+a06VEpaeM7ISTkVodMtrJy0W7sJ1YPiU/JqDvsAJst9xaFaKqBGp+Kon3AtF6uh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5VKDkhT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CFBC433F1;
	Wed, 14 Feb 2024 20:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707944241;
	bh=rm1z52ob2SJKl6r4iXzBcEK3+ThapcTgMWVurGvl9pM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X5VKDkhTZPIJYlReSxYUzHHaTWS+98NwZ1U1TzY14XV5j56P4RaS2W+wJE9s8GCIO
	 jFNyX5WMu395zznH0HGfWYa2HUPP53LfIrdSEzfJnUgX/AILHNocKPJXMiSVBOA4CH
	 7YdE9tNVVxgVRs71LvbBVbL9+8g5MN4BQ265dQPYF/XoAdZYBMhHlOrJcDf16u3POT
	 bk62jvNPVFycGbfAonebU9DWT3B+ZsgGcPiE6L55hZa4ikSoZuK1+hRy15ED4Lp/v3
	 WVRh+rsHTU/t4hpuJY6UCFN7t4wp2fxS/yrf+e/96o59HfNUIe+UKp8acUwyQMFx6a
	 jbebEBxbOjUAQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5114b2b3b73so186613e87.0;
        Wed, 14 Feb 2024 12:57:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUV0anpQ209d5pyFP2hFzqBxuDWAjZP/xzMgF34kHqqD5EBlsvzMrtQq5l4Mx+K1fUf/ivt5ZPN/+akUKDbJ+LqNB5pEtfnydRWR/wO5E0Ceog/K16257c9R/jpcnOCSGfnBZHNAVoVB5pn
X-Gm-Message-State: AOJu0Yx3qG3RQ3Lj/fTjBte51I5KQPXN8wZ4Rs8lLqmLlWXuNd9Mqr6p
	e1ROmEMNTqZjeBeK8LCBnMz0O1q9QSOVBcXDg3v8tnE3RV7uWMxePpZTCP62HZN8Q+fKfdT+4/p
	bazyog2+nyp6zkW209OvGhl78+IA=
X-Google-Smtp-Source: AGHT+IFyTd8aXJWJp7FlxxCZNCtocyL/lbTIdC1wqL6fPYB7udsfTMcMq0ib/cPhsw1BlFQt3RZ1aSmoPI9XhuU0Ttk=
X-Received: by 2002:a05:6512:3da6:b0:511:878b:80c with SMTP id
 k38-20020a0565123da600b00511878b080cmr3592138lfv.5.1707944239777; Wed, 14 Feb
 2024 12:57:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214181942.3562473-1-arnd@kernel.org> <CAK7LNASQUhJGSdQiyEpc5Rpuk_hJwSCu=W=4JkL-Et_giFNvPg@mail.gmail.com>
 <23b58d3c-82eb-450f-a246-f8a91b8e8075@app.fastmail.com>
In-Reply-To: <23b58d3c-82eb-450f-a246-f8a91b8e8075@app.fastmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 15 Feb 2024 05:56:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNATNuM=_+r2KWB9KW9Ax-zyMa4d9SsbNr8ba+UkhhaBcyA@mail.gmail.com>
Message-ID: <CAK7LNATNuM=_+r2KWB9KW9Ax-zyMa4d9SsbNr8ba+UkhhaBcyA@mail.gmail.com>
Subject: Re: [PATCH] kallsyms: ignore ARMv4 thunks along with others
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
	Ard Biesheuvel <ardb@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 5:47=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Wed, Feb 14, 2024, at 21:34, Masahiro Yamada wrote:
> > On Thu, Feb 15, 2024 at 3:19=E2=80=AFAM Arnd Bergmann <arnd@kernel.org>=
 wrote:
> > If this is a recurring problem,
> > maybe is it better to use a regular expression?
> >
> >
> > Remove these lines:
> >
> > # arm64 lld
> > / __AArch64ADRPThunk_/d
> >
> > # arm lld
> > / __ARMV5PILongThunk_/d
> > / __ARMV7PILongThunk_/d
> > / __ThumbV7PILongThunk_/d
> >
> > # mips lld
> > / __LA25Thunk_/d
> > / __microLA25Thunk_/d
> >
> >
> >
> >
> >
> > Add this:
> >
> > # lld
> > / __[^[:space:]]*Thunk_/d
> >
> > This pattern is only used in tooling,
> > but never in the kernel space.
>
> Right, makes sense. There is always a risk of removing
> intential kernel symbols and this is slightly higher
> with the regex but still not that bad.
>
> I'll give this a spin and send a v2 tomorrow then.
>
>     Arnd



Maybe this is a little more simpler:


/ __[[:alnum:]]*Thunk_/d





--=20
Best Regards
Masahiro Yamada

