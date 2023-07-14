Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92433753B5B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbjGNM5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjGNM53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:57:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D527273F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DahJQLuKdz+p5XMB8Vqx/A8LXfXbzJcB/v0Ff8D7d0U=; b=q5dHpd3dVO9cITILalxj5g1CXR
        WtMGJ4GZ/U2gnZL/Qd/FVtxy48Cj5U+/rkgPs1adY7RmozMH+PzC8UNR22bjC5zYZgGMWpx9/uGwM
        ex36iU9g3INbyfW76jxQoaEgWrq+NB0uY6wSq07K7qm8fFi6aruy1iCqVLCMudW01HTSZFUhO4R+X
        vxm/JoE9L36TaDVkRpqB4Utj0d8+XMVMKp4F0pM/uq5f5cFHAfBrtsnKPedYo/WHqg5ijyI0KLs1G
        03XJc6Zj77s3ZcTKW5s4bQVD4EtitsHle2rIMQgLVvdGcRw26gHEW3Me+DiSS1J/uPt4oINX8p6Iz
        OChQMBZw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qKIMK-0013sI-9o; Fri, 14 Jul 2023 12:57:20 +0000
Date:   Fri, 14 Jul 2023 13:57:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Maple Tree Work
Message-ID: <ZLFGMGtk2WMbGhuf@casper.infradead.org>
References: <20230707163815.ns4kdz7iut5octjv@revolver>
 <0152143a-b105-a413-ddf2-47f688633d97@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0152143a-b105-a413-ddf2-47f688633d97@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 05:58:13PM +0800, Peng Zhang wrote:
> I have a question I want to discuss here. I noticed that the interface
> of maple tree has three different prefixes, namely mtree_*, mt_*, mas_*.
> I am curious why the interfaces prefixed with mtree_* and mt_* cannot be
> unified? I think they can be changed to mtree_* to avoid two different
> prefixes.

I haven't worried about this too much.  The long-term goal is to use
the maple tree data structure to replace the radix tree data structure
underlying the xarray and use the xarray API to access the maple tree.
The xarray API will need some enhancements to make this work, but churning
the maple tree API doesn't seem like a good use of effort.
