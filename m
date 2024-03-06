Return-Path: <linux-kernel+bounces-94467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FDE87403D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B01AB21F34
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B5D13E7E1;
	Wed,  6 Mar 2024 19:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TFBZB625"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0666D13E7C8
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 19:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709752540; cv=none; b=d+xYBdBgVExBkjwsVxNAuU4u7hRCsSgMNj1QkUvV4cX9iCY69kGBa67wMXlBhVQinYNn8j6amTA74EGB38LUwU02Q+7jpnJizGDweOtX52d2gjj0bbusg/+2prWCyM4wCkM//noC+MKWbWvOSSCCXhL9KiWlLn4yn7BzgCgbibI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709752540; c=relaxed/simple;
	bh=QuS9AXxHXDpbM5rvDh38jn2uMjdWYTRhLPk0WPIY3dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0hCpnVIBShXvBIawouOYxEGd83PRqb2bwW81KgvEUTJJuZIK6ujezq7gxdVI+L5xSsmzpBbUrhwulVtAsRrQO+pOEZJ3Bt+tdmnQuEuwaO6jE6idNtU/2U73u40RBQ0cQCqJV+rW1cakyqYBkn4grueE0A9fUsWmlRi6qZfUo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TFBZB625; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dba177c596so904105ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 11:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709752538; x=1710357338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jVzv+SoRW1+I9CQGe/RRjiGpq2ikkVRYKb843GfHzio=;
        b=TFBZB625tDAO2dwG5FHXDg6Augv7nDVXlXCvW6qeCv78fNVOiNI90uV5RUbrB+LuzK
         KkL8PqjTHY0JRUqGBIiSkv9K82NCHsY/Mk+SaCNMKbK0yAT6R8a/2Eah7f99wvqp+lzf
         Q8BFJ56Uo6/TQVYlZSQNcrlrKXQr2LxsJN6evoTa7jKqXrc99Rg9XB191HJFJ+kxLv3T
         jg0Ne6v3fhfw+kZUaLQ9zoV2gFNeRQ66qFen2kLwAJlfdYeC2eTL0aK9inNHFRn6fedb
         KSzqAMgXOnjGNDuP+L7AZbPVIxGDnIwev9QVKpqFx2MV91tlSkatrlMjvwnXRMehtH4T
         CRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709752538; x=1710357338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVzv+SoRW1+I9CQGe/RRjiGpq2ikkVRYKb843GfHzio=;
        b=tTN3qe78eIY4oz4FJo/zBItLHeICemhzIXZwbYKfH4/xvRKM+m3yg/5JMt3YfXBX7G
         BSeH2tVsGulVXTlQsdvi+EXn62mRSbWyP/uKHeiwArN0DQHupqt1aOzCZ7NuhIfHPAJn
         WhHrixlpsoerDWCCd64u4mnNAjt/ssHrsbbeU+c4wfoQQ+1/3sBChQpt2nB8IXIhYPl4
         r2GonEx1woNrpxOPB+j7JWipkPhbdS61ncglJRg8FHOx12nMf3NiTQSHyR0DfHJjIYNF
         kxVKzWpd4fvQn270YiG4UwdiiVF0jgyj4vyQXB7fe/GMSoC4tPOQR7EsF21mZDVJX2mR
         MRRw==
X-Forwarded-Encrypted: i=1; AJvYcCWGgR2Kfxg0IL/Cpeclg3tMEjm+bSJtNx2vJFB43z73KP1axoNXCFfxdTOQUfJp7y/mfUsys6mMp5X7plhmabTBHyEXlFJS0mIsIlWq
X-Gm-Message-State: AOJu0YxMP7Ia3RKQUewLQgwY8X89b19NpdVaImj2qWUbiPwgIQQs4h2f
	WqnzRlHsLXvK/kuMIe3v7lGRS3YiRugOzEGMTv75S92tUiS9YgXNaQIgYazfDQ==
X-Google-Smtp-Source: AGHT+IGuYdCp1Cb41tMReB+PFmMHU4FwyH+nvlsqKqWQhCiftNEMDk5tCFfJIakTDZEyeAYTvDWXzg==
X-Received: by 2002:a17:902:e5cb:b0:1dc:b64:13cd with SMTP id u11-20020a170902e5cb00b001dc0b6413cdmr1355783plf.27.1709752537788;
        Wed, 06 Mar 2024 11:15:37 -0800 (PST)
Received: from google.com ([2620:0:1000:2510:8e30:f1a9:3b07:78c9])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902680f00b001dd090a7c00sm7520343plk.292.2024.03.06.11.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 11:15:37 -0800 (PST)
Date: Wed, 6 Mar 2024 11:15:31 -0800
From: Sami Tolvanen <samitolvanen@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <keescook@chromium.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2] rust: add flags for shadow call stack sanitizer
Message-ID: <20240306191531.GA454514@google.com>
References: <20240305-shadow-call-stack-v2-1-c7b4a3f4d616@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-shadow-call-stack-v2-1-c7b4a3f4d616@google.com>

On Tue, Mar 05, 2024 at 11:58:45AM +0000, Alice Ryhl wrote:
> Add flags to support the shadow call stack sanitizer, both in the
> dynamic and non-dynamic modes.
> 
> Right now, the compiler will emit the warning "unknown feature specified
> for `-Ctarget-feature`: `reserve-x18`". However, the compiler still
> passes it to the codegen backend, so the flag will work just fine. Once
> rustc starts recognizing the flag (or provides another way to enable the
> feature), it will stop emitting this warning. See [1] for the relevant
> issue.
> 
> Currently, the compiler thinks that the aarch64-unknown-none target
> doesn't support -Zsanitizer=shadow-call-stack, so the build will fail if
> you enable shadow call stack in non-dynamic mode. However, I still think
> it is reasonable to add the flag now, as it will at least fail the build
> when using an invalid configuration, until the Rust compiler is fixed to
> list -Zsanitizer=shadow-call-stack as supported for the target. See [2]
> for the feature request to add this.
> 
> I have tested this change with Rust Binder on an Android device using
> CONFIG_DYNAMIC_SCS. Without the -Ctarget-feature=+reserve-x18 flag, the
> phone crashes immediately on boot, and with the flag, the phone appears
> to work normally.
> 
> This contains a TODO to add the -Zuse-sync-unwind=n flag. The flag
> defaults to n, so it isn't a problem today, but the flag is unstable, so
> the default could change in a future compiler release.
> 
> Link: https://github.com/rust-lang/rust/issues/121970 [1]
> Link: https://github.com/rust-lang/rust/issues/121972 [2]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> This patch raises the question of whether we should change the Rust
> aarch64 support to use a custom target.json specification. If we do
> that, then we can fix both the warning for dynamic SCS and the
> build-failure for non-dynamic SCS without waiting for a new version of
> rustc with the mentioned issues fixed.
> ---
> Changes in v2:
> - Add -Cforce-unwind-tables flag.
> - Link to v1: https://lore.kernel.org/r/20240304-shadow-call-stack-v1-1-f055eaf40a2c@google.com

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami

