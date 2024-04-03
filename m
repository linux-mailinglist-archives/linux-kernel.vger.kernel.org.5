Return-Path: <linux-kernel+bounces-129020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624AA896346
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934021C22783
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F91B405F8;
	Wed,  3 Apr 2024 03:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="oiaat4AP"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593861C280
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 03:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712116478; cv=none; b=CDQxhjCd+BlcJXGxQeOJGuZLKInxCX8gCSUDy6CS+b70tZ6PyM+d2lOp+0dQVrG+ZIYIHOjzi+qHl63cHlrJ0iExeLu2Ipi5N555mkHFB0r0J612+JgIkbQijDD7cNbi7pb4/o9XN1m4UMEb9muopTrEuOfxF+6YK9DnManyYFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712116478; c=relaxed/simple;
	bh=Bp+yP828/5PdbUhrpzXSdAnkkpi0TYMQEcNn8nQYTZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGQcRNVQi8+6pqR+FBcLeM8fIR33suPyj+/mOAAVmuolEbYsqY6LQGeH0EqtSAVKWNSUXKkqbVhBQSOtiFmHzc2kYbp9C3jvzZg5TEcNY2g2lXzTEwKQgNvEbA2SgxoKvAIwFn/LyVy5ZWuhd4enQr9EmJ/9WLVEC+rBppS003Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=oiaat4AP; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e67b5d6dd8so3707680a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 20:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712116476; x=1712721276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nDlMmweqmT2YXtYjoDTBUfL6Mkig9fvlUABwdUVfhNw=;
        b=oiaat4AP4tcRZZSa+bI18qqceklN1pONC1cJ1l5n2hIvHOORiH2Ad5Nlyk4HIdcIQg
         jRUqKh+xkLamd23/AN56e+ztY6mlZuRcffMZC0gzbRSCPzi5w1xddD7vq5zxzi+gypB3
         aQFq30+WaEatbPL9NEb9dGm1ru5G/Q9/RvWO7AwQk1dTvftfImph2fjuEfG9V+bHzKKy
         jxUVIz3pwsYwPyoDbI+q/k2+EwbsecxJXFocr6K85Ikn1tU5rWbeBVjD9A1eJLOcC+1D
         y7Myl2sjCvEFc0CebehPlFpXCCuGSnx+dVeEgTjlqxAfwgJmKEIaCR2FephrfgJdQqAA
         ZlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712116476; x=1712721276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDlMmweqmT2YXtYjoDTBUfL6Mkig9fvlUABwdUVfhNw=;
        b=TIq4WDKURZkIZ45vdvyQwcbju+KW3i730DREAVveshHNg9hGhfpHH23k/S1zZPmL8d
         WEDUvfpWjOBamhqU72ZHm2VME6HBcRe4WmtgFlQM5n5/iAJ0KQabnOzBbNVud9fyu3rT
         bcRoazUW1k25SsxvDAep+vn3Fs0KjbHZkV/pM/Mf3SCY9MKhADl3qt2gTSxTO/T39ld9
         ObRU5XNVUpg97BCEXKpB2F1UEML9Q/03pRBZkbcM+Xk3G9wY9ufAYccxm+NuCKfTFvTz
         8Iy4JSw6KZFjgrslokN2pw7vzTx8JNmz0v9AoMI24ussxDyqzAUIalJoXC6XjZys/cjl
         +iyg==
X-Forwarded-Encrypted: i=1; AJvYcCWaM9Cy3DpNHlWK9aOF31AVVKfeZpy9yJNGeqntGpPkiSmQr4Po3mHNn3YHp5IYAVSK5vWMt+C5d6ck3ljaEqkFpRR8m6q8spM+WSfP
X-Gm-Message-State: AOJu0YzNVsGZkciR6dRxDED8oj2VSp8pLv8FvRcBSJGb97x3A8+XxVOX
	Z/1Yv4YmYX8qaDlSFtVPrTgn2JD9FZf1ptNiLXb6l2UdijAHBGVc/TLD2lZkQZI=
X-Google-Smtp-Source: AGHT+IETkCuICm5EPgSs85v0APh8MQMZIQjKjNwLi31nnN/NIeD9KNS9g5g3rmLvIILzexgZSobE3g==
X-Received: by 2002:a9d:6b94:0:b0:6e6:a32e:5f32 with SMTP id b20-20020a9d6b94000000b006e6a32e5f32mr16558369otq.29.1712116476362;
        Tue, 02 Apr 2024 20:54:36 -0700 (PDT)
Received: from sunil-laptop ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id cm28-20020a056830651c00b006e6763530e1sm2497020otb.61.2024.04.02.20.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 20:54:35 -0700 (PDT)
Date: Wed, 3 Apr 2024 09:24:21 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Haibo Xu <xiaobo55x@gmail.com>, "Xu, Haibo1" <haibo1.xu@intel.com>,
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	"Moore, Robert" <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Guo Ren <guoren@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Zong Li <zong.li@sifive.com>, Jisheng Zhang <jszhang@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Evan Green <evan@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Marc Zyngier <maz@kernel.org>, Anup Patel <apatel@ventanamicro.com>,
	Ard Biesheuvel <ardb@kernel.org>, Yuntao Wang <ytcoode@gmail.com>,
	"Schofield, Alison" <alison.schofield@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v2 6/6] ACPI: RISCV: Enable ACPI based NUMA
Message-ID: <ZgzS7W83iWRII73G@sunil-laptop>
References: <cover.1709780590.git.haibo1.xu@intel.com>
 <01cb5780041565784d459cd94a5c4f55eaa87739.1709780590.git.haibo1.xu@intel.com>
 <Zgpf0rqUSEZcSiAV@sunil-laptop>
 <CAJve8om9-cTtYKLmB0R=6Wwh5KQ9z+16AFR-tuUkJhJjbn0UEA@mail.gmail.com>
 <SJ1PR11MB6083B43290D216B1568642B0FC3F2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083B43290D216B1568642B0FC3F2@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Mon, Apr 01, 2024 at 04:57:30PM +0000, Luck, Tony wrote:
> >> If the firmware didn't provide the SRAT/SLIT on ACPI based systems, then
> >> there will be a message "Failed to initialise from firmware" from
> >> arch_acpi_numa_init(). This is not specific to RISC-V. But I am
> >> wondering why should it be pr_info instead of pr_debug.
> >>
> >
> > My understanding is maybe it just wants to expose explicit logs to
> > avoid any potential bugs from FW or Kernel.
> 
> There are lots of ACPI enabled systems that aren't NUMA (single
> socket servers, desktops, laptops). Making this "pr_info()" would just
> add noise to the boot on all of those.
> 
Exactly. But this is an existing pr_info message across architectures.
My suggestion is to add one more patch in this series to convert
this to pr_debug unless someone has strong reason to keep it pr_info.

Thanks,
Sunil

