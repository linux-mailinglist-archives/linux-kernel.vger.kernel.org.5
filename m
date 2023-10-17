Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACDC7CBCCA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbjJQHvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbjJQHvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:51:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A68AF7;
        Tue, 17 Oct 2023 00:51:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E805C433CC;
        Tue, 17 Oct 2023 07:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697529065;
        bh=LMbMxaMKaTNIfzrp/tf2/dOlav9L6MhzVw0qA4YUp3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QSC4iWLI1HUQUvIlRNCKzeTRqWoYbZ4K/jP21yNvC5634H7SUB6EwXxMJPw1Jn0Xp
         RCxLJYclgU+rDQTIH7iBNsMBsEfs03590ZyAsiYqAYuOLxiPpiEyqaAAj7tQ5JPRyW
         0/VNdUF7kBEUxB8yeRzrt+oMTel1p9wEdvvAV85Y=
Date:   Tue, 17 Oct 2023 09:50:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc:     outreachy@lists.linux.dev, julia.lawall@inria.fr,
        dan.carpenter@linaro.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] Staging: sm750fb: Rename
 displayControlAdjust_SM750E
Message-ID: <2023101724-diagram-legwork-0e53@gregkh>
References: <20231016201434.7880-1-anonolitunya@gmail.com>
 <20231016201434.7880-2-anonolitunya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016201434.7880-2-anonolitunya@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 11:14:08PM +0300, Dorcas AnonoLitunya wrote:
> Rename function displayControlAdjust_SM750E to
> display_control_adjust_SM750E. This follows snakecase naming convention
> and ensures a consistent naming style throughout the file. Issue found by
> checkpatch.
> 
> Mutes the following error:
> CHECK:Avoid CamelCase: <displayControlAdjust_SM750E>
> 
> Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_mode.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
> index e00a6cb31947..8708995f676c 100644
> --- a/drivers/staging/sm750fb/ddk750_mode.c
> +++ b/drivers/staging/sm750fb/ddk750_mode.c
> @@ -14,8 +14,8 @@
>   * in bit 29:27 of Display Control register.
>   */
>  static unsigned long
> -displayControlAdjust_SM750LE(struct mode_parameter *pModeParam,
> -			     unsigned long dispControl)
> +display_control_adjust_SM750LE(struct mode_parameter *pModeParam,
> +			       unsigned long dispControl)
>  {
>  	unsigned long x, y;
>  
> @@ -125,7 +125,7 @@ static int programModeRegisters(struct mode_parameter *pModeParam,
>  			tmp |= DISPLAY_CTRL_HSYNC_PHASE;
>  
>  		if (sm750_get_chip_type() == SM750LE) {
> -			displayControlAdjust_SM750LE(pModeParam, tmp);
> +			display_control_adjust_SM750LE(pModeParam, tmp);

Why is this function returning a value if it is just being ignored?

It's not the issue here in the patch, but for future changes.

thanks,

greg k-h
