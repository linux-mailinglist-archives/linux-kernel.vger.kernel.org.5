Return-Path: <linux-kernel+bounces-29313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E83D830CAE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF5D1F25143
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC7123741;
	Wed, 17 Jan 2024 18:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6K0j8f3"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE5422F05;
	Wed, 17 Jan 2024 18:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705515811; cv=none; b=gIInqn5SzVOEL45CcRkP+ysIGf/udjZ6gDvHf+VDHj4xMCHi47jhks/uqZSahGT/UvK4g9RoZQhB3yYsUCus9HALaW2aaF99CwtrWsnfvBHIJDll4PmJywjdWIOBrUdgwBhdA8FmBN1dynV4GBaGMvheGSdgGoeU3x4XJ5avTGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705515811; c=relaxed/simple;
	bh=eXio9NlaEYl1RqaWvINUW6RFO3slj0nXN/O8m9I0jP4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=Vy1uboybbtLAXjmQbr3ct9ZkhnjM8MFwLazFSB8sTfKpu5cQnJCBYIVT6qL/ErsCM3VDaQKlB1QVZ3Ck2BBPDgLDXcc2eDk4zhr+VEMhUghTgJULnAJen3ZJZ1x6gTkq6DCfHj2zWqVUDHEDBzrvn2bfgUsbSeUH2cqzjjpXKH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6K0j8f3; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5efb0e180f0so114349927b3.1;
        Wed, 17 Jan 2024 10:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705515809; x=1706120609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXio9NlaEYl1RqaWvINUW6RFO3slj0nXN/O8m9I0jP4=;
        b=U6K0j8f35y/md+hdr8yAxS0unWHO/tMXfKGjuGAJhnSiIf3QZ+CGJw/ohMY/h+apYg
         D1OgLnAuo8YMfeXHbF7XQ77kH4rfXgkaV/vZihjLmH22habeXCoAQd3nMQWZv7UAVygV
         UDiUT7pY+VNZcCmaakU51aR8KyZanYwpqT57MlYlc40r8qqH1yT9dTCrj7ofA9aBemR/
         ivGlQ0AOEcsLM8CxRKhUn/Jx6rUO1aH8NM6+cxKZ3RHrWeWWv/ygQ3mLynZnnJ1V1Tlm
         6VTa53UHoFoi28IrtJGdHOlqnIUrhD3n2Kx0mA8B1yGyQ/yOe5crhvru0vlOQyMTVy3T
         JoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705515809; x=1706120609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXio9NlaEYl1RqaWvINUW6RFO3slj0nXN/O8m9I0jP4=;
        b=DyxV9g7bgrcezi0TwyNwArNOVxPjyxVGD4ejK9ujJ2wzGsXWmylaqF1vSADR5d3o5H
         qRkw6H7kDwf3BjDbPs5ImDwUNrj3LEMQlntok36yx8OAxQRwhu46if3wJ7eMHBY+yT3p
         DYYbW+kyBGj9m6vNhbWveDK5ehQgN6O+9c7LcdgVuVuPBxeT0++6BCTAXJ+dPUhmjZdX
         P45xt5ToDcjkoSxnGbYk7qpH7NXTmAHYmDcKnAgGQJk9g31YUvN/s5gIQSDgn8ePORhK
         z2g3o0xcr4YZeehz9mGBNz36d4x8SDsHUbGlwG5GpxN3vstSweY5XNxa6SYtf5I1vbwY
         XSMQ==
X-Gm-Message-State: AOJu0YyG1kL/ikuMk0nHVzJDtJq1tekUYeakQkTZxBNK3ITlhdTBrAeh
	Y6i7zTQwKeqDpGWbbLTfP8kptFgtrZ3oJSI4ISM=
X-Google-Smtp-Source: AGHT+IGCcH/dqD6Al/2l0bQOPWAl/S0LnMuPzV2EbQmMsbLH6gHDj92gaTx/RM0zC3S16n6n9hZ5JDh5aDxL4N2u3xg=
X-Received: by 2002:a81:ca46:0:b0:5e9:dca:1b14 with SMTP id
 y6-20020a81ca46000000b005e90dca1b14mr7334369ywk.7.1705515808771; Wed, 17 Jan
 2024 10:23:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230307102441.94417-1-conor.dooley@microchip.com>
 <20230608-dispatch-sneer-aa09bd7b2eb8@wendy> <CANiq72nnph7LS1fLRtHz8NJ91PWXPaUnm0EuoV3wrbvK398AnA@mail.gmail.com>
 <20230608-spiritism-gonad-5f5aff4c3a24@wendy> <20240117-swiftly-parasail-618d62972d6e@spud>
In-Reply-To: <20240117-swiftly-parasail-618d62972d6e@spud>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 17 Jan 2024 19:23:17 +0100
Message-ID: <CANiq72mVKCOAuK4Qe+8AHmpkFwyJsVfx8AqB7ccGi3DYpSSWcw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] RISC-V: enable rust
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, linux-riscv@lists.infradead.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 12:31=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> 6.6 came and went, and I have been busy dealing with the other
> responsibilities I mentioned and have not had a chance to look here.
> I rebased this today and things still work as they did when I submitted
> this version, but things have gotten muddier on the LLVM side of things,
> as more recent versions have added yet more extension support.

Sounds fun :)

> My inclination at this point is to engage in a bit of LARPing as an
> ostrich, and sorta ignore these concerns initially. Specifically, I'd
> like to drop the idea of having the gcc support, and restrict to LLVM=3D1=
.

Yeah, if `LLVM=3D1` works, then I would suggest going ahead with that.

(Now that `rustc_codegen_gcc` is here, we will move to that and forget
about mixed compiler builds, but we still have to handle `bindgen`
flags until we have an alternative for that)

> When it comes to asymmetrical extension support between the C and Rust
> toolchains, I'm think we deal with that as we do for the C toolchains,
> sort issues out as-and-when they arrive rather than punt this again.

Sounds good, thanks a lot!

Cheers,
Miguel

