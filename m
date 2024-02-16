Return-Path: <linux-kernel+bounces-68988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2165F85830B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C002B23A62
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BF712EBF4;
	Fri, 16 Feb 2024 16:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FBYTll7I"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF25912FB15
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102405; cv=none; b=gJYk6RiOfMaZyBFMYElbru215VnXFUMx3e8geDIaR5S9X2KjLoYjHox1dE5oX0teIVa8bWJYwxoZ1pJqtnYvOQB7YGGcfv76MgTq/2xzlUnMAlgfEyd2iT9215H23dvHSOL/IswPnxC2EgUL/0sPvo0+TQV2iCuBcK8qHENgzo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102405; c=relaxed/simple;
	bh=+sI6/arw4pHUlSy2P7FUAboUipEszX2peP0Agji1zh0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ine5Vedk9hFHqXHXNeWW493XzcD2lBtCumJ7AiH13Vnvri+6dza/MkYQPyTkpW3aMBfVIpVqB9ZYh8CrB8kGVyZ3+EQJhDL/5E03QpvSuaAkfhySOvq/iIsP5LcEeUPKsY7spYmU4m1pen5GtHyhb7H3SRabzhjgXOYgVwIbvh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FBYTll7I; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60753c3fab9so27885487b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708102403; x=1708707203; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UXS1gX5/Xy6PLxYM9RfnwBDoH8Pa3vSwtFNHUTxgmps=;
        b=FBYTll7IG/IXJaa9GAs4tCoembR4ylNRKm5NYRz7l8dmZYtFwwCliJdxQ6qbNI8ffb
         Q1GA1JFrCmQpZZQJ/ljtBDyosbcIN+H5O0uj9fJMkqhacVkh/YUxV4pk0yAFNC8UKdWg
         ec4OHnUst4yE8YDbOCWcjSXbfdfTT+gMIDYt4MG9Ba6ZwwPzThl3bNmXecYTLhB2GhC/
         sqCbmV9MJzOpd1cEHOy+uKDLJ3eB6XhJV+WxCdhFsOlr0IGkR5Wbxye/ds/DA/U14PUZ
         xUfaEzGOZMAKuBBFBTt8mtqE3sRx9/L66bhy4L/Rng7NIIZSCJnTt4EmJKByr8XdeWlx
         9h7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708102403; x=1708707203;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UXS1gX5/Xy6PLxYM9RfnwBDoH8Pa3vSwtFNHUTxgmps=;
        b=M8AMkzJfC7Yml8uJ5SH+ouJQ/TCpjVIGW9R79w/cpwTf4tqTLip8z0hnAAVHlpSaHx
         1u/p+nLoTjsF1o2rKnirkUN41MBOX9OcjA8iCRIG8RCoxPvs1OHB9cPz7YfNc6qsFWjY
         CZFKxy69ysZ+VeGcpoKDtTefO0zbtZZAirB4GWpp+g49ljmiTHRukYMvCWwQdKHHko89
         Szdocd8cYsUZc6upHuu/EDwmTxk/ba+96cb1zlXP6vlWp4eNfel7OxLeG7FJVtDujty6
         0/CKOQzgPGNDGAT792EDRITRW2qRkO+h2W0VU9ZXtrV+xw4B+FcpgCmcghkYP7jLqmNy
         f5JA==
X-Forwarded-Encrypted: i=1; AJvYcCW2VdFkQjiUQIihvENy09S8oSr1xnhZabWZ4/RMbwIIyVbwgT/AkuuGiCYr18SI0euAUiw2gMEy/ZBH1LWI4zas6nl/wB5Pg7ZsY22b
X-Gm-Message-State: AOJu0YxZPQaWhR23UkUOugpxaquzNA48El3HRx5hpxyGlT8YIJDbyEYz
	mu4ndbaJBsBdgFSod/5X70ObbqR2jm1hl5ZpF9L9p754NU+pFI8slspLxaDW2hcK1IgY6GcBduT
	xrkO8uyVqKPgviA==
X-Google-Smtp-Source: AGHT+IGBxcUNdP7+M7iOUi+IxF7eNsX6SiwX1KHA/WlIg1zz7hHGs/AOt9gSw9o3mqWt/AEFxu+OVjXUjMjRt0U=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a81:6c14:0:b0:5ff:6e82:ea31 with SMTP id
 h20-20020a816c14000000b005ff6e82ea31mr1184941ywc.3.1708102402988; Fri, 16 Feb
 2024 08:53:22 -0800 (PST)
Date: Fri, 16 Feb 2024 16:53:20 +0000
In-Reply-To: <20240214172505.5044-1-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214172505.5044-1-dakr@redhat.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240216165320.1820346-1-aliceryhl@google.com>
Subject: Re: [PATCH v3] rust: str: add {make,to}_{upper,lower}case() to CString
From: Alice Ryhl <aliceryhl@google.com>
To: dakr@redhat.com
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, linux-kernel@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="utf-8"

> +    pub fn make_ascii_lowercase(&mut self) {
> +        self.0.make_ascii_lowercase();
> +    }

It's important to note here that this doesn't remove or introduce NUL
bytes.

pub fn make_ascii_lowercase(&mut self) {
    // INVARIANT: This doesn't introduce or remove NUL bytes in the c
    // string.
    self.0.make_ascii_lowercase();
}

Ditto for make_ascii_uppercase. (But not the to_* methods.)

> +    /// Returns a copy of this [`CString`] where each character is mapped to its
> +    /// ASCII lower case equivalent.
> +    ///
> +    /// ASCII letters 'A' to 'Z' are mapped to 'a' to 'z',
> +    /// but non-ASCII letters are unchanged.
> +    ///
> +    /// To lowercase the value in-place, use [`make_ascii_lowercase`].
> +    ///
> +    /// [`make_ascii_lowercase`]: str::make_ascii_lowercase
> +    pub fn to_ascii_lowercase(&self) -> Result<CString, AllocError> {
> +        let mut s = (*self).to_cstring()?;
> +
> +        s.make_ascii_lowercase();
> +
> +        return Ok(s);
> +    }
> +
> +    /// Returns a copy of this [`CString`] where each character is mapped to its
> +    /// ASCII upper case equivalent.
> +    ///
> +    /// ASCII letters 'a' to 'z' are mapped to 'A' to 'Z',
> +    /// but non-ASCII letters are unchanged.
> +    ///
> +    /// To uppercase the value in-place, use [`make_ascii_uppercase`].
> +    ///
> +    /// [`make_ascii_uppercase`]: str::make_ascii_uppercase
> +    pub fn to_ascii_uppercase(&self) -> Result<CString, AllocError> {
> +        let mut s = (*self).to_cstring()?;
> +
> +        s.make_ascii_uppercase();
> +
> +        return Ok(s);
> +    }

Please move these to `CStr` as well.

> +impl DerefMut for CString {
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        unsafe { CStr::from_bytes_with_nul_unchecked_mut(&mut *self.buf) }
> +    }
> +}

Needs a safety comment.

impl DerefMut for CString {
    fn deref_mut(&mut self) -> &mut Self::Target {
        // SAFETY: A `CString` is always NUL-terminated and contains no
	// other NUL bytes.
        unsafe { CStr::from_bytes_with_nul_unchecked_mut(&mut *self.buf) }
    }
}

Alice

