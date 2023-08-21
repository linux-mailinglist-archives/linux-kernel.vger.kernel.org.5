Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4F8782EF9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 19:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbjHURBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 13:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjHURBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:01:11 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB00FF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 10:01:02 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-76daefce551so20518785a.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 10:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692637261; x=1693242061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qp0mp4oKv9QJH2WNBMG+dMHV2S+Emhcg8pj4eiwry6I=;
        b=owUGxInYWGETc4Byt9qhOufCBlVpnQr39WF5+gGKIgsoShD+J8oyY6c8cXx6JLmJQh
         o3k7KiU6gAg+P3ufYR+t+aLNXl2l2o9ATj/s+OML35OLWn22moFaCxPzfEnwkOHU6etn
         D4DEYVIOIvJ3j/T+beSJPKauBBj1mX6moMVdZcZsKyOkx0DGBe96RFqaE+NPvm88AI98
         sZDPwbfPaqBwneSsIRDK1BL/tmEMlbYBcnGmY8eRNfsXAAoqd8VQSm/RC1iNUtTbwL7y
         4ws+ht1grGxMjzZuY44/MMkxrVJdd8h5VHNqGPapA/kAclCDwXEorlkLi1IbjvtXgQkT
         bbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692637261; x=1693242061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qp0mp4oKv9QJH2WNBMG+dMHV2S+Emhcg8pj4eiwry6I=;
        b=knIuFdZAoYXLg7Uj4c6JyAS1HMTxnFrQJ9CLNMhqNWVQAlcuA3FkiRJy2XvdUmTuz6
         4VwMmfUmxvYHarYvwQ0xKspSCH486sNsRYbB0qAo9GEhA2r/abVYQKIDMnt0zsBfGhvp
         aBijoQ32xoogDZmiD3QIVmX98UJ/SjbmigceNSHyjWx+2MdxMExBqLU7GIpXrJw8JVTp
         DSRewSXMtXYtEC3bPKJy2PviLih1eqLrtaVbMEPLTwwqDRrQ+cLXVQsskwtkNAiWAqCq
         ul5tKkfMY6EUbj/a/VjoCAEmW+gTsDkJzORru433NXStfF6Fomi6BWkP02YJRp45OKD3
         Ov6w==
X-Gm-Message-State: AOJu0YynoStzbXU4/Xjr3ILZdsZMT0Uzr7C8b1v3d0dgy4RpFSCzz5aI
        HklQ2jAT4ckXYBB2pyGYk5jMQw==
X-Google-Smtp-Source: AGHT+IHlN4tly8d2T2RVI8aDQ+SFzup3PPM5KO0yIMtl0SMNI2iXsSHA0d9eUjaH5xpnlr6zrfUOPA==
X-Received: by 2002:a0c:b455:0:b0:649:c4f:8d81 with SMTP id e21-20020a0cb455000000b006490c4f8d81mr5856142qvf.5.1692637261620;
        Mon, 21 Aug 2023 10:01:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id p6-20020a0ce186000000b0063f88855ef2sm2987702qvl.101.2023.08.21.10.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 10:01:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qY8Gy-00DumB-IP;
        Mon, 21 Aug 2023 14:01:00 -0300
Date:   Mon, 21 Aug 2023 14:01:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/11] iommu: Cleanup iopf data structure definitions
Message-ID: <ZOOYTLmgJuV3zxYm@ziepe.ca>
References: <20230817234047.195194-1-baolu.lu@linux.intel.com>
 <20230817234047.195194-5-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817234047.195194-5-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 07:40:40AM +0800, Lu Baolu wrote:
> struct iommu_fault_page_request and struct iommu_page_response are not
> part of uAPI anymore. Convert them to data structures for kAPI.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h      | 27 +++++++++++----------------
>  drivers/iommu/io-pgfault.c |  1 -
>  drivers/iommu/iommu.c      |  4 ----
>  3 files changed, 11 insertions(+), 21 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
