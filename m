Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6656A7AFE31
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjI0IWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjI0IWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:22:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4D99D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:22:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A745C433C7;
        Wed, 27 Sep 2023 08:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695802938;
        bh=1xiq7GcjaZa+/hz+RxJyVLLKmQ2nwX/FO2OAT5Ar6fI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fy64c/AVcVul3okypWZtVLEFycqRfFoZHwZ3AlEn+WqV6L1oGufLbK0HJp6ZTpVo6
         9OzgVwAQ8eA69eRrqXC27JKGToiD1ICHb6FQv+iquTxo4XRPXP6iK+tmWyUZp18Y8P
         c4ix24M/5gGc4CORyCYAo9bU5MOulb6TKRw1jDDc=
Date:   Wed, 27 Sep 2023 10:22:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     chenguohua@jari.cn
Cc:     linux@armlinux.org.uk, prathubaronia2011@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vidio: Clean up errors in serial.h
Message-ID: <2023092730-shampoo-anytime-f437@gregkh>
References: <706285a.86e.18ad556b0e1.Coremail.chenguohua@jari.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <706285a.86e.18ad556b0e1.Coremail.chenguohua@jari.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 02:32:23PM +0800, chenguohua@jari.cn wrote:
> Fix the following errors reported by checkpatch:
> 
> ERROR: space required after that ',' (ctx:VxV)
> 
> Signed-off-by: GuoHua Cheng <chenguohua@jari.cn>

Your subject line is very odd.

> ---
>  include/linux/amba/clcd.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/amba/clcd.h b/include/linux/amba/clcd.h
> index b6e0cbeaf533..64df8235d9cc 100644
> --- a/include/linux/amba/clcd.h
> +++ b/include/linux/amba/clcd.h
> @@ -244,7 +244,7 @@ static inline int clcdfb_check(struct clcd_fb *fb, struct fb_var_screeninfo *var
>  	var->xres_virtual = var->xres = (var->xres + 15) & ~15;
>  	var->yres_virtual = var->yres = (var->yres + 1) & ~1;
>  
> -#define CHECK(e,l,h) (var->e < l || var->e > h)
> +#define CHECK(e, l, h) (var->e < l || var->e > h)

There is nothing wrong with the original code here, please do not run
checkpatch on code that is NOT in drivers/staging/ unless you get the
approval of the maintainer to do so.

thanks,

greg k-h
