Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1C775B51A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjGTQ7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjGTQ7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:59:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B2F119;
        Thu, 20 Jul 2023 09:59:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3732161B75;
        Thu, 20 Jul 2023 16:59:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0480EC433C7;
        Thu, 20 Jul 2023 16:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1689872382;
        bh=VQP4is4iOB2/41AHouFlM3A0fVhNC+wCz4HgAMyDQJA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TMBoI2XM8Qy1bdgkB4k3gZ/g21ckwokUfTE4m3rYc60ZnJMwhRxAw4E/ku8iXOhdm
         5cHctZA2oLj/p+se92cTa8MbmUQaSeVtxBtrV/dk47aRPFjGILnGgZU6sgRGDL2jaD
         ZyZJbtkv8Kse+lZlsju/ncyPaxn554dwqIf7uArc=
Date:   Thu, 20 Jul 2023 09:59:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Yajun Deng <yajun.deng@linux.dev>, corbet@lwn.net,
        m.szyprowski@samsung.com, robin.murphy@arm.com, paulmck@kernel.org,
        catalin.marinas@arm.com, rdunlap@infradead.org,
        peterz@infradead.org, rostedt@goodmis.org, kim.phillips@amd.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v3] dma-contiguous: support numa CMA for specified node
Message-Id: <20230720095941.76803bbda5ad0c5103713d0c@linux-foundation.org>
In-Reply-To: <20230720115408.GA13114@lst.de>
References: <20230720082517.GA7057@lst.de>
        <20230712074758.1133272-1-yajun.deng@linux.dev>
        <25942dafbc7f52488a30c807b6322109539442cf@linux.dev>
        <20230720115408.GA13114@lst.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023 13:54:08 +0200 Christoph Hellwig <hch@lst.de> wrote:

> On Thu, Jul 20, 2023 at 08:47:37AM +0000, Yajun Deng wrote:
> > It's based on linux-next tree.
> > 
> > This patch should be after my other patch in linux-next tree.
> > a960925a6b23("dma-contiguous: support per-numa CMA for all architectures").
> 
> Where did this land?  dma patches really should be going through
> the DMA tree..

It's in mm-unstable with a note "hch" :)

I'll drop it.
