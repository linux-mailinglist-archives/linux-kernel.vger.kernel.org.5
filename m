Return-Path: <linux-kernel+bounces-3161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE98C816811
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 731E2B21920
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A19125A5;
	Mon, 18 Dec 2023 08:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYVM1k3d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D9D11C91;
	Mon, 18 Dec 2023 08:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3365b5d6f0eso1354091f8f.3;
        Mon, 18 Dec 2023 00:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702888348; x=1703493148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KuTpLAn0ifEofUaY2LsWGW2GH2ZKQjCbSzshhn3wDKU=;
        b=FYVM1k3d2hJjkBfG5x7M5wn3YRQsFfGTNR1MsrpXZ564Kn3QSDJDOVtscs/EkTx+mO
         H1QNmvTpKHWyCuDsCF80c/cVILwr8Uer6oFoiBofrB5qYDuXGZE3QCsfPXJKl4xHr8tT
         19HObt8SJ9Y8SAvqOGNEiVD1qx1NE/RpwfKytrKmExGwN2+5Dz1FljQKNTdsQaQ2KaPJ
         Swi0SrZvQe/tbn5I7fto1r29JWNUk6v8sVLPUGeTVJaTjWEeWqPiAII8dW1x+bwGkBhW
         CMHSTknY5k8pCbUIoJZOD9HIhR0oPcokRqDfBUuDo/6kAuXP/eYRx2A/B41+WQ+JUrNh
         uIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702888348; x=1703493148;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KuTpLAn0ifEofUaY2LsWGW2GH2ZKQjCbSzshhn3wDKU=;
        b=g//Iln6W3kxxNcG9cMXG0+20QNP4BcJxPQC7BfVJQ+v31gHhoeMhgSVTqhW81jwgz6
         ctPYBzHnq+2fFzsj3Y4IPenZaa5nkFZRwnGMQkD0fLO+XF0Gvmi+6KQIlztac9eqCKJK
         /PD/4gJpGO/kOsdHWkEMzYuYkKCP4IMfBD6oP+0JmlbIwrMFOE3iQhzD+7UGc+inauAi
         07IpDeYtlyLIflRl4O4Y8dCjybAeyKBWyFS79UvQgpruHEEGfWv13YQbvWYnyEwqKyvJ
         koUbrrX7xRQoTiZR4bPjXVB/GVXJC41C9HyvqP1p4XsfpyyuSybSJCtLYH88NryQGldD
         /b2w==
X-Gm-Message-State: AOJu0YwHiSpcQ52We8vaDZv3E6ldBEVP13Km6rZGKEUWfZzMBgIMbn7M
	SIwQEYW0xd1qpJnawMDddw==
X-Google-Smtp-Source: AGHT+IGJII3EAp5gkjrxzN2VVZR6QqK4xTyTaFGGa/kWTPKIkCzL3PU3OSeweRhi25UX4SYR+QFQiw==
X-Received: by 2002:adf:e10f:0:b0:333:2e1c:9553 with SMTP id t15-20020adfe10f000000b003332e1c9553mr9291141wrz.32.1702888348338;
        Mon, 18 Dec 2023 00:32:28 -0800 (PST)
Received: from [192.168.1.148] (224.69.114.89.rev.vodafone.pt. [89.114.69.224])
        by smtp.googlemail.com with ESMTPSA id w15-20020adfec4f000000b003366cc543casm537184wrn.102.2023.12.18.00.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 00:32:28 -0800 (PST)
Message-ID: <b9a3193d-e020-4691-b8d9-4dce09fe2cd4@gmail.com>
Date: Mon, 18 Dec 2023 08:32:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] rust: time: add msecs to jiffies conversion
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
 <20231216-rb-new-condvar-methods-v2-2-b05ab61e6d5b@google.com>
From: Tiago Lam <tiagolam@gmail.com>
In-Reply-To: <20231216-rb-new-condvar-methods-v2-2-b05ab61e6d5b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/12/2023 15:31, Alice Ryhl wrote:
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

Reviewed-by: Tiago Lam <tiagolam@gmail.com>

