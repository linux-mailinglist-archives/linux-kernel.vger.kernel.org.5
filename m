Return-Path: <linux-kernel+bounces-90623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C878F87025E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5171C233D5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068323D972;
	Mon,  4 Mar 2024 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LJgRO+Hb"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ADE3D3BE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 13:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557856; cv=none; b=M+KTOEOTSpJsfJU0hlAqrvULbActfKoyNFLBR9yY7riMKsvpATH8ip+P7S/0Iww7jAbb5cYiQdNdwCHZAiAcWqpRPiDsZwCWSEs0QKe5esV1V8JBbMThm8F5IhJ9JucIxdhHwUSVGGiEDOGO4v/f1fTJIPajQsoZKFU1PQIiP9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557856; c=relaxed/simple;
	bh=edMqvmg6y2VKb4yfnj4dW1OskK2vzKd7zQJdJKQMyrs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCRp6mQoDgRDZn4rWQEPDi9O7XtEf01s5e5FBg4hrB7etpNWitsSdqBh2vfzMnudgnahR5fP49un8Q+rhWsDxMq5PihmUCwOmMMGoveAsv87ogUJyNNWvNctmWvHPfhyzTh7ocZkSwDueLJB0H4y5wZwljd16X+wmn3SN03jDMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LJgRO+Hb; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3f893ad5f4so669614566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 05:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709557853; x=1710162653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z3m7OivOxzJeGdkMzIGOv6kRagQeqCuoThPb8xlNbgo=;
        b=LJgRO+HbeUy+EAApm7gnwP1G5T1RzxP/43RuN159JitjmB+tqdik+WseMa7ppc0Lsw
         zFJ/Qi4F2nmvJIcG0J3r6XAbWwoibIB/l1J8L0LBqT9cfVHrFCP2fSuj53GXHlK2MgTN
         KOf4NIk6XpxoKoJopFvDojC8rQWS3tpNWkF60XOnb7NXm0Lmo8pL0YaDTLyRvX8bLHFx
         a6kbFFniAVqz0C8/pXNe+MUMsm03pMjJFqyu0ozGtPkTCqoCZER98AHfi/8SUIdOYHEL
         SvLwOaZvfecGr7W8VQxZHVJqAJUUAuCNp9lon7ghkhiS3+vIlx0DPSIQplF9fjXXF24I
         Arwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709557853; x=1710162653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3m7OivOxzJeGdkMzIGOv6kRagQeqCuoThPb8xlNbgo=;
        b=KBcTNCPJ1j5yKjQP2Ehy8B0t9CbVD6wyk9H4SPINxNM18u6r/0phYD74UUCXFc9IIT
         pbwTxOXRYmDzrrmB3wjIymVg/ptfWKRh9xcAnQT2HcfbLI5S1hoHBEq4bGxkeznvpZoH
         GqQxSwr3dS35mz9F9jW9DHJ2b4h4Zt86NG0DRkNs/KVn570bbranl5PtQ5Ki4N/E6thm
         To5UwiOmJGIl/IuTDHyMK9aklyYcc3WtpVqSTigc7S0svs0dt3ZXgLnOoWCbe3ihi3/x
         ceeQoLg+A6f4ZYRT1qnS4b4L29KuvQe1bweC5I26PJehQVgsPNae8g/WhgGaoO5qnGe6
         GJCA==
X-Forwarded-Encrypted: i=1; AJvYcCV9s7VM/rm5aYaKqACHzogVX68iwy0gHnz+6e8u85osT22FPWcCFneIooeV1XkAbdrpUwE4ny7DE8NjTOhUR3aUoUgkHpgKeETOJtaP
X-Gm-Message-State: AOJu0YzgqehuTRhJ5+XcYr1hwxt8hmSb6lHfPtzJ+JAJfqa2Z7QN3Ttj
	mRT6eytpBEySe/l7AHN5Cx0VBW4MXeeTcRfreRJ5NT0/ObARNIw5uEA0pGEo3g==
X-Google-Smtp-Source: AGHT+IGrvXADFoe0PTlXPw7y7hmD/cJqKu6+s04vNFfdc9+9OA1wUWqNlu47ZlZ+Fh8V1+pbnqa8SA==
X-Received: by 2002:a17:906:4f09:b0:a45:70b9:252b with SMTP id t9-20020a1709064f0900b00a4570b9252bmr965095eju.57.1709557852486;
        Mon, 04 Mar 2024 05:10:52 -0800 (PST)
Received: from google.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id r18-20020a1709067fd200b00a4589f3392esm98523ejs.207.2024.03.04.05.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 05:10:51 -0800 (PST)
Date: Mon, 4 Mar 2024 13:10:48 +0000
From: Quentin Perret <qperret@google.com>
To: Christoph Hellwig <hch@infradead.org>, Will Deacon <will@kernel.org>,
	Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
	Android KVM <android-kvm@google.com>,
	Patrick Daly <quic_pdaly@quicinc.com>,
	Alex Elder <elder@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Murali Nalajal <quic_mnalajal@quicinc.com>,
	Trilok Soni <quic_tsoni@quicinc.com>,
	Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
	Carl van Schaik <quic_cvanscha@quicinc.com>,
	Philip Derrin <quic_pderrin@quicinc.com>,
	Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Subject: Re: Re: [PATCH v17 19/35] arch/mm: Export direct {un,}map functions
Message-ID: <ZeXIWBLVWzVycm0r@google.com>
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
 <20240222-gunyah-v17-19-1e9da6763d38@quicinc.com>
 <ZdhEtH7xzbzdhS2j@infradead.org>
 <20240223071006483-0800.eberman@hu-eberman-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223071006483-0800.eberman@hu-eberman-lv.qualcomm.com>

On Friday 23 Feb 2024 at 16:37:23 (-0800), Elliot Berman wrote:
> On Thu, Feb 22, 2024 at 11:09:40PM -0800, Christoph Hellwig wrote:
> > On Thu, Feb 22, 2024 at 03:16:42PM -0800, Elliot Berman wrote:
> > > Firmware and hypervisor drivers can donate system heap memory to their
> > > respective firmware/hypervisor entities. Those drivers should unmap the
> > > pages from the kernel's logical map before doing so.
> > > 
> > > Export can_set_direct_map, set_direct_map_invalid_noflush, and
> > > set_direct_map_default_noflush.
> > 
> > Err, not they should not.  And not using such super low-level interfaces
> > from modular code.
> 
> Hi Cristoph,
>  
> We've observed a few times that Linux can unintentionally access a page
> we've unmapped from host's stage 2 page table via an unaligned load from
> an adjacent page. The stage 2 is managed by Gunyah. There are few
> scenarios where even though we allocate and own a page from buddy,
> someone else could try to access the page without going through the
> hypervisor driver. One such instance we know about is
> load_unaligned_zeropad() via pathlookup_at() [1].
>  
> load_unaligned_zeropad() could be called near the end of a page. If the
> next page isn't mapped by the kernel in the stage one page tables, then
> the access from to the unmapped page from load_unaligned_zeropad() will
> land in __do_kernel_fault(), call fixup_exception(), and fill the
> remainder of the load with zeroes. If the page in question is mapped in
> stage 1 but was unmapped from stage 2, then the access lands back in
> Linux in do_sea(), leading to a panic().
>  
> Our preference would be to add fixup_exception() to S2 PTW errors for
> two reasons:
> 1. It's cheaper to do performance wise: we've already manipulated S2
>    page table and prevent intentional access to the page because
>    pKVM/Gunyah drivers know that access to the page has been lost.
> 2. Page-granular S1 mappings only happen on arm64 with rodata=full.
>  
> In an off-list discussion with the Android pkvm folks, their preference
> was to have the pages unmapped from stage 1. I've gone with that
> approach to get started but welcome discussion on the best approach.
>  
> The Android (downstream) implementation of arm64 pkvm is currently
> implementing a hack where s2 ptw faults are given back to the host as s1
> ptw faults (i.e. __do_kernel_fault() gets called and not do_sea()) --
> allowing the kernel to fixup the exception.
>  
> arm64 pKVM will also face this issue when implementing guest_memfd or
> when donating more memory to the hyp for s2 page tables, etc. As far as
> I can tell, this isn't an issue for arm64 pKVM today because memory
> isn't being dynamically donated to the hypervisor.

FWIW pKVM already donates memory dynamically to the hypervisor, to store
e.g. guest VM metadata and page-tables, and we've never seen that
problem as far as I can recall.

A key difference is that pKVM injects a data abort back into the kernel
in case of a stage-2 fault, so the whole EXTABLE trick/hack in
load_unaligned_zeropad() should work fine out of the box.

As discussed offline, Gunyah injecting an SEA into the kernel is
questionable, but I understand that the architecture is a bit lacking in
this department, and that's probably the next best thing.

Could the Gunyah driver allocate from a CMA region instead? That would
surely simplify unmapping from EL1 stage-1 (similar to how drivers
usually donate memory to TZ).

Thanks,
Quentin



