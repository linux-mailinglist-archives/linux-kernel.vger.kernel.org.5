Return-Path: <linux-kernel+bounces-16740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6E6824325
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0364C1F250B2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717AC224C1;
	Thu,  4 Jan 2024 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n3mPtseq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783E22232E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4b71cdbc788so124333e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 05:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704376478; x=1704981278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xC0j8nNl0IjVq5e5DkTu2zl2RjAuSNRZYGbUYvQn0hk=;
        b=n3mPtseqEBHNdHwHjzDMddya67XPT+jx+YS3Mfj+B9svRdWb4i1DW+pxRAC+LlHLJE
         qu6DpLxAQ+GipxzYf4ahGGXOuOD36v3W6y5podQfjatbRpzhdEk2Wd5zDvIBM2NJGOzE
         DTSEsLbSG1P31uCtp4W0Qk1kr+FMnNgcY7NyWA6rvBtr1MvfdlT1QDCEzRaGzlsxyt6N
         6o7OTVwBK9Vec/kGoPY8kHWs3W+MAZTIsV0MNu4qvHuSA/fiqgtWD5k10tsaen6eqHpG
         OzFOib6HHSS1jWmbF0zjAz5mZrh68ZUD6QcG62K3/sdmVaAuxJM55fx/GQRquMwi7edA
         67Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704376478; x=1704981278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xC0j8nNl0IjVq5e5DkTu2zl2RjAuSNRZYGbUYvQn0hk=;
        b=qrJstfnCUWbh0nKOMpdfKuYJfXGzAhoNoVBvCSKOsNC3RcxE6nTczk3UbfSdb9sSNE
         BK14c7SNfLEi6HW2+IM2XmCPQzC6yktpC7aCjBVnRU0/NrBb3X9rNbKgFU9hSEBZdSsb
         jeWVibGe0UrHq1Cje7eNmcKDhtnS5FkSw9QabfAjj8ZQHxB9VnTFJsrcfvjdSx4CbI2N
         tSe/0eUAE32O1zoASUX7XZIwnPnV53yGvw+d6EZj8KSeBahe1YcH09aAYc7XaxPZ+l59
         ZMIYZKcfsuteTGfcaFcL+QVtI1o1Emw1t5xDP8J6OfA43krpAN44ueIuy2wcFJqHKHLu
         u0Ag==
X-Gm-Message-State: AOJu0Yy9e4ODfeVe21wxzVkLjTrUc5xprAPZQE6KvuIJ30+hH8FDEr6R
	WmS3fxkgG8XEWOGNenCklOg3hBAfV275CAUc2h35kqLGTYjr
X-Google-Smtp-Source: AGHT+IFbu7LeqKUR6Vj0pxOYX3eR00qsFCGeHZK2LuF6q/cVXgVxP38lTA89mlG8d6Yq8wLMW+CseqDx1eAtmEzXRwU=
X-Received: by 2002:a05:6122:7cc:b0:4b7:e96b:8b12 with SMTP id
 l12-20020a05612207cc00b004b7e96b8b12mr367724vkr.19.1704376478197; Thu, 04 Jan
 2024 05:54:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231216-rb-new-condvar-methods-v2-0-b05ab61e6d5b@google.com>
 <20231216-rb-new-condvar-methods-v2-4-b05ab61e6d5b@google.com> <ZYC3GR6LMEmRUQy0@boqun-archlinux>
In-Reply-To: <ZYC3GR6LMEmRUQy0@boqun-archlinux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 4 Jan 2024 14:54:27 +0100
Message-ID: <CAH5fLgikS57SoNz1WrqVYbr8-iYRDRD8RS2F_QN1YOuV3dk8MQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] rust: sync: update integer types in CondVar
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Tiago Lam <tiagolam@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 10:18=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> =
wrote:
>
> On Sat, Dec 16, 2023 at 03:31:42PM +0000, Alice Ryhl wrote:
> [...]
> >
> > +const TASK_NORMAL: c_uint =3D bindings::TASK_NORMAL as c_uint;
> > +const TASK_INTERRUPTIBLE: c_int =3D bindings::TASK_INTERRUPTIBLE as c_=
int;
> > +const TASK_UNINTERRUPTIBLE: c_int =3D bindings::TASK_UNINTERRUPTIBLE a=
s c_int;
> > +
>
> Similarly, these definitions are better in rust/kernel/task.rs.
>
> The rest looks fine to me.
>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Thanks! I'll move these and add your tag.

Alice

