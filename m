Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562917C8712
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 15:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjJMNmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 09:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjJMNmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 09:42:32 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDED195;
        Fri, 13 Oct 2023 06:42:29 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4S6SNy00H8z9slt;
        Fri, 13 Oct 2023 15:42:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1697204546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5KyVORMmdsFCe+VFgUpWMVXH0T0VUg2Hs67km9vsQeg=;
        b=Cs5IhrvO7lzZAq0aoxObmbj0gtykN3EM5wzUW2+SZhlNW42WA5MTHO0xF6UQXaQ+fPHnNy
        ed5rlE7fy2i5s7rlXph7MNUpcCoaMXDgS3Gi69rSr7zYxOG5y3cqWudmkKJ8mrvi0LPOx6
        NnZuomUA7zLhNJgucNoWIBI1cIUmyhwg3+KXm0MiwXvI/LYeUoSVQKMIzzizQBCiGOuK7N
        Q+ab8AfHxG7exykdCJyf96yI8wnRgaVNDYHcsdfYwKTCoWBoF7P49cmSFMDwtbTOaQBAyR
        cH1rS82jzFHdu41tZq1+DWvQCUwNpFu9nYImO72yEGssfp1rxfKLPL/egLYAqQ==
Date:   Fri, 13 Oct 2023 15:42:20 +0200
From:   Erhard Furtner <erhard_f@mailbox.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-sparc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        David Woodhouse <dwmw2@infradead.org>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 0/2] Allow nesting of lazy MMU mode
Message-ID: <20231013154220.02fb2e6d@yea>
In-Reply-To: <20231012195415.282357-1-willy@infradead.org>
References: <20231012195415.282357-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: fwggrtmigo4x4ffeiuzyox1abn9uz6c1
X-MBO-RS-ID: 69186c5c661cec6bfb2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2023 20:54:13 +0100
"Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> Dave Woodhouse reported that we now nest calls to
> arch_enter_lazy_mmu_mode().  That was inadvertent, but in principle we
> should allow it.  On further investigation, Juergen already fixed it
> for Xen, but didn't tell anyone.  Fix it for Sparc & PowerPC too.
> This may or may not help fix the problem that Erhard reported.
> 
> Matthew Wilcox (Oracle) (2):
>   powerpc: Allow nesting of lazy MMU mode
>   sparc: Allow nesting of lazy MMU mode
> 
>  arch/powerpc/include/asm/book3s/64/tlbflush-hash.h | 5 ++---
>  arch/sparc/mm/tlb.c                                | 5 ++---
>  2 files changed, 4 insertions(+), 6 deletions(-)
> 
> -- 
> 2.40.1

Applied the patch on top of v6.6-rc5 but unfortunately it did not fix my reported issue.

Regards,
Erhard
