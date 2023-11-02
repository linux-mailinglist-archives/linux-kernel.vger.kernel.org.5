Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB357DFC17
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 22:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377432AbjKBVsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 17:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKBVsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 17:48:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D0518B;
        Thu,  2 Nov 2023 14:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GXxaVa4Xmy3l9nFyocU4N0dWrObmXp3nfxcdQhfLD0g=; b=a2EJuUVJcjNaS5YO68yNNMNcFB
        EHmoie2GCtfIRg2zirhwS+4fU7NY+d1irjZ7wjtCt0KxSfDcVITp5WF2C5kPXtlT4K6in6JbML2aE
        RIFQ/beeYUwhxugapkg68vVgUX4SYfA+F1U7M7SOostFkvJcjH66NffC4DVCjR0unqgOXk/3Y4tNZ
        paMoQ1WGBAe8tN4hSjE4LzKqUTe/Ya3t1baq6ZzY2Bg7T0pdj7sGFarIS7bN43aVeuH+ku8SvAzkp
        Jy6hBi/Q5qwd2KjInkgLELQXUwqIlVvfCkVkP+7OhVcOfujFJLPNvcAshQEZbnuxN6/FBEjf6L5mP
        Mrc8Q1Ww==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qyfXs-00AKwB-0o;
        Thu, 02 Nov 2023 21:48:08 +0000
Date:   Thu, 2 Nov 2023 14:48:08 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the modules tree
Message-ID: <ZUQZGLDYL1/eoyzj@bombadil.infradead.org>
References: <20231103080642.468b331a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103080642.468b331a@canb.auug.org.au>
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

On Fri, Nov 03, 2023 at 08:06:42AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in Linus Torvalds' tree as different
> commits (but the same patches):
> 
>   3111add7f414 ("module: Annotate struct module_notes_attrs with __counted_by")
>   331e833a7606 ("module: Fix comment typo")
>   dc95e422c283 ("module: Make is_valid_name() return bool")
>   bac202d3712f ("module: Make is_mapping_symbol() return bool")
>   b72d5a66766d ("module/decompress: use vmalloc() for gzip decompression workspace")
>   c7540b27da9e ("MAINTAINERS: add include/linux/module*.h to modules")
>   130afb8ce111 ("module: Clarify documentation of module_param_call()")
> 
> These are commits
> 
>   ea0b0bcef491 ("module: Annotate struct module_notes_attrs with __counted_by")
>   fd06da776130 ("module: Fix comment typo")
>   04311b9b3063 ("module: Make is_valid_name() return bool")
>   60da3640b07c ("module: Make is_mapping_symbol() return bool")
>   3737df782c74 ("module/decompress: use vmalloc() for gzip decompression workspace")
>   62eedac26415 ("MAINTAINERS: add include/linux/module*.h to modules")
>   2c7ccb3c362b ("module: Clarify documentation of module_param_call()")
> 
> in Linus' tree.

Fixed.

  Luis
