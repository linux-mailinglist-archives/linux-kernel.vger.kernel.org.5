Return-Path: <linux-kernel+bounces-77311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB86586039C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569DD1F2718F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD58E6E60A;
	Thu, 22 Feb 2024 20:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="iZLE4fWJ"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7430514B81E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 20:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708633374; cv=none; b=abOlm0qQFMMwBPfrWdY8tlcUoFUcOxS9S++KF1b1q+ttZGPVtAqlngWFARKb4B3lAOEgF5fANoLyNkbT8NAhanLG+7qfoIDaGKCAvazSQQTDY1Dg8/51zP7VjvugBrGUVkbZbe7VWrBIGTsXKYR3yyGkiWsfYDLcYKC7C7tbJ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708633374; c=relaxed/simple;
	bh=URYTFp/fuRVeilL5jaYsFaoYbDFJQDSZAADpYUjI2vg=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=Z1/BocNoiVcQpTqG5wwUU/n/8qhEFzTYM8F6xO2GabYHrDi6mdOh6Q/BXa9cuwW56h97pr9dZP2myStXs0vScaFyIk4T39SgoDHE2eDptaL2jAP5FPxP9SbaXM9bzRVEo6jgRqUMSfaZ0WNFU6z2MLlLeinlnxfRjjdXRimNqdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=iZLE4fWJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc0d11d1b7so1900815ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1708633372; x=1709238172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AvT+skZuVtuaziWCz2kmemhaijwUBiIAPgW6NDDOZYI=;
        b=iZLE4fWJoxw+ADNTYgLoQuJBkiWWaD5tHxiXzoRt/BUcDXw3J5/HaJLpWyW7CJEg+k
         fI1N+YlUahifMbqoQyuH2SrfalD+Xx/6G4fpSt6eDoRlgdZ+v0Rocr0lIMfQB+ynJ2o3
         /odbgwLNZqpZwAl0Hmk9zjKgwJeAKLZYKVVlyslsCv0cZI0sVg3DkUUs4fdRjc+CO7pb
         WydXPZz7eUnuxvX1kWqP/3KVBULbXH62ctNBkq2TdbXXlnWTC1PARGGZZNbw87WUMvGX
         gQYZpT2Jwnk5ntpvW8jB2ANXyN75bD+aCeCEFOEbtU7EvET22In3KHqp6suyf+joNYrh
         OIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708633372; x=1709238172;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvT+skZuVtuaziWCz2kmemhaijwUBiIAPgW6NDDOZYI=;
        b=V8/3bpuwnNPeKGHt1mIhbk8OdlRpQrFOHdzwVQmVWPxdG/YSxAgJd1qS8mzLZGMH2R
         D4q51Yebd9Cb2MHW2DA6fBEMHTw5nI5dCqXXju9YCyP7/4nuGp3YTxnqjjC20xbtjugt
         mSkHO/+Bo51JrcVHRJGR1vJlMNrJ/oKxFfuhFoAlbxi+r+fkxSSnprGcKy1aCZZABmZc
         pnthQwIvOZoojAID/fUoAD+FOWPZvoRjx0TpbTYZLRTsJAUZZQKF6KFjZx4f4VltYLlH
         reHsK1vIOgxSMohY2uyxoIA9gQWD7G3BvEBmWw1zEqnx3vp/WNsX04X+bONyHqnq6SFt
         R0kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEdCOa7VNAkk7Ak1Krh3ZRxHw+BxkSf4/85V6EaBoaI2zgJ6UefJ+InZhwdLidUfKiKAwqub9eCuMxx7WYB6I6u5eeZCiGUIKHt/Oc
X-Gm-Message-State: AOJu0Ywq5oVrO4c84zmCeiykmrsMVwAY8Uqr6Zz63vkKqujpB8S8irhb
	RyUU4I1OGoPQw2ENEuQ/AO0t6RcYPYDBKM++H1PmesBH12BkBCoyJI2wB5g5lC8=
X-Google-Smtp-Source: AGHT+IFX4Geggl92/IhMKrsNdt44zGVSwXSPbnf0r4+rgv+x/pEZjNOybydm0AF02MocpX49oCjQPA==
X-Received: by 2002:a17:902:db11:b0:1db:f049:6315 with SMTP id m17-20020a170902db1100b001dbf0496315mr15282166plx.51.1708633371738;
        Thu, 22 Feb 2024 12:22:51 -0800 (PST)
Received: from localhost ([50.213.54.97])
        by smtp.gmail.com with ESMTPSA id km16-20020a17090327d000b001d9fc826522sm2839647plb.239.2024.02.22.12.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 12:22:51 -0800 (PST)
Date: Thu, 22 Feb 2024 12:22:51 -0800 (PST)
X-Google-Original-Date: Thu, 22 Feb 2024 12:22:43 PST (-0800)
Subject:     Re: [PATCH v2] riscv: mm: fix NOCACHE_THEAD does not set bit[61] correctly
In-Reply-To: <CAHVXubg8NKBdeutbwrJh5hdZwhRFsgyTPknM=xUhV=VG+o2Lrw@mail.gmail.com>
CC: cyy@cyyself.name, linux-riscv@lists.infradead.org, jszhang@kernel.org,
  Paul Walmsley <paul.walmsley@sifive.com>, guoren@kernel.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: alexghiti@rivosinc.com
Message-ID: <mhng-4faa415d-93d9-46fc-b2f3-3b08c0de28ee@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 21 Feb 2024 06:00:49 PST (-0800), alexghiti@rivosinc.com wrote:
> Hi Yangyu,
>
> On Wed, Feb 21, 2024 at 4:04 AM Yangyu Chen <cyy@cyyself.name> wrote:
>>
>> Previous commit dbfbda3bd6bf ("riscv: mm: update T-Head memory type
>> definitions") from patch [1] missed a `<` for bit shifting, result in
>> bit(61) does not set in _PAGE_NOCACHE_THEAD and leaves bit(0) set instead.
>> This patch get this fixed.
>>
>> Changes since v1:
>> * reword commit message and add reviewed-by
>>
>> Link: https://lore.kernel.org/linux-riscv/20230912072510.2510-1-jszhang@kernel.org/ [1]
>> Fixes: dbfbda3bd6bf ("riscv: mm: update T-Head memory type definitions")
>> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
>> Reviewed-by: Guo Ren <guoren@kernel.org>
>> Reviewed-by: Jisheng Zhang <jszhang@kernel.org>
>> ---
>>  arch/riscv/include/asm/pgtable-64.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
>> index b42017d76924..b99bd66107a6 100644
>> --- a/arch/riscv/include/asm/pgtable-64.h
>> +++ b/arch/riscv/include/asm/pgtable-64.h
>> @@ -136,7 +136,7 @@ enum napot_cont_order {
>>   * 10010 - IO   Strongly-ordered, Non-cacheable, Non-bufferable, Shareable, Non-trustable
>>   */
>>  #define _PAGE_PMA_THEAD                ((1UL << 62) | (1UL << 61) | (1UL << 60))
>> -#define _PAGE_NOCACHE_THEAD    ((1UL < 61) | (1UL << 60))
>> +#define _PAGE_NOCACHE_THEAD    ((1UL << 61) | (1UL << 60))
>>  #define _PAGE_IO_THEAD         ((1UL << 63) | (1UL << 60))
>>  #define _PAGE_MTMASK_THEAD     (_PAGE_PMA_THEAD | _PAGE_IO_THEAD | (1UL << 59))
>>
>> --
>> 2.43.0
>>
>
> I feel pretty confident on this one :)

Ya, sorry I missed it the first time around -- that's a bit embarassing 
;).  It should show up on fixes soon, just queued up behind some other 
patches but the tester is back alive so thing should be sane again.

> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> Thanks,
>
> Alex

