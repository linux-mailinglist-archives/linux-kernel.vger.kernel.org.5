Return-Path: <linux-kernel+bounces-3162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB76816812
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784C71F218F8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755CA1079A;
	Mon, 18 Dec 2023 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cp9gmzYV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17882101ED;
	Mon, 18 Dec 2023 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3365e85a4easo1328135f8f.1;
        Mon, 18 Dec 2023 00:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702888367; x=1703493167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rGsPDIwnCz36o6myxAQrm6KTXCyrXNRQ7FesRSicPsI=;
        b=Cp9gmzYVmwceR8TCZizm7U+Yufn1rjaz9VzxBkqwwe9rXKOmn75/uAwhe9xu9razK1
         93mG/3JBtuHQ75qfRBu5qUl+cstdGamWBKEz+0lXUzxRFodNoVhBgRatXZf02Uvf4zKJ
         rPi/bojnWfGtOBPGT6Z7GrkkxZABI5Y8mCGyNsoKYjpKipi7/b0dslWJwDTrzd3auSlQ
         TBXuwkdtwsBZnjO3XkpCBp+5GUI4fDYnn+0CS22Txl7z3iUfjwLFgFl100R+BSf8VppK
         aKZ5VoNwkl6FAknok7666SJawaxRv3PchuY+3o70j9uubCOi3e6c8AeJ9GNhJh6xlRIA
         XhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702888367; x=1703493167;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rGsPDIwnCz36o6myxAQrm6KTXCyrXNRQ7FesRSicPsI=;
        b=A3sNRtjPPxDKAI2ZqtWakhVO0x4opFqYWEF1PJLFxcyx6t6QnGXfdXrsfQjIEscu5r
         6KCKQOqNfk5zEPnnH1D1gNgza7PodygIpdy3Cc1kwZ6PlLaCJ5qVuy0eyj0ZqI8w4ZAi
         Z1xKBeWhHLghmoA519NSLgzRONXX2OMeXE3+wrRL7o5V+vpdhfsK8Bz3kYK1MceZckSf
         jEZSpdvg/X2s/FieVGMAXmDjZ9/Uxpot5K7tSTIey5PqhkVng3jOS76FeP8+zFcX7xo9
         6P3UlD4qGA3ylJQuJl8/+UuVFcBl5aJ6W8t17yc20Y8VFqv2hIJbi67lOvntb8q6f5+S
         d83Q==
X-Gm-Message-State: AOJu0YzWz+Wgbn8VsAzS7z0PdTEog5oUwBVEaph1sUz5ApAUSTikg2XG
	LBD9C9mz8qlooe+jbtGE5Q==
X-Google-Smtp-Source: AGHT+IFzV7gYXwsLChD9M5q1eEK3n5azu2LSJy9WT77samlg3/fA01GUY0cfwBV2HF+4eKagbmEsaQ==
X-Received: by 2002:adf:f052:0:b0:336:5bcd:7beb with SMTP id t18-20020adff052000000b003365bcd7bebmr2376777wro.17.1702888367258;
        Mon, 18 Dec 2023 00:32:47 -0800 (PST)
Received: from [192.168.1.148] (224.69.114.89.rev.vodafone.pt. [89.114.69.224])
        by smtp.googlemail.com with ESMTPSA id w15-20020adfec4f000000b003366cc543casm537184wrn.102.2023.12.18.00.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 00:32:46 -0800 (PST)
Message-ID: <8328468d-49a6-488c-a94b-61703b205a59@gmail.com>
Date: Mon, 18 Dec 2023 08:32:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] rust: sync: add `CondVar::wait_timeout`
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
 <20231216-rb-new-condvar-methods-v2-3-b05ab61e6d5b@google.com>
From: Tiago Lam <tiagolam@gmail.com>
In-Reply-To: <20231216-rb-new-condvar-methods-v2-3-b05ab61e6d5b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/12/2023 15:31, Alice Ryhl wrote:
> Sleep on a condition variable with a timeout.
> 
> This is used by Rust Binder for process freezing. There, we want to
> sleep until the freeze operation completes, but we want to be able to
> abort the process freezing if it doesn't complete within some timeout.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Tiago Lam <tiagolam@gmail.com>

