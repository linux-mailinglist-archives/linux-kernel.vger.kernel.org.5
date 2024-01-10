Return-Path: <linux-kernel+bounces-22535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9ED829F27
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C031C22AB6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A59D4CE1A;
	Wed, 10 Jan 2024 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h8F25P27"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F8347F56
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7cd42bc09adso1313375241.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 09:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704907712; x=1705512512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1gDQWRsTBn8FfuPpZdgTLj6dmGKzp9kvOi2HJqDhRc=;
        b=h8F25P27vHUT8FawdZEMegwqD0cSRM1tQiSA3jzYaw0xWgZlyuWw+pRR8BJn07DzWA
         wOf2KTyOkKv/bAiiJ1fWIjopjHAGVKRnnyU74W9njxo6Em08hf/48FOa0a0lneFpKtln
         FkJstHydYZfAYoxtY2/8gT9UGC870aks/DRn/r2nFio7PX/Jk0yRTx1XPqn00PisP//a
         jzF9JaRFWKUgsQKxk5EA8TnRkvmgSaoxfMRs2OCzLEWZEjwXe4wzT+Di6VZWvQPJ0P41
         loTwAkFBt3rp9D3nPB/TcectJZOeFc30NTzeic13kw6KNa2nbEBXtclFgvIT87XQxUC7
         hWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704907712; x=1705512512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1gDQWRsTBn8FfuPpZdgTLj6dmGKzp9kvOi2HJqDhRc=;
        b=vtvzvefxGrHn0YvVpqschVOsybrLwDwE0hltd0VMmZd4FHveGbDSQ+y1MxbjBDWJtm
         vbeU5izNl2eE4PJdHbR+8pChVj0G/TlK3sEHYvJVpzxnjMwmtXEBPgVj41ywUgPH6ca1
         GHlsya4DTqN9j6GoDEDzF7IUKTnFQDEwMBcOJEcVm58gUti2LWNaLgwAi8cPCTst/h0c
         XHTYJSqn/ww+e2rNrdXqQQ+Ibr+9A1g4uh+WqImdVjqF+qlZr8A8fP1hCu+cjaRCJEAK
         f9UZ7NsgkwH8d85JmM4FnbZyk7Rz+/Mbmd5foN2yW9cWhPWrWg0kgqpkIXKf2xqE0+ji
         hbaA==
X-Gm-Message-State: AOJu0Yw//e2OYPHDyYyZiKFcHbCvWm2srx+g41Qdx4YK5E/P9Ymw6rso
	OjTElzzs/CN22CQPVI4vGp8VqUvmGEcaI0aaeXjSbZO7K5Na
X-Google-Smtp-Source: AGHT+IEoYRbB+JirhI0ipcDY02s6rgl5EC07s+Fc3so1lLucdbroukxYD53l0f0ymZVkJpINcTS4YfR3xJ093roH2P4=
X-Received: by 2002:a05:6102:5091:b0:467:e34a:e8d0 with SMTP id
 bl17-20020a056102509100b00467e34ae8d0mr1169324vsb.2.1704907712294; Wed, 10
 Jan 2024 09:28:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110012640.1335694-1-kevinloughlin@google.com> <20240110133657.vbpzplchgaim3bya@box>
In-Reply-To: <20240110133657.vbpzplchgaim3bya@box>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Wed, 10 Jan 2024 09:28:21 -0800
Message-ID: <CAGdbjmK3oTE=3PizXrvux2XT1GLMPp=Fto-2ySfSf_Em4Tjnsw@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/sev: x86/sev: enforce PC-relative addressing in clang
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Kees Cook <keescook@chromium.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ze Gao <zegao2021@gmail.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Pengfei Xu <pengfei.xu@intel.com>, 
	Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-coco@lists.linux.dev, Adam Dunlap <acdunlap@google.com>, 
	Peter Gonda <pgonda@google.com>, Jacob Xu <jacobhxu@google.com>, 
	Sidharth Telang <sidtelang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 5:37=E2=80=AFAM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Similar issues was fixed before with fixup_pointer() tricks. Have you
> tried looking this direction.
>
> Relevant thread starting with:
>
> https://lore.kernel.org/all/20210920192341.maue7db4lcbdn46x@box.shutemov.=
name

Yes, I considered using `fixup_pointer()` as well, and I agree that it
remains a valid option to solve this problem. I just now mentioned the
primary downside to using `fixup_pointer()` in my response to Andi
(https://lore.kernel.org/lkml/CAGdbjmJcQeLWroBkbRC-cFQ6OuMHONsGLzpUrrA5k3uc=
8Rzkmw@mail.gmail.com/).
Namely, we would have to pass around `physaddr` from `__startup64()`
to any functions wanting to use `fixup_pointer()`). However, we should
be able to get around needing `physaddr` by using something like the
`GET_RIP_RELATIVE_PTR()` macro that I proposed in the same reply
(forthcoming in v2 of this RFC PATCH).

