Return-Path: <linux-kernel+bounces-3163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CE0816815
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6FA8281F12
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8061079B;
	Mon, 18 Dec 2023 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJnyG9Ex"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5F111193;
	Mon, 18 Dec 2023 08:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e3c6f1c10so353332e87.1;
        Mon, 18 Dec 2023 00:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702888425; x=1703493225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w7msxpJgBBjQPtZZCsb1ltJW2M3TBsdRo5LCmhi6CvY=;
        b=jJnyG9Exkp5mfMRYojnoHxE5FMvSvoqzF0VcD9oauACtTIrP3PS2Wsn+uPYGHCH0C2
         /orB8AuQxoWZJojPbJmRyLPy4qGuuSSLJ0JByOiCZFtEy7Y3PGyEAAsf0VXMM82mFYpq
         eJtAC5eP3qE9RD1izzGBajLzwZmayYAkkEC8T9CeQGT61deA83VNC7UA6Dmlu+HrhpM0
         ikaxxavC2+VQGiTJDG7k0nyT/mNuWqapFHXARk9/KN1GOuCK9f37xbTUxAefTiWA6Yuq
         d3pSBP1Ty3klkUuqin2bPEbku/wAwo8GWLAE4xrUXyuFjHUwNnRQVSfBhEZCzikG9LSe
         +hxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702888425; x=1703493225;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w7msxpJgBBjQPtZZCsb1ltJW2M3TBsdRo5LCmhi6CvY=;
        b=Xa7U0ins2kjIQHL8XMrHY0QTbQbrgoX0dh5n8DNsA/v/MFBvz/hSJy2afmkwp8UXuF
         gmK6eVJCNBE40YEzO1okJgEeSJL5XUoL4RiH8F8nP7/3Fpu8KYkMlLQFk3p/GoLPx4Yy
         TzZ2Bw8NtI3bU6W76ZpoUvnkfA90rcY+eGHJ1wGgdwYFi94n5XXVwKJNDLvSmxavDT5j
         GsNSuuq/e7Ppo4Go9NK2N7+BAzLy+PW+G8ErNJbCuiGcFmtCyfs5LAfkXBkBWJRcvDD6
         JtXWBIb9DbqUKAu6Z8/+/MMfMN4Sc1CYfPZ/RyNy1TweHIn9KYXpgMzvNQFtrrqzqfS2
         zOzA==
X-Gm-Message-State: AOJu0Yy3658zJS6/BftRsk+RsepnnulVCasts6T9y4Z8sy8XY+v43+OI
	49lrTdDU2LqMVUDxkQtKPQ==
X-Google-Smtp-Source: AGHT+IFm8yEQkImXxTPVut9GyAoJTRoIcCxxJ3EpWccrE5MErNed3DvHHjfBUo7yChrPWTtgHg1JDQ==
X-Received: by 2002:ac2:4e82:0:b0:50e:2d04:fe42 with SMTP id o2-20020ac24e82000000b0050e2d04fe42mr408461lfr.241.1702888424842;
        Mon, 18 Dec 2023 00:33:44 -0800 (PST)
Received: from [192.168.1.148] (224.69.114.89.rev.vodafone.pt. [89.114.69.224])
        by smtp.googlemail.com with ESMTPSA id w15-20020adfec4f000000b003366cc543casm537184wrn.102.2023.12.18.00.33.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 00:33:44 -0800 (PST)
Message-ID: <80e69cc3-5ee2-48de-83a2-6e2b95f17121@gmail.com>
Date: Mon, 18 Dec 2023 08:33:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] rust: sync: update integer types in CondVar
Content-Language: en-GB
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231216-rb-new-condvar-methods-v2-0-b05ab61e6d5b@google.com>
 <20231216-rb-new-condvar-methods-v2-4-b05ab61e6d5b@google.com>
From: Tiago Lam <tiagolam@gmail.com>
In-Reply-To: <20231216-rb-new-condvar-methods-v2-4-b05ab61e6d5b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/12/2023 15:31, Alice Ryhl wrote:
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

Reviewed-by: Tiago Lam <tiagolam@gmail.com>

