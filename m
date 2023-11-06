Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5E87E2CE2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjKFTcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjKFTcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:32:35 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FC1103
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:32:30 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-4ac45927974so738748e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 11:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699299149; x=1699903949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DAHtCI4uX5rSDG9hdPsxsTF21tKIZfBDAKE7xDsp3rU=;
        b=Z2jm4Z2fM/s6CReA9bNMbi06a5UFGrWJtM4czIwF5UVP2NCEgE/Lbi/nNoBg6uY3eh
         UutNwYXbnLSrdmNCi9OpK/jy9T6nsE8KET3oC3oBZWwl4SbtcQJ1ShLFHYylPkSmn7iK
         vGLEdlB86xa2m7u+i+obR0ZGO4OOhMcuHcTcn3qEJ/y2S3OsDzF2VLDq79m1pULy+mcv
         fsNZKo39mESiFIuASuhNiGmFgpPebJ16GvBfQpstPJMHNpTeKyzMpYPf+W7pcjWpuhw+
         zXk3ZjtydtJRHjq44iY0IzLz1r+lTI3FOlqUBzxyV16/uGKS+vmOtQ4Hf9gQF2TuDVhS
         a78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699299149; x=1699903949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAHtCI4uX5rSDG9hdPsxsTF21tKIZfBDAKE7xDsp3rU=;
        b=jdocTXyF+lpmZyJob40giLL9+WRGW5ljTl/36HjkK5rCLttex+57zFEPxz92QUHi0O
         fDVYZwZlygCE1nCpsI+6Y6WMGrV34Er0mQ2rEoHrGnNv6BEseiI/HvtTM4IxoUtKFldS
         RBWZWYP14KZBdcZ42eoArAwFwM+3KweRD9BosmMP00cD/rMOqQZxJYefS7NQ3uMulTat
         dRUyKkMn4IClemWBM+WhTqgV6k2UZaPDt20YHLsMFxCw369neX1WFt6sp5+adgOz1zoT
         /poKM7GePw80Pf+i4We1CHDWwmTfMTt9C6G0XrqcA2LgPpKg08vWP4Abdfu8yYsT40wj
         1mkQ==
X-Gm-Message-State: AOJu0Yz7NvrEfJdv1yXnj9IrtECANLEyfmE4B3QyH423fisF0Y0RLzKn
        zzTaPV4CCgVmboTz72tfMS5NuhdqZV30vk7v+mU=
X-Google-Smtp-Source: AGHT+IHHrThxyHmJktLceZ794OYsaOv21wFux00FTZbUeam8b2XhNtl+ya1TeSFos/G045SdeP1ylg==
X-Received: by 2002:a1f:1c4a:0:b0:49b:289a:cc4a with SMTP id c71-20020a1f1c4a000000b0049b289acc4amr27005359vkc.3.1699299149465;
        Mon, 06 Nov 2023 11:32:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id b3-20020a0ce883000000b0066cfd398ab5sm3663160qvo.146.2023.11.06.11.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 11:32:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r05Km-001Qut-BY;
        Mon, 06 Nov 2023 15:32:28 -0400
Date:   Mon, 6 Nov 2023 15:32:28 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tina Zhang <tina.zhang@intel.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, joro@8bytes.org,
        will@kernel.org, Yi Liu <yi.l.liu@intel.com>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/5] iommu/vt-d: Add generic IO page table support
Message-ID: <20231106193228.GU4634@ziepe.ca>
References: <20231106071226.9656-1-tina.zhang@intel.com>
 <20231106071226.9656-3-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106071226.9656-3-tina.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 02:12:23AM -0500, Tina Zhang wrote:
> Add basic hook up code to implement generic IO page table framework.
> 
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>  drivers/iommu/intel/Kconfig |  1 +
>  drivers/iommu/intel/iommu.c | 94 +++++++++++++++++++++++++++++++++++++
>  drivers/iommu/intel/iommu.h |  7 +++
>  drivers/iommu/io-pgtable.c  |  3 ++
>  include/linux/io-pgtable.h  |  2 +
>  5 files changed, 107 insertions(+)

If this is going to happen can we also convert vt-d to actually use
the io page table stuff directly and shuffle the code around so it is
structured like the rest of the io page table implementations?

Jason
