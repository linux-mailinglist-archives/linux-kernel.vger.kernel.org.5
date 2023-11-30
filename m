Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546A07FE46E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 01:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjK3AC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 19:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjK3ACz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 19:02:55 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2B4137
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 16:03:01 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1fa4e47f6c0so697739fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 16:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701302581; x=1701907381; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iqaBGyfV5ntKwlfmxQAMawFx8i861c6WUBXKE0OU9B4=;
        b=iOzGNPohtJhV5ZKZto6OPi9ScC3+3i49b+LcVuxDq9mtzkWFxOvciaUfeoR4sw7MAj
         QkroWu54eoGEksnarJc5KLNbJjo2b9/mRbC+ARswRHSJSyHf6r8cA77yjWE15tnQlLyz
         LBW/x9VdJrPUIKxS84g8k0Qs9ndFvOUUMlXB7Nqmt7sEcoM/fPyFN2BUh3cbS5mvHdg0
         VdkVOj4Kg/Qxda/ukbmSUzOpmMJI+XXCavYOg10/lBhhL0UvytuwbmpE/8guWJYyiZ+X
         V6X2LIvossUNdgs1k1Z5XJ0azlmaKkohR5dD+1WWKcXd1aFqIkEqAhpHzDOqblxLktkC
         OKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701302581; x=1701907381;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iqaBGyfV5ntKwlfmxQAMawFx8i861c6WUBXKE0OU9B4=;
        b=qPW0I82RXwY86jYEvxDigNZPW00DgS8CByVWHYOvEMtKK4lBSl0NjhxBHNopekLUsx
         9uyXwJA3ybCFWN9tfKU8jNjseYIww1EckhahQle5LitIGnji1+a3iCm7SF6VbTwvH1M2
         EuqVjSp96WacBflMcs7uLTCGhz1c7Ucj6hFZ5CSATJYBP2VZ2KTkUXTSyY7C5nJPqbUe
         RP5TULHBJA5GObjz1j4oqPzu68+Bn59Z1WhY/0T24RK8LPFMrAcH146I6L/23Sq3FDUE
         BY2FOAqXjy5q3ogsyq8F/dIBMD2iDFmqiFPEv+lYa8Zg5bXlESNFChtMANSmNt8zSg+0
         GB8A==
X-Gm-Message-State: AOJu0YwCiMYHvBkrOeuPNJzTSsFEF/iopVLvKp8anMTXTCCg5EsqJm5l
        F01PVnnTvFy5pakXB71uvUefwQ==
X-Google-Smtp-Source: AGHT+IH9mJrgeBca3QDmdqlZSO64E6UWuuZZMjhMVoz9rZsKA5pWXiF1aXxzzo/4HFbYhkfRvbso7A==
X-Received: by 2002:a05:6870:1603:b0:1f9:eb7e:6621 with SMTP id b3-20020a056870160300b001f9eb7e6621mr10166623oae.18.1701302580971;
        Wed, 29 Nov 2023 16:03:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id ry4-20020a056871208400b001efa3446d4esm3609159oab.43.2023.11.29.16.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 16:03:00 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r8UWB-005qQQ-Hz;
        Wed, 29 Nov 2023 20:02:59 -0400
Date:   Wed, 29 Nov 2023 20:02:59 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     akpm@linux-foundation.org, alex.williamson@redhat.com,
        alim.akhtar@samsung.com, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, baolu.lu@linux.intel.com,
        bhelgaas@google.com, cgroups@vger.kernel.org, corbet@lwn.net,
        david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org,
        heiko@sntech.de, iommu@lists.linux.dev, jasowang@redhat.com,
        jernej.skrabec@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
        kevin.tian@intel.com, krzysztof.kozlowski@linaro.org,
        kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, lizefan.x@bytedance.com,
        marcan@marcan.st, mhiramat@kernel.org, mst@redhat.com,
        m.szyprowski@samsung.com, netdev@vger.kernel.org,
        paulmck@kernel.org, rdunlap@infradead.org, robin.murphy@arm.com,
        samuel@sholland.org, suravee.suthikulpanit@amd.com,
        sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org,
        tomas.mudrunka@gmail.com, vdumpa@nvidia.com,
        virtualization@lists.linux.dev, wens@csie.org, will@kernel.org,
        yu-cheng.yu@intel.com
Subject: Re: [PATCH 09/16] iommu/iommufd: use page allocation function
 provided by iommu-pages.h
Message-ID: <20231130000259.GS1312390@ziepe.ca>
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-10-pasha.tatashin@soleen.com>
 <20231128235254.GE1312390@ziepe.ca>
 <CA+CK2bC=vMU54wXz1GSzpOcLFCuX5vuE6tD49JF8cMbz4tis-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bC=vMU54wXz1GSzpOcLFCuX5vuE6tD49JF8cMbz4tis-g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 04:59:43PM -0500, Pasha Tatashin wrote:
> On Tue, Nov 28, 2023 at 6:52 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Nov 28, 2023 at 08:49:31PM +0000, Pasha Tatashin wrote:
> > > Convert iommu/iommufd/* files to use the new page allocation functions
> > > provided in iommu-pages.h.
> > >
> > > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > ---
> > >  drivers/iommu/iommufd/iova_bitmap.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > This is a short term allocation, it should not be counted, that is why
> > it is already not using GFP_KERNEL_ACCOUNT.
> 
> I made this change for completeness. I changed all calls to
> get_free_page/alloc_page etc under driver/iommu to use the
> iommu_alloc_* variants, this also helps future developers in this area
> to use the right allocation functions.
> The accounting is implemented using cheap per-cpu counters, so should
> not affect the performance, I think it is OK to keep them here.

Except it is a mis use of an API that should only be used for page
table memory :(

Jason
