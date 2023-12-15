Return-Path: <linux-kernel+bounces-2212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A8A815990
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 14:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB968281810
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12B02D7A9;
	Sat, 16 Dec 2023 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVQ/C5/L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705D114005;
	Sat, 16 Dec 2023 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso1305161a12.3;
        Sat, 16 Dec 2023 05:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702734517; x=1703339317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cMdekASZxZHVFfSc7wnHzY7Tv4MkxPQPmvOEgSf0s3A=;
        b=eVQ/C5/L7F6aWeK9bkdZz1UcYVzMSLhEOHnu2Wn7lC6pTSljN6t2tkkFUBCG6QaH1r
         xnrKA/WiOi8NlD5ZVUZwcEf75U/UDaN8oLdZi+2TSWE05kNX6pmRRPPuPHASedCtG1qj
         JP2CZ3RDLVLK816pyoDszZapyxFEvPdepAAwX/ZdXJWKRHzaeYW8Jrsr3YAqhFNzJqDL
         WlvEqCcWZo6krcvmlFWUuN6IC2OnQvrwV9PktzZId4Eg9QyetlcLZmb/41dZEEtpCQb7
         3KyyZZixYgyrOUiSC1W8g9ATAugvFfGMoE14XTcYcmeqLMDC/KCXsIAbNBIgN7W5yjqF
         PBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702734517; x=1703339317;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cMdekASZxZHVFfSc7wnHzY7Tv4MkxPQPmvOEgSf0s3A=;
        b=lt2sLJjhxwbpc/8wZoc+Sls3K2W3ei1yxH4rVjK5MuAI6lvM7pH5Ue1b1HgV4d3z9D
         +WEHReFRiZhwxQJKgttm/Y4MlbYxuhuTrlo69vUFqHRBISu2WTpaqOKpN/wii/1JW6vs
         tZZmOg4ZLl1xNO/RME2OnYhnaymKnH82v99t2sCn+P6QOAsMqs3mGUpAfeYB/g5gdzbM
         hDpe6uNeCHmdQfGwxBwDyGqmPLXvViGmMlGJU8v3y77GiLVXc5SZbzpNM1ZJ13fxrXXW
         D3y0O46RGfhr0jXdMj9d1kPJ/a2/rVpp2dKr3Wn+EemIHyBAfIp7SGsLBkCfP7gjhBcI
         5SDw==
X-Gm-Message-State: AOJu0YwdG3BwerjMrRvNcJYSCtBzbMmuaflIbO8RDvIwn+/Vd5F5+oIM
	/OZEy7gDBcM1s+3N5c1y1SqotmBHzh8=
X-Google-Smtp-Source: AGHT+IGMRI0tGh2WrcuWUWqrhXsQO6lqjkNVpRGJgVO1U3NtRTPQ1rpt6nhXUonl7sYzoRdwErziMQ==
X-Received: by 2002:a05:6a20:54a9:b0:190:1c0:1c25 with SMTP id i41-20020a056a2054a900b0019001c01c25mr17316135pzk.91.1702734516764;
        Sat, 16 Dec 2023 05:48:36 -0800 (PST)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id u17-20020aa78491000000b006cb98a269f1sm15142081pfn.125.2023.12.16.05.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 05:48:36 -0800 (PST)
Message-ID: <2f92ca77-703b-403d-9dc9-b45d2d8d86a1@gmail.com>
Date: Fri, 15 Dec 2023 13:34:35 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: rust: remove `CC=clang` mentions
To: Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho
 <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, patches@lists.linux.dev,
 Jonathan Corbet <corbet@lwn.net>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-doc@vger.kernel.org, llvm@lists.linux.dev
References: <20231215124751.175191-1-ojeda@kernel.org>
Content-Language: en-US
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20231215124751.175191-1-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/15/23 09:47, Miguel Ojeda wrote:
> Nowadays all architectures except s390 recommend using `LLVM=1` instead of
> `CC=clang`, and since commit a3c6bfba4429 ("Documentation/llvm: refresh
> docs") the Kbuild LLVM documentation makes `LLVM=1` the way to go:
> 
>      We want to encourage the use of ``LLVM=1`` rather than just
>      ``CC=clang``. Make that suggestion "above the fold" and "front and
>      center" in our docs.
> 
> In particular, that commit removes the examples with `CC=clang`.
> 
> Thus do the same in the Rust Quick Start guide, i.e. remove the `CC=clang`
> mentions, especially since the architectures that have had their Rust
> support upstreamed (or soon to be upstreamed) are all `LLVM=1` ones
> anyway. And perhaps by the time Rust is supported for s390 (or new
> architectures), it may have moved to `LLVM=1` anyway. Otherwise,
> this can be added back if needed (or perhaps an extra link to
> Documentation/kbuild/llvm.rst).
> 
> This should also help avoiding potential confusion around `CC=clang` [1].
> 
> Link: https://lore.kernel.org/rust-for-linux/6df6e8e5-8d5b-4d3d-91b5-bc0e90c424ea@nvidia.com/ [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

