Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D69E75C003
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjGUHmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjGUHmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:42:32 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0355630C3;
        Fri, 21 Jul 2023 00:42:13 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B2F0F67373; Fri, 21 Jul 2023 09:42:09 +0200 (CEST)
Date:   Fri, 21 Jul 2023 09:42:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Yajun Deng <yajun.deng@linux.dev>,
        corbet@lwn.net, m.szyprowski@samsung.com, robin.murphy@arm.com,
        paulmck@kernel.org, catalin.marinas@arm.com, rdunlap@infradead.org,
        peterz@infradead.org, rostedt@goodmis.org, kim.phillips@amd.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v3] dma-contiguous: support numa CMA for specified node
Message-ID: <20230721074209.GA22859@lst.de>
References: <20230720082517.GA7057@lst.de> <20230712074758.1133272-1-yajun.deng@linux.dev> <25942dafbc7f52488a30c807b6322109539442cf@linux.dev> <20230720115408.GA13114@lst.de> <20230720095941.76803bbda5ad0c5103713d0c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720095941.76803bbda5ad0c5103713d0c@linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 09:59:41AM -0700, Andrew Morton wrote:
> > Where did this land?  dma patches really should be going through
> > the DMA tree..
> 
> It's in mm-unstable with a note "hch" :)
> 
> I'll drop it.

Ah.  And looking at the patch is isn't even pure dma but also has
a significant mm side.  If you're fine with it I'll pick it up in
the dma-mapping tree in addition to the follow up.
