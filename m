Return-Path: <linux-kernel+bounces-16762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05451824374
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDA091C23EF1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7C722EF5;
	Thu,  4 Jan 2024 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DxOtbUNN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B78225A1
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4676dc16009so145102137.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 06:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704377853; x=1704982653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giLoYiBuCJluqiJ7Duk1l5c9a+I6JQIaND7ild3LKSE=;
        b=DxOtbUNN23LHRxMwsp+MWzHZ3AYFsf2oqqxoROjFri+6hjipMn3pmAcusDpfP2VKdz
         RYNoiKhcm3BPP9LjY9fAPi/YocEf26THJG2amYRvUAtIEVBh2AC5s4K4MhQoHJfe5UHC
         PsFZCsxy7DWX/s69wBUaNpyXDgB9zO1D6BkYDs9nD0/pJTbReuHk9Lvtf+uYXoOqcXQ0
         nALgk6P+ZW8/Qk2F00eNDKDD4mRp8MBNr4ORcERWfMXbVA2CV4eR4A6DHZYJ6LBHVcce
         H0k8BD/9kg1hHccR1/80UpBGnrEk5uQKzaZkrP6B0Tnt3dZ1S+SZPVprYmyMWrV7rq6W
         z53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704377853; x=1704982653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=giLoYiBuCJluqiJ7Duk1l5c9a+I6JQIaND7ild3LKSE=;
        b=WMDap/AuZBWQLIgQM2RcxlnTZxV3X0OD1WJF8nVL7FnUGBuXq4fvWE9rRx3zhlUlyg
         i5imvrGwv+Q3dRMxbd1zw4QBYXLg90I2mC0heovKYw4aMT7AVc1fpBELuWLOOqzOUNed
         F0ilJHga104b9VjihqrTwbpW0yVQ/UPRV+mgnvVVgm42yhq2YCKvYqF9LhBlRfLXYSaH
         3xe+80pnpW+d71jgZWtMDVdThCVa6YFUgzQqhxCAE5TVy61pxbkWhlqhrWmhTmnIxAQp
         fCbQ+pcWYtSZAhERhP/v7wW7pWw9HF29YcmjqdrQEVELR8/ATpVUWFYExDXo7SKhN/5v
         3k2g==
X-Gm-Message-State: AOJu0YwvBWYtzhYB5Qaa23ppn5bBU9nrTqUut8fZByMq/PSqbdSZumNB
	8Ow6ILxO7U4PE/8G1ZX8C8Da7Jx6ZRqCJXZaF5zx22yf6MQH
X-Google-Smtp-Source: AGHT+IGGmXT5NwaRXznAvd/khpPo+30lICXph7Zp7dFvuoRHIJ8Z66QH5RcDJIO3wncQMw04tfWxFlWfMufxu9XEDlI=
X-Received: by 2002:a05:6122:a01:b0:4b7:3eee:3a4a with SMTP id
 1-20020a0561220a0100b004b73eee3a4amr347951vkn.28.1704377853494; Thu, 04 Jan
 2024 06:17:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104-rb-new-condvar-methods-v3-0-70b514fcbe52@google.com>
In-Reply-To: <20240104-rb-new-condvar-methods-v3-0-70b514fcbe52@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 4 Jan 2024 15:17:22 +0100
Message-ID: <CAH5fLggzw8K-MDaYPDULL1My4HooYwiZ+18aC6+RxYvL+XyPEA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Additional CondVar methods needed by Rust Binder
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Tiago Lam <tiagolam@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Cc: Martin Rodriguez Reboredo <yakoyoku@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 3:03=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
> This patchset is based on top of Boqun's patch [3] that renames the
> existing wait methods to follow the C convention of using the
> _interruptable suffix.

I forgot to update this part. It's actually based on top of rust-next
(which has patch [3]).

