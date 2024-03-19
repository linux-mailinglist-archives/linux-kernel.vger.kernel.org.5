Return-Path: <linux-kernel+bounces-107378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCAE87FBAC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B4F283279
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296CD7E103;
	Tue, 19 Mar 2024 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CkPD2AuK"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E247D3F0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710843634; cv=none; b=n4AoYmAHlXd/DKtvRbu/JmCNs2is4Xg5nJVnYkZ55yU0gRrypjsLAaIPQaZA8dprVo9hSrG7s1QGI7NkRQ1gk3Dr/66v3sC7jGxtsfhw8CI65OXgCbsNxp5k3kcFlwyXxX/PXwXvzTmSyo/A2952ltszc+I6j4hZa6ig5QBBw10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710843634; c=relaxed/simple;
	bh=f3d4nTxhLrJKF8BIku5uXK0MHpCRy45pJaoaXw7zLR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFn/eOEID0SMaFwiLIuvgi8GcZg6PZy/Vw/Z1WHniPKXazsATpb/yT33TysCTsgME5IhQoOlEmAxVyPv5dwr5Agvd7z/uAI2aVY2cKVens1g7FiEy6rZ7Pwd9NdHqTsK3c1fqY9/Kja71htG2HsEOpq9Y6E9mpQ0WzvzXbEMFes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=CkPD2AuK; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a4859178f1so2087769eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1710843632; x=1711448432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QL3EGbNhVw3JtUTld34AtoZby/9DY4UaNMDtaugQZHE=;
        b=CkPD2AuK+GZb+OvUMVdm6TKVbj/4IFgBmKdmoKEb1cSD6G8XNjjMyt4zPKAO1mU7vx
         QRfqDVVtDZBFl+cpHaqYOPASnxGsBqPzP3h7cKaV8Tkn5lG9CUo01xmGcN/L26g1IaqQ
         F9hU/ejhRM5Vi4MweC/UBr1yHm2+qLZcvrpr++CJCJozWCbivmV8A2WClasQ3zK76Eq+
         L7kzV+ZIP+r5Dx9zMVNfLlfcDr5CNBXRZ85bZ1X0q9LmcTRP7AQmL+yxtHyL7cQU6Osi
         VunFetqrrkvtWqKAy3VErLxjx8sgk0h3fHydkiki02Am/dMi9v3r9/boswRO+0CyxDJw
         in7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710843632; x=1711448432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QL3EGbNhVw3JtUTld34AtoZby/9DY4UaNMDtaugQZHE=;
        b=s9Tp14oL/7RvVJKfsFpmjkMWjlfxUSPfdjS16GgdgYqErYfIra6nObqbyx/r1B9aqj
         UREOTKdGGp7Z84V8MDXx8Hbapy4Fg+ZB2gc01Yka9NdbcwSAjdVm0yur5funWuSmNza6
         UK3r+TRZG6ex8Cg+jdkBmCP7dJ7aCa/9MoHFiGjli0NFjBxmAgDY7ieFjOkgWL0YyJW6
         l8L3sx6BgpVORsWGfPunYrsCWY9tFgHKBE2xovq7pffMD45NJJiTKEcbJ8tQ1OIMb5Ga
         9s9PnX6lV3gfgzHuK/sYVsdjRug6koZ0eDJJjb4w0RKPGZ1oEjq6JmbrztTCvdhOC4aL
         h6Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWD5wkSQcDo6rZ6QhXJ4DvQfJ0XLxHjR/N96suGhZMZAdaWBhk8Hnd76jfXFmkBTn7v6m/+B6A2THYJqeu9gRgHV/5Iw8A6hoPc3hEv
X-Gm-Message-State: AOJu0Yz8YWnRnKGWg68+ucLedTVY/T018NY7YMppAdzF263+0ZAb9M0y
	GUv7vjc73enWmmOmSKh8visED+Sy5viuA9aehIUf8DeRs7zdU+SFskduo4i7Yq0=
X-Google-Smtp-Source: AGHT+IGVGk/H1aT7F0MOr8+0o1ytVFNZ5mK4pp0hbrmu8U5f3VIEAqB/PjrEuaGzbfdxTTLcPEkOJw==
X-Received: by 2002:a4a:6f0b:0:b0:5a2:37c9:d91f with SMTP id h11-20020a4a6f0b000000b005a237c9d91fmr12704898ooc.5.1710843632056;
        Tue, 19 Mar 2024 03:20:32 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id dc4-20020a056820278400b005a4a656860bsm1040842oob.2.2024.03.19.03.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 03:20:31 -0700 (PDT)
Date: Tue, 19 Mar 2024 15:50:21 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Drew Fustini <drew@pdp7.com>
Cc: linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>
Subject: Re: [PATCH v1 -next 0/3] RISC-V: ACPI: Enable CPPC based cpufreq
 support
Message-ID: <Zflm5cje/+rnZ7HH@sunil-laptop>
References: <20240208034414.22579-1-sunilvl@ventanamicro.com>
 <ZfiKooxO88h1nj35@x1>
 <Zfj4FnG5vAPP55ri@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfj4FnG5vAPP55ri@x1>

On Mon, Mar 18, 2024 at 07:27:34PM -0700, Drew Fustini wrote:
> On Mon, Mar 18, 2024 at 11:40:34AM -0700, Drew Fustini wrote:
> > On Thu, Feb 08, 2024 at 09:14:11AM +0530, Sunil V L wrote:
> > > This series enables the support for "Collaborative Processor Performance
> > > Control (CPPC) on ACPI based RISC-V platforms. It depends on the
> > > encoding of CPPC registers as defined in RISC-V FFH spec [2].
> > > 
> > > CPPC is described in the ACPI spec [1]. RISC-V FFH spec required to
> > > enable this, is available at [2].
> > > 
> > > [1] - https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html#collaborative-processor-performance-control
> > > [2] - https://github.com/riscv-non-isa/riscv-acpi-ffh/releases/download/v1.0.0/riscv-ffh.pdf
> > > 
> > > The series is based on the LPI support series.
> > > Based-on: 20240118062930.245937-1-sunilvl@ventanamicro.com
> > > (https://lore.kernel.org/lkml/20240118062930.245937-1-sunilvl@ventanamicro.com/)
> > 
> > Should the https://github.com/vlsunil/qemu/tree/lpi_exp branch also be
> > used for this CPPC series too?
> 
> I noticed the ventanamicro qemu repo has a dev-upstream branch [1] which
> contains 4bb6ba4d0fb9 ("riscv/virt: acpi: Enable CPPC - _CPC and _PSD").
> I've built that but I still see 'SBI CPPC extension NOT detected!!' in
> the Linux boot log.
> 
> I'm using upstream opensbi. It seems that sbi_cppc_probe() fails because
> cppc_dev is not set. Nothing in the upstream opensbi repo seems to call
> sbi_cppc_set_device(), so I am uncertain how it is possible for it to
> work. Is there an opensbi branch I should be using?
> 
> Thanks,
> Drew
> 
> [1] https://github.com/ventanamicro/qemu/tree/dev-upstream

Please use below branches for qemu and opensbi. These are just dummy
objects/interfaces added to test the kernel change which are otherwise
platform specific features.

https://github.com/vlsunil/qemu/tree/lpi_cppc_exp
https://github.com/vlsunil/opensbi/tree/cppc_exp

Regards
Sunil

