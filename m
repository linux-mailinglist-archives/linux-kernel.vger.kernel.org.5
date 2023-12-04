Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B138B8038E0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbjLDPcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjLDPcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:32:05 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A715DA5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 07:32:11 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4254ad7b967so16858591cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 07:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701703931; x=1702308731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QNErOhF1qMkgPNVpHAnyVSyCwAUX/1YSBmZDFvsm8OU=;
        b=altJvCMFqLnz0th385qoKkCef9KpcoT97a66K2T11evxL+qQgeN04sZF2sJciPhIxa
         MTCpLAlzXQ/Et3m8eJlcuazUcWUcPNwH0ennEkeVk1j/pe55zuDf4BAdLOYazfOsm/ul
         6jWn5e7ZlaEMc+SMDee03zgbkmhj7ScXWJj83JUVDYdKDCHtDxCdzZBFbB061egcWZT1
         qlYYWu+paNhGEAf6akyznZHBoEUZgESyjTDVFcJYgBtmRDRCBjy9/DLfwjCpeZZKTPT6
         OOxQOSIzAcCJOINEVcKdvFNrhOLXwom8QBrCJ3e8yNm8jfNxfqC+SGJ4O+Dc00TtsKnK
         6VRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701703931; x=1702308731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNErOhF1qMkgPNVpHAnyVSyCwAUX/1YSBmZDFvsm8OU=;
        b=A8UH6sUrRjeestY7N2YPw10DHct3fzWRqtYAy3aVZN0yOhIapM+8EK1G1mmO0oH5rs
         9fNDdxA/qzr6Da4vyaGCSxufSYKuHhR4aArVSoE/de6ygvDmHJHzJuKvA7KIhvT+D85b
         NV1NsiW0z6fPV65n0jcfinndhCT2oEQubDae2jzxXdf1a/a9mu90UgjPomScUJDXBNxb
         oKODDnTJyL25AgODqOIrKQs0qYNYHwG0d5w3YLsuhJsXNWD2Wkv8qvdXlRLglKuvMYCE
         NVSFfFN/6ahc3Z/5N6oXMv29BTUINIdb17jkEn/jdEXuMLJCVicLQbrZvuF6is3A0rcL
         hePA==
X-Gm-Message-State: AOJu0YwxOXOlaf64K/6wABv84Xaw9f6ctEve5GWWp4h6t1xzpFD5Eanu
        HwGFxrowDYaT47Hn4G/VIuk3UQ==
X-Google-Smtp-Source: AGHT+IEnloh+umt8D2CaTqj/3erJ8LZq5gKurAnArFiVByvdfAGoIgyiu/VWyqqDTZ8kj1dh4ApCGQ==
X-Received: by 2002:a05:622a:1c8:b0:425:4043:96e2 with SMTP id t8-20020a05622a01c800b00425404396e2mr6614490qtw.111.1701703930810;
        Mon, 04 Dec 2023 07:32:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id df15-20020a05622a0ecf00b00423da75b0f4sm4371928qtb.71.2023.12.04.07.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 07:32:10 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1rAAvZ-00B2r2-ML;
        Mon, 04 Dec 2023 11:32:09 -0400
Date:   Mon, 4 Dec 2023 11:32:09 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joel Granados <j.granados@samsung.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Message-ID: <20231204153209.GN1489931@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <CGME20231204150747eucas1p2365e92a7ac33ba99b801d7c800acaf6a@eucas1p2.samsung.com>
 <20231204150744.db3hfpq4v55cuavn@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204150744.db3hfpq4v55cuavn@localhost>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 04:07:44PM +0100, Joel Granados wrote:
> On Thu, Oct 26, 2023 at 10:49:24AM +0800, Lu Baolu wrote:
> > Hi folks,
> > 
> > This series implements the functionality of delivering IO page faults to
> > user space through the IOMMUFD framework for nested translation. Nested
> Does this mean the IOPF_CAPABLE HWPT needs to be parented by a HWPT
> created with IOMMU_HWPT_ALLOC_NEST_PARENT set?

I would expect no. Both a nested and un-nested configuration should
work.

Jason
