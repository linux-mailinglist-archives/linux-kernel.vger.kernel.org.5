Return-Path: <linux-kernel+bounces-3159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03DE81680D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551DD282F11
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5789E10941;
	Mon, 18 Dec 2023 08:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxHyc5Ig"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6ED1094C;
	Mon, 18 Dec 2023 08:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-336437ae847so2604041f8f.2;
        Mon, 18 Dec 2023 00:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702888322; x=1703493122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2R3RysZeELSrwaA1Xpv5JYjM2T+a8nYeDy+wQcqvhZU=;
        b=mxHyc5Ig1AvGKc9Q9flo692/YFPpXGdFRKYejnjHDROW2Q1YWjb06UzUhdxVy6B1/Q
         U6MoYk6yTX65Jmj0vBbO4sYENtMReZkf7RXUr2aFWOplGpzjSwEj8E/yQ2BwJXske1Qc
         HikiOajPgNEqEPaXYTmoptkK9TnFqe8NeIhoS/WbH8b8mD/GELuwWefIcrHjtnBf1YV/
         e9bb0Ch+zzmvO2Oc40k4RL8GwPkCjEUTqzWN1J/Gf6z0pNZph9MsgqosIX2a84bX3pxj
         3ntcr10/0IQF4igGPg72Hr4cA7FB/I6+VqFdCrCwm+XpEyAGG02WpZk7qDtPHuObgpzY
         j4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702888322; x=1703493122;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2R3RysZeELSrwaA1Xpv5JYjM2T+a8nYeDy+wQcqvhZU=;
        b=kn62EOE5deXWzKSUfCNoKstp893zzSOxZn/rhEHeASk6YGFEhZvnYHr0+XKLRi/4aJ
         b1jgCuKlJH/YYHszzioXtyVbJaP0MT2EbcwhPYCDUEnmZ9TYXGXyLqjabD1NIdk5o627
         Q0GQoP+O3GHoo0Alh+LL9+95Dh4RFM6XU7QNIGuC+QxUAkB+VQnsDwTo8ywbnzg/nTg2
         OfPkP1+9S+lOY5y96hiH3Rxm/elbarGHb94eoGSfMPSP3s031tgaFa7MGkpDXE1GOPhF
         HEuaUcWEI8xNf8SAnB9eIv0fWY+anYxtJFzbFU1SmDZ/Q4NRDXIOjhjxHGZDc79o0gdz
         lucQ==
X-Gm-Message-State: AOJu0YzvzvFCe0czVi+/U2ieI6TiN/4OCysp3bThZCiHQ2/km8bNNDfp
	9jDfcW2FjC+f7jEVQPFMqg==
X-Google-Smtp-Source: AGHT+IHKKhPPJJY38USoCVCcxvwSs9c0dtzo8svH14z8NfzO+gwgXo+Wt3ImnY+5yB9OgVK/TF3F6g==
X-Received: by 2002:adf:e10b:0:b0:333:4295:8f72 with SMTP id t11-20020adfe10b000000b0033342958f72mr9174867wrz.118.1702888322217;
        Mon, 18 Dec 2023 00:32:02 -0800 (PST)
Received: from [192.168.1.148] (224.69.114.89.rev.vodafone.pt. [89.114.69.224])
        by smtp.googlemail.com with ESMTPSA id w15-20020adfec4f000000b003366cc543casm537184wrn.102.2023.12.18.00.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 00:32:01 -0800 (PST)
Message-ID: <84f0fbc6-f50d-4eea-ac9e-4683c5d252ad@gmail.com>
Date: Mon, 18 Dec 2023 08:31:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] rust: sync: add `CondVar::notify_sync`
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
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Martin Rodriguez Reboredo <yakoyoku@gmail.com>
References: <20231216-rb-new-condvar-methods-v2-0-b05ab61e6d5b@google.com>
 <20231216-rb-new-condvar-methods-v2-1-b05ab61e6d5b@google.com>
From: Tiago Lam <tiagolam@gmail.com>
In-Reply-To: <20231216-rb-new-condvar-methods-v2-1-b05ab61e6d5b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/12/2023 15:31, Alice Ryhl wrote:
> Wake up another thread synchronously.
> 
> This method behaves like `notify_one`, except that it hints to the
> scheduler that the current thread is about to go to sleep, so it should
> schedule the target thread on the same CPU.
> 
> This is used by Rust Binder as a performance optimization. When sending
> a transaction to a different process, we usually know which thread will
> handle it, so we can schedule that thread for execution next on this
> CPU for better cache locality.
> 
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Tiago Lam <tiagolam@gmail.com>

