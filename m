Return-Path: <linux-kernel+bounces-16776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50208824397
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFD7AB25C11
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51CF24205;
	Thu,  4 Jan 2024 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSQ9j7ug"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AE2241F5;
	Thu,  4 Jan 2024 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6dc02ab3cc9so334249a34.3;
        Thu, 04 Jan 2024 06:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704377980; x=1704982780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YyXkGaIn4n8uR5zY2tnEwMlymDvJhftWg9/2ZNakfUM=;
        b=lSQ9j7ugW2q4+YomZQK0Nm/vDby01tvZ6YeOQO869+C6fGdQP/Dm9QlN0iZAoRwvBO
         KqXhdVMAYoELxMB3uuXQDj9xDZyU89jFbxO29DjR8op0dRvMQS0E+NUee+4fjx1ZPx2H
         mhS6TXRvrWW9Z9K/Qh4DeWOTz4+Oouf8JEqhdG7puOG0FLsi59XBLL1yEyCyiJrmwvWT
         SBTlRCFbybjiQmbDdZt8wL8WdXVo2hBuRkQIc/cweKEIByFEEMrI7//ImwRzhRWY7wuB
         dezpuMqXwwvNUXFdiV/dJET+k0hePSkgRy3cSDvG/H+A3B70yPNbxuENLEpvGKD5sLVE
         gZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704377980; x=1704982780;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YyXkGaIn4n8uR5zY2tnEwMlymDvJhftWg9/2ZNakfUM=;
        b=Hz2HNEoIfIGRKrNZXmAkRcT7K5HXCX9WJL/uZCAtohzIqtd3Cw+GQXN+fwMaL+hvqM
         sauqO7pHZk7KL3DaPMEKuASRFoyhtYXRZlFM1/wQPYD5c8FRKcQxxeWqgz3ocO2hfrrX
         uxdpsUSt23E8jmzFBhlOdsftLUS5N8p+b4WyGy8uiYoNrcAad3vW6MLOtdp7J9ZLvDFl
         ZtXworSu7LH/38ResD7UQNl4l4yA9nXJa1a3ZiE5VxuFPhMV5RvMtb37IoH9trbGJYRo
         aaN48x1i9xXcZceRfZPnJVuwNHQvncEccwu9UOFiV2vwdM4wdP0lIM1bS4+lVSjJmc9u
         wUcQ==
X-Gm-Message-State: AOJu0YwX4n3vfe1OGnhOF5YUzAtv3RiJI+l+MFE6Z4iegMFzdIb9q0Ki
	T+qekMNmaXxLrIE/4PMNPFg=
X-Google-Smtp-Source: AGHT+IEUMB6l0hlcqSyjPruBcShBmtmZRMFRfpq9EoSjrKDRreVRDYhnqFA0qsXRaXez6Dd9/jEhEA==
X-Received: by 2002:a05:6358:2826:b0:175:4915:ebf5 with SMTP id k38-20020a056358282600b001754915ebf5mr667732rwb.43.1704377979784;
        Thu, 04 Jan 2024 06:19:39 -0800 (PST)
Received: from [192.168.54.105] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78e59000000b006d945660076sm24634123pfr.59.2024.01.04.06.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 06:19:39 -0800 (PST)
Message-ID: <3d6d8098-f303-4767-9ba2-e7a80433a4c2@gmail.com>
Date: Thu, 4 Jan 2024 11:19:34 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] rust: sync: update integer types in CondVar
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
References: <20240104-rb-new-condvar-methods-v3-0-70b514fcbe52@google.com>
 <20240104-rb-new-condvar-methods-v3-4-70b514fcbe52@google.com>
Content-Language: en-US
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20240104-rb-new-condvar-methods-v3-4-70b514fcbe52@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/4/24 11:02, Alice Ryhl wrote:
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
> Reviewed-by: Tiago Lam <tiagolam@gmail.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

