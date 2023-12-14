Return-Path: <linux-kernel+bounces-189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 426EB813D41
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED4961F21157
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968812C696;
	Thu, 14 Dec 2023 22:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kryIFjzJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FF967210;
	Thu, 14 Dec 2023 22:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dbcd348f64cso26699276.2;
        Thu, 14 Dec 2023 14:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702592765; x=1703197565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GewXYhMBPjvgfSqNiYm+0p22+IJCJUykF8TiN4qTyI=;
        b=kryIFjzJooI5uzK0tVLs438eDoZBeS0/DvxjoJ+tfdfxGN7UXq+VpGGETOZ1CIx0W7
         giiqEuAsHbB+1jG5nYKhwqpzGiIPFJC7E0o77De54qw3/xJ7EUYuRJh5i+Nvi8BwD+zM
         BNAWCpaSXNoFk89s02ddBx3pKV43Lia7TphXFfj1gAuvqQm4dnvWO+LLwjtqkF9wnC+X
         9yQZMvTa0DzJdt9ZRYBPt4maUMwmTUlzvvU+tQy+pvZ/uvkpEzg13xJ+FNzNarf8dDKY
         3oOYcAvpVZ/NE7rrgGy4cOEgitQfhBbRJWQX8Urrwzp5wxbtdpIVlJLlRcyavfrxtLJC
         XHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702592765; x=1703197565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GewXYhMBPjvgfSqNiYm+0p22+IJCJUykF8TiN4qTyI=;
        b=voCG4FZt4wJP40wKA39CVK78F7aoD1kR7oPmnEavWUY04mWV0JiWFGsCGwDHUjr5uc
         s4TRpsrrbMeB4hT178k+fbfYE4paMf9ky4IND6sZk4DvswW4/aXRBHNG+V9BMHvoCvu7
         eiftyGw88LsiTS9tptY4kmiAZwi+5LZUiT6OvlfV2RfK5NZtZGv67Aa702MQ/nYCVbIz
         9ebmIYE7YTQgbMRvHbgQEcm5PWKQUowOvWQKt0lYPt8hOw/9oIpI7+ePx0Hxbh6W3WNc
         g120/l8StdSO7v+sd9Kpv9B6UT6eZEeTRL5X0A0kbOfHYHyGpp7ujPkBIrmrazO93tB1
         rBzQ==
X-Gm-Message-State: AOJu0YwzV0aN0b9VIbjVUgX8yk6KrcBU0EgYr9MNS3NL87g8RWefGovw
	EWoDacaCoztzp565baMNNMTdmviBkmkQ5VdGrAI=
X-Google-Smtp-Source: AGHT+IHAzqYLRTQoFGOeJ/iE0CLqEvZfXbrPZse0sTjrBDFxkIJbZXBj/INGKyvyb0CsKUsOrJE6WpLw/Y6imaj2Myk=
X-Received: by 2002:a25:a28c:0:b0:dbc:d7d6:92e8 with SMTP id
 c12-20020a25a28c000000b00dbcd7d692e8mr2031677ybi.23.1702592765606; Thu, 14
 Dec 2023 14:26:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e2b943eca92abebbf035447b3569f09a7176c770.1702366951.git.viresh.kumar@linaro.org>
 <1c03eb18-a6ac-45c8-8fea-46097bb4e132@gmail.com> <CANiq72=mvca8PXoxwzSao+QFbAHDCecSKCDtV+ffd+YgZNFaww@mail.gmail.com>
In-Reply-To: <CANiq72=mvca8PXoxwzSao+QFbAHDCecSKCDtV+ffd+YgZNFaww@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 14 Dec 2023 23:25:54 +0100
Message-ID: <CANiq72nSh16cBNOoErQ3nDx0gSqq0Co2kv2wKEyqr5YmYUzhbQ@mail.gmail.com>
Subject: Re: [PATCH V2] docs: rust: Clarify that 'rustup override' applies to
 build directory
To: Tiago Lam <tiagolam@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vincent Guittot <vincent.guittot@linaro.org>, rust-for-linux@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 6:22=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Or we could just provide a `rustupoverride` Make target to do this for
> us [1], since we have all the information needed and would be
> copy-pasteable by everybody. I can send it as a non-mangled patch and
> then Viresh can redo this one on top using it.

Patch at: https://lore.kernel.org/rust-for-linux/20231214222253.116734-1-oj=
eda@kernel.org/

Cheers,
Miguel

