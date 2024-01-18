Return-Path: <linux-kernel+bounces-29617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 604188310D4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55151F27AF0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E914422;
	Thu, 18 Jan 2024 01:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="YfWfyFAS"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7F533D3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 01:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705540923; cv=none; b=Wc2r0Y9742T8a+LDFJfC+wEIBRLNv2/J/OlKAg4GOR7pHP0hsm3PkrQGOmpmJoeGL0oA1dsRVrYFHLAJcJ/Fmw6eqon0dqFVzolE87ixD3wWq9MAfAA5atIJeEy5SQSiAI+uLkPZxApziwUIO5gBi2xgO/O6zrxzLY0Q2u7A0q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705540923; c=relaxed/simple;
	bh=TjqUprKHh3TupeogcpxrLmCi6JmfEpfeXd9hqG4x52o=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=aCyu3htCP6MUqhMn0ts+0+fTegKvbu4POlFFyz80C8cI8IGzoeCUg77mlaGnuf2k1EQ6WnUNO9HjJJ0LEQ9pnMcBjlw6xdmarx9Io/y3ZQxeO7D3NoSeDcY94gpcjYI9l0BTKrmEbNLARa0PCldb+Ofd0hVux0utG4cAe41EBB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=YfWfyFAS; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5ebca94cf74so113206057b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 17:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1705540920; x=1706145720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcJ87WuylELSBGB65CLThAXVE9BemkYUVCaMh1wpp2E=;
        b=YfWfyFASPrvZejHe6Ih+Svl4vdhUrECMybV3bVQgsh2ETcgK4K/qkd7ed9ra5dhFY/
         pF9i3BhoJpIImiTAWhW7TEKESh0lhhOgok+8qnpBIzRIVlGThI5IvvVzBHi67pUaOnuy
         BeQXU+VxRUY0x2248kenB1PV9SLYf0PMdJSxEbvEGgZZiC9lwdFELSr2cqAlDZLwmHQQ
         eC3vseJcbx6N35REWvm+cbOgu4J27nV9J12loUAvMvD2LTcyYobmPoqhWVFa8nMgz7Ce
         gxuqGEYYNUQSQ3Y5S8phhbFNQuugB3R3t0EbD22QhQlfaJ1HcG4LZLd4fdK6DSvzmJg4
         cgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705540920; x=1706145720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcJ87WuylELSBGB65CLThAXVE9BemkYUVCaMh1wpp2E=;
        b=Q7SfVdP9y7wAFrymGp4x8g4v2POCa/eVRWmk2LlPe1PGEmFQXdcAIzqB0lfSJUZrFk
         /FtlcX6r/p0oZj5yQOhdH1Ziak8S/0sZ9SCNM/oRG8mRj3zCNDdWcf7B0JO+6y7Mzgk2
         t2y2BOmwALzdc1Tl3VHFGTLw8RkhkoUuUxbpK+5c5hlOkUEGP+6aiM3mTypPqFFO4l2g
         So9RxQVfkb/9bf+cp6jW7tqhU/Xyyzjx0cVFUVXY+t6eYWjQ2GUs7g5xpzc35dET69vV
         f7Rdv3tBX626XL8oUPE+IHPliI4994RMEZBtHAEPeM71iH/fpDqzSwC8CPMhEPUpGA6U
         yJvw==
X-Gm-Message-State: AOJu0YxcXJUTSMHlzDYkn8NjfnTGQmN7RUlJNTAVCLWJE07NCmVb4nbb
	BMPsO5EZu+CLE74s6lrixrchF99kvvbjbeUevR45tlLNwFz8ge0nVoXPl/XEu7EnMeFHkakna3A
	UsXQzV/C9ZZPahD56he5HcMP1I5bZBHBiwsc2gQ==
X-Google-Smtp-Source: AGHT+IEvEpU+zAHKgdCYjLCG/6vV2dOuIUWUQuSckAMpqL67VacJ6pNKEITM9aM3JNk1TCqcRIw8adfCE9iGubmF/Yw=
X-Received: by 2002:a81:8204:0:b0:5d7:1940:7d66 with SMTP id
 s4-20020a818204000000b005d719407d66mr101988ywf.61.1705540920219; Wed, 17 Jan
 2024 17:22:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116160141.165951-1-kernel@valentinobst.de> <20240117001549.169160-1-kernel@valentinobst.de>
In-Reply-To: <20240117001549.169160-1-kernel@valentinobst.de>
From: Trevor Gross <tmgross@umich.edu>
Date: Wed, 17 Jan 2024 20:21:49 -0500
Message-ID: <CALNs47tMfa3CWaA3Z2sco8FgFW4UOC7_ESRZE0W6Z_1i6FBAWA@mail.gmail.com>
Subject: Re: [PATCH 12/13] rust: kernel: remove unneeded doclink targets
To: Valentin Obst <kernel@valentinobst.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 7:16=E2=80=AFPM Valentin Obst <kernel@valentinobst.=
de> wrote:
>
> Remove explicit targets for doclinks in cases where rustdoc can
> determine the correct target by itself. The goal is to reduce verbosity
> in the source code.
>
> Signed-off-by: Valentin Obst <kernel@valentinobst.de>
> ---
>  rust/kernel/workqueue.rs | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index aedf47f258bd..f63190b563d8 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -426,13 +426,10 @@ pub unsafe fn raw_get(ptr: *const Self) -> *mut bin=
dings::work_struct {
>  /// The [`OFFSET`] constant must be the offset of a field in `Self` of t=
ype [`Work<T, ID>`]. The
>  /// methods on this trait must have exactly the behavior that the defini=
tions given below have.
>  ///
> -/// [`Work<T, ID>`]: Work
> [...]

Just for reference, this behavior is described at
https://doc.rust-lang.org/rustdoc/write-documentation/linking-to-items-by-n=
ame.html#valid-links:

> You can also refer to items with generic parameters like Vec<T>. The
> link will resolve as if you had written [`Vec<T>`](Vec)

