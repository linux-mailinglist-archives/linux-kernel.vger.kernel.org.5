Return-Path: <linux-kernel+bounces-145261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1FB8A518D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A2D82882A7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6B712BF21;
	Mon, 15 Apr 2024 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="djlGTVLT"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EA07829B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187420; cv=none; b=TQNs/ifd/DfXJPOWlbNjtifF2YhVUJtcsWa3XtOUUre2NzaTaStSKBjbx5zo/QyZ0dboS3hZh3fOBVsdeJTBWIcYbF8bNHyer3UFMP6r/qr9/e0/5NcwwL4K+zUYFgW04YjCf4WINL80SEv1XmuGns94BedOdzshtBE2vJ6wK0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187420; c=relaxed/simple;
	bh=6QDDaFd9eTHSjGZ+Gq69MqmItflrTqKnpwZ5H6nspls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnL+TFwrcUYsxQqN9zpORcLrV4bKRGRHoFUaxwW5aWat5KRpRXiMinpOOXWgwZ30aQAlrNBSHDDBeCvduP+baz4IXvIugxS1DFAAcDJPi0SZLbb7ufltgVxtN1qpUtJ6HjHbOwVoDqQ84yDD301jWmi978JH58UlFOZxjemS41w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=djlGTVLT; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e2c1650d8so2968722a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713187418; x=1713792218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SsPjsW5vGyGQYslNcZfnPrf8zdlh6X3WXkIuouRF3Dg=;
        b=djlGTVLTcajbVDmPo6YNTF2O+xyJkOimFpaRVQ7JuevkkNHFEadaaMCCaHNOsMhaIc
         MtJvD2+8UIpEGNK5EwrYO8VSYN5qAIu0D5b8QCiIdmfJxpI2PS71mI8JX/94vcQwIEVu
         pr34Qh84oOWtpnTBXr4/f9wdhj0DAEJsTvUtcNyc7sk5CltR/Fu+AvEYjOHQZhI/5sDO
         fc2w1Bq5RBdVP97WF9AbAWBmXyNrLGw6tUG43XxqhAbnIV9Hc+q0GHA4WmeX2eQOhvAi
         Nwo3ASmkh4LH9lmL5mFQOjAXlKJuaJBV8KeMFGDcRy9uvJg4qVAgRPAfuUstdrMFlyz4
         0XLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713187418; x=1713792218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsPjsW5vGyGQYslNcZfnPrf8zdlh6X3WXkIuouRF3Dg=;
        b=KfTbiVTD3FfFDz3kQ5E+mCRXkey4DwX6u3CmLPsIyeBoIP3gQMpaMEl2GHrXMLXvXm
         FDMV4E3N85QqUt7aPxobHmoqeyfD08q5FGXRrFi+Gol9sDbudBRWZGbAHIDNMbF0PgYm
         Npf3ABw+dJAXOy/iWRtBrnfwFwCWkM1qSRBe7VUyML+S+gmUSmh7+JzQ0Xdml9LpKsEG
         9hTymwK3ECkRraKMmaEVx05zQTKzWPGvADR1iqAefsF2GHJt86iGgmGvVbSMTFT88lKD
         Dj8XCX3CzbrVudJxfR477KSm5YuT4V51v3OiDGeeJRoLGbRzvwoHT+TDN4uhn81cDvXW
         oGjw==
X-Gm-Message-State: AOJu0Yx2GNKKQqlZ0Bu1E1C8Dgh0OYsqc1Tpi9h2uHlCKKcxI2IBr3Oa
	6C7Afn8aHVpEbkfD98Lm5ujQmwMQWR+pMgDYPoSM148yodUC+V3CwaCALIvHXSk=
X-Google-Smtp-Source: AGHT+IHklOBQ3iGKHu088UkpOHw/VxcGUKSaeMTX9Gz3utwCjBi1O3+vYBQcukgR3YGBfTGMHvrvUA==
X-Received: by 2002:a17:906:f1c7:b0:a52:fb9:27ad with SMTP id gx7-20020a170906f1c700b00a520fb927admr6011866ejb.48.1713187416663;
        Mon, 15 Apr 2024 06:23:36 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id ji16-20020a170907981000b00a5244a80cfcsm3480965ejc.91.2024.04.15.06.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 06:23:36 -0700 (PDT)
Date: Mon, 15 Apr 2024 15:23:35 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Alexey Makhalov <alexey.amakhalov@broadcom.com>, 
	Atish Patra <atishp@atishpatra.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, Will Deacon <will@kernel.org>, 
	x86@kernel.org
Subject: Re: [PATCH v6 14/24] RISC-V: KVM: Add perf sampling support for
 guests
Message-ID: <20240415-cdc6d5bc6c5145f9d6f54afc@orel>
References: <20240411000752.955910-1-atishp@rivosinc.com>
 <20240411000752.955910-15-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411000752.955910-15-atishp@rivosinc.com>

On Wed, Apr 10, 2024 at 05:07:42PM -0700, Atish Patra wrote:
> KVM enables perf for guest via counter virtualization. However, the
> sampling can not be supported as there is no mechanism to enabled
> trap/emulate scountovf in ISA yet. Rely on the SBI PMU snapshot
> to provide the counter overflow data via the shared memory.
> 
> In case of sampling event, the host first sets the guest's LCOFI
> interrupt and injects to the guest via irq filtering mechanism defined
> in AIA specification. Thus, ssaia must be enabled in the host in order
> to use perf sampling in the guest. No other AIA dependency w.r.t kernel
> is required.
> 
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/csr.h          |  3 +-
>  arch/riscv/include/asm/kvm_vcpu_pmu.h |  3 ++
>  arch/riscv/include/uapi/asm/kvm.h     |  1 +
>  arch/riscv/kvm/aia.c                  |  5 ++
>  arch/riscv/kvm/vcpu.c                 | 15 ++++--
>  arch/riscv/kvm/vcpu_onereg.c          |  6 +++
>  arch/riscv/kvm/vcpu_pmu.c             | 68 +++++++++++++++++++++++++--
>  7 files changed, 93 insertions(+), 8 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

