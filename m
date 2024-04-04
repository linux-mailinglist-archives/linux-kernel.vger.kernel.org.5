Return-Path: <linux-kernel+bounces-131977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF22898E2C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 468F81C295CC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA5B132C15;
	Thu,  4 Apr 2024 18:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nn3vknvy"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81851131723;
	Thu,  4 Apr 2024 18:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712256212; cv=none; b=JmiDmkP9bZMe4bEniZgmdQe9PUdByp26yRrORuxDm/ap2KoA9KrQPxccLERVXfVjsgi8/4cz2zRe49vO45AHMZnyYkBP+Qawsg31zfSOItHwyX+wsEcOYcehRiFkW4E/vU8oWllUJjnOGOOV3aTDfhREDSgjQ/MRmeFsaNJC3gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712256212; c=relaxed/simple;
	bh=lNeaNNlhbREvV2krr1ClfJeQ8ozUNbsQyuKB+WQvTCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQV37vWAQjuYWbK8/35i0Wjp0A4LxIM97fuTU9Sv/TiKmIndDj1EuxE9vJ03Xiot5bMKcWedcQlnVRpY3Eg8kv7g8QWyPol/0aEtsNIG7uKkfDlVrM8EU6sBc7N1qNtLxBpOb2OrY/efQRK9hufG8Vx5HN+smwcFoNhso5cIAsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nn3vknvy; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2a26cb416faso1025824a91.2;
        Thu, 04 Apr 2024 11:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712256210; x=1712861010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNeaNNlhbREvV2krr1ClfJeQ8ozUNbsQyuKB+WQvTCE=;
        b=nn3vknvyT7EhZwzHw9s+WY++6btYVY3Ol/FROowx9+Et0d2b8yjin4QrdHl5+bbosU
         8376HSuipyTnb4SjBkc39nSnBS1h/V2fdywMipFhyvs0F5JcH3LwTeqczZCwz1c/K69M
         5LQL4qbiFjAjPx6tiRY2qM5RcTz4e81Hx1LaUreS3QOom8wkTwBmNDISTbhDApcHTXn4
         Qz3c/raLuGg1EpgqINwwVasDOoWm+ox3EIOLpWvODnMGJBiFRnfrYbNJqPff9OPR3cDP
         9DGAQpjReFFkYrIlhZFN38x3giIOoSEWg4ardcCwKAMsJIXWPWwNMdSYU/qnXCuodWAJ
         g5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712256210; x=1712861010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNeaNNlhbREvV2krr1ClfJeQ8ozUNbsQyuKB+WQvTCE=;
        b=qk282Nx5zfB5tvSM3tAb0zuEXF00u0dkpbrB8oKdvBuYjyTCL7n9bgT3c4Ra3Zdiq6
         E3g5bfS1oARNScnxxxfraI85MIc7Igqdxc4MZej2dm74XU4YUlB/aa/5N4d3fa1yvpIq
         5kQv8cGqRfrRXTN9ngYyp/hF/qQYK1Z7+sExYBO44WyL6nC6u9bi1YzfAFlnadAT2vwz
         zT7ylzqp2QOiFGxcr43auETvaw3MfY8fbM6CF19guOfil2ftJ0/j7BvO+Bk3tLJRWkF+
         wtzqdAsvA7iLdRS28RvS1ANYjFa0fa0c4bJGMZa8Vk5q42qYLoLiRdT5rGG+oS/CdnLl
         ITlA==
X-Forwarded-Encrypted: i=1; AJvYcCU8XsOHfUyjlbC+Co5OAlaj56MiuS2AkXwEcqWuqwDicJDe4xOGzo/UIvbS6GqB2bep2bbQZVlI5oB2Qi3dKM709R32Uf1zmTa/UkCzI4QtkRPuSMwYo64k5JbmZJ4wVrMGdHB1hkUvNIzk/vSeoZeui+0FWk67OK84g+69SM3nauV+xys=
X-Gm-Message-State: AOJu0YxQvlq+c0WlL/FgwlnMObO8zZ2afbin2tKRY08Y2sHozeUFpKLy
	PIQw3paOdSIllN7FKa8U8HIHvxLzJEmSofhsTfkuAi+uBy/ep0+M7mhrhrZ7zfwLr7pMAbx0Hoj
	3YJWpeqbLnAGmtspSU+nF1CQDWDQ=
X-Google-Smtp-Source: AGHT+IGL/ZuNDW+YAA14KxvITUONfWERjFMqYTVlIMjA2c3NxTdOFX1JFpnSxqA19fMs4gI4skjktyw1RgBSXBjql7I=
X-Received: by 2002:a17:90b:78b:b0:2a2:8a0e:1b81 with SMTP id
 l11-20020a17090b078b00b002a28a0e1b81mr3277609pjz.30.1712256210175; Thu, 04
 Apr 2024 11:43:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404-providing-emporium-e652e359c711@spud> <20240404153258.GA852748@dev-arch.thelio-3990X>
In-Reply-To: <20240404153258.GA852748@dev-arch.thelio-3990X>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 4 Apr 2024 20:42:48 +0200
Message-ID: <CANiq72kSfC2j07mAaV591i4kDwejWRYcFTvASgQmNnHVe5ZwCw@mail.gmail.com>
Subject: Re: [PATCH v3] rust: make mutually exclusive with CFI_CLANG
To: Nathan Chancellor <nathan@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org, 
	Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>, 
	Kees Cook <keescook@chromium.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 5:33=E2=80=AFPM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> Acked-by: Nathan Chancellor <nathan@kernel.org>

Thanks!

> It seems like this won't be forgotten about but if there is not already
> an issue open for this somewhere, it would be good to have one, since we
> obviously want this for both C and Rust code.

We track the unstable feature(s) at
https://github.com/Rust-for-Linux/linux/issues/2 (I just moved this
one there since it is close to ready, but it was in #355 previously,
and cleaned things up a bit).

On the Rust side, I think the main one is
https://github.com/rust-lang/rust/issues/89653.

It includes KCFI, but it is missing Matthew's PRs for KCFI etc. I
added a link to get those issues/PRs (or hopefully most of them):
https://github.com/rust-lang/rust/pulls?q=3Dis%3Apr+cfi+label%3APG-exploit-=
mitigations+-label%3Arollup

We could create an explicit/concrete issue for removing the `depends
on !` when Matthew sends the patches, though.

> As a general meta comment not directed at anyone in particualr, I think
> these 'depends on !' should all have some sort of comment or description
> as to why they are disabled. I can infer from most of them but it would
> still be good to be explicit, especially since someone might want to
> work on fixing the ones that are due to missing support and such.

That is definitely a good idea. An alternative could be linking an
issue instead (perhaps concrete ones for that, i.e. your other idea
above) so that we can update the status etc. easily.

Cheers,
Miguel

