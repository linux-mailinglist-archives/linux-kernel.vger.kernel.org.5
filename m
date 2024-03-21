Return-Path: <linux-kernel+bounces-109664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C44881C32
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 078DC2830F8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 05:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6579B38DC0;
	Thu, 21 Mar 2024 05:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="kebzPVb+"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACFF2838E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 05:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711000190; cv=none; b=dfM1HxsqsOKz9Mbj7mtrZklkiy2wsXBQBqj81CyB4HIyYk4/qzFp1hLL9MlGvakhKHl8bI0f47aaeF8ITZfmc6bzHNJ+WE0iaSzF6Bmett2WbfzFF0ByGQYZrK8qCja1ZGJ6YkYc8OReiZdaNA+dUD27gmSemc8yALC7K3kBgWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711000190; c=relaxed/simple;
	bh=xqb6OW4NL610PwfRqtZ6sO9SB9ttkAls8egmCeYMbwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gn/i5+NukPXJw9owr0xibW+gwQ73dYHvMPcl0EZGbbZrvL+DoCDEOQeLqQkWi9QKLPXsl1DcbVtl5gfGjUPLTZsKZ1MkdYxGiS/Db/UKtTAuggQcXLRbQHVsz7r2LUuwM7XEcKi7y4YVOcOvyDEbLQ98c0a6FJr9MezE5PqnTnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=kebzPVb+; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c390030af2so448460b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 22:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1711000188; x=1711604988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4fMphhNJ5kOGNAmeCpoYULkf287odK9ySZpSTtY/rRg=;
        b=kebzPVb+6u/YW8a0A4XMCsggydlDOG1DgqRx4NaX/gLoiocHYgJws6JIkKpizbsUiK
         miUGX005eeVMYYGjv9iJrRmGSzQim+w7p+odCysbKYG7bbcpKZP14136G3IsaK9w17+F
         Qep9aosrjOdC+b0ze6XJdNG/tD2mB3Ot+votZaTS9SzprVrEcbas/vFwSwloTxILWBqg
         GFhfCSUILmoONUI5asJEMrWFRfG1hCI9rqZYALreffY8ALRZKRmlONGkcOzYBCkKZ5Z3
         Tu/Davi9vKKCJHsSkfg8LLXcFIyruQzDuyGiCEUaWnPnrKXS9juo1Ujrcm0tRAAHt8Al
         uuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711000188; x=1711604988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fMphhNJ5kOGNAmeCpoYULkf287odK9ySZpSTtY/rRg=;
        b=AQ0bcsR8uHriPmmspuwMUpOXYokQhXtZFidSMWNNuhpcBzeWBuT8X3YPdYvwA+Hx5b
         lZjIhFjyTVS80hshZGJQRhtJ0Y+3buR4MlKDvFyeuZvgAyFP6JvNqflTNGvV0HKWJPC+
         7ihzWD9fxojgfxnpldoRDKb9g8HcMFFgsvek7ZDZNBcU5qwGV1+2st9wZ0wL+JX0ZePH
         L6mYYsJUZe2+hfl2uS+CCIq7pO9pGUqV0EoR/NdDe6jAfvTtmThflLr/aB4raXjvEeaL
         O3hpIrzh8YDFak6aiIb8NPbTZUAxeg2UehQXIW9cE7TuVN2ROLRAmL9HgWRbQAbpwh00
         36Mg==
X-Forwarded-Encrypted: i=1; AJvYcCXF+vecqngm7UVtmVDuGvHA2eW4H/ud/msEKviijfZTxZxqXHl+jwHoptuzAnOQih1YPLN4NKG+NYgd7MEQIm2c1XG8L5TDbLGLRlg8
X-Gm-Message-State: AOJu0YwqKHxjFgWNwjmKaB5FmXx2Rad39z7BvxIZfbg8kYvtm2bZdXfj
	D7vYO5NnBg1KuW5sbdRQvX8yC+oLw5fqUjf3P47uAtdTXZrcjCU21GlLJcUdLiF7gQrHSrpzsTp
	D
X-Google-Smtp-Source: AGHT+IE0/NeFnqIC97uS0g8chtXLhBTnsViFruSK0O5TsDNqnoRtdY/a9pxc+Nn5UfS59hiKwsJLqA==
X-Received: by 2002:a05:6808:16ac:b0:3c3:773b:1289 with SMTP id bb44-20020a05680816ac00b003c3773b1289mr4629025oib.5.1711000187996;
        Wed, 20 Mar 2024 22:49:47 -0700 (PDT)
Received: from sunil-laptop ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id c25-20020aca1c19000000b003c3aef12838sm56402oic.42.2024.03.20.22.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 22:49:47 -0700 (PDT)
Date: Thu, 21 Mar 2024 11:19:38 +0530
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
Message-ID: <ZfvKclUHAPkmywT3@sunil-laptop>
References: <20240208034414.22579-1-sunilvl@ventanamicro.com>
 <ZfiKooxO88h1nj35@x1>
 <Zfj4FnG5vAPP55ri@x1>
 <Zflm5cje/+rnZ7HH@sunil-laptop>
 <Zfuzmx/bvJZjWDx4@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfuzmx/bvJZjWDx4@x1>

On Wed, Mar 20, 2024 at 09:12:11PM -0700, Drew Fustini wrote:
> On Tue, Mar 19, 2024 at 03:50:21PM +0530, Sunil V L wrote:
> > On Mon, Mar 18, 2024 at 07:27:34PM -0700, Drew Fustini wrote:
> > > On Mon, Mar 18, 2024 at 11:40:34AM -0700, Drew Fustini wrote:
> > > > On Thu, Feb 08, 2024 at 09:14:11AM +0530, Sunil V L wrote:
> > > > > This series enables the support for "Collaborative Processor Performance
> > > > > Control (CPPC) on ACPI based RISC-V platforms. It depends on the
> > > > > encoding of CPPC registers as defined in RISC-V FFH spec [2].
> > > > > 
> > > > > CPPC is described in the ACPI spec [1]. RISC-V FFH spec required to
> > > > > enable this, is available at [2].
> > > > > 
> > > > > [1] - https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html#collaborative-processor-performance-control
> > > > > [2] - https://github.com/riscv-non-isa/riscv-acpi-ffh/releases/download/v1.0.0/riscv-ffh.pdf
> > > > > 
> > > > > The series is based on the LPI support series.
> > > > > Based-on: 20240118062930.245937-1-sunilvl@ventanamicro.com
> > > > > (https://lore.kernel.org/lkml/20240118062930.245937-1-sunilvl@ventanamicro.com/)
> > > > 
> > > > Should the https://github.com/vlsunil/qemu/tree/lpi_exp branch also be
> > > > used for this CPPC series too?
> > > 
> > > I noticed the ventanamicro qemu repo has a dev-upstream branch [1] which
> > > contains 4bb6ba4d0fb9 ("riscv/virt: acpi: Enable CPPC - _CPC and _PSD").
> > > I've built that but I still see 'SBI CPPC extension NOT detected!!' in
> > > the Linux boot log.
> > > 
> > > I'm using upstream opensbi. It seems that sbi_cppc_probe() fails because
> > > cppc_dev is not set. Nothing in the upstream opensbi repo seems to call
> > > sbi_cppc_set_device(), so I am uncertain how it is possible for it to
> > > work. Is there an opensbi branch I should be using?
> > > 
> > > Thanks,
> > > Drew
> > > 
> > > [1] https://github.com/ventanamicro/qemu/tree/dev-upstream
> > 
> > Please use below branches for qemu and opensbi. These are just dummy
> > objects/interfaces added to test the kernel change which are otherwise
> > platform specific features.
> > 
> > https://github.com/vlsunil/qemu/tree/lpi_cppc_exp
> > https://github.com/vlsunil/opensbi/tree/cppc_exp
> 
> I know the opensbi branch is just for the purpose of testing the kernel
> driver. However, I am new to ACPI and I am trying to understand how a
> real system might work.
> 
> The _CPC register address encoding in the RISC-V FFH spec enables the
> SBI CPPC register ID to be specified. But how would SBI firmware know
> what physical address corresponds to the CPPC register?
> 
> If sbi_cppc_test_write() [1] was implemented for a real system, then how
> would it know what physical address to write to for a CPPC register like
> SBI_CPPC_DESIRED_PERF?
> 
The SBI extension provides an abstraction to access the CPPC registers.
SBI implementation for the platform should be aware of how to access a
particular register in the back end when it supports the extension.

Regards,
Sunil

