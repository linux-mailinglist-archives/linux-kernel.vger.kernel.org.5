Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137CD7919FA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbjIDOrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjIDOrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:47:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318531B9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 07:47:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D467CB80DB8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 14:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B920C433C8;
        Mon,  4 Sep 2023 14:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693838836;
        bh=00vX/S/bZEFxcOzXRYU8XSPRx2QXSBBtaI9lexJnG8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rzISwFr28zXS9GvtLthacWON48kxuF1gVv0qUb8O9mRw+CPTXyQm+U7jSnVvgQSO/
         g6XtOJFAx7LUOgzA6cHHyGtu6Azy9nGtmynBO3lq7bkThEHBsSDxgyw6BIKE1B8Ho5
         mNIYF+tf7p9Uu2F6//TKq//qvhjL80NS79etcOBAQUXW8e4FIJXdK1Noy8RECblL0J
         Oj0fMPf5y7lU8iAsAuBBjYC5MmhKytLgCySG7qXaaugOQCVeRbipSsKBADv2zolRsB
         gKAct38ncmcG+/QZdyqBLSeGHoy0qH0d3GZ1H0qbHlRZ9fHj6qo8Pj0cgJT229bnIc
         ZAgFEcxDJ5Vjw==
Date:   Mon, 4 Sep 2023 22:35:23 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Xiao Wang <xiao.w.wang@intel.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: alternative: remove alternative boundary symbols
 in vdso
Message-ID: <ZPXrKz1jhqz5g3nF@xhacker>
References: <20230902022510.818602-1-xiao.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230902022510.818602-1-xiao.w.wang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 02, 2023 at 10:25:10AM +0800, Xiao Wang wrote:
> Instruction patching for vdso is based on elf header parsing to get the
> beginning and ending of .alternative section, the __alt_start and __alt_end
> symbols defined in vdso linker script are not used, so this patch removes
> them.

The same patch has been in mailist since July:

https://lore.kernel.org/linux-riscv/20230726173024.3684-2-jszhang@kernel.org/

Thanks
> 
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> ---
>  arch/riscv/kernel/vdso/vdso.lds.S | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/riscv/kernel/vdso/vdso.lds.S b/arch/riscv/kernel/vdso/vdso.lds.S
> index 82ce64900f3d..d43fd7c7dd11 100644
> --- a/arch/riscv/kernel/vdso/vdso.lds.S
> +++ b/arch/riscv/kernel/vdso/vdso.lds.S
> @@ -42,9 +42,7 @@ SECTIONS
>  
>  	. = ALIGN(4);
>  	.alternative : {
> -		__alt_start = .;
>  		*(.alternative)
> -		__alt_end = .;
>  	}
>  
>  	.data		: {
> -- 
> 2.25.1
> 
