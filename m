Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733C578A898
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjH1JMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjH1JMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:12:39 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAC6110;
        Mon, 28 Aug 2023 02:12:18 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 06AC432002D8;
        Mon, 28 Aug 2023 05:12:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 28 Aug 2023 05:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1693213933; x=1693300333; bh=Dv
        eWy5bJAk2TdvNVYiVcOl4OPq7/VIXwIVFQN7u8suY=; b=BMF/KEsGbXfnm55dDz
        AVu/sBAkn87Hhf7myXBCek8rdlOhw7E8fe1vE4f2SUPqQ951D83W2ZFlI7CtDGPz
        6aw9nBOfQZ5k/AZhkd4db5m2XOOGboWGlfTg+1lxCzYm7ZOHp5CFKShCviLBJysV
        3gd28IGek2Bys6G5KrpA3g9557tnSMCUo6ctMTzr5pAQc0ZLGXpSwmQND3zuilt3
        NmMc0Zol3SrQeDGDTCuiUL/lPZ1XJM8dfpuCCF8sDNnNWRlQVyRJc4EqGzptLrF1
        3xRkgBQ2INY4zSNklmmxz0M3dWPOr+mtDFHAcuzH4d9ViTNraDINCEYRhC7QRTiG
        xpfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1693213933; x=1693300333; bh=DveWy5bJAk2Td
        vNVYiVcOl4OPq7/VIXwIVFQN7u8suY=; b=s3zMM45rssS4mcGmyqnAshX6SRNTJ
        16U0c9ohtJwLCEEoQdQ6aONu8KPF9xs2yqo+nn2wYGob0FK8qHAtvIAtyIbp+Tys
        tpKns8GN+dG7q3ElnB2+KKCckgUevEIHiZa6ugIkoKiFhtxIlDHk3BbuUV2GRynT
        oCfWc5vqmKPUynlfbjAGa26gZ+V+1G9jGotkRaBGfYCwlO4S4ADLCtLq+ilKOLQM
        M/CsnX+WMgJ2/fH7H1c2ihn0hqbuhSvglmTxVnmRhhKlWXeMxmpHh8++lEo8U6pr
        bvKBYzJL1lU1N9cJKGluVoPSloF9bN2IVy8StkonObEU8803oWgoGDcmg==
X-ME-Sender: <xms:7GTsZDVkl5lfIvNqyP2Hh4_kwgOGW6niQ_oYJDCqbzEpDQXw4khTlw>
    <xme:7GTsZLlkTwhzKfKnp-Q6Hx-Xaf7UTumcG9L8Gmg_LFNr1319wPf2oNdoQEIW525xx
    tHdjAf9hAWPSQ>
X-ME-Received: <xmr:7GTsZPZwOB7mk7uY7HdJcA2BP49ipG4MlVsVhgZqxtUBAu00g0gDj6e2j-Ry7di5uaArUXser1BNhu8kIuicNRzubBGt432-3ogSAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefgedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeehgedvvedvleejuefgtdduudfhkeeltdeihfevjeekje
    euhfdtueefhffgheekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:7GTsZOWIME-rGlyGv6cK_1QMN1e0JYJoUIVD9T-AlgwBo2PJ7usztQ>
    <xmx:7GTsZNnLB1i5sYutrfCEN8PTJwrOR0rfLdt93WGTWOHDxymgip-IpA>
    <xmx:7GTsZLddaRedPZeBurbmvWJyEzmOmF1xBsRuZTFUxjRLB-ILCiif-A>
    <xmx:7WTsZA9hPmdhX8zI8TdJ3gPj0lxBHrzrmqpiwpxvXKNIzdeXF0D22g>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Aug 2023 05:12:12 -0400 (EDT)
Date:   Mon, 28 Aug 2023 11:12:00 +0200
From:   Greg KH <greg@kroah.com>
To:     Anshul <anshulusr@gmail.com>
Cc:     richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, linux-alpha@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] alpha/boot: fixes formatting issues in `main.c`
Message-ID: <2023082835-germproof-ecosphere-5ce5@gregkh>
References: <20230828071829.64366-1-anshulusr@gmail.com>
 <20230828080703.107031-1-anshulusr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828080703.107031-1-anshulusr@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 01:36:59PM +0530, Anshul wrote:
> Fixed minor formatting issues as per `scripts/checkpatch.pl`
> 
> Six changes to the file and their severity are as follows:
> * [WARNING] Removed unnecessary braces from single statement blocks
> * [ERROR] 5 fixes are to pointer formatting
> * [ERROR] Removed a trailing whitespace
> 
> 6 errors and 1 warning of the previously present 6 errors and 5
> warnings have been fixed.
> 
> Signed-off-by: Anshul <anshulusr@gmail.com>
> ---
>  arch/alpha/boot/main.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/alpha/boot/main.c b/arch/alpha/boot/main.c
> index 22a1cb026..f609c3a83 100644
> --- a/arch/alpha/boot/main.c
> +++ b/arch/alpha/boot/main.c
> @@ -20,8 +20,9 @@
>  #include "ksize.h"
>  
>  extern unsigned long switch_to_osf_pal(unsigned long nr,
> -	struct pcb_struct * pcb_va, struct pcb_struct * pcb_pa,
> -	unsigned long *vptb);
> +				       struct pcb_struct *pcb_va,
> +				       struct pcb_struct *pcb_pa,
> +				       unsigned long *vptb);
>  struct hwrpb_struct *hwrpb = INIT_HWRPB;
>  static struct pcb_struct pcb_va[1];
>  
> @@ -42,7 +43,7 @@ find_pa(unsigned long *vptb, void *ptr)
>  	result <<= 13;
>  	result |= address & 0x1fff;
>  	return (void *) result;
> -}	
> +}
>  
>  /*
>   * This function moves into OSF/1 pal-code, and has a temporary
> @@ -62,8 +63,8 @@ void
>  pal_init(void)
>  {
>  	unsigned long i, rev;
> -	struct percpu_struct * percpu;
> -	struct pcb_struct * pcb_pa;
> +	struct percpu_struct *percpu;
> +	struct pcb_struct *pcb_pa;
>  
>  	/* Create the dummy PCB.  */
>  	pcb_va->ksp = 0;
> @@ -176,11 +177,10 @@ void start_kernel(void)
>  	}
>  
>  	nbytes = callback_getenv(ENV_BOOTED_OSFLAGS, envval, sizeof(envval));
> -	if (nbytes < 0) {
> +	if (nbytes < 0)
>  		nbytes = 0;
> -	}
>  	envval[nbytes] = '\0';
> -	strcpy((char*)ZERO_PGE, envval);
> +	strcpy((char *)ZERO_PGE, envval);
>  
>  	srm_printk(" Ok\nNow booting the kernel\n");
>  	runkernel();
> -- 
> 2.42.0


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
