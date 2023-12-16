Return-Path: <linux-kernel+bounces-2280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 015F5815A79
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD13A1F23923
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8483172C;
	Sat, 16 Dec 2023 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMfxHyp8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACADC3159C;
	Sat, 16 Dec 2023 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3470496e2so14680315ad.1;
        Sat, 16 Dec 2023 08:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702744970; x=1703349770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TdAN122O3mTY/KDjnyrw58uVJWBDFD8M+bmKV4s8GdQ=;
        b=FMfxHyp8vjVYYiyIvzqBVTmigecuywHigMooBL96Rfqpx5/Ziah+O+E9X25mbUw8au
         kMH0rK/8CgVhn12DATzX69x4tLzRcfHiD6zMVlOhW8Bi16jnd3Lx/e9kPRGyNxVH9fN1
         TFz/AOL1hke1HbFFh2lkfl3YgGnWjGikVS+zwVHW52i2dfG8/KQ5lbpB3k2Zf8IxoHlK
         7FZ/ptZIIXWTrautwHsvq/JGEGrG6NmuZQ+AjjD0E1nbBJHbBogkL8ne/GuQGMoBNVXG
         drUfOAyyr0XPDMX3xG2XruQIKiV9s4yiaoTF4nvRU69t7LnXED675gpY8y5apMu0kduq
         /kGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702744970; x=1703349770;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TdAN122O3mTY/KDjnyrw58uVJWBDFD8M+bmKV4s8GdQ=;
        b=qOL9jTUG5EUyoQbX9mMY0pzvoGySur9hqeZQall0l5v4ZBg+OB4qOx43MhwzCLihjy
         vHQiqZy3ChPC7uMnMeBiIIBzV6Z8hYOrQ0eTW8Ql+/sdLIoW2z/27ObETOGSIT/uiVjt
         Uak9TXHpbNWIeZPwxA0NJTMvpPdWG0EwSXirlkaHbiaV51mowTRAwtjz3nnoB+G9lELJ
         EocKKQouG9vOpIlv8brWHz+JeVzi1qVM7BAWWAIcwnH5rXQWcVFzmlbKw51sEXJxXT0I
         MDauHnYZElbpGmKO90dVxWVIcAAzw/aHy0x5E4SKrv8BlYdklPB+q3mKIj8RGCbvL5dI
         zfMQ==
X-Gm-Message-State: AOJu0Ywy15/LiJMpZZmSYHjz13lg+CcUqSMT3YA/N1SmeOUgAzWuNCee
	u4+UOTf347UFGiLkc6qD63A=
X-Google-Smtp-Source: AGHT+IHw5AZGJ4W7fLE03D6X7gUCAT6XWA597afy6cot9Ktyq5DxqTIYf/VBAxiXfK3KYU+3QwYglw==
X-Received: by 2002:a17:902:da91:b0:1d0:ab2e:8e8e with SMTP id j17-20020a170902da9100b001d0ab2e8e8emr16082445plx.82.1702744970056;
        Sat, 16 Dec 2023 08:42:50 -0800 (PST)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id l4-20020a170903244400b001d060c61da5sm16103353pls.134.2023.12.16.08.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 08:42:49 -0800 (PST)
Message-ID: <22602f95-b18d-4956-a46d-5694e7e2a409@gmail.com>
Date: Sat, 16 Dec 2023 13:37:03 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] rust: sync: add `CondVar::wait_timeout`
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
 <20231216-rb-new-condvar-methods-v2-3-b05ab61e6d5b@google.com>
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20231216-rb-new-condvar-methods-v2-3-b05ab61e6d5b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/23 12:31, Alice Ryhl wrote:
> Sleep on a condition variable with a timeout.
> 
> This is used by Rust Binder for process freezing. There, we want to
> sleep until the freeze operation completes, but we want to be able to
> abort the process freezing if it doesn't complete within some timeout.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

