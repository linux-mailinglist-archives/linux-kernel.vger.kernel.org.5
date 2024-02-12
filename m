Return-Path: <linux-kernel+bounces-61071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AF4850CEB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 03:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455671F240D5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 02:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313AB20EB;
	Mon, 12 Feb 2024 02:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHBci7tk"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1546F110A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707706121; cv=none; b=GV0ktqzodszklWSC5QMLJo/yxuPsyqCIJhrzXyRaIP2A3e2DVRt0rW9+jOw3KbaGp4vnzV+N/1DxgsbFW/vP3LX8YW1rhnTPzwBus/cbbns3JL6SHUwU4wnP0YR55b5sfB6N6AKPo7F7fp+7C9Wf9YUdhZHQupMaoQg/BHLq83o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707706121; c=relaxed/simple;
	bh=U1S5brLivRdEEProPUBEd2oRg+SgT4UBofe4mfVB4Ak=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EQAt2h5087Eu5I5D06hjlniJabJDvmsiDHjLk/uIAnXZSTXoq+YnjWAiWFnRxi0dCcNpqleWWIXW3RaWpUuX4oVi4x4/NIwYwfhE8DSEZn9c/T7lQeZHQM4FSfYrGgIP8TtvMEzhfqA3r5VdhMWewbwHBkGCuxg5YO0PyG6Eu1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHBci7tk; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d73066880eso25580535ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 18:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707706117; x=1708310917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TycaA2s/zS0gTstZA7vOH1giU+ckDkRTNXdU1ggjDeY=;
        b=hHBci7tkMmOSC+suRt56+KRdPUQpsZ71kqDN0vgzeBU8VPrTY5dxx70I83H8wj8MLv
         zlFMLAyQul8kMLPFl6821jFuEdrwmxuysABNAvFX8tjz2skU71eFpRXgp5Zhtk9Noh+1
         AxOZ+ATWO/9cYwtoOt3TMie8Zys9WmxJciE4yIPGcLv4cEp9iRzOOIejqi0PG0+SxC/c
         7xROwPr7aamyKbPR9IUDcWBAy4IsUvu3wvaqkBSiO+SsI3D8pcqxGdkr5hrjLka2JbuL
         Ni14+gQlahu0Da1N2aBePOSjMa7+F5gmbavdSbHIz/cja3o3bk1FwiHUkRhq+anhnPaD
         G2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707706117; x=1708310917;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TycaA2s/zS0gTstZA7vOH1giU+ckDkRTNXdU1ggjDeY=;
        b=ANNczOezKgTqaKlYnELX1F9oFp1RupdsVEhWzbrAKTNG6x1sOEUVlWJ91a5vQm5nGe
         dcWwBT6hXqFCQI7colWzS+yGh7h0dnKh3s0eNYalq3R9a0DEXGxG4fKiL3qfmgOUAtba
         KrIfASIx/pODS+VpBnoQ6+sEEWUVbVfXSbKDln1FagE5zBJ+hxgn9Mr+nzgwTTGznvdJ
         yEiG7M6LFa2ifHGch2Q2ZLozVG4ZrvQ9ScjcUA7XYIDmCPoo8mlOxCb3lNVUqGq/9J+w
         faDExhwfvXHLCo/z4YNZs7ksax+aznF3Vft68+LCAR1Oz9jaBSBr6VAcC0o8XsHf46BZ
         aXig==
X-Gm-Message-State: AOJu0Yx4Z33Jy+m0tLMqjlIFafScppuJrVIHy0Gj8W7LQ23ri+G39U0l
	nMGBK2gO3cLod85833O8+qrF2NVXs122FVzfncm4o3hqdZG6vEcO
X-Google-Smtp-Source: AGHT+IFfuDEkGSAt0V7s7XNbdBPKAbg+JamTC5zsyzPkjye0KCTx0PiuvDzdDgCouSM8h5Dczg/x7g==
X-Received: by 2002:a17:902:eb4c:b0:1d9:8fc6:35 with SMTP id i12-20020a170902eb4c00b001d98fc60035mr5938675pli.15.1707706117325;
        Sun, 11 Feb 2024 18:48:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWbMteimK3jECQI8TCvE347ioF55OHhPY12zmjCDQTENLuwFXLF+w8ATj5h58C5d0drGaBd6OpbR29ldvF9D7zYy4x9dHze/6w7zZKMKez6+voOTOl05gNZtiGfsCB3eSFJpVdNcYmmPXwtBpe6SnAk08wq7p4dAOHrVm9dVCB2jjxR5lQfAooXwnByuU81Q0ydLfSRYWmO80lHWyUTsE5Rbt6D1kHYP4hmDzrusVwSDC9MP/NB9YaFy6jp8vqlL+ZrRe2xyR6vEghWZo5rqxEzxDjS1iBo1LiE2eSySCN0UGqoGhvWVrcYyQwj
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id a1-20020a170902ee8100b001d94c709738sm4845827pld.217.2024.02.11.18.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 18:48:37 -0800 (PST)
Message-ID: <dc60d456-3f02-4076-8adf-4688cfa03aeb@gmail.com>
Date: Mon, 12 Feb 2024 09:48:30 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: arch/x86/kernel/sys_x86_64.c: rationale for 0x40000000 for
 MAP_32BIT's start address?
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: hapter@420blaze.it, mingo@redhat.com
Cc: tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, Andi Kleen <ak@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>
References: <a5c2f06ba401cdf13bc87749341b1605@420blaze.it>
 <ZcmF3SrTACMULEPb@archie.me>
In-Reply-To: <ZcmF3SrTACMULEPb@archie.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/24 09:43, Bagas Sanjaya wrote:
> On Sun, Feb 11, 2024 at 08:52:45AM +0000, hapter@420blaze.it wrote:
>> I've found that passing in MAP_32BIT for mmap() will always return an
>> address above 0x40000000. The problem seems to lie in
> From one gigabyte up?
>> arch/x86/kernek/sys_x86_64.c, where the following comment is the only thing
>> close to a hint(Line 100):
>>
>> /* This is usually used needed to map code in small
>>    model, so it needs to be in the first 31bit. Limit
>>    it to that.  This means we need to move the
>>    unmapped base down for this case. This can give
>>    conflicts with the heap, but we assume that glibc
>>    malloc knows how to fall back to mmap. Give it 1GB
>>    of playground for now. -AK */
>>
>> Unfortunately this does not supply a rationale for starting from 0x40000000,
>> which seems very arbitrary, and the git commit has been there since the
>> beginning of time (i.e. as far the the git history goes), so the git blame
>> has not helped much to clarify it. I was also not able to find who "AK" was.
> 
> That was from commit 717db2f9f36805 ("[PATCH] x86-64 updates for 2.5.54")
> in tglx/history.git repo [1], authored by Andi Kleen. Cc'ing him.
> 

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/arch/x86_64/kernel/sys_x86_64.c?id=717db2f9f36805d85c695771ea7d712812896aa7

-- 
An old man doll... just what I always wanted! - Clara


