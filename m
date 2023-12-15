Return-Path: <linux-kernel+bounces-751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A0A814585
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74CF21C22BFC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A303F199C2;
	Fri, 15 Dec 2023 10:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4A4ht8jm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4E91945E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 10:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4b2cdf382d9so156449e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 02:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702636087; x=1703240887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFkrN1vK3BylaBocXztGHMiijGax/EL/4gaHlS2BTvM=;
        b=4A4ht8jme8JDkdqLMhO+eAuWQPted3jVl0gh2bPWcADF3jlNsGJ+uEZEzuPXfVvnk1
         OsKgQdwRr9Syv9yYInmliQDGz7ibeB3CIWBN7PiIZVeBs3kR0HrABwfF9SwMLzTVsZ6h
         O5rKsHz4rEyin4B1Xbzq8P/Ik9+o4Reh2W5d1E0xPtB645KWAmfImiLFwMuWVEgW3hy/
         YIZhrPkm3uFPG+8gFlqVmbH3mKv2+ILG1yaao3kQ3zWxKeqmuiYD6QrAnK4uHQMEe3L6
         dqFWRHuPIeZ6tDgfcdMXGGfz/rg+e4cLjXBuWfNjHQhpeEwG1fTFzfJNVagaHrjmwKs6
         MzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702636087; x=1703240887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFkrN1vK3BylaBocXztGHMiijGax/EL/4gaHlS2BTvM=;
        b=vtX1aGjj6yDd2EP+9RqDgshbAMmA4nvC+tNhER42Q0iO9rH/BUKUwNuyapbkVIXPhQ
         CXqFNX2VqM7OOiT60gId3MtRJGHhrt3APMsgTpw8xKdmt6j27ywVw9wgtbhT0goF+icv
         IittOVuoSGiaV7n3F8NZ/alSMnehCz4PCV6k636I8hB9OebRWz+TrSEjtNcM97N2FJwn
         gFGr3M7kK35WhSsshhQUHyLN1vEoNhtYQpgudQHklbje2exS8tKOAFuqUzfXTT19in6E
         bTwyvSBdHsKaGZRhfhKdn51Y51NlPsD92gBQ9dy/Mg2k7U7eydAjyhn7AOXCuUMA+vIC
         1FVA==
X-Gm-Message-State: AOJu0Yz09v8XRn6txPX/E6jvSN7faCbsh3UvKeP95HJfoJzrtuUI0Xjb
	odJqabWYOSka9TrDwy2MKEOsKSpp40Q8qnmBa+PXyu/vXVOE5I9hmO9Ipg==
X-Google-Smtp-Source: AGHT+IHrgzg5Xy8glhNabG8mQDgwQ4Syagis5L66d9FePm9gDh1kQJ1PjnOm/F0wHWssEiQYB+/rqg/OdCr/s913HTI=
X-Received: by 2002:a05:6122:448d:b0:4b2:df58:7de1 with SMTP id
 cz13-20020a056122448d00b004b2df587de1mr9223620vkb.23.1702636087417; Fri, 15
 Dec 2023 02:28:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZXtebif2S1CyJRik@boqun-archlinux> <20231214200421.690629-1-boqun.feng@gmail.com>
In-Reply-To: <20231214200421.690629-1-boqun.feng@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 15 Dec 2023 11:27:56 +0100
Message-ID: <CAH5fLggriMBLWVx5i1efHdiNveVutvRfcA6mydNV9egzEFnnxw@mail.gmail.com>
Subject: Re: [PATCH] rust: sync: Makes `CondVar::wait()` an uninterruptible wait
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tiago Lam <tiagolam@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 9:04=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Currently, `CondVar::wait()` is an interruptible wait, and this is
> different than `wait_event()` in include/linux/wait.h (which is an
> uninterruptible wait). To avoid confusion between different APIs on the
> interruptible/uninterruptible, make `CondVar::wait()` an uninterruptible
> wait same as `wait_event()`, also rename the old `wait()` to
> `CondVar::wait_interruptible()`.
>
> Spotted-by: Tiago Lam <tiagolam@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

The diff is a bit hard to read because you swapped the order of the
functions, but LGTM.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

