Return-Path: <linux-kernel+bounces-23572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 781FF82AE88
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1191F271DB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42ED515AC1;
	Thu, 11 Jan 2024 12:16:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFEF156C7;
	Thu, 11 Jan 2024 12:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8B642F4;
	Thu, 11 Jan 2024 04:16:56 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02E653F64C;
	Thu, 11 Jan 2024 04:16:08 -0800 (PST)
Date: Thu, 11 Jan 2024 12:16:06 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Anup Patel <anup@brainfault.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>
Subject: Re: [PATCH -next 1/2] ACPI: Enable ACPI_PROCESSOR for RISC-V
Message-ID: <ZZ_cBlOSW9VCjkOv@bogus>
References: <20240111093058.121838-1-sunilvl@ventanamicro.com>
 <20240111093058.121838-2-sunilvl@ventanamicro.com>
 <20240111-bb411d2dd39eb859dd049fa0@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111-bb411d2dd39eb859dd049fa0@orel>

On Thu, Jan 11, 2024 at 11:00:12AM +0100, Andrew Jones wrote:

[...]

> Also, interestingly, it looks like this ancient line
>
>  obj-$(CONFIG_ACPI_PROCESSOR)    += processor.o
>
> in drivers/acpi/Makefile should be removed,

No

> since there's no drivers/acpi/processor.c file.

Correct, but ..

> I guess the make process silently filters object files which don't have
> corresponding source files?

May be, but I doubt if that is the case here.

processor.o is just aggregation of all processor_*.o and this will be
the processor.ko when built as a module.

--
Regards,
Sudeep

