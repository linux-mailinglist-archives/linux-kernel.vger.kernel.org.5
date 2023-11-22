Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8607F4140
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343581AbjKVJJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbjKVJJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:09:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B524499;
        Wed, 22 Nov 2023 01:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cOCKv2++KLIuAg21SGAwrhK9OHo5VZAQ2mEiIx+oLgk=; b=LH7biDT6ND14MwCmwr5baPJRzn
        4kmXq8bl6D4nhe/JvmNHE3z7FFNLqGTCY3lYcafHbNJEjAH3tJCYjasIiT5ITF6+bBvJwNhBc64Jk
        zdC1swd1n/b9vAUIxjumc9gpCi+zp7CMUsDtnFDcJNFmubEzite+95TSOvjQrclG8zzPrt8iOuqVp
        lTTxikkI1jkwsjD3pf+Evv84DxLrzuOnT0YrjmrrqkgBfn++6vo1vA5cCvjE6kFQE/PI0Rr4iiZZB
        v1L58Jxu6cmmIbtPiOb5W3whnnjWZyyqOSBu7eX4o1xDAcy6y91y0nKow3qyF2mHkiDR+Z9nfn5m+
        SmMrAI7w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r5jBp-0019f1-28;
        Wed, 22 Nov 2023 09:06:33 +0000
Date:   Wed, 22 Nov 2023 01:06:33 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Kunwu Chan <chentao@kylinos.cn>
Cc:     Christoph Hellwig <hch@infradead.org>, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jkbs@redhat.com, kunwu.chan@hotmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ipv6: Correct/silence an endian warning in
 ip6_multipath_l3_keys
Message-ID: <ZV3EmcsEqfFuvW4P@infradead.org>
References: <20231122071924.8302-1-chentao@kylinos.cn>
 <ZV2sWSRzZhy4klrq@infradead.org>
 <37452b03-9c24-42a7-bb4f-ed19f622f0ef@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37452b03-9c24-42a7-bb4f-ed19f622f0ef@kylinos.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 05:04:49PM +0800, Kunwu Chan wrote:
> Hi Christoph,
> Thanks for your reply.
> I also can't guarantee that it's the right thing to do. Just wanted to
> dispel this warning. If you have any better way, please let me know.

The most likely reason is that it needs an endianess conversion.  I
don't know the answer either, but actually spending a few minutes
trying to understand the code should allow you to find it out quickly.

Removing a warning for it's own sake when you don't understand it is
never a good idea.

