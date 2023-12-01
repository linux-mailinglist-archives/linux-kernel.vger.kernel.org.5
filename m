Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DC0800CAC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379086AbjLAN5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379060AbjLAN5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:57:40 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743BAA6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 05:57:46 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-77d66c7af31so263247685a.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 05:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701439065; x=1702043865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w5RfSzjMMhEGY5HPP+VV7KP4PAnFpwToiPE40rmIjTE=;
        b=ZHDIx3O3JFtKtmYM0wtN1DhovriW2rtgBX/vtkFKLmqvfTNp9tAhcOoybeJPJXY29q
         kv2+USLr9TWBWMUCZTXiOq9MSCmaoj1j75l+f5l0yMAcUkPt6/1/LY4hcAkVZv/XBb/w
         hVVjtNPUtURPYvYPS2l/igt4v4Z2MavAYa6U8PLUA2dzR3h7vHSs+80xTEXYfG1Ar0e0
         5bgBF3cf9CLPoNdMk1iQb76z7opiGIMUGMqqkVERcf3mtcOiaTso86/ddgs33hazprbT
         7c5EgMR3w/dPJyKZzyWQkbi8T59/eL3EJs91shCTNqXp7XkhbmLWyR/I+5NlFw+SoCq/
         sCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701439065; x=1702043865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5RfSzjMMhEGY5HPP+VV7KP4PAnFpwToiPE40rmIjTE=;
        b=Vg+UhTWh/d9uX4zfKFhpC7Ztl3XWWAzokPm5aCz816KYgEOha6AMSznpuooq4iK/Df
         6UNHK7tAspL8RYyR9ku5zPH+BiNi36SH3N5D42PoFlZqm1Mp4fJubNCZvT2pIWqGBorg
         F4SFyKTwlkTtlqDq77HqcU1BR8hECCZs1y3YDu4RUr8icHHRXgrnnCyQkqdinW4FbFqT
         h8ssAFaz4V6BGjgN4xC7zftcjGd0ne78U+k1N71HCAPZATcD8gTfOmeioWrCeUiHMvXO
         DYlM6LF7fUqbnKLMLCzm9T1mqKKHIlUOrmkkPidzn7wxvEDsMzFNeZ+j90NsHBHpKRLC
         Pusg==
X-Gm-Message-State: AOJu0Yzswq0H0X4m24ZyW/nUaWMy//BJrDXXw1E+7dVlPgzk3uASW2Um
        Uukn5dKa2pjbBBRjGrtIp9rgSA==
X-Google-Smtp-Source: AGHT+IGiHfUB0BG86D+k/H8bgXmfkHHxfAODJ1IDqy5rd6EVUw0TGcCvkgnXizQa+DzIHgV9yCckKw==
X-Received: by 2002:a05:620a:29c9:b0:773:c43e:5e73 with SMTP id s9-20020a05620a29c900b00773c43e5e73mr47263709qkp.25.1701439065500;
        Fri, 01 Dec 2023 05:57:45 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id vy13-20020a05620a490d00b0077da601f06csm1508858qkn.10.2023.12.01.05.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 05:57:44 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r941X-006F8M-UN;
        Fri, 01 Dec 2023 09:57:43 -0400
Date:   Fri, 1 Dec 2023 09:57:43 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/7] dma-mapping: Clean up arch_setup_dma_ops()
Message-ID: <20231201135743.GI1394392@ziepe.ca>
References: <cover.1701268753.git.robin.murphy@arm.com>
 <20231129203642.GO1312390@ziepe.ca>
 <ae27768f-a6fa-4971-b44c-92899a81a2b7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae27768f-a6fa-4971-b44c-92899a81a2b7@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 01:07:36PM +0000, Robin Murphy wrote:
> On 29/11/2023 8:36 pm, Jason Gunthorpe wrote:
> > On Wed, Nov 29, 2023 at 05:42:57PM +0000, Robin Murphy wrote:
> > > Hi all,
> > > 
> > > Prompted by Jason's proposal[1], here's a first step towards truly
> > > unpicking the dma_configure vs. IOMMU mess. As I commented before, we
> > > have an awful lot of accumulated cruft and technical debt here making
> > > things more complicated than they need to be, and we already have hacks
> > > on top of hacks trying to work around it, so polishing those hacks even
> > > further is really not a desirable direction of travel. And I do know
> > > they're hacks, because I wrote most of them and still remember enough of
> > > the context of the time ;)
> > 
> > I quite like this, I was also looking at getting rid of those other
> > parameters.
> > 
> > I wanted to take smaller steps because it is all pretty hairy.
> > 
> > One thing that still concerns me is if the FW data restricts the valid
> > IOVA window that really should be reflected into the reserved ranges
> > and not just dumped into the struct device for use by the DMA API.
> > 
> > Or, perhaps, viof/iommufd should be using the struct device data to
> > generate some additional reserved ranges?
> > 
> > Either way, I would like to see the dma_iommu and the rest of the
> > subsystem agree on what the valid IOVA ranges actually are.
> 
> Note that there is some intentional divergence where iommu-dma reserves
> IOVAs matching PCI outbound windows because it knows it wants to avoid
> clashing with potential peer-to-peer addresses and doesn't want to have to
> get into the details of ACS redirect etc., but we don't expose those as
> generic reserved regions because they're firmly a property of the PCI host
> bridge, not of the IOMMU group (and more practically, because we did do so
> briefly and it made QEMU unhappy). I think there may also have been some
> degree of conclusion that it's not the IOMMU API's place to get in the way
> of other domain users trying to do weird P2P stuff if they really want to.

I'm not sure this is the fully correct conclusion - eg if today we
take a NIC device on a non-ACS topology and run DPDK through VFIO it
has a chance of failure because some IOVA simply cannot be used by
DPDK for DMA at all.

qemu and kvm are a different situation that want different things. Eg
it would want to identity map the PCI BAR spaces to the IOVA they are
claiming.

It should still somehow carve out any other IOVA that is unusable due
to guest-invisible ACS and reflect it through FW tables into the VM.

I'm starting to see people build non-ACS systems and want it to work
with VFIO and I'm a little worried we have been too loose here.

> bridge and so inherits its restrictions. However I don't recall any
> conscious decision for inbound windows to only be considered for DMA domain
> reservations rather than for proper reserved regions - pretty sure that's
> just a case of that code being added in the place where it seemed to fit
> best at the time (because hey it's more host bridge windows and we already
> have a thing for host bridge windows...)

Yeah, and I don't think anyone actually cared much..

At least as a step it would be nice if the DMA API only restrictions
can come out as a special type of reserved region. Then the caller
could decide if they want to follow them or not. iommufd could provide
an opt-in API to DPDK that matches DMA API's safe IOVA allocator.

Jason
