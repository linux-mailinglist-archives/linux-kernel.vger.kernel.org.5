Return-Path: <linux-kernel+bounces-24972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC12082C56C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 920762822EC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5761BC22;
	Fri, 12 Jan 2024 18:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="mmkNwBh+"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E32A1BA5D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 18:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bbd6e3795eso5227329b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 10:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1705084238; x=1705689038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1y9RFKMR0FSPqYNNO9hPu+QHh0esMWSorBv6pzr/qFM=;
        b=mmkNwBh+NozHzf6PRcy5xxx6nQGPfr8Q1FX10zy+uqAaCRPCs3P+Pps/t1dXRJWR0l
         9Rj5PAtYF6zkd/EfD8Qu+T4Vi0L+MDT2s1ne61216E68YVrSa+6GqpvT2CaGlqmFNpT+
         NSiccl9fV9WFUFV4GReFODlGYJWlaE0fEi4xP2rob5+YQjFl3en/ZWVfcBTnwEqKgIjf
         hLF/9kKk+SJmr+MEdyc5FG7EGnFtIWOqtGaEUadtFoWVwbGQDK/EorePa6ZhPmgryf3h
         Jq+rImIK7hm1ceawLy3XYXu4HhqMogrFUFCstJaNd2Ku7JlEVImemIkaWtNQ7xpnTXYB
         OZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705084238; x=1705689038;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1y9RFKMR0FSPqYNNO9hPu+QHh0esMWSorBv6pzr/qFM=;
        b=AcPOIvYL9TTXS6PjBpq5jEbk3L3g5dLenBNmAXdrLHfj/WyehcdVP/qvLmW5lHynau
         T0EVr/SCoc8Y1AP9eO1bPhQLH44ZnLxIOfSa9CvZP4XIps6FvrW92U93+5gCxBSt33ez
         8crBG6lpULtGXqD7aHnr2osmCWfnB6kqOd7l8rLVQnXunm0+gupqbL8MhV60jLRfvdbo
         f5Op1HJpyNB4cQhMUhqv8ssP/gUIYzK1AZewd9oReaVGmGuKGpi+C32IUXoQErSv2Vem
         ZYD5gL0OkQHc0xMjNY2r0wlSzNCruFv5sz9QwwNZxKYrA6CPznFEjKHDCYKENPiS0PFL
         AJOQ==
X-Gm-Message-State: AOJu0Yyn7q5tTucZnoPdpvstPL6NNjEtinma2SkvMdpV3hwhOABNhUZe
	n1eSVHoZv/LvKpj3c5u7aWsnuqz3pm7CtQ==
X-Google-Smtp-Source: AGHT+IF1BUZm9MFACP928AtwGap6NZre7MHtBSqet5vC3dqPxL0czPLn7Q0DKWE2Rm3d/VpIQYiTIg==
X-Received: by 2002:a05:6808:3a14:b0:3bd:5f84:b599 with SMTP id gr20-20020a0568083a1400b003bd5f84b599mr2083047oib.109.1705084238187;
        Fri, 12 Jan 2024 10:30:38 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id n17-20020a0568080a1100b003bc144dc4f5sm669050oij.1.2024.01.12.10.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 10:30:37 -0800 (PST)
Date: Fri, 12 Jan 2024 10:30:37 -0800 (PST)
X-Google-Original-Date: Fri, 12 Jan 2024 10:30:23 PST (-0800)
Subject:     Re: [PATCH v5 0/5] RISC-V SBI debug console extension support
In-Reply-To: <170498463783.20080.10723421328706946354.git-patchwork-notify@kernel.org>
CC: linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>,
  jirislaby@kernel.org, Conor Dooley <conor@kernel.org>, ajones@ventanamicro.com,
  linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: apatel@ventanamicro.com, Greg KH <gregkh@linuxfoundation.org>, nathan@kernel.org
Message-ID: <mhng-2a34d0e2-170f-47a5-a688-ab454a70f06b@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 11 Jan 2024 06:50:37 PST (-0800), patchwork-bot+linux-riscv@kernel.org wrote:
> Hello:
>
> This series was applied to riscv/linux.git (for-next)
> by Palmer Dabbelt <palmer@rivosinc.com>:
>
> On Fri, 24 Nov 2023 12:39:00 +0530 you wrote:
>> The SBI v2.0 specification is now frozen. The SBI v2.0 specification defines
>> SBI debug console (DBCN) extension which replaces the legacy SBI v0.1
>> functions sbi_console_putchar() and sbi_console_getchar().
>> (Refer v2.0-rc5 at https://github.com/riscv-non-isa/riscv-sbi-doc/releases)
>>
>> This series adds support for SBI debug console (DBCN) extension in
>> Linux RISC-V.
>>
>> [...]
>
> Here is the summary with links:
>   - [v5,1/5] RISC-V: Add stubs for sbi_console_putchar/getchar()
>     https://git.kernel.org/riscv/c/f503b167b660
>   - [v5,2/5] RISC-V: Add SBI debug console helper routines
>     https://git.kernel.org/riscv/c/f43fabf444ca
>   - [v5,3/5] tty/serial: Add RISC-V SBI debug console based earlycon
>     https://git.kernel.org/riscv/c/c77bf3607a0f
>   - [v5,4/5] tty: Add SBI debug console support to HVC SBI driver
>     https://git.kernel.org/riscv/c/88ead68e764c
>   - [v5,5/5] RISC-V: Enable SBI based earlycon support
>     https://git.kernel.org/riscv/c/50942ad6ddb5
>
> You are awesome, thank you!

Nathan points out that this has some semantic conflicts with a patch in 
Greg's TTY tree: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?id=f32fcbedbe9290565e4eac3fd7c4c451d5478787

So I think the best bet is to wait on Greg's patch to land in Linus' 
tree, and then base a v6 of this patch set on that merged patch.  I'm 
going to drop this one from for-next.

