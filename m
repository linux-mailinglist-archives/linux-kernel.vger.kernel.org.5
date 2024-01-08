Return-Path: <linux-kernel+bounces-19304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC811826B1E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BAEDB213DA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25CF13AEE;
	Mon,  8 Jan 2024 09:56:53 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912B013ADC
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5e784ce9bb8so11527917b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 01:56:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704707810; x=1705312610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6zcoW9ZBE4FkJfB/Sgrd9ilZjNAT7x2Y69neKzMmhA=;
        b=kdjgjS6+HSOTt9xRmE7TUF+tERvCJdqDwSjdW5pvTfw+IfRUiRMnrzifGRqF8rAwcb
         i8FJFXXwHPDq4mX7/TzAiYSne5Oy6Qv9MbykRnqUdabndbEdtnZsAeZL3cIPhRIlLL9a
         iYJQkPtJmxAIKCG1jhM0b6Y4rfiu/fGnZkJJpWQOWriIpVKGN+oiT1rr4IEkCl8lz/vB
         JFnpNc3gvCgfDRFDCE0bptr69UwaWFGpnqjW5q6h59tFJcK92kUAd+/mgwzcX3Gd2NXa
         6OGYuM8cGsETC8B1t3rxjJFUuXn+bpFPGrC7LItdVZL9VeKazDE+GJ1BV5u2j5ezXnD0
         hLiw==
X-Gm-Message-State: AOJu0YyJQEKqf1qfzAGdSaecXv6vOTOFR25hHrdZ/dWubNQczfpl/kHk
	kkbV8Mn/1+HlqDAHLlF0KnFajzMfIdzawQ==
X-Google-Smtp-Source: AGHT+IHukKkVDiD1MPY+xD0gKvnusGmcjOFCC4BVFlSezENa+O9ljWw9vPggKtKVe6gXkF0DjHMzeg==
X-Received: by 2002:a0d:d3c6:0:b0:5e7:7811:84e9 with SMTP id v189-20020a0dd3c6000000b005e7781184e9mr2028063ywd.35.1704707810430;
        Mon, 08 Jan 2024 01:56:50 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id j3-20020a816e03000000b005e8f5b53d6bsm3027021ywc.22.2024.01.08.01.56.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 01:56:50 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dbdd61d80a3so1144904276.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 01:56:49 -0800 (PST)
X-Received: by 2002:a25:7ec7:0:b0:dbd:726a:21f0 with SMTP id
 z190-20020a257ec7000000b00dbd726a21f0mr1894139ybc.16.1704707809104; Mon, 08
 Jan 2024 01:56:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108093221.1477020-1-daniel@0x0f.com> <20240108093221.1477020-3-daniel@0x0f.com>
In-Reply-To: <20240108093221.1477020-3-daniel@0x0f.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 8 Jan 2024 10:56:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX44A6+BNByuvbCC2gcM5vAipbaGAK7L8Vh8q3tMynBbQ@mail.gmail.com>
Message-ID: <CAMuHMdX44A6+BNByuvbCC2gcM5vAipbaGAK7L8Vh8q3tMynBbQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] m68k: Fix interrupt stack frames for 68000
To: Daniel Palmer <daniel@0x0f.com>
Cc: gerg@linux-m68k.org, fthain@linux-m68k.org, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

Thanks for your patch!

On Mon, Jan 8, 2024 at 10:32=E2=80=AFAM Daniel Palmer <daniel@0x0f.com> wro=
te:
> The plain old 68000 does not push the frame type/vector on the
> stack when an interrupt starts like the brand new 68010 does.

;-)

> This means that currently everything in struct pt_regs is
> a bit off because it expects the processor to push an extra
> short before the kernel interrupt code adds the rest.
>
> In entry.S for the 68000 we already need to manually put
> the vector number on the stack to work out what interrupt
> is being handled because the cpu doesn't push that to the
> stack.
>
> So we can jiggle this around a bit to fix the issue:
> - For 68000 use the same struct pt_regs layout as coldfire
>   where frame/vector is after pc and sp.
> - In entry.S push the vector number first, the stack pointer
>   now lines up with the sktadj field in pt_regs and when saving
>   the remaining registers the offsets match the fields in the
>   struct.
> - Remove the vec argument from the DragonBall interrupt
>   decoding logic as it's not pushed on the stack anymore
>   and not used either way.
>
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>

> --- a/arch/m68k/include/uapi/asm/ptrace.h
> +++ b/arch/m68k/include/uapi/asm/ptrace.h
> @@ -39,7 +39,7 @@ struct pt_regs {
>    long     d0;
>    long     orig_d0;
>    long     stkadj;
> -#ifdef CONFIG_COLDFIRE
> +#if defined(CONFIG_COLDFIRE) || defined(CONFIG_M68000)
>    unsigned format :  4; /* frame format specifier */
>    unsigned vector : 12; /* vector offset */
>    unsigned short sr;

I think it would be better to use the classic m68k stack frame.
That would pave the way for building a single nommu kernel for
MC680[012346]0 that runs on e.g. any Amiga.
MC68000 and Coldfire are incompatible anyway.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

