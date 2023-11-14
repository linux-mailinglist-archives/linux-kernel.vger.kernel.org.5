Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D857EB72C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 21:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjKNUFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 15:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjKNUFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 15:05:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C47A7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 12:05:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312B6C433C8;
        Tue, 14 Nov 2023 20:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699992310;
        bh=oDLylzWb9XOoeGUg7Wqz1W9FNvhlRbijO4lCH9ddguU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o6TuzT8X6+03MokWu0xHLXoYfuNFNOUHWCCbEP5apxtlsI4P7WOXmDToB2DZVwY5E
         42VbgFxJGkTfeEOxBD4F0bN+dh92e8Q/Pj80FFVsl2Ni+MXU508TjNxsIqmQoo6uk4
         AC+o1d8VIPN/K0oXlVo+JBPKSMNqEQDOWsWwVnj7wLwV1FoJrkqyVyVD+Mt1x0ayd7
         QdPA/IPxbV+3Z2xIsla3v3RutMH9sS3i/bmJzXzQN7gGfnR4jk/XXPcGEKkX2uhW9A
         KqKc3La7Y9mBJfDn4r55tn2HyRHbKpqwd3Q98XzxfKPngoJrjZ19ajZ2ZXzsBnbaYa
         ssIccWziYhMDQ==
Date:   Tue, 14 Nov 2023 13:05:08 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Helge Deller <deller@gmx.de>, linux-kbuild@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linux/export: clean up the IA-64 KSYM_FUNC macro
Message-ID: <20231114200508.GA3378955@dev-arch.thelio-3990X>
References: <20231110120722.15907-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110120722.15907-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 01:07:22PM +0100, Lukas Bulwahn wrote:
> With commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture"),
> there is no need to keep the IA-64 definition of the KSYM_FUNC macro.
> 
> Clean up the IA-64 definition of the KSYM_FUNC macro.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

I see you sent a patch for the other instance of CONFIG_IA64 that I see
in tree still. LGTM.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  include/linux/export-internal.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/include/linux/export-internal.h b/include/linux/export-internal.h
> index 45fca09b2319..69501e0ec239 100644
> --- a/include/linux/export-internal.h
> +++ b/include/linux/export-internal.h
> @@ -50,9 +50,7 @@
>  	    "	.previous"						"\n"	\
>  	)
>  
> -#ifdef CONFIG_IA64
> -#define KSYM_FUNC(name)		@fptr(name)
> -#elif defined(CONFIG_PARISC) && defined(CONFIG_64BIT)
> +#if defined(CONFIG_PARISC) && defined(CONFIG_64BIT)
>  #define KSYM_FUNC(name)		P%name
>  #else
>  #define KSYM_FUNC(name)		name
> -- 
> 2.17.1
> 
