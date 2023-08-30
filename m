Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E607278DB9F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239343AbjH3SkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343735AbjH3QoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:44:03 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC20119A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 09:43:59 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bdc19b782aso37284565ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 09:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1693413839; x=1694018639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lys1zqL5/DflOY2CEUv0l1jES6B5BHfh+5mdgRFaHc0=;
        b=ntbkGJohnq2XiW0I7u5T7Q03wI2URgpZlXyZrEuCKaZXTL20wzvXjK/322qf5U+47I
         rJ67qJiNxdCcfhTgQaDSKkgH1ZNMwaj6qF6F0HQ6fr/eS89DKEDQ+Jz3JEl8KuXH7+zv
         O3mg+bb6gjNUvvSpd/t6h/eDTzxaiNQKgNcUekFruP9EpAahPBo9wXco3hgfDpltYglA
         yqIXlrnlRRAoBxH2Kyi47NvyVgRxObfyWh410kwb0iSXje6nDN5/Ray2/J5zivoIQVSO
         9s55bgrT/1nXQt0poinw2DU0kvnoMc2tptog5BxPqMwPwM5Tj5zhr/8djliM/xwuERI7
         Gtdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693413839; x=1694018639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lys1zqL5/DflOY2CEUv0l1jES6B5BHfh+5mdgRFaHc0=;
        b=QK7OtD75PQuEu3TnM3Jz7cxbyUB4di6kKglaGT7IQyf/8Vs9vZCnCS1RQ1NUdTCqHF
         +hbg6d7TROXa52ugJUtOF2eh9pyKkoQyUPKAiEx9u+dwbwksL7zMDcqUBtO9wtDbzsAY
         MSRXUU9A25KoWB6p0qk6rs+Fh3JWkcQzGbqE8tGLsLR6HkvWpf4QwcxHOo1cTSpJlgLe
         7IM+/VDWebVVm59ykjvunFeUubTSLvIeEEDkncrFJhohS4BUsaXCViFIC3RGWX0loBhx
         Opy+CyKYBM/xpPSyMNLdLecd0T6gMGJKxGWvsMFA+Buk5aOm4LSf73ivBxJVTSFa+ezm
         r/gw==
X-Gm-Message-State: AOJu0YxCBQSg8CmfPcI/Ax4ez1BDvwf5kfn9lkhMoyAPtEdfeuNuiJsT
        i8RY+2zK8t+JkMLp82GWdQDDUA==
X-Google-Smtp-Source: AGHT+IEgvTm6ZPGyWF9D7X3ASVWWGrWtPIK9lG2unX/1lX5zpfNCJ9O15xyfLMCZkZhVk6ehLCACdA==
X-Received: by 2002:a17:903:22ca:b0:1bf:d92e:c5a7 with SMTP id y10-20020a17090322ca00b001bfd92ec5a7mr3002630plg.28.1693413839424;
        Wed, 30 Aug 2023 09:43:59 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902d31200b001b53c8659fesm11280968plc.30.2023.08.30.09.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 09:43:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qbOIP-0005rb-8y;
        Wed, 30 Aug 2023 13:43:57 -0300
Date:   Wed, 30 Aug 2023 13:43:57 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Anle Pan <anle.pan@nxp.com>, m.szyprowski@samsung.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, hui.fang@nxp.com
Subject: Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment size
Message-ID: <ZO9xzf727b/YvZB/@ziepe.ca>
References: <20230828075420.2009568-1-anle.pan@nxp.com>
 <CAAFQd5Cn3xQroyYtC+m+pk1jOE5i3H+FGr-y8zqhaf0Yo5p-1Q@mail.gmail.com>
 <deb735ce-7de1-e59a-9de4-1365b374b417@arm.com>
 <20230829150442.GA3929@lst.de>
 <CAAFQd5CiHXvsJugSi+hXY9ESsmxUzBzmbhF6G48iVsOcL5eMtQ@mail.gmail.com>
 <20230830143341.GA25574@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830143341.GA25574@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 04:33:41PM +0200, Christoph Hellwig wrote:
> On Wed, Aug 30, 2023 at 12:47:57PM +0900, Tomasz Figa wrote:
> > Do we see anything replacing it widely anywhere on the short-middle
> > term horizon? I think we could possibly migrate vb2 to use that new
> > thing internally and just provide some compatibility X to scatterlist
> > conversion function for the drivers.
> 
> Jason said at LSF/MM that he had a prototype for a mapping API that
> takes a phys/len array as input and dma_addr/len a output, which really
> is the right thing to do, especially for dmabuf.

Yes, still a prototype. Given the change in direction some of the
assumptions of the list design will need some adjusting.

I felt there wasn't much justification to add a list without also
supporting the P2P and it was not looking very good to give the DMA
API proper p2p support without also connecting it to lists somehow.

Anyhow, I had drafted a basic list datastructure and starting
implementation that is sort of structured in away that is similar to
xarray (eg with fixed chunks, generic purpose, etc)

https://github.com/jgunthorpe/linux/commit/58d7e0578a09d9cd2360be515208bcd74ade5958

I would still call it an experiment as the auto-sizing entry approach
needs benchmarking to see what it costs.

> Jason, what's the status of your work?

After we talked I changed the order of the work, instead of starting
with the SG list side, I wanted to progress on the DMA API side and
then build any list infrastructure on that new API.

Your idea to use a new API that could allocate IOVA and then map phys
to IOVA as a DMA API entry point looked good to me, and it is a
perfect map for what RDMA's ODP stuff needs. So I changed direction to
rework ODP and introduce the DMA API parts as the first step.

I had to put it aside due to the volume of iommu/vfio stuff going on
right now. However, I think I will have someone who can work on the
ODP driver part this month

Regardless, RDMA really needs some kind of generic lists to hold CPU
and physical address ranges, so I still see that as being part of the
ultimate solution.

Jason
