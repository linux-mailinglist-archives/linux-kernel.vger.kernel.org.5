Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950AB7A9B36
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjIUSzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjIUSzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:55:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8179AD94F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W1GgHf9odJrZq8sT8tCtEyW/SABocjtVtu+zuJNXlPE=; b=R77fZQH1ARPWXmFPVmZGhhGTO2
        uT5MaxbrolcoVwHGZkazI6LgLDUxycDR1heKYIzdPNEFM3rAxfeN+OKtNi9Fbu+GV1Mv6WkLjjNGz
        Lt09wERCQMWcR6NVXMS0RWtfn+Ezoa4rHqqzGi4LDTR+PlEA3EEK38+EKK9HFccoj/ub5ZDPmC7+l
        UfSYuzQrrVYewybbIGrGGMGQN4BBkPnlwK9emSLJVmT5L+J+NwJB5mxz+CxiPypcGZItt6TOZZGlc
        GHAyhJpsFaMyqY3CLGw/SoUHTQXd892/L7jB4rV0AX5XxMKcnII9CD7U6UrjUBhsi2XUKHv+nf427
        EKeHc8cA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qjObF-00DTm1-EZ; Thu, 21 Sep 2023 18:40:29 +0000
Date:   Thu, 21 Sep 2023 19:40:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pedro.falcato@gmail.com,
        stable <stable@kernel.org>
Subject: Re: [PATCH 2/2] maple_tree: Add MAS_UNDERFLOW and MAS_OVERFLOW states
Message-ID: <ZQyOHcQFhHqO7JAY@casper.infradead.org>
References: <20230921181236.509072-1-Liam.Howlett@oracle.com>
 <20230921181236.509072-3-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921181236.509072-3-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 02:12:36PM -0400, Liam R. Howlett wrote:
> Since MAS_NONE is used for handling of the maple tree when it's a single
> entry at 0 (just a pointer), changing the handling of MAS_NONE in
> mas_find() would make the code more complicated and error prone.

Single entry at index 0 is MAS_ROOT, not MAS_NONE.

