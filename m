Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEEB763E43
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjGZSSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjGZSSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:18:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6CAFE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GbQoenHKa+neacdcm3RLojGOhzh6q+FYf9tIxmYvQKE=; b=xuv4rVYdoDDsE0XUTPwwP1W1rW
        vcqZKvgVgqjMGwZpBdy/2ztMDWalyk3Zi2ztrX81ZEjYit430tw6ucLRRG4FQsR5G9leFzuq7YM7O
        Shnpedd/BGjfaSkJ7so1t7/uR+RjOKkJmuoCsJmIbDGcUsbKqRQI8cFdBE2N2ZpKzAu0J42bwb4ff
        aTWuNneLbSX3LxwVRZnIunHehYMFFawwXmXXmkwYdAc/B6miQnxPE9icie/FaOWZRqXD6ilJj6j5A
        QUbfNLwkotLOQafR6P0qPXa0N36KIvoqw4ToJLorXuV7Pe3an6q4qMMqxbb20l3R+gtWD7Jl7D6NW
        Cn98pwsQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qOj5F-00BGJE-1g;
        Wed, 26 Jul 2023 18:18:01 +0000
Date:   Wed, 26 Jul 2023 11:18:01 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Chen Jiahao <chenjiahao16@huawei.com>
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org, fweisbec@gmail.com,
        pmladek@suse.com, rongtao@cestc.cn
Subject: Re: [PATCH -next] samples/hw_breakpoint: mark sample_hbp as static
Message-ID: <ZMFjWSR4+KudR+gE@bombadil.infradead.org>
References: <20230726101759.2537372-1-chenjiahao16@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726101759.2537372-1-chenjiahao16@huawei.com>
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

On Wed, Jul 26, 2023 at 10:17:59AM +0000, Chen Jiahao wrote:
> There is a sparse warning shown as below:
> 
> samples/hw_breakpoint/data_breakpoint.c:24:19: warning:
> symbol 'sample_hbp' was not declared. Should it be static?
> 
> Since 'sample_hbp' is only called within data_breakpoint.c,
> mark it as static to fix the warning.
> 
> Fixes: 44ee63587dce ("percpu: Add __percpu sparse annotations to hw_breakpoint")
> Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>

Thanks, applied and pushed.

  Luis
