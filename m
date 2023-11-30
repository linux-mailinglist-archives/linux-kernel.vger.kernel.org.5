Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912037FF44C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346525AbjK3QC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346563AbjK3QCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:02:23 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FA71716
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:02:15 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-332e56363adso754450f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1701360134; x=1701964934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J8Q31kwOWiBDXnwlbMX0bPU/+i+b5UwJll/wjEONC1U=;
        b=tLtM5mNqCSrVHP8edXgwL+BALAypuISUQH5BPMPHcwH7KjkZZhZOAN76wJhq6Ot0ua
         o53pOhdtPWueREFkxpn2Og0Ai7sMYyjpf12qFxwU9gSklGIxWCVrsJM4MiIxExdFMnME
         Zt8S5T1TVRelAtTxJ5rspA0NqwSag5kxOcH3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701360134; x=1701964934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8Q31kwOWiBDXnwlbMX0bPU/+i+b5UwJll/wjEONC1U=;
        b=VbK8E96vEbFeeWlo0XwJqOW+gKSB5XI5X/bPH+sYOQXo6BOCQmUqHomSirDjh94FKl
         38OsN16Zhx7C2FfdDPnYnLgpt8y0zJBa0+X6ANPTSWDDYJaHQwquItwygY3uv/hMR65D
         V+66oeoQXIrsZVIdV4Op5hQj46F9zvtoR4C+AJK6FV6GNesFFFmxvRGIIWFkR4EsEfqg
         h/rkwCgurrmcg24RqtFPLmJbSbNIh/RHfcQ6dijuTedfeZxdG7tp4fPdhwHXf+rbfu0K
         qpCH7ECZY0XsAkbYqfMcQi4TCknJfpTo1PSWeYV4mUei2GXo3nVxHMFTbug52y+cNLvG
         OW+Q==
X-Gm-Message-State: AOJu0YzFXBD8l/rYeWPgFQiAgq2akFPFR/epP9p4ScL7xfpameJimZqc
        GJddwOgtmhtFYbl05gDgJEQw5w==
X-Google-Smtp-Source: AGHT+IG7CHrQYHgQi9oJz5npE820tArdqo6WytLhF5GonusjbfiVhyI2nc1i0dbHiq1MLAlBCrQniA==
X-Received: by 2002:a5d:458b:0:b0:332:ffaf:d217 with SMTP id p11-20020a5d458b000000b00332ffafd217mr9790796wrq.27.1701360133280;
        Thu, 30 Nov 2023 08:02:13 -0800 (PST)
Received: from localhost ([213.195.113.99])
        by smtp.gmail.com with ESMTPSA id f12-20020adfdb4c000000b00332d3b89561sm1873646wrj.97.2023.11.30.08.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 08:02:13 -0800 (PST)
Date:   Thu, 30 Nov 2023 17:02:12 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Jiqian Chen <Jiqian.Chen@amd.com>, Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Stefano Stabellini <stefano.stabellini@amd.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
        Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
        Honglei Huang <Honglei1.Huang@amd.com>,
        Julia Zhang <Julia.Zhang@amd.com>,
        Huang Rui <Ray.Huang@amd.com>
Subject: Re: [RFC KERNEL PATCH v2 2/3] xen/pvh: Unmask irq for passthrough
 device in PVH dom0
Message-ID: <ZWiyBP4Lzz5lXraP@macbook>
References: <20231124103123.3263471-1-Jiqian.Chen@amd.com>
 <20231124103123.3263471-3-Jiqian.Chen@amd.com>
 <alpine.DEB.2.22.394.2311291950350.3533093@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2311291950350.3533093@ubuntu-linux-20-04-desktop>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 07:53:59PM -0800, Stefano Stabellini wrote:
> On Fri, 24 Nov 2023, Jiqian Chen wrote:
> > This patch is to solve two problems we encountered when we try to
> > passthrough a device to hvm domU base on Xen PVH dom0.
> > 
> > First, hvm guest will alloc a pirq and irq for a passthrough device
> > by using gsi, before that, the gsi must first has a mapping in dom0,
> > see Xen code pci_add_dm_done->xc_domain_irq_permission, it will call
> > into Xen and check whether dom0 has the mapping. See
> > XEN_DOMCTL_irq_permission->pirq_access_permitted, "current" is PVH
> > dom0 and it return irq is 0, and then return -EPERM.
> > This is because the passthrough device doesn't do PHYSDEVOP_map_pirq
> > when thay are enabled.
> > 
> > Second, in PVH dom0, the gsi of a passthrough device doesn't get
> > registered, but gsi must be configured for it to be able to be
> > mapped into a domU.
> > 
> > After searching codes, we can find map_pirq and register_gsi will be
> > done in function vioapic_write_redirent->vioapic_hwdom_map_gsi when
> > the gsi(aka ioapic's pin) is unmasked in PVH dom0. So the problems
> > can be conclude to that the gsi of a passthrough device doesn't be
> > unmasked.
> > 
> > To solve the unmaske problem, this patch call the unmask_irq when we
> > assign a device to be passthrough. So that the gsi can get registered
> > and mapped in PVH dom0.
> 
> 
> Roger, this seems to be more of a Xen issue than a Linux issue. Why do
> we need the unmask check in Xen? Couldn't we just do:
> 
> 
> diff --git a/xen/arch/x86/hvm/vioapic.c b/xen/arch/x86/hvm/vioapic.c
> index 4e40d3609a..df262a4a18 100644
> --- a/xen/arch/x86/hvm/vioapic.c
> +++ b/xen/arch/x86/hvm/vioapic.c
> @@ -287,7 +287,7 @@ static void vioapic_write_redirent(
>              hvm_dpci_eoi(d, gsi);
>      }
>  
> -    if ( is_hardware_domain(d) && unmasked )
> +    if ( is_hardware_domain(d) )
>      {
>          /*
>           * NB: don't call vioapic_hwdom_map_gsi while holding hvm.irq_lock

There are some issues with this approach.

mp_register_gsi() will only setup the trigger and polarity of the
IO-APIC pin once, so we do so once the guest unmask the pin in order
to assert that the configuration is the intended one.  A guest is
allowed to write all kind of nonsense stuff to the IO-APIC RTE, but
that doesn't take effect unless the pin is unmasked.

Overall the question would be whether we have any guarantees that
the hardware domain has properly configured the pin, even if it's not
using it itself (as it hasn't been unmasked).

IIRC PCI legacy interrupts are level triggered and low polarity, so we
could configure any pins that are not setup at bind time?

Thanks, Roger.
