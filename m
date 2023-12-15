Return-Path: <linux-kernel+bounces-804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E340A81467F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0CAB283537
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED9624A0A;
	Fri, 15 Dec 2023 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1t+f9oY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFBE1C292;
	Fri, 15 Dec 2023 11:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3364a1451c6so273741f8f.3;
        Fri, 15 Dec 2023 03:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702638845; x=1703243645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k+yoIAvPDl135lIcXlo6qqmeUnqlKdg0n91rabpsyIE=;
        b=k1t+f9oYRpNxF7LvgN/P8g33Etk+KRRCZKSD8uBIOqpibpLUFzDkYtHI8pitLV2JNL
         kgg6HFBLZ2rPbi023CR9qMRbqgcptzRd0qa2A7N9ii0FheZQNQAAguQWV188XvTx9tci
         DEWtAWMxfz/CYB9gMj/dYYaTc7pZqjowA8MK7fUWnTMc9qW/wrrIaY0f3sKsilJK2uGQ
         RXITRNgw3rOrKyZLaoZQlbkKeB7uvkt0PUI/gS9xUPBYBSw4T9lBzXK4uF6EJj3bcMPl
         D/BpEqhm2WT1Rijw483cqqcjeEd8MEDy3C8divtzJQth4I2yvu8wZ+os6jhVSNUgyxLW
         ImFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702638845; x=1703243645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+yoIAvPDl135lIcXlo6qqmeUnqlKdg0n91rabpsyIE=;
        b=l597KNjbRXCxEJRdZeGUG3W9AjCWNk6OWdD6MQ538E7Jw3IsEtCSaDd7ybUJ+MxLUB
         03tWJkV66XH/18qW86TWQKxItlVQLdGbV6XYQ9/yOI0+PQkmWyYw6+8buy1iirv/Tfy8
         KnId5cuw312BBpou+ciD7bSERYEDWQvgHbcmC/ckXIoT0vntTx0xCeM5IxabMtSnwpWb
         C/MD1zFc4BGlHQ/brxXy6evDFrZpftUMW4daxZELK+Cqq8SLlGqguLUfYoJPMLaPdmv2
         zV7v7QOYZFAW+JDy5NUTiuPp1vhNme4J8Ib4KO5DJpzaCqNtyA5kHZZWtTYl3kHn2eUc
         AlFA==
X-Gm-Message-State: AOJu0YzNhQPLeBKbN8tC6PolQ3nYCpxo3T3Jbn1HMD3RjZDTKCg4TNcI
	xzsUejgQmT/Kjl49VTcrfA==
X-Google-Smtp-Source: AGHT+IE/nxncmYRzZ5pQAF1zfOXt47/6t2/dxgcvEOpjZB2yKfMjTzIdLSaOyRKLLS9i9VSekPfbnQ==
X-Received: by 2002:a5d:6daa:0:b0:336:4aae:811f with SMTP id u10-20020a5d6daa000000b003364aae811fmr1781196wrs.118.1702638844070;
        Fri, 15 Dec 2023 03:14:04 -0800 (PST)
Received: from [192.168.1.148] (224.69.114.89.rev.vodafone.pt. [89.114.69.224])
        by smtp.googlemail.com with ESMTPSA id dd14-20020a0560001e8e00b003364277e714sm5909747wrb.89.2023.12.15.03.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 03:14:03 -0800 (PST)
Message-ID: <a2aca039-7360-476e-a1b1-e950698cd26b@gmail.com>
Date: Fri, 15 Dec 2023 11:14:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] docs: rust: Clarify that 'rustup override' applies to
 build directory
Content-Language: en-GB
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <e2b943eca92abebbf035447b3569f09a7176c770.1702366951.git.viresh.kumar@linaro.org>
 <1c03eb18-a6ac-45c8-8fea-46097bb4e132@gmail.com>
 <CANiq72=mvca8PXoxwzSao+QFbAHDCecSKCDtV+ffd+YgZNFaww@mail.gmail.com>
 <20231215064823.ltm55fk4zclsuuwq@vireshk-i7>
From: Tiago Lam <tiagolam@gmail.com>
In-Reply-To: <20231215064823.ltm55fk4zclsuuwq@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/12/2023 06:48, Viresh Kumar wrote:
> On 14-12-23, 18:22, Miguel Ojeda wrote:
>> Something like v1 but a bit simpler, e.g. keeping things as they are,
>> but with just a sentence after the command like "If you are building
>> the kernel with `O=`, i.e. specifying an output directory, then you
>> should append `--path <builddir>`." could work.
>>
>> Or we could just provide a `rustupoverride` Make target to do this for
>> us [1], since we have all the information needed and would be
>> copy-pasteable by everybody. I can send it as a non-mangled patch and
>> then Viresh can redo this one on top using it.
> 
> How about this ?
> 
> diff --git a/Documentation/rust/quick-start.rst b/Documentation/rust/quick-start.rst
> index f382914f4191..367b06f3edc2 100644
> --- a/Documentation/rust/quick-start.rst
> +++ b/Documentation/rust/quick-start.rst
> @@ -39,8 +39,17 @@ If ``rustup`` is being used, enter the checked out source code directory
>          rustup override set $(scripts/min-tool-version.sh rustc)
> 
>   This will configure your working directory to use the correct version of
> -``rustc`` without affecting your default toolchain. If you are not using
> -``rustup``, fetch a standalone installer from:
> +``rustc`` without affecting your default toolchain.
> +
> +If you are building the kernel with `O=`, i.e. specifying an output
> +directory, then you should append `--path <builddir>` to the above
> +command.
> +

I think we can drop the reference to the `--path <buildir>` to avoid 
giving too much information to the users following the guide. It doesn't 
seem to bring anything given users should now always go through `make 
rustupoverride`.

> +Alternatively, you can use the ``rustupoverride`` Make target::
> +
> +       make LLVM=1 O=<builddir> rustupoverride
> +

But if I understood this correctly, the point here is that with the new 
target we can now abstract both cases behind the `make rustupoverride` 
target - i.e. we don't need to provide alternatives. So, maybe something 
like the following is clearer:

	If ``rustup`` is being used, enter the checked out source code 
directory, or your build directory (if you're using the `O=` option to 
build the kernel), and run::

         	make LLVM=1 rustupoverride

	This will configure your current directory to use the correct version 
of ``rustc`` without affecting your default toolchain.

	If you are not using ``rustup``, fetch a standalone installer from:
      	 
https://forge.rust-lang.org/infra/other-installation-methods.html#standalone

Tiago.

