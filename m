Return-Path: <linux-kernel+bounces-65908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7E5855392
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB631C264BF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0886413DBB8;
	Wed, 14 Feb 2024 19:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ryhl.io header.i=@ryhl.io header.b="IpsE0O97";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tf6uPpHP"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A899213DB89;
	Wed, 14 Feb 2024 19:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707940754; cv=none; b=cl2Ol+HbU0Xqh2Ovc4AZ/hM57L9Onlcomg/Pi/htOG/NIqp96j2mT9tvDLGdJyWC0Yqga4YTDifGewUWKzDl4ZB/GLVuPRlsmAqg8b+lcBSnSbaf31XC1bSX4T60iBC5M5ZGGFhHOQET4fF1fmxhB1aiuabXnQW+jJRHB55MQOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707940754; c=relaxed/simple;
	bh=8dbIZkc7iluw4d62Qz7g3VPq5jEMEKqVH19XVKGgS5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GWTDJu72Q3h7e14nUonXNZuaXlfIBhLPAauubB6TuKXAaFbblONeWkRMdrVGIABWf+vf5BUo37OScLN+s2o0VphJ3ER0Vykma7K7N/xNdXaqpEFYYs1AGIBWJpdOTQ2fLy+7JE8idnL/WhtiPR38d4sciRUWgwSYhPmzxTSQgDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ryhl.io; spf=pass smtp.mailfrom=ryhl.io; dkim=pass (2048-bit key) header.d=ryhl.io header.i=@ryhl.io header.b=IpsE0O97; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tf6uPpHP; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ryhl.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ryhl.io
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 665BB13800A0;
	Wed, 14 Feb 2024 14:59:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 14 Feb 2024 14:59:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1707940751;
	 x=1708027151; bh=kblh42iEi6BqEIDvzG3EpyCmLAkUwY9rEd/N4oq3kDU=; b=
	IpsE0O97/bbD86gLLXLQipwZ/OIBrnnnhLnx/QzMwiKFnpJniBXd7sBrelBQOSAV
	jSkSTgZX1nx89g0KV47jWZPhZ3NQUk4BqBxkz0nD1mbcRbMjb7pKETb/CiOHrM2s
	vf2YEPXGlwLjdySP9V1R3/H35NJ/QZ1TN64x71+rq0FLWKp+5kfuaYXPFYx9iGND
	Wkx/iltnX9lTE9U0zOnfDP7cYgcm3QTHyHZaRa+y1nRrEpnNjPgWi/kqzEiBZ2zn
	yb088Ug+7I6BKTx7INyiOn19fzSYf8yVgc3dQdlKhYB4m9+Q4mdatZTsXrpr4VmB
	1t/KgLkp7Rc/SLnNuwJbBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707940751; x=
	1708027151; bh=kblh42iEi6BqEIDvzG3EpyCmLAkUwY9rEd/N4oq3kDU=; b=t
	f6uPpHPVgAQ1WDzRM7hdI3/rzMQ57aK2y7FhfjJ8oW3KEUTbLSIXL1DzcSPLOn1k
	8sZ4PR+JUoN2glrbdN+raekmNJ5jla2p5tAoU3QgSeV+Kk9uToL4kYzM5+zF06jT
	Vp/RlEhLspEHqqEztGFqFJ8emelp3qPXppdz+QgPd3XQ2JHVJ2mKbvo3RFN7uIUY
	JtjvJ+wEQDmnssaa/PfZ45arE8wFh+LDS5IwqTJtx+INeOXMlRhL38rQTa3FIses
	v5AxFf/QE+mnGsV0lv7uMa8PUY0DsGWdoJtOJH3v5v5g91NVswTD2uS+RlrrwNdh
	A1guSIjh+Hy9MkhBd5IkQ==
X-ME-Sender: <xms:jhvNZU_GJ0ZuCBIKeUOfpbAG6icAlhZ3bvwz8bOI4IhZhYzhXFvw6g>
    <xme:jhvNZcuF5DXlpUeb2IvlkzLXBgUPYc793wvffxjGvMnQkMqVv19gE_QQKjmgpRrG0
    -sKfxZ1ZNdY8M5J6g>
X-ME-Received: <xmr:jhvNZaCxBZuCPGqjhHxsP8MPS3yYvWaD4EzF8gme8MH2Ero_hjSyBxJmzJh_rQLRpbvvf_j7bw141-zkEPeFqQXDHN3QEmSvME_m>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgddufeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhhi
    tggvucfthihhlhcuoegrlhhitggvsehrhihhlhdrihhoqeenucggtffrrghtthgvrhhnpe
    fhheefgeekveeigeeftedtjeduveduhefguefgieehgfeiueetuedufeekudeuueenucff
    ohhmrghinhepiihulhhiphgthhgrthdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhitggvsehrhihhlhdrihho
X-ME-Proxy: <xmx:jhvNZUfNZeP2jwxt-a6QL8MxPwrGAFFa-CDmHsCw_YSbMfTK8wbBag>
    <xmx:jhvNZZP1fVQjQgc09K-AlZ8UHlT-DCa8YGJjFrrwszEFPVKAOvUsdg>
    <xmx:jhvNZek9roJwk2aybCwvNuMwVTxPho50f1I28DRyJv_jPgxV4jpQKg>
    <xmx:jxvNZdmoeXur0vppkdX83C5Th_5yB2XoKBwDvNXYBMmPaN4vUDLTSg>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Feb 2024 14:59:08 -0500 (EST)
Message-ID: <2d94d420-fca2-47c1-aee7-bbce7a1505cf@ryhl.io>
Date: Wed, 14 Feb 2024 20:59:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rust: str: add {make,to}_{upper,lower}case() to
 CString
To: Boqun Feng <boqun.feng@gmail.com>, Danilo Krummrich <dakr@redhat.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240214172505.5044-1-dakr@redhat.com>
 <Zc0UNUGbmmBlzBAv@boqun-archlinux>
Content-Language: en-US-large
From: Alice Ryhl <alice@ryhl.io>
In-Reply-To: <Zc0UNUGbmmBlzBAv@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/24 20:27, Boqun Feng wrote:
> On Wed, Feb 14, 2024 at 06:24:10PM +0100, Danilo Krummrich wrote:
>> Add functions to convert a CString to upper- / lowercase, either
>> in-place or by creating a copy of the original CString.
>>
>> Naming followes the one from the Rust stdlib, where functions starting
>> with 'to' create a copy and functions starting with 'make' perform an
>> in-place conversion.
>>
>> This is required by the Nova project (GSP only Rust successor of
>> Nouveau) to convert stringified enum values (representing different GPU
>> chipsets) to strings in order to generate the corresponding firmware
>> paths. See also [1].
>>
>> [1] https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/topic/String.20manipulation.20in.20kernel.20Rust
>>
>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
>> ---
>> Changes in V3:
>>    - add an `impl DerefMut for CString`, such that these functions can be defined
>>      for `CStr` as `&mut self` and still be called on a `CString`
>> Changes in V2:
>>    - expand commit message mentioning the use case
>>    - expand function doc comments to match the ones from Rust's stdlib
>>    - rename to_* to make_* and add the actual to_* implementations
>> ---
>>   rust/kernel/str.rs | 81 +++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 80 insertions(+), 1 deletion(-)
>>
>> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
>> index 7d848b83add4..02d6e510b852 100644
>> --- a/rust/kernel/str.rs
>> +++ b/rust/kernel/str.rs
>> @@ -5,7 +5,7 @@
>>   use alloc::alloc::AllocError;
>>   use alloc::vec::Vec;
>>   use core::fmt::{self, Write};
>> -use core::ops::{self, Deref, Index};
>> +use core::ops::{self, Deref, DerefMut, Index};
>>   
>>   use crate::{
>>       bindings,
>> @@ -143,6 +143,19 @@ pub const fn from_bytes_with_nul(bytes: &[u8]) -> Result<&Self, CStrConvertError
>>           unsafe { core::mem::transmute(bytes) }
>>       }
>>   
>> +    /// Creates a mutable [`CStr`] from a `[u8]` without performing any
>> +    /// additional checks.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// `bytes` *must* end with a `NUL` byte, and should only have a single
>> +    /// `NUL` byte (or the string will be truncated).
>> +    #[inline]
>> +    pub const unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) -> &mut CStr {
>> +        // SAFETY: Properties of `bytes` guaranteed by the safety precondition.
>> +        unsafe { &mut *(bytes as *mut [u8] as *mut CStr) }
> 
> First `.cast::<[u8]>().cast::<CStr>()` is preferred than `as`. Besides,
> I think the dereference (or reborrow) is only safe if `CStr` is
> `#[repr(transparent)]. I.e.
> 
> 	#[repr(transparent)]
> 	pub struct CStr([u8]);
> 
> with that you can implement the function as (you can still use `cast()`
> implementation, but I sometimes find `transmute` is more simple).
> 
>      pub const unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) -> &mut CStr {
> 	// SAFETY: `CStr` is transparent to `[u8]`, so the transmute is
> 	// safe to do, and per the function safety requirement, `bytes`
> 	// is a valid `CStr`.
> 	unsafe { core::mem::transmute(bytes) }
>      }
> 
> but this is just my thought, better wait for others' feedback as well.

Transmuting references is generally frowned upon. It's better to use a 
pointer cast.

As for .cast() vs the `as` operator, I'm not sure you can use .cast() in 
this case since the pointers are unsized. So you might have to use `as` 
instead.

Alice

