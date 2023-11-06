Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E167E1B7D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 08:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjKFHtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 02:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjKFHtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 02:49:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D6C93;
        Sun,  5 Nov 2023 23:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JsR9ayW5W/B/juTQaypftAOI6FoM2p6JwLFtaaXiYeY=; b=SSznQCH//sjs76e1wLV444srrk
        IjB9fGYRmpH98jSF6D9OGwcgvbQaqTdm5CXHbU/Ves9131e8i7/fW7YMAGIBhViM6Azlh2HiGHZZ8
        ScO1bEes4pdl4jnHCJlzr0zoI1oTJOXkbgRR9u5bi6OQwXwXAYDOsmxsjGvDY7DeUXiBMSx5NEmUn
        2Tr/uf8AN4z3twUhnZZKV8AuvnvPBWc/RkkjUVZ3X9iXzkh5psGgYL2/4+Z66RPlWXbUN2le8YYb0
        hr/mmhXZjnD6O9ZNH5xmrvdY6bL7shMS1Zc+C46kXVZqrjgO/Nyp2WWYqAdCI7rRELn6VYJwcaVS3
        qjfAMdCA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qzuMZ-00G1sz-1b;
        Mon, 06 Nov 2023 07:49:35 +0000
Date:   Sun, 5 Nov 2023 23:49:35 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, edumazet@google.com,
        davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, ndesaulniers@google.com, trix@redhat.com,
        0x7f454c46@gmail.com, fruggeri@arista.com, noureddine@arista.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH net] tcp: Fix -Wc23-extensions in tcp_options_write()
Message-ID: <ZUiaj9qCKD/U2KLp@infradead.org>
References: <20231031-tcp-ao-fix-label-in-compound-statement-warning-v1-1-c9731d115f17@kernel.org>
 <ZUStrQCqBjBBB6dc@infradead.org>
 <20231103165312.GA3670349@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103165312.GA3670349@dev-arch.thelio-3990X>
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

Normally the kernel keeps the ifdef outside the function body and adds
a stub.  But this already looks like a huge imrpovement over the
existing version to me.
