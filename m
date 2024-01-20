Return-Path: <linux-kernel+bounces-31701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C3C8332AB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 04:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5F771F22789
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 03:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C533111E;
	Sat, 20 Jan 2024 03:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="H1VG32Jh"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D0410E1
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 03:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705723165; cv=none; b=puQoDcqTCTXuE3AyynHtEx5CjSvDCa64KsEllYY0x6ovNkYYQfUzCis/LHgWDcwBNf7lN5Hj309N4tup1ggaaoKYGKwKUZme33ukmNAYfE5m77MLNRHRKRrJlpfINScsVWO9/dP0y76LUlH5LUncvW6YWT4oJITvqQ0W9gMsmOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705723165; c=relaxed/simple;
	bh=owW4MPVe7RBYKQzYe4QKg/APdDGIG9NhmwHwHuaMnNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AjZSojIUd/WA5OfOeILQi1qLje/oybIqOtHooojUpqVc/s0gXqQDZZ0h7ihOVP++E6kPahWoegyYowaCiPMCQYkodXx7tPbBf9yCfaIIUhJr3z+OH7Mbx8N7w5rfAY25SdBw15N8Z0wa6x5cCY4y1sM4t6xzaE0m3udEvFz46wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=H1VG32Jh; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3606ad581a5so7076335ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 19:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1705723163; x=1706327963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUdj33zU6WPp9NMXR1jDLao5OoMg89mIJNooFVUpnh0=;
        b=H1VG32JhcxkcCTJVlDDHMs8zWauAyUFM5l2cmKm1D8qnQ9uYbbgMjvQ/cEKGfQcAn0
         mhOFjZhBDchoMOl4eddIZpRn6I7feHBEgFoG7jD9jtGKpqN9LG6R42M+X/yViAiXNj8a
         n41Y2PFH9GITwYHfarPi+9gdIsLMJIVfBn1vH/brQTknm137GyzMcBuG3bOzdYmmqNKL
         eR9a8By/clLSQ7jwCwtH/29ohe0BC978zCek2d3S/PPKqmzYryofs7vOxzib/bEtl1nB
         XnfDdDqm9CuNRgstAoRkZzvQd9ykTbPVIxLD3RIGn+0mJjQWqNQ/sfgUGJkRaka6q7Rl
         g1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705723163; x=1706327963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUdj33zU6WPp9NMXR1jDLao5OoMg89mIJNooFVUpnh0=;
        b=Y7Tm8wvDMg/Em8/vyk1WB8yLDXP/bjwrz6a9/8KJZ1ktVl89WxIKvxE41FshEawQpp
         kl6UtTUvE7MSfo/7BRUff8fSO+TIfPGrtWnai9Pfu3+GpAnUUarocZd/zoTDe7BBJOZ+
         YzcoNOaEQx3zx6ygp5wKeSj/BR5b2l2pP/PwcoxjxK1W3WL0ORXGjnaFcl+nbLQs6w+j
         7H6X35hJxIRAer7pHCg6qVIcRRKavA1eYH1XljlSLy+ju96EjJ4BBqPlP2YxouBf/uxC
         HcYomU28swVH5MuBkiwPeYkAYzX/4sFvzZz3Hu9sviNkqZ6YmZctC3+RZSMYfPCh0tqz
         AsvA==
X-Gm-Message-State: AOJu0Yw29rO1yNQtxCyv3bX8rUEf7GPsUWCZQGReqpJz304OZfJGnMTP
	AcEkvDFtI7a4DRqnOd1Ia+w8YmVQ5fOJR219iMK9j+Q0L7+lRWgt4PhJJI7qx8icbbV7Ba3a/SX
	sgP+bHoqd0XtMDlpOUHQehpck/DC/HLQY8c0bfw==
X-Google-Smtp-Source: AGHT+IE/vAYx8mnNdDKMAblUXSdltL/8n5TCQTrCXmLC8zaNaqz1vAs/Oe/IS8XQjJqKfiNn3hNoFDPDJZHtazYV8Ls=
X-Received: by 2002:a92:b70a:0:b0:360:7190:f895 with SMTP id
 k10-20020a92b70a000000b003607190f895mr854939ili.52.1705723162955; Fri, 19 Jan
 2024 19:59:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119224404.26695-2-palmer@rivosinc.com>
In-Reply-To: <20240119224404.26695-2-palmer@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 20 Jan 2024 09:29:11 +0530
Message-ID: <CAAhSdy0naZf8aKkAH6MgYyLior3rZEjx0WWWgp4Ljakrb5q5XQ@mail.gmail.com>
Subject: Re: [PATCH v2] tty: hvc: Fix the RISC-V SBI driver for a refactoring
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Greg KH <gregkh@linuxfoundation.org>, 
	jirislaby@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu, ajones@ventanamicro.com, 
	apatel@ventanamicro.com, Atish Patra <atishp@rivosinc.com>, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 20, 2024 at 4:15=E2=80=AFAM Palmer Dabbelt <palmer@rivosinc.com=
> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> I missed the int->size_t refactoring in f32fcbedbe92 ("tty: hvc: convert
> to u8 and size_t"), which causes the newly used ops in 88ead68e764c
> ("tty: Add SBI debug console support to HVC SBI driver") to fail to
> build due to a
>
> linux/drivers/tty/hvc/hvc_riscv_sbi.c:59:15: error: incompatible function=
 pointer types initializing 'ssize_t (*)(uint32_t, const u8 *, size_t)' (ak=
a 'long (*)(unsigned int, const unsigned char *, unsigned long)') with an e=
xpression of type 'int (uint32_t, const char *, int)' (aka 'int (unsigned i=
nt, const char *, int)') [-Wincompatible-function-pointer-types]
>         .put_chars =3D hvc_sbi_dbcn_tty_put,
>
> Fixes: f32fcbedbe92 ("tty: hvc: convert to u8 and size_t")
> Fixes: 88ead68e764c ("tty: Add SBI debug console support to HVC SBI drive=
r")
> Link: https://lore.kernel.org/r/20240119215612.20529-2-palmer@rivosinc.co=
m
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> Changes since v1 <20240119215612.20529-2-palmer@rivosinc.com>:
> * Fix the return and arguments correctly.
> * Also fix the hvc_sbi_dbcn_tty_{get,put}().
> ---
>  drivers/tty/hvc/hvc_riscv_sbi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tty/hvc/hvc_riscv_sbi.c b/drivers/tty/hvc/hvc_riscv_=
sbi.c
> index 2f3571f17ecd..f8cd3310ef35 100644
> --- a/drivers/tty/hvc/hvc_riscv_sbi.c
> +++ b/drivers/tty/hvc/hvc_riscv_sbi.c
> @@ -15,7 +15,7 @@
>
>  #include "hvc_console.h"
>
> -static int hvc_sbi_tty_put(uint32_t vtermno, const char *buf, int count)
> +static ssize_t hvc_sbi_tty_put(uint32_t vtermno, const u8 *buf, size_t c=
ount)
>  {
>         int i;
>
> @@ -25,7 +25,7 @@ static int hvc_sbi_tty_put(uint32_t vtermno, const char=
 *buf, int count)
>         return i;
>  }
>
> -static int hvc_sbi_tty_get(uint32_t vtermno, char *buf, int count)
> +static ssize_t hvc_sbi_tty_get(uint32_t vtermno, u8 *buf, size_t count)

The hvc_sbi_tty_put() and hvc_sbi_tty_get() functions are already
updated in Linus's tree. We only need to fix hvc_sbi_dbcn_tty_put()
and hvc_sbi_dbcn_tty_get()

Please rebase this fix upon Linux-6.8-rc1 whenever that is available.

>  {
>         int i, c;
>
> @@ -44,12 +44,12 @@ static const struct hv_ops hvc_sbi_v01_ops =3D {
>         .put_chars =3D hvc_sbi_tty_put,
>  };
>
> -static int hvc_sbi_dbcn_tty_put(uint32_t vtermno, const char *buf, int c=
ount)
> +static ssize_t hvc_sbi_dbcn_tty_put(uint32_t vtermno, const u8 *buf, siz=
e_t count)
>  {
>         return sbi_debug_console_write(buf, count);
>  }
>
> -static int hvc_sbi_dbcn_tty_get(uint32_t vtermno, char *buf, int count)
> +static ssize_t hvc_sbi_dbcn_tty_get(uint32_t vtermno, u8 *buf, size_t co=
unt)
>  {
>         return sbi_debug_console_read(buf, count);
>  }
> --
> 2.43.0
>
>

Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

