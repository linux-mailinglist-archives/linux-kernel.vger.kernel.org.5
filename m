Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE447D29EA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjJWGJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJWGJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:09:24 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68F1D65
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:09:22 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F28EA68AA6; Mon, 23 Oct 2023 08:09:19 +0200 (CEST)
Date:   Mon, 23 Oct 2023 08:09:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jia He <justin.he@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, nd@arm.com
Subject: Re: [PATCH v3 1/2] dma-mapping: export dma_addressing_limited()
Message-ID: <20231023060919.GB11907@lst.de>
References: <20231016125254.1875-1-justin.he@arm.com> <20231016125254.1875-2-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016125254.1875-2-justin.he@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 12:52:53PM +0000, Jia He wrote:
> This is a preparatory patch to move dma_addressing_limited so that it is
> exported instead of a new low-level helper.

So while this exports dma_addressing_limited that's really a side effect.
The primary thing is that it moves the function out of line.
