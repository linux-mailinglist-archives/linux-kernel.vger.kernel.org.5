Return-Path: <linux-kernel+bounces-154930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ECF8AE32D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B894A1F218A9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF58C75817;
	Tue, 23 Apr 2024 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="GWjWXBv7"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CC7626DF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713869795; cv=none; b=sEhdc40t7u8g9oEJylKpmvqivHcSFBXRzUn2gQpb0aSkFWiCkrby7eiTBeDILCYjzwiRz/CRKT3jtD7Nq9yMa4JzsKYKOwbJUSQFLNJp1iP0eiUlFaSAMm0W3dTCefpcbEKcNu4iYG1p8ak1cgOjyxEaTnOh5fKe9Sg5BkO4ncE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713869795; c=relaxed/simple;
	bh=o3+E/pVcXMqGN2IqmycMoE4DCLdrwAivCv4tvzqB9Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piKZBBiz2f2sf2Z0kx3oePyvuDfPD6QTLPuQCVL+NC2jKR+XSCeHkgaGybquXZxg8ViJKsQexHTtdBmDi+8qj4NgsN69KGxClfJE2V9yakdyr1tlvEO1MSxx40reWFHTPiF+orccmrCrdZWcfx2mNqOlFqxEM6jnuw4c1K8t4WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=GWjWXBv7; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a587831809eso86418966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713869792; x=1714474592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f7A3dJbrWY/9z1NTPLr/SP8VA+syiS13CnbQZQzTmh4=;
        b=GWjWXBv7Cn/wPbJp28rCO/HzDYzjI29GOdYQTrarblqKOgDeYn3CMGmc/GwGIkH4It
         iB3UMMD6o4gBTSzyTAEtPmdUsIT2n0REd682t2ojxM4ti9Dm/fCioytcnGeCadF8Qcjn
         BpIBgOr0VFARD/PwKTh7SXuBs8aHgvSqqdh0f42hJm7nDib5NCjiC60yYWVYaaH4MUys
         D+SXlayKn1e3Do3FKERf/5Gpxhj/xYw+NqF2h6vvfqEx9ZO+s0abjW2tbqyjiCAWdSVl
         BrPOEbTJ3p9kwUvePL8lXjN2ZBgRJNamoLAcGjwbn8i8Ynaw8PSDXBTbMCdblEqWu7F4
         7wCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713869792; x=1714474592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7A3dJbrWY/9z1NTPLr/SP8VA+syiS13CnbQZQzTmh4=;
        b=RL0zPWeNn9s8Pewom4ASsdvnUQx1qdvuNLvkjjmWCE6mUdsAMOcgQw8JRlIYMyPInD
         Q4W7LPG6a9hoZbv+4Hq9HYDLSWlEzVQ1FNDf41qpi8yIlaP0LEZ/UKwq4BZ7VDWY+BIn
         Ulv7rtVkXRXUyna4EAdGbzrzsbKPmZ4GsEXUx9+nd20JLUjArcvCQlh1baCtk9ECg1JF
         gZ9+OmXzfRZ76SZ4VDQvs4Vy9SM1E/MOjHgVgaaLYWbGUyUIkyqkPni1TiRJkkuA0Tvl
         xiu4v4gvUWo8TF1AKpGHRRsM0kgb2r3k07ap3fXaPCWW136Gq/LSlEgxciRV4oe4ZPOX
         k8Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVs9xd/aQIuHTNaE4ITtVkdlrmQ/X+JDrZfxDSMy8ASWmGir2C+eWxN6uj0JT5ouuUO7mSgWuUN8HjOnTQGYLfkpJbnGGNTwJ+rf7T6
X-Gm-Message-State: AOJu0Ywb/f4DPwfe+gKHwAvTngda1DsNYpsKYkfLzrWCyLcgwu+chEyH
	logf1SInky4LgYS/EG3uiDqdTd9XZKcFbMf02k6Xe8aGutHwqHVLlIDD81d3XTkYDhI4VkFlREs
	Nnp4=
X-Google-Smtp-Source: AGHT+IGuxCj+bPVMezQTiiqaIkHubBLsXlhj+D610GPwkEGBc0PyN8R4nZYOrEBNLFuAizVxpXXs2w==
X-Received: by 2002:a17:906:3502:b0:a52:22c4:8158 with SMTP id r2-20020a170906350200b00a5222c48158mr8092139eja.56.1713869791624;
        Tue, 23 Apr 2024 03:56:31 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id c27-20020a170906d19b00b00a5557bc8920sm6916846ejz.54.2024.04.23.03.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 03:56:31 -0700 (PDT)
Date: Tue, 23 Apr 2024 12:56:30 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Atish Patra <atishp@rivosinc.com>, linux-kernel@vger.kernel.org, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Anup Patel <anup@brainfault.org>, samuel.holland@sifive.com, 
	Conor Dooley <conor.dooley@microchip.com>, Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, Will Deacon <will@kernel.org>, 
	x86@kernel.org
Subject: Re: [PATCH v8 24/24] KVM: riscv: selftests: Add commandline option
 for SBI PMU test
Message-ID: <20240423-b25d0b1540d2092f5370afa5@orel>
References: <20240420151741.962500-1-atishp@rivosinc.com>
 <20240420151741.962500-25-atishp@rivosinc.com>
 <724a4797-18dc-4011-ba48-445c1cb6a976@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <724a4797-18dc-4011-ba48-445c1cb6a976@collabora.com>

On Tue, Apr 23, 2024 at 02:03:29PM +0500, Muhammad Usama Anjum wrote:
..
> > +	pr_info("Usage: %s [-h] [-d <test name>]\n", name);
> A little weird that we have pr_info named helper to print logs when it is a
> userspace application, not kernel code. I'll check it in the source who
> added it to the KVM tests.
>

It was me, as git-blame will easily show you. Why is it "weird"?
Applications have needs for pr_info-like functions too, and the pr_info
name isn't reserved for the kernel. The only thing weird I see is that
I didn't differentiate pr_debug and pr_info messages. I probably should
have at least given pr_debug output a 'debug:' prefix.

Thanks,
drew

