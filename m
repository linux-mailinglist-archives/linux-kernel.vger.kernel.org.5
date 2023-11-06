Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BCB7E1B54
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 08:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjKFHhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 02:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjKFHhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 02:37:33 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7D5D75
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 23:37:26 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 489A96732D; Mon,  6 Nov 2023 08:37:24 +0100 (CET)
Date:   Mon, 6 Nov 2023 08:37:24 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jia He <justin.he@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, nd@arm.com
Subject: Re: [PATCH v4 1/2] dma-mapping: move dma_addressing_limited() out
 of line
Message-ID: <20231106073724.GA17734@lst.de>
References: <20231028102059.66891-1-justin.he@arm.com> <20231028102059.66891-2-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028102059.66891-2-justin.he@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +bool dma_addressing_limited(struct device *dev)
> +{
> +	return min_not_zero(dma_get_mask(dev), dev->bus_dma_limit) <
> +			    dma_get_required_mask(dev);
> +}
> +EXPORT_SYMBOL(dma_addressing_limited);

I've changed this to an EXPORT_SYMBOL_GPL to match dma_get_required_mask.
