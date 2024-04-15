Return-Path: <linux-kernel+bounces-145267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 605A38A51AB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9228E1C227F6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03267A15A;
	Mon, 15 Apr 2024 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="d6kMSAdi"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D5278C9F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187897; cv=none; b=uBn2SirAZRdjsSJcluSXIGVU7eF13oMzxRr0S4fxk15BemJ+qgxS9+J6JcB5sRS+3bauRP0uREgFGF7QgHFHNbvj76aO7/HgGYKbuyAZaBBYVS3gNk5BJq6Pc9gZGDPe68mvBxMRUUq18rxH7KmcVQy5qvAL+RPtFqhivU+sVoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187897; c=relaxed/simple;
	bh=5WAhOh6+YNFbemGNWCEJZjikj9RLzeY4/BZOTZkwkkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkSyfjvS1kzysPP/O2D8vz0YOG8ti2GyGeHjI/NCAHZf/SwQgz5cag8khstPtYtI9PLN/aSAoPtSsQH7ANQ68l5MzEu3Nq+GhmMdBQXjxsnfWgD5ipsbjJXwRKr+LUFmwGNjLfaLvvZUvUSHTCtCaESWTI2d3e/8GsD6lzraXi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=d6kMSAdi; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4182353a15cso10476545e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713187893; x=1713792693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KE+Cpvnrr9PFeeWoK6ioKoV8XULExBLcSObfZiwRf6E=;
        b=d6kMSAdipTxsOD4NELJ7Bq/ijvD0PfBcgTlyi1ZDl9GMAx+2ejSzqPXv22TRd1g2Bj
         +ULip5ofGCpxcEexNjLYUZ6HRUGUAHCe3Ii6GUGqEX0kAURLSQYvFL4i5DjN3DYDVuJE
         hPlcWYMVj1a7IQkBBPYRuGxFwLe0Pl5MN7Sr3fTVdEbjrH77PLtM6p7K3A5HTDhwemh4
         F63S9igtICEFu9KP7C40HOceDgbtiGqQww8dtF0f5kMlssuzsx9AmXf+NfHljt9jdrAg
         T4MpzWfz7wBbDLm982CdXWGmsEce98E/LtlvdSExzULwvxsNQ4y6TzKnvbBW+gvYVjQ6
         4mfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713187893; x=1713792693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KE+Cpvnrr9PFeeWoK6ioKoV8XULExBLcSObfZiwRf6E=;
        b=Qhtpeqg9pmNLPVAXkkWY+nrLcG5q/PlMsPu07HBzL/A0T69G5p0XimFdUbKHcE6dfX
         vmzB53ZQ1DSkEc07+QEHYtisYiqEYLOqQEnLQwGoOnh4ZfWqxSdrNLfiymu29liiNyFK
         uOnAUfzF1/NmMsBKlED5eodtOvasRl20BDYQ0LOyvSSpcovOitp84SjD3cnwdxRBvNrH
         dTswbNnNBwwNkSGE0sbksD0YVz+ACfMYZiQSc3t1lYj6h3MoYA2sI4rCLa9hWJLKGp9l
         8mGO3319DlQIaUdGWLP5TipW7YfncVrFTp0TfQBkJeJEeTfBLOtI/evAuVrkz28ffN+K
         YtRw==
X-Gm-Message-State: AOJu0Yy39O9jN5raFN4TOfpqgKMJ17T4wPAC3xl/9cNWiY6LEYvq98X5
	O1Eq0aGOjmYcXqP/7cGrfkOFOoraBRP7ZxdWqsLBeHqHu9MMD3qU8XObQWTbdKM=
X-Google-Smtp-Source: AGHT+IEyD5MBvbEAjbw0tg7O5uE23K2svhSCaSMgsgY2nQ2IFrtDTCQqzK+yEHIFjtQaAGU4qZut+A==
X-Received: by 2002:a05:600c:3b98:b0:417:e00c:fdb8 with SMTP id n24-20020a05600c3b9800b00417e00cfdb8mr8462561wms.1.1713187893433;
        Mon, 15 Apr 2024 06:31:33 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c4fc400b004170e0aff7asm19061196wmq.35.2024.04.15.06.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 06:31:33 -0700 (PDT)
Date: Mon, 15 Apr 2024 15:31:32 +0200
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
Subject: Re: [PATCH v6 21/24] KVM: riscv: selftests: Add SBI PMU selftest
Message-ID: <20240415-05af8386b8ebe9aecf37c1c8@orel>
References: <20240411000752.955910-1-atishp@rivosinc.com>
 <20240411000752.955910-22-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411000752.955910-22-atishp@rivosinc.com>

On Wed, Apr 10, 2024 at 05:07:49PM -0700, Atish Patra wrote:
> This test implements basic sanity test and cycle/instret event
> counting tests.
> 
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../selftests/kvm/riscv/sbi_pmu_test.c        | 369 ++++++++++++++++++
>  2 files changed, 370 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

