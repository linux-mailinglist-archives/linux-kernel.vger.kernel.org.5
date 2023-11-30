Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078697FE7A5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 04:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344199AbjK3D3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 22:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjK3D3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 22:29:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5BD1B4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 19:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KzUCaiBxlCQAig49WO2ddiIpIQAq6C9H0nvIt9MnJxk=; b=X30FX6RoIF8uET3Kc8+Mi1Ti7y
        rnuewCmgbFVJtaHP8jqjWa1iVEUV1CWxeSxrfFkrgf6x0jbq5jiWkIK7Mx1e8uficbB6HkWI9tvDe
        tStb/WnFgn4eJUYGl89zpWd2UnW4exHZI8B3KQExvS7hVq4ug60fQ6/jQKcQzFiOShWMiXsQBfgC/
        Xvf411d8LvFmNSeNAGaZqDO7UAjzmJX2mH7mfGw2sruSsdwUF1sy03kT7+Vs4hiXOqz8KsZlP/BS5
        4Q91rLFDlPqsYg0qouu0LStvdF9Fu/aDx5r1wl6MgFOgyNcC3zGCSuRRXGEi9Ik6plrOpJ1MWER0H
        vg9Hr2Rg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r8Xjz-00E2d0-CZ; Thu, 30 Nov 2023 03:29:27 +0000
Date:   Thu, 30 Nov 2023 03:29:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     zhiguojiang <justinjiang@vivo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH] mm:vmscan: fix shrink sc->nr counter values issue
Message-ID: <ZWgBl07bJqrLTpzZ@casper.infradead.org>
References: <20231129130126.2130-1-justinjiang@vivo.com>
 <ZWdWFx1mXl29dP5U@casper.infradead.org>
 <dc01e0d2-17db-4531-bc7d-7d637d96c2f1@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc01e0d2-17db-4531-bc7d-7d637d96c2f1@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 09:56:59AM +0800, zhiguojiang wrote:
> > > -		 * If kswapd scans pages marked for immediate
> > > +		 * If kswapd scans massive pages marked for immediate
> > I don't understand why you've added the word "massive".  Do you mean
> > that the pages are large, or that kswapd has scanned a lot of pages?
> The added "massive" means that there are a large number of pages marked for
> immediate reclaim on evictable LRUs.

Then the word "many" communicates your meaning better.  "massive" would
mean that each page is very big, while "many" means that there are a
lot of pages.

It was foolish to send out a v2 so swiftly.  Best wait for someone who's
familiar with this code to respond to it now that you've clarified what
you were doing.
