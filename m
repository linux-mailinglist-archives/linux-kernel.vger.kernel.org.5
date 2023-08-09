Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2E777679B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjHISrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbjHISqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:46:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F7710D4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 11:46:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 442DD61572
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 18:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBA3C433C7;
        Wed,  9 Aug 2023 18:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1691606812;
        bh=8VUPwjOWYEE8WoNNGr3QrghG1LCxP6UkLxr+pnJhuFk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yIVM+8nIl0vsi4/PqcnzqN9bbpk+DS4PYrcZ2KQWHBIoeA/jjEElKS0+05FczTqvK
         wJ6Ncr19U0fuIvmzJbb9PXFjJ4xt42LoB22DvEQVnu5XVqcvwcJrrdxmXqSVbAKo8X
         45m91JO+yHAPRRkeXvyJZbgZsRMn81bn1H4Q0Mik=
Date:   Wed, 9 Aug 2023 11:46:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Dylan Jhong <dylan@andestech.com>
Subject: Re: [PATCH -fixes] mm: Add a call to flush_cache_vmap() in
 vmap_pfn()
Message-Id: <20230809114651.eb690e5bd4c60b075eb3111b@linux-foundation.org>
In-Reply-To: <20230809164633.1556126-1-alexghiti@rivosinc.com>
References: <20230809164633.1556126-1-alexghiti@rivosinc.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Aug 2023 18:46:33 +0200 Alexandre Ghiti <alexghiti@rivosinc.com> wrote:

> flush_cache_vmap() must be called after new vmalloc mappings are
> installed in the page table in order to allow architectures to make sure
> the new mapping is visible.

Thanks.  What are the user-visible effects of this bug?
