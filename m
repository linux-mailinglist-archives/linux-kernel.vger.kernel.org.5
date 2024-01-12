Return-Path: <linux-kernel+bounces-24971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8C182C56A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD6B2865F5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F45B2561D;
	Fri, 12 Jan 2024 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ax9IqFwR"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2201AAA6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 18:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7cbeaacbcb8so1763175241.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 10:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705084187; x=1705688987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1csma4A5U64O+REmW+zu6/PA7desA13VUuUwLGfC3Q=;
        b=ax9IqFwRO3QGLemyprcJ05Br5v2R+yrGerWiG19J92TsZdNQuurXSijiKvN9ogphaI
         smtnUS+zjFpWbjLUaEEf5gA5o78RtuQZPnG/w0/AfbQpBCYKFFEdLf79fSsEvW9Fp04q
         PGtrFWbH/mojmlAqcm58TMqBZULxH9wyvOUCSc7nw3t/2vLrlf0wEAwdT3W0jg3Vxc8U
         4O2YPY2qFUg/BiIZ99hY85O1MM58DJ71MLRbcR9yFpCJ6m8wXLHgsphrzIhcjmrrzcLX
         +r+8B9JqUC7PdkZ66apdV5F7bN+OWH9Nj7cNSSq7Y2ssb0DZ0DajOF/0cf9JcMpMJCxU
         xq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705084187; x=1705688987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1csma4A5U64O+REmW+zu6/PA7desA13VUuUwLGfC3Q=;
        b=WOBINi+GMsPhC47u4k6v3Ys3rhxWeb2pkFlltI/TYegXeEo1h2zGMLd2lBE+0Ygpzm
         V3rXMeLwJkPuFLRMZ/g+oR+Bx2zYB4FS+nOfe2gMVxrBFGkvyMkDWIj76i0b2rhhHCF6
         tHQHn50XMK3yyr/qFNbGMIajzo2Q6S9DHxey6ftHsIG4YXwqXmhkS+2EI3AI+ChLMhoX
         FpeTLyMzDJpNt7pJdLX2COaBcFL8PwNf9XQpip+lRlGu+x8W6ovaM9R02aQGK6LrB8h3
         7c72O+GKxxlcuj2m5iMthxoszgdOfOkVr7x14Xu5TyX7M4jLyuddM6bO1eL25dfiLWxZ
         RxPg==
X-Gm-Message-State: AOJu0Yzl2VLCBQFM17qVx57jitedHKZEcBzbGYDEtfZ4tWbYfRtSrG0E
	0G64TD2kM6Rvw8JY5m9CWEctIsRC5GNUYQoNaO/mCYmxIWab
X-Google-Smtp-Source: AGHT+IFbEsPC+6pQYmKgmUdqKvTP1jQV+FRoiuzD78v/fDaV2RhMwCdQ3K00zV5/Vj8TA9sq36+8X1YIL/ffox626bo=
X-Received: by 2002:a05:6122:3809:b0:4b6:f254:b234 with SMTP id
 em9-20020a056122380900b004b6f254b234mr1441346vkb.32.1705084187287; Fri, 12
 Jan 2024 10:29:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZ7YuEexYSaZYmLK@tassilo> <20240111223650.3502633-1-kevinloughlin@google.com>
 <20240112121725.3amxlumpifhagamb@box>
In-Reply-To: <20240112121725.3amxlumpifhagamb@box>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Fri, 12 Jan 2024 10:29:36 -0800
Message-ID: <CAGdbjmLeyPhYfjVHPRa8LgNYjt9-rOPiyCodHoQOkEh9iQhjBg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/sev: enforce RIP-relative accesses in early
 SEV/SME code
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Kelley <mikelley@microsoft.com>, 
	Pankaj Gupta <pankaj.gupta@amd.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Arnd Bergmann <arnd@arndb.de>, Steve Rutherford <srutherford@google.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Yuntao Wang <ytcoode@gmail.com>, 
	Wang Jinchao <wangjinchao@xfusion.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Brian Gerst <brgerst@gmail.com>, Hugh Dickins <hughd@google.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Joerg Roedel <jroedel@suse.de>, Randy Dunlap <rdunlap@infradead.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-coco@lists.linux.dev, Ashish Kalra <ashish.kalra@amd.com>, 
	Andi Kleen <ak@linux.intel.com>, Adam Dunlap <acdunlap@google.com>, 
	Peter Gonda <pgonda@google.com>, Jacob Xu <jacobhxu@google.com>, 
	Sidharth Telang <sidtelang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 4:17=E2=80=AFAM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Can we replace existing fixup_pointer() (and other fixup_*()) with the ne=
w
> thing? I don't think we need two confusing things for the same function.

Per my tests, yes we can; I replaced the fixup_*() functions with
GET_RIP_RELATIVE_PTR()/PTR_TO_RIP_RELATIVE_PTR(), and guests with and
without SEV, SEV-ES, and SEV-SNP all successfully booted under both
clang and gcc builds. I have a slight preference for sending that as a
separate follow-up commit, but please let me know if you feel
differently. Thanks.

> Also, is there any reason why GET_RIP_RELATIVE_PTR() and
> PTR_TO_RIP_RELATIVE_PTR() have to be macros? Inline functions would be
> cleaner.

I used macros because we need to use both the global variable itself
and the global variable's string name (obtained via #var in the macro)
in the inline assembly. As a secondary reason, the macro also avoids
the need to provide separate functions for each type of variable for
which we'd like to get RIP-relative pointers (ex: u64, unsigned int,
unsigned long, etc.).

