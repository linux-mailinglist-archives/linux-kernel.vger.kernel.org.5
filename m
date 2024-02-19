Return-Path: <linux-kernel+bounces-71631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3737F85A80A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1C3D1F21E3C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6AE3B7A0;
	Mon, 19 Feb 2024 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeJlezPb"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EAD3A29A;
	Mon, 19 Feb 2024 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358484; cv=none; b=Vl6oXuRhtUUbK87kVrJVaI8UA+WSMDxbSAPg7x2o8og75eMRsyHhXRd3vzKwOgxtz0LyvrsUClXkS45zH8HoIFjEL7c/LgQjSXQyjWf9MG4HsU1GcF+DX40DxWp1U2m4SYyxAdM3dgzFOfMbER3HY45xew29lTOr0+FHD4SxRRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358484; c=relaxed/simple;
	bh=RjJaUO3UTTrFsrhoX11/20RQ9F41KV1HxKWjbf2SUaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k6nE4FUp2lrDxEVRm1EKfRQvzWEgYB3Hd646ejckDbRM4OjbsHWgVlOxuY2poWs4StiIl8j1KYL0D4/rumVW9hTVLBHOX1qpKvqVgYTIE5Q/q6I9OzpT4kXM/gAGbHH7RrhcbwoZghrAEnjTWBL80WBZC0ESVwTIu4ThqYe+FGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeJlezPb; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-607f8482b88so29075147b3.0;
        Mon, 19 Feb 2024 08:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708358481; x=1708963281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjJaUO3UTTrFsrhoX11/20RQ9F41KV1HxKWjbf2SUaA=;
        b=KeJlezPbN3clz3N8ckKag+gGWgOjR5ddzRX6aj8ni4sAbaoN6/318/CRSmFVt6sITe
         nY5+nrvE79E4dnTvv6PXTmZVPagZDE9oqMSakn/GX6ZVPmXuQie7XQGpsbIpP0MR7uYd
         ZixkVC7RKcQs/Pjyr8qaAWGpF/EPLX7VXC5v4MzfLUGRC0TGYrhhEo9xC81ALnACbm4w
         UQoaPaF7kdkqsbFd7YfApBrbOfezl1dZ0ZVAeYca5dI32xxrURaJgS10FvpGqBUJtk2L
         vL0ifCmbWOe2ZCjMSGxOzxKvvAjfX5Pt+xWqx2meF8wqlLL25YbLImL65ZPbv9J3DuGL
         hUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708358481; x=1708963281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjJaUO3UTTrFsrhoX11/20RQ9F41KV1HxKWjbf2SUaA=;
        b=ozLVeeH75njGCVauI4SzP/c33jyAFVghDc116gya6VFqAokfufbWUNukz/ZJb3dyI2
         +ycCvExRbGvMVkZGKhxSIU45ED7MRe0qiefkZeKj1vUAXwYqx3ujeZP1fmnTX9Whz5Bb
         3ECCznQZx09BqV33C0qT6B/5Gfx396KEv/lLtcwEUu2i0UJenZYtb+Bx3JSA+uinSZl3
         mewQItM7HHc6XDLt/sEIg7HVqDguI3arBfMIXKQng0n1mdDfgb9F/GVrPFA2n/meXT25
         1JaK8LzeGeUM1/H2iPuFWM4oYCArCKqHFA0EsoeafVPFmzSh9kOW6JNOnJyeS0iFcjM7
         mBkA==
X-Forwarded-Encrypted: i=1; AJvYcCWR4RZmK0hSjLpVOKGa3RpnvqUw5HNW9MMXiB85K8SpJ93pokZC1FpWtYUCo9PyHDU9C5P4lCR7z+kOpqRPqAJMQ1cF7KXjvD3JB/kx1ea9gm9Rotmg4EmN9GBb0TY0050INbQ9SUoXhLu7IlQ=
X-Gm-Message-State: AOJu0YxH1yrucPgYy5wsv5xCEZUK8wKcbwANdOltcbq+IXT8VVsTHk+L
	OvGdvEqaUAr/ta7AMOnA9jX8L9n7zsb/0HAj8DQa8L1dtko7wm4hM8HkEmz1B/OsJpIVJxjZJhw
	mWLgJl7ez8eGMN/vfT4F5TTmq+lM=
X-Google-Smtp-Source: AGHT+IFV7cnfqHWd3LWv+ZHLoC4tmJGJ/Lk4xaw+zFGGTkElEoABI2C5HfHRAkYwwL44+IqGRK7P3TWcTOqJsPV5ric=
X-Received: by 2002:a81:b614:0:b0:607:f4b9:11aa with SMTP id
 u20-20020a81b614000000b00607f4b911aamr10367352ywh.21.1708358460925; Mon, 19
 Feb 2024 08:01:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217002717.57507-1-ojeda@kernel.org> <CAH5fLgirUqw2hkEgFKOV4a2N2sW-GAGVY=KkkyzptMN+H2txfQ@mail.gmail.com>
In-Reply-To: <CAH5fLgirUqw2hkEgFKOV4a2N2sW-GAGVY=KkkyzptMN+H2txfQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 19 Feb 2024 17:00:49 +0100
Message-ID: <CANiq72=r9cE5ZT7EWe77g2dfprBx+DBrujo=mcA7r1hoO+=P0w@mail.gmail.com>
Subject: Re: [PATCH] rust: upgrade to Rust 1.77.0
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 10:06=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> Maybe you should just add the as_ptr method to ThisModule now? It will
> silence the warning, and doesn't trigger a warning of its own since it
> is pub.

Yeah, either way is fine -- I meant the patch to be independent and to
avoid adding an API without a user, but it is not a big deal.

> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Thanks!

Cheers,
Miguel

