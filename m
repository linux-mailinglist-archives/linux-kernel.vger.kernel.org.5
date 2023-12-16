Return-Path: <linux-kernel+bounces-2281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E5F815A7A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA3D3B21625
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F03D31A72;
	Sat, 16 Dec 2023 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUUZWm+G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9FE31A6B;
	Sat, 16 Dec 2023 16:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d3470496e2so14680605ad.1;
        Sat, 16 Dec 2023 08:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702744975; x=1703349775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Dg7+JE+RvQYLP7f8Y6LErJNo48c6DQMGYf9ZdHEKXo=;
        b=nUUZWm+GQ08tLqzCHHwxCQocFsTO8sakHwLX5Xzbj1EPgwsgrZmIzf69DyG7o0GD2I
         9GV0/VdvZCpRWR8RuWj5Mh5KpO8uqqAWVlRxFnG+LdEqoyqdEVrQX9OV84LVGqkNopVc
         8YRRcQE1TY5K328/GU4k/Sj2MpogqruxXPjp88dNH15FZh09epKsjgnj2UDlYuDLeWvT
         gyCRtzuGS7f0AGDdseFyJ97W0we/IgwnlRP/2+oHfelUd/zpn3widY6RvDFRscThpNfb
         rY0xgqEyRjdM0Ld3xW/gSZe0rqYWDF3mQTCROvvFcmIxo4eZCcm4Bm3n7/ls635oVkdz
         yHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702744975; x=1703349775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Dg7+JE+RvQYLP7f8Y6LErJNo48c6DQMGYf9ZdHEKXo=;
        b=eWEtpfOMLnVc+npmegs1E/Is190SjQXaF8ITtJ6i2V+YcfzphNB1sG6c/X0zN0m3kB
         QVb/VfZNUjjOOuue9NKRtE44tj4kcmqLWEbDzT3JcwonGNsfEOmwwr0FwaGQZsIiSEuj
         xvaHKHhqOA4mYEfGh9SmMcLl+tZK3Rcc7YcTZ6lNNVqTfhZdAjj2d3i5suo936fEa73u
         VY1ndGZZ8EG96TOWCiZ+rtWMndgKhsPiaLG2OzAUvCXn3NbLv0+KEl1+YOUp7Yr4ZoJI
         F9Fs1ZB6EGUaPhB/F11oVEJxfW+qG7DCA/vWKjerMDUmY64rMhqft5X2cAdKjDiCrFdZ
         npLA==
X-Gm-Message-State: AOJu0YyGiDxtfc5Q7WqSZmJ+iVNUFpKaJPxNoSHAm9HM5FFGJMUChzCR
	KL5uUiemhjXo75ZZAnkMUtM=
X-Google-Smtp-Source: AGHT+IEJTRyrYYkxNmvy9HEys5OOf2GNRiXQQNMV2zKzPFE2VavloG6Dq3SGRbv8TD7f125guZhwdA==
X-Received: by 2002:a17:903:22c7:b0:1d0:7965:f530 with SMTP id y7-20020a17090322c700b001d07965f530mr14734154plg.88.1702744975467;
        Sat, 16 Dec 2023 08:42:55 -0800 (PST)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id l4-20020a170903244400b001d060c61da5sm16103353pls.134.2023.12.16.08.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 08:42:55 -0800 (PST)
Message-ID: <76415f1d-174c-4cee-9b58-e956be6bda54@gmail.com>
Date: Sat, 16 Dec 2023 13:42:30 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] rust: sync: update integer types in CondVar
Content-Language: en-US
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Tiago Lam <tiagolam@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231216-rb-new-condvar-methods-v2-0-b05ab61e6d5b@google.com>
 <20231216-rb-new-condvar-methods-v2-4-b05ab61e6d5b@google.com>
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20231216-rb-new-condvar-methods-v2-4-b05ab61e6d5b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/23 12:31, Alice Ryhl wrote:
> Reduce the chances of compilation failures due to integer type
> mismatches in `CondVar`.
> 
> When an integer is defined using a #define in C, bindgen doesn't know
> which integer type it is supposed to be, so it will just use `u32` by
> default (if it fits in an u32). Whenever the right type is something
> else, we insert a cast in Rust. However, this means that the code has a
> lot of extra casts, and sometimes the code will be missing casts if u32
> happens to be correct on the developer's machine, even though the type
> might be something else on a different platform.
> 
> This patch updates all uses of such constants in
> `rust/kernel/sync/condvar.rs` to use constants defined with the right
> type. This allows us to remove various unnecessary casts, while also
> future-proofing for the case where `unsigned int != u32`.
> 
> I wrote this patch at the suggestion of Benno in [1].
> 
> Link: https://lore.kernel.org/all/nAEg-6vbtX72ZY3oirDhrSEf06TBWmMiTt73EklMzEAzN4FD4mF3TPEyAOxBZgZtjzoiaBYtYr3s8sa9wp1uYH9vEWRf2M-Lf4I0BY9rAgk=@proton.me/ [1]
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]
> @@ -174,22 +178,15 @@ pub fn wait_interruptible_timeout<T: ?Sized, B: Backend>(
>       }
>   
>       /// Calls the kernel function to notify the appropriate number of threads with the given flags.

There are no more flags, please update the comment.

> -    fn notify(&self, count: i32, flags: u32) {
> +    fn notify(&self, count: c_int) {
>           // SAFETY: `wait_list` points to valid memory.
> -        unsafe {
> -            bindings::__wake_up(
> -                self.wait_list.get(),
> -                bindings::TASK_NORMAL,
> -                count,
> -                flags as _,
> -            )
> -        };
> +        unsafe { bindings::__wake_up(self.wait_list.get(), TASK_NORMAL, count, ptr::null_mut()) };
>       }
> [...]

