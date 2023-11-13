Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703587E9423
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 02:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjKMBgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 20:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKMBgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 20:36:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E3A1BF1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 17:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=+D7ccdqm6TDj+4rVpt2CUxxkfNoxynYNLh9SSF9Rt2I=; b=eWirk8EiFe1xHnPFFvKh+zUsUa
        yDQQNme9s61dDuMh2O7ZtUG7gNUG2DNWl+/wdQKDyuIqBHAjBQbkXdFNaB2PsAUwSvgnJ0Y+sUHUj
        9rY5A7pU/9zK+I53VWBZc1utkhTffnw+0PZMPfuqAWieIzkimwvhNXgUqgbl65o7jG8I80O/BlJ+X
        QlRoqWW9lTNxbfKwiaJ5JG6vzz+8L5mU9DmRFilQu1gAjXmtDGqiFP5Qkn7odNdeFaIjjw/RMgRSv
        xosZp3XvMPqARxv8mWbdNV89uz1sHvKYr4F0KyK2gJO+XsllEueD318mHATe3Ek3ww6QgNalhqKzd
        wLwkgBAg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r2Lrz-00BNan-3y; Mon, 13 Nov 2023 01:36:07 +0000
Date:   Mon, 13 Nov 2023 01:36:07 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     zhiguojiang <justinjiang@vivo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v2 1/1] mm: ALLOC_HIGHATOMIC flag allocation issue
Message-ID: <ZVF9h6M6dK5AZDg7@casper.infradead.org>
References: <20231109073133.792-1-justinjiang@vivo.com>
 <20231109073133.792-2-justinjiang@vivo.com>
 <20231109094954.dd4b2a5b1f5dfcc9a721edba@linux-foundation.org>
 <ZU8eRWQvk/Mm4VHO@casper.infradead.org>
 <4911abfc-081f-4d3f-aa15-73c617a81c36@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4911abfc-081f-4d3f-aa15-73c617a81c36@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 09:04:49AM +0800, zhiguojiang wrote:
> 
> 
> 在 2023/11/11 14:25, Matthew Wilcox 写道:
> > On Thu, Nov 09, 2023 at 09:49:54AM -0800, Andrew Morton wrote:
> > > On Thu,  9 Nov 2023 15:31:33 +0800 Zhiguo Jiang <justinjiang@vivo.com> wrote:
> > > 
> > > > Add a new bool* argument to pass return flag instead of *alloc_flags
> > > > and add the related comments.
> > > Please retain (and update) the changelog with each version of a patch.
> > > 
> > > For reviewers (please), here's the v1 changelog:
> > This patch isn't diffed against the current tree.  It can't be reviewed.
> patch v1:
> https://lore.kernel.org/all/20231108065408.1861-1-justinjiang@vivo.com/
> patch v2:
> https://lore.kernel.org/all/20231109073133.792-2-justinjiang@vivo.com/
> patch v3:
> https://lore.kernel.org/all/20231110020840.1031-1-justinjiang@vivo.com/

None of those are diffed against the current tree.  You need to send a
patch that applies cleanly to either linux-next or current Linus head.
Not a patch on top of an earlier version of your patch.
