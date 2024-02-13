Return-Path: <linux-kernel+bounces-62997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A998528A9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28A11C2318C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF60134AB;
	Tue, 13 Feb 2024 06:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lNm2UMVz"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409841428F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707804920; cv=none; b=IXWJTnUDAEkdfFKt8OnLOZHoChbd3Ql4+3VInxOuCCajiB6hTpUxpm7YwUTKTBXKsoKys8UZEsNWIAXsWfBpk7GSpzxXH17wl8KTQvu6cquiMMkUh5ANYLT9XZRa4W+ipMOav4d2SP0dBhcaz5U2zxd3CqEkLWhJxTIjqU7EmHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707804920; c=relaxed/simple;
	bh=u8yZi7AQT/813a+tj4axejVbUv5iQUwpTR2TYQK9hnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDh1Y+ta9ajVoUYhFVB99qQ7OlpXjnC7voZIlGUZE8pSlz3iMrDRDUPAfU2PmavTskhldKEFXJTsUTUOYT2BsNv5eD4X7LV1cIHa77+432cHALXJVP4BHtyt58JnvFa+tWk+0ZWbaWMBO8oHEJOP+iK+t9VuIL9SpXI6lgivku0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lNm2UMVz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d74045c463so31315935ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 22:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707804918; x=1708409718; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GJ45qOxQygjER8m1e9kp6gKBtLTSJcN85GoQ73Py9I0=;
        b=lNm2UMVzy2U12VM1LGrysZqJgpzn9fsEdwf9aysEfiqZiKB8z4MDiTy8M1sAFnIOBU
         GF29VhYl50DwVFiCkUuXULsVZ/T3bR+r3jIMJm8u6BYEMdCyOgGUujCgFPv+NrdZ2ok/
         uxyg/ntdozAhfrvm36Ut6wWrgVJ0boWc/U2hG8iRtMv37zRKq8cxrPwnoWtuFZmwRl9A
         NGkN1uB/TkpJ5TcFwX3oxRfYt3p8UA6xJo0fHfcq5g1aeXil8g2JbbeXVJxrHGUQnGAw
         LYBVUSiHgnP6uD+O3i3zlzqY/lUX1LngL5sSZSzWpurRh5QJtHJWBmoQysRpdat0b1QU
         2quQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707804918; x=1708409718;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJ45qOxQygjER8m1e9kp6gKBtLTSJcN85GoQ73Py9I0=;
        b=hr1MxuIOqzdF+3iqwAzgQzSVnNt9EKaPsHz07G7FJGZ5QaEZcc5pFqE2F4iT/ert8h
         HOBwUo3v5r+FOMJbw1lJkw8xqMl1n/8a4CRrDR+xFe7fU2otky6DtxA1D5kHUALOj3lx
         sSBs83VHX9gfIbQHfvKCQFaGZ6/qRCCKnF6sfGZ2eYp3vUbAGSTiDk7XzbM3LEGyvdWv
         3brZEYyYLkG8x9crPu7FlLIlLZSdpbZxiBUqipXXn9/rI3o53LwpO/ArAFzpetZYdpy/
         N6g3ZxYOrlAojKjotpDbfqqfPGSN7GcjzJYiHm3Pdl64i3Sli2rqI4MUq7QkAx9DLv9Y
         sFQw==
X-Forwarded-Encrypted: i=1; AJvYcCWjeQg4AZK01BOHBDI+x8pswHLFFA5NeUzOlZgBxpHzuLb0SglkM4I5nTCVHgfnIF4pTaQWHfUpL+I1YPn8YItzU4JgW/JnBMJX6j02
X-Gm-Message-State: AOJu0YyWZLjONEM5IOcKgtksidyp2BwjBS9jB4LXoqV4+o8Q5SBboE+Q
	wX/tlJkJnE5rzdNFxq2YZzvQKUj0aDXy8zN+5H/bfadS/gxQ10M7XY+5W3Ip6zo=
X-Google-Smtp-Source: AGHT+IGUi3DzFtU5GCBI3jPrDosrmH0laHEfMHGNSX3/jONnrMeRzSaScuSFaMYurZ9SbwCiek8r+w==
X-Received: by 2002:a17:903:442:b0:1da:2c11:54af with SMTP id iw2-20020a170903044200b001da2c1154afmr4125403plb.63.1707804918640;
        Mon, 12 Feb 2024 22:15:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU6p0I8t3iGuopuoBs6axX29J/x4aeFiOGMbt+F2tIsk5b7fad2JT8DgSpKvC0GKCuZaUqRzJOZ05Rdn7G9wy3AXz7OtJ5QpF7fdp09Ikx5EO4EzWLiTdm85xRhNJ5Sr/NgmyrivZmVvzG4i7h1pw2A3PVwh+XDuZORnVC+b9JFmAZn8JyAqjcv8ImGBFkdGN8wK7gEk1vpjJWOFZXZnR+FdWBJDb2PhzwvhjkXhpqIwT1Fi008FFS0253FdcI53uvsGrwP0gHPryoX3JEZtD1d0WMnljvwRaZyMeJKJaodWeisbRgCWe5R7phEZpsuYs0i5m32OS7jnH3p8iC+YrQ7IxpVqojA2WCKUe0/1bwN7WaC0eRGKMi5HuDsnPsbDFTeqP5p/lSRBHiKGQ0J2N4evDuhAeqUzzlRve8uXkm+8CYWqjv2Zwlkb1DfrqhizMhactkAICRceS0+IA==
Received: from localhost ([122.172.83.95])
        by smtp.gmail.com with ESMTPSA id jv13-20020a170903058d00b001da0ce93890sm1302529plb.152.2024.02.12.22.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 22:15:18 -0800 (PST)
Date: Tue, 13 Feb 2024 11:45:16 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sunil V L <sunilvl@ventanamicro.com>, linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>
Subject: Re: [PATCH v1 -next 0/3] RISC-V: ACPI: Enable CPPC based cpufreq
 support
Message-ID: <20240213061516.kbvwdyabw2p6egwr@vireshk-i7>
References: <20240208034414.22579-1-sunilvl@ventanamicro.com>
 <CAJZ5v0iwV4mG40hbhomrTgiUoUpn_ocNH_5K84yseSpsZtviVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iwV4mG40hbhomrTgiUoUpn_ocNH_5K84yseSpsZtviVg@mail.gmail.com>

On 12-02-24, 16:24, Rafael J. Wysocki wrote:
> On Thu, Feb 8, 2024 at 4:44 AM Sunil V L <sunilvl@ventanamicro.com> wrote:
> >
> > This series enables the support for "Collaborative Processor Performance
> > Control (CPPC) on ACPI based RISC-V platforms. It depends on the
> > encoding of CPPC registers as defined in RISC-V FFH spec [2].
> >
> > CPPC is described in the ACPI spec [1]. RISC-V FFH spec required to
> > enable this, is available at [2].
> >
> > [1] - https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html#collaborative-processor-performance-control
> > [2] - https://github.com/riscv-non-isa/riscv-acpi-ffh/releases/download/v1.0.0/riscv-ffh.pdf
> >
> > The series is based on the LPI support series.
> > Based-on: 20240118062930.245937-1-sunilvl@ventanamicro.com
> > (https://lore.kernel.org/lkml/20240118062930.245937-1-sunilvl@ventanamicro.com/)
> >
> > Sunil V L (3):
> >   ACPI: RISC-V: Add CPPC driver
> >   cpufreq: Move CPPC configs to common Kconfig and add RISC-V
> >   RISC-V: defconfig: Enable CONFIG_ACPI_CPPC_CPUFREQ
> >
> >  arch/riscv/configs/defconfig |   1 +
> >  drivers/acpi/riscv/Makefile  |   1 +
> >  drivers/acpi/riscv/cppc.c    | 157 +++++++++++++++++++++++++++++++++++
> >  drivers/cpufreq/Kconfig      |  29 +++++++
> >  drivers/cpufreq/Kconfig.arm  |  26 ------
> >  5 files changed, 188 insertions(+), 26 deletions(-)
> >  create mode 100644 drivers/acpi/riscv/cppc.c
> >
> > --
> 
> This is fine with me, so
> 
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> 
> and it would be good to ask Viresh (who maintains the CPPC cpufreq
> driver) for an ACK.

I have provided my Ack over the cpufreq patch. Thanks.

-- 
viresh

