Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75605796FB6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 06:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241715AbjIGEus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 00:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236799AbjIGEuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 00:50:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B11219B5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 21:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=agMaBjuOFtJtue/FbP/i4deiq5fFLhiBf3GHw58yzas=; b=D/6XY7fg3+OTdCcL78r6ouJI2a
        j0nJKQ+qd28Vgv+PMWDEBtTCK+tZY0hOR5uHlnBAHjjglP2qVDHLYoXj/Vt3q/SknQGaPkf6TVszX
        KrQztPoXiKWNJBij9WZHFNM3mHtf/fbFk9sGADOqlc3C5S3KTTTGfMaQofHQYX2M9xjgEQ5tzTdcW
        jmf+VRuuWmb7o7yp9F9DE/hPpUqG3equByVOkb61Fflcn4EFtklrT2VaR9fLddfpsLVU7o5RSIGvV
        /eq0T3G2n1E8QCqSgYDJvMs1rOqurAD5A6RlSVXxvXLmgbzuhcz2sxZCKMhvwWQBDqS+FpceWFbKY
        6zSVKG7w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qe6yP-008I3S-1s; Thu, 07 Sep 2023 04:50:33 +0000
Date:   Thu, 7 Sep 2023 05:50:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zhiguo Jiang <justinjiang@vivo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH] mm: vmscan: fix get_swappiness() return value type
Message-ID: <ZPlWmbu+pLIPgyYC@casper.infradead.org>
References: <20230907044045.709-1-justinjiang@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907044045.709-1-justinjiang@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 12:40:45PM +0800, Zhiguo Jiang wrote:
> Fix bool to int of the get_swappiness() return value type in
> lruvec_is_sizable().
> 
> The get_swappiness() return value type is int, but the
> get_swappiness() return value type is bool in lruvec_is_sizable().
> So there is a possibility of value overflow.

Have you looked at how the C spec defines int->bool conversion?
