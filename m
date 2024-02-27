Return-Path: <linux-kernel+bounces-83429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667BC869901
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3473C1C236F3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48ADC13B79F;
	Tue, 27 Feb 2024 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5C76UY9"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3314213B797;
	Tue, 27 Feb 2024 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045264; cv=none; b=Ly6Sn9/TPl1opS0jyTxqDC2xkchKcAZjXNnfSV1TWoSR2ZQj5Y0/TaSagLRC9YV1CffdmOfnhLF7VV3OZ2B+tRyW/GJxTqBm8tGwuiOb78E2SxWv35eO+k5ZibV9XtOvsTcNaf3F6b9p/Utyfzqe/LM/sQGxZ9+/UhUr5Vbbk4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045264; c=relaxed/simple;
	bh=I7STVGxFEhzeUUnynFVCazQYTKSuDkuz5TcCbE8wTBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gXB1HXQg8zsQH+ot9MzyRUgIpY6/ryWVloarc/dpbQKkMihy0M3b9aMRRbWQsO0waeZj/oQVtF+9VehWwN6x199GniBX4B5h4wyPPviOHBvSJpwGLkd8CzTPJ9vSubvsYF4j7h0qnOuHhNdcc+qAlNL3uQH2XwlfKxEqvdgrc0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5C76UY9; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-53fa455cd94so3198529a12.2;
        Tue, 27 Feb 2024 06:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709045262; x=1709650062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCy743fk4tyJkNw6DXsgUea2FahrCbo/h1GwjkT/m8w=;
        b=C5C76UY9g/SFjwOxrGGHL3xxdYTWS2UdptMmk9qGB36tQ6jkhYs5uO2GmcMmQp0NL7
         1M5FwI8UnsiI++/3ci5D4siKDNFNX4Z6tCQXpHVfkdufjyo1BMbq/XqbeL6MrMkG96MJ
         +Ki0TCrnZHWhFWAc/jP3OQKa0y0bDaUziUCtIqCDECxSNn6SZOCSj0v2u66zFa3WcAlT
         nHK3XqOBd0Cj9oiDK5uXWeSqxQWOrSur5DnSXkepVYn8OvaHrSYNNqGtjEO9Hh4Vn6AE
         vWRvty+6CTsf0WDxuEJ+Q8XHGiOlsR/azbT3S93VAEDV8/Lx5NQkTPF5uWpmb4/2tv5M
         KXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709045262; x=1709650062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCy743fk4tyJkNw6DXsgUea2FahrCbo/h1GwjkT/m8w=;
        b=dGeXkj8+qnGNXr/CgLaK4eNVSKBxHREoj1Rsq9QPIil8U2Rcn6GV0rb33qAdkPuwQA
         P+CzGqZeKvO1ZXpmNtxxVGsv4JBuQ2uHn15kbZxZOce3S4VOpN5SNnqwsYezliCBpeOQ
         jPW5TtfxKRae9ZKngs195kUm0B94md6RzzIXCzOTu+eUW9QL8TOOajFD912PwairqTdu
         04X1ChFHu7MYyijAKPL+LjKFXpBxL+9wU6MoO9bEsMWuP/wR27DppqNTLUn9n2S0pMWl
         zYa9QOQJjKmuiFsXdCrmoJPX5tpuJsTf+QUIu//gCLofe5U+xZKZW0SJDU0zE4LISkMp
         o3aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk4hqFwG5Tc4ctEptCi4hh4YKJohrLMPe9yrnpMNn/S30dwYWImqmozB6j3rQtt0Oiss/wRZH/WLYbv/83m9fwEoQX67rK4bU4u6pw5cV7JAGpZIyvXs/aux5Nq7zbJuL9AQ/GN08VIYDCQ9sb4UcxkVPaxVbTpbRyT0M2FMQZhaCe6X0mb3M=
X-Gm-Message-State: AOJu0YwrtLmpWqF4P7Jj4foiPkQaDxThhwF3QYMDpPV0DrfXYUTfH9/g
	N91wORUe+EUXTG4u1qpDzEebPc8N3pyppKsvjfIKwKJyIdmIDU6cGn/6LdAy4qSpEdBirCqSWoj
	6JUsk8u3ZM0YHZ8TKkxKmCkXF3EM=
X-Google-Smtp-Source: AGHT+IFafpLdk0evJiKKq2WOgHZJ334wUaliiML9yKUEBDk7ieZRcShNP65NIpPeHhXYIz7pBy67jwjYFUhaFlkV+Ak=
X-Received: by 2002:a17:90a:dc0f:b0:29a:b713:8b27 with SMTP id
 i15-20020a17090adc0f00b0029ab7138b27mr5063628pjv.46.1709045262472; Tue, 27
 Feb 2024 06:47:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223-leverage-walmart-5424542cd8bd@spud> <20240223-employee-pessimism-03ba0b58db6b@spud>
 <CANiq72ngEZskjH0f=8+cJuQsFTK227bGCxe5G0STMHuPbZYnXg@mail.gmail.com>
 <20240227-resolved-deceit-4a59a6af5b71@wendy> <CANiq72mwM+4Oh-H5WmRoqQ_nE1w-eJ1wn-nEwS=BR9JRwzxMMQ@mail.gmail.com>
 <20240227-glove-underwire-f562a56cf2c7@wendy> <CANiq72=f03_bw9B8ww8UxHkVyP2F7ZPyvC+KWCyhO3Nk1yqdaw@mail.gmail.com>
 <20240227-swarm-serpent-2010b255f68a@wendy>
In-Reply-To: <20240227-swarm-serpent-2010b255f68a@wendy>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 27 Feb 2024 15:47:29 +0100
Message-ID: <CANiq72=69uBBhKMrw5P8K6eDHPiwAw_Oj8g1aYcywEYhhUG8OA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] scripts: generate_rust_target: enable building on RISC-V
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org, 
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

On Tue, Feb 27, 2024 at 1:37=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> Looking closer at those targets, all of them enable compressed
> instructors, but we support hardware that does not support them.
> I think that means we are stuck with the custom targets.

Did you try `-Ctarget-feature=3D-c`? i.e. as far as I know, you can
disable target features even if they are enabled from the built-in.

It seems to work from a quick try (in userspace), e.g.

0000000000000000 <f>:
       0: 9b 05 05 00      sext.w    a1, a0
       4: 13 05 a0 02      li    a0, 0x2a
       8: 63 84 05 00      beqz    a1, 0x10 <f+0x10>
       c: 13 05 b0 07      li    a0, 0x7b
      10: 67 80 00 00      ret

vs.

0000000000000000 <f>:
       0: 9b 05 05 00      sext.w    a1, a0
       4: 13 05 a0 02      li    a0, 0x2a
       8: 99 c1            beqz    a1, 0xe <f+0xe>
       a: 13 05 b0 07      li    a0, 0x7b
       e: 82 80            ret

Cheers,
Miguel

