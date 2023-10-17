Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D267CC905
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343824AbjJQQl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343684AbjJQQl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:41:56 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEC4ED
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:41:52 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-417fc2da919so40862281cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1697560911; x=1698165711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5MsW2Hvp6im1571f/e59oteDAoDCIGSXlLc583DfDLg=;
        b=aXUXowGdR31c6RzSBezyw3SzeNHEEfEwAICPbwxHAwgrctwoOnCCxB3c9aRyV7UH8A
         QieCMoksHqKQhemnsohv6JqJrDCx/cbLF1bn7jSv9PCwtjMM/2p85nslS5W4o1V5eQhH
         BACm/e9q1K4EYZJcKLmDbat9SBJLZj/FO+4DntHiwDqxQ8CTlbM9O4oQDQ932PZjjBnJ
         bpWjVCrypUeJv0fESFPrl8stdhIDpBukIHScxdH6cAw8E78L9k/C4kWWY1kGv7k5hfrw
         ZzE8LmwVZ4XKII7qzYZt4bit3HGblHhKK4tZwR3ZvX4XgkHHU4MaHME3kLHQZq9Eghul
         Fo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697560911; x=1698165711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MsW2Hvp6im1571f/e59oteDAoDCIGSXlLc583DfDLg=;
        b=Vsy2aU9lk2WbKn4UcG4ylwz1ELnZslkl/jur0VR3pAWchpOJurniduuTmkAnB0//TF
         JMbQFIws8ZXuMNWPdcHI5Mah0BJCTX0QFVGifuAD7bzhvZ2lsdkf6WRgagoX+AAYzHHt
         7oNGKQMZOcuAyNnwk5VTUfNIaA3AjUA59DwixOtl522jJD7PAddUaBQL30HnkFQ1AeFe
         SEXdtkisFT0eRSBdcovGF5HbkuIswBXmkvfj3jqYnV9OkXJdIvO0CC4q2TJwnK0qu72u
         CwxLeP7nkGz80xmy4JB/Od4k7//CVooulbDIhW17oHqXFKwRgg10E6pAiUBreoDGAtr4
         Arcg==
X-Gm-Message-State: AOJu0YzQD0aZcBQpPWQGUuqGBasnzNNr7WqyZizH1pY0/cOUpF7y32Tw
        PPud8fXNfifj9ufNU0EqSHsqMw==
X-Google-Smtp-Source: AGHT+IE1dQmP4ebFkaXpsk8hiVNKIl6iWdx3W7/Lrk/p4bB7BLs964FA8Bic7g2UaJhXeTkXeavVfw==
X-Received: by 2002:a05:622a:506:b0:410:9111:4a0b with SMTP id l6-20020a05622a050600b0041091114a0bmr3294519qtx.13.1697560911646;
        Tue, 17 Oct 2023 09:41:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id y12-20020a05622a120c00b004196a813639sm756907qtx.17.2023.10.17.09.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 09:41:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qsn8g-002sLi-HJ;
        Tue, 17 Oct 2023 13:41:50 -0300
Date:   Tue, 17 Oct 2023 13:41:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tina Zhang <tina.zhang@intel.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v8 0/5] Share sva domains with all devices bound to a mm
Message-ID: <20231017164150.GF282036@ziepe.ca>
References: <20231017004802.109618-1-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017004802.109618-1-tina.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 08:47:57AM +0800, Tina Zhang wrote:
> This series is to share sva(shared virtual addressing) domains with all
> devices bound to one mm.
> 
> Problem
> -------
> In the current iommu core code, sva domain is allocated per IOMMU group,
> when device driver is binding a process address space to a device (which is
> handled in iommu_sva_bind_device()). If one than more device is bound to
> the same process address space, there must be more than one sva domain
> instance, with each device having one. In other words, the sva domain
> doesn't share between those devices bound to the same process address
> space, and that leads to two problems:
> 1) device driver has to duplicate sva domains with enqcmd, as those sva
> domains have the same PASID and are relevant to one virtual address space.
> This makes the sva domain handling complex in device drivers.
> 2) IOMMU driver cannot get sufficient info of the IOMMUs that have
> devices behind them bound to the same virtual address space, when handling
> mmu_notifier_ops callbacks. As a result, IOMMU IOTLB invalidation is
> performed per device instead of per IOMMU, and that may lead to
> superfluous IOTLB invalidation issue, especially in a virtualization
> environment where all devices may be behind one virtual IOMMU.
> 
> Solution
> --------
> This patch-set tries to fix those two problems by allowing sharing sva
> domains with all devices bound to a mm. To achieve this, a new structure
> pointer is introduced to mm to replace the old PASID field, which can keep
> the info of PASID as well as the corresponding shared sva domains.
> Besides, function iommu_sva_bind_device() is updated to ensure a new sva
> domain can only be allocated when the old ones cannot work for the IOMMU.
> With these changes, a device driver can expect one sva domain could work
> for per PASID instance(e.g., enqcmd PASID instance), and therefore may get
> rid of handling sva domain duplication. Besides, IOMMU driver (e.g., intel
> vt-d driver) can get sufficient info (e.g., the info of the IOMMUs having
> their devices bound to one virtual address space) when handling
> mmu_notifier_ops callbacks, to remove the redundant IOTLB invalidations.
> 
> Arguably there shouldn't be more than one sva_domain with the same PASID,
> and in any sane configuration there should be only 1 type of IOMMU driver
> that needs only 1 SVA domain. However, in reality, IOMMUs on one platform
> may not be identical to each other. Thus, attaching a sva domain that has
> been successfully bound to device A behind a IOMMU A, to device B behind
> IOMMU B may get failed due to the difference between IOMMU A and IOMMU
> B. In this case, a new sva domain with the same PASID needs to be
> allocated to work with IOMMU B. That's why we need a list to keep sva
> domains of one PASID. For the platform where IOMMUs are compatible to each
> other, there should be one sva domain in the list.
> 
> v8:
>  - CC more people
>  - CC iommu@lists.linux.dev mailing list.
>    When sending version 7, some issue happened in my CC list and that caused
>    version 7 wasn't sent to iommu@lists.linux.dev.
>  - Rebase to v6.6-rc6 and make a few format changes.

You should based it on Joerg's tree so he can take it without
conflcits.

The conflicts are trivial though (Take Michael's version and switch
mm->pasid with mm_get_enqcmd_pasid(mm))

It looks fine, please lets get it in this cycle, the ARM and AMD SVA
series depend on it.

Jason
