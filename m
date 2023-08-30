Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B62D78D283
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 05:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240283AbjH3DZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 23:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238878AbjH3DZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 23:25:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BDCAB
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 20:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VVA7GaUS5V1klkwOVyxNgdi/XPDy8SsdCWkheIYk4Uo=; b=b8WMJ745RNOA9XNX/H2kPTp3d+
        6EVUGgGsrlbPBVjtmRaMekDE5AHSgQmC04vqvyoHA0Ed4mqRLa4qQ6Spz6mIwjHeHcC0J2/eyDW7u
        MPXGA7hwgum7RcSyqf7MF6u7iLHuoqbcC0figH1vUOIubewZ/6fb7NBo1dtho8/Bb2M4RjJRyze6p
        C9UjWZfhtXAXhi88Ov9WfzuigwXdqKvwJA9vLS43z4syUqqT6KEh9jGk1MYeJ43M6njQdAQ8gY6kb
        xevuOjX2+DM/PhBXZ342tqeoKZlGA+kIMcFrajOrKRlw8QRMvklNZ3xTkEz2NPW2nIx7G0Dikdroy
        aDQcGnxQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qbBp7-00APzQ-6V; Wed, 30 Aug 2023 03:24:53 +0000
Date:   Wed, 30 Aug 2023 04:24:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap: Define DEFAULT_STACK_GUARD_GAP
Message-ID: <ZO62hWK7r1zc1xsg@casper.infradead.org>
References: <20230828035248.678960-1-anshuman.khandual@arm.com>
 <ZO3lQn8XZA+Q9/dF@casper.infradead.org>
 <3622f8fe-00c4-298e-0b35-06bb61b92cde@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3622f8fe-00c4-298e-0b35-06bb61b92cde@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 08:25:45AM +0530, Anshuman Khandual wrote:
> 
> 
> On 8/29/23 18:02, Matthew Wilcox wrote:
> > On Mon, Aug 28, 2023 at 09:22:48AM +0530, Anshuman Khandual wrote:
> >> This just defines a macro constant i.e DEFAULT_STACK_GUARD_GAP representing
> >> the default gap, guarding the stack mapping. This does not cause functional
> >> changes.
> > 
> > But why have you done it at all?
> 
> Just as a normal cleanup which also improves readability.

hard disagree.  NAK this patch.
