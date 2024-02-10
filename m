Return-Path: <linux-kernel+bounces-60278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931C4850289
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 05:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1F6DB247A4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 04:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187AFCA7F;
	Sat, 10 Feb 2024 04:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAGQ/ZZY"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B195F23B9;
	Sat, 10 Feb 2024 04:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707539027; cv=none; b=pD5U+BJryvcARUAfRN0xZ64SwccJJ2vMjUM+Qb6Y9jlLYNYNnUtjIMa7415s+BGGLDZIVWqUpzIDu88mr0j3BqKNmAUpOYOkqrtWOR3m76Q9reUz3IvXJgZHep734I121KVp1eGDOO0Cj2qQs6fymH8tSsfYhqXZd+0O5BI/bbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707539027; c=relaxed/simple;
	bh=ln9JYS6GbPHPQxL+/Nc1r63uDX2PizaCmpKlb68JATg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dz+hkiegJK5XPEVlOCqSCGbfhSagHZYCjcknGFgKiI8WYEO2BjzqCGtBwv4ll/jbgw3iqGza+kkBnI39h2Agrjro+KZgkdyMOqEUJfNBorZMXuy8msklEIS7vbXlh2Yq/B/eR189pjVgbYzrpiP5CSNRyOaWeG2x0srE4ooB0IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAGQ/ZZY; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6de3141f041so1264953b3a.0;
        Fri, 09 Feb 2024 20:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707539025; x=1708143825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+R0OcFh8QuVvnUOr/SAUhq/IMAFvrwIfBwIQpXf9tlQ=;
        b=CAGQ/ZZYZ4fOjsZd99zoLU8f17XjFFtbkPnivQUVlfXZ9P5yhvPcMKBQ4WwnNhE10v
         7mUZ1Z7d2KGHMUEq0MhunSJgh6LlBZh3a9RsLna54a9IfnFLtEy1cjFaIIl4O8/03oMz
         zVtxi/gP2RiNAGe11cxAOGjx1zdeyOPV53kr7Lhj7xswF3VJbDDTyF8EToBN+vB5fBCy
         4Imahk8YfOyDgDo2G9y3CntprdV+TFqAlZhN+pLk73BnR+drUSp5109Z7dgJVU7il5sB
         T+elnZwBaPJqR0U19gE/7aDZyfafyUB7Xn6MqhTtOIutc1JFvhpl8PFWh6ga0vi+6ObV
         FMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707539025; x=1708143825;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+R0OcFh8QuVvnUOr/SAUhq/IMAFvrwIfBwIQpXf9tlQ=;
        b=a/5BQNoPnhdu+zAgLxKqorGDOdJ3Y9UFxTo8G+eHKsyw6ZY4ufsZ4F4rfUGQrdYl1R
         OIMK6n/Q4lhGfE46XlBtI9sDDtEgCnPLa8JFUSO2QMwSJRYMz1Yp1f6+j9evskttILah
         BSCZY+63glzqXoiziYFLcTh5RW7Sem6Y40NeAFJAlCuREXwQdInbCppF5KMM0fxwbwUY
         /FsWkw+XgsUsOR7q8HlwHVc3+a+ZWszdyYo5wJAlxD01VMPw/UUV1VmsiL/Fij4kEa30
         uwT8Wzh8E249F/Ch/59jpfBO+500+vdoVNPr2z5Rh8Q1fTtOz6LYByd/x8qWyMtXWVGU
         Op4w==
X-Forwarded-Encrypted: i=1; AJvYcCWoQcT4UXAlzMHYIqgjaaNIhtddCmAnbRGEQbETnnl4uHXNBvdDd4NtlN0q5Ue80xCqJXwpSgUZHccer7LAIB8+2zkCP2IG/GO2ZoDznEbQp+9m6sgCqeS1fa2z8nGByuGI9gCDkbI0r17+EAI=
X-Gm-Message-State: AOJu0YzdgcMtLueHEv449C0p2ogExKKFC6jq2HFFrFXNmEnx2GddrVWA
	uzM06PsueD5PNBIEpL9gvPtijehQ+cA0DdPYKG8uRbrZnui+oE9i
X-Google-Smtp-Source: AGHT+IHd1Lcc5MMpQyHrDTrH5tqwCgZsd0+wYJ2vs9KNP8mEmdgqizlw3H4odw2sax6sPK1jRbQVMQ==
X-Received: by 2002:aa7:86d4:0:b0:6dd:c3fd:45fb with SMTP id h20-20020aa786d4000000b006ddc3fd45fbmr1203330pfo.24.1707539024775;
        Fri, 09 Feb 2024 20:23:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVeHjFnDx6mul6waQi7Lp/LgSfsbqfN5PG95avU746wKv7PVDKFjFtsukaX+mRiLqYgTXbmvOvJFwsjO4i+IMBaKemdCX3ST8dNK8eHW4pQvbYJBBqDVpueN0vQV6s6NbeyiBwCn2Z8gwB4iFOpzNRTIe1HYBmlOVGqRz6pRa6/x9oSEW/RNqn7Nn2hQuk6BKfPCfKSRElcRBaeMgzG2CL7RJnATszXS0sPHIrJqRzS2FDbLfQyKoK9i4AswVpXlCnYDW/6euxGC5hMY+lOb3WFad7wW1u5Q7i3p6G2qOOTP6zcH0mvYLy13w9VHllPhIeO5LrJ0QUTm7SURQpmrLcSyxiBHdKTmDoD6/opgtpTFkuLU2f2K75XBSSJS/qtv8Zti7bkROSf6Duz+yjSm2Vz8cLjbpjCkWfDrrPSPpVd6PiWV6+yEPYPdTtACOfnYKegl5k9rTr9USnNM4BfEI9SXeiRyh+bqqpeeNvvAMxlTse2qTlrui/Vl8yMMPRsFLO9oeFh2ppXV8GJktZ/xEvTnZmh5X1ozaQ53nzZmdGwUHK64+hVjTqhgTBAb+NCiDHctB3937CkEAoTweFrCtMSjAPsN35UFdA2MXgVwbkfwsc069WdLIz0lqrjB3rJEz+1TVQhSc6ILk+bLYC2B3RUNSOCRTZLGNUaZcO7Xsv+MVYVBxpEpCXokGyOsawOoWYp6UBj
Received: from [192.168.54.105] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id j19-20020a056a00175300b006e0436e08edsm1419682pfc.11.2024.02.09.20.23.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 20:23:44 -0800 (PST)
Message-ID: <d35a656b-b802-4f1e-90d6-7320d61ed818@gmail.com>
Date: Sat, 10 Feb 2024 01:23:38 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] rust: add abstraction for `struct page`
Content-Language: en-US
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Kees Cook
 <keescook@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
 Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas
 <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>
References: <20240208-alice-mm-v2-0-d821250204a6@google.com>
 <20240208-alice-mm-v2-4-d821250204a6@google.com>
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20240208-alice-mm-v2-4-d821250204a6@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/8/24 12:47, Alice Ryhl wrote:
> [...]
> +    /// Maps the page and reads from it into the given buffer.
> +    ///
> +    /// This method will perform bounds checks on the page offset. If `offset ..
> +    /// offset+len` goes outside ot the page, then this call returns `EINVAL`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * Callers must ensure that `dst` is valid for writing `len` bytes.
> +    /// * Callers must ensure that this call does not race with a write to the
> +    ///   same page that overlaps with this read.

This safety section says that a call mustn't race with a page that
overlaps this read, hmmmmm.

> +    pub unsafe fn read_raw(&self, dst: *mut u8, offset: usize, len: usize) -> Result {
> +        self.with_pointer_into_page(offset, len, move |src| {
> +            // SAFETY: If `with_pointer_into_page` calls into this closure, then
> +            // it has performed a bounds check and guarantees that `src` is
> +            // valid for `len` bytes.
> +            //
> +            // There caller guarantees that there is no data race.
> +            unsafe { ptr::copy(src, dst, len) };

If `src` and `dst` overlap then wouldn't that be a bad idea? If so then
how about mentioning that callers have to ensure that `dst` does not
overlap with the page that's being read and use
`core::ptr::copy_nonoverlapping` instead, otherwise the doc comment
could mention that `dst` can overlap.

> +            Ok(())
> +        })
> +    }
> +
> +    /// Maps the page and writes into it from the given buffer.
> +    ///
> +    /// This method will perform bounds checks on the page offset. If `offset ..
> +    /// offset+len` goes outside ot the page, then this call returns `EINVAL`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * Callers must ensure that `src` is valid for reading `len` bytes.
> +    /// * Callers must ensure that this call does not race with a read or write
> +    ///   to the same page that overlaps with this write.
> +    pub unsafe fn write_raw(&self, src: *const u8, offset: usize, len: usize) -> Result {
> +        self.with_pointer_into_page(offset, len, move |dst| {
> +            // SAFETY: If `with_pointer_into_page` calls into this closure, then
> +            // it has performed a bounds check and guarantees that `dst` is
> +            // valid for `len` bytes.
> +            //
> +            // There caller guarantees that there is no data race.
> +            unsafe { ptr::copy(src, dst, len) };

Same as above

> +            Ok(())
> +        })
> +    }
> [...]

