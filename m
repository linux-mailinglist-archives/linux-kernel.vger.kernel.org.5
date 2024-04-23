Return-Path: <linux-kernel+bounces-155910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC3D8AF8C8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4510E290974
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80D8143873;
	Tue, 23 Apr 2024 21:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9jN9Hpf"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A653142E97;
	Tue, 23 Apr 2024 21:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713906718; cv=none; b=SPOHQ5hauxuJqGOw2ytLIBQJ+lBfejf5aGdOy4Xke3KmLN5VKP7DEFBiGun/V7PqFcQb+1lT+EzxoK+sl4K0+uBsHXA0T5v0hyipibNgNf/fV9Rj/fj8JiykfX6Qxbj4kOiPCA9LNw+tb0GKJG5NbYynE4CwsJ1sCZtM76YnQSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713906718; c=relaxed/simple;
	bh=BCvCUEpG1dWWFdyB0viZeQh4dMtu9PpK7XpuEOqeMzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrcgPo6Yl5XwJ8Lv6vD039GeDfKBVTPtpiqqs7zy0I2JZ27omV3mqWMuJMLHzPJEE4wU5oKyJ93d0BM0lezuauMmNakpahV7kBFWbIFq5y5nsmt/3aUACIZKWv9dyqztx1HrLKjFVXtc0F9eTYlgVffJ5vgOVq/ZHXJvchm51Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9jN9Hpf; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c71c7e2d40so1726494b6e.3;
        Tue, 23 Apr 2024 14:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713906716; x=1714511516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UC62SSmjBqgn/WCf7krMQgCSYCyzmYRam3I6GpOx66w=;
        b=d9jN9HpfIo8iJv6ZDqv8rYemaZArEhCPuBTJKaSlExHukviS4a4wqjyec/vSkzDGNH
         Xb09Us79+KphWzOJSE8s5cWdm43V/lg04q/XldJMOBgXRQJqbFOalMEpCjr0UwSwBAPJ
         i3CUYOq0DQUErv90L5GXCMHJdqulgHhhBZ5ghM5v/OGw27QSdNgN9aQC7xAgx7b4UTKx
         QB2GYNuciNtlTSFwviBzWU0oqy4nbxZXOWo7RTeNIg6UoFBCnWDn6kkx6aX0nPmOBjuP
         todJsCfiOoCC2P65orQvrKd4axaVqx+37+NBIt/z/wxeLFDmo0UQCT/yYj6S/yvgshFA
         4dyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713906716; x=1714511516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UC62SSmjBqgn/WCf7krMQgCSYCyzmYRam3I6GpOx66w=;
        b=AnN5aRhCzwFb1GCdlkgDmNKxH1V24aXbnZXFk3U2q5nPOOMdflA1ny8YDsk9jM2CgN
         VIHCPNXvhyxlfLnjFr4hv9UooSfoHRiAjG/qhhY4OzwUx690pnG6eaVuTn5XUGwCPHUf
         hWB9EOX2v4HrV6WM4s1LwvvFAgQ4YJ/JX4EApuyu+FSOwrE6Apn6mm0eWKghdD4kCAVk
         9lUu1jLI8g+Xt143Kvb1aELXjqOgIxn4im2nmgGIe5fiB5N6uHZcxTFJWX036JfgId8j
         OWeiH/FaUKi2RVFh3Pyw+G2yWynvZg1sMk/4Yz4HUwL3mdDXAR8pdidzVKsAtwzlRwmG
         yl1w==
X-Forwarded-Encrypted: i=1; AJvYcCXsm6NXvZbqv1MEEK0C4oDIRfl+8GF+fxyELID7gcLsH/wVwVGzyODy3S8ja8q6wYtXS8MMgqoHsSJRmOwY1ymgLpZ+PYnDFEwoyz0o/tDsZJ56dmuoEXIsxrkN0DNOj6UlPiVP2UWQUKj4nLA=
X-Gm-Message-State: AOJu0YyK7ib+uaDVwRSDJOQkMGTkyIoBhgVN+brAeGMoOLaYEmzQVv/0
	orrROYZ1/CHZ3hkEjXF+4azc7evtId5Hh7KpmfisXdB+FJ63hyaJ
X-Google-Smtp-Source: AGHT+IEAGMS00VbhqfFBWsfVSykVB1kntpVJBjlm4lod2mX9JgXgeLsGyeiQxu8jUZyBJKidb6cqKQ==
X-Received: by 2002:a05:6808:3946:b0:3c7:2607:c541 with SMTP id en6-20020a056808394600b003c72607c541mr531525oib.13.1713906716541;
        Tue, 23 Apr 2024 14:11:56 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id ez4-20020ad45904000000b00690c77505bdsm4599305qvb.37.2024.04.23.14.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 14:11:55 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 4C93F1200032;
	Tue, 23 Apr 2024 17:11:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 23 Apr 2024 17:11:27 -0400
X-ME-Sender: <xms:_yMoZmhFRcIK8DVwWc8fVIFmCA7b2Qo21YprbLdxX7KvRy3bku3aNg>
    <xme:_yMoZnAZsGdnKr0u73bo4MqdbeDD0xnid2mnf57ZVMq7zKgudabWfFsThoK39f3P4
    MXfGsR3Ji63STeDNQ>
X-ME-Received: <xmr:_yMoZuHMdefAp0cy2y0K7psNtY67MOUydvChnZSYA4eRBjlWZ8So72p5EqM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeluddgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeeg
    vddvhedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquh
    hnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:_yMoZvTNiaVV8nrPP30lODW96KszhoKxVBejmKnDQ3J5L6JECDxUug>
    <xmx:_yMoZjyt6fvmjs_p_2LjlAzbx-W3Lo1I5HKe3QgvZv0DrJZIKk6_CA>
    <xmx:_yMoZt5GWXBCIUebkyJylJM_aZMQcQofHW_LEO-Pp1wBi_bMMVHQmA>
    <xmx:_yMoZgwy9FYWPuEPzInIxRS_bGFjoCwIcZNZ3c7TJk6fd9Pb3RihEw>
    <xmx:_yMoZvjjsP7E35pfrWuVUdAGtQCtpbf9wwqmn_7N9DfzRmuFHKp1UCl4>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Apr 2024 17:11:26 -0400 (EDT)
Date: Tue, 23 Apr 2024 14:11:22 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>, Miguel Ojeda <ojeda@kernel.org>
Cc: John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 2/2] rust: time: Use wrapping_sub() for Ktime::sub()
Message-ID: <Zigj-lY5lnBSKuib@boqun-archlinux>
References: <20240411230801.1504496-1-boqun.feng@gmail.com>
 <20240411230801.1504496-3-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411230801.1504496-3-boqun.feng@gmail.com>

On Thu, Apr 11, 2024 at 04:08:01PM -0700, Boqun Feng wrote:
> Currently since Rust code is compiled with "-Coverflow-checks=y", so a
> normal substraction may be compiled as an overflow checking and panic
> if overflow happens:
> 
>         subq    %rsi, %rdi
>         jo      .LBB0_2
>         movq    %rdi, %rax
>         retq
> .LBB0_2:
>         pushq   %rax
>         leaq    str.0(%rip), %rdi
>         leaq    .L__unnamed_1(%rip), %rdx
>         movl    $33, %esi
>         callq   *core::panicking::panic::h59297120e85ea178@GOTPCREL(%rip)
> 
> although overflow detection is nice to have, however this makes
> `Ktime::sub()` behave differently than `ktime_sub()`, moreover it's not
> clear that the overflow checking is helpful, since for example, the
> current binder usage[1] doesn't have the checking.
> 

Ping. Thomas, John and Stepthen. Could you take a look at this, and the
discussion between Miguel and me? The key question is the behavior when
ktime_sub() hits a overflow, I think. Thanks!

(Cc Kees as well)

Regards,
Boqun

> Therefore make `Ktime::sub()` have the same semantics as `ktime_sub()`:
> overflow behaves like 2s-complement wrapping sub.
> 
> Link: https://lore.kernel.org/lkml/5ac8c0d09392290be789423f0dd78a520b830fab.1682333709.git.zhangchuang3@xiaomi.com/ [1]
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/kernel/time.rs | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index e3bb5e89f88d..3cb15d3079f4 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -77,7 +77,9 @@ impl core::ops::Sub for Ktime {
>      #[inline]
>      fn sub(self, other: Ktime) -> Ktime {
>          Self {
> -            inner: self.inner - other.inner,
> +            // Mirrors `ktime_sub()`, kernel defines signed overflow to behave like 2s-complement,
> +            // hence `wrapping_sub()` is used.
> +            inner: self.inner.wrapping_sub(other.inner),
>          }
>      }
>  }
> -- 
> 2.44.0
> 

