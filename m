Return-Path: <linux-kernel+bounces-17680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76793825117
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251CC287F79
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1CC24B52;
	Fri,  5 Jan 2024 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NHI3SJE3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53BE2421D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4673b620d95so285265137.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 01:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704447895; x=1705052695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFpseWSlXa6VJ8x1Bw84TJ22oa6aTo4EtNJAEkzn/5k=;
        b=NHI3SJE32/yf9P1jX0pK04v0UXnSp5H5/4Kp0l/CbEQyHc/RYN77xBfVeaZXIggzx3
         4XEvwzy7pJAWlBiBJwQUVRQvl5VlMZAaJYmbo63qRh2QNsyvvTLOdZoXHtPPhX0rtlym
         bz6lUg7FfaQ4aGe6Cm48jZME8OORoFo52QY7WRqaAjOH/adnyLqlVvZxy5DHXPLC3Sgg
         8X3+FnVBcZlkweY26MoQ0GNbxaajtSe9cIo/EvWRIXPTGY8xz+0LMPbNGinBPjkmRSVR
         +U52U7xnsPUSfymXL/eRecpCGbDmkrzpPCRlhdU5aA5hNxJICbVrf6eTwFV8GsV30Q+V
         IgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704447895; x=1705052695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TFpseWSlXa6VJ8x1Bw84TJ22oa6aTo4EtNJAEkzn/5k=;
        b=xNQnRGw/I6UBqY1Y8pkjMbj7IgV7KdfbU8+Uuvjb+/XkEXOepA+J11DS9ZR1eUCUun
         kKvmPKgY6cZHJsDps7Ifhg2VaID8yFFmm0Rkvbt8pZuSpJ12kZ2MaAfGjw2hMPwwdpGN
         khdRESzHJjkUH//pp26aKo/AOYOBz2UXdZibg6IToGltZXCX0Sw/e0WE3iIIcVne/jFz
         EAHlk1YRkgrCler/z/vmFcS1undGd8VMyFjrWB5GkoT/rf63Jp7wnuW0XQ4DKb8yPikD
         E3sGqZipI/A6wy8RrMrK5z7zyd5RJwONPkhI2C61YLszkBLPKf835sXk/bzMMReyVzJv
         9cBQ==
X-Gm-Message-State: AOJu0YzcHTZetuv5wnluCxyrrKSJHiTQb7o8hQuW/WnPoJIpSGyXZUmy
	owV6CawjUQmS7VkAFndk+55SQSMIum9bfi6q3ZGd1hgxy89N
X-Google-Smtp-Source: AGHT+IH4FqpMAlNwGaCvWINiNBl7iVD5T08hKuClAAWaczaKj/nZDT0JQx8gWAWE1GGQR/8rwUprdx9cH4a66mdDW1k=
X-Received: by 2002:a05:6102:440f:b0:467:bacf:5a6e with SMTP id
 df15-20020a056102440f00b00467bacf5a6emr54778vsb.20.1704447895692; Fri, 05 Jan
 2024 01:44:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104-rb-new-condvar-methods-v3-0-70b514fcbe52@google.com>
 <20240104-rb-new-condvar-methods-v3-4-70b514fcbe52@google.com> <ZZc1ZcgzdRHtipr0@boqun-archlinux>
In-Reply-To: <ZZc1ZcgzdRHtipr0@boqun-archlinux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 5 Jan 2024 10:44:44 +0100
Message-ID: <CAH5fLggfvRrCLOEmkAhSuEsyZdXpwb6KkvosvfOjFcw=BSvyEQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] rust: sync: update integer types in CondVar
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Tiago Lam <tiagolam@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 11:48=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Thu, Jan 04, 2024 at 02:02:44PM +0000, Alice Ryhl wrote:
> [...]
> > -use core::ffi::c_long;
> > +use core::ffi::{c_int, c_long, c_uint};
>
> core::ffi::c_uint is not needed here. And
>
>         use core::ptr;
>
> is missing (for the `ptr::mut_null()` below)

Oops, looks like I messed up this patch. Sorry about that.

