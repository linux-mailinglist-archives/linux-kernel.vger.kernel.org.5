Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5B37E4C72
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbjKGXHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjKGXHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:07:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18A710C8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699398407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=evOOxUwRzOxqxcodoYQiu8D+8i7HycPPu2po6a+EzrU=;
        b=HFcivVMDFupRl94e6wzopcy+94rw5WFQzR+t2VJGGdkH6TVJjXCMrBpCkJZM/Sydpv/ZN7
        OB1EvJzpQlqeDr6i2x/jp1eTCGA0vevkjmslm3Y730DoMwt5TJYKVd5umbZD8QjPT9VgaU
        e0PRVSrKL4CmkFbo1TJp/SRph5AwP9g=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-tIRLBkZzOA-L3uUaxM2lug-1; Tue, 07 Nov 2023 18:06:44 -0500
X-MC-Unique: tIRLBkZzOA-L3uUaxM2lug-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7ac3dfff4c8so587508239f.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 15:06:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699398404; x=1700003204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evOOxUwRzOxqxcodoYQiu8D+8i7HycPPu2po6a+EzrU=;
        b=aLHnCWR8vh9cKGwksCpcf6XQ+CXqhxtHh9/BvMOzRKB1EYPYfaMPBn014Eqtf32asg
         WPPOqOdFs7DnRM+pjCSFKfUKPXsHzl7U0B9UoOcDGRSHH5BemTiH/Dq+I1lkCbTtqSdV
         lIVTQqewpUjyfkTCWS3Zzv9Fv5KcLze/xf5XkaDNtlfZfOd+ckp08AToi0YSoZJcI4ic
         5KqWqniqUZP40EnLqTJQScwRDteNs8qhFTvXcGZkAjYsIotPseCpdmiTFuE9wJka8Mcg
         yDLg5GS2bZUqfHsFxNAtJWAEsQ/coaFLvugRWjLQVWSZQR4T0uMbEbiWOHXyDtkTzrZw
         51lQ==
X-Gm-Message-State: AOJu0Yxz9smFoIIJFCThl3SdwQPLT6AJW/P6sdyuIDsUAL1vbAUDF6Is
        RiWGji5Fxfbeh8PilcPudycFQX0rTcxGiaW86l4t+CDEOkH1uQnrT7lvATtecg0sr29kxV86Fze
        psP22cwEVsYLz1UU62YIRz2WG
X-Received: by 2002:a6b:dd15:0:b0:7ac:7cbf:972 with SMTP id f21-20020a6bdd15000000b007ac7cbf0972mr261426ioc.12.1699398403533;
        Tue, 07 Nov 2023 15:06:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaQwvUt/Q1P1zaKJYSFtqLACqcrOblpWzBgvcWqmvYHf8+bh/9ikaMkiqgQ/LmNo+qmavYmA==
X-Received: by 2002:a6b:dd15:0:b0:7ac:7cbf:972 with SMTP id f21-20020a6bdd15000000b007ac7cbf0972mr261409ioc.12.1699398403197;
        Tue, 07 Nov 2023 15:06:43 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id g15-20020a056602242f00b0076c569c7a48sm3193990iob.39.2023.11.07.15.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 15:06:42 -0800 (PST)
Date:   Tue, 7 Nov 2023 16:06:41 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "yishaih@nvidia.com" <yishaih@nvidia.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "tom.zanussi@linux.intel.com" <tom.zanussi@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [RFC PATCH V3 00/26] vfio/pci: Back guest interrupts from
 Interrupt Message Store (IMS)
Message-ID: <20231107160641.45aee2e0.alex.williamson@redhat.com>
In-Reply-To: <7f8b89c7-7ae0-4f2d-9e46-e15a6db7f6d9@intel.com>
References: <cover.1698422237.git.reinette.chatre@intel.com>
        <BL1PR11MB52710EAB683507AD7FAD6A5B8CA0A@BL1PR11MB5271.namprd11.prod.outlook.com>
        <20231101120714.7763ed35.alex.williamson@redhat.com>
        <BN9PR11MB52769292F138F69D8717BE8D8CA6A@BN9PR11MB5276.namprd11.prod.outlook.com>
        <20231102151352.1731de78.alex.williamson@redhat.com>
        <BN9PR11MB5276BCEA3275EC7203E06FDA8CA5A@BN9PR11MB5276.namprd11.prod.outlook.com>
        <20231103095119.63aa796f.alex.williamson@redhat.com>
        <BN9PR11MB52765E82CB809DA7C04A3EF18CA9A@BN9PR11MB5276.namprd11.prod.outlook.com>
        <7f8b89c7-7ae0-4f2d-9e46-e15a6db7f6d9@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2023 11:48:28 -0800
Reinette Chatre <reinette.chatre@intel.com> wrote:

> Hi Alex and Kevin,
> 
> On 11/7/2023 12:29 AM, Tian, Kevin wrote:
> >> From: Alex Williamson <alex.williamson@redhat.com>
> >> Sent: Friday, November 3, 2023 11:51 PM
> >>
> >> On Fri, 3 Nov 2023 07:23:13 +0000
> >> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> >>  
> >>>> From: Alex Williamson <alex.williamson@redhat.com>
> >>>> Sent: Friday, November 3, 2023 5:14 AM
> >>>>
> >>>> On Thu, 2 Nov 2023 03:14:09 +0000
> >>>> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> >>>>  
> >>>>>> From: Tian, Kevin
> >>>>>> Sent: Thursday, November 2, 2023 10:52 AM
> >>>>>>  
> >>>>>>>
> >>>>>>> Without an in-tree user of this code, we're just chopping up code for
> >>>>>>> no real purpose.  There's no reason that a variant driver requiring  
> >> IMS  
> >>>>>>> couldn't initially implement their own SET_IRQS ioctl.  Doing that  
> >>>>>>
> >>>>>> this is an interesting idea. We haven't seen a real usage which wants
> >>>>>> such MSI emulation on IMS for variant drivers. but if the code is
> >>>>>> simple enough to demonstrate the 1st user of IMS it might not be
> >>>>>> a bad choice. There are additional trap-emulation required in the
> >>>>>> device MMIO bar (mostly copying MSI permission entry which  
> >> contains  
> >>>>>> PASID info to the corresponding IMS entry). At a glance that area
> >>>>>> is 4k-aligned so should be doable.
> >>>>>>  
> >>>>>
> >>>>> misread the spec. the MSI-X permission table which provides
> >>>>> auxiliary data to MSI-X table is not 4k-aligned. It sits in the 1st
> >>>>> 4k page together with many other registers. emulation of them
> >>>>> could be simple with a native read/write handler but not sure
> >>>>> whether any of them may sit in a hot path to affect perf due to
> >>>>> trap...  
> >>>>
> >>>> I'm not sure if you're referring to a specific device spec or the PCI
> >>>> spec, but the PCI spec has long included an implementation note
> >>>> suggesting alignment of the MSI-X vector table and pba and separation
> >>>> from CSRs, and I see this is now even more strongly worded in the 6.0
> >>>> spec.
> >>>>
> >>>> Note though that for QEMU, these are emulated in the VMM and not
> >>>> written through to the device.  The result of writes to the vector
> >>>> table in the VMM are translated to vector use/unuse operations, which
> >>>> we see at the kernel level through SET_IRQS ioctl calls.  Are you
> >>>> expecting to get PASID information written by the guest through the
> >>>> emulated vector table?  That would entail something more than a simple
> >>>> IMS backend to MSI-X frontend.  Thanks,
> >>>>  
> >>>
> >>> I was referring to IDXD device spec. Basically it allows a process to
> >>> submit a descriptor which contains a completion interrupt handle.
> >>> The handle is the index of a MSI-X entry or IMS entry allocated by
> >>> the idxd driver. To mark the association between application and
> >>> related handles the driver records the PASID of the application
> >>> in an auxiliary structure for MSI-X (called MSI-X permission table)
> >>> or directly in the IMS entry. This additional info includes whether
> >>> an MSI-X/IMS entry has PASID enabled and if yes what is the PASID
> >>> value to be checked against the descriptor.
> >>>
> >>> As you said virtualizing MSI-X table itself is via SET_IRQS and it's
> >>> 4k aligned. Then we also need to capture guest updates to the MSI-X
> >>> permission table and copy the PASID information into the
> >>> corresponding IMS entry when using the IMS backend. It's MSI-X
> >>> permission table not 4k aligned then trapping it will affect adjacent
> >>> registers.
> >>>
> >>> My quick check in idxd spec doesn't reveal an real impact in perf
> >>> critical path. Most registers are configuration/control registers
> >>> accessed at driver init time and a few interrupt registers related
> >>> to errors or administrative purpose.  
> >>
> >> Right, it looks like you'll need to trap writes to the MSI-X
> >> Permissions Table via a sparse mmap capability to avoid assumptions
> >> whether it lives on the same page as the MSI-X vector table or PBA.
> >> Ideally the hardware folks have considered this to avoid any conflict
> >> with latency sensitive registers.
> >>
> >> The variant driver would use this for collecting the meta data relative
> >> to the IMS interrupt, but this is all tangential to whether we
> >> preemptively slice up vfio-pci-core's SET_IRQS ioctl or the iDXD driver
> >> implements its own.  
> > 
> > Agree
> >   
> >>
> >> And just to be clear, I don't expect the iDXD variant driver to go to
> >> extraordinary lengths to duplicate the core ioctl, we can certainly
> >> refactor and export things where it makes sense, but I think it likely
> >> makes more sense for the variant driver to implement the shell of the
> >> ioctl rather than trying to multiplex the entire core ioctl with an ops
> >> structure that's so intimately tied to the core implementation and
> >> focused only on the MSI-X code paths.  Thanks,
> >>  
> > 
> > btw I'll let Reinette to decide whether she wants to implement such
> > a variant driver or waits until idxd siov driver is ready to demonstrate
> > the usage. One concern with the variant driver approach is lacking
> > of a real-world usage (e.g. what IMS brings when guest only wants
> > MSI-X on an assigned PF). Though it may provide a shorter path
> > to enable the IMS backend support, also comes with the long-term
> > maintenance burden.  
> 
> Thank you very much for your guidance and advice.
> 
> I'd be happy to implement what is required for this work. Unfortunately
> I am not confident that I understand what is meant with "variant driver".
> 
> I initially understood "variant driver" to mean the planned IDXD virtual
> device driver (the "IDXD VDCM" driver) that will assign IDXD resources
> to guests with varying granularity and back the guest MSI-X interrupts
> of these virtual devices with IMS interrupts on the host. From Kevin
> I understand "variant driver" is a new sample driver for an IDXD
> assigned PF, backing guest MSI-X interrupts with IMS interrupts on
> the host.
> 
> The IDXD VDCM driver is in progress. If a new variant driver needs to be
> created then I still need to do some research in how to accomplish it.
> Even so, it is not clear to me who the users of this new driver would be.
> If the requirement is to demonstrate this VFIO IMS usage then we could
> perhaps wait until the IDXD VDCM driver is ready and thus not have to deal
> with additional maintenance burden.

A vfio-pci variant driver is specifically a driver that leverages
portions of vfio-pci-core for implementing vfio_device_ops and binds to
a PCI device.  It might actually be the wrong term here, but I jumped
to that since the series tries to generalize portions of one of the
vfio-pci-core code paths. You might very well be intending to use this
with something more like an mdev driver, which is fine.

That also sort of illustrates the point though that this series is
taking a pretty broad approach to slicing up vfio-pci-core's SET_IRQS
ioctl code path, enabling support for IMS backed interrupts, but in
effect complicating the whole thing without any actual consumer to
justify the complication.  Meanwhile I think the goal is to reduce
complication to a driver that doesn't exist yet.  So it currently seems
like a poor trade-off.

This driver that doesn't exist yet could implement its own SET_IRQS
ioctl that backs MSI-X with IMS as a starting point.  Presumably we
expect multiple drivers to require this behavior, so common code makes
sense, but the rest of us in the community can't really evaluate how
much it makes sense to slice the common code without seeing that
implementation and how it might leverage, if not directly use, the
existing core code.

The sample drivers come into play in that if we were to make the
vfio-pci-core SET_IRQS path usable in this generic way, then any driver
implementing SET_IRQS for a PCI device should be able to take advantage
of it, including those that already exist in samples/vfio-mdev/.  I
don't think anyone is requesting an iDXD sample driver, the real driver
should be sufficient.

> In the mean time there are items that I do understand better
> and will work on right away:
> - Do not have ops span the SET_IRQS ioctl()
> - Use container_of() instead of opaque pointer
> - Do not ignore INTx, consider the mdev sample driver when refactoring
>   this code.
> - Consider the Intel vgpu driver as user of new emulated interrupt
>   interface.

I think looking at kvmgt and the existing sample drivers to find
commonality that actually provides simplification would be a good
start, but I don't anticipate implementing IMS backed MSI-X in common
code unless we're at least imminently able to make use of it.  Thanks,

Alex

