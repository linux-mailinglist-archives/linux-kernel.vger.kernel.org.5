Return-Path: <linux-kernel+bounces-127162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33558947A0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 004161C219A9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049BA56B99;
	Mon,  1 Apr 2024 23:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ao9g58MR"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC16543AD1;
	Mon,  1 Apr 2024 23:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712013718; cv=none; b=hESNNkMOtPbWU1YMJWUK6x6gJVo294ai6mliaYF+joHEln7Mj+kHNgI0ciqWACJYrJoVk63xvjJ+CY/95YngSIqRYmQZmTFsyIF+I/oRTdiZNiCGaDPb17m+MzHiRrweASXrYOv6hbU9s73z9HVu8uKgLZvwxNKdcNjK+WH8dYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712013718; c=relaxed/simple;
	bh=0+EAJqjhy7qUnqyXbEMpjBscGPZgEX2cmg4eE/DdrxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iiKtwaJ9Z6wq2LOcdbSqYpkvFHIdIcMz0ukQtVggs02o3sGLBVGzb/grPUS8NNUkAUYARb2oRTEkmfAHxXs+ghjlRSH5ouygArhlz0wgDzojBWBhzzfr8ZjqG2ie9bYotAP7nKBdByM9bCHuWJ5TDG+8SZ3H2LgKMjFgEYMy/B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ao9g58MR; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-61428e80f0cso22866617b3.2;
        Mon, 01 Apr 2024 16:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712013716; x=1712618516; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D1mxLt9IrQqWthikg7YY8D2OyqeJAzfgA0Sf3WwzMsM=;
        b=ao9g58MR/JpSP/MIw/Mgreb1c5HO30aULOS4k6PU8/kUpV7TZGavJh8/cynwQw7Zwa
         pUKS2men6c0Q+M+fCKxbMAfk/b85G0NTukLGsxFvBpQ1LLaW8nl6uB40ojK+eJhoxmsF
         DQ2TIhFs3LR4oj5Hk8zDrNiqIGHCtNQWaOEqp9NbDo87/ygkqh1IHywHblDhYmPBWQsF
         yj3nDDCdsT27cmMOdlwpbZBDL7a8L8Jtlp/4hafVj/kZtVq/wslBl1z9l5gv3xpfRzW9
         e0cRVcqoTpfvSFCDFlUJjEqQf0ib0UNfOdCHKOsp4KOrqA14QRilOa09LOBnskSAIGFx
         0LTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712013716; x=1712618516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D1mxLt9IrQqWthikg7YY8D2OyqeJAzfgA0Sf3WwzMsM=;
        b=ubIsUyKCTgXPqJXSPrE47IxJUNIrzAiHB1yaCToMisHen+djt3MiB297xbE1Jyb17j
         31I3Cd5iTCvx/yiGqFNwSlE0trGylCeGLYoo57TK+5yFEBvm/VrYRf4OYicuBtCiRBT6
         40pfRpPERAz/kJzEmZsbzSlqRiwc8clfhOrv3VDPE9F1Swx1oHDbB6VhpSm06N706rHj
         y13VrJQxSoEtKrhI4T6OkhrZyu2oSLjZssrh/29S616ArJ6twz5FRo15R06MMawPzDxL
         1T8M9mPO/Qx1NR0up9pMZAS9YyUilzqSmd9QJJs0Vsue7rXfwRfSIwZdbJXU4QfifD1Z
         dC9A==
X-Forwarded-Encrypted: i=1; AJvYcCWMcPPfEnoeMmk1mYq5PNuOQKhGW3ypdGCgqDmzonxi4I7vr1rBo/E29Ef/S8PS1T+UF6DiiXx8d+27KWXEaLjVnfPKG9nfrufAoIjp
X-Gm-Message-State: AOJu0Yx+I8gZy0ofPHQGk43Dd3ZUY9jaz5zMnRQYDaXqiC2LS2n926XP
	siBV7yJNIinPiEcLkb5B1XVJbfkpJMAb9z0Zb49PpbS5T/BGW+i8CRRkdbjmy5tw2JiffTIkjwX
	/g+/p+EGXhtOHbhZMIWhkv5maGn7chTLzomg=
X-Google-Smtp-Source: AGHT+IFNWwbgcERz1AsmoHYuIr9hm+Drefy/IdPxUUEG4+kMy0AMRSOaSJVFNEZ9fcF6QA4m+bDLcmlaujIpLHON2+o=
X-Received: by 2002:a05:690c:4482:b0:615:1294:d6b0 with SMTP id
 gr2-20020a05690c448200b006151294d6b0mr1683623ywb.25.1712013715655; Mon, 01
 Apr 2024 16:21:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401214543.1242286-1-boqun.feng@gmail.com>
In-Reply-To: <20240401214543.1242286-1-boqun.feng@gmail.com>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Mon, 1 Apr 2024 20:21:45 -0300
Message-ID: <CANeycqra4O9hcKuoMXdh365iWr8KGE+BC2rBHn36mLOQGKY-kg@mail.gmail.com>
Subject: Re: [PATCH] rust: types: Make Opaque::get const
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Obei Sideg <linux@obei.io>
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Apr 2024 at 18:46, Boqun Feng <boqun.feng@gmail.com> wrote:
>
> To support a potential usage:
>
>     static foo: Opaque<Foo> = ..; // Or defined in an extern block.
>
>     ...
>
>     fn bar() {
>         let ptr = foo.get();
>     }
>
> `Opaque::get` need to be `const`, otherwise compiler will complain
> because calls on statics are limited to const functions.
>
> Also `Opaque::get` should be naturally `const` since it's a composition
> of two `const` functions: `UnsafeCell::get` and `ptr::cast`.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Wedson Almeida Filho <walmeida@microsoft.com>

