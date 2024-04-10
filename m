Return-Path: <linux-kernel+bounces-138045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0670A89EB7C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89524B246AE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784B013C91F;
	Wed, 10 Apr 2024 07:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="QjBUHcUW"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4EF13C90A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712733019; cv=none; b=q5ckhjxIbv88lGQV9FrCgJEBudnUan2Ux+4BTOewlmP2OpmgIDeW1AipUieKhZ8BDDOFqiGRO29DGjY++1Z35BDxH43sx1tMfTWlFwiaHspGxzz0xZ+RFCq9cSomhUHm/8sUrKXepoOq8nQG4pACBGqFvGhl3LB/M0ddCNZURUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712733019; c=relaxed/simple;
	bh=jsUeO4aThyaUmwXMlWYckJ8eYmsW8VRj/SiTQghFA3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lY+2PenJ6HyGb0wvBUyM+jz8pYU58uTirXQ108H1kqd9i4TuguQExF52Vato1b5WhuNpvKNGqIzZuoOaqkTTgyXH/gdDg1doEY3AKOdKsjVRu/5n5YMgiV9GIuzgFkAYoGJxjDlT0ffZdljlTayHIplE632JkseI4gnYE6wqH7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=QjBUHcUW; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so1060068466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 00:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712733016; x=1713337816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SZ18eCyb0XZAICmBnfaeK08LTmFa9T66gJC4R8KSh1g=;
        b=QjBUHcUWsg5aBfO24tD4F8EiCQ3cwjhXz0vrMi5nC4zr4V16fB/f9+3b+KVCHdHBK7
         IofMsxkORXwX2iE7PeMEE514AA+V5XYnyM8/mYJFj9pHRGm1eO//I42XpSLiZGHZgFpj
         tDKaH01ObaxVZqJ6n8Oz2AjxWoMoLWHH2I+KuOxEi3Sj8S+45SejNK8kETCUi7okcmzL
         wjcKqfdAlOR61ORevVzgSqMOQrXvBn7EF13uxcO0yncSMfknArV/ElXVMIXCyPaopdhb
         dlhoJzAvXU7+oyD5GJIm++tIRleYlnqsbVWIl0Dp+ULr/z1cyFZiaTVxrxXJCfLCFur+
         3yEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712733016; x=1713337816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZ18eCyb0XZAICmBnfaeK08LTmFa9T66gJC4R8KSh1g=;
        b=OiH3nP+A1Y1PNCW8SSG6NLyuIKm3+CwuGIvK13X2fLsut5hZ3X5KxgQgBU1yzp6mHD
         8wDnayacif49X+wjChL/X/+WDNdhbNwHAXiEArgkYS0oEyOvBZQkTuDc1wFHW963DUef
         2lVUezMYDujU07V//v4mpoQAe55FvIQAx5kiimnAQ4CTWfuvzRO5ElEPi7mfR7Rn+tEg
         lP06oteFd+iTCNxZV+QHLHuHyIH5zoS7m2ylzBQmTd0yCjHEMa08OamKzz1VkkBWRpc2
         E90qdtZ/4g0OwTnuPYp96RXfMJh+I/28GcknZcAP80nFjZ1PVc3nPP8J8cqURbSNoXzV
         nohw==
X-Gm-Message-State: AOJu0Yz/kKzeZNBzYPFyBoe2Cpv2B0dz4qAcZicsMS0jDfW94Ca3Cqjz
	nVVsUCJ2NmSiFYHRxMN6cNuTdxaxBpODsHpJSQo/z+dU6nByYtx8oXCvIVwmEOk=
X-Google-Smtp-Source: AGHT+IFxljZJ08Uz0yhQgpMjKNeXFWA7BWx83bzmmJAW4p2u+kQE1tRwcsho9/acuSekX0UatVujKg==
X-Received: by 2002:a17:906:2844:b0:a52:a25:2077 with SMTP id s4-20020a170906284400b00a520a252077mr982535ejc.14.1712733015975;
        Wed, 10 Apr 2024 00:10:15 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id l15-20020a170906414f00b00a519de61bebsm6612955ejk.137.2024.04.10.00.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 00:10:15 -0700 (PDT)
Date: Wed, 10 Apr 2024 09:10:14 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>, 
	Ajay Kaher <akaher@vmware.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Alexey Makhalov <amakhalov@vmware.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v5 21/22] KVM: riscv: selftests: Add a test for PMU
 snapshot functionality
Message-ID: <20240410-2a41e43624596a442d6a95cd@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-22-atishp@rivosinc.com>
 <20240405-4e840120e8117c286cb593f9@orel>
 <8748dbed-d105-4f26-a808-667c3b56c8ec@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8748dbed-d105-4f26-a808-667c3b56c8ec@rivosinc.com>

On Tue, Apr 09, 2024 at 03:52:40PM -0700, Atish Patra wrote:
> On 4/5/24 06:11, Andrew Jones wrote:
> > On Wed, Apr 03, 2024 at 01:04:50AM -0700, Atish Patra wrote:
..
> > > +	probe = guest_sbi_probe_extension(SBI_EXT_PMU, &out_val);
> > > +	GUEST_ASSERT(probe && out_val == 1);
> > > +
> > > +	if (get_host_sbi_spec_version() < sbi_mk_version(2, 0))
> > > +		__GUEST_ASSERT(0, "SBI implementation version doesn't support PMU Snapshot");
> > > +}
> > 
> > It's a pity we can't check the SBI spec version that KVM is advertising
> > from KVM userspace. Normally we'd want to check something like this at
> > the start of the test with TEST_REQUIRE() before running a VCPU in order
> > to generate a skip exit.
> > 
> 
> Agreed. I will send a separate series for that as it is an ABI change.
> 
> > (We probably should allow reading and even writing the SBI spec version
> > from the VMM in order to better support migration.)
> > 
> 
> How that would work for SBI spec version write use case ? For migraiton, you
> can't go back to older SBI versions in the host. Isn't it ?
> 
> Considering this case your VM is running with PMU snapshot as the host has
> SBI v2.0. It can't be migrated to v1.0 and expecting it work. Correct ?
>

We can start a VM on a host with SBI v2.0, but tell KVM to tell the VM
that it has v1.0. Then, the guest shouldn't use any features from SBI
that appear after v1.0 and it should be safe to migrate to a host with
v1.0.

A more likely scenario might be this though:

 1. KVM userspace checks and captures the SBI version of the host where
    the VM is first being launched, e.g. v2.0
 2. The VM gets migrated to another host which supports something later,
    e.g. v3.0, but to
    - avoid possibly confusing the guest we tell the destination host
      that it should expose v2.0 as the SBI version
    - allow rollback to the source host without concern that the guest
      has already seen v3.0 and started to use something that the
      source can't provide

Thanks,
drew

