Return-Path: <linux-kernel+bounces-151809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFC48AB431
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D0D0286F07
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F533131BAD;
	Fri, 19 Apr 2024 17:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8NOizub"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE8E85284;
	Fri, 19 Apr 2024 17:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713546710; cv=none; b=rBvtRihujWwIAY7eamAcVdFlmqkqpXEpzVNLbjxq287dgV+nZiWuOBaNg1ksYmLW3zmnZED6XW9ACcsc6f7j/sC1JsPZM+30dlkcvlcNf4j/4Pqv+G3rikn4/c6jCw/Ha0aICUxIbPG9Q1D39nXc80ScMhcIzmgWOUwWAdvRMzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713546710; c=relaxed/simple;
	bh=8tkp2OzXq/LQyBsBo9UUSKU1a3auTWKdaRyv5yhqPDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMYGTLRb6Y8nO+nPPCUUBPGA/HLtlZ7UDzfsGb2kXKtExMX5SMVG+uzliv2qHV4ZysaqdXAgmposToJogWMnV8pi09XKL8mWOiijX2ckGb/cMZ4kM61wjK2ko0WoGYNeO3b/3rzQG0BSVShBS1HAPV3aMXuZ+QSqG07LH8MLwBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8NOizub; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78edc3e80e6so153405785a.2;
        Fri, 19 Apr 2024 10:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713546707; x=1714151507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etFE82tcfTZVhWATTB9AHQDcgyv5F3QBoyzAyqb3uco=;
        b=Z8NOizubSZM+EYSZbV7w0Y4nNw610IfAi4SQ6tgaisRs1mddMR693mkcuhwxKapJLE
         NNkKcszX4eJzVgoZ675HTgvTHed53DR9VRrXVcuQDc839iY3zQiFgc2lFxlZjh5+19fD
         SeqK798RQspdM7Xti5zgXQLYOIDSF2M4J00Mvce6EUbdayJA16uJLc/HbdB6GXhUZ+n+
         v+0ARaxba2o9+H8grueUKKTdJOX/cTupH5eYjbLju6gONMVbtVGC5zpoOjo/13+HL0QQ
         UVk+lxjanx3+i1ExMSJM6Rs8hXksIso+292ZQ6G8j6UFZ/WUvVpDNouvM/JMChnfBt7+
         Og7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713546707; x=1714151507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etFE82tcfTZVhWATTB9AHQDcgyv5F3QBoyzAyqb3uco=;
        b=rw/0FdpbI50z1f0cjPrBz9k/4FNY5EP9t4bY43stD91I80y1M1QrYEVipHwe1MrSzC
         cOzeh4KhGVXCyyuTrsvkciM+txQJPJlcUIb0+fXYjKnptDzIxDaYXX3OhQTrFnae/uEO
         6r7yI+LUdpyqAOepWlU+IpqOFXDQGZvYdxBgw4VtOKPpyEMJAutF06lM95fffGVNBv5L
         dShILVJIa76JdMF4Pvbbm+g4pLvszFv5O+z178YnjmskI/TXjkYYdmoH1mSqoS4BFtHe
         m96bRXyhvZ8Uw+YIaQKBL5IjqZRgtMEH0o3KJJevK0H/IEOPBG5hfJxWu4cyEDzyqzd1
         pkdA==
X-Forwarded-Encrypted: i=1; AJvYcCU+VsWuZkaIXC+VAevgPyxi2mUL8PCsASrL8tIOsh/pyKJi0/bfLhqNI+2SyhCUqmhQeVY5tH9vK3iVLsKPCdrnqRkc1xbSYryTh7XCBEFHRqPgAKmpMaCDppYJghB5yFlI/tthqNh2iQRMuYI=
X-Gm-Message-State: AOJu0Yx+nWwU1b74S7ww8IbMQIs9y/68f36YTLSdq8JhMm5MITsiV5G2
	0CUDF1TLApkZF1iS6OAczNBZ0IaQwCVUyXkG0LIB01XzAjUPlnH/
X-Google-Smtp-Source: AGHT+IFFep7UovV+uvyU+cQO4IWzeXpZBAOpFsUdttQtI/h3gTiHDpMDMDoLwJyOro/ZCj5auCJHrQ==
X-Received: by 2002:a05:620a:5650:b0:78b:ac85:3b79 with SMTP id vw16-20020a05620a565000b0078bac853b79mr2904061qkn.40.1713546707344;
        Fri, 19 Apr 2024 10:11:47 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id a4-20020a05620a066400b0078d73685803sm1760929qkh.99.2024.04.19.10.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 10:11:46 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id D72DA1200043;
	Fri, 19 Apr 2024 13:11:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 19 Apr 2024 13:11:45 -0400
X-ME-Sender: <xms:0aUiZhSPzSuQg4DTApEsEAjpXHt8CmgJrO1vDLtmTiJimCpEckwTUw>
    <xme:0aUiZqz_d9vv7PPpAH9HcAnuhp-Jrun3mEMLAm4WevDUelHoVDUXvJuxGD13SZ_Bo
    09SE9dQlkVxVnNCwA>
X-ME-Received: <xmr:0aUiZm28vBNG8_GgM2huFOEesi0b1riz3u6pJ1kfYVNW0OwXAEH9RTTN0ZM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekvddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepiedtfeevhfetkeelgfethfegleekfeffledvvefhheeukedtvefhtedt
    vdetvedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:0aUiZpCUBXgWv12Ldrj4S-GSVQi7WFp6yzWoS2HFGt73FbL7USWdGw>
    <xmx:0aUiZqhl3S6DOGlIhZRC-lkgPCAD086VJ1r7yiyKlsKUfeZRRlpbgQ>
    <xmx:0aUiZtrUX8XkXzc9jLWOTVcebbOEliXvZRscJQ4RiuyDgOnsF2AA3A>
    <xmx:0aUiZlgOn9oLlNYRCPSDP0uBlTzQ-gAVtZ6x97vouXW_BWtXJURCUA>
    <xmx:0aUiZlT4bI7fS71Yy7zhszobVzjSXoBXNANObMS0Rj_0ejNKqAnA6WQR>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Apr 2024 13:11:45 -0400 (EDT)
Date: Fri, 19 Apr 2024 10:11:18 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Arnd Bergmann <arnd@arndb.de>, Trevor Gross <tmgross@umich.edu>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v6 1/4] rust: uaccess: add userspace pointers
Message-ID: <ZiKltinLGvKlBivm@boqun-archlinux>
References: <20240418-alice-mm-v6-0-cb8f3e5d688f@google.com>
 <20240418-alice-mm-v6-1-cb8f3e5d688f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418-alice-mm-v6-1-cb8f3e5d688f@google.com>

On Thu, Apr 18, 2024 at 08:59:17AM +0000, Alice Ryhl wrote:
[...]
> +    /// Reads the entirety of the user slice, appending it to the end of the provided buffer.
> +    ///
> +    /// Fails with `EFAULT` if the read happens on a bad address.
> +    pub fn read_all(mut self, buf: &mut Vec<u8>, flags: Flags) -> Result {
> +        let len = self.length;
> +        buf.reserve(len, flags)?;

(Reportedy by Miguel)

When compile with `make rusttest`, kernel crate is compiled as userspace
program, so we need to explicitly pick where the `reserve` comes from
(Vec or VecExt), the current version will hit the following error:

	error[E0061]: this method takes 1 argument but 2 arguments were supplied
	   --> rust/kernel/uaccess.rs:296:13
	    |
	296 |         buf.reserve(len, flags)?;
	    |             ^^^^^^^    -------
	    |                        | |
	    |                        | unexpected argument of type `Flags`
	    |                        help: remove the extra argument
	    |
	note: method defined here
	   --> /home/boqun/linux-rust/rust/test/sysroot/lib/rustlib/src/rust/library/alloc/src/vec/mod.rs:910:12
	    |
	910 |     pub fn reserve(&mut self, additional: usize) {
	    |            ^^^^^^^

	error[E0277]: the `?` operator can only be applied to values that implement `Try`
	   --> rust/kernel/uaccess.rs:296:9
	    |
	296 |         buf.reserve(len, flags)?;
	    |         ^^^^^^^^^^^^^^^^^^^^^^^^ the `?` operator cannot be applied to type `()`
	    |
	    = help: the trait `Try` is not implemented for `()`

	error: aborting due to 2 previous errors

	Some errors have detailed explanations: E0061, E0277.
	For more information about an error, try `rustc --explain E0061`.

and we need to the following fix

diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index 39481e374c40..80f7e7ca2f5e 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -293,7 +293,7 @@ pub fn read<T: FromBytes>(&mut self) -> Result<T> {
     /// Fails with `EFAULT` if the read happens on a bad address.
     pub fn read_all(mut self, buf: &mut Vec<u8>, flags: Flags) -> Result {
         let len = self.length;
-        buf.reserve(len, flags)?;
+        VecExt::<u8>::reserve(buf, len, flags)?;
 
         // The call to `try_reserve` was successful, so the spare capacity is at least `len` bytes
         // long.

Regards,
Boqun

> +
> +        // The call to `try_reserve` was successful, so the spare capacity is at least `len` bytes
> +        // long.
> +        self.read_raw(&mut buf.spare_capacity_mut()[..len])?;
> +
> +        // SAFETY: Since the call to `read_raw` was successful, so the next `len` bytes of the
> +        // vector have been initialized.
> +        unsafe { buf.set_len(buf.len() + len) };
> +        Ok(())
> +    }
> +}
> +
> +/// A writer for [`UserSlice`].
> +///
> +/// Used to incrementally write into the user slice.
> +pub struct UserSliceWriter {
> +    ptr: UserPtr,
> +    length: usize,
> +}
> +
> +impl UserSliceWriter {
> +    /// Returns the amount of space remaining in this buffer.
> +    ///
> +    /// Note that even writing less than this number of bytes may fail.
> +    pub fn len(&self) -> usize {
> +        self.length
> +    }
> +
> +    /// Returns `true` if no more data can be written to this buffer.
> +    pub fn is_empty(&self) -> bool {
> +        self.length == 0
> +    }
> +
> +    /// Writes raw data to this user pointer from a kernel buffer.
> +    ///
> +    /// Fails with `EFAULT` if the write happens on a bad address, or if the write goes out of bounds
> +    /// of this [`UserSliceWriter`]. This call may modify the associated userspace slice even if it
> +    /// returns an error.
> +    pub fn write_slice(&mut self, data: &[u8]) -> Result {
> +        let len = data.len();
> +        let data_ptr = data.as_ptr().cast::<c_void>();
> +        if len > self.length {
> +            return Err(EFAULT);
> +        }
> +        let Ok(len_ulong) = c_ulong::try_from(len) else {
> +            return Err(EFAULT);
> +        };
> +        // SAFETY: `data_ptr` points into an immutable slice of length `len_ulong`, so we may read
> +        // that many bytes from it.
> +        let res = unsafe { bindings::copy_to_user(self.ptr as *mut c_void, data_ptr, len_ulong) };
> +        if res != 0 {
> +            return Err(EFAULT);
> +        }
> +        self.ptr = self.ptr.wrapping_add(len);
> +        self.length -= len;
> +        Ok(())
> +    }
> +}
> 
> -- 
> 2.44.0.683.g7961c838ac-goog
> 

