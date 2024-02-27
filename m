Return-Path: <linux-kernel+bounces-83627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5928869C75
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F94C1F22CB1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCBF2C6A4;
	Tue, 27 Feb 2024 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="PALDAHN2"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19E8208B0
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 16:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051933; cv=none; b=N5bPPgJ5S8Yyq+fJcXuXTncGj+gcOUM9UaEdfAWyPs4XVSGva1++dvoOKybAeoUrvgxk7gQn0598JW50bk4DVXFvGI3S2sMriHjRIYWVKzk4lDwD+uYdHyCYfiygzrAsZUS7ocCPQqCfIRMvsL6w/xTor8C3imy0NjLfbUAHaXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051933; c=relaxed/simple;
	bh=JK2bmcfEsaCOTSZSTZsc9hhbD20YHy0y1PqEbB5xuAM=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=KpURJwFInLwHfvNNhcx5o7q+aZ+aN0a9wfXAlfNBKh/PMUjlLhwkxFZkxyiT+oYlMCTSkXfs+XouN4U9vzxJUvSAeJ8+wM8dQFCd3l0d0JjtcztvuSJdPwJfi9jF2PlZilLW5YxoZkPwy68FIsoeu9oEqJR90DpECrL+L+hMfAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=PALDAHN2; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-365ab9e9e31so2591875ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 08:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1709051930; x=1709656730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBYvHRNVmUQHuF4u6D8aV99gBzMfLHOJu7wZkaD6DE8=;
        b=PALDAHN2NG3U1Td9o9NV8wdNnO3RAja5cGWEYEj8cVsp910fsX5PHNemR6h9jp+26E
         lwhHuumvwnLyaeDbj9ekV3vocnquVVEXs3BqrMyaDXqUyXTYTaKaXFnMzVY46BMfi7ej
         50yG9iZoTrV+jilOmDS4h8DTQJFbWGotU8KOBo+/pmnRc67NAC85+iqNE1XJBNwK3HOg
         gcUF3EUnnI7DgY1gZfifDxMtYseS2WX2CkTwTg0MOdI+fRcn9SjpkGB4eXR5hObAuPCp
         ZHQWYwvfrkaE2tFjYT+bvkKO+7VMRPjRCtpMj+PHHsaG7KbIbSAW1HXKk6gPTn7ifa48
         02mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709051930; x=1709656730;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBYvHRNVmUQHuF4u6D8aV99gBzMfLHOJu7wZkaD6DE8=;
        b=r9ndhD3yaj6OgwyUEnOBuBXalMJYO0ZwLsZcuuuln7XA9mQD6CjCeY2GZiYlRJ+44L
         VWwPiUKiOVgN8cR3PUIGOciRf1zCS7RqonCeIV2ELW9a9PFddmiuaQixxW1oPwkPhOIu
         k4k28GXh+e0q6Y88s8Mu7cnz/P0omVTmUoeZ13Ggb/85boqsZ74TSvt5ZoutWLJkfwES
         21N/hfbpT6wLvD38kZO5b0PYVF6Ubq7KPNKJYR1eEWAxu++e7VbzyhZPtRHKlxCHMZbS
         +6p+RI1xtko4RTfljjPXPGmqOT3zVIaABU5E2hPxhHmHXOR7mUDQVjdIUwAaip6IWUDR
         C36A==
X-Forwarded-Encrypted: i=1; AJvYcCVtLLdhkQ66MPhREwY5BacGAjOP3YIFLbuGvOrEG/Vjdb5EBR189X71mi2qad1lFUgKEPB2ltAsUWEu6iXL3ky78DcgXfWv+s06gP+E
X-Gm-Message-State: AOJu0YymP3wOCxgnYULcznzZ085pCa92eTZ2oSRE7ZaXDsycQ024XRCE
	aPWeTsil4XXyYBwDnAYVMQzzINS1Lld+N8s0CeAVNUm8rFckpnUNZvbuGUc8FHQ=
X-Google-Smtp-Source: AGHT+IF/piMzSGTcKm+9pvDU30C2+pCT5esgldW0sjMlovL7AeIarCO2Czmdb8PlN8+u1fgjCQQDcg==
X-Received: by 2002:a05:6e02:1bce:b0:365:24d9:9477 with SMTP id x14-20020a056e021bce00b0036524d99477mr14656459ilv.15.1709051930522;
        Tue, 27 Feb 2024 08:38:50 -0800 (PST)
Received: from localhost ([50.213.54.97])
        by smtp.gmail.com with ESMTPSA id ls22-20020a056a00741600b006e533caee00sm3465541pfb.155.2024.02.27.08.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 08:38:50 -0800 (PST)
Date: Tue, 27 Feb 2024 08:38:50 -0800 (PST)
X-Google-Original-Date: Tue, 27 Feb 2024 08:38:48 PST (-0800)
Subject:     Re: [PATCH] riscv: deprecate CONFIG_MMU=n
In-Reply-To: <a49546e8-6749-4458-98da-67fd37b7df18@rivosinc.com>
CC: lohr85@gmail.com, Conor Dooley <conor@kernel.org>, samuel.holland@sifive.com,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, ajones@ventanamicro.com,
  dlemoal@kernel.org, Bjorn Topel <bjorn@rivosinc.com>, Atish Patra <atishp@rivosinc.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: cleger@rivosinc.com
Message-ID: <mhng-a3b495e6-aca6-4137-a3c1-8fcacafd8596@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 27 Feb 2024 01:11:41 PST (-0800), cleger@rivosinc.com wrote:
>
>
> On 26/02/2024 20:00, Charles Lohr wrote:
>> WOAH! Please DO NOT deprecate NOMMU. I use the NOMMU build constantly
>> and NOMMU Linux on RISC-V is the avenue used by many FPGA soft cores
>> for Linux, as well as some limited systems.

OK.

I just build test this stuff, as I don't really have a use for it 
personally.  I figured if nobody's reporting bugs then probably it's 
broken and nobody's noticed because nobody's using it.

>> I get new copies of the kernel when there are releases and test them
>> frequently to make sure everything is still working as expected.

I'd actually expected it to be broken, but I guess we managed to avoid 
screwing things up ;)

>> For us we just don't care about XIP. I mean if someone did push it
>> through to fruition, I'd also test and use it, but I urge you please
>> do not deprecate this.  While it's sometimes needed a bit of a
>> creative build to get everything working, I've never needed to patch
>> anything in the kernel beyond patching in a custom console for serial
>> output.
>>
>
> Hey Charles,
>
> No worries, we actually did not expected NOMMU to have *so many* users.
> I guess deprecating stuff is a good way to have immediate feedback ;).
> Having FDPIC psABI to be merged upstream could also probably be a
> positive point toward a better NOMMU support.

Ya, that's probably the right way to do it.  Touching anything in the 
psABI is pretty miserable, though, so I don't really want to force 
people to do it...

>> I am happy to discuss the possibility of me and or one of the other
>> RISC-V soft (FPGA) core people stepping up to try to be more active,
>> but so far we've just been very well serviced by the current NOMMU
>> Linux setup.
>
> It could probably be nice to have some feedback/Tested-by: from NOMMU
> users for new releases then.

Having more upstream interaction from users is always appreciated, 
that's the best way to prove people are using the code.  If you guys 
have the time it'd be great to get this into some sort of CI, ideally 
running on some real platform.

> Thanks,
>
> Clément
>
>>
>> Charles
>>
>>
>> On Mon, Feb 26, 2024 at 8:03 AM Conor Dooley <conor@kernel.org> wrote:
>>>
>>> On Mon, Feb 26, 2024 at 04:25:24PM +0100, Clément Léger wrote:
>>>> I guess I could also mark XIP as deprecated.
>>>
>>> I'm not so sure, people recently added XIP support to QEMU (and sent
>>> kernel fixes in December). XIP is also not nearly as much of a problem
>>> to support, there's far less that it does differently, the main barrier
>>> was the inability to test it which is no longer the case.
>>> That said, XIP is gonna kill itself off I feel as it does not support
>>> runtime patching and therefore is extremely limited on extensions, given
>>> we use alternatives for all of that (although I suppose if someone has a
>>> usecase they could make nasty macros worse and implement a compiletime
>>> switch in the alternatives too).
>>>
>>> Cheers,
>>> Conor.
>>>
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv

