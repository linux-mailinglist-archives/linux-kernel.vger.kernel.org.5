Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D428796F6A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 05:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237322AbjIGDtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 23:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237333AbjIGDto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 23:49:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DC611B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 20:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=y3uaHwASikwEouI256jZQ+4BUwGwQyFKyGeC2PlT9UA=; b=kyow9CyeqcqxWIvBbzK+d2n4rR
        ljgPkDAhqdg90vhbA/N6mfu072LxeKGD2Gj921CoJzsLZ+Pmzx79tmCQtXj8zzaaAq767KMvdH+u3
        83lQHAy+tBnpmLgieIp4cBLlxTzgqEMoC9sLU0RW/9Q0ezmXLT3G68LlwJdQ6DJYdrGYohfTwNDCZ
        NNwSWxG2yzpm90yw90eJj/wLfiPhNKTabNdeKlgxeP/7RWsCge/CV2+k66Wx7L/OjPw6/rMlSzNbg
        DKbBSS6YQZrl7VMqvWL7zoZtH7GwEdmPs//8dic19pe4GJhqEiwrtffJ0o9eHllFBZ9vO5/urD5r4
        dG+a0DNQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qe61K-007wkO-JT; Thu, 07 Sep 2023 03:49:30 +0000
Date:   Thu, 7 Sep 2023 04:49:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     =?utf-8?B?7Ius7J6s7ISg?= <jason.sim@samsung.com>
Cc:     "liam.howlett@oracle.com" <liam.howlett@oracle.com>,
        "surenb@google.com" <surenb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
Subject: Re: [PATCH] maple_tree: use GFP_KERNEL on mas_node_count
Message-ID: <ZPlIShWJWt+Kxt8x@casper.infradead.org>
References: <CGME20230907033914epcms1p61c5eed4d34d5c4212436c201f33292b3@epcms1p6>
 <20230907033914epcms1p61c5eed4d34d5c4212436c201f33292b3@epcms1p6>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230907033914epcms1p61c5eed4d34d5c4212436c201f33292b3@epcms1p6>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 12:39:14PM +0900, 심재선 wrote:
> Use GFP_KERNEL on mas_node_count instead of GFP_NOWAIT | __GFP_NOWARN
> in order to allow memory reclaim.

What testing did you do of this patch?  In particular, did you try it
with lockdep enabled?
