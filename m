Return-Path: <linux-kernel+bounces-12667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8986081F8A5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46754285B0D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 13:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E1E8494;
	Thu, 28 Dec 2023 13:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="mmNpu6/s"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A09C79EA
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 13:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7ba737ee9b5so437800239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 05:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703768922; x=1704373722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2sTRWP1BfjExUpMIHeRBHU/LlMOrJyrRhsp9tBe90/E=;
        b=mmNpu6/sh5mNnMPUJZ1XwXdcro5XxB72crgiVr3LUIZLi6nPq9H2CiJRGNGHlRUxX1
         eOWnefhJrBx8Wmk9UfcZN1lOA/9rIW1t5SA52hxIrJY90sUbcgfDIbjPnim9jmOvEuST
         zC/9mLokek5GMzLqOnl/k8wZHP6K1fCA098AmmpI1F7olXcrQnvqxDVM1W2k7N4xBOIT
         EZ9pjS6wNb+QeoGUTkkLYbuRkHA6uCOtLGyQCJVG23vHaD21eoUOE3D7VwnNHCGODXEg
         Actx4aDcmbLuMZte3PfYfRpKN8AoDUkPb6XO4HX2hwf9QWUhJvbbkr0+GuK+RP0HCAGC
         OjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703768922; x=1704373722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2sTRWP1BfjExUpMIHeRBHU/LlMOrJyrRhsp9tBe90/E=;
        b=R7l+0wzJbyrtF/gBJyPCVwMBin+2XZH9DGQur2I/CCYtTLPoFodkXyQzhsXyEf2dsE
         MX+L11ZbgFozandKUNTKwlSnFBeRbhlx4GHvhC9vXLjCu9g0FyKA60ocoUduuyQlWR0d
         hrkYrjYmGZm9VkaxFENN73utEyCBcZrXg+ZjHQlhlWowXAXdmHa5rK73+6NZFfI9hBg7
         u4QBxrf0mvpruzAAGLmcfTYN7qOJMPmpLGSh/hFEO7f5qkAGbLgGGv0RvaDasB2eSrZ3
         4x9VOAUbocJ+OKQPxWb2poVMaEQdoJBF3NrAoOiWrEpNAuRQLFz+9VCRagqJkBQMC9pq
         6ajg==
X-Gm-Message-State: AOJu0Yws170MwOwifJHcHXksdf1nMh7rItBoVduQc/sNBsykNmt9Ov1Z
	g1gRVIDeNtVbaohSxb9yFDkmCPV9TOe3NA==
X-Google-Smtp-Source: AGHT+IE3SK3cpPclMD7nMM9tzXVA5ulc46KRGcSGLUzMVQbJhiwmZQrdF/fDTxX9t0ugT/7ZCuqrPQ==
X-Received: by 2002:a6b:4e07:0:b0:7ba:9355:921e with SMTP id c7-20020a6b4e07000000b007ba9355921emr14536420iob.37.1703768922600;
        Thu, 28 Dec 2023 05:08:42 -0800 (PST)
Received: from sunil-laptop ([2409:4071:d8c:48a3:7c9f:2b6f:993e:1716])
        by smtp.gmail.com with ESMTPSA id ca5-20020a0566381c0500b0046d79f147bdsm907069jab.179.2023.12.28.05.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 05:08:42 -0800 (PST)
Date: Thu, 28 Dec 2023 18:38:28 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>, Haibo Xu <haibo1.xu@intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Anup Patel <anup@brainfault.org>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Jones <ajones@ventanamicro.com>,
	Will Deacon <will@kernel.org>, Len Brown <lenb@kernel.org>
Subject: Re: [RFC PATCH v3 03/17] PCI: Make pci_create_root_bus() declare its
 reliance on MSI domains
Message-ID: <ZY1zTMnYnjy7bn4A@sunil-laptop>
References: <20231219174526.2235150-4-sunilvl@ventanamicro.com>
 <20231226235602.GA1483795@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226235602.GA1483795@bhelgaas>

On Tue, Dec 26, 2023 at 05:56:02PM -0600, Bjorn Helgaas wrote:
> On Tue, Dec 19, 2023 at 11:15:12PM +0530, Sunil V L wrote:
> > Similar to [1], declare this dependency for PCI probe in ACPI based
> > flow.
> 
> It would be better to refer to this as 9ec37efb8783 ("PCI/MSI: Make
> pci_host_common_probe() declare its reliance on MSI domains") instead
> of a link to the mailing list archives.
> 
> The git SHA1 is part of the git repo, and git can tell us where that
> SHA1 is included.  The lore URL is external and doesn't say anything
> about what happened to the patch.
> 
Yes!. Let me update in next version. Thanks!

> > This is required especially for RISC-V platforms where MSI controller
> > can be absent.
> > 
> > [1] - https://lore.kernel.org/all/20210330151145.997953-12-maz@kernel.org/

