Return-Path: <linux-kernel+bounces-22071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53098298BF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D41286691
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E77A47F52;
	Wed, 10 Jan 2024 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIRujL+s"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFDA3F8FA;
	Wed, 10 Jan 2024 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dbed4b84667so3254560276.0;
        Wed, 10 Jan 2024 03:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704885625; x=1705490425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FW1K//afvn0Nho0TscAWU/eSRLYGsm+Sr/mW3eupyTw=;
        b=EIRujL+sEX/mfgo4owObIZYzq0Rfpr21ttYFXqC+ljQECOPr6PCaqpCgXBgK97YMV+
         Pq2gEjUtxoYPpYSgO2HobeymfYr4wpR5lJ1/SLtnUipi8u2blZfhelD5Vo6oE9ZLDTqa
         2yssjYYV+xMFlf/Qrf0fh2JnquED9HVW6o98unj7zLttuXFOsDBVtdoDK1sTtoIQ9j/+
         60FFRUMnEATLOY+E+xa4W0b+iMtQnUsCXFfFrOB3MC1CuOKmIiaXBDZeRpuTfbn6hHXB
         BbEl8pctMDoElCKhHeaLyv1ZFSYbNz8s+UzBtpYMNSdxw1Rq+CmvEbWQn/9/rsuKOyTO
         GiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704885625; x=1705490425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FW1K//afvn0Nho0TscAWU/eSRLYGsm+Sr/mW3eupyTw=;
        b=hdd/c1QPxUmfvphE3VIcPRN56KrR+iT7fhVwNFwXW5W1ByYvpD19mbIJr5CqkKzaKr
         Ob+wo6Y77VFS0C8Jy5ev44LkHZfJ7QsgzL8dThLAnBfALykMm951aT6xaqUN4GtdavP3
         YNWg4oxjIYVRGSodw2TDFcEGLjWqzzqB4qJqAD5i45YdpU0kj1eqBstlMxp+tglnZaNP
         AaGTZiWLTzmK0pqIG8hXUZmgh6adHe9cs2amb72zr8+KJoyXk/Io3WbFpVbxtHvnXHKt
         NX7Ki5hN9jvwVRUmWgGZTzPTvZU90HEUY7cacTs+kvc7eWXJyujf0oBNobgq1i3ZbuGD
         hdmA==
X-Gm-Message-State: AOJu0YzFq7Vmvn5pga3UE6gFW7BTmOzUDcMKW/rsZYTuwwFYyDde+5bD
	8O/JtK1HiMKalS8SnVeSyId4x9rJJV3GYS/g5VY=
X-Google-Smtp-Source: AGHT+IHaa7xcgtCKMUHH4aDoyZhwFwZccl2P3DTlnAJLFyjFE/VpE1rrAyZzbqN6y/vAIhj6iEM0E8WaN6WqUlUJkC0=
X-Received: by 2002:a5b:d47:0:b0:dbe:ab05:a610 with SMTP id
 f7-20020a5b0d47000000b00dbeab05a610mr615185ybr.36.1704885625150; Wed, 10 Jan
 2024 03:20:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106065941.180796-1-wangrui@loongson.cn> <CANiq72=M5TrUL+9Z0nqKKcD=KHwyDA79fNYHgU2EJ+7u6Ct8qw@mail.gmail.com>
 <CAHirt9hd4W25p1kVNYXbEXrLj6NgT5r=EPWsoOmHZzS1qGR-yA@mail.gmail.com>
In-Reply-To: <CAHirt9hd4W25p1kVNYXbEXrLj6NgT5r=EPWsoOmHZzS1qGR-yA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 10 Jan 2024 12:20:13 +0100
Message-ID: <CANiq72nw2UHd3Kek-Fmvk_3zE=z56wYJVQJq_syYagru5+wo8g@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Enable initial Rust support
To: WANG Rui <wangrui@loongson.cn>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, WANG Xuerui <kernel@xen0n.name>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-doc@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 4:22=E2=80=AFAM WANG Rui <wangrui@loongson.cn> wrote=
:
>
> Thanks for your comments. I noticed that the refactoring of the build
> system to support the use of Rust built-in targets is still ongoing.
> Could this take some time? In the meantime, let's proceed with the
> generation method.

My pleasure! If you mean the first patch of the arm64 series I linked,
we have been waiting for a while for that to get merged (hopefully
6.9?). So, yeah, as you say, it is probably best to continue with this
and then you can change it later after the arm64 series lands. Thanks!

Cheers,
Miguel

