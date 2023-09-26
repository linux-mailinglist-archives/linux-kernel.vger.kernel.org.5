Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0459A7AE6E8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 09:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbjIZHeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 03:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjIZHeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 03:34:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90770FC;
        Tue, 26 Sep 2023 00:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C1oF1souaSCsz59IjXXjb/BNhj0xydUEaApGSGUHy90=; b=aY+1KO44igHYvwLagvz+nCyGOn
        WGrzW0/F0SuFYB7E4Thmtw6gAezYczmBcJqEpApJNBQSr7PXo5QZ/jUCIpaE5iF2g8qnNeodljmMA
        4k/2qhDLPF4xTyiKZoanq8MJ2QelFrI4q6cH7HPRcpXO+yzNwoU3wyKiNaPNIDKSfBlhYIIVzOAsi
        hXADgpM5gOpx+jPGo9ocWELvlctVJevKI3+6blg9xCKU4IYbMCktuH1m5EqTTeSNDj5c1JyEXpaAO
        JjT1t6DjWk4TXvZZmDlPn9LQ47443wbwoWd2D5vZlPYaOUDC4VMx5/uWtJwrO9mQmHEeAJTUyQ1/o
        MiuaZTlA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ql2a3-00Fnl9-2H;
        Tue, 26 Sep 2023 07:34:03 +0000
Date:   Tue, 26 Sep 2023 00:34:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     Dave Miller <davem@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, jschlst@samba.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-spdx@vger.kernel.org
Subject: Re: SPDX: Appletalk FW license in the kernel
Message-ID: <ZRKJa+cMsFxiizKb@infradead.org>
References: <6100798b-ab1d-262a-fd5b-435d6dfc4a53@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6100798b-ab1d-262a-fd5b-435d6dfc4a53@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 09:39:05AM -0400, Prarit Bhargava wrote:
> To be clear, I am not asking for their removal, however, I do think a better
> license should be issued for these files.  The files were trivially modified
> in 2006. It could be that the code in question is now unused and it is just
> easier to remove them.
> 
> Is there anyone you know of that we could approach to determine a proper
> SPDX License for these files?

The code contains firmware that is downloaded to the device.  The proper
thing would be to convert them to separate binary files in the
linux-firmware packages.  But given that the driver has seen nothing
but tree wide cleanups since the dawn of git I suspect there is no
maintainer and probably no user left.  The best might be to indeed just
remove it and see if anyone screams, in which case we could bring it
back after doing the above.

