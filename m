Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FEC783742
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 03:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjHVBPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 21:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjHVBPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 21:15:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC78184
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 18:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wAK2cHLht84/yxjMIHph+3aS8ewWzAUt5+bzspkCFkY=; b=gAPH5zIvEbUW45I2XJ8eiSfqxG
        gDM2yS+te0dJj6dBTAC0LZ5sey/SB+RRi4zbQNV8ZhjT3knwZ5c8m6PbHAcr+uCwDHAStG5mT4aeo
        6qr4WSUamwoxEnoc058qnnQHPZNiru7tdepeZIUIldMMIM08CVAWli/2r2tuNti4Ivcqne3CEnsLA
        sDMrhdK7UquS+ubF2ZD+cJbDzzm+h21UfMq26j/1dFMU63X6ViqcRuR6CL6YeIv4wJrs4r52Pq8zs
        W3zV/4UmWAx4WP49VuoiNaxny1lmjWAZrGlUJvPalMcmpKYh8n0cYneo446wvP5lkudeK+eP+MD0j
        JGSWnB7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYFzk-00DTug-1K; Tue, 22 Aug 2023 01:15:44 +0000
Date:   Tue, 22 Aug 2023 02:15:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH] maple_tree: shrink struct maple_tree from 24 to 16 bytes
 on LP64
Message-ID: <ZOQMP6ksHU3Nf7sM@casper.infradead.org>
References: <20230821225145.2169848-1-mjguzik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821225145.2169848-1-mjguzik@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 12:51:45AM +0200, Mateusz Guzik wrote:
> by plugging a padding hole.
> 
> [sounds like an obvious thing to do, am I missing something?]

That was how I originally had it.  Not sure when/why it got messed up.
