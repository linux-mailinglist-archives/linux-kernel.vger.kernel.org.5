Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B68E8074D5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379149AbjLFQVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379171AbjLFQVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:21:45 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 4B52AD4E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 08:21:50 -0800 (PST)
Received: (qmail 460384 invoked by uid 1000); 6 Dec 2023 11:21:50 -0500
Date:   Wed, 6 Dec 2023 11:21:50 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Ferry Toth <fntoth@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Hamza Mahfooz <someguy@effective-light.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew <travneff@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        iommu@lists.linux.dev,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB mailing list <linux-usb@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: Bug in add_dma_entry()'s debugging code
Message-ID: <c952ef3f-2890-4f1e-bb5d-057b0db36b46@rowland.harvard.edu>
References: <20231128133702.GA9917@lst.de>
 <cb7dc5da-37cb-45ba-9846-5a085f55692e@rowland.harvard.edu>
 <ZWYnECPRKca5Dpqc@arm.com>
 <76e8def2-ff45-47d3-91ab-96876ea84079@gmail.com>
 <ZWm-u2kV1UP09M84@arm.com>
 <5425cf42-0f49-41b5-b26d-1e099d5bdcc2@elsinga.info>
 <5093ce37-047e-4aa8-a9e8-2978da9d734a@rowland.harvard.edu>
 <ZWobHJqBji80CTm-@arm.com>
 <e22ae13a-aafc-49da-8092-1a17f60ae420@rowland.harvard.edu>
 <1e4df825-08fa-40cf-a565-9c0d285c9b73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e4df825-08fa-40cf-a565-9c0d285c9b73@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 05:12:40PM +0100, Ferry Toth wrote:
> Hi
> 
> On 05-12-2023 19:28, Alan Stern wrote:
> > In the long run, it may turn out that trying to detect memory usage
> > patterns that could cause problems for architectures other than the one
> > currently running is not workable.  Certainly it is a bad idea to have a
> 
> Maybe. But while debugging code on your platform it is a good thing to get
> warnings for potential issues on other platforms.

Oh, absolutely!  It's definitely a good thing.  I'm just saying that 
doing it may not be practical -- there may be too many false positives 
(as in this bug report) and false negatives.

> In this case we (I) got misled by the warning message itself. That should be
> easy enough to improve.

I don't think so.  Issuing incorrect warnings that should be ignored is 
a very bad idea, no matter what the wording is.  After seeing a few 
messages like that, people learn to expect them -- and then they ignore 
the valid warnings along with the incorrect ones.

Alan Stern
