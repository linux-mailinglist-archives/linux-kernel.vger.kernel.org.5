Return-Path: <linux-kernel+bounces-47091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B93E8448FC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F6F51F23417
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252DD1BC49;
	Wed, 31 Jan 2024 20:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="l/few0PV"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7267A31A61
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706733284; cv=none; b=pUpteJ04Z73RpNhQBWsqmMENL+AYnicHcRFhsQ8UO/ic1D86wM+YAbMEyxdFgV5WcM3Zh5e3CIrtpZ7gqLD32nQfrodYFhx+sKhILTVyOGvS4RRHyxwYUNZNWLB64Zd/u7hfK6bwRJrOB82QWOMb+xj9XBn0EKzre0cSaAI+Frg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706733284; c=relaxed/simple;
	bh=exb8QliXElxoEXVK1gbR8+PpzfLOvEHWKXq3vd8Mf6Y=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=WyyAX7ytvyuXFm+V10angPLDO5kf4OanyJThFlah8zLqzstPN/knNiGHURq2smsij5IBiU21XCtK2iHvN/SRqXgLyT2U8zdHCZyTzhiwSN0r/RNn7t4BV4GBrjEIwY0y5swsPaD49KS4n7aXfW8jgVDrhrYrbvxYYeYO1anLqag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=l/few0PV; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso181097a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1706733281; x=1707338081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ToCSOyY9UgT3lZYwTMmNWF442wR42KPytzlol85Izbc=;
        b=l/few0PVcKIfjEtJya2PV4y2hdCvVXMf3TPjQR9+qCP0MQnK27UrUamgpUAu9Al8CV
         9x81c/WI0TO6HNcaM24E9vPOXbXf0cl1PJr7LSeb/lmIXzsEa39Jr2Qzr3sszkTajKV3
         X/xIPs+ODVipdiF/5SxV5Vwd1Sz14SX3deE638ckWWYIamOLrHwiEL66dXKKkTt+Ec6O
         OQkoO0ruc8xbc7PSqdqj025O6Rdfs6XDuGmvYG/PqoywhKVo6JPEvjRdfFxSrhu6DS8Q
         9SO9S2okAjmvQORjeleXkpr1L4RhkUIseYrANigaw7UZpVCbZa+SiS53whyv8KVaFrXf
         ZZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706733281; x=1707338081;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToCSOyY9UgT3lZYwTMmNWF442wR42KPytzlol85Izbc=;
        b=TVvBRmdK9tMq/Py50XH7kFscVcoYghamtmsGjl95KxUMArR8YMByt6A7kMRcjQasqL
         sCJ/fUq99o3tDHAYazu+OCyp2n+fGkqgU1EfT63otHk7zbH0IHeEDu0Mv/J0MPr6QWiG
         kOud+U2K0gQeY5DiKISJHp63FQrqUVD7vJlOF1Ey4JM0HLvPWDMSodTFjcr70qKjjact
         Dl09OxImPsoIrvp5jgKNAT5EuFezzqJisA3/wkdYwUNSwt56fVTrGyGG7LFXNPdJTqYP
         cQYaakBhLjN0cVoQBwXkUk5+/KQm09ryNkSSzGZgxSiJYm5RtTJKyFyNggtQIhxNAYOk
         KSrQ==
X-Gm-Message-State: AOJu0YwsboTpKAHkYbNTa4nhcP8fM4Pk2PhWScZnaHVRMdiu4lo+TRX4
	0sCZ8pqA54so9S1oYO4/hEuxoOahRzPW8PaRhjP+sZqk0xKdd4Pn0eN8p+dwXWk=
X-Google-Smtp-Source: AGHT+IEsFzJWhwkZHvWSeO6eMVC7rMYmcrfSRDwnS5J+jMrysPE3aQ1rfKm6FrvZ3viTgCzDnZxSkQ==
X-Received: by 2002:a05:6a20:f3a6:b0:19c:ad6b:e1c2 with SMTP id qr38-20020a056a20f3a600b0019cad6be1c2mr2839985pzb.12.1706733281551;
        Wed, 31 Jan 2024 12:34:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXqfWhjIx1TNL1IuyBOTEw7zpq0DQTBViDu+wnKkWGpI2jfceGOMShnRxYQcqH9PG5CsOjLDzniIjDpMJapuRkaaUmsJXgGuGs6v291UHPiNHY0seXAX/ag2QwQeq6+DLyZOm9bhoRF/Jvr9Bswuc3lIdtsoy6oOD7CsfFJdg9LUomiqByc0cDRvcwLeaYhkQDvCG/cro+tY2ymBZISpPksVyT45q7VNFXa4bupfBFtDn6mfcQ=
Received: from localhost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id v27-20020aa799db000000b006dde1001a0bsm10275840pfi.190.2024.01.31.12.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 12:34:40 -0800 (PST)
Date: Wed, 31 Jan 2024 12:34:40 -0800 (PST)
X-Google-Original-Date: Wed, 31 Jan 2024 12:34:39 PST (-0800)
Subject:     Re: [PATCH] riscv: Fix wrong size passed to local_flush_tlb_range_asid()
In-Reply-To: <ZbdpTPMOw4lsPxBi@snowbird>
CC: alexghiti@rivosinc.com, Paul Walmsley <paul.walmsley@sifive.com>,
  aou@eecs.berkeley.edu, geert@linux-m68k.org, linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: dennis@kernel.org
Message-ID: <mhng-d603d0d3-2f72-4dfc-b635-c270ae79fd85@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 29 Jan 2024 01:01:00 PST (-0800), dennis@kernel.org wrote:
> Hi Alexandre,
>
> On Tue, Jan 23, 2024 at 02:27:30PM +0100, Alexandre Ghiti wrote:
>> local_flush_tlb_range_asid() takes the size as argument, not the end of
>> the range to flush, so fix this by computing the size from the end and
>> the start of the range.
>>
>> Fixes: 7a92fc8b4d20 ("mm: Introduce flush_cache_vmap_early()")
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> ---
>>  arch/riscv/mm/tlbflush.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
>> index 8d12b26f5ac3..9619965f6501 100644
>> --- a/arch/riscv/mm/tlbflush.c
>> +++ b/arch/riscv/mm/tlbflush.c
>> @@ -68,7 +68,7 @@ static inline void local_flush_tlb_range_asid(unsigned long start,
>>
>>  void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
>>  {
>> -	local_flush_tlb_range_asid(start, end, PAGE_SIZE, FLUSH_TLB_NO_ASID);
>> +	local_flush_tlb_range_asid(start, end - start, PAGE_SIZE, FLUSH_TLB_NO_ASID);
>>  }
>>
>>  static void __ipi_flush_tlb_all(void *info)
>> --
>> 2.39.2
>>
>
> Sorry for the delay, I just pulled this into percpu#for-6.8-fixes. I'll
> send it to Linus this week.

Do you mind if we do a shared tag or something?  It's going to conflict 
with 
https://lore.kernel.org/all/20240117140333.2479667-1-vincent.chen@sifive.com/ 
  No big deal as it's a pretty trivial conflict, but they'll both need 
stable backports.

>
> Thanks,
> Dennis

