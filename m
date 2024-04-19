Return-Path: <linux-kernel+bounces-150952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1325E8AA718
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4478F1C20B6B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF7879F9;
	Fri, 19 Apr 2024 03:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyCch/jV"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9712F29;
	Fri, 19 Apr 2024 03:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713497010; cv=none; b=dHfQd8nPc1UI7DJ5e2sj92uCYR00yQoOI0RLBafYLF1mDoF+pH41braZDCNsuET03CKsc1NtYKnsGSsAFK9OaRW6vjIGp95J6zLVOm77p2v/qfkSeErjm/VVypIXrEurAtX6PkRDDOrk2W4B7CnJgNL4A6BbTqvo5sDqmdbSxwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713497010; c=relaxed/simple;
	bh=SUmuINA+bjdWdk4wF+C/KB+0NtQvv+XG/HKRIM+2tWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hjIaksJ0mTu3ttm3pRTUZSg/tt9/n4Gg8Jirojv17sBfzRUizf6SkBm+xcrGYlOaUTrT0PmBq2Xt3Hi1pr3PFnn2ZUX+sp1we/6M64VIWNAquW+8u31p854e3dGgmUx4bQ6Srjcy7+hce16vcD4REKAy2hqEPo7AUByPAFxca3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyCch/jV; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1e2bbc2048eso13830525ad.3;
        Thu, 18 Apr 2024 20:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713497008; x=1714101808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rkTMLIqteFTKJ/kNcp3QQqr3wtAr/MdNE0+T1ql8bB4=;
        b=AyCch/jV1iiXfQX9L+hNJsmYIgyilJvywtT+nkpmC6SxhcY+jtEF7mrvCMJ0Th8pOj
         2PdbiXfwGExAxeUqk0pDcg9bEitnIsLSu7hDI5Rmpl1GZxslFsrKgDTMm8IRE0bI0i03
         vb7T8jUGcNvyVLwm28W63lmlEw7D4iQ8mD79zkQz9+5weNmXUG7LZ1lGbbs0QRhLxeDu
         hpvEW+F++az/ZwFVzNghYq6iY9V8MQEahyzYnyFZVUxShL50S5dXJoUCHGTmfklu7lS+
         FbqafeMwbp+drKvhpq5Kdl41kKU+S7qizBLk1GpYtYL7+87ftHa1sKNwIFAsXSgtt/b3
         9X9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713497008; x=1714101808;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rkTMLIqteFTKJ/kNcp3QQqr3wtAr/MdNE0+T1ql8bB4=;
        b=eqa8xdKOnWp8Qv2al7q9/NcNQFJtmo6pH0zaT7Vd/pm1u/i3sZwRBnWRSHqT/2OOeZ
         TulxaDduIVWMCeTp8CJk/ltINFMXRVorUybzdu9ui2YupfLWClVyKspq/J4sjbGOVJKq
         gg2gY2uf0RGo5yKvI/sddEt4kRNp2q/7MGAtDq0kCNTXmyGXKm/mR9aH4TGwEhjdJ0KE
         uByYMWYRtkVClEf03ceqZCj+yXeXStnhK/9WnxA/yjSxu5JXkZCLzR+n4A86WBz5X1Qm
         0nzgy78b7dKCeW/V0YDuq2PJLOVpeLKbXa1GWZXZdtvGZIbA1B8RxGqLugY1Tv5tEUma
         dsvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKT8KXFTIR/34BR7SDRGMYdBiyErVf/USW5RoTvEAzFMbkW2VSH4807xiVc50QHarWzngWaJmq/mHV/xDk5C7MQQnrUtuOi4YAlxug8AnI6u4G9fPS97dwrgSj6F3Gb4O/kevWzK+JRg==
X-Gm-Message-State: AOJu0YwjD8Ywton2hRFbBdaTMpLB13PNq7jlorG5/ri1JLElcmoW0Yv+
	3FsAomJ2B5Fj6Nug5WK1IOqe+7xFDAoURkEO3jZXChDXNWPVQq5c
X-Google-Smtp-Source: AGHT+IFcqSNcJwvLtQsKIF35W+no4QmEUqR9PgxOJnSrzkqnfVrSeUklYgHoCBe3eD+W5EXz3SXiCg==
X-Received: by 2002:a17:902:ecc8:b0:1e2:71fd:dd85 with SMTP id a8-20020a170902ecc800b001e271fddd85mr1103014plh.23.1713497008312;
        Thu, 18 Apr 2024 20:23:28 -0700 (PDT)
Received: from [172.27.234.152] (ec2-16-163-40-128.ap-east-1.compute.amazonaws.com. [16.163.40.128])
        by smtp.gmail.com with ESMTPSA id s2-20020a170902ea0200b001e43cf17fe5sm2291080plg.6.2024.04.18.20.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 20:23:27 -0700 (PDT)
Message-ID: <8738cb85-fac1-4a15-9666-eb05316f5368@gmail.com>
Date: Fri, 19 Apr 2024 11:23:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 2/9] irqchip: Add RISC-V incoming MSI controller early
 driver
To: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Frank Rowand <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Atish Patra <atishp@atishpatra.org>,
 Andrew Jones <ajones@ventanamicro.com>, Sunil V L
 <sunilvl@ventanamicro.com>, Saravana Kannan <saravanak@google.com>,
 Anup Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240307140307.646078-1-apatel@ventanamicro.com>
 <20240307140307.646078-3-apatel@ventanamicro.com>
Content-Language: en-US
From: Eric Cheng <eric.cheng.linux@gmail.com>
In-Reply-To: <20240307140307.646078-3-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/7/2024 10:03 PM, Anup Patel wrote:

> +static int __init imsic_parse_fwnode(struct fwnode_handle *fwnode,
> +				     struct imsic_global_config *global,
> +				     u32 *nr_parent_irqs,
> +				     u32 *nr_mmios)
> +{

..

> +	/*
> +	 * Find first bit position of group index.
> +	 * If not specified assumed the default APLIC-IMSIC configuration.
> +	 */
> +	rc = of_property_read_u32(to_of_node(fwnode), "riscv,group-index-shift",
> +				  &global->group_index_shift);
> +	if (rc)
> +		global->group_index_shift = IMSIC_MMIO_PAGE_SHIFT * 2;
> +
> +	/* Find number of interrupt identities */
> +	rc = of_property_read_u32(to_of_node(fwnode), "riscv,num-ids",
> +				  &global->nr_ids);

Will here check if the pass-in interrupt identity number is (multi-64 -1) && 
between [63, 2047]?
Per spec AIA v1.0, Sec. 3.1 Interrupt files and interrupt identities:
"The number of interrupt identities supported by an interrupt file (and hence 
the number of active
bits in each array) is one less than a multiple of 64, and may be a minimum of 
63 and a maximum
of 2047."

> +	if (rc) {
> +		pr_err("%pfwP: number of interrupt identities not found\n", fwnode);
> +		return rc;
> +	}
> +
..



