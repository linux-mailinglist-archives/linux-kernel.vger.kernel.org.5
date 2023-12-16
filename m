Return-Path: <linux-kernel+bounces-2214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337618159A8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 14:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63472857A1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD8A2D7A9;
	Sat, 16 Dec 2023 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFaL9Tny"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD1F288AE;
	Sat, 16 Dec 2023 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so1317496a12.1;
        Sat, 16 Dec 2023 05:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702734991; x=1703339791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d+QKSwtAIEuecoULCNbymDGc4MmnFHIZxwHr8KNV/bw=;
        b=SFaL9TnyUyG4IPwikOl6FCuDYqfUUDEMZbTkywhOxY98ok//mmxQzO0aWgeq6ivGRh
         4qLFhb9BMYalGWPXZLyHrndyKSpHqDJes9ltiurFFPBg5AIxdLc+3otsrRFJfpXY2ApT
         OJ/6ZySx/9biC+X19s/yMmuDlZnvF4s/PHL471iXG+kdLCiV3lFgKox2xKAHJp1Gonxo
         DdsA6YaKGujCBlCOugMnhlhpIIHL0egkYx/mQa3KdtnXXpQbmrNTFXWmSDGkz3c93vRu
         5RWKlg6CVbUNVo9t9Cc6EyXRt0tjOZCRa444bFpEeztVKMGZbAEvZaVJDk4Gnv3FazVs
         8ItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702734991; x=1703339791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d+QKSwtAIEuecoULCNbymDGc4MmnFHIZxwHr8KNV/bw=;
        b=I3XM6yYlfo6FiaBe9nJGuZVGDnoBhCETb499pwxYrgeTt1c0M6DDMCo/WbWiRIUJIx
         xo5vnrLfB5R0TYmQ701Dk8py7gi+f4WO/7SUaXmQS2QG3m+FfNUWZPoZ4vZAcSiqVtur
         UUEqtt9sNRCUrMH16jSwdXlaKiu7a2CDRQcaXgGb3Fec5UUefBDj768I1xDRzBUH3E7p
         mng4jXXEouLvzbZFHwBhQBBAe7yEIMrqsryYlxEiubHRv/mwLHiUdE5HOJThJEfkM0gc
         phaznnMOhaqznAgbPwMD1Pxxf9EOjad9JJORyBsxSWrnEGpaBBqjXP5Od6RpjvjGF/Ja
         QWUg==
X-Gm-Message-State: AOJu0YwTMn7/6qFll7Y86Bm5298jdHxKPeto+tzGsbT8IXLTzU0TXNo2
	D2fUdTjgThLUouESsqKoRhE=
X-Google-Smtp-Source: AGHT+IEvyd9u/4I3Ib/Kj8Ccrn9JnHOTcgSpSuZTPny6sk8cJ2XeXf+zI8WOCSUg/vamTGy38bBXqw==
X-Received: by 2002:a05:6a20:54a9:b0:190:1c0:1c25 with SMTP id i41-20020a056a2054a900b0019001c01c25mr17329292pzk.91.1702734991213;
        Sat, 16 Dec 2023 05:56:31 -0800 (PST)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id kb1-20020a17090ae7c100b00286e9bec1efsm18039549pjb.33.2023.12.16.05.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 05:56:30 -0800 (PST)
Message-ID: <08b3f964-a66e-483d-81dd-4f6f8f61bdbd@gmail.com>
Date: Sat, 16 Dec 2023 10:56:25 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: support `srctree`-relative links
Content-Language: en-US
To: Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho
 <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, patches@lists.linux.dev,
 FUJITA Tomonori <fujita.tomonori@gmail.com>
References: <20231215235428.243211-1-ojeda@kernel.org>
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20231215235428.243211-1-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/15/23 20:54, Miguel Ojeda wrote:
> Some of our links use relative paths in order to point to files in the
> source tree, e.g.:
> 
>      //! C header: [`include/linux/printk.h`](../../../../include/linux/printk.h)
>      /// [`struct mutex`]: ../../../../include/linux/mutex.h
> 
> These are problematic because they are hard to maintain and do not support
> `O=` builds.
> 
> Instead, provide support for `srctree`-relative links, e.g.:
> 
>      //! C header: [`include/linux/printk.h`](srctree/include/linux/printk.h)
>      /// [`struct mutex`]: srctree/include/linux/mutex.h
> 
> The links are fixed after `rustdoc` generation to be based on the absolute
> path to the source tree.
> 
> Essentially, this is the automatic version of Tomonori's fix [1],
> suggested by Gary [2].
> 
> Suggested-by: Gary Guo <gary@garyguo.net>
> Reported-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Closes: https://lore.kernel.org/r/20231026.204058.2167744626131849993.fujita.tomonori@gmail.com [1]
> Fixes: 48fadf440075 ("docs: Move rustdoc output, cross-reference it")
> Link: https://lore.kernel.org/rust-for-linux/20231026154525.6d14b495@eugeo/ [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>   Documentation/rust/coding-guidelines.rst | 13 +++++++++++++
>   rust/Makefile                            |  3 ++-
>   rust/kernel/error.rs                     |  2 +-
>   rust/kernel/ioctl.rs                     |  2 +-
>   rust/kernel/kunit.rs                     |  2 +-
>   rust/kernel/print.rs                     |  8 ++++----
>   rust/kernel/sync/condvar.rs              |  2 +-
>   rust/kernel/sync/lock/mutex.rs           |  2 +-
>   rust/kernel/sync/lock/spinlock.rs        |  2 +-
>   rust/kernel/task.rs                      |  2 +-
>   rust/kernel/workqueue.rs                 |  2 +-
>   rust/macros/lib.rs                       |  2 +-
>   12 files changed, 28 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/rust/coding-guidelines.rst b/Documentation/rust/coding-guidelines.rst
> index aa8ed082613e..05542840b16c 100644
> [...]
> diff --git a/rust/Makefile b/rust/Makefile
> index 543b37f6c77f..73ea24117f07 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -98,7 +98,8 @@ rustdoc: rustdoc-core rustdoc-macros rustdoc-compiler_builtins \
>   	$(Q)find $(rustdoc_output) -name '*.html' -type f -print0 | xargs -0 sed -Ei \
>   		-e 's:rust-logo-[0-9a-f]+\.svg:logo.svg:g' \
>   		-e 's:favicon-[0-9a-f]+\.svg:logo.svg:g' \
> -		-e 's:<link rel="alternate icon" type="image/png" href="[/.]+/static\.files/favicon-(16x16|32x32)-[0-9a-f]+\.png">::g'
> +		-e 's:<link rel="alternate icon" type="image/png" href="[/.]+/static\.files/favicon-(16x16|32x32)-[0-9a-f]+\.png">::g' \
> +		-e 's:<a href="srctree/([^"]+)">:<a href="$(abs_srctree)/\1">:g'

Another way would be to not put `srctree` in the link and add
`abs_srctree` here to directories that are in `srctree`. But that might
be too wonky to rely on so this will be the way to go.

>   	$(Q)for f in $(rustdoc_output)/static.files/rustdoc-*.css; do \
>   		echo ".logo-container > img { object-fit: contain; }" >> $$f; done
>   
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

