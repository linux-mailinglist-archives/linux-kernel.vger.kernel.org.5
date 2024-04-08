Return-Path: <linux-kernel+bounces-135246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C7089BDB9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A1E1F225E5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AD5651AB;
	Mon,  8 Apr 2024 11:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="U+3Pfava"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA34464CE6
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 11:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712574275; cv=none; b=ThsduMlgvqczHODXqguPfqtbZwnDHWVoPtSxEZ2clpq7C2RB1uaoF01zDV2FJOKbJ9XqFLxL5Wl+GT7SHnLJapiuyp661wV5juTLcyI/K2DDwFtWBn4bs2tLaXGnATRY67t98Z7Dadw4MLEDWuSxE41s2YxCK8ib4BKmeC6jraI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712574275; c=relaxed/simple;
	bh=AEkCZa+mofKBE7dnqGDEYSr7MtyuCBAKa5IvA/RNPPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEsIICApzV8I7CrbRoeQSOD42SIvIZCK/dE4txJMo1WPzXS/toY9MGxCAoTOF8fNd0kiTVJPEmco+0Ly3IChRjEm5nDA6jxtWrDVZ7qg79+9KCUU4J6eTQBRMZoz4TpqPz+epWTWy1gDawMATJpFI1KL9D82/67t0bAh1S4rVZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=U+3Pfava; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e6282dd72so802826a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 04:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712574271; x=1713179071; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2JMfbQnsZCy4AZnv2rKGHbXHeobClNfn+hJCPxhuGCs=;
        b=U+3PfavayTTxpi3GdPULfQX4/079Mr2dArOIcLhr8HR6/yChBpqWdZYHGtN6orjaDt
         CGtqjEzpp0W1+pdy+Db1ev9LucyIc4yLsDdwvGeGcPyt/VFGSkJIJB+PICfAvp8gGTMo
         8+aLn6JAaUH0KrPR7zBeUXprZmNOS4jZXSowVE/FR7aukYKWGNrg3uHOz+qTQb0LTYR+
         FEv1ByLnDnt7XQ8U/Zs8ARg7ajw4UXXgy36zlmk3z7i2Ub40r4UYMYspDq88KHYjGqTD
         IevdI0GG5h8hiyGQJhKozjqICo1N71F5DCAmmXLWFdaNpN3exE38WMuCTV3LbSMTLD6m
         ak2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712574271; x=1713179071;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2JMfbQnsZCy4AZnv2rKGHbXHeobClNfn+hJCPxhuGCs=;
        b=VBzzEUkA748FskOTvdLo+L8TRywWH4XhXbhTSt0V1nIRbJgG7+Ima+vyoGSoB6aFz/
         YO2SYV/fWOogL4uoV7kD5HhKalPxbFKJvEId43GtMG4Ppl1qgFcKdMVQSOX/CEuDkqDa
         bQq+LCInhiXw0rIOT7Rq1UtBZMCvS8O4ZWQZG8lOxAURoUQTZjuqECiG/AS1IEA7ePol
         3ViQ6eUSu5kpBFLXwkjetBMmGv6nklHDQGVUBQKXbu0XpDrOFfKYapN7l151AipXdR0M
         pnSBX4y+ZjztLbfPqCG8UVs/lMTfRWwRTecfwxiKrXv28z3WAnYObsWeMnezjLq9NimO
         R1OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpLYkaFvUdc52MIfYjGEO8Jdx7hX1ym1k63D58sQaQVGzGoP139PTV9Vd51PBmFDirnHqXs9OSg4EEbSBmfs4kMMOuLzB0YeHpzCAi
X-Gm-Message-State: AOJu0Yzox6enCt1pd8xqHqYKGOkNNVLmwJ1S9COW6YgNLtUjqCE18EhG
	WEXtMHEO+dyPKVvwSGGbgsXKNDsgDAVYCzwIBpIUcSKvWGK128f4VphwrS/EYiM=
X-Google-Smtp-Source: AGHT+IHu3NL1dqCrQipR9WBG7yHccjiSJMRW2XQ02zqZv9+xdvjF/qhErQbKJL/weMoN3GTlL7Gjbw==
X-Received: by 2002:a17:907:6d0c:b0:a51:cdfd:8ef7 with SMTP id sa12-20020a1709076d0c00b00a51cdfd8ef7mr2804880ejc.39.1712574271061;
        Mon, 08 Apr 2024 04:04:31 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id n22-20020a170906119600b00a51d113b320sm1674891eja.110.2024.04.08.04.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 04:04:30 -0700 (PDT)
Date: Mon, 8 Apr 2024 13:04:29 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Anup Patel <anup@brainfault.org>, Shuah Khan <shuah@kernel.org>, 
	Atish Patra <atishp@atishpatra.org>, linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/5] Add parsing for Zimop ISA extension
Message-ID: <20240408-0c3a1c3e3880a67a631f9f14@orel>
References: <20240404103254.1752834-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240404103254.1752834-1-cleger@rivosinc.com>

On Thu, Apr 04, 2024 at 12:32:46PM +0200, Clément Léger wrote:
> The Zimop ISA extension was ratified recently. This series adds support
> for parsing it from riscv,isa, hwprobe export and kvm support for
> Guest/VM.
> 
> Clément Léger (5):
>   dt-bindings: riscv: add Zimop ISA extension description
>   riscv: add ISA extension parsing for Zimop
>   riscv: hwprobe: export Zimop ISA extension
>   RISC-V: KVM: Allow Zimop extension for Guest/VM
>   KVM: riscv: selftests: Add Zimop extension to get-reg-list test
> 
>  Documentation/arch/riscv/hwprobe.rst                    | 4 ++++
>  Documentation/devicetree/bindings/riscv/extensions.yaml | 5 +++++
>  arch/riscv/include/asm/hwcap.h                          | 1 +
>  arch/riscv/include/uapi/asm/hwprobe.h                   | 1 +
>  arch/riscv/include/uapi/asm/kvm.h                       | 1 +
>  arch/riscv/kernel/cpufeature.c                          | 1 +
>  arch/riscv/kernel/sys_hwprobe.c                         | 1 +
>  arch/riscv/kvm/vcpu_onereg.c                            | 2 ++
>  tools/testing/selftests/kvm/riscv/get-reg-list.c        | 4 ++++
>  9 files changed, 20 insertions(+)
> 
> -- 
> 2.43.0

For the series,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

