Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104297F5F7B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 13:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345351AbjKWMw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 07:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345371AbjKWMwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 07:52:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D939D42
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 04:53:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFF1C433C7;
        Thu, 23 Nov 2023 12:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700743980;
        bh=F7P1UrcrA7XXYERAlMWEnIMlgPNCzYeKlSXTkoC+Q5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PB81C+oEP4NslxZtrQVlx0Jb94L25vntk60abpyG1TQRbvYo8ZMR1FLYs4DbWZCf9
         q310bWMtehDxFYYsr7zeqQFMowHy6oGAKPVKJUpo80QSdUMCdZ10SxNPBZRnESpEoI
         MbZvrayzvPCT8oZ67f5qnT7iyZ9omLH48kbEvnrE=
Date:   Thu, 23 Nov 2023 12:48:35 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc:     outreachy@lists.linux.dev, julia.lawall@inria.fr,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: sm750fb: Remove unused return value in
 display_control_adjust_sm750le()
Message-ID: <2023112329-daybed-elevate-88aa@gregkh>
References: <20231101152137.10664-2-anonolitunya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101152137.10664-2-anonolitunya@gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 06:21:34PM +0300, Dorcas AnonoLitunya wrote:
> Modifies the return type of display_control_adjust_sm750le()
> to void from unsigned long as the return value is being ignored in
> all subsequent function calls.
> 
> This improves code readability and maintainability.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
> ---
> 
> Changes in v3:
> - Rebase patch to apply against latest branch
> 
>  drivers/staging/sm750fb/ddk750_mode.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
> index e1f20379431c..4278f9a826ab 100644
> --- a/drivers/staging/sm750fb/ddk750_mode.c
> +++ b/drivers/staging/sm750fb/ddk750_mode.c
> @@ -13,7 +13,7 @@
>   * HW only supports 7 predefined pixel clocks, and clock select is
>   * in bit 29:27 of Display Control register.
>   */
> -static unsigned long
> +static void
>  display_control_adjust_sm750le(struct mode_parameter *mode_param,
>  			       unsigned long disp_control)
>  {
> @@ -70,8 +70,6 @@ display_control_adjust_sm750le(struct mode_parameter *mode_param,
>  	disp_control |= DISPLAY_CTRL_CLOCK_PHASE;
>  
>  	poke32(CRT_DISPLAY_CTRL, disp_control);
> -
> -	return disp_control;
>  }
>  
>  /* only timing related registers will be  programed */
> -- 
> 2.42.0.345.gaab89be2eb
> 
> 

Does not apply to my current tree :(
