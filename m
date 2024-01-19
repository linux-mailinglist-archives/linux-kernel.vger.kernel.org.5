Return-Path: <linux-kernel+bounces-31596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC1D83308E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6140C286AEA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F67558AA6;
	Fri, 19 Jan 2024 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="FP3+C+fT"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3B75465E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705701573; cv=none; b=DnrHDMbmoNVS8sYrq3JRJHeUWBGvMytbACqlS2niK7WpmssVnZxa7oz3jVcp76nIvk3vtzw/3Cc6CgbUcnvKRmiu1GzHoI+VYN9+aQtzUD/rb5DxcfMviiSayI8SpvOiEZ9Do8v7xx6Ilg2yDKZXVPRvRBfiVK1UeXYVNMyUU2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705701573; c=relaxed/simple;
	bh=x1rxNQeXYLXk8l6ZOp05BM8JPpIubtZJkqFc265ZIao=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=f/CaHCT+rCTptpOoUU9n6PDMqfDMCDLZoI1/bV5CJHe1b0/fIu07jNhYpRomOHZg7aVvmxCLC2TBU8njC4kvZGzzjT+liv/Aal7KdS1QklUB2LL+CqV2vbmloCsALVzyKqDSMtBYu2f3Hm1rpd65hml1a+OQYLlc6hJKxyHxN8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=FP3+C+fT; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-59927972125so592863eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 13:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1705701571; x=1706306371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5S7IqMYVGKNqJZ35fEQj0xzfnTIX8E84YBSqWvhnC0=;
        b=FP3+C+fTfp+wcFWfWAhnTtBvrIaKT21yHSUS08fjmeQQIZzr8q0oB7wczJssffGdMw
         q5JtAHs0jCfpPm3W39eEf+kl6c6IJo61u6DqKwdehF7aXxKJ3m8/qBp8euodsIyD+c5m
         qFmH0lbgK9x7y5ri0DiVORwDOCEEnor8myV/xco36FOUMmn0RFCnTIsT4bEPr97DyMl2
         U5+/dfPuiBGzqawT0qoI4Teu99LP0bDYEzhiZU99HnQ7SWHyytAIFedc/wkc7lG8Q370
         zXlopx8KPyfF172ZlahzkJFuRDHyql0q+hmwcSbNd+AcW4ICza2ZgE0Gx+Fd+Ra9y8OZ
         TeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705701571; x=1706306371;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5S7IqMYVGKNqJZ35fEQj0xzfnTIX8E84YBSqWvhnC0=;
        b=SL9oden5pqMizKf+3gCQ1Iy1zQ950noLEhcBmm0DHonKc4Q0Mjg8tZ13fsea3j29Li
         s5a7hdHv9TW39F2wjOikFwunKiaK/Tn0Du63s0mlVnUL2QVdQkPwvOPomLSixE/cub7D
         rpiV/PsJXqbcGgX7ZbkhU29eWqTXpkKnq7HweKB2Tc+SRzEtkSphbKiwjbnFqYB9QLqH
         uvw+nhYR/3P3FWL4HSJpC5aRtPMrfm/A9AzWVcUXC9dWXKIo19vutvdZiOykQLwta233
         nYE8KrxpDiyjDqdwKp3gHPfHhAlBsS414raEdfJV/yoC0S82t9TY2YSGPoW7PWd3ttpA
         y3Tg==
X-Gm-Message-State: AOJu0YzEZyCxkdzrCHPpWewmBpgpYTKX87SEiNs9FWkrXqsS9Fc1Ciou
	v6d7olSML2Pf3wiNimI+anidDfJPTyorvMXB6pNKPgfMbTvwuzx8WiYgPSFYZ4c=
X-Google-Smtp-Source: AGHT+IESicOUtDUT+5BwgwqSfPXAdnKkq3SaMukVEeCzOBMaA+ge58Litoyb9vV7itnjx54Th0+h3w==
X-Received: by 2002:a05:6359:4290:b0:175:bf72:cfd4 with SMTP id kp16-20020a056359429000b00175bf72cfd4mr419654rwb.31.1705701570687;
        Fri, 19 Jan 2024 13:59:30 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id 37-20020a630a25000000b005ceb4a6d72bsm3824521pgk.65.2024.01.19.13.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 13:59:30 -0800 (PST)
Date: Fri, 19 Jan 2024 13:59:30 -0800 (PST)
X-Google-Original-Date: Fri, 19 Jan 2024 13:58:56 PST (-0800)
Subject:     Re: [PATCH v5 0/5] RISC-V SBI debug console extension support
In-Reply-To: <CAK9=C2UV8J52a1pZjsNpFNwpUKn5K3nhS-+bS-3pohDwi3HrfQ@mail.gmail.com>
CC: Greg KH <gregkh@linuxfoundation.org>, nathan@kernel.org,
  linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, jirislaby@kernel.org,
  Conor Dooley <conor@kernel.org>, ajones@ventanamicro.com, linux-serial@vger.kernel.org,
  linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: apatel@ventanamicro.com
Message-ID: <mhng-f5f3ec82-ce6a-4e20-8799-f36fd82d74b6@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Fri, 19 Jan 2024 02:09:18 PST (-0800), apatel@ventanamicro.com wrote:
> On Sat, Jan 13, 2024 at 12:00 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Thu, 11 Jan 2024 06:50:37 PST (-0800), patchwork-bot+linux-riscv@kernel.org wrote:
>> > Hello:
>> >
>> > This series was applied to riscv/linux.git (for-next)
>> > by Palmer Dabbelt <palmer@rivosinc.com>:
>> >
>> > On Fri, 24 Nov 2023 12:39:00 +0530 you wrote:
>> >> The SBI v2.0 specification is now frozen. The SBI v2.0 specification defines
>> >> SBI debug console (DBCN) extension which replaces the legacy SBI v0.1
>> >> functions sbi_console_putchar() and sbi_console_getchar().
>> >> (Refer v2.0-rc5 at https://github.com/riscv-non-isa/riscv-sbi-doc/releases)
>> >>
>> >> This series adds support for SBI debug console (DBCN) extension in
>> >> Linux RISC-V.
>> >>
>> >> [...]
>> >
>> > Here is the summary with links:
>> >   - [v5,1/5] RISC-V: Add stubs for sbi_console_putchar/getchar()
>> >     https://git.kernel.org/riscv/c/f503b167b660
>> >   - [v5,2/5] RISC-V: Add SBI debug console helper routines
>> >     https://git.kernel.org/riscv/c/f43fabf444ca
>> >   - [v5,3/5] tty/serial: Add RISC-V SBI debug console based earlycon
>> >     https://git.kernel.org/riscv/c/c77bf3607a0f
>> >   - [v5,4/5] tty: Add SBI debug console support to HVC SBI driver
>> >     https://git.kernel.org/riscv/c/88ead68e764c
>> >   - [v5,5/5] RISC-V: Enable SBI based earlycon support
>> >     https://git.kernel.org/riscv/c/50942ad6ddb5
>> >
>> > You are awesome, thank you!
>>
>> Nathan points out that this has some semantic conflicts with a patch in
>> Greg's TTY tree: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?id=f32fcbedbe9290565e4eac3fd7c4c451d5478787
>>
>> So I think the best bet is to wait on Greg's patch to land in Linus'
>> tree, and then base a v6 of this patch set on that merged patch.  I'm
>> going to drop this one from for-next.
>
> Greg's patch is now available in upstream Linux so I will rebase and
> send out v6.

Sorry, I forgot about this one and merged it.  I just sent up a fixup: 
https://lore.kernel.org/all/20240119215612.20529-2-palmer@rivosinc.com/ 
.

>
> Thanks,
> Anup

