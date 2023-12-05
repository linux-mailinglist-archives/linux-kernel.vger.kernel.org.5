Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DB4804938
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 06:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjLEFMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 00:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344252AbjLEFMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 00:12:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6243C11F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 21:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ncz6t9/1ak5tQzeNdq4sicxqCjunw4/Fask4L2znKlk=; b=QM3JaUd6O6kjwVIotWLkMsWcxw
        FFEFIyTuo20WeeS3rQnMzCF5h5fdXw9F8hUIsor4c9xc0N3vv6XuUql4TGd5zAU7DeNSunKZTUTU1
        Fj79EOc9Kbkma5HiXEq/Gq99kU0kl5OUzVHOcJ+JETE8Az/fbNGD3MdK9b+P7GMFQDfMISGDcbdw5
        75pQZ50ioG1Xcx228O5yXnqapN4gUJhQtz6LEPQmk0UR1PYqG3CIsox+F2Ra3seecq3Gml6BZbSQa
        YZqTv9VZrMp/f4mPzxJf5+4i2o6K0HuMH1xDxdDNkxEvipwM5Qq263/xrEmUNXKh8kRNfPOeVbE2o
        0iODzysw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rANjj-006Hnu-0y;
        Tue, 05 Dec 2023 05:12:47 +0000
Date:   Mon, 4 Dec 2023 21:12:47 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] mm/damon: export DAMON symbols and add sample
 loadable modules
Message-ID: <ZW6xTyyl0qvcqi3O@infradead.org>
References: <20231205022858.1540-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205022858.1540-1-sj@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 02:28:55AM +0000, SeongJae Park wrote:
> DAMON cannot be used from loadable modules since it is not exporting its
> symbols.

And that is a good thing.  We should absolutely not allow random modules
probing MM internals.   What you posted here is basically just adding
hooks without even real in-kernel users.

