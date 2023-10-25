Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E45F7D6B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343919AbjJYMaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbjJYMaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:30:14 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F968F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 05:30:12 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6ce2bcb131fso3645751a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 05:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698237012; x=1698841812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9DG403nD2V19bQC0UpYqMu9IRQQKhJgIcJ3freQIKoE=;
        b=m7TFjkQzx8/cHqYWih5FdEvVr4Ej2XOdwqUiHZR71LBJIBuYV84FWJiSUuw2/aK1z4
         +FvHcyoJCChtpxSA91UsTutAzVrnE8aHJLPWcLm/cdYyZtp+vKbtwDOBci9exdtQbWyR
         aCTSJxEIyAMOma+j9DDdQymMBF93/OJWtfj3PU/Q/SBBxeKBC+G1obozMv4HDXyQ/r57
         T48GeBl72GfQM8X0ROJcP/hpO/AgYKxoWzu9f/9FVFDj+goqKtO+hUXTLFjzb0kBTge3
         fmAeQGQDYLm5Icb0AIVL2HlYk4ZAqZ4+PKsyKeRLUW3ol8mU/29n12W6AjFBSIUO1sBu
         K8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698237012; x=1698841812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DG403nD2V19bQC0UpYqMu9IRQQKhJgIcJ3freQIKoE=;
        b=Z5z359ElrrlGoiLCuvK6lo2t+u7iJ9JRnGgUdpHwQAnkIGi6LxoTNGmD7Hh228ETEM
         WqDyE6JmLMn9iASDVMMHV+NhoAVGhhKbhJbaNWgAmbDaE4Ov2DyYM1Gtpow8fIJCW1MZ
         G4KPa2CU8LgniK9DoPe8qgVblflZ6Dpo57/9fDh2HLrdX9UUbseorMsQfc/Yyw+H1MHt
         qeKFuGCV72tTfe29idelWWkyhpJhlo8dz8qfK/8JVeHISxVVqEuQQ+liTXdWjDRGesyn
         s9FKLcLQxTj4nSRHaOJ4FTpLsM9HvFAOxbX0LdrSAEOrY6DiqxjtqLXqxWJkFMES9QZD
         I6xQ==
X-Gm-Message-State: AOJu0YzPWUM9iMKrcGTx7/+PIk2J16uH+07zjbUF2iyd/3K1rcoBZ3U6
        sx0RnNQ966vRMQV9h74Ek7cHFg==
X-Google-Smtp-Source: AGHT+IEJOcOZKL0zy8oglZlyZrvfqEvQLpCVmTAD59/utMgZ3IZcnStseBPSR1WbJdjae8MoeharIw==
X-Received: by 2002:a05:6870:9f8a:b0:1dc:33a:40d8 with SMTP id xm10-20020a0568709f8a00b001dc033a40d8mr19973908oab.4.1698237011790;
        Wed, 25 Oct 2023 05:30:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id du3-20020a0568703a0300b001e11ad88f7csm2569262oab.30.2023.10.25.05.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 05:30:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qvd1V-004frI-De;
        Wed, 25 Oct 2023 09:30:09 -0300
Date:   Wed, 25 Oct 2023 09:30:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tina Zhang <tina.zhang@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v9 0/5] Share sva domains with all devices bound to a mm
Message-ID: <20231025123009.GO691768@ziepe.ca>
References: <20231018050640.24936-1-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018050640.24936-1-tina.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 01:06:35PM +0800, Tina Zhang wrote:

> Tina Zhang (5):
>   iommu/vt-d: Remove mm->pasid in intel_sva_bind_mm()
>   iommu: Add mm_get_enqcmd_pasid() helper function
>   mm: Add structure to keep sva information
>   iommu: Support mm PASID 1:n with sva domains
>   mm: Deprecate pasid field

I don't know where Joerg has gone, he hasn't been able to answer three
emails about this series in the last week. I'll take it through the
iommufd tree so we can have an orderly next cycle for the three driver
series already posted. If it reaches Joerg's tree before Sunday I'll
drop it.

We should have a discussion about process at LPC.

Regards,
Jason
