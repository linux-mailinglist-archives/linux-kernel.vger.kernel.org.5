Return-Path: <linux-kernel+bounces-66277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8945C8559A4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 05:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 139EF1F21D4F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 04:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BAE79DF;
	Thu, 15 Feb 2024 04:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Q7VPPD5b"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6B96FB8
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 04:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707970117; cv=none; b=exvXIdyKP4NrnMFXgbX0hxMz+2+VKVa5jjH6+Shj/oQoCHCm2Ym4T0lfjksC8LOO1NOyvEDNaJEQBce6w/Z5SeXE3GFaakFoMKEHB8ITNLOPZFBposedy9Qx1eKluDwUUex4EBIwosbQ6lbwakapjk5gpuR5BqWPghiG+Qn0E8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707970117; c=relaxed/simple;
	bh=fwzXfIHA+bu1X9LOY39v5VZJdIHAkdWY225oLPE/15U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XAUOdKC9cDwnDibxcF6K/rVbavltuZcIe6E19YzOK2m/fyuvU0HMEaUrEbftMc5VoR3cl87k9EvE9ucZgqSZwdghBTAupcjZn8p6t+CNzT/Y1hvfSlvG7UYb977sg+Qa4t3yuKYFIqDl0OrXmeX/wdu0LX9crVO+SWITXxizw/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Q7VPPD5b; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-607d590aeb5so828607b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 20:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707970114; x=1708574914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0w9vfO1nci3hMBG4zrvPfuevQJ+mISNB0ncXe9bAugI=;
        b=Q7VPPD5bLyRHnCjzI3SoqaQgDm3TZ33xFDOMkRUmyKXleogyg95hpdH31qno3U6K5v
         /Sn/ICL/UYtKHGBdEQDFDkRU1rDJdWOntm90M4m0/eBtMpup33HjPR6j6DCNMNCTuLMW
         eabduin5fYrIgikD6RTteiwb0daqKlKWiGDy3XOuqSkQd99kggtww7ThcmzzKkkJg+AN
         fZlLskq0uGIt0diDtUi6L1bfLYfx5LGYo/LdLFIgovTxt0cSb0chRAn3vxm+QEc370Oc
         XG+Ff0vjrXlKjXuhreULKXqyWcLBzpE9bWybodJVz8gbvdVDpfl5KjiRczfJ48DhgNy3
         61qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707970114; x=1708574914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0w9vfO1nci3hMBG4zrvPfuevQJ+mISNB0ncXe9bAugI=;
        b=MXhANl9y2mCXNm6Xaj19AauznD9YTMNf3kLb/kGja7oflA3k68YPgvtdMM8bktX9Mo
         muOVYjv2JfxmwolXselN7ut4u2V9QSA3e8R8A94YSshYbw/iG9Vq51M+u9D/BPxAzvWE
         CLsLonTqzId0hHjQzQ/Ar4DJO9YjeNPp9O9teuJpZIfTrGIQB3/1Ijw7OrHdT3V/Tc20
         USe1gQ19pty8HYA5ROec1kbrskd/KA0jBdoywUQb+oba5X/huj1uAE5C3Se+x+S93Ibi
         9i/iGfxrLt8vhy0mlx4Zipr7UH3vjgjX1ecm98mkvNHQhPYDSVkb408dWIn/BXvVKIn4
         7CKA==
X-Forwarded-Encrypted: i=1; AJvYcCUzl7c8yrdnlqmV6G7eoFZya1BDqlw2gWlZxdxIouVL3+252oxQt1q+lxPztY9SMx/wYFc3zuD7odKBvluKPQngXfGtt6D20k83AO3p
X-Gm-Message-State: AOJu0YzzkPnoxTUeAtES+w2smHE+VS7BBG8ZNWjfrCX0urXlkimtPzq9
	OnI4yJoS5O6XhmmBX+KzANxMPZb/3uIU4I1m8TpDaFknm9ndGJY6LPWM6J1ZU3L4nuTx7OMLiMT
	ILa7jrB8ITo/S6rYYRAhWwK6HKh66OW1FcDdLuw==
X-Google-Smtp-Source: AGHT+IGQkwmej07U+XAmfxLUrH424NdUQnxc8G0QlI2/oLIXmnVVGpvST/wk6u569F5Rlh1QrNy6M3o79kHgF1h9v2o=
X-Received: by 2002:a81:9a47:0:b0:607:57c5:41fc with SMTP id
 r68-20020a819a47000000b0060757c541fcmr704855ywg.15.1707970114147; Wed, 14 Feb
 2024 20:08:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203-clone3-shadow-stack-v5-0-322c69598e4b@kernel.org> <20240203-clone3-shadow-stack-v5-1-322c69598e4b@kernel.org>
In-Reply-To: <20240203-clone3-shadow-stack-v5-1-322c69598e4b@kernel.org>
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 14 Feb 2024 20:08:22 -0800
Message-ID: <CAKC1njQk7LajEMffAVMb76j6ndrixWyRgHf8XudSL-AzNn4s_g@mail.gmail.com>
Subject: Re: [PATCH RFT v5 1/7] Documentation: userspace-api: Add shadow stack
 API documentation
To: Mark Brown <broonie@kernel.org>
Cc: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, 
	"H.J. Lu" <hjl.tools@gmail.com>, Florian Weimer <fweimer@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Kees Cook <keescook@chromium.org>, jannh@google.com, linux-kselftest@vger.kernel.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 4:05=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> There are a number of architectures with shadow stack features which we a=
re
> presenting to userspace with as consistent an API as we can (though there
> are some architecture specifics). Especially given that there are some
> important considerations for userspace code interacting directly with the
> feature let's provide some documentation covering the common aspects.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  Documentation/userspace-api/index.rst        |  1 +
>  Documentation/userspace-api/shadow_stack.rst | 41 ++++++++++++++++++++++=
++++++
>  2 files changed, 42 insertions(+)
>
> diff --git a/Documentation/userspace-api/index.rst b/Documentation/usersp=
ace-api/index.rst
> index 09f61bd2ac2e..c142183d9c98 100644
> --- a/Documentation/userspace-api/index.rst
> +++ b/Documentation/userspace-api/index.rst
> @@ -27,6 +27,7 @@ place where this information is gathered.
>     iommufd
>     media/index
>     netlink/index
> +   shadow_stack
>     sysfs-platform_profile
>     vduse
>     futex2
> diff --git a/Documentation/userspace-api/shadow_stack.rst b/Documentation=
/userspace-api/shadow_stack.rst
> new file mode 100644
> index 000000000000..c6e5ab795b60
> --- /dev/null
> +++ b/Documentation/userspace-api/shadow_stack.rst
> @@ -0,0 +1,41 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Shadow Stacks
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Introduction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Several architectures have features which provide backward edge
> +control flow protection through a hardware maintained stack, only
> +writeable by userspace through very limited operations.  This feature
> +is referred to as shadow stacks on Linux, on x86 it is part of Intel
> +Control Enforcement Technology (CET), on arm64 it is Guarded Control
> +Stacks feature (FEAT_GCS) and for RISC-V it is the Zicfiss extension.
> +It is expected that this feature will normally be managed by the
> +system dynamic linker and libc in ways broadly transparent to
> +application code, this document covers interfaces and considerations
> +
> +
> +Enabling
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Shadow stacks default to disabled when a userspace process is
> +executed, they can be enabled for the current thread with a syscall:
> +
> + - For x86 the ARCH_SHSTK_ENABLE arch_prctl()
> +
> +It is expected that this will normally be done by the dynamic linker.
> +Any new threads created by a thread with shadow stacks enabled will
> +themsleves have shadow stacks enabled.
> +
> +
> +Enablement considerations
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +- Returning from the function that enables shadow stacks without first
> +  disabling them will cause a shadow stack exception.  This includes
> +  any syscall wrapper or other library functions, the syscall will need
> +  to be inlined.
> +- A lock feature allows userspace to prevent disabling of shadow stacks.
> +- This that change the stack context like longjmp() or use of ucontext
> +  changes on signal return will need support from libc.

For enabling considerations, it will be good to have some words on ss token=
s
too, probably along the following lines.

- Shadow stack tokens: During shadow stack switches (either by user mode
or kernel), to prevent inadvertent shadow stack pivoting, it is expected to=
 save
some predefined formatted token during shadow stack save operation and
validating the token during shadow stack restore operation.

>
> --
> 2.30.2
>

