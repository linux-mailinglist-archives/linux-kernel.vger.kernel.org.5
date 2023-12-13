Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4C1811760
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442197AbjLMPii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442041AbjLMPig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:38:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3782BF4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:38:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8BAC433CA;
        Wed, 13 Dec 2023 15:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702481922;
        bh=0Rhgoliy2s+rYmj4ksO8ITkA/9uEsKk7Ibt8CtnnnkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VfzY7vP897C4GeCqXd/zG4c+zaM6BIQLxx2wsL7KEiu1PihSuKKTgVpvvLddlHPdi
         AZNYpuiCWrOhH9jYWYMyuKZPVjT3vB7hgmqX7ZFfLZ10Ey4+UTa2u5blqEwoDaEkr+
         AoxaPMM3Qv+dQYxoiXx78eM76StKLCVgcVdiLbr0Z5uCxUgk48wb1Ia5j3dEQsZdpz
         ipLdWu7hSN5kNIuyVz5oS3bRmDLCIOBhzOSnRCf5sXosAtpV1V75bQqmFeS+38dyNe
         JTuzAfuaeu3HbadTbGBYeo/56tRUvKsFkIUsX0oj9myeBrG5innNr5tRY2uc/0S20b
         aqRVT1YOPJfhw==
Date:   Wed, 13 Dec 2023 15:38:38 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] leds: rgb: Drop obsolete dependency on COMPILE_TEST
Message-ID: <20231213153838.GM111411@google.com>
References: <20231202214353.7c02f23c@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231202214353.7c02f23c@endymion.delvare>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Dec 2023, Jean Delvare wrote:

> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> is possible to test-build any driver which depends on OF on any
> architecture by explicitly selecting OF. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Lee Jones <lee@kernel.org>
> ---
>  drivers/leds/rgb/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

It's not clear to me what this patch improves.

Going to choose to keep the status quo on this one.

> --- linux-6.6.orig/drivers/leds/rgb/Kconfig
> +++ linux-6.6/drivers/leds/rgb/Kconfig
> @@ -4,7 +4,7 @@ if LEDS_CLASS_MULTICOLOR
>  
>  config LEDS_GROUP_MULTICOLOR
>  	tristate "LEDs group multi-color support"
> -	depends on OF || COMPILE_TEST
> +	depends on OF
>  	help
>  	  This option enables support for monochrome LEDs that are grouped
>  	  into multicolor LEDs which is useful in the case where LEDs of
> 
> 
> -- 
> Jean Delvare
> SUSE L3 Support

-- 
Lee Jones [李琼斯]
