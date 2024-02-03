Return-Path: <linux-kernel+bounces-51104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD59848685
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DAEE28502F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 13:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF375D905;
	Sat,  3 Feb 2024 13:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKXDPmCY"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3DE433D5;
	Sat,  3 Feb 2024 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706967324; cv=none; b=VolwkFFA/w8w5UuEWBLCX2rG4PjgIHxq7Em8/E7RrMp4KrgZ05q/jQpa8o7EEbZUD+FaClEr1kMJL3gIveUsWMxq4rdeS+e2Oo7rjlccylqHGOsKTETGm/HzG/7x5UIoov/Y+Yb4rwA3JkqoUnFwq/APrH3QC2+yHXdRDlDT4uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706967324; c=relaxed/simple;
	bh=A+hGYOL0gt/GgmcQa7WP6qCGq9VmybxKV6Sy9oD3vaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTSrxKPJHwXSZpq9pKmXqC7cnBEXMFq8U2IqELElxUgwBI8ka6lwWq4cdQpvoip9MeNzUCvEn3zOdUHsGUoK7Jym2rGMrDaFaxUZZ0UicWD9OyVlvn7TG5IysZv7DMOcn/YseUTthKFm9Wyp6aLIxncdfkWwU3HR5JRj97eVZGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKXDPmCY; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6040a879e1eso31389347b3.3;
        Sat, 03 Feb 2024 05:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706967322; x=1707572122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3yWyYi4bDAa4Pmz/SsjyeLYBc9Qo5resphR6lTSFh8=;
        b=WKXDPmCYgcxbgsdVy590ZgAX/7bsyUb+Y5e/ZBZpqFOXJkzr0ky+77glaCcVHcOZkW
         0+jCgJ0jsOGx3aNdu6v6+IIWneHZuoWbJkAD31eG7Mv/ypPdTv/AURwTInwFJ/RWclxz
         iB8TB7tvi0u31lUL/puxV6313lLYKmJ58QFBkkbzbi/ZbMJfp4h7kWJYj1lFyOB+/7D9
         8IPYOjMCTeLRi128aEy+978Bz/YHL+W7pNin64N8kZCfttLA1qhqkxL1FV87rzg7iCK8
         KOSBi5+L0k8t8hBtGOaDlbP5AGdvid7Cat5OGbXEHs8506oyJOcJnyJjDyu3GvHZ/ohj
         ofPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706967322; x=1707572122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3yWyYi4bDAa4Pmz/SsjyeLYBc9Qo5resphR6lTSFh8=;
        b=jJ/M7E37iPPCsKXKcAbpl/fjW9+YKvsL1M4tnV5QJ0Y3XAmFNtwkY0IAy5tL88Zr2I
         Mbj09OsRXdNOfYolia6Im9xR2Kk18LMftKWcPh4XnYJwT75CW8B0dBaT3VfdQXUSBgtF
         HzB48UurRsaBI+8wl+apfV1f/DPGBBg57ZVq4lM3Ks1Gdec9nEzSjrCZZ4REc9pHtNne
         zefX8bSLEeA181YmrO9Jx/Oi3UnHGoMXRP8b0CqE0E08rI3rmmP4CBMBgBrnYMQQHgtb
         nWl7NA3jMfDPt2O5P4jKvkMb4iMZ70TZftVZ5nsRdhDbt/0fnVG9tTARqaHCa1RpR949
         vV7Q==
X-Gm-Message-State: AOJu0YwIJhDKJQua2HxWwkT76OSIUVWICXrHGnNmCppMWihYUTN/Fun8
	wmUBqDxBXhKdNw5Wut/vTCq/tS+lqDCitqGyqUd4yy1rXFyC7VHoxvDfZMoFcwHTBiP1vkXPZxl
	w7uNw3zxY4HZ2UksoziEaipyXIPY=
X-Google-Smtp-Source: AGHT+IGy+mF9kwovaYnQ1qob9QLWfl7MTKcTdjCQ20jgFHHNz2gCRW/kwOpFSoixlIPD75u4OmDB5ajbR1avB8Wddts=
X-Received: by 2002:a81:a0d0:0:b0:602:d12f:1b7a with SMTP id
 x199-20020a81a0d0000000b00602d12f1b7amr9960316ywg.7.1706967322547; Sat, 03
 Feb 2024 05:35:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215194828.2611213-1-mmaurer@google.com> <ca0f2db8-e353-4f52-aaa1-35042e52ad91@intel.com>
In-Reply-To: <ca0f2db8-e353-4f52-aaa1-35042e52ad91@intel.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 3 Feb 2024 14:35:11 +0100
Message-ID: <CANiq72m3-j_ZmwfSCZG+-uMr9fzocMmUJhDkjgspzCKbYbbO_w@mail.gmail.com>
Subject: Re: [PATCH] x86: rust: Disable entry padding with Rust
To: Dave Hansen <dave.hansen@intel.com>
Cc: Matthew Maurer <mmaurer@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 9:32=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> That way, someone who is using CALL_DEPTH_TRACKING doesn't accidentally
> lose it by turning on RUST.  To turn on RUST, they'd first need to go
> turn off the things that are selecting CALL_THUNKS.

+1, we should prefer to avoid disabling other things, especially since
Rust is still a bit of an "expert" option, so please feel free to add
it to the `RUST` list.

Cheers,
Miguel

