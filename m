Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003277ABEF7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 10:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjIWIz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 04:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjIWIzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 04:55:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265A0136;
        Sat, 23 Sep 2023 01:55:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE79BC433C7;
        Sat, 23 Sep 2023 08:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695459319;
        bh=lseakF6M2dlhTAVWNVK3bOAsavTxJDpelRRD6WFVyqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OuhpNCZ9pA/PjelUbm7C5AC7eEHLWgQTWDcs6fnqF8fSTroxBm2WuVxfByP7lIgEI
         W31HIc3p60iYfcgSz6Noo3GWdnDE7R6SpRKw0zb/Rj7Ds4Rrny6OEnTeOIi6W0i8Xf
         w7pO4haVIbSFNVEq93YgfQJ2mVC/wAAyS0tw4QSeiAp3fGogE8Yrw+b8EGoVqqCGKu
         BRzwRmQR7qchrGZC4jIMQOZmxDKvMKJu2+0i4QgQSZeNPOlBTYFhLGmp1DcLr1xp2c
         SPG6XyJtctIOxt5YmDQgsr6/1uYCXQs+Sj19/m2XKeaYa7Wi/h0DfmPzlCPBnlLwHJ
         tk7pZhocEtXXA==
Date:   Sat, 23 Sep 2023 10:56:21 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jorge Lopez <jorge.lopez2@hp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] platform/x86: hp-bioscfg: Annotate struct bios_args with
 __counted_by
Message-ID: <ZQ8YtbxQnkDN1nc0@work>
References: <20230922175420.work.701-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922175420.work.701-kees@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 10:54:21AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct bios_args.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Jorge Lopez <jorge.lopez2@hp.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <markgross@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Tom Rix <trix@redhat.com>
> Cc: platform-driver-x86@vger.kernel.org
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c b/drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
> index dea54f35b8b5..4da99cb7218d 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
> @@ -19,7 +19,7 @@ struct bios_args {
>  	u32 command;
>  	u32 commandtype;
>  	u32 datasize;
> -	u8 data[];
> +	u8 data[] __counted_by(datasize);
>  };
>  
>  /**
> -- 
> 2.34.1
> 
> 
