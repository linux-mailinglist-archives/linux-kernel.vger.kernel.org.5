Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4934D7790B3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbjHKNYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjHKNYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:24:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1528125
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kTrAesynkOq2vMzYXBezvugm+/mxLujlFwSFb/okd6o=; b=PswOdkv2cAUlc1tWppH6N/0FNZ
        TMm5SoQfX0lhpECgFZO2CZ1kB8lYvAUwFitlZVZG9mAUUN5ACttVuWHwYLINC8UVu36VbIRBFKWPl
        N6ZXY0eEo7GiRgEz5UZ5rHXQcQYzphat+8HNhXYJVkHej3cU3xj24419eDw1dE41XzUv7XTdOBlhg
        bjvuQl9gq4NX+4fz91DYUzYPB6OCh0dCBToYF4ftx8oGIWAiKYmEV/M6EzrJyJnxMkSn4twSq1ZXg
        qwpu5o5M7NarR1oq/vWYCmnh28Br1vZCPsgSJn3RJuBeDfI4d3AiOTc7naCWYGrpEXy4AQ1QmBX81
        VgnQF/sg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qUS7J-001OnE-N6; Fri, 11 Aug 2023 13:23:49 +0000
Date:   Fri, 11 Aug 2023 14:23:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        Rong Tao <rongtao@cestc.cn>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] radix tree: remove unused variable
Message-ID: <ZNY2ZRnypLeRsT83@casper.infradead.org>
References: <20230811131023.2226509-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811131023.2226509-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 03:10:13PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Recent versions of clang warn about an unused variable, though older
> versions saw the 'slot++' as a use and did not warn:
> 
> radix-tree.c:1136:50: error: parameter 'slot' set but not used [-Werror,-Wunused-but-set-parameter]
> 
> It's clearly not needed any more, so just remove it.
> 
> Fixes: 3a08cd52c37c7 ("radix tree: Remove multiorder support")

Thanks!
