Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211197E1B58
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 08:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjKFHiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 02:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjKFHiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 02:38:03 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7AFD47
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 23:38:00 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 26CC168AA6; Mon,  6 Nov 2023 08:37:58 +0100 (CET)
Date:   Mon, 6 Nov 2023 08:37:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jia He <justin.he@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, nd@arm.com
Subject: Re: [PATCH v4 2/2] dma-mapping: fix dma_addressing_limited() if
 dma_range_map can't cover all system RAM
Message-ID: <20231106073757.GB17734@lst.de>
References: <20231028102059.66891-1-justin.he@arm.com> <20231028102059.66891-3-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028102059.66891-3-justin.he@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2023 at 10:20:59AM +0000, Jia He wrote:
> +	if (likely(!ops))
> +		return !dma_direct_all_ram_mapped(dev);
> +
> +	return false;

I've turned his around to make it read a little nicer.

