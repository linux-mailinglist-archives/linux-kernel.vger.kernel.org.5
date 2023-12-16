Return-Path: <linux-kernel+bounces-2279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A66B0815A78
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBD521C21774
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BE730D17;
	Sat, 16 Dec 2023 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkY9C760"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A9730CE1;
	Sat, 16 Dec 2023 16:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d3a64698b3so1429765ad.0;
        Sat, 16 Dec 2023 08:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702744965; x=1703349765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lgmlK8B4By1djxX90jfCzwJAoHfHoZPd7Qj1e2z37Yo=;
        b=QkY9C760plCw81HSyHzTfc6tvp+zE2jIvFA3gWk7Z4JUOM1/C7vW7kO/Aw5SCY3cMf
         dKvXijomENdmggRktZqQXsxansKIhd7jnZgWHadtRLxNbG0SddT44roNTvow/E9JDzkM
         842euNbpRZm91YCEw/ZdEysfewux26bWsZF+bVRyhacEI0Dm5g/lB+X0HfLveNlKWo40
         Qdd6DkhHK/cq37fXZZf6ute0sO+gjQVsc2De5Uwsev/RPy2qPSs3xrFZpfbAozRBf7If
         WI65act7k1jUEVefgVafyzualzD1dfh49SFt6RgMElwqnL5LAiNKDm/6J8O3+J2lHkQu
         qOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702744965; x=1703349765;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lgmlK8B4By1djxX90jfCzwJAoHfHoZPd7Qj1e2z37Yo=;
        b=lIemZYOgSc8CHthqxT6GdT+JzpPFhH6fLGR2EHlfH7iIoGU0HOBdy7FpPSM0ptaLum
         7lCevCDG7iFiif0WWtn0fnLJn7ftc7PggPJdUk1Jy0Ip60SO+RyBinCp+usbnNhdG/ZR
         NvQKcSE8sMwZb0OCsHoWhxxhxC3OKKZnYp5mnKdBmNEctx9KzTT44D1m4iDZ4c93KZRa
         9+49tZM5J1jQXszsK5f/SyjNhg7f6KEDuWkWo06FkOoqSyCUMjXtKv+uDe68zr0Oq//V
         C3s+Cw5wOSZOYktDjYSHwyRkt9d+hi9N9vHHEfw6qEUiTzRrVBCx0XoTKLcXQodFKl3S
         7JRA==
X-Gm-Message-State: AOJu0Yz+QJ+REFDlbWLMyWdr6OQJayaca6SYq5mLM3D3tEXfHmmAkPsT
	O/fopSWsv0hD2xJmw3T9DRQ=
X-Google-Smtp-Source: AGHT+IFSHiqI/wXH4RAqX4wMR10QdJ2L0d6krRJ6pNEK5SKJ9gbT/T9NtVT5GsUfwyx4TDTZ94I5oA==
X-Received: by 2002:a17:903:26c2:b0:1d0:6ffd:e2e0 with SMTP id jg2-20020a17090326c200b001d06ffde2e0mr12936039plb.122.1702744964762;
        Sat, 16 Dec 2023 08:42:44 -0800 (PST)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id l4-20020a170903244400b001d060c61da5sm16103353pls.134.2023.12.16.08.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 08:42:44 -0800 (PST)
Message-ID: <10c99be0-da84-4961-b1fb-6e09cbf7b829@gmail.com>
Date: Sat, 16 Dec 2023 13:30:45 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] rust: time: add msecs to jiffies conversion
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
 <20231216-rb-new-condvar-methods-v2-2-b05ab61e6d5b@google.com>
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20231216-rb-new-condvar-methods-v2-2-b05ab61e6d5b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/23 12:31, Alice Ryhl wrote:
> Defines type aliases and conversions for msecs and jiffies.
> 
> This is used by Rust Binder for process freezing. There, we want to
> sleep until the freeze operation completes, but we want to be able to
> abort the process freezing if it doesn't complete within some timeout.
> The freeze timeout is supplied in msecs.
> 
> Note that we need to convert to jiffies in Binder. It is not enough to
> introduce a variant of `CondVar::wait_timeout` that takes the timeout in
> msecs because we need to be able to restart the sleep with the remaining
> sleep duration if it is interrupted, and if the API takes msecs rather
> than jiffies, then that would require a conversion roundtrip jiffies->
> msecs->jiffies that is best avoided.
> 
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

