Return-Path: <linux-kernel+bounces-165410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 110BE8B8C64
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFAD2280402
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB6C12FB03;
	Wed,  1 May 2024 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HOoF+NRT"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFA112F367
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714575454; cv=none; b=iz2p+0jMSxC3BZaYNW+7jBXl7jNDs4fm2Qlmaki3jLY52J2B7mo/yQd9Glac2owlTvxHPu21wk6YNmNgWVGhxI5d3UPx6DbL/Ql8k3iuX73hwHPqDkrLuZGztVnGG/Y9lCagGe7PeIavxFMz8wqnF15LnF/julj3v7h8RGxo4ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714575454; c=relaxed/simple;
	bh=ap3BJox/MGVOgxqCNy7fpIJSXCiWokvcBZnrVfJZjT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQbKgoCO3c/paFaXzYST4MUptTGXk50O5oIIcknvqOhR5MCI8LzKx42hMaZZWzm/p1QesqVfqWA06X9S1Z1anMLT5J6seeAnvZ1m/AZqoQelaAA2MRj0Be6iCF1uKc1LE2SJDRU68T2EXZs62JViZRA9up/QbBVjMas2+AT0cjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HOoF+NRT; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-790f91b834cso275434585a.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 07:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714575452; x=1715180252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yMDuFgQIFZusBttFcIEeiK3dO+QLC27z5ORAgCsbWKI=;
        b=HOoF+NRTkf8cPp1HPVTa/V5KOkmGUnuM8FNW+ZEucrvVRizDSeLFkKBZROoOzxNCF4
         n33yNkaSdydbS1b3/8IYdH/HOZzrNzzYNBQF14eHvT8TgvYvx7gtvoNZ0igxXiTxuk6P
         adM+7ijguEhkjQgivQDLPws4moV+nPvGjU5W6G79rvXeNZ08wiGGrlIJ4lqYgk0A9EMs
         Ndhe2/AwLgYUx1EBqarKnj+us1MVaPheOS9nFMyaQHic+xBM7JndmP1uihelnJ4mbdR3
         PHCXb/afHLM/4PucqpXlf/pUzyFsn2foa936bOrw+0k6zfsVZBu9rXjfgDQMsgak9ksv
         VPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714575452; x=1715180252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMDuFgQIFZusBttFcIEeiK3dO+QLC27z5ORAgCsbWKI=;
        b=Fa3b2fjwIjB7+ROoUiplgLcFN1Wd+7QaJHLRg6/fSq18InwTtj5mUiqflpdqw+Aj+f
         4hRzkEQMjFBzEtvk5hZVdiWQRqV4yjWIdP8SmvoJGsj9jJwKzS56Y8UQrxH8T9POOZTx
         iVp/dwmhlLupbq0ZW8IhoDoKudTKH+M/4OyccXtGd/KrPD4zQuHhsYTfgqLyuKVsMgfr
         1MHxvH7LJQS78si2Epsrn6EnwpC44pI14iX0gB2+/XAq8xyv9akESxSw8X2lSqrlCwaG
         F8TjKA2xlz6iWbFiTAk3S6vS4u3nngy+3Y7TjY3rSrxeG8p+qTBtwfsK9YH5WZfTuEN8
         HV3A==
X-Forwarded-Encrypted: i=1; AJvYcCV2prPsvDiCTnypyvq2zXK5tmwbosq5meWR3jlJOWgDrcsR9kEWwoyQyyKNqo7knZMIAkOH9Q06emYj4n3tAm3r1npxL+mzx9d7R1C+
X-Gm-Message-State: AOJu0YyBpr/+XhdY6Tv9EGjHgfZjl1dNVTGsCd0EIpXvCXrPs8kW3qRO
	svg0QM4l+2/Eblz8AzQHUuv8qeqhk8MYKnzmSbbnL7xrk6kTRVTJmoVjM9OWJo4=
X-Google-Smtp-Source: AGHT+IHmOIDK/Mldt2hAVSSoxj1UCLR3AUkPhDiQrlj4ZsACrgmp5YSJE5CUYE4eJ91yhllDRNrddw==
X-Received: by 2002:a05:6214:2486:b0:6a0:cb42:993d with SMTP id gi6-20020a056214248600b006a0cb42993dmr3978427qvb.23.1714575452398;
        Wed, 01 May 2024 07:57:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id g18-20020ad45152000000b006a0af6e25c2sm5039912qvq.94.2024.05.01.07.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 07:57:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s2BOl-00DcLt-Fb;
	Wed, 01 May 2024 11:57:31 -0300
Date: Wed, 1 May 2024 11:57:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@rivosinc.com
Subject: Re: [PATCH v3 5/7] iommu/riscv: Device directory management.
Message-ID: <20240501145731.GE1723318@ziepe.ca>
References: <cover.1714494653.git.tjeznach@rivosinc.com>
 <ce3b82a20db0b776685269674ce9b7a926d5680d.1714494653.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce3b82a20db0b776685269674ce9b7a926d5680d.1714494653.git.tjeznach@rivosinc.com>

On Tue, Apr 30, 2024 at 01:01:55PM -0700, Tomasz Jeznach wrote:
> Introduce device context allocation and device directory tree
> management including capabilities discovery sequence, as described
> in Chapter 2.1 of the RISC-V IOMMU Architecture Specification.
> 
> Device directory mode will be auto detected using DDTP WARL property,
> using highest mode supported by the driver and hardware. If none
> supported can be configured, driver will fall back to global pass-through.
> 
> First level DDTP page can be located in I/O (detected using DDTP WARL)
> and system memory.
> 
> Only simple identity and release (blocking) protection domains are
> supported by this implementation.

Why rename the concept? We call it a BLOCKING domain, just use that
name please.

> +static int riscv_iommu_attach_release_domain(struct iommu_domain *iommu_domain,
> +					     struct device *dev)
> +{
> +	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
> +
> +	if (iommu->ddt_mode > RISCV_IOMMU_DDTP_MODE_BARE)
> +		riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, 0);
> +
> +	return 0;
> +}
> +
> +static struct iommu_domain riscv_iommu_release_domain = {
> +	.type = IOMMU_DOMAIN_BLOCKED,
> +	.ops = &(const struct iommu_domain_ops) {
> +		.attach_dev = riscv_iommu_attach_release_domain,
> +	}
> +};

'riscv_iommu_release_domain' doesn't make sense..

Jason

