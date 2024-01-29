Return-Path: <linux-kernel+bounces-42402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE7B8400DE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392562819A4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9894354F82;
	Mon, 29 Jan 2024 09:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="o0KVvwiI"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E9C55761
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706519070; cv=none; b=e5B7WlWORm+X0Q7lxKWRIdgn1HzALUx4t17d4nyUaFX4UTyHmc17dnuqErVm3eFwNpcDS/y4uS11vpACIV+peVSWWUqJG7n2f7tLlPa8VyvTJQ7vp0r5BAAZl2NO9D7sG7Om/pfsOlEcbM0xkgOdJCUMszG80hi12WBidN8ftLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706519070; c=relaxed/simple;
	bh=ksF4ZWil8K2mr+5dzsAVbWuBapkyv+wm9DHTkXKrfiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TbP4CKtBo4SHegSHpqAw5r+XoDh1OMGl6+woLY+bOrUqfDfHSfL477md9lOn5Xfow+1A53wQsvfUv5+Ye4GLTWdblRBd+Z2JASLye7L2q2xKyeEy5uX1FR3VQzGutfUGk9XSzzbDhSA431BXA7PFV5tq8zITSW3M9wP+SfaicuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=o0KVvwiI; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a28a6cef709so286584966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 01:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706519067; x=1707123867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmg3Hmk9zJNrE7hya32tHVBXLNynM4oyDoMxztwJS0A=;
        b=o0KVvwiIKTYzokLmADSAACt9L+wjhsc+Zp/P9rnFP6Tr1BrQwmEoGyYok0xrsYgKeh
         V5wMQKrFNlcQAaeT5tu7f369v5dww7WEFPKIEDVYcGNngvFgDmc4Hye+bTekaMjvSJkd
         Mc4+6tsNJy/WFn+m6upMvVBumOn7F4ZsIw9ZjCLBP26BUPbw8CZuMFv7tTeiMExrmriH
         KT+IHu+TXoupHdvj5IFpCCQHOwmLac/0hMRIOy00MnN4D4iqXABM2baUL89JRt0fJ1Nu
         5JaLM8uAFRqLeCRV6lgOu0QZUsBhL/+Oqs3a3yAsKHpwFrVu6Wwppgra60SoqxYfGnSL
         y4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706519067; x=1707123867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmg3Hmk9zJNrE7hya32tHVBXLNynM4oyDoMxztwJS0A=;
        b=JWBGDkYEjLZcKrb3w1ctotgYgOQMNy3ikHTtQCiCQPQd09ediTTyp3oqDeFiz7pznL
         /kAZrqHVJr6Sn2jerHFucDG1G1SXV6JQsEzVPpOaBHkjub/Vxj7nUpCAGf9I2jcZOnkH
         3yQVywRob0dQhIsyXmye0cSdejQlr1Aln8UN2hPIAK6DB06vCqiEIKX9+AOxBfxNejmc
         6poMxlcKLvbA+9Pn6ZpdjVZOobVakAtPdNxYJYd7C9Vy/d1940jYD1sLsrpZ80XuyVos
         nmnMv8ztsPQkBLNsWuWS6c3epEiqdhMOTUlVmQVZA5By4g9hA7WIa892/srby+fW9pBz
         ihcQ==
X-Gm-Message-State: AOJu0Yww+pcVMh/jpG+GOMiujZ/TqF/XzHh9hLUrQRZMYOYgmGlWgA4G
	f/HnJ08IBIf8BiDFblWwg9bEoZKG/D59MzlHgwVWd+wooI7rwu3kq9IhkEYosdhglFj7EyuoXz0
	kNMNRu1mkQtgJVtzak1jUlU4CuU//rZf1U+lJxA==
X-Google-Smtp-Source: AGHT+IFzvYufgRiNAVracHuQK2cLPonaFabFFL3fAz4Cpzxi0d4lWhEOTYTzLWAXVttGPvnGz4xbM9SbOoOM7XAfjvM=
X-Received: by 2002:a17:906:b204:b0:a35:ee97:7ca6 with SMTP id
 p4-20020a170906b20400b00a35ee977ca6mr224215ejz.24.1706519066861; Mon, 29 Jan
 2024 01:04:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123132730.2297719-1-alexghiti@rivosinc.com> <ZbdpTPMOw4lsPxBi@snowbird>
In-Reply-To: <ZbdpTPMOw4lsPxBi@snowbird>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Mon, 29 Jan 2024 10:04:16 +0100
Message-ID: <CAHVXubiwoB3jwGqNyKvoUB=73zU-w35c45CcaReD0vgTBxWKQA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fix wrong size passed to local_flush_tlb_range_asid()
To: Dennis Zhou <dennis@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 10:01=E2=80=AFAM Dennis Zhou <dennis@kernel.org> wr=
ote:
>
> Hi Alexandre,
>
> On Tue, Jan 23, 2024 at 02:27:30PM +0100, Alexandre Ghiti wrote:
> > local_flush_tlb_range_asid() takes the size as argument, not the end of
> > the range to flush, so fix this by computing the size from the end and
> > the start of the range.
> >
> > Fixes: 7a92fc8b4d20 ("mm: Introduce flush_cache_vmap_early()")
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  arch/riscv/mm/tlbflush.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> > index 8d12b26f5ac3..9619965f6501 100644
> > --- a/arch/riscv/mm/tlbflush.c
> > +++ b/arch/riscv/mm/tlbflush.c
> > @@ -68,7 +68,7 @@ static inline void local_flush_tlb_range_asid(unsigne=
d long start,
> >
> >  void local_flush_tlb_kernel_range(unsigned long start, unsigned long e=
nd)
> >  {
> > -     local_flush_tlb_range_asid(start, end, PAGE_SIZE, FLUSH_TLB_NO_AS=
ID);
> > +     local_flush_tlb_range_asid(start, end - start, PAGE_SIZE, FLUSH_T=
LB_NO_ASID);
> >  }
> >
> >  static void __ipi_flush_tlb_all(void *info)
> > --
> > 2.39.2
> >
>
> Sorry for the delay, I just pulled this into percpu#for-6.8-fixes. I'll
> send it to Linus this week.
>
> Thanks,
> Dennis

No problem, thanks!

Alex

