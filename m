Return-Path: <linux-kernel+bounces-34875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3F28388A3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6152B236AC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AB856741;
	Tue, 23 Jan 2024 08:14:10 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9A255E76;
	Tue, 23 Jan 2024 08:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705997650; cv=none; b=DFyiscWFrJHFWlpqW55oglYH1qMGqy2KrgF5Xnj9vUv4VWQ0br8DlPVP5ckRDXO28JeSO3irvGwGPfgh12Opsb4Te+5ZdduwbX8dj9A2TK0dk2lMZ36B+amzriiea95xoW8vtN5Ek+E3tkdLb+HHtj708fKoykwhbLct6cxUzGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705997650; c=relaxed/simple;
	bh=nzuOFA+tLJ46VDzCzSWAXp7X7RWGYzJ+SUPa4Tl1kYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivTMmhc1+bniBpQ1U/xDED2kFL/JZJELe0sAhALsTMUUBKmUO4w403NCi1FKY2ll1Y8fPtRta4v6Z9OqU31gJxStE65yD/SS8z5O1CL4fn9F0ay6Vnb+aRPOReCfUuVSi3wvc72/bPlWlIE8vLUj0x+F8oR+M1tQ1ccSf82Yiig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5ffcb478512so15288837b3.0;
        Tue, 23 Jan 2024 00:14:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705997647; x=1706602447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfMZ1E3cUmfIUyRbJhcNUyxEYBNYe0N54hD1T9iqNv0=;
        b=CNVFEROJeOK1WxiYA+Af091RvGO7Plhk0Hcp7oZZLxlFjHqT292JTG4lYJcvhBUnLR
         FxBSzQl8ELS2/POFNxoCjMcVKHndbUHizjyTSA2gEozlcwtQNxck9G2ZkVmp2bJ/bAQi
         ZeQx9QL0VsvgQs3v7lLFgJMfU6wRLlZWO0I0iQawGbmIpAtXG/XqRu1Sll8qttTofMWw
         fJB+rHEIUzdjJBAWVc8JeFTs1TbsqQ6lTIH42LfHsNK8CIyurkA9WtL7jnIHgPi3Kyrj
         2Dm4g+htoIpUJ0Ciy2M9CAUSFVkEvcoS2+d+AW08/kSFV69IZebXi5w+NRxaKxWQ8MI2
         anVA==
X-Gm-Message-State: AOJu0YyiqxogbiAdAk3IBRvI5kkLAdwm4rwPT6n8pi0G3ov2n4J/TZ4P
	iruA0+BNNoFDGH7CVxfaM9Whwul+zjyVpX1Hh/jbhZ1iN1IZAHhDZG4yyEv74N0=
X-Google-Smtp-Source: AGHT+IGhLlXR7Pl7zlTS3Hz8Ao2MHFwPweaqQjs4H0Iez/XiocJAdKEBBQr0okBmKB16dopSG+RWmQ==
X-Received: by 2002:a81:484e:0:b0:5ff:7c9d:61f7 with SMTP id v75-20020a81484e000000b005ff7c9d61f7mr4975435ywa.38.1705997647109;
        Tue, 23 Jan 2024 00:14:07 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id q8-20020a815c08000000b005f75cf6281fsm10109462ywb.5.2024.01.23.00.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 00:14:06 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5ffcb478512so15288737b3.0;
        Tue, 23 Jan 2024 00:14:06 -0800 (PST)
X-Received: by 2002:a81:6dd7:0:b0:5ff:9175:b102 with SMTP id
 i206-20020a816dd7000000b005ff9175b102mr4257992ywc.25.1705997646645; Tue, 23
 Jan 2024 00:14:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122235208.work.748-kees@kernel.org> <20240123002814.1396804-27-keescook@chromium.org>
In-Reply-To: <20240123002814.1396804-27-keescook@chromium.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Jan 2024 09:13:55 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWa9tXQRHkkX-W+5n8kuCvEFZdsfStPtYGA0MZpTGX79Q@mail.gmail.com>
Message-ID: <CAMuHMdWa9tXQRHkkX-W+5n8kuCvEFZdsfStPtYGA0MZpTGX79Q@mail.gmail.com>
Subject: Re: [PATCH 27/82] m68k: Refactor intentional wrap-around calculation
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Liam Howlett <liam.howlett@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Hugh Dickins <hughd@google.com>, linux-m68k@lists.linux-m68k.org, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kees,

On Tue, Jan 23, 2024 at 1:35=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
> In an effort to separate intentional arithmetic wrap-around from
> unexpected wrap-around, we need to refactor places that depend on this
> kind of math. One of the most common code patterns of this is:
>
>         VAR + value < VAR
>
> Notably, this is considered "undefined behavior" for signed and pointer
> types, which the kernel works around by using the -fno-strict-overflow
> option in the build[1] (which used to just be -fwrapv). Regardless, we
> want to get the kernel source to the position where we can meaningfully
> instrument arithmetic wrap-around conditions and catch them when they
> are unexpected, regardless of whether they are signed[2], unsigned[3],
> or pointer[4] types.
>
> Refactor open-coded unsigned wrap-around addition test to use
> check_add_overflow(), retaining the result for later usage (which removes
> the redundant open-coded addition). This paves the way to enabling the
> unsigned wrap-around sanitizer[2] in the future.
>
> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f185365=
94 [1]
> Link: https://github.com/KSPP/linux/issues/26 [2]
> Link: https://github.com/KSPP/linux/issues/27 [3]
> Link: https://github.com/KSPP/linux/issues/344 [4]
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Liam Howlett <liam.howlett@oracle.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: linux-m68k@lists.linux-m68k.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks for your patch!

> --- a/arch/m68k/kernel/sys_m68k.c
> +++ b/arch/m68k/kernel/sys_m68k.c
> @@ -391,10 +391,11 @@ sys_cacheflush (unsigned long addr, int scope, int =
cache, unsigned long len)
>
>                 mmap_read_lock(current->mm);
>         } else {
> +               unsigned long sum;

"sum" sounds like this is a dummy variable, to please the third
parameter of check_add_overflow()...

>                 struct vm_area_struct *vma;
>
>                 /* Check for overflow.  */

I agree with Liam: please drop the comment.

> -               if (addr + len < addr)
> +               if (check_add_overflow(addr, len, &sum))
>                         goto out;
>
>                 /*
> @@ -403,7 +404,7 @@ sys_cacheflush (unsigned long addr, int scope, int ca=
che, unsigned long len)
>                  */
>                 mmap_read_lock(current->mm);
>                 vma =3D vma_lookup(current->mm, addr);
> -               if (!vma || addr + len > vma->vm_end)
> +               if (!vma || sum > vma->vm_end)

.. Oh, it is actually used. What about renaming it to "end" instead?

>                         goto out_unlock;
>         }

With the above fixed:

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

If you want me to take this through the m68k tree (for v6.9), please
let me know.
Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

