Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C500B7D970B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345807AbjJ0LzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345801AbjJ0LzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:55:09 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4262BD57
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 04:55:04 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c8a1541232so17720285ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 04:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698407703; x=1699012503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e5FujhKIaH/uwx0lIrEstVD0nII/dzmNIeNJ8ebqYu0=;
        b=StVDK6iWENOIw4cbhc1kGnRGHoFOc+mmrjv3JwtRZMaGFn6+6vv1FCNwb9w+V1F9lF
         X+fCT1jk9DSxIIMBWzhcis5IcSUn6wvFM2mgb+hDXzkEEddNoSnXJ5seAJG3sIMafw70
         GXzinIDEgB3EJ/ka2nAJzSjgTFE6xIC1bx/qpxBSNOCoD+OdKQM3INsvkQc55IaqodfW
         vyY8uLyrndhYDr/4vpABnT00QCaw9BLbck4k2IoRC2RYdeoVdTqd6/MSd+iUqq408SDK
         fofxJnHChiqm/zSWNkBCj017d+6VVAMtLPob7rXYl/fuNwX6jCMqdrKfLG4kdW61d0qS
         1njQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698407703; x=1699012503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5FujhKIaH/uwx0lIrEstVD0nII/dzmNIeNJ8ebqYu0=;
        b=NQNZ8cTLaWQbOKQCHCpUZaFmlRpGp91131K0Jh39Meslh38xaDXOeFx+2QwuC4LH+T
         vjwrBTV63+dy7GyQLHNOipBGU4C8jETqf45ulyMyZjwqMF5o4BUPASaZemlavSQ8Og54
         yGsIef3aMDf+xZ5Ph2/7AT7nVw6mUlenaBE+dJdkbCEjaBXTOzuc0VH7v532Iwe6BFZi
         +hCazwxuh8ZqUcDTsqCmHOPG+w5PjmB1Xg3o922I9pJT9cl+koRwzXdCByA6CWmpj5iq
         m/kV03PcvBP88+3cN7clo+ZQvCbZ5pND4E7aXBeqJdTRrNS7GA2dhZIaUnKbG3p2JEq7
         Jfgw==
X-Gm-Message-State: AOJu0YxQVWWruaniegMFfN366PHdtFUT+qOUEqpAR3dg2FUwl82HWGtF
        dRbiHbtwL9Zmg4OCBaF8JPE5Lw==
X-Google-Smtp-Source: AGHT+IHUO3uODEbp/2xpVvuNkWZLUzFgyUmu6ctAkgCEdcwdjl1R6oJFy7lgIUS+r693E6SqK+uHMg==
X-Received: by 2002:a17:902:cf41:b0:1ca:7086:60f7 with SMTP id e1-20020a170902cf4100b001ca708660f7mr3256113plg.28.1698407703704;
        Fri, 27 Oct 2023 04:55:03 -0700 (PDT)
Received: from sunil-laptop ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902684c00b001b9f032bb3dsm1424132pln.3.2023.10.27.04.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 04:55:03 -0700 (PDT)
Date:   Fri, 27 Oct 2023 17:24:51 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Anup Patel <anup@brainfault.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Haibo Xu <haibo1.xu@intel.com>
Subject: Re: [RFC PATCH v2 13/21] irqchip: riscv-intc: Add ACPI support for
 AIA
Message-ID: <ZTulC3tUuTm92/Li@sunil-laptop>
References: <20231025202344.581132-14-sunilvl@ventanamicro.com>
 <20231026165150.GA1825130@bhelgaas>
 <ZTufD/InY/gwpE+Q@sunil-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTufD/InY/gwpE+Q@sunil-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 04:59:31PM +0530, Sunil V L wrote:
> Hi Bjorn,
> 
> On Thu, Oct 26, 2023 at 11:51:50AM -0500, Bjorn Helgaas wrote:
> > On Thu, Oct 26, 2023 at 01:53:36AM +0530, Sunil V L wrote:
> > > The RINTC subtype structure in MADT also has information about other
> > > interrupt controllers like MMIO. So, save those information and provide
> > > interfaces to retrieve them when required by corresponding drivers.
> > 
> > > @@ -218,7 +306,19 @@ static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
> > 
> > > +	 * MSI controller (IMSIC) in RISC-V is optional. So, unless
> > > +	 * IMSIC is discovered, set system wide MSI support as
> > > +	 * unsupported. Once IMSIC is probed, MSI support will be set.
> > > +	 */
> > > +	pci_no_msi();
> > 
> > It doesn't seem like we should have to tell the PCI core about
> > functionality we *don't* have.
> > 
> > I would think IMSIC would be detected before enumerating PCI devices
> > that might use it, and if we *haven't* found an IMSIC by the time we
> > get to pci_register_host_bridge(), would/should we set
> > PCI_BUS_FLAGS_NO_MSI there?
> >
> The check in pci_register_host_bridge() is like below.
> 
> if (bridge->msi_domain && !dev_get_msi_domain(&bus->dev) &&
>             !pci_host_of_has_msi_map(parent))
>                 bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
> 
> When there is no IMSIC, bridge->msi_domain is 0 and hence
> PCI_BUS_FLAGS_NO_MSI will never be set. Do you recommend to set
> PCI_BUS_FLAGS_NO_MSI if bridge->msi_domain is 0? Let me know if I am
> missing something.
> 
What seems to work is, setting bridge->msi_domain = true in
pci_create_root_bus() similar to how pci_host_common_probe() sets for OF
framework. Would that be better solution?

Thanks,
Sunil
