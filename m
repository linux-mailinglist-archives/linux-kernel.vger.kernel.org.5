Return-Path: <linux-kernel+bounces-155610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5B78AF4C5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2CF1C22494
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5B113D8A8;
	Tue, 23 Apr 2024 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="A/Wl6+zC"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7946313D625
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891643; cv=none; b=S7CaOYfnaTFtr9S7CcuEImLX1TbyxwskqjGekjNxuCrrqV2Ju/WPg5XP8Y4f3GW4NgDFqCF0unZH5RZ4+ONHLUCd2980X1XuKw8E2IYR1Ty4sXIanh7nys4f34mewSNQXI/vShuh+6vRzvTnzXU4AHo+kViySqsTZGonVWyGctg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891643; c=relaxed/simple;
	bh=koJE8orB6Lr920KYY5A47CTkKeZrCUS3/cmdeXdfgCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeHfDym3G+ofELL7VzB2RDOOjojpB3BTJVnqp5kJMB4dj5bw7fqIyo7VtFDX2Zgz4QoURIisVtkRy7pDAk+l865qZL9pSSkdrh6WZ4KPFIrGLuWW5ejlIFoinHU9vg1IaWY9KPCEPpjsdsiGGi/StId/CCFiexHLDdVekycXB+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=A/Wl6+zC; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a55b93f5540so293589766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713891641; x=1714496441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7kpoRkSgmIbeAMxE5jSosiKeK58hdGccskOzXdueAwo=;
        b=A/Wl6+zC1A3ocpvhH8Q4p1DLqofzfPNJL6aEDJ+3gSE0lpesO30tZTBwPTxtnVk2Af
         JqyshzowNUAK9IrprDrU7cj23vj1BrdgehgNy/AFD43u12gDQlHUaVxWB0kE7zMrelOB
         TtHUuG9DhZ0Zy0UpTaXTT+FC6OTJIQcl5PiR+a4h5Lw3kTLlVLetJ9NLnP+ucuFdjirK
         305BkRYqooN0uBjgDxa7tFkDEQpd+10tCt/6fvsezA7lPpFr4O+iV9EQv+h6uC4lyLHb
         XnfhSUcOVRpoHqZqV5CuUQbewkhTeapl+4/BY0E0GSf1NtNcbnxMiGWsKVlIWr5rEFcr
         NQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713891641; x=1714496441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kpoRkSgmIbeAMxE5jSosiKeK58hdGccskOzXdueAwo=;
        b=bpG3SBb+Yd2uItXcUHsMf6ZT80KiTZhNN2qVfF6PW3Ef++Avr0YmuuatRpzE5DisxD
         6E5Bx74d9CgDtykXcCBgyRLtRbnwOY6UAIVNGadiyT14UAo22vXOSUH1o6HWRVp3WBv0
         kvpQHkfJ9Fc+i8b1GXVqAizifWz07zJyisbTZKKqBYmyC3aUUqpOOaKjTpkIPITxe2qt
         BM1IRSh+tDlueo6dDjLpRiPWM/y6taTHz/pDiSeuet6+q3vCL4L281wlliOBhifEs507
         XQIs6adgb8CYQeF58TbaS2+LEl58ojjoxHjqfbMeDNaB4cFcqq2sAGxOytfiKlt2UnGK
         iEIg==
X-Forwarded-Encrypted: i=1; AJvYcCXED90eK1eR6OTJO5DbN/jQ94l8dAlNeZNSfmCZrcPprj21f3aKVRFgfL/QKtCSesIbgmWFRd11+HyfJNXGJYO2HeyMEeY7G/au0IVJ
X-Gm-Message-State: AOJu0YxWrwx75+kIkUOzdDVbouSxrGueuKu5PUwsoJB8FELc5hzCl+jd
	nzrOjYAA8rshhj0BqxaNncnt7IvvZ6WXnKLNa8TyKAxl80MA/LhWOjnRTFSYEBE=
X-Google-Smtp-Source: AGHT+IGcGANkzjcqPRS58akjvbDATplTwj1qOXK/GFOuWc3MEiIWZm4cD/e4azAjA7fogSoeRMZxBA==
X-Received: by 2002:a17:906:5857:b0:a52:2772:b9cb with SMTP id h23-20020a170906585700b00a522772b9cbmr8740381ejs.24.1713891640539;
        Tue, 23 Apr 2024 10:00:40 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id z18-20020a170906435200b00a4e657a5f1asm7220478ejm.112.2024.04.23.10.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 10:00:40 -0700 (PDT)
Date: Tue, 23 Apr 2024 19:00:39 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Anup Patel <apatel@ventanamicro.com>, devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com, linux-kernel@vger.kernel.org, 
	Rob Herring <robh+dt@kernel.org>, Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev, 
	Palmer Dabbelt <palmer@dabbelt.com>, Nick Kossifidis <mick@ics.forth.gr>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 7/7] iommu/riscv: Paging domain support
Message-ID: <20240423-64e0112d612ab1f011c4b26e@orel>
References: <cover.1713456597.git.tjeznach@rivosinc.com>
 <301244bc3ff5da484b46d3fecc931cdad7d2806f.1713456598.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <301244bc3ff5da484b46d3fecc931cdad7d2806f.1713456598.git.tjeznach@rivosinc.com>

On Thu, Apr 18, 2024 at 09:32:25AM -0700, Tomasz Jeznach wrote:
..
> +static size_t riscv_iommu_unmap_pages(struct iommu_domain *iommu_domain,
> +				      unsigned long iova, size_t pgsize, size_t pgcount,
> +				      struct iommu_iotlb_gather *gather)
> +{
> +	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
> +	size_t size = pgcount << __ffs(pgsize);
> +	unsigned long *ptr, old;
> +	size_t unmapped = 0;
> +	size_t pte_size;
> +
> +	while (unmapped < size) {
> +		ptr = riscv_iommu_pte_fetch(domain, iova, &pte_size);
> +		if (!ptr)
> +			return unmapped;
> +
> +		/* partial unmap is not allowed, fail. */
> +		if (iova & ~(pte_size - 1))
                           ^ Shouldn't this ~ be removed?

> +			return unmapped;
> +
> +		old = READ_ONCE(*ptr);
> +		if (cmpxchg_relaxed(ptr, old, 0) != old)
> +			continue;
> +
> +		iommu_iotlb_gather_add_page(&domain->domain, gather, iova,
> +					    pte_size);
> +
> +		iova += pte_size;
> +		unmapped += pte_size;
> +	}
> +
> +	return unmapped;
> +}
> +

Thanks,
drew

