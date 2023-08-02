Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D0376CF0B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjHBNod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjHBNo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:44:29 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46BBB2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 06:44:28 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-56c7f47ec42so3741208eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 06:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690983868; x=1691588668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iaKT85TJhEtcFP9ANuQrpHynlBJz4qIcEmhrfVkT2f0=;
        b=MkqMmJNHF6SUb5Wg4wdkEMPdYqOcouWW7G77xUhqRubpPap1WIXCVLfpofpfoRg26Y
         dkkJRyGmK8uKOe1+9wlNIKM6rTtoZ3zkRuR83glbO0xUmlWTnsJKIu0ptTJZmF0s10Ry
         7nKBMssvjUTItFpD15ENyaZOwD5BIKVYdWl/IwwYVTSnGWh6SyfA3JUGxelbar8aNpFe
         765IoEhQsyzRpwTHH4gSRiDX0KKcnS/VMwIw82iGkQo3eHqpyIHn5n1xg9DM6kPGS5Ls
         +8pzxFQdedg3Q/tFWXR+e9EmpZh65FUTg+hWlL6g0lqm4O316Wkm40VZqWv0SoMt0iS/
         rHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690983868; x=1691588668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iaKT85TJhEtcFP9ANuQrpHynlBJz4qIcEmhrfVkT2f0=;
        b=b0IvlS1+gAS3zfjm5iiSHJpndtU6ki3xi4U8zgJmv3kkTZ7HSsiyYOp20+SFyXjwAu
         GKN9qv/1EFRPdzJwJn4RPW0oAupQUuLPfNVzJiYcCxzBqRcnpM/Y+4KTTL5AwmuR+Oyu
         5Ft91mh16OtqnMEniaz4nT544VEEyIKvsGINVZly9KqSfJd8gtrMynDMuVibeYF+Vgf+
         YCjbniiogjjaUUON0bcV2anLslnx3G08Ym7NO+2WT03yGrg+Wi0o3iifHXiGWQfep8n2
         OXfyfNLi170JcZ4FAeQkflUBpGjW22hiF1ceWCcIxJTWRqb4fmbBYTqE4kIgfjPrLaUx
         Tepw==
X-Gm-Message-State: ABy/qLYM/gHrL+mtTT2dKexSG/bBhddbgo7CWhXyrct+tFMZ5CMeUUmp
        XxVZw1Pbyj+/uD7NLkJnjwbIXw==
X-Google-Smtp-Source: APBJJlGIW2O7+amusHg/yl/NaQI+skiPGbXQqDGrrFAPEvK+fD1I90Tv962Nn8fzJAYM4LtJ250cWw==
X-Received: by 2002:a05:6358:724a:b0:135:5ede:f352 with SMTP id i10-20020a056358724a00b001355edef352mr8120539rwa.8.1690983866720;
        Wed, 02 Aug 2023 06:44:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id e18-20020a0ce3d2000000b00635efe2f65csm5536749qvl.30.2023.08.02.06.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 06:44:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qRC9J-0032yC-6I;
        Wed, 02 Aug 2023 10:44:25 -0300
Date:   Wed, 2 Aug 2023 10:44:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC] iommu/virtio: Use single flush queue (EXPERIMENTAL)
Message-ID: <ZMpduWLdRXhUEx6O@ziepe.ca>
References: <20230717-dma_iommu-v11-0-a7a0b83c355c@linux.ibm.com>
 <20230726111433.1105665-1-schnelle@linux.ibm.com>
 <20230802123612.GA6142@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802123612.GA6142@myrica>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 01:36:12PM +0100, Jean-Philippe Brucker wrote:

> automatically get plugged into a VM without user intervention. Here I
> guess the devices we don't trust will be virtual devices implemented by
> other VMs. We don't have any method to identify them yet, so
> iommu.strict=1 and CONFIG_IOMMU_DEFAULT_DMA_STRICT is the best we can do
> at the moment.

VM's should work the same way as bare metal. The hypervisor should
pass in an ACPI/etc indication if specific devices are to be
untrusted. Otherwise the VM should assume trusted devices.

The hypervisor can already read all the VM's memory, it doesn't make
alot of sense for the VM to try and be defensive here in the general
case.

Jason
