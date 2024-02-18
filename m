Return-Path: <linux-kernel+bounces-70437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3AE8597B7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 17:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7ED61F21398
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 16:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532876D1C6;
	Sun, 18 Feb 2024 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dulISQCg"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432FEFBEA;
	Sun, 18 Feb 2024 16:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708272713; cv=none; b=cHCwUvJIce/9YQ02GV+frJyxnnoHHWs2W3qSKj/yw5SGtwPtsLYjY7LJj0hTzhrbc+FFvJQyiw29nLc4MzqEQjCZPQxNsqnBVLSCBMQ6e1LUDZD3spw6N5lLLarZXJBvR3dLNgg/WTNpMivJkFh8oVnhxt+uOtZ5xdkOajGrd/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708272713; c=relaxed/simple;
	bh=O7gBdNUrHWtEdQ7Sb7xM0HZk+kbpmFEH/bA31/rebr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WKiZvKclk4XHZa8MDZQJryIzuVgy0pdFZWy5HStPJhefxh/oBpQYN65mSjZi/Sg9Kw67jfgexRJtYABucHqRf5hnlCULtfqYNOCmzqt6+gZnw9VVEo2dvXtFEbowX4uyVnJcZxNH9DIWAI5NhsG3ieH4b80c3thHtfhWa5iBl+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dulISQCg; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dba6b9b060so13988995ad.1;
        Sun, 18 Feb 2024 08:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708272711; x=1708877511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tW7EMHm+pV1IgZiBPcrF8p6ggsHIaTJdyvaAlRROm4M=;
        b=dulISQCgLoSdL6sa73gh1QlIRYFGkFSSWA7p+5aVYahFLYOly4DIp+dvHXxo/6zcsA
         Xy6a5qmw+KCPOsqNxcza/ngVw7KfRuB6qzMBO7Ky+Gf86nNaFc4lrLzpdBwKuyopeuhe
         vFN/+Jq4xhXRPPex42r/Z8u0n+4jpy83XGJTD5GX1psBm+6ibc4lnhRH/8WRp6R2Zvjt
         WMpUW9O6Ei2LZHu60p1L5ZuaQ6Cjn7h2ZW2C+KNlysm1JMMm3dOBuXmgtpy3ICjnsaba
         6fYbX/cBW1tUmbALrPfpgbA/LtBdWOpXH1CKVdXkR2WGdjK9LbXZYOjpc+4tE7PRoF6F
         7ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708272711; x=1708877511;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tW7EMHm+pV1IgZiBPcrF8p6ggsHIaTJdyvaAlRROm4M=;
        b=CszjxikYro7V0+5Fse90lQqsHSfMmFJsB7LSQcqS0T2ZpwdcvHXNSG4TUKeYMhpUEH
         mgXPb+U+2NsjAexlR/Du53Vnbx1RaFVoFWJtOOPYbzVPRPqAZfUxQr7KtJhuhPVJ0XUo
         MLT9QGyA14PEVsw+ILZCT9v2OyQdcrdoiFCtONMao6z+lf1mgky+cCmGKpDgT6HhZLWZ
         sDypJbi9NUa2QCjmt98Spuczdje7k5bNkK0N5zkIqU4fyQnE2HsDtuJ5XDK4r6qdojvv
         MnjAGYC9ug4HwUDLS2ATPMjH0ukCxADx774OHgXfUjXD9tRCfh2F25mvSLkvOtrBr2ew
         Ertg==
X-Forwarded-Encrypted: i=1; AJvYcCWMQ+lUEXmVIDnFVrgrOKfuhIN8FTAMCnULneCb4t44v8+70M+gIKSqLmIUzX8ifhjm7IuVemcJCFExAyVb2zgzMKNdyIIrECEwje6MsGSvLsvqUUXbfKlguWjr5key77dPnaJaaqs/wTIOE/dJkrqnoe1rZwbvMOgeUZih58HISmJRxtBU54z5Ess=
X-Gm-Message-State: AOJu0YyMpafNOJGM0uzs7YksTKtBKlSqrj5LIgE1+5aQfisH6tVgMcEh
	uNPN25q2d5aLXisfuG88MbC2QKK7UrOLONCzKFA5+0vULBttIyzaUgSI7zrd
X-Google-Smtp-Source: AGHT+IGvUh5Wg21hYx2cRJD+JeqLvS78+7d49olJmucsFPibZTyi/QhEO2MJ6RB3UaIBIpLdjHH/zw==
X-Received: by 2002:a17:903:11c5:b0:1db:8d0a:cfa9 with SMTP id q5-20020a17090311c500b001db8d0acfa9mr13621769plh.6.1708272711402;
        Sun, 18 Feb 2024 08:11:51 -0800 (PST)
Received: from [192.168.54.105] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902d50f00b001db4b3769f6sm2813762plg.280.2024.02.18.08.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 08:11:50 -0800 (PST)
Message-ID: <e3562896-2d4f-42cd-be7f-6c7fb7fd08a1@gmail.com>
Date: Sun, 18 Feb 2024 13:11:47 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/2] rust: crates in other kernel directories
Content-Language: en-US
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20231104211213.225891-1-yakoyoku@gmail.com>
 <CAK7LNAT4zKWn6+scn5wbaN2_x4wh4EYSuNxnaoQK1FfJK45MOw@mail.gmail.com>
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <CAK7LNAT4zKWn6+scn5wbaN2_x4wh4EYSuNxnaoQK1FfJK45MOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/23 11:13, Masahiro Yamada wrote:
> [...]
> 
> I will not provide a line-by-line review.
> 
> 
> Just one thing I'd like to point out.
> 
> You assume the library (drivers/usb/core/*)
> is built before its consumers (samples/rust/*).
> 
> If Kbuild ends up with building lib consumers first,
> it will be a build error.
> 
> 
> 
> Kbuild descends into multiple directories in parallel building.
> 
> You cannot predict which directory is built first.
> 
> [...]

Thinking with what you've said the same thing might apply to any Rust
written code that depends on crates under the `rust` dir. Adding
Make dependencies to object code made from `.rs` will be required if so,
assuming that Kbuild is intelligent enough to build the crates first.

