Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BC5762770
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 01:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjGYXfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 19:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjGYXft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 19:35:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72926212D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 16:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i9stS88GRQ0XDqPN1RVCHpzzs7K8vA+FiBHULCzsBkk=; b=bNv7VRyRJsYNSKD6vFBBIoh7hj
        HPEqg8htiMNqwpX4rrsralVF5b7GXhkBv9dxYPOPxVMUhoZbuurzPT558oUL/pfJkjaYNoLlXAj/o
        u0IWEr6r0wUpU/a0ic5Uf2TFMbbpz3ZH5iukFaqpTfsjtJQHSipZ7We/uRqQVD+R9S+IAlLqvI+qJ
        kWXWxsC00k3f8HAnDaGFEOtotvXrtzoPvILcq9BmVmRzVH63Hcub+2Q74rOwLgoitn2WMjX6ImMdq
        /brkDo6+fwWTKctSRqRDtA5amsfQvingLoWpSPW9akMXgD+PoEp4Pd4qUthkO9zk2pU3LrhlxH24e
        keegQM9Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qORZ3-008j7s-1Q;
        Tue, 25 Jul 2023 23:35:37 +0000
Date:   Tue, 25 Jul 2023 16:35:37 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Rong Tao <rongtao@cestc.cn>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] samples/hw_breakpoint: fix building without module
 unloading
Message-ID: <ZMBcSeEcvsXVd6Ij@bombadil.infradead.org>
References: <20230725082546.941346-1-arnd@kernel.org>
 <ZL-YKHxMfTIg16Hl@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL-YKHxMfTIg16Hl@alley>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 11:38:48AM +0200, Petr Mladek wrote:
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Thanks, patch applied and pushed!

> But even better solution would be to define symbol_put_name() as
> a noop in both situations and use it.

Patch welcomed!

  Luis
