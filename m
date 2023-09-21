Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6264D7AA59D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 01:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjIUX15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 19:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjIUX1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 19:27:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C5F8F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 16:27:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786FDC433C8;
        Thu, 21 Sep 2023 23:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1695338869;
        bh=SJbxiQb0unKA+nMj2mRavTDir6g83Ub6YVE1qG4Rjns=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oNLDJ5/1ert+fipFAqVCBE140YejWbtzCnP3HKI6PchHFLLHn3KPqD86onbbwNuQ2
         zvLy5pP+yrLkXEXKb1D0eq9MXQ8BmPW7/D6azUQsFeNbwK+NP7ySXNUHezM7O5PKzK
         PHI1/5FErfcroy0Vvda8f9adqRLTIj+H3GLapQu4=
Date:   Thu, 21 Sep 2023 16:27:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pedro.falcato@gmail.com,
        stable <stable@kernel.org>
Subject: Re: [PATCH 0/2] maple_tree: Fix mas_prev() state regression.
Message-Id: <20230921162748.a85eb5af766e0662e4f22a5e@linux-foundation.org>
In-Reply-To: <ZQyYH+5pnDc1KYj0@casper.infradead.org>
References: <20230921181236.509072-1-Liam.Howlett@oracle.com>
        <20230921112521.fc07c658804f4e188179da77@linux-foundation.org>
        <20230921185330.j5jw3oms4tc6crkf@revolver>
        <ZQyYH+5pnDc1KYj0@casper.infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2023 20:23:11 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> > > It isn't clear what are the user-visible effects of this flaw?  Please
> > > send this along and I'll paste it in.
> > 
> > 
> > User may notice that mas_prev() or mas_next() calls that result in going
> > outside of the limit passed to the call will cause incorrect returns on
> > subsequent calls using that maple state, such as mas_find() skipping an
> > entry.
> 
> When Andrew says "User visible" he means "userspace visible".  Not
> "in kernel user visible".  What are the _consequences_.

Thanks ;)

We have a Link:
(https://gist.github.com/heatd/85d2971fae1501b55b6ea401fbbe485b) but it
takes us to the reproducer code.  If it took us to Pedro's initial bug
report then the sun would shine and birds would sing.



