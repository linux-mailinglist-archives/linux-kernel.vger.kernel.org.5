Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9557CBCCE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343516AbjJQHv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbjJQHvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:51:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432C3F9;
        Tue, 17 Oct 2023 00:51:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04648C433C8;
        Tue, 17 Oct 2023 07:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697529078;
        bh=LQXEF5e62dr/R/72d1cA39kSwjDHnzyBdz56YeqjIIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P2uO+BeTR1vz4vtCd906zybVFo4Cpdvk0eRP9uAUlRgTYfwv3RnsNQS3DJEQggmyo
         u0W4eIOMDesc1NpZERkXHP3H81fbKN9sNlWuhnnnYtiw8qQ+OPbh3EXbTDIBISH/Vj
         dRCeA0i4iKMRZxQYe/AzW47LmdPQEY0KTl1aN+RU=
Date:   Tue, 17 Oct 2023 09:51:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc:     outreachy@lists.linux.dev, julia.lawall@inria.fr,
        dan.carpenter@linaro.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] Staging: sm750fb: Rename programModeRegisters
Message-ID: <2023101705-baffling-able-d86a@gregkh>
References: <20231016201434.7880-1-anonolitunya@gmail.com>
 <20231016201434.7880-5-anonolitunya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016201434.7880-5-anonolitunya@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 11:14:11PM +0300, Dorcas AnonoLitunya wrote:
> Rename function programModeRegisters to program_mode_registers. This
> follows snakecase naming convention and ensures a consistent naming style
> throughout the file. Issue found by checkpatch.
> 
> Mutes the following checkpatch error:
> CHECK: Avoid CamelCase: <programModeRegisters>
> 
> Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_mode.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
> index fc3db09de9ae..e901855fa9b6 100644
> --- a/drivers/staging/sm750fb/ddk750_mode.c
> +++ b/drivers/staging/sm750fb/ddk750_mode.c
> @@ -75,8 +75,8 @@ display_control_adjust_SM750LE(struct mode_parameter *mode_param,
>  }
>  
>  /* only timing related registers will be  programed */
> -static int programModeRegisters(struct mode_parameter *mode_param,
> -				struct pll_value *pll)
> +static int program_mode_registers(struct mode_parameter *mode_param,
> +				  struct pll_value *pll)
>  {
>  	int ret = 0;
>  	int cnt = 0;
> @@ -220,6 +220,6 @@ int ddk750_setModeTiming(struct mode_parameter *parm, enum clock_type clock)
>  		outb_p(0x88, 0x3d4);
>  		outb_p(0x06, 0x3d5);
>  	}
> -	programModeRegisters(parm, &pll);
> +	program_mode_registers(parm, &pll);

Again, the return value is ignored?

