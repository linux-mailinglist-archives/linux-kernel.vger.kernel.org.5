Return-Path: <linux-kernel+bounces-109790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAEE8855BD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E239BB21117
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B2A13AE8;
	Thu, 21 Mar 2024 08:32:51 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC5CC8FF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711009971; cv=none; b=acZ2s6J9SUa7oCp+r3DPiC48Awf44hDkIjdC4rIzjA18NO/dyoH3TNLi2+9YG4+VhLnspy5Pwh3zGjJ37Pnpq5otFJKlShU1mewU28pWgYdWLjoLfFc/ADNN05uZL862TmGcRjaaLPsEAz0Veir0PB5ZNcqvcrsJxvlkuirp9CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711009971; c=relaxed/simple;
	bh=2SeI0KLkQK8keeZfc3uwhguEk/P0UYOP26RJRbCSQS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMpNyBdCw78otFYTtKhCFEyRKWUbyu5GR7jpPESi0uJVeYNvlFDR+Gd7fUZqJ6zUh+yKBm3f0hViT+tDq3CFBWp/rHipnwtk//+mWQUWywnZu0d/ufuZghsJyNsJjoDsy6JskDu/6TegwmLoiSqI0X0bGfeo1TFv2OecAVJoGwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-60a0579a955so8297107b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 01:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711009967; x=1711614767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mUmrGrAX3Duzs64PPgK1QzuxSOry2pd/+ceHDEcKUU=;
        b=frIAE8CbB6ZMcJ8tVJdD/I6ZQHh4sARUg+ln0SHprONW9iukohr6MWvlyNW17tg3Tm
         CDqn6HG2+Yyh+N9WIvVtSkt7w4PjvcWMgAHnyIn5Ukl7ji+D7he8kWaSdakDfJrNrUmm
         wVryzk5bR55+Q7uCket5yh1gBDrN2+sUjX4bctSi7nhlWY6yr4pR+CyoJaE6v4a5rfX3
         9+h1hFvajLlJ44COeyrwtPxsJDA+4bTQaZ1perCs5WdLvkyoAsAbOF0g2gxQOjkLS0Ff
         vhnJjo7Q3+bBnnFZ5KetPjVwIrda2/UxF7f98Im7YuSSsqpE0xf6WUkIQZ+TdCh+L78d
         aXQA==
X-Forwarded-Encrypted: i=1; AJvYcCXWlwtG+36Hr9liyz60PqZGDh7vrtcvrvOGhP9PlEyRTPeK3MrcqQGACyHI4DXZu0ttijGU5jOcFDhKyX6DM8bd0/dV/wRv+dO2eyT8
X-Gm-Message-State: AOJu0Yw1uSrG4lTJE3l02rXwpkfS4nNDbKfefp+u1TpXDUIQ1v/RZiu6
	JcI1ffMoaa4EsIE7HBFqAeJvJSzmcHInDfyLCT1EP+Ig55XnlMkzWxVNPWta1/w=
X-Google-Smtp-Source: AGHT+IEKMj3f58w3s1PIvZTBLyljSXo3xqMxc0dEM3UpUtQTEmyiTOr5XG7zq+3LL6QS9ya5irwiFQ==
X-Received: by 2002:a05:6902:cb:b0:dcc:53c6:113a with SMTP id i11-20020a05690200cb00b00dcc53c6113amr6862004ybs.59.1711009966632;
        Thu, 21 Mar 2024 01:32:46 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id x76-20020a25ce4f000000b00dcd3e78d086sm3002612ybe.46.2024.03.21.01.32.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 01:32:45 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-60a0579a955so8296607b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 01:32:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW1yX2iJVqRfwHiDz3xMQMNePu9hE3nt2lF6SjD7pBBW5b4gYNYy6w2RLUkrlyuVgaH/pHzXKW6F1ydbINuAGn2xDI6ZN0OnEJRK3Le
X-Received: by 2002:a5b:ecc:0:b0:dc6:be64:cfd1 with SMTP id
 a12-20020a5b0ecc000000b00dc6be64cfd1mr7256066ybs.36.1711009965385; Thu, 21
 Mar 2024 01:32:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320180333.151043-1-arnd@kernel.org>
In-Reply-To: <20240320180333.151043-1-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 21 Mar 2024 09:32:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW41e+DSBKBgugTkjoLy6bXfji-KWmB_d9EstEv01eC6w@mail.gmail.com>
Message-ID: <CAMuHMdW41e+DSBKBgugTkjoLy6bXfji-KWmB_d9EstEv01eC6w@mail.gmail.com>
Subject: Re: [PATCH] powerpc: ps3: mark ps3_notification_device static for
 stack usage
To: Arnd Bergmann <arnd@kernel.org>
Cc: Geoff Levand <geoff@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nathan Chancellor <nathan@kernel.org>, Paul Mackerras <paulus@ozlabs.org>, 
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Arnd Bergmann <arnd@arndb.de>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Kevin Hao <haokexin@gmail.com>, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Wed, Mar 20, 2024 at 7:03=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The device is way too large to be on the stack, causing a warning for
> an allmodconfig build with clang:
>
> arch/powerpc/platforms/ps3/device-init.c:771:12: error: stack frame size =
(2064) exceeds limit (2048) in 'ps3_probe_thread' [-Werror,-Wframe-larger-t=
han]
>   771 | static int ps3_probe_thread(void *data)
>
> There is only a single thread that ever accesses this, so it's fine to
> make it static, which avoids the warning.
>
> Fixes: b4cb2941f855 ("[POWERPC] PS3: Use the HVs storage device notificat=
ion mechanism properly")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

> --- a/arch/powerpc/platforms/ps3/device-init.c
> +++ b/arch/powerpc/platforms/ps3/device-init.c
> @@ -770,7 +770,7 @@ static struct task_struct *probe_task;
>
>  static int ps3_probe_thread(void *data)
>  {
> -       struct ps3_notification_device dev;
> +       static struct ps3_notification_device dev;
>         int res;
>         unsigned int irq;
>         u64 lpar;

Making it static increases kernel size for everyone.  So I'd rather
allocate it dynamically. The thread already allocates a buffer, which
can be replaced at no cost by allocating a structure containing both
the ps3_notification_device and the buffer.

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

