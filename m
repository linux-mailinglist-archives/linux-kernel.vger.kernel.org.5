Return-Path: <linux-kernel+bounces-139542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4B68A0426
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6671F21BA5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3BE3F8F1;
	Wed, 10 Apr 2024 23:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b36XwsNV"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D31E2E40E;
	Wed, 10 Apr 2024 23:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712792501; cv=none; b=n0/oWu//gJZ5xZPJ9eX7AG9SUQXbb2Ro3emq9KYs27HX9Gm5aXZerYD7kNQApRPR1RHviQycNewAMy5S/KEURc7kFBZWj71MsOEzo2SdrN6TdnnBkfh4b2qQ+fjVM0jKs5oQRGpdSpETw1aHDIQYQb9ZudWMFUXCNDOw0KwO2Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712792501; c=relaxed/simple;
	bh=95cPUOZrv+Txpgf24vZ+Y7Z2qLuYyNsbkJU8CxFoBHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0v7S9tJgjFF/IbOZob6JeNYggNrbBOVWvjf10b5hJQjyLkPofBuLtECRPy+nX4vbjXUkA0HuePkkYhx/sTqEMN6Ftl+cFy/H6uohypcYuJ2WGQNwWX7T+xq8k9vSQ6itMbSaVXdeKbzZn9dSuhqciwcCrtZJyckNCXTxI0LRiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b36XwsNV; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so5828413a12.1;
        Wed, 10 Apr 2024 16:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712792499; x=1713397299; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CRij2JUKN+gXhnLbCfIi1jjMHZE4c+tbfwdebfMxESI=;
        b=b36XwsNVaJ+bnI0mS33rJzRUvInuSE6qVS6InWUlYWxRYSBpf9UkncudkTbJqhu2EM
         F6Ub4fPzwhaIZIK1mB6ZxSPPlExtlE26Aoxfu+dxm31vYM+q2O/89ZkbMwsMqgcbrh9B
         mAUwLQY27j4YjZSNQ8l8hfo538Q3lzI+cgc2l7xk7+WkBU95bO0ENQXr+7FgBTlZ29+3
         TjLWacYDSxrkSmNY72YT9iiFSYehnbgO3bdZSwKoxyxf1IlOh8q7l0q8KIJ4AxMBmBOZ
         G0EpCzW6d7vfVQLW9PbKLMuhemPdaH5YYQkU9tmCujS43/lfMn/FIOx8zaZI+qi01rzj
         cEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712792499; x=1713397299;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CRij2JUKN+gXhnLbCfIi1jjMHZE4c+tbfwdebfMxESI=;
        b=N1WDDquqQblbWmfYFHiaHK3Yx5csul3iVskJUjYgoLDoutGHTXtXwr3OKm84i5Ef4f
         QWDIcOyIMDUVpOPgxJSArUIoUD9vdzuY6+Kh/TKLSwjPI6nGHcSYiE2vooF3uzWDZG55
         qPV5KSr6a5pWNDrB4DucKUdsUoUl68UEPUUEGBw4OM1FYX2FykxSqeomfPVy00lIvV5S
         318g0m9J/XpmF7hhpacrKgPDpMlpadrTk2zkB2IH96QppRhfsePSgD69EJoSpUpCE3QI
         xHQ81XAa0jfz+DuvNORNTzBzUieWhwo/KpBZFwqTUdNiz4/SkoIS4RongR9Fh4F1AoiJ
         INtw==
X-Forwarded-Encrypted: i=1; AJvYcCVFu2DGh3PngRWwJ51OqTgJp2Pa2efPauIYAwOrKA0O5DDvOJIuQLKZNBkXkpbYLIFdrEyuTOgp7K4+7Q5o2IQKTWGvvTLyAs3CzFiAF8cyGxp7ckz9kEm17Wig8akSMP3dbzGKUC1LsKLV
X-Gm-Message-State: AOJu0Yw4dG8p7Wqsi3zdfVaSDya4hUvMJhUHM8CzAupKcnJT53i7PNfQ
	THfIpYMbwJcMmqh7KRIAsxLJTwImzBX4RCk8ZZlVVPDxxJvqdUvV+1GgxWEyYJwmyAsDmYfoL2z
	hoOQqvrUN7zLiJKJB4Twm46SKpnw=
X-Google-Smtp-Source: AGHT+IG36nkf0prGXlL9LwnBR5WCY/llcinzeEbi1COlc7nR2R7dJsXwAwOwy17E7g8JGa7+9MKMZ7VQ/n5W8XGksmQ=
X-Received: by 2002:a17:90a:d254:b0:2a2:3252:cb83 with SMTP id
 o20-20020a17090ad25400b002a23252cb83mr4123737pjw.38.1712792499294; Wed, 10
 Apr 2024 16:41:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411-as-instr-opt-wrussq-v1-1-99b1a1a99f93@gmail.com>
In-Reply-To: <20240411-as-instr-opt-wrussq-v1-1-99b1a1a99f93@gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Thu, 11 Apr 2024 00:41:27 +0100
Message-ID: <CAJwJo6aBbw96uo_eiDuKP5nX4EsoSYkEmaKjdMY01_Pc2z-1DA@mail.gmail.com>
Subject: Re: [PATCH] kbuild/x86: Use $(KBUILD_AFLAGS) in Kbuild's version of $(as-instr)
To: 0x7f454c46@gmail.com
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Please, ignore this version.

the previous one was to add a helper function and that seemed to work,
but on rework to actually use KBUILD_AFLAGS instead of adding a new
function I certainly haven't tested it enough.
Going to prepare version 2, sorry for the noise.

On Thu, 11 Apr 2024 at 00:24, Dmitry Safonov via B4 Relay
<devnull+0x7f454c46.gmail.com@kernel.org> wrote:
>
> From: Dmitry Safonov <0x7f454c46@gmail.com>
>
> At Arista some products use compatible 32-bit userspace running on x86.
> As a part of disto build for ia32 it also compiles the 64-bit kernel.
> While the toolchain for the kernel build is yet the same, with 64-bit gcc:
> > / @Bru-na-Boinne% file /usr/bin/gcc-11
> > /usr/bin/gcc-11: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=6571ad50d8f12eece053f1bac7a95a2c767f32c9, for GNU/Linux 3.2.0, stripped
>
> It seems that gcc is being smart and detects that it's running in
> a 32-bit container (personality flag? 32-bit mmap base? something else
> inherited post-exec?  haven't yet figured it out) and by default tries
> to build 32-bit binaries.
>
> That results in a failing toolchain check:
> > / @Bru-na-Boinne% printf "%b\n" "wrussq %rax, (%rbx)" | /usr/bin/gcc-11 -Wa,--fatal-warnings -c -x assembler-with-cpp -o /dev/null -
> > <stdin>: Assembler messages:
> > <stdin>:1: Error: `wrussq' is only supported in 64-bit mode
>
> Which passes when -m64 is directly specify for the build check:
> > / @Bru-na-Boinne% printf "%b\n" "wrussq %rax, (%rbx)" | /usr/bin/gcc-11 -m64 -Wa,--fatal-warnings -c -x assembler-with-cpp -o /dev/null -
> > / @Bru-na-Boinne% echo $?
> > 0
>
> As a result, kbuild produces different value for CONFIG_AS_WRUSS
> for native 64-bit containers and ia32 containers with 64-bit gcc,
> which produces different kernels with enabled/disabled
> CONFIG_X86_USER_SHADOW_STACK.
>
> arch/x86/Makefile already properly defines KBUILD_AFLAGS += -m64,
> which is luckly already available at the point of toolchain check
> in arch/x86/Kconfig.assembler
>
> By hacking around Kbuild variable the following way:
> > --- a/scripts/Kconfig.include
> > +++ b/scripts/Kconfig.include
> > @@ -13,7 +13,8 @@ left_paren  := (
> >
> >  # $(if-success,<command>,<then>,<else>)
> >  # Return <then> if <command> exits with 0, <else> otherwise.
> > -if-success = $(shell,{ $(1); } >/dev/null 2>&1 && echo "$(2)" || echo "$(3)")
> > +if-success = $(shell,echo '$(1)' 1>&2;{ $(1); } >/dev/null 2>&1 && echo "$(2)" || echo "$(3)")
>
> I got the following output for the toolchain check, before:
> > linux @Bru-na-Boinne% make ARCH=x86_64 oldconfig V=1 2>&1 | grep wrus
> > printf "%b\n" "wrussq %rax,(%rbx)" | gcc  -c -x assembler-with-cpp -o /dev/null -
>
> and after:
> > linux @Bru-na-Boinne% make ARCH=x86_64 oldconfig V=1 2>&1 | grep wrus
> > printf "%b\n" "wrussq %rax,(%rbx)" | gcc -D__ASSEMBLY__ -fno-PIE -m64 -c -x assembler-with-cpp -o /dev/null -
>
> Which seems appropriate to me.
> This also reflects the existing definition in scripts/Makefile.compiler
> for $(as-instr) that already has $(KBUILD_AFLAGS).
>
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
> ---
>  scripts/Kconfig.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
> index 3ee8ecfb8c04..d8574c1faf2d 100644
> --- a/scripts/Kconfig.include
> +++ b/scripts/Kconfig.include
> @@ -33,7 +33,7 @@ ld-option = $(success,$(LD) -v $(1))
>
>  # $(as-instr,<instr>)
>  # Return y if the assembler supports <instr>, n otherwise
> -as-instr = $(success,printf "%b\n" "$(1)" | $(CC) $(CLANG_FLAGS) -Wa$(comma)--fatal-warnings -c -x assembler-with-cpp -o /dev/null -)
> +as-instr = $(success,printf "%b\n" "$(1)" | $(CC) $(CLANG_FLAGS) $(KBUILD_AFLAGS) -Wa$(comma)--fatal-warnings -c -x assembler-with-cpp -o /dev/null -)
>
>  # check if $(CC) and $(LD) exist
>  $(error-if,$(failure,command -v $(CC)),C compiler '$(CC)' not found)
>
> ---
> base-commit: 2c71fdf02a95b3dd425b42f28fd47fb2b1d22702
> change-id: 20240410-as-instr-opt-wrussq-48ec37e36204
>
> Best regards,
> --
> Dmitry Safonov <0x7f454c46@gmail.com>
>
>

