Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9367FE508
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 01:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343841AbjK3Ajt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 19:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjK3Ajr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 19:39:47 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B051A6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 16:39:53 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-58d439e3e15so179402eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 16:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701304792; x=1701909592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dqKTf6r/9DX5X0G9N0YPszfAss74aB4UlJwKc4ipXlY=;
        b=gJeX5uHA1xRqlJ/NiA8klcilclFAkpTYoxKBf2ye+8qryZEh2tC6Ns0dAY8FdjXziV
         ZUDnlI8kYjSxCj9nAOh37pJd+ErExStgh7MgF5jPSpwIg0JcOyZ/+wKLRKoWBSCMbT1F
         PxL0Jom0KbNcioSagO/WECnaxufHktzDqUznGVUXUlp7hXviyKPQPc7F9p7kwjQRN9zl
         XKd1RWv6bCXpJ+fHMPYZLSUnKVtgMsPyq5ypXQvxsU7o7Q/0gqU2Oex6U1sjV1jpOPFs
         AvdabnAch/SxZjfHaDOZXkcy4ooJrMuH/piV/3/s5PI3fB5FQnZc4oN/Uwuh/k/7GBQz
         EU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701304792; x=1701909592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqKTf6r/9DX5X0G9N0YPszfAss74aB4UlJwKc4ipXlY=;
        b=PKDXWaAlCVHRK7ngM+Ix3P40IcO8ub8b0XcPCj0nuDz4dLCnFkBbB9CZdthFEmxSU7
         H49EFxsBn4kP4nbKxFANhDh6iwZrnkmiAnerXKwA8h0lgkk6nsc4p2uB+BAtePc7bK6/
         2oglZ9Te+cdxqT7Ns8zN7CxkGPPFhgOxRbpecMlZYNrRqGJsM0ojbH+euvdvetP0ivxu
         SiJsIcfYo5COkylzFAZhMcCLzfGKz3tIInOE8wNcEKd0nHWOO1kCEMAO0xokCmBN8SDj
         qacR5mGkwXGg9rkEP2mX84KxyGMg7GjEIWpuknrS0LQlT3ItqqeD2rqXU3rYG/H+ji8k
         81gw==
X-Gm-Message-State: AOJu0YyRpSep+OJmpqf2My0gHD04UY5s5ixflKjzbs2dsNS8k8VFQraa
        zkFDaMHG6WbcYzKgg/JT+FUmDg==
X-Google-Smtp-Source: AGHT+IG4kpqJkp5MuGe0QWOyJQ+HDuDWisfSFN2LiYZ3lNwDJg400B3FZHlbHx5WpKar2Jc43DZwNA==
X-Received: by 2002:a4a:a645:0:b0:58d:6bf6:4daf with SMTP id j5-20020a4aa645000000b0058d6bf64dafmr7941560oom.2.1701304792652;
        Wed, 29 Nov 2023 16:39:52 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id i14-20020a4aab0e000000b0057327cecdd8sm2410792oon.10.2023.11.29.16.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 16:39:52 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r8V5r-005qzk-3H;
        Wed, 29 Nov 2023 20:39:51 -0400
Date:   Wed, 29 Nov 2023 20:39:51 -0400
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
Subject: Re: [PATCH 3/7] ACPI/IORT: Handle memory address size limits as
 limits
Message-ID: <20231130003951.GA1394392@ziepe.ca>
References: <cover.1701268753.git.robin.murphy@arm.com>
 <2ae6199a9cf035c1defd42e48675b827f41cdc95.1701268753.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ae6199a9cf035c1defd42e48675b827f41cdc95.1701268753.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 05:43:00PM +0000, Robin Murphy wrote:
> Return the Root Complex/Named Component memory address size limit as an
> inclusive limit value, rather than an exclusive size.  This saves us
> having to special-case 64-bit overflow, and simplifies our caller too.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/acpi/arm64/dma.c  |  9 +++------
>  drivers/acpi/arm64/iort.c | 18 ++++++++----------
>  include/linux/acpi_iort.h |  4 ++--
>  3 files changed, 13 insertions(+), 18 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
