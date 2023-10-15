Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F857C9B60
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 22:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjJOUWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 16:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJOUWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 16:22:36 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B9AB7
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 13:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DpWLnotZ9u/SboBse1Dohqi24vkChNNsZ0sAeXBCXrs=;
  b=ts5MnbitFb69UtJVtV3DMWCQoo7zKJ0ajMU7yDRDClv90SEQufag6EqD
   Ij7XYVJRBRoitJb3/ebVsD16+tpKbtljQ6JdcHgfWoFOwbNOCvMHOeeaW
   RxaICn3oHBkd2QNqIYHur4QydyNuakrwNnMtPB14gFAj2yncC5H1h7fFc
   E=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,226,1694728800"; 
   d="scan'208";a="131324498"
Received: from unknown (HELO hadrien) ([87.129.180.234])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 22:22:30 +0200
Date:   Sun, 15 Oct 2023 22:22:29 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Dorcas AnonoLitunya <anonolitunya@gmail.com>
cc:     outreachy@lists.linux.dev,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] Staging: sm750fb: Rename
 displayControlAdjust_SM750E
In-Reply-To: <16a9ad33ef67993482da0d350d7239aee3f0dd22.1697400022.git.anonolitunya@gmail.com>
Message-ID: <d4fb378f-7446-cf16-2d14-3623e313d6ac@inria.fr>
References: <cover.1697400022.git.anonolitunya@gmail.com> <16a9ad33ef67993482da0d350d7239aee3f0dd22.1697400022.git.anonolitunya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 15 Oct 2023, Dorcas AnonoLitunya wrote:

> Rename function displayControlAdjust_SM750E to
> display_control_adjust_SM750E.This follows snakecase naming convention
> and ensures consistent naming style throughout the file.Issue by
> checkpatch.

The period at the end of a sentence should have a space after it.

ensures -> ensures a

Issue -> Issue found

julia

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
>  		} else {
>  			reg = peek32(CRT_DISPLAY_CTRL) &
>  				~(DISPLAY_CTRL_VSYNC_PHASE |
> --
> 2.42.0.345.gaab89be2eb
>
>
>
