Return-Path: <linux-kernel+bounces-29594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D06831091
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B622830A5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812581844;
	Thu, 18 Jan 2024 00:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="BtXTn6ob"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD6BA55
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 00:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705538316; cv=none; b=LwwaTfAKrNzN+hv9b8mAcAaMTKxErR5sT5Jv+hzu8mpZZHGQDZMtFvcB6sA3Q3lULctXDCRRrPtFmlw+NDgndC6nYAf9Ueeu2GQuEXP5KjSZIHykYx0QFGTC0lVFfliY4uJoQ1fbDV9s8aXFVtAep/XbCaIg3wOgU7h+5xjkcw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705538316; c=relaxed/simple;
	bh=SBQBBQIwfX1zJwK3wxf4dU3QqzrPgQS1EHSC4mnFb6Q=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=WfJVVHAKODjVOsiEyorkEHzv5DbsoU0S3kuHtkrWY5Qp3T2O6Nk2MxAYeT0E7Z7vCO/n8IMQTmPiMP9t5ADbIESXoihHRdXumCTTc39pevSk+7tdJVRhS2l7t6t/SXwaTgFD0l1ibcezFssnWCVTLhsBLwIydOPjgLaW2+jjITQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=BtXTn6ob; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5ff88cbbcceso426927b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1705538312; x=1706143112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGG4atFEY41i3tyWaRPBdDpmdKCXRC2AZy9zs1ZOjKA=;
        b=BtXTn6obQUKySoYG1z3JbzxnS8Q/+oUSGpPVU+2n57eTY2qb5i6tbz9NQgsX0Gwz6+
         5rDx6lmZ/R8m/+TSNgEXeso3oogWId5zbpVND1JTU2Kg7W4qKX1cRubaxB2k+TZhVnp/
         2V/YIQ2w0T5oabn0AxVe8L6Rov2OCgkmMVLsGlCTODGh4A+RlihVTZbyCNRmYspT+Gg/
         eC1saFlO+rjf0Q5/3/5+nXZPn/ZsfhRJykhmZKf0Ogr9fTAO2anhDvdnvbGJBFuqc2Gi
         q4XWM1VTAfrlFkMqxE4kedutHPBmXmn3lExi6r2QMWuLi9v4PYdBIXXzxK18Tm2Db8ir
         QyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705538312; x=1706143112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGG4atFEY41i3tyWaRPBdDpmdKCXRC2AZy9zs1ZOjKA=;
        b=F+7GrAxzzrOQ1pITvkrKMDpDt3EcDUfTaxqcYl97DET8dOKJ/f6EnpwXfTRiIsG9av
         dJl48HqO2u9gihw3WIq+Y5icXmQriipdloPRs7IT2EAGm7FhJc6PpcZFPALqrpi2PSyr
         lcjsy2fAirzIRG299IErpUJIeX3K4ezFW0sRVHZx24M0iG6NgAZYndcoqvpfd06ttjxJ
         J+J2mFjebv/4TLkNkb1oTDuIqNIoguZudZAkiWZ5OBcGGqS+K36V3QG7NYH67ftVM/BL
         xLIfoJX0ibZb3pj+A5Ekj2f0Qx5I5gP0KszSzgANXDe3zm2dr6b+bDMoyJIeU1Vus8fS
         Mwtg==
X-Gm-Message-State: AOJu0YyfxjJDWq+lSj0GekN9HEqonMWiQUNyPYufefZggPpe+iDYwR3s
	Zf9VIxGZb+2ctFo0TH4EmbN0SXnhGzsRAed9parvlzH0GpkLJp51Q7tQmmjML9GwkxYW9M/ihyc
	6YLGE5PfMdv0Eo92QxHpYS7nSfHHz3dMgkdOy0w==
X-Google-Smtp-Source: AGHT+IFleKtsKKpVS+cdH2BPVyA0F8ifuJWLDtVjBM/i02Ip6dWVxOzOsg8/NtUGwXWk/+HyDRd2x8GAs+lec1dyUVE=
X-Received: by 2002:a81:4846:0:b0:5ff:7a72:3496 with SMTP id
 v67-20020a814846000000b005ff7a723496mr85488ywa.12.1705538312603; Wed, 17 Jan
 2024 16:38:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116160141.165951-1-kernel@valentinobst.de> <20240116220411.168016-1-kernel@valentinobst.de>
In-Reply-To: <20240116220411.168016-1-kernel@valentinobst.de>
From: Trevor Gross <tmgross@umich.edu>
Date: Wed, 17 Jan 2024 19:38:20 -0500
Message-ID: <CALNs47u037Bjk60E4x+c0+fk+2v5sc8iDzD0ztyqyJRdMDBgeg@mail.gmail.com>
Subject: Re: [PATCH 04/13] rust: kernel: add srctree-relative doclinks
To: Valentin Obst <kernel@valentinobst.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 5:35=E2=80=AFPM Valentin Obst <kernel@valentinobst.=
de> wrote:
>
> Convert existing references to C header files to make use of
> Commit bc2e7d5c298a ("rust: support `srctree`-relative links").
>
> Signed-off-by: Valentin Obst <kernel@valentinobst.de>
> ---
>  rust/kernel/lib.rs          | 2 +-
>  rust/kernel/sync/condvar.rs | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index e6aff80b521f..0d365c71cae2 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -75,7 +75,7 @@ pub trait Module: Sized + Sync {
>
>  /// Equivalent to `THIS_MODULE` in the C API.
>  ///
> -/// C header: `include/linux/export.h`
> +/// C header: [`include/linux/export.h`](srctree/include/linux/export.h)
>  pub struct ThisModule(*mut bindings::module);
>
>  // SAFETY: `THIS_MODULE` may be used from all threads within a module.
> diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
> index f65e19d5a37c..0bb76400efd9 100644
> --- a/rust/kernel/sync/condvar.rs
> +++ b/rust/kernel/sync/condvar.rs
> @@ -77,6 +77,8 @@ pub struct CondVar {
>
>      /// A condvar needs to be pinned because it contains a [`struct list=
_head`] that is
>      /// self-referential, so it cannot be safely moved once it is initia=
lised.
> +    ///
> +    /// [`struct list_head`]: srctree/include/linux/types.h

Hm, I wonder if we could figure out a way to make links point to
specific definitions in the C headers with # anchors. I'm not sure
what the intended platform to view these links is.

>      #[pin]
>      _pin: PhantomPinned,
>  }
> --
> 2.43.0
>
>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

