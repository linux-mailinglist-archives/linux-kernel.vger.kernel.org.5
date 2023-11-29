Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E64D7FE0CB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbjK2UKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbjK2UKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:10:18 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4052610C0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:10:22 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6d817ccaa6dso134750a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701288621; x=1701893421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rHJA5Yeky915FldzKVWXmcEmJkb/NyXXE4CZH+o9wtk=;
        b=TMX/b42YSqQWGRv8SJ31XUxjsROrb0nVxWAOAzXJM5oU7AGvONOikPI0gg4q+AkmdQ
         dJhxzBaSJvn9pZCBZJtONFFfTF8ilewvl0USnvsI9z8wBLBB34zy+CBDqqg7G7277H2m
         RQYlT+IBbJxzZslEgv640Ec0+Y/tGTtEDp2+uzrpkJwFJsp7UTfGxqlCy/YYuAqWKj7K
         7PofxekIH+NL/O2eoKxaNcZl9u1+zM8eekqPU94xK5MTvW8FKH3NYnwQe3JiKWMUueGh
         zsgLx6FU+7f5FhQmq2iy75ABqqaoKhCH10Kcz26a/bnSvUMHkdkS/NP2yv/I/M3xdYxu
         carQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701288621; x=1701893421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHJA5Yeky915FldzKVWXmcEmJkb/NyXXE4CZH+o9wtk=;
        b=XOZgaLMyEDsZ1uIEl6q0RyKPM9xHEq7aobG06CMyUBRpYDWCOo567yYoGKc7rK4dfZ
         z3swdfanQDMLn82ClRhpsYLbWZJB3inlio0+i0mEoLxBwHP6JRa4m5n1OnSpGDErFLJi
         bhwzyqlXb0ONjEqqGlUmA++k3MO3IwGPjaEPH16wUu4AP+IfFHm1KkplXrF98R2+HXln
         MyPwr6lU9cba5zIPABp0bHP4HXfUtfQnsaKE41zMN91T3HdG9lXRxTnSOdHBmAKoyY0Y
         57vlzdAifJUoWfW7rTWnNjl42zWPO1DJ5Js692/bZF9oZLDP6APg5vT+P9my1xOxDXR2
         6ugw==
X-Gm-Message-State: AOJu0Yy31Ab/4dTIdL0kZG3x+S0Vn7DsOWYM93RUONA2Now1bbfBqsKz
        CCEMJxqPajFxC56tfB6NQTZVTg==
X-Google-Smtp-Source: AGHT+IGPGnuc5Am8VWo68rNz8SzuiAXNuTN8/tCcUTvWfbbrTAaPJlaetZ3rzD+6iGGYpZmalGlQAw==
X-Received: by 2002:a9d:6f01:0:b0:6bd:93e:460b with SMTP id n1-20020a9d6f01000000b006bd093e460bmr21088456otq.19.1701288621545;
        Wed, 29 Nov 2023 12:10:21 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id s8-20020a9d7588000000b006b753685cc5sm2083142otk.79.2023.11.29.12.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 12:10:21 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r8Qt2-005pR2-Ao;
        Wed, 29 Nov 2023 16:10:20 -0400
Date:   Wed, 29 Nov 2023 16:10:20 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Omit devTLB invalidation requests when
 TES=0
Message-ID: <20231129201020.GK1312390@ziepe.ca>
References: <20231114011036.70142-1-baolu.lu@linux.intel.com>
 <20231114011036.70142-2-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114011036.70142-2-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 09:10:34AM +0800, Lu Baolu wrote:
> The latest VT-d spec indicates that when remapping hardware is disabled
> (TES=0 in Global Status Register), upstream ATS Invalidation Completion
> requests are treated as UR (Unsupported Request).
> 
> Consequently, the spec recommends in section 4.3 Handling of Device-TLB
> Invalidations that software refrain from submitting any Device-TLB
> invalidation requests when address remapping hardware is disabled.
> 
> Verify address remapping hardware is enabled prior to submitting Device-
> TLB invalidation requests.
> 
> Fixes: 792fb43ce2c9 ("iommu/vt-d: Enable Intel IOMMU scalable mode by default")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/dmar.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

How did you get to the point where flush_dev_iotlb could even be
called if the iommu has somehow been globally disabled?

Shouldn't the attach of the domain compeltely fail if the HW is
disabled?

If the domain is not attached to anything why would flushing happen?

Jason
