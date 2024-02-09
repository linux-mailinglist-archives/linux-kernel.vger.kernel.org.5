Return-Path: <linux-kernel+bounces-59654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B8D84F9EC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47AB81C26F24
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F154612C548;
	Fri,  9 Feb 2024 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="BL6pVXWe"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B471F12A146
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496885; cv=none; b=L4bYT2vIM0qfpl6SVfaMIPCmXXfP8cJKjwLjGjgPlMpCRgFkwWh06b/h5lWLf18CUs3Jk/ZfikUQJ9ql/MZOzhaa4FPjFkzAFhZfVhemXTYxk7XW5UihixQ5aSLx7Vi4YBf+Kxpqng+GVm/tTkV+X0gRSrW6jzuauUTAcTwUt+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496885; c=relaxed/simple;
	bh=cWBreh1uuEEiqOpLgDlhEs12/LVS9j+zXzKJbO/pwK4=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=PFpCveHzsIHcp0fRq6r/KGYeGwly7027jkQ066ho4btklmLVtkpqrg5k3Cz6JGdQSKXlxINidlTYyLOW7wm9Vt/d8m/QjNHwjgtzwRZSx5qnF198LRbmROrBhBIy+n2YXJKptApm49VAVAZI5Wgv3l9+bO3zXQoe7MwP/NVsXAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=BL6pVXWe; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e08dd0fa0bso522674b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1707496880; x=1708101680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2zcUgQutS3DlGmwc5sEu07E2yjamp4+tUNWDaLkXDGg=;
        b=BL6pVXWeOhXRvpwBrQKaiO1OO8eDuYdJdqJRcabv3PUfPOpZZ5g6EEnokfmExc/d+U
         vXyAFSkKG3/NO2zmk4kyMah3m2zHB57kYeSyiDOEcHrz6DUJZ3QOOrLpD2tCQiYostDT
         IlPJ+tbgPSg89asUdInOXIs8+bR/lnRl8a2icOn0awiI7eG6RCnCt8qkGyIJtBSP2Rnv
         UhU2vqA0+7kgZ7CI4Gx42sJVlcr5eDYbJfThMzxqB4xFSZOENO/m/2QniyuKV/F3S3IB
         mhFqksFSitXAY/bxDnZTeM2Odoe2oZeip0cGuEgJP+XzJIdGSXvIVFfiJTGSn0gQ72/n
         o+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496880; x=1708101680;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zcUgQutS3DlGmwc5sEu07E2yjamp4+tUNWDaLkXDGg=;
        b=kZZEZJkqZu9KiZLPJIrgD8/Wx4jG1/YJm541//eCRlgnVinF02WRsXE1q3/R3XYFnX
         iQd2q3oW05ToTNa9KQJiqHfWiad9AOrPpd9m6squOJbZ0qgsiSHYvTjBoVZkH7BT0UoM
         qJxumZP1iT7tM5nYyIn9mtT1LbLJjBpXvlOAY94VkEg3oIRfBX67IxXkfzW0bXLAxq/t
         ghlzm2SpwuC9Fni7qqeSYtDJNShWRuBMUNhu5XzvaF3Cqv75FsJETZ94pcHr2SgOJN6e
         kiEi26TEI7maDdq10aCk4Sp/ObUOgxhb2+rsvEApUVlyPugbVhFV5wGWR2p98CwMThdg
         UirQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgjeHS8SXvgrx1i/ENUoj53D+LPniG/OTIlSe/c4a6ORRLWYkmH8vgYRuKUg4RbQgtzmAVlYrU5lIPuQKHniKPm7qPcT3pk7lte5wZ
X-Gm-Message-State: AOJu0YwDuT1iyWMNNYoUf1CPdqFtu7p6nPAp634lKAoPIaYOGvQU3WG8
	paI5A0yWm7GEPSjQDBmYUY5nFSqzMsKJhcFzbXT4ya1vbCSL1ifeVJB+ciuCkfM=
X-Google-Smtp-Source: AGHT+IH138In2qxnUDyUf5L0gXNV1VbXHmjJHEtnKql2S7mQ4A7aMyRWwAcBnM47BI7S/82MALke/A==
X-Received: by 2002:a05:6a00:2d90:b0:6e0:4030:ef77 with SMTP id fb16-20020a056a002d9000b006e04030ef77mr2136298pfb.16.1707496879549;
        Fri, 09 Feb 2024 08:41:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW6wu/Bha+p2xiJadb32Pu5nECmFu1bSMq78Yus+Wy9UGejr+P/rAkvSaYFYJpd4eKOMUDwtlXR5p89UC6jkt7GzbRaB16LaAfJvdZA5qsJOFcMQrqMzs/8q3+2FOkBiC2owQCZL1+Z5jjNK6+JZfuehN3+7w9pRTq1NIPmfjiU0jmf6RUsN1XH/GUA125keZ5AVyaEH/JZTQJEzNlNvzc/DzGDYa/D3+APhpCn3IhlaWxIwdc=
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id y2-20020aa78542000000b006e096ff7c91sm728258pfn.100.2024.02.09.08.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:41:18 -0800 (PST)
Date: Fri, 09 Feb 2024 08:41:18 -0800 (PST)
X-Google-Original-Date: Fri, 09 Feb 2024 08:41:15 PST (-0800)
Subject:     Re: [PATCH] riscv: Fix wrong size passed to local_flush_tlb_range_asid()
In-Reply-To: <ZbsT16CvwSDXtlAL@snowbird>
CC: alexghiti@rivosinc.com, Paul Walmsley <paul.walmsley@sifive.com>,
  aou@eecs.berkeley.edu, geert@linux-m68k.org, linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: dennis@kernel.org
Message-ID: <mhng-df0a3f10-0713-440c-81c4-a47f22fb367a@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 31 Jan 2024 19:45:27 PST (-0800), dennis@kernel.org wrote:
> Hi Palmer,
>
> On Wed, Jan 31, 2024 at 12:34:40PM -0800, Palmer Dabbelt wrote:
>> On Mon, 29 Jan 2024 01:01:00 PST (-0800), dennis@kernel.org wrote:
>> > Hi Alexandre,
>> >
>> > On Tue, Jan 23, 2024 at 02:27:30PM +0100, Alexandre Ghiti wrote:
>> > > local_flush_tlb_range_asid() takes the size as argument, not the end of
>> > > the range to flush, so fix this by computing the size from the end and
>> > > the start of the range.
>> > >
>> > > Fixes: 7a92fc8b4d20 ("mm: Introduce flush_cache_vmap_early()")
>> > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> > > ---
>> > >  arch/riscv/mm/tlbflush.c | 2 +-
>> > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > >
>> > > diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
>> > > index 8d12b26f5ac3..9619965f6501 100644
>> > > --- a/arch/riscv/mm/tlbflush.c
>> > > +++ b/arch/riscv/mm/tlbflush.c
>> > > @@ -68,7 +68,7 @@ static inline void local_flush_tlb_range_asid(unsigned long start,
>> > >
>> > >  void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
>> > >  {
>> > > -	local_flush_tlb_range_asid(start, end, PAGE_SIZE, FLUSH_TLB_NO_ASID);
>> > > +	local_flush_tlb_range_asid(start, end - start, PAGE_SIZE, FLUSH_TLB_NO_ASID);
>> > >  }
>> > >
>> > >  static void __ipi_flush_tlb_all(void *info)
>> > > --
>> > > 2.39.2
>> > >
>> >
>> > Sorry for the delay, I just pulled this into percpu#for-6.8-fixes. I'll
>> > send it to Linus this week.
>>
>> Do you mind if we do a shared tag or something?  It's going to conflict with
>> https://lore.kernel.org/all/20240117140333.2479667-1-vincent.chen@sifive.com/
>> .  No big deal as it's a pretty trivial conflict, but they'll both need
>> stable backports.
>
> This alone won't need a stable backport, I merged the bug as part of
> enabling the percpu page allocator in the recent 6.8 merge window.
>
> That being said, this is the only patch I'm carrying for v6.8. I'm happy
> to drop it and have you pick it up instead. Saves me a tag and a PR.
> Lmk if that works for you.

Sorry I missed this, but that seems like the easiest way to go here -- 
the other patch fixes the same bug (and another one), so I think we're 
safe with just that (which I'm sending to Linus as part of my rc4 fixes 
now-ish, as I'd need to anyway).  It's d9807d60c145 ("riscv: mm: execute 
local TLB flush after populating vmemmap"), in case anyone's looking 
later...

