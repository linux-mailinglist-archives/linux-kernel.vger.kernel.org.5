Return-Path: <linux-kernel+bounces-62164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF0A851C84
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAAC0281CD7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33E73FB29;
	Mon, 12 Feb 2024 18:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZExALOD5"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87123A8C5;
	Mon, 12 Feb 2024 18:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707761510; cv=none; b=uYdpC6fQX/h/132hTOdi/lPqFpOMxLK234K5JA+uSgaTAkOiYGg5ubIae2jcRb41lLnUG4sauhdemCLNcvKS+VJUtYv/U74UD52WGCfjzle+juSRwcsa+JB6K+2zMBZTLaRcnbJMzUeC8f8QQR/he42y52hFkqw6yebSMWnVVMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707761510; c=relaxed/simple;
	bh=AF1d0fd4AxNFZk9w0ViOPCU56o5bwEO45KnjZB6ogNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N5fYiYKaC7CbsWHE0WBWqyKR32k2PTx3iYp9xX4h8OhEgTH5RHooQNMLv87/pP079p+p9WvPtV2tlF1DjVH7FwDzIuwrqL5OwRQGH4Ssa2bPSv7W08658147TL5LKLZ8mtZ04jvJ561SsMKfUGjV7hJDyyfsArLWPVnZGGSc55A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZExALOD5; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e0ee8e9921so107447b3a.3;
        Mon, 12 Feb 2024 10:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707761508; x=1708366308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0WioqbTZKq0P+lyta+EQBea/PSsBEYwVMDVbmzi1DgA=;
        b=ZExALOD57Dc56OfURtp+0yAsKLNOK+yQF3YiWC5Wjslsdn1SFu2XtVtpLb4WpxGX7c
         Sf3gqsw/58qFtLoJqEv/vGZZw5uuJVP26SooYyoCFl7xAWJLa2yIX9I+Lvl92xQeIWHV
         TXGNx7ODbnHFSRkOMv2ufqmYiUa1ZMa2uXsANd8IOK/ulb70o4iMeR6P5jEfupa6GCuw
         wcaRkJsX+DCYNig7k3CL65oHl8SDv3Awcz/J+2G1RH6CWwajHWSPM6Bk26gGd2PtzcfL
         NEI/SVUXLOWKYtHPqXcndsNeFA/EHgNIzTBBhNpWMB8XwjkSvh50ZdZ4LPSLGBCH3Dhs
         3Oxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707761508; x=1708366308;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0WioqbTZKq0P+lyta+EQBea/PSsBEYwVMDVbmzi1DgA=;
        b=qH20biVKCzdVZYfNRVFfiRTW8OJIO8GgAOfS4COHkrGfMwsN7BSPGCH/OYhmmEJulC
         12CgTTt7W3OAqSIMAUYP9cAFU7ErGKr0iMXpJlCq01Fw1r8cDE20Vzwm58iqeE5LjP1g
         UiBEevf6UuP4hzPvsi0Oo8mL4XtwuoaknqNBR5OD2y7p3ZY/FqVbiGjptc5+XacZrylf
         kzE0Up0arKzUTKcoJQyNJvE2HHfY+kHb/d1k28TKbNEnZZ36TujKZ4tSKJKZflRLsOJA
         iT7wdq/2D00VDlEpPOVwHEjDDTeaqPU4F1e9KjtnMqmLHLoDUMPRDuYJcnW4YjuD66Vj
         Cwlw==
X-Gm-Message-State: AOJu0YwsuTYZxa+TjCWJmk0wnY9+tTswcc5Q39mjDCaNLlsHSJhaSrNK
	nsfvMB2bD5g0I0fRIYPu/6JqkR8B7SQoy1ESeftgyWsqfEeTKZq6
X-Google-Smtp-Source: AGHT+IGyJf7jH/y0babjrV0MZaAcDBC9ftQRDowzPQylcRGUVugNChhGwD+7Yy8WGFjbxFeD1ag7kw==
X-Received: by 2002:a05:6a21:1394:b0:19c:9f1b:1d8d with SMTP id oa20-20020a056a21139400b0019c9f1b1d8dmr5576803pzb.12.1707761507792;
        Mon, 12 Feb 2024 10:11:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWVmGRxsdj8Y079ZpV3o4NLGHPdhcQA2bxDRk3VfARoc5y1piXpHU68JJhwXAkraD08O7nXuBbCPeRIkLMmRBICsot5LXzuNpBKa7lsL7G3ZoH6t0LcyVaX0LSielyt7tFA6+PrUZevhCHIWMQsoTpJyI3PcrNxE3Lmkf8B/5zHwyiUr2jCkR6QW+/yqobGmBure+JasCZwj8OaBtNZaw4sWA5ffLxrO59vW4ijTZDQOFN8k9x3ggb3MUytIkSWnUAVJ3bJZ2Qt4CHcbncO5GFIGwDI3Em5biy+JJ9ulBbpBGKSvzCz5lj3Zawsk+9kIP/WPbzBUGc72jXGGCrq5/fEWfMwkCA8ZxMmHZH+nP5piBljacMgRfyIH1r3dBYXrReFY1U9ph2WBEIUgoukPsL0BkdvS/4V30ZFPj89ZgG3EGQ+Hl7EqyCh/pSQmq8J6i/u/JXlRbstXeo5+D5qm1Qjn2He7d7KFeY5d1i3cbTQGtjHrUX/DSvGXHhYkjmAhv1o+6RubwclGb1w7QlUnfTG754mkMXbQEv3AU+1fyZfXUTDWmSyaaoVSHxRb49lXj8o5U7o2HrSaLMgGicebPl9ZTue15C4HvPHdgnhuW2vfapCbAqkVP/LiFuhi39nKl5GnfZXsb2ctgeWs1Vgk+v+s0Nfut2C8A+bzMIyIkDDh+4oJeahw5O6jrsyiHfxlhPnseGjVWEpsdYxdkqCZg==
Received: from [192.168.54.105] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id t187-20020a6281c4000000b006d99f930607sm6287472pfd.140.2024.02.12.10.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 10:11:47 -0800 (PST)
Message-ID: <a5f7bf1e-0846-476d-8d21-b816fd3916ca@gmail.com>
Date: Mon, 12 Feb 2024 15:11:41 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] rust: add abstraction for `struct page`
Content-Language: en-US
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Kees Cook
 <keescook@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
 Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas
 <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>
References: <20240208-alice-mm-v2-0-d821250204a6@google.com>
 <20240208-alice-mm-v2-4-d821250204a6@google.com>
 <d35a656b-b802-4f1e-90d6-7320d61ed818@gmail.com>
 <CAH5fLghM2thHeQifehUDT1b64okVn3sh6Eg_oPxqoK2zU-EJGw@mail.gmail.com>
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <CAH5fLghM2thHeQifehUDT1b64okVn3sh6Eg_oPxqoK2zU-EJGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/12/24 06:36, Alice Ryhl wrote:
> On Sat, Feb 10, 2024 at 5:23 AM Martin Rodriguez Reboredo
> <yakoyoku@gmail.com> wrote:
>>
>> On 2/8/24 12:47, Alice Ryhl wrote:
>>> [...]
>>> +    /// Maps the page and reads from it into the given buffer.
>>> +    ///
>>> +    /// This method will perform bounds checks on the page offset. If `offset ..
>>> +    /// offset+len` goes outside ot the page, then this call returns `EINVAL`.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// * Callers must ensure that `dst` is valid for writing `len` bytes.
>>> +    /// * Callers must ensure that this call does not race with a write to the
>>> +    ///   same page that overlaps with this read.
>>
>> This safety section says that a call mustn't race with a page that
>> overlaps this read, hmmmmm.
> 
> Is there a question here?

I've said more like introducing the next point, but if you want to use
`copy_nonoverlapping` then the safety section should mention that both
`src` and `dst` memory areas are forbidden to be overlapping.

> [...]
> I'll use copy_nonoverlapping. Thanks for the suggestion.
> 
> Alice

You're welcome.

