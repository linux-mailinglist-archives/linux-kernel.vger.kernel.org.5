Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0BF7CDB47
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjJRMGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjJRMGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:06:47 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95855112;
        Wed, 18 Oct 2023 05:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UpeYTh2P4KQvdjFFPRoqkuwGbEkoq8vBM1ds043uAt4=;
  b=QWzZBm7ACQALV25Qy8k2ZnFZKZ+dUkpsVrrM/4GG237sFSzVXXcdgSlw
   kznBRH7QDSLRlSHKsmuMBxY+1Pr527MfwHtTzP5wW+Tu2RGBC3ohlbnUA
   3Z5EPLD1cH0rRWYUKj3fvWQgAyf/SqBRHzMW/8U3JkoZjqSWMs6pTWsy6
   4=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,235,1694728800"; 
   d="scan'208";a="131893552"
Received: from dhcp-138-246-3-50.dynamic.eduroam.mwn.de (HELO hadrien) ([138.246.3.50])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 14:06:41 +0200
Date:   Wed, 18 Oct 2023 14:06:41 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Dorcas AnonoLitunya <anonolitunya@gmail.com>
cc:     outreachy@lists.linux.dev, dan.carpenter@linaro.org,
        andi.shyti@linux.intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: sm750fb: Remove unused return value in
 program_mode_registers()
In-Reply-To: <492e63bbc58147fb534930ef9e1fb5d844ae8769.1697619623.git.anonolitunya@gmail.com>
Message-ID: <4b7129ae-27f9-7ff4-845-9c327aff488c@inria.fr>
References: <cover.1697619623.git.anonolitunya@gmail.com> <492e63bbc58147fb534930ef9e1fb5d844ae8769.1697619623.git.anonolitunya@gmail.com>
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



On Wed, 18 Oct 2023, Dorcas AnonoLitunya wrote:

> Modifies the return type of program_mode_registers()
> to void from int as the return value is being ignored in
> all subsequent function calls.
>
> This improves code readability and maintainability.
>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_mode.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
> index 83ace6cc9583..e15039238232 100644
> --- a/drivers/staging/sm750fb/ddk750_mode.c
> +++ b/drivers/staging/sm750fb/ddk750_mode.c
> @@ -73,8 +73,8 @@ display_control_adjust_sm750le(struct mode_parameter *mode_param,
>  }
>
>  /* only timing related registers will be  programed */
> -static int program_mode_registers(struct mode_parameter *mode_param,
> -				  struct pll_value *pll)
> +static void program_mode_registers(struct mode_parameter *mode_param,
> +				   struct pll_value *pll)
>  {
>  	int ret = 0;
>  	int cnt = 0;
> @@ -202,7 +202,6 @@ static int program_mode_registers(struct mode_parameter *mode_param,
>  	} else {
>  		ret = -1;

Is it still useful to have ret = -1?  Maybe the ret variable is not useful
at all any more, but one would have to check the parts of the function
that aren't shown.

julia

>  	}
> -	return ret;
>  }
>
>  int ddk750_set_mode_timing(struct mode_parameter *parm, enum clock_type clock)
> --
> 2.42.0.345.gaab89be2eb
>
>
