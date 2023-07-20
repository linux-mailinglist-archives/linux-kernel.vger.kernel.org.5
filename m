Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA7F75A604
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjGTGHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGTGHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:07:48 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE3D1734;
        Wed, 19 Jul 2023 23:07:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C188067373; Thu, 20 Jul 2023 08:07:42 +0200 (CEST)
Date:   Thu, 20 Jul 2023 08:07:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH] dma: DMA_ATTR_SKIP_CPU_SYNC documentation tweaks
Message-ID: <20230720060742.GA2987@lst.de>
References: <98ef4f76d7a5f90b0878e649a70b101402b8889d.1689761699.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98ef4f76d7a5f90b0878e649a70b101402b8889d.1689761699.git.mst@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 06:15:59AM -0400, Michael S. Tsirkin wrote:
> A recent patchset highlighted to me that DMA_ATTR_SKIP_CPU_SYNC
> might be easily misunderstood.

.. just curious: what patchset is that?  DMA_ATTR_SKIP_CPU_SYNC is
often a bad idea and all users probably could use a really good
audit..

>  #define DMA_ATTR_NO_KERNEL_MAPPING	(1UL << 4)
>  /*
> - * DMA_ATTR_SKIP_CPU_SYNC: Allows platform code to skip synchronization of
> - * the CPU cache for the given buffer assuming that it has been already
> - * transferred to 'device' domain.
> + * DMA_ATTR_SKIP_CPU_SYNC: Allows platform code to skip synchronization of the
> + * CPU and device domains for the given buffer.

While we're at it, I think "allows" is the wrong word here, we really
must skip the synchronization or else we're in trouble.
