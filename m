Return-Path: <linux-kernel+bounces-72702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E72B85B7A4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28CF6B20C90
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A27605DC;
	Tue, 20 Feb 2024 09:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mJ7JAnEG"
Received: from mail-lj1-f201.google.com (mail-lj1-f201.google.com [209.85.208.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3369F5F542
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421749; cv=none; b=IAv3kU9lnVuGzIwbcXufFx+V4HgfYkY+rrV7MgCmJ8EEbrDQ6q/KLJBsq4SkCRIlqujPxb073MqWkuoiDjVmzsYyu1ubzL6vJxdTzNvHBp7GjHyaLThpIAMFT/DnHVONvgUEdtgXQMcZdOm9GviHZIJvRzI3WblixQgue7VkIaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421749; c=relaxed/simple;
	bh=Hq0Cmy5FJkYWn0RlKLg2mQTAvevk9epBCAsv3Id1SNs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZDhKz+QqltQ0YF1O8c51vjc/5ue2p3ZpfLaus6L6KDPc2SbSJcKYb9fp8U7JM1sAC/DHTsaPvZXVbiAfsi92Ayqxe/NiaU+I9gKhJqskp/YPU/Pa+2RpbFlbZU6UMC8NXJshFw8bmTXcyEJq8rVjOwqdCRwWRXMSxdfpPu7H56s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mJ7JAnEG; arc=none smtp.client-ip=209.85.208.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f201.google.com with SMTP id 38308e7fff4ca-2d055407fa4so46758921fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 01:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708421746; x=1709026546; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eGvW91C4grW9jhiVdhrUhasqpBxGbw0RjsBpYtBt9c0=;
        b=mJ7JAnEGg8quhRSBGZ0cFaVNo1ORtCAEQZWEMIGqwIjqTLBupG1hH1fbzd4RCNCIH9
         3shfCSFinYbnuVbmsA2ECa+cvBNE405ALB00uVo8yICpYHibHgcfdoEaTlXGBrdLpHNL
         kwvvagJ+nvbu04131o1fgB+Lan7DkatzkPhy5oM0i7i7kjBMrDjXqw8opTiKhQo3M+i0
         H0WFhVrjMOSniRIcB+DcYgzXHysNgp0f/yQ3CMbZdE31n3BnP0PzMUjvxnqbzW5zQF80
         F1JiKn2I8y4HHFGZQPMyjl5tRwWVOfFko5PcwwKRMV6Z7Ib97hf3r4Qhr/KRh479WXl1
         Ieuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708421746; x=1709026546;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eGvW91C4grW9jhiVdhrUhasqpBxGbw0RjsBpYtBt9c0=;
        b=JhIP+tYT97osR3cU5pSP0qTgpjMCHK8MMXy+ZdJp45Qz3PerOsg1pc4enEDkIa0Ezg
         v+9mnE5Av7fJUBvXuo9Y/KtZZabPfJPcuZzYo1GTwV69puglzR+pr3aC3mQXMohSCyUd
         gGrqCAMvLzhFl4SFDXZxvcpFxGkA+oEl1amKrAoQKYpW42Tc8FGoH8CIl72E/8PmTgx4
         +4s8EzEVIMuMhmxTv/XyGU/j2zkVO22rUiI8yZsBJoHxEli9td0iwT4Pef5+3m3grnaS
         HMwsWcg78jokYU3Mxa3DRHrRApoXbaNh/4NETTAn5D8gG8+coel0nJ9lIJsXM43KE+7H
         edmw==
X-Forwarded-Encrypted: i=1; AJvYcCVG8Y/XDM3FMul6sRZl5I8V1jXgUuk4IRagKdozJCPzl2eFRSwSbrnvUnoWfuRPggmYe35m+LFAQwJMgFtmQ0VgENweeH8uh8pZlANN
X-Gm-Message-State: AOJu0YyBXQHn/r18AtmX2Xg2zNlpaMm/YLCrFO+RPRJB1YY8PDIveSrd
	5IZZdKdIgLK55Kqs0zMf0fpSRFSvb06xuA0bHGZuWft58bbZTuJJ2m5R5hZLKNxm4co7cIhtH1b
	oyJZny4jzQPWaGA==
X-Google-Smtp-Source: AGHT+IFMRTrmb0//fhvPOtv3qog+JWK2GyME95bme+y5LFmL0oHTci1rMmg42oFwzH8JNMisvGMZxgj0+++A55s=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:651c:104e:b0:2d2:c6a:5731 with SMTP
 id x14-20020a05651c104e00b002d20c6a5731mr15606ljm.9.1708421746047; Tue, 20
 Feb 2024 01:35:46 -0800 (PST)
Date: Tue, 20 Feb 2024 09:35:40 +0000
In-Reply-To: <20240219163915.2705-1-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219163915.2705-1-dakr@redhat.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240220093541.280140-1-aliceryhl@google.com>
Subject: Re: [PATCH v4] rust: str: add {make,to}_{upper,lower}case() to CString
From: Alice Ryhl <aliceryhl@google.com>
To: dakr@redhat.com
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, linux-kernel@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="utf-8"

> Add functions to convert a CString to upper- / lowercase, either
> in-place or by creating a copy of the original CString.
> 
> Naming followes the one from the Rust stdlib, where functions starting
> with 'to' create a copy and functions starting with 'make' perform an
> in-place conversion.
> 
> This is required by the Nova project (GSP only Rust successor of
> Nouveau) to convert stringified enum values (representing different GPU
> chipsets) to strings in order to generate the corresponding firmware
> paths. See also [1].
> 
> [1] https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/topic/String.20manipulation.20in.20kernel.20Rust
> 
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>

This looks good to me, so you may add my

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

However, it looks like this patch has some clippy warnings that need to
be fixed before it can be merged.

$ make LLVM=1 CLIPPY=1
error: unneeded `return` statement
   --> rust/kernel/str.rs:267:9
    |
267 |         return Ok(s);
    |         ^^^^^^^^^^^^
    |
    = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#needless_return
    = note: `-D clippy::needless-return` implied by `-D clippy::style`
    = help: to override `-D clippy::style` add `#[allow(clippy::needless_return)]`
help: remove `return`
    |
267 -         return Ok(s);
267 +         Ok(s)
    |

error: unneeded `return` statement
   --> rust/kernel/str.rs:284:9
    |
284 |         return Ok(s);
    |         ^^^^^^^^^^^^
    |
    = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#needless_return
help: remove `return`
    |
284 -         return Ok(s);
284 +         Ok(s)
    |

error: deref which would be done by auto-deref
   --> rust/kernel/str.rs:677:58
    |
677 |         unsafe { CStr::from_bytes_with_nul_unchecked_mut(&mut *self.buf) }
    |                                                          ^^^^^^^^^^^^^^ help: try: `&mut self.buf`
    |
    = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#explicit_auto_deref
    = note: `-D clippy::explicit-auto-deref` implied by `-D clippy::complexity`
    = help: to override `-D clippy::complexity` add `#[allow(clippy::explicit_auto_deref)]`

error: aborting due to 3 previous errors

Alice

