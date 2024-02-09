Return-Path: <linux-kernel+bounces-59901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A79084FD1B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C914288906
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A411272D8;
	Fri,  9 Feb 2024 19:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ryhl.io header.i=@ryhl.io header.b="NjmM4v4B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ei+3VEb5"
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E581272B3;
	Fri,  9 Feb 2024 19:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707507858; cv=none; b=qBL5Q3/omytDiid9a6pIkSrl9bNAteoQggYok6B6GQitISWlZiYQ8TAF440ZaawWHYDhUA+CmP/5gqluyE+i6jh77cORsBSTZVSrDQjvrskGc+j9v2qNmv7hq9LyXzklqrwhgc3wz/rorNcdZ0VYkVPZulkrrXYiSO4L5DaUlTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707507858; c=relaxed/simple;
	bh=aUjVqz9weRqk3nI2+rU6qNFUPRqw/bc0Q2Em0cvvgxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fIi/RcArOFvn2ZsU9RJzlLjA7NOwPbCVQKdOZpiw/V7K2HuhUuYn+WHaiXUQeia9a0f0XzbEChShqvklqUHXppXhS1gryT+wKqNfZFzAsQTnAocjR+Rp71ucrUw/sVrDTVv/VTNCyKhCxWo6ekDplE906aDVW6yWjXMDuScxaIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ryhl.io; spf=pass smtp.mailfrom=ryhl.io; dkim=pass (2048-bit key) header.d=ryhl.io header.i=@ryhl.io header.b=NjmM4v4B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ei+3VEb5; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ryhl.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ryhl.io
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id DC8CD13800BA;
	Fri,  9 Feb 2024 14:44:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 09 Feb 2024 14:44:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1707507854;
	 x=1707594254; bh=Uq0f/q/RzaK4737YBI6RkZe/+xPjtPBgR+88IW4uEMw=; b=
	NjmM4v4BA4Nq5stu7QlEEwKslSyZfdseQr2QrM0ItcP6WzCH4J4KC3CSc7Jl+uK9
	2xNL/AhiB9Mpuq6ukEbHKDiRR855Pr3NFRtVgS+r/qOLIdjd8aRDQ0Ecgb/t9+kG
	kQs5auoaVUrSfDCt7PgKzou2Wum7kNWKBuGrDG4TuMDQk1q4rsf/7bLPZb6j8RdE
	YsX8jyXIEVbgmjtX0BMy/cWtD6mgWA1BLS2S3aqG+hZVuXC93oja1lqDWvSMf4e0
	e99LtWTY5ybp1bxydfyJioEOfSUTR1/9hzS1sU0DieXKoE1KLEwa7gy7CtNlpJWV
	2Jxa25tRWTXBT0xJLusMbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707507854; x=
	1707594254; bh=Uq0f/q/RzaK4737YBI6RkZe/+xPjtPBgR+88IW4uEMw=; b=e
	i+3VEb5Vt+RYAONVpOYUMzTWlAeDL3tcZ1EbU1wM0DywzNhDSCUUx/vUaON56Web
	5yZbwhiKuLwp9Flfeggg9g1VqGrQPBXtqlfrlT2nL4q9w32Z2cZ4zN06MskwX40E
	DkKWvV3DrSd8f92xS6Ca3hjXFrrOTEUctFWTG3FyRzaAEE0O3jPdEicbVL9kVRF2
	O7qm0tT+JyhVvTxPr9zEB6yshuXUmz2b9KkCH2EE/dbunQic1hmj4QrgfVSResa6
	NuBtVAQP4mC2K9ofgIrCOjqgB9RFbqiSgUS4ploIbQQw+Eiw+HwOVBjT8l8/Iv2T
	szCC87Ds70q/RYTQPx+Fg==
X-ME-Sender: <xms:joDGZWvCl0tsfHFWFSBjFYpH4XoBb3PmbctFjbrsEVJGjXlU8vXt_g>
    <xme:joDGZbcF5NR8BU4N2VCBm0x1RDOs9exkTh60NvWE8TcAXhgVAKs46UQOnJg6-3FxA
    0_Bsn1Dv7QeylZpMw>
X-ME-Received: <xmr:joDGZRwxTXDrwGHxIkq2HpF36sEmQrCTaiMT3L-sZzNf0LEAIeXJOjluah7LAApvPl_gFFl7fNn7uUn0vrwzEImArX03n68LYTOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhhi
    tggvucfthihhlhcuoegrlhhitggvsehrhihhlhdrihhoqeenucggtffrrghtthgvrhhnpe
    efgfeugfdtgefhueeiudffjefhveeuheeuheekvdetfefgheehtdffuddtgfdujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhitggvse
    hrhihhlhdrihho
X-ME-Proxy: <xmx:joDGZRN9sP3JPeDktgz3xt85JU4TuH8_unLHvks9_0zdW3YkFXHaZg>
    <xmx:joDGZW8XTJhTvrizNnPIB3xAf73xcj7JRXKxnrYgyCcVasLulwfklA>
    <xmx:joDGZZVQrpKoPtFvgqUFNbff4aHfji03pIF2HOPJkroFnOYeW585xA>
    <xmx:joDGZRVrnaYI9kOHPktngVzG0OOX5SaXK-aeOWZ3NEPWo71mmxI10Q>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Feb 2024 14:44:12 -0500 (EST)
Message-ID: <e847145b-f837-4110-8f93-806b7101d7b6@ryhl.io>
Date: Fri, 9 Feb 2024 20:44:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: locks: Add `get_mut` method to `Lock`
Content-Language: en-US-large
To: mathys35.gasnier@gmail.com
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
References: <20240209-rust-locks-get-mut-v1-1-ce351fc3de47@gmail.com>
From: Alice Ryhl <alice@ryhl.io>
In-Reply-To: <20240209-rust-locks-get-mut-v1-1-ce351fc3de47@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/9/24 17:22, Mathys-Gasnier via B4 Relay wrote:
> From: Mathys-Gasnier <mathys35.gasnier@gmail.com>
> 
> Having a mutable reference guarantees that no other threads have
> access to the lock, so we can take advantage of that to grant callers
> access to the protected data without the the cost of acquiring and
> releasing the locks. Since the lifetime of the data is tied to the
> mutable reference, the borrow checker guarantees that the usage is safe.
> 
> Signed-off-by: Mathys-Gasnier <mathys35.gasnier@gmail.com>
> ---
>   rust/kernel/sync/lock.rs | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index f12a684bc957..7711c6313e14 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -121,6 +121,11 @@ pub fn lock(&self) -> Guard<'_, T, B> {
>           // SAFETY: The lock was just acquired.
>           unsafe { Guard::new(self, state) }
>       }
> +
> +    /// Gets the data contained in the lock
> +    pub fn get_mut(&mut self) -> &mut T {
> +        self.data.get_mut()
> +    }

You can never have a mutable reference to a Linux mutex because we pin 
our locks. At most, you can have a Pin<&mut Self>.

Alice

